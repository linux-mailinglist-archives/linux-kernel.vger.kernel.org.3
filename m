Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9078F524D85
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 14:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353481AbiELMvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 08:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354173AbiELMvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 08:51:01 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D442FFD6;
        Thu, 12 May 2022 05:51:00 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id n8so4784701plh.1;
        Thu, 12 May 2022 05:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=27EwMlbk53oJO3mj5MrkPCMTBgjzsri0OLoJeRdN+Xk=;
        b=hwrCWIKn1lNQ5iP8cTprtxDiQdgsMreSVVUAyf+2m6lva9mk0B0WJgcFR1btdyKcAF
         r5U9AETUU9dZQ+8otEPYCoyqsMDop7ywLHzo1YvBPwEdKZ/zDp8iJr6wRl6YPfsmBdUC
         Tg25iaD2FO8Kil7UA+XBjE7bHdfOpyNwJStR2ZvBB4grxA0bRtC0/BQ69JxQlUB4ppCK
         W5tMj2DMn5bbxGq7SbLEorDVyvLZ/+ezEShhhMqAj+63M+A33wTtbcVYXaLd8X3ds+bR
         LLNM7GpiBk8YyYQYlHnQEGXpXbtTzLht72W359j/qNant5OaJfCnuZaAFpmGERFMpLPq
         p8sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=27EwMlbk53oJO3mj5MrkPCMTBgjzsri0OLoJeRdN+Xk=;
        b=3/5j2eGM5weaqer8NWU5kX1++O98vjMYTLbHkGRrQFbHEb7OK6tE6DcSucjg6w7KA+
         WacC3pWOVZqyAHjMRblYAxI75fqif/3NGNjifky+gA6TPXb7zzK2PZLokDaBsSKVfcSO
         G0fv+YTMoBDJ3PgeWMWU1YFnJYIYe1XAGekoEWsv3emBO3Ari/EAh7j+YZLb0M0nAquy
         sImJiDqmmjMD5pjdyuMK2m47uvO+MOJ0RWetBvVWlfzvHViJQOk5mg6mHIJdtYGHmGDq
         BcKdKk8jraqMDMGtbIyVIiPFqKXFnGcPMLk6uxlm/5qpPw5xcTwSmaI+VcbGdVx6F27J
         uukA==
X-Gm-Message-State: AOAM532b9A6zCTctmvx3g7//yHwUZZ5yMqoza9cwUVhRXJpsMcV29JQU
        yMBg+bxOWEWDDGMQsgCNtMGjx1hza4AbRqbGWw==
X-Google-Smtp-Source: ABdhPJxnxpgAp4wv1yi22WGwb29rdhwZR+gxdFpDHWtsY7kBvNH4oytzIcA1sPJ4IFbevGo+nmHRtWbths9+TvSAhPk=
X-Received: by 2002:a17:90a:db45:b0:1d9:29d0:4c6e with SMTP id
 u5-20020a17090adb4500b001d929d04c6emr10742419pjx.46.1652359859746; Thu, 12
 May 2022 05:50:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220512112106.2356120-1-zheyuma97@gmail.com> <CAHp75Vfz-Qq3qo3Re7tsL0mfXNVYZYspGDFCDXhtZxwac7bEiw@mail.gmail.com>
In-Reply-To: <CAHp75Vfz-Qq3qo3Re7tsL0mfXNVYZYspGDFCDXhtZxwac7bEiw@mail.gmail.com>
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Thu, 12 May 2022 20:50:48 +0800
Message-ID: <CAMhUBjkbLkA-aw4rUwFAsxZpGrOefUA515RnhXY0EjECi3hdLA@mail.gmail.com>
Subject: Re: [PATCH] gpio: ml-ioh: Add devm_free_irq() call to remove flow
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 8:03 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, May 12, 2022 at 1:21 PM Zheyu Ma <zheyuma97@gmail.com> wrote:
> >
> > When removing the module, we will get the following flaw:
>
> Thanks for the report and patch! My comments below.
>
> > [   14.204955] remove_proc_entry: removing non-empty directory 'irq/21', leaking at least 'gpio_ml_ioh'
> > [   14.205827] WARNING: CPU: 0 PID: 305 at fs/proc/generic.c:717 remove_proc_entry+0x389/0x3f0
> > [   14.209994] RIP: 0010:remove_proc_entry+0x389/0x3f0
> > [   14.217820] Call Trace:
> > [   14.218057]  <TASK>
> > [   14.218264]  unregister_irq_proc+0x14c/0x170
> > [   14.218674]  irq_free_descs+0x94/0xe0
> > [   14.219019]  mp_unmap_irq+0xb6/0x100
> > [   14.219357]  acpi_unregister_gsi_ioapic+0x27/0x40
> > [   14.219796]  acpi_pci_irq_disable+0x1d3/0x320
> > [   14.220206]  pci_disable_device+0x1ad/0x380
> > [   14.220613]  ioh_gpio_remove+0xc5/0xe0 [gpio_ml_ioh]
> > [   14.221075]  pci_device_remove+0x92/0x240
>
> Can we remove not so important lines from the above? I guess ~3-4
> selected ones would be enough.
>
> > Fix this bug by adding devm_free_irq() call to remove flow.
>
> Fixes tag?
>
> > Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
>
> The code looks okay on the first glance.
>
> P.S. Do you have such hardware?

Thanks for your comments, I've resend the patch.
Actually, I do not have the hardware. I test the driver with a virtual
device instead.

Zheyu Ma
