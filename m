Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C79659274C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 03:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbiHOBAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 21:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiHOBA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 21:00:29 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40096147
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 18:00:27 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id k26so11177674ejx.5
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 18:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=+ugmkU0qdYiAUmyrNmDMEM1YjXxZxkx6dI7elfK4aJY=;
        b=XO9uR2FNfb6zXDmKW3ERHyogDwFZ1D2PG8BBalXOd9l8gyh9c3nmmGCQNSxXwJkrF5
         6Nn4Yu2griUe5TFvI8c/vztUe9tAe5/8EPPkc/+Ka9Fil1xeMarBLo28DgEqVdGyXr2k
         iNtvMQx+/BWGCC+kp7DWCGfyraOFVxRIlEwfZcTOG/OMWTh1KvAJBS+PQ3zQHdtlHDXY
         XO+VilXWPJe+3ez+22M7oOjdaPRm35YkNf5WxIBfh7n7iIsTJN4KNvpUfljHkuJaGKw8
         J+Ohcq8sEC4JLRCYjmCHYOM5uIdZn2m8qooOAxCi5x9DAlcwkpN6jPZSJxQi5hMb7ebM
         Lszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=+ugmkU0qdYiAUmyrNmDMEM1YjXxZxkx6dI7elfK4aJY=;
        b=3N2P6OyZ+/6W7K7Lh/4/rJoYruk57hDyuCnXBDSCVQ6Qar1SEemuIV4nhVH0m8Hcgk
         TNF0JvTp6MJuTQ5g1cq0M21LilMwy5FM66ry9tRORI7eQk7v3VdsSgoBNWkgxDvkdcCF
         DLsoU9Ff67fCoqoeLiwTS+G9WINGRAqz3JmIbOoZNxE9V5+lR55EZwIrf05HxBu6qLRW
         5qfWzgPWxK8KB5KbxGbjMqGg3ntrS+i5C4FjmqEUyGLdD1kJPOMga9gyP5z+geqK48vx
         dVWpQmIErk/un8VWt92y/a9ACStDBg12DUW8W5NAnNwtQVBC6+XguBchqDUfUmj+B5pj
         nutg==
X-Gm-Message-State: ACgBeo3+zwmyT9LXHdyNJWMhy4CCMrJpX1ZfF5J6aWf/NBDJl64x2pvq
        FsKSKankP9L9JyK3laOntEA7ZeW3Bg/Dwp30lLk=
X-Google-Smtp-Source: AA6agR6u+n4BvEUI19lUf73Whtuos+Znv/3U9PRWYeU/kBtk2EqapJtqVWsE4bZKW/f09DC41+OwopZweLcqcWIUw9o=
X-Received: by 2002:a17:907:28c9:b0:730:c053:986f with SMTP id
 en9-20020a17090728c900b00730c053986fmr8688556ejc.194.1660525226308; Sun, 14
 Aug 2022 18:00:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220812132124.2053673-1-dzm91@hust.edu.cn> <20220812134138.gpu7274yahlvr6hr@wittgenstein>
 <CAD-N9QWSwoLw9nvaQieUCPZoAYXyNTymUVOzKOTUOfC38FkXnA@mail.gmail.com> <20220812141849.nhwpvg6vte22lg2s@wittgenstein>
In-Reply-To: <20220812141849.nhwpvg6vte22lg2s@wittgenstein>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Mon, 15 Aug 2022 08:59:11 +0800
Message-ID: <CAD-N9QW5qJw5NuA3GLwUuJavKccn7DY__NVDxRbazbjnAizR-Q@mail.gmail.com>
Subject: Re: [PATCH] drivers: binderfs: fix memory leak in binderfs_fill_super
To:     Christian Brauner <brauner@kernel.org>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Kees Cook <keescook@chromium.org>,
        syzkaller <syzkaller@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2022 at 10:18 PM Christian Brauner <brauner@kernel.org> wrote:
>
> On Fri, Aug 12, 2022 at 09:48:40PM +0800, Dongliang Mu wrote:
> > On Fri, Aug 12, 2022 at 9:41 PM Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > On Fri, Aug 12, 2022 at 09:21:24PM +0800, Dongliang Mu wrote:
> > > > From: Dongliang Mu <mudongliangabcd@gmail.com>
> > > >
> > > > In binderfs_fill_super, if s_root is not successfully initialized by
> > > > d_make_root, the previous allocated s_sb_info will not be freed since
> > > > generic_shutdown_super first checks if sb->s_root and then does
> > > > put_super operation. The put_super operation calls binderfs_put_super
> > > > to deallocate s_sb_info and put ipc_ns. This will lead to memory leak
> > > > in binderfs_fill_super.
> > > >
> > > > Fix this by invoking binderfs_put_super at error sites before s_root
> > > > is successfully initialized.
> > > >
> > > > Fixes: 095cf502b31e ("binderfs: port to new mount api")
> > > > Reported-by: syzkaller <syzkaller@googlegroups.com>
> > > > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > > > ---
> > >
> > > Seems right but where's the full syzbot link to the issue?
> > > Also, wouldn't (untested) sm like the below be better?:
> >
> > I originally would like to change the order to object initialization,
> > but I am not sure if they can be exchanged since many *_fill_super are
> > ended with d_make_root.
> >
> > If you are sure about this exchange, I can resubmit a v2 patch.
>
> I think we should just always clean up the allocated memory in
> binderfs_fill_super() when d_make_root() fails and before via a goto
> block after the successful return. So we keep the cleanup in
> binderfs_fill_super() consistent and restricted to a single location.

Hi Christian,

So the final decision is to keep the cleanup or error handling code in
a single goto location at the end of binderfs_fill_super.

If I understand correctly, this change keeps the same semantic as mine
but is more elegant to maintain.
