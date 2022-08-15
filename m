Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7327359392D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 21:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242194AbiHOSkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 14:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242048AbiHOSjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 14:39:15 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57412E6B8;
        Mon, 15 Aug 2022 11:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Peq9JtWu1E4wR6oLY4ARrrcqindLx2FfBvAEgWzQ1g0=; b=w2tLn6ETVYP0VvljwROUi5c9Q/
        rveWi+fG4t0fVcKB8q1gaZj8w72ZcqqAKvJDoLctt58naFC32aD+X4WKR+yk4FIlBv/57aq3IMObi
        6jS7VEFtjnk4FEMuwQ8+Fjy8laYEJZy6EcLFItyiTPh5qAGwOMKYiQ6KeIQKxCsNKd2oY6u19eCRm
        pR2Hzxb627+lWtmepjuPenaVX0DcWRc5KKJNlIxPNAzsI6C9Lino+xxMTUciyHL/wKO+9SgnbZbvI
        YEg3IuCRpq7nZ2tZ9dWcU9PJPGY179wOkToWpHf9rdYl4q/9kHG57Ze0zJ4QSdhMVDEFbqJTVyy6e
        BlseRfMA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oNekh-004kXN-TZ;
        Mon, 15 Aug 2022 18:23:52 +0000
Date:   Mon, 15 Aug 2022 19:23:51 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jiacheng Xu <578001344xu@gmail.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        konishi.ryusuke@gmail.com, linux-nilfs@vger.kernel.org,
        security@kernel.org
Subject: Re: KASAN: use-after-free in nilfs_mdt_destroy
Message-ID: <YvqPN2T3Q8pfnCoV@ZenIV>
References: <CAO4S-mficMz1mQW06EuCF+o11+mRDiCpufqVfoHkcRbQbs8kVw@mail.gmail.com>
 <YvqKJppIL4lVCn9+@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvqKJppIL4lVCn9+@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 07:02:14PM +0100, Al Viro wrote:
> On Mon, Aug 15, 2022 at 10:03:21PM +0800, Jiacheng Xu wrote:
> 
> > Patch:
> > Fix this bug by moving the assignment of inode->i_private before
> > security_inode_alloc.
> > An ad-hoc patch is proposed:
> > https://patchwork.kernel.org/project/linux-fsdevel/patch/20211011030956.2459172-1-mudongliangabcd@gmail.com/
> 
> ... and that looks like utter bollocks.  Why does security_inode_alloc()
> look at ->i_private?  Which LSM is involved?

OK, I see...  The role of security_inode_alloc() here is that it's
a possible cause of failure.  And yes, dealing with that class of
bugs here might be better.

However, *IF* we go that way, why not move that thing to the
very end?  Just prior to
        this_cpu_inc(nr_inodes);

Sure, nilfs2 steps only into uninitialized ->i_private.
Who's to say that we won't run into somebody deciding that e.g.
inode->i_data.private_data is worth a look?

Just move the call of security_inode_alloc() down to immediately
before the nr_inode increment, with explanation along the lines
of

"In case of security_inode_alloc() failure the inode is passed to
->destroy_inode(); doing security_inode_alloc() last makes for
easier life for ->destroy_inode() instances - they can rely upon
the rest of inode_init_always() having been done.  It's not
just a theoretical problem - nilfs2 has actually stepped into that
[reference to report]"
