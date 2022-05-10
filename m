Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6F7520F70
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 10:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237816AbiEJIMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 04:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237864AbiEJIK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 04:10:58 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB41D249887;
        Tue, 10 May 2022 01:06:55 -0700 (PDT)
Received: by mail-qk1-f178.google.com with SMTP id c1so12653151qkf.13;
        Tue, 10 May 2022 01:06:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hrwbYVMfyZKLGnIKNlCKVv1V4tt6GbLeMklP2rm/UpI=;
        b=AIIBiz8JIbGH3wqpbmLY7XDGxWc1SqAQjR9yr4t4biow36QLK4mlREUTIgv6BjeOkA
         FRaxl0/POIYsFS5yjVIexPOXnC9J1v0HufivUS0HP+wCgE3TWybjMECOXgPTKzpVf2U1
         XYdjHJV7qTieJBmbhN3O1QaLwhEksN/ld3admgYb8uqd3z0gj0CKqi+LcSDDSgzamZ/G
         /jtraUwroTcZlzAP4749Hf6DxMF6P6bH4IgnX/5zeFRNMHQ463HTPbIPuVHooFmz/Ih8
         fr5EaWwPmcs8HSN0+vW9e0QgizV/WFNDeTaMR3UUksR+JXJ199hqO8xYBfiDzTXAZ/RE
         /WdQ==
X-Gm-Message-State: AOAM533d2oFlXLoS88SlxUKZCpuggGf+LiF7sN/BCS6hatc1j4lgJyIE
        ZGqjU7fEaZyPxyaMbPtuNRwZphYyY9U2rw==
X-Google-Smtp-Source: ABdhPJwJ3QMqzoGF9MAZVYiv3WWBcfzCUMMBdpPiK/nuc3ZWk95NUngNO6kSTuualJOYf2aq593OPQ==
X-Received: by 2002:a05:620a:4150:b0:6a0:81cc:7e78 with SMTP id k16-20020a05620a415000b006a081cc7e78mr6851089qko.98.1652170014518;
        Tue, 10 May 2022 01:06:54 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id q71-20020a37a74a000000b0069fcc501851sm8175683qke.78.2022.05.10.01.06.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 01:06:54 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-2ec42eae76bso170522147b3.10;
        Tue, 10 May 2022 01:06:53 -0700 (PDT)
X-Received: by 2002:a81:234b:0:b0:2f8:4082:bbd3 with SMTP id
 j72-20020a81234b000000b002f84082bbd3mr18054436ywj.47.1652170013606; Tue, 10
 May 2022 01:06:53 -0700 (PDT)
MIME-Version: 1.0
References: <2b7d411b4a7913335082c858cb0d63b9e4bf7c5b.1652103920.git.geert+renesas@glider.be>
 <20fd1a74-c0f5-d8e9-4903-b74c185d5aa3@kernel.org> <CAMuHMdVXHSnOOnn3jchezQc+bsPYTnSPuw_rOe+pyskAVaQGnQ@mail.gmail.com>
 <22ed864d-8d71-7042-4d55-2b0b65d4d281@kernel.org>
In-Reply-To: <22ed864d-8d71-7042-4d55-2b0b65d4d281@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 10 May 2022 10:06:42 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVFHeJvXAfb-Q1WGvDEuKTeVx-3fmmPu18Ci2yoNinMuA@mail.gmail.com>
Message-ID: <CAMuHMdVFHeJvXAfb-Q1WGvDEuKTeVx-3fmmPu18Ci2yoNinMuA@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roger,

On Tue, May 10, 2022 at 9:40 AM Roger Quadros <rogerq@kernel.org> wrote:
> On 10/05/2022 10:30, Geert Uytterhoeven wrote:
> > On Tue, May 10, 2022 at 9:22 AM Roger Quadros <rogerq@kernel.org> wrote:
> >> On 09/05/2022 16:48, Geert Uytterhoeven wrote:
> >>> The Texas Instruments OMAP General Purpose Memory Controller (GPMC) is
> >>> only present on TI OMAP2/3/4/5, AM33xx, AM43x, DRA7xx, TI81xx, and K3
> >>> SoCs.  Hence add a dependency on ARCH_OMAP2PLUS || ARCH_K3, to prevent
> >>> asking the user about this driver when configuring a kernel without
> >>> OMAP2+ or K3 SoC family support.
> >>>
> >>> Fixes: be34f45f0d4aa91c ("memory: omap-gpmc: Make OMAP_GPMC config visible and selectable")
> >>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> Could you please also add ARCH_KEYSTONE in the 'depends on' list
> as some SoCs in that architecture do have the GPMC block.

Are you sure? AFAICS, none of the Keystone DTS files have device
nodes that are compatible with the match list in the omap-gpmc driver.

Or perhaps the GPMC support still has to be added to the Keystone
DTS files (and or driver)?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
