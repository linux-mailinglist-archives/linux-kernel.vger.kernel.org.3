Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0204C59279A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 03:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiHOBsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 21:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiHOBsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 21:48:38 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D991311A3D
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 18:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HGo0XIO3+DsDYVBd08+wBQXUYY81cjOh3s5tyKuX8Ew=; b=GPxc8nC8lWZ/lo/bc7cKevVkQl
        unCRB0/xk5GIPpOYjIfnmz6Zfbh5g57noCYsLPWm2IvANFU1mtGm0gjpXAH2FPZmoyrWyZoD+QB3S
        ef6Uj61oB8Kad7e8tTlwKvq/6frbQUMox+LBM7b0zgjlbroGshoM7qZ6D9AoyZxFCUMtTHYdUvNGf
        b2eT/UTIg6lp80iLJeaEB3vCW+66v53h32XRzLPkDLS9HNvhwqgnYPe7alOV7hLFHkNa3jf+63g19
        A6WeMu1jUBUn/3kfIYjYE4hZ3kWkv8PrAFWpUEspsS2DQaf8/Br7PyCK1lodSvDB4TnGE8JDszfBF
        M350Ay0g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oNPDP-004OGh-5A;
        Mon, 15 Aug 2022 01:48:27 +0000
Date:   Mon, 15 Aug 2022 02:48:27 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
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
Message-ID: <Yvml67jphhmGXUFN@ZenIV>
References: <20220812132124.2053673-1-dzm91@hust.edu.cn>
 <YvZYmprZ1NiMkynp@kroah.com>
 <CAD-N9QWU_tcnHMtP3iWcQogSWwDET4nhK5AQKDbh2KJQzwfF9A@mail.gmail.com>
 <YvZfEwFL7GSHEzs8@kroah.com>
 <20220812142423.33wnvnjg6v2h2m3y@wittgenstein>
 <YvZkfPak2UMSc1tS@kroah.com>
 <YvmlfBJTiOQVfVtX@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvmlfBJTiOQVfVtX@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 02:46:36AM +0100, Al Viro wrote:
> On Fri, Aug 12, 2022 at 04:32:28PM +0200, Greg Kroah-Hartman wrote:
> 
> > > It's a bit tricky to follow but d_make_root() always consumes the inode.
> > > On success via d_instantiate() and on failure via iput(). So when
> > > d_make_root() has been called the inode is off limits. And as soon as
> > > d_make_root() has returned successfully we're guaranteed that
> > > sb->s_fs_info is cleaned up if a ->put_super() method has been defined.
> > > Just fyi.
> > 
> > Ah, thanks, that wasn't obvious at all.
> > 
> > greg k-h
> 
> FWIW, I would rather provide a proper ->kill_sb() and gotten rid of
> all that stuff.  The thing is, unlike ->put_super(), ->kill_sb() is
> called for *anything* that has gotten to foo_fill_super().  Usually
> allows to get rid of those "call all of or parts of foo_put_super()
> on failure exits" and associated bitrot...
> 
> Like this (completely untested):

[snip the patch]

PS: that's instead of the patch upstream, not on top of it.
