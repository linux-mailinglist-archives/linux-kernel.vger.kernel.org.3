Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30CC24E2F6D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 18:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351871AbiCUR52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 13:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351886AbiCUR50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 13:57:26 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76FC49907
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 10:55:58 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWMG1-00EuGN-5b; Mon, 21 Mar 2022 17:55:53 +0000
Date:   Mon, 21 Mar 2022 17:55:53 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Tejun Heo <tj@kernel.org>
Cc:     Imran Khan <imran.f.khan@oracle.com>, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v7 7/8] kernfs: Replace per-fs rwsem with hashed
 rwsems.
Message-ID: <Yji8KT2K7ZKOQ+6S@zeniv-ca.linux.org.uk>
References: <20220317072612.163143-1-imran.f.khan@oracle.com>
 <20220317072612.163143-8-imran.f.khan@oracle.com>
 <YjPNOQJf/Wxa4YeV@zeniv-ca.linux.org.uk>
 <536f2392-45d2-2f43-5e9d-01ef50e33126@oracle.com>
 <YjgpaeFfFandY999@zeniv-ca.linux.org.uk>
 <Yjir/d5S3J1PTiux@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yjir/d5S3J1PTiux@slm.duckdns.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 06:46:53AM -1000, Tejun Heo wrote:
> On Mon, Mar 21, 2022 at 07:29:45AM +0000, Al Viro wrote:
> ...
> > stabilizing the tree topology.  Turn it into rwlock if you wish,
> > with that thing being a reader and existing users - writers.
> > And don't bother with further scaling, until and unless you see a real
> > contention on it.
> 
> Given how rare these renames are, in the (unlikely) case the rename rwsem
> becomes a problem, we should probably just switch it to a percpu_rwsem.

Why bother with rwsem, when we don't need anything blocking under it?
DEFINE_RWLOCK instead of DEFINE_SPINLOCK and don't make it static.

Again, we already have a spinlock protecting ->parent and ->name.
Existing users:

kernfs_name() - can be shared.
kernfs_path_from_node() - can be shared.

pr_cont_kernfs_name() - exclusive, since that thing works into a static buffer.
pr_cont_kernfs_path() - exclusive, same reasons.

kernfs_get_parent() - can be shared, but its callers need to be reviewed;
that's the prime breeding ground for rename races.

kernfs_walk_ns() - this is fucking insane; on the surface, it needs to
be exclusive due to the use of the same static buffer.  It uses that
buffer to generate a pathname, *THEN* walks over it with strsep().
That's an... interesting approach, for the lack of other printable
terms - we walk the chain of ancestors, concatenating their names
into a buffer and separating those names with slashes, then we walk
that buffer, searching for slashes...  WTF?

kernfs_rename_ns() - exclusive; that's where the tree topology gets
changed.

So we can just turn that spinlock into rwlock, replace the existing
uses with read_lock()/read_unlock() in kernfs_{name,path_from_node,get_parent}
and with write_lock()/write_unlock() in the rest of fs/kernfs/dir.c,
make it non-static, put extern into kernfs-internal.h and there you
go...

Wait a sec; what happens if e.g. kernfs_path_from_node() races with
__kernfs_remove()?  We do _not_ clear ->parent, but we do drop references
that used to pin what it used to point to, unless I'm misreading that
code...  Or is it somehow prevented by drain-related logics?  Seeing
that it seems to be possible to have kernfs_path_from_node() called from
an interrupt context, that could be delicate...
