Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636A84E36C5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 03:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235571AbiCVCm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 22:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235473AbiCVCmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 22:42:25 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BE413F53
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 19:40:58 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWUS6-00FB9i-7g; Tue, 22 Mar 2022 02:40:54 +0000
Date:   Tue, 22 Mar 2022 02:40:54 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Tejun Heo <tj@kernel.org>
Cc:     Imran Khan <imran.f.khan@oracle.com>, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v7 7/8] kernfs: Replace per-fs rwsem with hashed
 rwsems.
Message-ID: <Yjk3Nqft/U6vDvd1@zeniv-ca.linux.org.uk>
References: <20220317072612.163143-1-imran.f.khan@oracle.com>
 <20220317072612.163143-8-imran.f.khan@oracle.com>
 <YjPNOQJf/Wxa4YeV@zeniv-ca.linux.org.uk>
 <536f2392-45d2-2f43-5e9d-01ef50e33126@oracle.com>
 <YjgpaeFfFandY999@zeniv-ca.linux.org.uk>
 <Yjir/d5S3J1PTiux@slm.duckdns.org>
 <Yji8KT2K7ZKOQ+6S@zeniv-ca.linux.org.uk>
 <YjjP5ldCCGYqD+UV@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjjP5ldCCGYqD+UV@slm.duckdns.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 09:20:06AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Mon, Mar 21, 2022 at 05:55:53PM +0000, Al Viro wrote:
> > Why bother with rwsem, when we don't need anything blocking under it?
> > DEFINE_RWLOCK instead of DEFINE_SPINLOCK and don't make it static.
> 
> Oh I mean, in case the common readers get way too hot, percpu_rwsem is a
> relatively easy way to shift the burder from the readers to the writers. I
> doubt we'll need that.
> 
> > kernfs_walk_ns() - this is fucking insane; on the surface, it needs to
> > be exclusive due to the use of the same static buffer.  It uses that
> > buffer to generate a pathname, *THEN* walks over it with strsep().
> > That's an... interesting approach, for the lack of other printable
> > terms - we walk the chain of ancestors, concatenating their names
> > into a buffer and separating those names with slashes, then we walk
> > that buffer, searching for slashes...  WTF?
> 
> It takes the @parent to walk string @path from. Where does it generate the
> pathname?

Sorry, misread that thing - the reason it copies the damn thing at all is
the use of strsep().  Yecch...  Rule of the thumb regarding strsep() use,
be it in kernel or in the userland: don't.  It's almost never the right
primitive to use.

Lookups should use qstr; it has both the length and place for hash.
Switch kernfs_find_ns() to that (and lift the calculation of length
into the callers that do not have it - note that kernfs_iop_lookup()
does) and you don't need the strsep() shite (or copying) anymore.

That would allow for kernfs_walk_ns() to take kernfs_rename_lock shared.

HOWEVER, that's not the only lock needed there and this patchset is
broken in that respect - it locks the starting node, then walks the
path.  Complete with lookups in rbtrees of children in the descendents
of that node and those are *not* locked.

> > Wait a sec; what happens if e.g. kernfs_path_from_node() races with
> > __kernfs_remove()?  We do _not_ clear ->parent, but we do drop references
> > that used to pin what it used to point to, unless I'm misreading that
> > code...  Or is it somehow prevented by drain-related logics?  Seeing
> > that it seems to be possible to have kernfs_path_from_node() called from
> > an interrupt context, that could be delicate...
> 
> kernfs_remove() is akin to freeing of the node and all its descendants. The
> caller shouldn't be racing that against any other operations in the subtree.

That's interesting...  My impression had been that some of these functions
could be called from interrupt contexts (judging by the spin_lock_irqsave()
in there).  What kind of async contexts those are, and what do you use to
make sure they don't leak into overlap with kernfs_remove()?

In particular, if you ever use those from RCU callbacks, you need to make
sure that you have a grace period somewhere; the wait_event() you have in
kernfs_drain() won't do it.

I've tried to track the callchains that could lead there, but it gets
hairy fast.
