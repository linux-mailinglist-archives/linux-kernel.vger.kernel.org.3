Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7225509127
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 22:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381958AbiDTUOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 16:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351344AbiDTUOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 16:14:37 -0400
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B1A4615B;
        Wed, 20 Apr 2022 13:11:49 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id r18so3271117ljp.0;
        Wed, 20 Apr 2022 13:11:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kituK6OBdqTi+kxAeHHv4yFs1BiJnSRSgcn1u3Ell74=;
        b=iiBTwI/x1GL+h0uosviF8NDkpNvDIKwbQie12nqQrfFob9vxSGJzNHzl5YJPCpif4U
         dTamnNBzcBFi9MQKZ+DCzrBc904Dmw80scj2s2rr5pQ8ruwuOgnWesEgtbH2FUVSPnTO
         5wcvIljHDLeU2EL7nmqffRp2wyhaKSDpCBUof3qqWYxcakoXttCQAjfwO4Ali58vckyd
         HAbyaHzQGnNJZQSGNhlRAp5I9aYHNoqSH8vRKOQGw1yflzI77+3xUm4kqdX3iPeovKhF
         grC6ch6eT93zFGfEVCILGIra51bVqeALCnZpB+vKU17YjeSCR9o+Fr/YhB0tG5ixqTP9
         BvIg==
X-Gm-Message-State: AOAM531ZYrJNKUBNArre6MjJynQczBj/t7uE5q869GE93hRYdDplL9Y2
        O0lkJSW+SsmhvQ2f9mPRmIVHWwY6eylzZKpfgLY=
X-Google-Smtp-Source: ABdhPJybRBIjDP+5BAIib8bSg9t516qHkD6xvIc7IexyqYv45hzQlZwIieiIhem1fSD/qEfR01uOTg==
X-Received: by 2002:a2e:9ecb:0:b0:24b:4e2a:a555 with SMTP id h11-20020a2e9ecb000000b0024b4e2aa555mr14496285ljk.149.1650485506839;
        Wed, 20 Apr 2022 13:11:46 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id k10-20020a19560a000000b0046d1707fcbdsm1927162lfb.215.2022.04.20.13.11.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 13:11:43 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id b21so4963738lfb.5;
        Wed, 20 Apr 2022 13:11:39 -0700 (PDT)
X-Received: by 2002:a05:6512:b0e:b0:44a:a5a0:f60e with SMTP id
 w14-20020a0565120b0e00b0044aa5a0f60emr15727328lfu.669.1650485498400; Wed, 20
 Apr 2022 13:11:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220330154024.112270-1-phil.edworthy@renesas.com>
In-Reply-To: <20220330154024.112270-1-phil.edworthy@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 20 Apr 2022 22:11:24 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVV=PBfboHUk-wi1coAy7rcpDngKGSTqDWh-5vnSc91pg@mail.gmail.com>
Message-ID: <CAMuHMdVV=PBfboHUk-wi1coAy7rcpDngKGSTqDWh-5vnSc91pg@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] Add new Renesas RZ/V2M SoC and Renesas RZ/V2M
 EVK support
To:     Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phil,

On Wed, Mar 30, 2022 at 5:40 PM Phil Edworthy <phil.edworthy@renesas.com> wrote:
> RZ/V2M has a dual-core Cortex-A53 (1.0 GHz) CPU and built-in AI
> accelerator "DRP-AI" for vision, which is Renesas' original technology.
> It also has a 32-bit LPDDR4 interface and video codec (H.264).
>
> The RZ/V2M is used with ISP firmware that runs on one of the Cortex-A53
> cores. The firmware is an integral part of the SoC such that the HW
> User's Manual documents which of the peripheral modules are used by the
> firmware.
>
> Initial patches enables minimal peripherals on Renesas RZ/V2M EVK board
> and booted via nfs. Ethernet is broadly compatible with the
> etheravb-rcar-gen3 driver, but interrupts need some work so it's not
> been included in this patch set.
>
> Below blocks are enabled on Renesas RZ/V2M EVK board:
> - memory
> - External input clock
> - CPG
> - UART

Thanks for your series!

> v2:
>  * Removed SYS dt-bindings patch and corresponding SoC identification
>    as we only used the LSI version register. This can be dealt with
>    later on.

That patch[1] also introduced the ARCH_R9A09G011 config symbol,
without which none of the new code in this series is built.

[1] [PATCH 07/14] soc: renesas: Identify RZ/V2M SoC
    https://lore.kernel.org/all/20220321154232.56315-8-phil.edworthy@renesas.com/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
