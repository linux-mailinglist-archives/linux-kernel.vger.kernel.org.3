Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF685749B8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 11:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237849AbiGNJyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 05:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiGNJyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:54:31 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1666D474D6;
        Thu, 14 Jul 2022 02:54:29 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id n12-20020a9d64cc000000b00616ebd87fc4so812529otl.7;
        Thu, 14 Jul 2022 02:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=X6mRQhVSO5biAw/mXo/QUbT/IuLAZ3fsxf8wWVobTxs=;
        b=AQnv6bm+0RwEPxeMJug4uEWaTRQiB0TwNLNvn064FDpcLOaCD7gKOtUp2lGAUZ8ovR
         8+nyQ4Wpoh8hX89wInzJ/Ngb3qpI8TFVg/00WU5gkOmP2pFKtT5xH1ON+91sMuY1YJ6A
         MBIXVvbH1piz14eP0epeaRwlmHnxnrBxhZyy+uIDP9jtcgKXXZo2f/1tkqkjWGUN2SPm
         GD8VGIP4mpyKeSXaWnh07C6PqEeaCoaZfyiDKNcvijDGN+H3PlKnVWnkeoRKJTHxUc70
         0e/h59bCxQs1fXsMnMzCtI6xlaESD7rBWwx9ppLsj17AniqJci633w87ueJIyo/nFG2V
         jRAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=X6mRQhVSO5biAw/mXo/QUbT/IuLAZ3fsxf8wWVobTxs=;
        b=ZP/agJIPxUG2WzzCTzxpnwF+ew6s/MSJSsujxxTXYQ53BC14Kp+gfRyMKet/D9jLr+
         rfiROI5TyC+uDQMKnb07qLvlSxxfXOQ02Mzwo7Cxc9C2hPI56NhLsWAol4loCRXB5mvw
         GmCCOEApHWu0dJ7hCLjqchqN4Re2zseAMcHZikJ1oRo4OxwCcNCQcTd5I7gwtZ+SSM3h
         aKPqtbpobvSlgkdxk2+SG3TWIULC3doigPsvLwOgrBW+0V9o6Zau37ktaBgyoPB+DWDS
         DPPDa1ZsuOpKh+sLQayfaYKW8LK2jJTrfOCA7sbpUqZsygd4HX5y2yqsSx5L1zt0FeoH
         w1Og==
X-Gm-Message-State: AJIora8tifyIFmMCxjIp/xpoVIeFxsaLmuKL1H27RlW/QevAFfDqf5r9
        /quwEhZJX6lMMNInZ1ylUhW6wsaqDUXunC8HLWjUIFE7WWOW/g==
X-Google-Smtp-Source: AGRyM1utmP+baueRn1lT4LhqU3E8OboEVfz6YBmgkFA8G1Zd84Uk0LA58rQYSV95jQlLMcw/nSe6HR4Z95muJowDzdI=
X-Received: by 2002:a05:6830:3686:b0:61c:4a56:5c8b with SMTP id
 bk6-20020a056830368600b0061c4a565c8bmr3111730otb.49.1657792468382; Thu, 14
 Jul 2022 02:54:28 -0700 (PDT)
MIME-Version: 1.0
References: <870c02d4d97a921f02a31fa3b229fc549af61a20.1657747763.git.bristot@kernel.org>
 <CA+icZUVbQNM+MkMCQik83FoiWF_a1v7Mb-4hZX6SZgNcp2x5SA@mail.gmail.com>
In-Reply-To: <CA+icZUVbQNM+MkMCQik83FoiWF_a1v7Mb-4hZX6SZgNcp2x5SA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 14 Jul 2022 11:53:52 +0200
Message-ID: <CA+icZUW-Mu-Cak481yrE9f6PvGcfaDN7ZPLhrtX6L7zOPU73Zg@mail.gmail.com>
Subject: Re: [PATCH V2] rtla: Fix Makefile when called from -C tools/
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
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

On Thu, Jul 14, 2022 at 11:07 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Wed, Jul 13, 2022 at 11:32 PM Daniel Bristot de Oliveira
> <bristot@kernel.org> wrote:
> >
> > Sedat Dilek reported an error on rtla Makefile when running:
> >
> >     $ make -C tools/ clean
> >     [...]
> >     make[2]: Entering directory
> >     '/home/dileks/src/linux-kernel/git/tools/tracing/rtla'
> >     [...]
> >     '/home/dileks/src/linux-kernel/git/Documentation/tools/rtla'
> >     /bin/sh: 1: test: rtla-make[2]:: unexpected operator    <------ The problem
> >     rm: cannot remove '/home/dileks/src/linux-kernel/git': Is a directory
> >     make[2]: *** [Makefile:120: clean] Error 1
> >     make[2]: Leaving directory
> >
> > This occurred because the rtla calls kernel's Makefile to get the
> > version in silence mode, e.g.,
> >
> >     $ make -sC ../../.. kernelversion
> >     5.19.0-rc4
> >
> > But the -s is being ignored when rtla's makefile is called indirectly,
> > so the output looks like this:
> >
> >     $ make -C ../../.. kernelversion
> >     make: Entering directory '/root/linux'
> >     5.19.0-rc4
> >     make: Leaving directory '/root/linux'
> >
> > Using 'grep -v make' avoids this problem, e.g.,
> >
> >     $ make -C ../../.. kernelversion | grep -v make
> >     5.19.0-rc4
> >
> > Thus, add | grep -v make.
> >
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Fixes: 8619e32825fd ("rtla: Follow kernel version")
> > Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> > Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> > Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
> > ---
>
> Thanks for v2.
> That looks good to me.
>
> Daniel, you are right that not passing -s to make-line will not show
> the grep output.
>
> Formally and again my...
>
> Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
>

Addendum:

Subject?

[PATCH V2] rtla: Fix Makefile when called from -C tools/

...called from -C tools/ clean?

 -Sedat-

>
> >  tools/tracing/rtla/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
> > index 3822f4ea5f49..1bea2d16d4c1 100644
> > --- a/tools/tracing/rtla/Makefile
> > +++ b/tools/tracing/rtla/Makefile
> > @@ -1,6 +1,6 @@
> >  NAME   :=      rtla
> >  # Follow the kernel version
> > -VERSION :=     $(shell cat VERSION 2> /dev/null || make -sC ../../.. kernelversion)
> > +VERSION :=     $(shell cat VERSION 2> /dev/null || make -sC ../../.. kernelversion | grep -v make)
> >
> >  # From libtracefs:
> >  # Makefiles suck: This macro sets a default value of $(2) for the
> > --
> > 2.32.0
> >
