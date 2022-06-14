Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0163C54B8AA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 20:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237759AbiFNSbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 14:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbiFNSbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 14:31:08 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8ED48385
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 11:31:07 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id b8so12816401edj.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 11:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gU3gGBLd+11Y6cn59KJDYz57BLQD7iw6Av0QAwQuCWo=;
        b=a5oaz7JTGvcAGUojefZXM0Kk/DMpz0sYJzN2Iysi5h6LbRYjcaCHQNKAkZoiOmWMqT
         vAVKyu7+PwcDw4Qz5YJTYguDLxdPO90/3moHjpH33C/e7AhFQlgMFYzIIK5ZqiPOlnQC
         1Ry5Ag5ng3RQOipkuRCFroi/1vwsWxeDZ317Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gU3gGBLd+11Y6cn59KJDYz57BLQD7iw6Av0QAwQuCWo=;
        b=VlqiqmSSzFzcVBnD/G3fqRXqm44/M8T9cpvt1eaWRB0bK79Bzd7crMiPjg1TgN2YmH
         /kzpCeGMMrHd/IK412U9oUu+a5eJa9pnOFbOsOoF4rBhPN5LL/nn/3cBirm8/bVzjwlc
         df1tXsO58qCV3Q2sxtM1c47crkMmrZghR/1dWFGfNQgT0aSItRECL4JmZiORZkEaRLeq
         0F1I6LqWNWt+bsjtyn5hVfhvtmlN2FyLYOQm+Qw9byc+z2nDEfzBL2u0TxuRk/XBKE5T
         l0PCqTK1c01xDF87A6qnKMIDPTnpLqKtdIRQOgb4dvRR6KzMxPnNQ+T7qnGNh7glqMOS
         BRDA==
X-Gm-Message-State: AOAM5305jpgjTuxZI7Dqf3DfbdiwN11uIE1gElvOAh8AYYxUxDNLkt92
        npPdSu4SDNsp4dxELL3yPL2bv77NpJR7dhTW
X-Google-Smtp-Source: AGRyM1vwWz5t7/PCV4EIkS6kWRUww8v1U2DD+V1vSNkoW0H8xRXggian0q94OwYSCN8nUiX3h3OcmA==
X-Received: by 2002:a05:6402:b09:b0:42d:bd80:11ac with SMTP id bm9-20020a0564020b0900b0042dbd8011acmr7827655edb.244.1655231465528;
        Tue, 14 Jun 2022 11:31:05 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id q8-20020a056402518800b0042dd022787esm7663424edd.6.2022.06.14.11.31.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 11:31:04 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id l126-20020a1c2584000000b0039c1a10507fso5259815wml.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 11:31:03 -0700 (PDT)
X-Received: by 2002:a1c:5418:0:b0:39c:3552:c85e with SMTP id
 i24-20020a1c5418000000b0039c3552c85emr5627002wmb.68.1655231463454; Tue, 14
 Jun 2022 11:31:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220614144853.3693273-1-glider@google.com> <CAHk-=whaWnwB8guceg8V=bA1adv74GNaMk2FEu+YQkBKUqxVoA@mail.gmail.com>
 <CAG_fn=WEed5NJ8hdrrP_N8aQ_1Ad11VoJgdVxQheo3VfT_xyXQ@mail.gmail.com>
In-Reply-To: <CAG_fn=WEed5NJ8hdrrP_N8aQ_1Ad11VoJgdVxQheo3VfT_xyXQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Jun 2022 11:30:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=whjz3wO8zD+itoerphWem+JZz4uS3myf6u1Wd6epGRgmQ@mail.gmail.com>
Message-ID: <CAHk-=whjz3wO8zD+itoerphWem+JZz4uS3myf6u1Wd6epGRgmQ@mail.gmail.com>
Subject: Re: [PATCH] [RFC] Initialization of unused function parameters
To:     Alexander Potapenko <glider@google.com>
Cc:     Evgenii Stepanov <eugenis@google.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Buka <vitalybuka@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-toolchains <linux-toolchains@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 11:08 AM Alexander Potapenko <glider@google.com> wrote:
>
> On Tue, Jun 14, 2022 at 6:48 PM Linus Torvalds
> >
> > I'm assuming you mean pass by reference.
>
> No, sorry for being unclear. I mean passing by value.

Pass-by-value most definitely should warn about uninitialized variables.

> In the given example the prototype of step_into looks as follows (see
> https://elixir.bootlin.com/linux/latest/source/fs/namei.c#L1846):
>
>   static const char *step_into(struct nameidata *nd, int flags, struct
> dentry *dentry, struct inode *inode, unsigned seq);
>
> , and the local variables `struct inode *inode` and `unsigned seq` are
> being passed to it by value, i.e. in certain cases the struct inode
> pointer and the unsigned seq are uninitialized.

Then those cases should warn. No question about it.

I assume the only reason they don't warn right now is that the
compiler doesn't see that they are uninitialized, possibly due to some
earlier pass-by-reference use.

             Linus
