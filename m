Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59EB94B0E49
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 14:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242063AbiBJNTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 08:19:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239009AbiBJNTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 08:19:09 -0500
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A391BB;
        Thu, 10 Feb 2022 05:19:11 -0800 (PST)
Received: by mail-ua1-f51.google.com with SMTP id 4so256593uaf.0;
        Thu, 10 Feb 2022 05:19:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RGlHeCPU57R/KCZiFIedYFp+cWh87MZTkzZO4VrO6nI=;
        b=E6xqv9HC8AQMr1EFn6kf5Rwr4ASyJewsqspnmJnQ12xMNkhjKj4hF63wArxClgoksz
         JNhuOMylbEJ1gDLvvYC1M9X54tJ2N4SkSCsCY15INsTgAlIhf3bNjc9fveIrWDVDyPX9
         Ws6vU5+jVdXTigneBuU8qbWdxdLq4Oe43EIP+O5Uz0EgDVgDZ1I4y1woi4hweh6WZmA/
         2K10BeossQ2YqacmYf+N4UNk2sCF9DrM2ROZnQ+3HwZMcdQl0V/n3/7Laoa4pomugM2L
         HVmR2PLqrZmffLdda9hZlnJ5zaiQu8Rs17wdWNQx3k6lk66R47AYk6m4vVaCYwNGV3hN
         cyCg==
X-Gm-Message-State: AOAM532ukDMeVWiQLceStL7XAPx5USVSOlbTl0aOkJZelkuQHFoYc3HQ
        HTKx88rQmzyyjzbeyvJU/2YJoteJwisgBQ==
X-Google-Smtp-Source: ABdhPJxeEaeAc1hkNAFUqoPIou82rhlPLpRItrD5x1LObC+7mkghhthxMNvnU5H9V7zkx9zJgWn3HA==
X-Received: by 2002:ab0:6851:: with SMTP id a17mr2505419uas.97.1644499150142;
        Thu, 10 Feb 2022 05:19:10 -0800 (PST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id t5sm326089vso.29.2022.02.10.05.19.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 05:19:09 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id e18so5244708vsq.10;
        Thu, 10 Feb 2022 05:19:09 -0800 (PST)
X-Received: by 2002:a67:ec0c:: with SMTP id d12mr2031817vso.77.1644499149332;
 Thu, 10 Feb 2022 05:19:09 -0800 (PST)
MIME-Version: 1.0
References: <20220130143333.552646-1-laurent@vivier.eu> <20220130143333.552646-6-laurent@vivier.eu>
In-Reply-To: <20220130143333.552646-6-laurent@vivier.eu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 10 Feb 2022 14:18:58 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW=HCyMn4N6OWLd3a5+GBP865rcdF5Yttmc_0+WzWxMfw@mail.gmail.com>
Message-ID: <CAMuHMdW=HCyMn4N6OWLd3a5+GBP865rcdF5Yttmc_0+WzWxMfw@mail.gmail.com>
Subject: Re: [PATCH v14 5/5] m68k: introduce a virtual m68k machine
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-rtc@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2022 at 3:33 PM Laurent Vivier <laurent@vivier.eu> wrote:
> This machine allows to have up to 3.2 GiB and 128 Virtio devices.
>
> It is based on android goldfish devices.
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

How to proceed?
This has a hard dependency on the goldfish patches 2-4.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
