Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A34596DC6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 13:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236338AbiHQLnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 07:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbiHQLnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 07:43:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D11F08
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 04:43:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABD5B614F6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 11:43:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D20C433C1;
        Wed, 17 Aug 2022 11:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660736590;
        bh=sFY46UNg5CyoYSYYJBPY2dZP0am3MG7vM+ocfRkA/ek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sg9qReUSN5d0V0h6icFFCOhqPV3dp/HoEqncnSLJ8oksVncPxj2Hn9D2RsC3G97Ld
         TYhZUsInfDApIy1iUiRpdsE4FjIiN9XPOXXJs+tt7zQJiCLHib2OWXrR5bafHYI7J0
         on4BBjmfrFdFKfplZptQR5wXIx9kNvGaK7VGcLwg=
Date:   Wed, 17 Aug 2022 13:43:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Kees Cook <keescook@chromium.org>,
        syzkaller <syzkaller@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers: binderfs: fix memory leak in binderfs_fill_super
Message-ID: <YvzUS/7bd1mm6c/V@kroah.com>
References: <20220812132124.2053673-1-dzm91@hust.edu.cn>
 <YvZYmprZ1NiMkynp@kroah.com>
 <CAD-N9QWU_tcnHMtP3iWcQogSWwDET4nhK5AQKDbh2KJQzwfF9A@mail.gmail.com>
 <YvZfEwFL7GSHEzs8@kroah.com>
 <20220812142423.33wnvnjg6v2h2m3y@wittgenstein>
 <YvZkfPak2UMSc1tS@kroah.com>
 <YvmlfBJTiOQVfVtX@ZenIV>
 <20220815084740.2jpqud4htermrdko@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815084740.2jpqud4htermrdko@wittgenstein>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 10:47:40AM +0200, Christian Brauner wrote:
> On Mon, Aug 15, 2022 at 02:46:36AM +0100, Al Viro wrote:
> > On Fri, Aug 12, 2022 at 04:32:28PM +0200, Greg Kroah-Hartman wrote:
> > 
> > > > It's a bit tricky to follow but d_make_root() always consumes the inode.
> > > > On success via d_instantiate() and on failure via iput(). So when
> > > > d_make_root() has been called the inode is off limits. And as soon as
> > > > d_make_root() has returned successfully we're guaranteed that
> > > > sb->s_fs_info is cleaned up if a ->put_super() method has been defined.
> > > > Just fyi.
> > > 
> > > Ah, thanks, that wasn't obvious at all.
> > > 
> > > greg k-h
> > 
> > FWIW, I would rather provide a proper ->kill_sb() and gotten rid of
> > all that stuff.  The thing is, unlike ->put_super(), ->kill_sb() is
> > called for *anything* that has gotten to foo_fill_super().  Usually
> > allows to get rid of those "call all of or parts of foo_put_super()
> > on failure exits" and associated bitrot...
> > 
> > Like this (completely untested):
> > 
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > ---
> 
> Sounds good,
> Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>

Looks much better to me too.  Can someone (Christian?) turn this into a
real patch that I can apply?

thanks,

greg k-h
