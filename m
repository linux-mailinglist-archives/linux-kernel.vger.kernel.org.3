Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE06B59E495
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 15:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241388AbiHWNma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 09:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241252AbiHWNmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 09:42:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8786E171FB1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 03:46:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03BF26151E
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 10:45:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D3AC433C1;
        Tue, 23 Aug 2022 10:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661251529;
        bh=WTOXHVgyyQjMUt941kPahRztf3QGl+pFnO2JvMlKtNk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VJc9M1AidWuN5injMt3nhYTx7JswGArYsG27kWO4dMJSuLqhoxweFb9+R8trpJ4BL
         Hh0PQzAeguFfu7wccseOKUnmVNFHLgDy6LikhTlIR86QFSnD9tpx8G8XXntjdGiGbu
         /ME+gbRKztbisTVQg8k6pyYk2u4IdvZuSFRy7Wcg=
Date:   Tue, 23 Aug 2022 12:45:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Todd Kjos <tkjos@android.com>, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Kees Cook <keescook@chromium.org>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH v2] binderfs: rework superblock destruction
Message-ID: <YwSvxrA6efdt9Gix@kroah.com>
References: <20220823095339.853371-1-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823095339.853371-1-brauner@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 11:53:39AM +0200, Christian Brauner wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> So far we relied on
> .put_super = binderfs_put_super()
> to destroy info we stashed in sb->s_fs_info. This gave us the required ordering
> between ->evict_inode() and sb->s_fs_info destruction.
> 
> But the current implementation of binderfs_fill_super() has a memory leak in
> the rare circumstance that d_make_root() fails because ->put_super() is only
> called when sb->s_root is initialized. Fix this by removing ->put_super() and
> simply do all that work in binderfs_kill_super().
> 
> Reported-by: Dongliang Mu <mudongliangabcd@gmail.com>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> ---
>  drivers/android/binderfs.c | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)

What changed from v1?

