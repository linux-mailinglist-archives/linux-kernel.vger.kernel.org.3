Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8758859082C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 23:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235456AbiHKVi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 17:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbiHKViZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 17:38:25 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBF59F19C;
        Thu, 11 Aug 2022 14:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PP9YDeHip3JLgIFd/30i9RiuExqZxhJ75I9LntNprD0=; b=CciMJdAHkb4L29AeV9z4VvWNbz
        fu8e9dbzuSbAiDZhkCRiDNnc74Kk3qDDwqQ83/JFGD/gZzEqES68yUr7KjnYddcEXEyhGGasAC2JO
        JBGAWQuXO3M58GrcaesbPFBfNDQB187p7wRJ+g5yRN5VZ2A/6OBfXvs3T0s4ft5THjfKFb+DUAWn4
        +WxU9a5JbAJX+KEjOZid6rk97Atv5VWbe4j5uY1hqulry8VZqo6JZ9Shyl+SZjbfQINrLrvpiPYNw
        SlzDsRj9YMIwIM6M9EeC1HAqsXqvT7RzGyy6+WNlHf04ZYWCwUGUq9etKNlq/RoIuN0IUs8NTlcTI
        CsxgsMVg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oMFsj-003Z1H-4O;
        Thu, 11 Aug 2022 21:38:21 +0000
Date:   Thu, 11 Aug 2022 22:38:21 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Ilya Dryomov <idryomov@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [GIT PULL] Ceph updates for 5.20-rc1
Message-ID: <YvV2zfT0XbgwHGe/@ZenIV>
References: <20220811152446.281723-1-idryomov@gmail.com>
 <CAHk-=wifgq59uru6xDB=nY-1p6aQ-1YB8nVhW7T-N2ctK3m1gw@mail.gmail.com>
 <CAOi1vP9BSi-65of-8D0BA1_DC0eVD_TQcWkhrGJwaXw_skhHFQ@mail.gmail.com>
 <5d0b0367a5e28ec5b1f3b995c7792ff9a5cbcbd4.camel@kernel.org>
 <YvVzHQ5DVaPAvw26@ZenIV>
 <72a93a2c8910c3615bba7c093c66c18b1a6a2696.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72a93a2c8910c3615bba7c093c66c18b1a6a2696.camel@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 05:30:03PM -0400, Jeff Layton wrote:
> On Thu, 2022-08-11 at 22:22 +0100, Al Viro wrote:
> > On Thu, Aug 11, 2022 at 05:08:11PM -0400, Jeff Layton wrote:
> > 
> > > Actually, I never got a formal ack from Al. I did send it repeatedly,
> > > but I assume he has been too busy to respond. We've had it sitting in
> > > linux-next for a couple of months, and he did suggest that approach in
> > > the first place, but I too would also prefer to see his official ack on
> > > it.
> > 
> > "Suggested approach" had been about inode_insert5() changes, right?
> 
> Right. I was talking about this patch (which I think is sane):
> 
>     fs: change test in inode_insert5 for adding to the sb list

It is, AFAICS.

> > But that's fs/inode.c side of things...  I have to admit that I'd missed
> > the unlining d_same_name() - exporting the sucker per se didn't look
> > insane and I hadn't looked at that in details ;-/
> > 
> > Looking at it now...  might be worth renaming it into __d_same_name(),
> > leaving it inlined and exporting a wrapper; not sure if the impact on
> > d_lookup()/__d_lookup()/d_alloc_parallel() is worth worrying about it,
> > though.
> > 
> > Profiling a case when we have a plenty of files in the same directory
> > on tmpfs, with something earlier in the pathname to kick out of RCU
> > mode (e.g. going through /proc/self/cwd) might be interesting...
> 
> The d_name_name changes seemed ok to me, but it would be good to have
> your ack (or qualified NAK) if possible.

Exporting the functionality?  Sure, no problem.  Uninlining that one...
I suspect that it's OK, but I'd like to see profiling data; it's not
as if it would be hard to return to having it inlined, obviously.

Again, my apologies for not spotting that one.
