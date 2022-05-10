Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE78C520F96
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 10:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237932AbiEJIVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 04:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238054AbiEJIVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 04:21:17 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E210628D4F9;
        Tue, 10 May 2022 01:17:20 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id hf18so13039454qtb.0;
        Tue, 10 May 2022 01:17:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EKpAyevEfePe5RlmKM03pK8oMJOi8sz1FAXiHwEguLQ=;
        b=xHS49mOJyjYzn9Wc5GeuAelrtFM6v7JxQSnxU6Dh20S0WIK52nu4SjkcbB83vYIFlA
         3VjRwe44m+ThP1Hjx4TNDmbQZec/yq4cm8fKtFtX/Xe4f91DjPbmrk6kYeqw00uEEqpM
         /oF2bv6TmjYvW6HcuZi0CvEjlhx8g/oFVBXOpn6XAlnRRttpnBkMPLsWQBMY5qZDhy9G
         iq/TOPJqcWiGbArUZYeysTG9kkKZZCIOdgEDCM/JxTUOEuYtMUyQUedjlrrCFC9oBriV
         xFZVk8lvluJLH5A7c37lqrJIW3HXoPVlsG+wk5mrNCfF3c1s/Y30hQryuQv8Hfvp8mwC
         Rg6A==
X-Gm-Message-State: AOAM530fInV75P7X2tI3N5gNIvWl9roifChVZ70UJKWlxufS0hBGeAcy
        XQ40aeL9YtYZTMiBhCjjMvK/R1LtrWwDlw==
X-Google-Smtp-Source: ABdhPJxz76H3kfyioHZNI/JRMkUp+0woG6FqwsGWwmOru/I1w1cu/gIcbF/2c5K1lyuCxNzeG+qt2g==
X-Received: by 2002:aed:3148:0:b0:2ed:55a5:7a92 with SMTP id 66-20020aed3148000000b002ed55a57a92mr18970765qtg.104.1652170639818;
        Tue, 10 May 2022 01:17:19 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id r12-20020ac867cc000000b002f39b99f6b7sm8886771qtp.81.2022.05.10.01.17.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 01:17:19 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-2f16645872fso170733577b3.4;
        Tue, 10 May 2022 01:17:19 -0700 (PDT)
X-Received: by 2002:a81:2143:0:b0:2fb:1274:247e with SMTP id
 h64-20020a812143000000b002fb1274247emr18322539ywh.384.1652170639030; Tue, 10
 May 2022 01:17:19 -0700 (PDT)
MIME-Version: 1.0
References: <2b7d411b4a7913335082c858cb0d63b9e4bf7c5b.1652103920.git.geert+renesas@glider.be>
 <20fd1a74-c0f5-d8e9-4903-b74c185d5aa3@kernel.org> <CAMuHMdVXHSnOOnn3jchezQc+bsPYTnSPuw_rOe+pyskAVaQGnQ@mail.gmail.com>
 <22ed864d-8d71-7042-4d55-2b0b65d4d281@kernel.org> <CAMuHMdVFHeJvXAfb-Q1WGvDEuKTeVx-3fmmPu18Ci2yoNinMuA@mail.gmail.com>
 <5cec89ab-76f7-65d5-0b1d-fdd768234f0e@kernel.org>
In-Reply-To: <5cec89ab-76f7-65d5-0b1d-fdd768234f0e@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 10 May 2022 10:17:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW6VH-N7gx+YtccexE7jprvigJDstu_00FJXtH3d45Wdg@mail.gmail.com>
Message-ID: <CAMuHMdW6VH-N7gx+YtccexE7jprvigJDstu_00FJXtH3d45Wdg@mail.gmail.com>
Subject: Re: [PATCH] memory: OMAP_GPMC should depend on ARCH_OMAP2PLUS || ARCH_K3
To:     Roger Quadros <rogerq@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        "open list:TI ETHERNET SWITCH DRIVER (CPSW)" 
        <linux-omap@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roger,

On Tue, May 10, 2022 at 10:10 AM Roger Quadros <rogerq@kernel.org> wrote:
> On 10/05/2022 11:06, Geert Uytterhoeven wrote:
> > On Tue, May 10, 2022 at 9:40 AM Roger Quadros <rogerq@kernel.org> wrote:
> >> On 10/05/2022 10:30, Geert Uytterhoeven wrote:
> >>> On Tue, May 10, 2022 at 9:22 AM Roger Quadros <rogerq@kernel.org> wrote:
> >>>> On 09/05/2022 16:48, Geert Uytterhoeven wrote:
> >>>>> The Texas Instruments OMAP General Purpose Memory Controller (GPMC) is
> >>>>> only present on TI OMAP2/3/4/5, AM33xx, AM43x, DRA7xx, TI81xx, and K3
> >>>>> SoCs.  Hence add a dependency on ARCH_OMAP2PLUS || ARCH_K3, to prevent
> >>>>> asking the user about this driver when configuring a kernel without
> >>>>> OMAP2+ or K3 SoC family support.
> >>>>>
> >>>>> Fixes: be34f45f0d4aa91c ("memory: omap-gpmc: Make OMAP_GPMC config visible and selectable")
> >>>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> >> Could you please also add ARCH_KEYSTONE in the 'depends on' list
> >> as some SoCs in that architecture do have the GPMC block.
> >
> > Are you sure? AFAICS, none of the Keystone DTS files have device
> > nodes that are compatible with the match list in the omap-gpmc driver.
>
> Yes, the 66AK2G12 SoC contains the GPMC module. [1]
>
> > Or perhaps the GPMC support still has to be added to the Keystone
> > DTS files (and or driver)?
>
> That's most likely the case.

So would it make sense to compile the omap-gpmc driver on keystone
yet, or does that need the introduction of e.g. a ti,k2g-gpmc compatible
value first, and thus should it be postponed?

> [1] 66AK2G12 datasheet: https://www.ti.com/lit/ds/symlink/66ak2g12.pdf?ts=1652170122865&ref_url=https%253A%252F%252Fwww.ti.com%252Fproduct%252F66AK2G12

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
