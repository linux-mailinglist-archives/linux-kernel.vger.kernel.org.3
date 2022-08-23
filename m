Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE7659E4B8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 15:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241919AbiHWNxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 09:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241762AbiHWNxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 09:53:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309BC21DA4D
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 03:58:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 478696156A
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 10:57:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02678C433D6;
        Tue, 23 Aug 2022 10:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661252266;
        bh=weFxzyJoPaRaRZfw691D7CT3McdJ1+SG47mm+X0at00=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r795k7rdRZa65eIgS03Q3atNX8pVNDsiH/5c/5H0GYD9PDInibBxvK38r9knlX5eT
         0YzA1iVJHr59VEIAOp5H6i3YEx4n7Mb5AptRdRSZ233Bu09rruIn3IoSyFzaW7HzXm
         a0ND4+93RvhK9MUOWgFQyNnY7rVKzdZ8tzI1HcSlX1gdHCymEi7oy/juq7j7Sx7LDY
         N8eZ9V3ZyCinj6tELlQjWTRW06cz+sxFwNmmgrTXP8YiqC3Nq1QBCdF2IWro5019yK
         M9/Vl46ColI3me/yO5+AmcUrRJR/o4wlzuN0QPYU2ZrCVh14ScusD1tfOdNqi0v7+E
         q7F2Wdm1+bPEw==
Date:   Tue, 23 Aug 2022 12:57:36 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Todd Kjos <tkjos@android.com>, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Kees Cook <keescook@chromium.org>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH v2] binderfs: rework superblock destruction
Message-ID: <20220823105736.l2g7jnt64eki6iro@wittgenstein>
References: <20220823095339.853371-1-brauner@kernel.org>
 <YwSvxrA6efdt9Gix@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YwSvxrA6efdt9Gix@kroah.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 12:45:26PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Aug 23, 2022 at 11:53:39AM +0200, Christian Brauner wrote:
> > From: Al Viro <viro@zeniv.linux.org.uk>
> > 
> > So far we relied on
> > .put_super = binderfs_put_super()
> > to destroy info we stashed in sb->s_fs_info. This gave us the required ordering
> > between ->evict_inode() and sb->s_fs_info destruction.
> > 
> > But the current implementation of binderfs_fill_super() has a memory leak in
> > the rare circumstance that d_make_root() fails because ->put_super() is only
> > called when sb->s_root is initialized. Fix this by removing ->put_super() and
> > simply do all that work in binderfs_kill_super().
> > 
> > Reported-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> > ---
> >  drivers/android/binderfs.c | 30 +++++++++++++++++-------------
> >  1 file changed, 17 insertions(+), 13 deletions(-)
> 
> What changed from v1?

Ah, forgot to add:

/* v2 */
Christian Brauner (Microsoft) <brauner@kernel.org>:
- Call kill_litter_super() before sb->s_fs_info cleanup.
