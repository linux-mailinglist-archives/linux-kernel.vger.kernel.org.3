Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D495645D5
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 10:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbiGCIeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 04:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbiGCIeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 04:34:00 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634E0A19C;
        Sun,  3 Jul 2022 01:33:59 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id c13so5826700qtq.10;
        Sun, 03 Jul 2022 01:33:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VSHHOsfszPZ4Xzy/z0YVRPTZZp58PE4uq16iJ2kH/Zw=;
        b=laHYtF1iMlaHEGOh0zdnxltdd+R6zg/T2pMEpYdD4c9ozap73N4HRzbMFr8vJr5PLk
         7MiP/SOeHKR36hKX4b6Y4hc/GB8eTsIWqL12vs9Vcf260/nqXlXzNwohkWkehKcPalna
         FVDEYl6eD3fmD214Vr9w6MxH5ZN3T0+VjvcLoSWFgqD0wsw/cQ6CYF89/uNyxl3gkUDY
         uA7u/cUbF6WYBLWVmjah+GytVILLU/I04xvqIjKIlopb8SEnpuIy5c4pmvrPy9Q1SqEi
         3tr6l8JhaT0t56ZfsadK3eIBhj17YwL5UEJYBmtM1XL52EwU2tYBd2SmE+ABVb09fh9Z
         vOJA==
X-Gm-Message-State: AJIora8KjjphTQS95qbEVfP18gVp/545MwMAIWBZGtmRDJQ/kbAU62Nc
        8ciCk3zKx7LMgF17UcIuzjv3pK7O6OGxyA==
X-Google-Smtp-Source: AGRyM1vHceyoTI2Xu+pbZR9guVzAa4fPQYT2eOh1zcFNEn288pmmsRPIxLxzqLQkZCs/r2P+i12vIQ==
X-Received: by 2002:a05:622a:138c:b0:31d:378d:c5f0 with SMTP id o12-20020a05622a138c00b0031d378dc5f0mr9880756qtk.463.1656837238415;
        Sun, 03 Jul 2022 01:33:58 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id n4-20020a05620a294400b006b24d912ab7sm7075382qkp.46.2022.07.03.01.33.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Jul 2022 01:33:57 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id o2so6315352yba.7;
        Sun, 03 Jul 2022 01:33:57 -0700 (PDT)
X-Received: by 2002:a05:6902:120e:b0:634:6f29:6b84 with SMTP id
 s14-20020a056902120e00b006346f296b84mr8702569ybu.604.1656837236792; Sun, 03
 Jul 2022 01:33:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190625075746.10439-1-vigneshr@ti.com> <20190625075746.10439-4-vigneshr@ti.com>
 <CAMuHMdUCdjfAoZm-cb4v+STt5C0T6OejdcCCQNBRqqAHL6JD=w@mail.gmail.com> <75fee78a-f411-1c7e-a902-d28d02703c16@ti.com>
In-Reply-To: <75fee78a-f411-1c7e-a902-d28d02703c16@ti.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 3 Jul 2022 10:33:45 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUXczeOP9J_A6q1GdhBG42SwZa6VrwOCAdrbB4kSPF+8g@mail.gmail.com>
Message-ID: <CAMuHMdUXczeOP9J_A6q1GdhBG42SwZa6VrwOCAdrbB4kSPF+8g@mail.gmail.com>
Subject: Re: [PATCH v8 3/5] mtd: Add support for HyperBus memory devices
To:     "Raghavendra, Vignesh" <vigneshr@ti.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Tokunori Ikegami <ikegami.t@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Mason Yang <masonccyang@mxic.com.tw>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vignesh,

On Sat, Jul 2, 2022 at 7:10 PM Raghavendra, Vignesh <vigneshr@ti.com> wrote:
> On 6/27/2022 8:58 PM, Geert Uytterhoeven wrote:
> > On Tue, Jun 25, 2019 at 10:00 AM Vignesh Raghavendra <vigneshr@ti.com> wrote:
> >> Cypress' HyperBus is Low Signal Count, High Performance Double Data Rate
> >> Bus interface between a host system master and one or more slave
> >> interfaces. HyperBus is used to connect microprocessor, microcontroller,
> >> or ASIC devices with random access NOR flash memory (called HyperFlash)
> >> or self refresh DRAM (called HyperRAM).
> >>
> >> Its a 8-bit data bus (DQ[7:0]) with  Read-Write Data Strobe (RWDS)
> >> signal and either Single-ended clock(3.0V parts) or Differential clock
> >> (1.8V parts). It uses ChipSelect lines to select b/w multiple slaves.
> >> At bus level, it follows a separate protocol described in HyperBus
> >> specification[1].
> >>
> >> HyperFlash follows CFI AMD/Fujitsu Extended Command Set (0x0002) similar
> >> to that of existing parallel NORs. Since HyperBus is x8 DDR bus,
> >> its equivalent to x16 parallel NOR flash with respect to bits per clock
> >> cycle. But HyperBus operates at >166MHz frequencies.
> >> HyperRAM provides direct random read/write access to flash memory
> >> array.
> >>
> >> But, HyperBus memory controllers seem to abstract implementation details
> >> and expose a simple MMIO interface to access connected flash.
> >>
> >> Add support for registering HyperFlash devices with MTD framework. MTD
> >> maps framework along with CFI chip support framework are used to support
> >> communicating with flash.
> >>
> >> Framework is modelled along the lines of spi-nor framework. HyperBus
> >> memory controller (HBMC) drivers calls hyperbus_register_device() to
> >> register a single HyperFlash device. HyperFlash core parses MMIO access
> >> information from DT, sets up the map_info struct, probes CFI flash and
> >> registers it with MTD framework.
> >>
> >> Some HBMC masters need calibration/training sequence[3] to be carried
> >> out, in order for DLL inside the controller to lock, by reading a known
> >> string/pattern. This is done by repeatedly reading CFI Query
> >> Identification String. Calibration needs to be done before trying to detect
> >> flash as part of CFI flash probe.
> >>
> >> HyperRAM is not supported at the moment.
> >
> > Thanks for your patch, which is now commit dcc7d3446a0fa19b ("mtd:
> > Add support for HyperBus memory devices") in v5.3.
> >
> >> HyperBus specification can be found at[1]
> >> HyperFlash datasheet can be found at[2]
> >>
> >> [1] https://www.cypress.com/file/213356/download
> >> [2] https://www.cypress.com/file/213346/download
> >> [3] http://www.ti.com/lit/ug/spruid7b/spruid7b.pdf
> >>     Table 12-5741. HyperFlash Access Sequence
> >
> > The last link no longer works.  Do you have a replacement?
>
> Looks like I used a link point to specific version instead of top level
> redirector link. Please use:
>
> https://www.ti.com/lit/pdf/spruid7

Thank you, that link works for me.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
