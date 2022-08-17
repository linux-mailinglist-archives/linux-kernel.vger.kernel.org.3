Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0045970F4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 16:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239451AbiHQOTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 10:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbiHQOTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 10:19:25 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686525F13A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=q8FAIhejhKLXHNyU1DAEWDypIdvH51+2VKRpRPG41YU=; b=FRlzoxQsY8UAFGMxbVZFWpqyrc
        S2d3kFgCBVkHyYRZP3+m4GwkLZ4djc0bEcbDi0IwCHvNrT5Ud9oplCVOiwQFCCccyDGMt7CjJ6I81
        KLzEhyFlmAJ0YI8VFLWm/Ztiqe9qRFqFuFISstDW5XtdKSWsUhH4ZLqRkjUo3Nl+zEHIOluG9JIPX
        vF7iseDZOGsqEIXRgH1+m3P8cCmEyRRyVM3aAcS4C7aarsLu/hPnhDq9UBbPxCn7pSXUY7+UEw3HQ
        vVaaFnHxoAL2P8b4Dq0ZbHezGcOYFnYri2WNEU5YW+81RAgOfjYaFKUpLhmC8ncKITSeKgp6x+z8J
        tQ/n9/DA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oOJt3-005Nzj-Bw;
        Wed, 17 Aug 2022 14:19:13 +0000
Date:   Wed, 17 Aug 2022 15:19:13 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Subject: Re: [PATCH] binderfs: rework superblock destruction
Message-ID: <Yvz44WHBh94IvJt/@ZenIV>
References: <YvzUS/7bd1mm6c/V@kroah.com>
 <20220817130306.96978-1-brauner@kernel.org>
 <Yvz0JkdxXwY8uDyT@ZenIV>
 <20220817140149.pfakskeyxkqcot54@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817140149.pfakskeyxkqcot54@wittgenstein>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 04:01:49PM +0200, Christian Brauner wrote:
> On Wed, Aug 17, 2022 at 02:59:02PM +0100, Al Viro wrote:
> > On Wed, Aug 17, 2022 at 03:03:06PM +0200, Christian Brauner wrote:
> > 
> > > +static void binderfs_kill_super(struct super_block *sb)
> > > +{
> > > +	struct binderfs_info *info = sb->s_fs_info;
> > > +
> > > +	if (info && info->ipc_ns)
> > > +		put_ipc_ns(info->ipc_ns);
> > > +
> > > +	kfree(info);
> > > +	kill_litter_super(sb);
> > > +}
> > 
> > Other way round, please - shut the superblock down, *then*
> > free the objects it'd been using.  IOW,
> 
> I wondered about that but a lot of places do it the other way around.
> So maybe the expected order should be documented somewhere.

???

"If you are holding internal references to dentries/inodes/etc., drop them
first; if you are going to free something that is used by filesystem
methods, don't do that before the filesystem is shut down"

That's just common sense...  Which filesystems are doing that "the other
way around"?
