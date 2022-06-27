Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E92F55CD42
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238039AbiF0P2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 11:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236142AbiF0P2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 11:28:54 -0400
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC83C186D6;
        Mon, 27 Jun 2022 08:28:53 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id y14so15176369qvs.10;
        Mon, 27 Jun 2022 08:28:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cew7BXEncqN8cEBUoXDCQbsV+p26HXetoRwi9DMFMVs=;
        b=LRCTX8Y9dgMJqFIhwE/i3uqSDSIkxJvrDlBHNfnzO3MBQAQT5QsMtwG4QLOHrj3SZQ
         tgqfWWU4QRYOpyBFW45sknacopm/e6R/768lGXMsdACYhclu6w5c7h7B6n88mO1uIy/t
         g1d8XrrD8oRwKv5Hd29DFvSha25IGnWo2yDcyHwud4xoXjWTlJnLzr0H7pTXAxw8amJC
         qV8q1fdeyWtDbeRTfTYCXDc9gP95WN1U204nH/eTYWgJ4ytVYkLpPGjWdRJDiWHtOufA
         Rg9U3d0FkbrlLRR5hxMgdv9dQcmxGnDxrOQsT29MxgH7CXOULyqvAUzcC8BoMfstQYA+
         5Enw==
X-Gm-Message-State: AJIora8RdXeJPwxKmn/rtf7qqnu05UQdULt/SK2nPQygvu1nIlUDFMNq
        eqM09dGCMmE+wgRIMeJzZbsT36a5d9M9Ew==
X-Google-Smtp-Source: AGRyM1sobL/E7i+JAR2kzgBGM7ySAhIBjURHEBoPEwdKho8M6wnfZWmdyw16sCo3pZqnR6qOmcciWA==
X-Received: by 2002:ac8:59c6:0:b0:305:2f9c:a53e with SMTP id f6-20020ac859c6000000b003052f9ca53emr9367546qtf.59.1656343732501;
        Mon, 27 Jun 2022 08:28:52 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id t22-20020a05622a181600b00316dc1ffbb9sm7116624qtc.32.2022.06.27.08.28.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 08:28:51 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id p7so15933769ybm.7;
        Mon, 27 Jun 2022 08:28:51 -0700 (PDT)
X-Received: by 2002:a05:6902:905:b0:64a:2089:f487 with SMTP id
 bu5-20020a056902090500b0064a2089f487mr14703242ybb.202.1656343731074; Mon, 27
 Jun 2022 08:28:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190625075746.10439-1-vigneshr@ti.com> <20190625075746.10439-4-vigneshr@ti.com>
In-Reply-To: <20190625075746.10439-4-vigneshr@ti.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 27 Jun 2022 17:28:38 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUCdjfAoZm-cb4v+STt5C0T6OejdcCCQNBRqqAHL6JD=w@mail.gmail.com>
Message-ID: <CAMuHMdUCdjfAoZm-cb4v+STt5C0T6OejdcCCQNBRqqAHL6JD=w@mail.gmail.com>
Subject: Re: [PATCH v8 3/5] mtd: Add support for HyperBus memory devices
To:     Vignesh Raghavendra <vigneshr@ti.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vignesh,

On Tue, Jun 25, 2019 at 10:00 AM Vignesh Raghavendra <vigneshr@ti.com> wrote:
> Cypress' HyperBus is Low Signal Count, High Performance Double Data Rate
> Bus interface between a host system master and one or more slave
> interfaces. HyperBus is used to connect microprocessor, microcontroller,
> or ASIC devices with random access NOR flash memory (called HyperFlash)
> or self refresh DRAM (called HyperRAM).
>
> Its a 8-bit data bus (DQ[7:0]) with  Read-Write Data Strobe (RWDS)
> signal and either Single-ended clock(3.0V parts) or Differential clock
> (1.8V parts). It uses ChipSelect lines to select b/w multiple slaves.
> At bus level, it follows a separate protocol described in HyperBus
> specification[1].
>
> HyperFlash follows CFI AMD/Fujitsu Extended Command Set (0x0002) similar
> to that of existing parallel NORs. Since HyperBus is x8 DDR bus,
> its equivalent to x16 parallel NOR flash with respect to bits per clock
> cycle. But HyperBus operates at >166MHz frequencies.
> HyperRAM provides direct random read/write access to flash memory
> array.
>
> But, HyperBus memory controllers seem to abstract implementation details
> and expose a simple MMIO interface to access connected flash.
>
> Add support for registering HyperFlash devices with MTD framework. MTD
> maps framework along with CFI chip support framework are used to support
> communicating with flash.
>
> Framework is modelled along the lines of spi-nor framework. HyperBus
> memory controller (HBMC) drivers calls hyperbus_register_device() to
> register a single HyperFlash device. HyperFlash core parses MMIO access
> information from DT, sets up the map_info struct, probes CFI flash and
> registers it with MTD framework.
>
> Some HBMC masters need calibration/training sequence[3] to be carried
> out, in order for DLL inside the controller to lock, by reading a known
> string/pattern. This is done by repeatedly reading CFI Query
> Identification String. Calibration needs to be done before trying to detect
> flash as part of CFI flash probe.
>
> HyperRAM is not supported at the moment.

Thanks for your patch, which is now commit dcc7d3446a0fa19b ("mtd:
Add support for HyperBus memory devices") in v5.3.

> HyperBus specification can be found at[1]
> HyperFlash datasheet can be found at[2]
>
> [1] https://www.cypress.com/file/213356/download
> [2] https://www.cypress.com/file/213346/download
> [3] http://www.ti.com/lit/ug/spruid7b/spruid7b.pdf
>     Table 12-5741. HyperFlash Access Sequence

The last link no longer works.  Do you have a replacement?
Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
