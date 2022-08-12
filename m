Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9239D5911C2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 15:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238426AbiHLN5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 09:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiHLN51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 09:57:27 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51119925D
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 06:57:26 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id k26so2175942ejx.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 06:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=UqdfMBk3FFh1oCjqYXyPvd30eogbRofxBEUHJL5KgK0=;
        b=UIOZDYkytCcVwuVC8i6ZqFPz3l3zhM5EVr/20mUsnh5cx2mTXPpvRc2c9jbYUYLQZc
         AfvSHtrRT4r02XTsO7bSI2mD76VkFeItd+jLH9Z5Bu9CiTgdy1XBIPsmF5BDjZ/LU0lu
         7Ig+56xv16be3+gJepLICuA9ONSyc0ohcRaAhACdwfjuzDt2GWJPa9bBqShHOasgyIOR
         MI8kMIu+bqS1lpN0XYYe9ibALCmU3r5EPNRUZPTygDHk+oJN/qr+XvbL9W+LPfbWRZ2T
         HJENOPnMWurAw0bnBfgCFi/0BUcytm/DBBK8oXE2CbTbLqfzYDt0PL8uRon/+hsmMtOF
         Aiyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=UqdfMBk3FFh1oCjqYXyPvd30eogbRofxBEUHJL5KgK0=;
        b=2ZAox4hFKbWLpajot7u8GIAeSWDOqh3xSHltzkgJjR7ZagwaFWCkLa+jV0fuPEsAdK
         XlTdcEAK3Lw8+BXFVTj1uvs8pZN0I7nfxTeX3Tix85z9DaqpJ07hhGQu3GmD95TnpDpA
         MQH1/hTo1iq0pWLDAIbBNoOE7gGGrZ8oWcuCA2BM7rfFymhQBXiO08zWIGNu9zsM4fVE
         SRTuPLCF2l5ICn7lrcxKd515wo3Nl+lWaUYRTIksNPgAl0FeamqsO24lqz6VjfW50WMk
         D2jHnVvyhB1DGvfDLuZpioD6ujFv7lbIamYNQiFTdxj4EYyTfcX1IAf2tGNj21Lok0q6
         jR3w==
X-Gm-Message-State: ACgBeo0BzRPFMb8rxtI9B0mP+psDg7peSMGC8WhrMA7Bdg8Zhn2PCp4Y
        yUH0BBqPmQUSu0iMJJ0NLKaxKgGYBVRh3uiksXI=
X-Google-Smtp-Source: AA6agR5b6JHS11XaB1VLJdcr0UpOBC3SruahBqfEW7BjMgwF9FOhR6nIAQ4vdwbn4/nulbrITJlNjfSVctyZMKCpMUQ=
X-Received: by 2002:a17:907:d9e:b0:731:1a5:8c68 with SMTP id
 go30-20020a1709070d9e00b0073101a58c68mr2816133ejc.365.1660312645159; Fri, 12
 Aug 2022 06:57:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220812132124.2053673-1-dzm91@hust.edu.cn> <YvZYmprZ1NiMkynp@kroah.com>
In-Reply-To: <YvZYmprZ1NiMkynp@kroah.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Fri, 12 Aug 2022 21:56:46 +0800
Message-ID: <CAD-N9QWU_tcnHMtP3iWcQogSWwDET4nhK5AQKDbh2KJQzwfF9A@mail.gmail.com>
Subject: Re: [PATCH] drivers: binderfs: fix memory leak in binderfs_fill_super
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
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

On Fri, Aug 12, 2022 at 9:41 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Aug 12, 2022 at 09:21:24PM +0800, Dongliang Mu wrote:
> > From: Dongliang Mu <mudongliangabcd@gmail.com>
> >
> > In binderfs_fill_super, if s_root is not successfully initialized by
> > d_make_root, the previous allocated s_sb_info will not be freed since
> > generic_shutdown_super first checks if sb->s_root and then does
> > put_super operation. The put_super operation calls binderfs_put_super
> > to deallocate s_sb_info and put ipc_ns. This will lead to memory leak
> > in binderfs_fill_super.
> >
> > Fix this by invoking binderfs_put_super at error sites before s_root
> > is successfully initialized.
> >
> > Fixes: 095cf502b31e ("binderfs: port to new mount api")
> > Reported-by: syzkaller <syzkaller@googlegroups.com>
>
> Where is the specific syzkaller link for this report?  It would be good
> to reference it so it can be properly checked.
>
> Also, how did you test this change?

I found this memory leak in my local syzkaller, and there is no any
syzbot report about this crash, therefore I use such a Reported-by to
indicate.

Although my local syzkaller does generate any reproducer, this bug can
be triggered by injecting faults at new_inode and d_make_root (i.e.,
between s_sb_info allocation and code after d_make_root).

>
> > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > ---
> >  drivers/android/binderfs.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> > index 588d753a7a19..20f5bc77495f 100644
> > --- a/drivers/android/binderfs.c
> > +++ b/drivers/android/binderfs.c
> > @@ -710,8 +710,10 @@ static int binderfs_fill_super(struct super_block *sb, struct fs_context *fc)
> >       info->mount_opts.stats_mode = ctx->stats_mode;
> >
> >       inode = new_inode(sb);
> > -     if (!inode)
> > +     if (!inode) {
> > +             binderfs_put_super(sb);
> >               return -ENOMEM;
> > +     }
> >
> >       inode->i_ino = FIRST_INODE;
> >       inode->i_fop = &simple_dir_operations;
> > @@ -721,8 +723,10 @@ static int binderfs_fill_super(struct super_block *sb, struct fs_context *fc)
> >       set_nlink(inode, 2);
> >
> >       sb->s_root = d_make_root(inode);
> > -     if (!sb->s_root)
> > +     if (!sb->s_root) {
> > +             binderfs_put_super(sb);
> >               return -ENOMEM;
> > +     }
>
> How did you test this change to verify that you are not now just leaking
> memory?  It looks to me like you just changed one problem for another
> one :(

As mentioned above, I just tested my change by injecting faults at
new_inode and d_make_root.

Can you explain more about "changed one problem for another one"? I
don't quite understand this statement.

>
> Please always be very very careful when making these types of changes,
> and verify and test that they are correct.
>
> thanks,
>
> greg k-h
