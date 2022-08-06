Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3216758B525
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 13:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbiHFLNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 07:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiHFLNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 07:13:04 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599EE11802;
        Sat,  6 Aug 2022 04:13:03 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id o3so2206691qkk.5;
        Sat, 06 Aug 2022 04:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=I3uXfOIh0HQkXTbkdEdipML9h3bJHEvJCiPVtZoJAxE=;
        b=bMf5AdAUe63EHMZe1gF1GIKSeeV1hL+NGemf4kNorRiMZPJA4EuWlFEPg9AqfPrcKF
         fjCN0X+ObNCek24R4wD9uGBdoffu/vatpfBOscBwY09OkXmmNXJ52rSBd26a/zut9wv+
         jZSs4DynzWiynB/SyroaEb9IlLyAtpx5YzTrgq7GlAHRZY7sFEXbwFOj61EfTwv784Az
         m93LJvQxCG9aPvkczjdA4TfBp5iNTlOZq6Lnw4vzWSIKm841MjP+cq9diruYevNYDWdz
         DKNMGS3ldJ6UPhMcgbYC945jLYDxGHGeS1iRBszg1MjMw1FaRT+hfcQw6zOXFdv/WUJy
         FGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=I3uXfOIh0HQkXTbkdEdipML9h3bJHEvJCiPVtZoJAxE=;
        b=Ph073nU+uFjtAGa1nYxJS1MKoDhn16ozyUfwwVvKim5FYn0eyEnQAADIoPpd0mcFm1
         T1reBsdKEeWtoMM1CpvCEEouONNbn9bwUwW529gXiKDJK3AunTOhlvAxHOjstSmtEmyC
         Tkm1FCz2x4ZBARWnmy3DUbnZ1Fh2MSjTF0Bu7Z2Da8jfvP5seIM760d0alZachFVLM2j
         HRjyFcgh+tkS5V/GpF9b+xbldj6ZC4pFs2y34Du+L6S8027DuLJAwa7ZUlMbnsNppT2u
         mKFKpZB2UTicpN4UlGswjRMLJht3wEfGLTZxy1+OizK3i8cu+I83ORGtzNBOHBYyEj+b
         Xlgw==
X-Gm-Message-State: ACgBeo2EXh4HQRHWSvEBAtIRZdyJyHJfgJUdtqJBI4u6vg07iWeIe1hg
        t66ZH4dNp3PGF6Jpo/MF3ofZpucGCCxU1Lz71r+F1+uQ33I=
X-Google-Smtp-Source: AA6agR7olyhmAx1+dblpo8eUiDEKiuS50WdSCti376/m2Osg2u+f8ZpqR24PO4mWNVixEPUcJLqC/vMeXec/k8WnJgw=
X-Received: by 2002:a05:620a:8018:b0:6b6:5df:977 with SMTP id
 ee24-20020a05620a801800b006b605df0977mr7992311qkb.320.1659784382338; Sat, 06
 Aug 2022 04:13:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220805081909.10962-1-luke@ljones.dev> <20220805081909.10962-3-luke@ljones.dev>
 <CAHp75VcYba6wYwkMo_Q_QEZsr4wyfDB5czu13w-y6hfQ13CkvQ@mail.gmail.com> <90W6GR.9Z5CYBT7NOHJ1@ljones.dev>
In-Reply-To: <90W6GR.9Z5CYBT7NOHJ1@ljones.dev>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 6 Aug 2022 13:12:25 +0200
Message-ID: <CAHp75VfABOpx1TLhF2wYapNm8h5Yhu0eRqtdaYpRK9MN5hfo2g@mail.gmail.com>
Subject: Re: [PATCH 2/5] asus-wmi: Add support for TUF laptop keyboard RGB
 mode control
To:     Luke Jones <luke@ljones.dev>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Sat, Aug 6, 2022 at 12:34 PM Luke Jones <luke@ljones.dev> wrote:
> On Sat, Aug 6 2022 at 11:56:58 +0200, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Fri, Aug 5, 2022 at 10:20 AM Luke D. Jones <luke@ljones.dev> wrote:

...

> >>  +       if (sscanf(buf, "%hhd %hhd %hhd", &save, &mode, &speed) !=
> >> 3)
> >>  +               return -EINVAL;
> >
> > Usually we have three separate nodes for that, but they are kinda
> > hidden in one driver, so I don't care much.
>
> I don't really understand what you mean sorry.

Each value is in a separate sysfs "file" (we call it "sysfs node"),
but it seems Pavel proposed a better solution so LED framework has
something to offer you.

...

> >>  +       /* These are the known usable modes across all TUF/ROG */
> >>  +       asus->keyboard_rgb_mode.mode = mode < 12 && mode != 9 ?
> >> mode : 0x0a;

This also can be improved

  if (mode >= 12 || mode == 9)
    ...mode = 10;
  else
    ...mode = mode;

Or, if it's important, switch all above to be hexadecimal constants.

...

> >>  +       err = tuf_rgb_brightness_set(cdev, cdev->brightness);
> >>  +       if (err)
> >>  +               return err;
> >>  +       return 0;
> >
> > return tuf_rgb_brightness_set(...);
>
> This causes a hang (waiting for return somewhere?) if I don't return
> count. Especially true if the return is 0.

I didn't get this, because what I suggested is an equivalent to the
above 4 lines.

-- 
With Best Regards,
Andy Shevchenko
