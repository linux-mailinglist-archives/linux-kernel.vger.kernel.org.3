Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093AF4B0157
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 00:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiBIXdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 18:33:08 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiBIXdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 18:33:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59205E04FF2F;
        Wed,  9 Feb 2022 15:32:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E155DB823D7;
        Wed,  9 Feb 2022 23:32:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9059EC340E7;
        Wed,  9 Feb 2022 23:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644449571;
        bh=1v8Ww55cVuJZilob67Fi28dIKcIBdoa+SK7/xwiEXVU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=J012nIT9ccXpnYwTs+ydTA1iu5DOhEijYaeLyA/9sBdND6pjgOJixJPVaeXXI/UaS
         y35tC7deE5+dUi0UnnwtYo4zmZhGYhMSChh0b1mWtgrJkFoiirWwhhTNKMP3frJbna
         giZP5Wvfe13k6oqHC4Jdg4FiGiABuwFHYm9j2SUxhpcdl96MDhAeJrkKd7nlUiYqFC
         e0V3SSadUMydbL9Vdo8FTk+MO1i8i9xkDaXMm/PC7c4KM6wm2bPpE5mrwZOwaXw4OY
         7j1PJVndwse+fpdlIYCQugU8jEWlX4aJW0p/Vgn/l6gZa7Dqq2fMJUSx2KVir22ECM
         fr+yRf82//5Nw==
Received: by mail-ej1-f44.google.com with SMTP id k25so11265757ejp.5;
        Wed, 09 Feb 2022 15:32:51 -0800 (PST)
X-Gm-Message-State: AOAM533DZSRuUnHh9rsP2unyew3O+uPo7SdIVRCiliyyc+Zx5a7ebgxT
        TiFfcP64+z48n33a1QfuUjrMwQy5mycEm0sniQ==
X-Google-Smtp-Source: ABdhPJyNA301ZhPXtbCzzHj3UCxICGpDk+ZxCnOCEAlawsi68a+tJydeVQx/Mn2Ov0fAVmDZMq+dJBVJ3QGrVUxn7h4=
X-Received: by 2002:a17:907:2d29:: with SMTP id gs41mr4169484ejc.14.1644449569884;
 Wed, 09 Feb 2022 15:32:49 -0800 (PST)
MIME-Version: 1.0
References: <20220128042321.15228-1-nikhil.gupta@nxp.com> <CAL_JsqKWmnQde+4tnZ3d90pWguezLVqto4DRe3WRjf9PCQ=L4w@mail.gmail.com>
 <PAXPR04MB83348BB9265516255BBB2ACB8B269@PAXPR04MB8334.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB83348BB9265516255BBB2ACB8B269@PAXPR04MB8334.eurprd04.prod.outlook.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 9 Feb 2022 17:32:38 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+EnQE27cfUU2xZM+kjQrmhO4PcO3WDG2yg+=sRAnxPgQ@mail.gmail.com>
Message-ID: <CAL_Jsq+EnQE27cfUU2xZM+kjQrmhO4PcO3WDG2yg+=sRAnxPgQ@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH] of/fdt: move elfcorehdr reservation early for
 crash dump kernel
To:     Nikhil Gupta <nikhil.gupta@nxp.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Priyanka Jain <priyanka.jain@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 1, 2022 at 9:37 AM Nikhil Gupta <nikhil.gupta@nxp.com> wrote:
>

Please don't top post and fix your email client quoting on replies.
IOW, don't use Outlook. While MS loves Linux now, they don't make an
email client that works with maillists.

> Hello Rob,
>
> This issue will come in scenarios where the memory has been reserved using fdt_init_reserved_mem()
> The memory address which is reserved overlaps with the address of elfcorehdr which has a fixed address,
> So the memory for elfcorehdr needs to be reserved first.
>
> crashkernel memory range : 0x00000000d4000000 - 0x00000000f4000000 (512 MB)
> elfcorehdr addr is calculated in kexec tool based on reserved crashkernel memory space. (Last page is used in top down order)
> elfcorehdr conflict with memory [    0.000000] memblock_reserve: [0x00000000f3c00000-0x00000000f3ffffff] reserved by fdt_init_reserved_mem()
>
> Without Patch:
>
> [    0.000000] memblock_reserve: [0x00000000d4010000-0x00000000d677ffff] arm64_memblock_init+0x258/0x2c8
> [    0.000000] memblock_phys_alloc_range: 4194304 bytes align=0x400000 from=0x0000000000000000 max_addr=0x0001000000000000 early_init_dt_alloc_reserved_memory_arch+0x9c/0x16c
> [    0.000000] memblock_reserve: [0x00000000f3c00000-0x00000000f3ffffff] memblock_alloc_range_nid+0xdc/0x150
> [    0.000000] memblock_phys_alloc_range: 33554432 bytes align=0x2000000 from=0x0000000000000000 max_addr=0x0001000000000000 early_init_dt_alloc_reserved_memory_arch+0x9c/0x16c
> [    0.000000] memblock_reserve: [0x00000000f0000000-0x00000000f1ffffff] memblock_alloc_range_nid+0xdc/0x150
> [    0.000000] memblock_phys_alloc_range: 16777216 bytes align=0x1000000 from=0x0000000000000000 max_addr=0x0001000000000000 early_init_dt_alloc_reserved_memory_arch+0x9c/0x16c
> [    0.000000] memblock_reserve: [0x00000000f2000000-0x00000000f2ffffff] memblock_alloc_range_nid+0xdc/0x150
> [    0.000000] OF: reserved mem: initialized node bman-fbpr, compatible id fsl,bman-fbpr
> [    0.000000] OF: fdt: elfcorehdr is overlapped
>
> With Patch:
>
> [    0.000000] memblock_remove: [0x0001000000000000-0x0000fffffffffffe] arm64_memblock_init+0xa0/0x2d8
> [    0.000000] memblock_remove: [0x00008000c0000000-0x00008000bffffffe] arm64_memblock_init+0xfc/0x2d8
> [    0.000000] memblock_remove: [0x00000000d6160000-0x00000000d83befff] arm64_memblock_init+0x1c8/0x2d8
> [    0.000000] memblock_add: [0x00000000d6160000-0x00000000d83befff] arm64_memblock_init+0x1d4/0x2d8
> [    0.000000] memblock_reserve: [0x00000000d6160000-0x00000000d83befff] arm64_memblock_init+0x1e0/0x2d8
> [    0.000000] memblock_reserve: [0x00000000d4010000-0x00000000d615ffff] arm64_memblock_init+0x260/0x2d8
> [    0.000000] memblock_reserve: [0x00000000f3fff000-0x00000000f3fff3ff] early_init_fdt_scan_reserved_mem+0x370/0x3c8
> [    0.000000] OF: fdt: Reserving 1 KiB of memory at 0xf3fff000 for elfcorehdr
> [    0.000000] memblock_phys_alloc_range: 4194304 bytes align=0x400000 from=0x0000000000000000 max_addr=0x0001000000000000 early_init_dt_alloc_reserved_memory_arch+0x38/0x8c
> [    0.000000] memblock_reserve: [0x00000000f3800000-0x00000000f3bfffff] memblock_alloc_range_nid+0xdc/0x150
> [    0.000000] memblock_phys_alloc_range: 33554432 bytes align=0x2000000 from=0x0000000000000000 max_addr=0x0001000000000000 early_init_dt_alloc_reserved_memory_arch+0x38/0x8c
> [    0.000000] memblock_reserve: [0x00000000f0000000-0x00000000f1ffffff] memblock_alloc_range_nid+0xdc/0x150
> [    0.000000] memblock_phys_alloc_range: 16777216 bytes align=0x1000000 from=0x0000000000000000 max_addr=0x0001000000000000 early_init_dt_alloc_reserved_memory_arch+0x38/0x8c

Digging a bit more, it seems this never worked? It is also not fixable
in this way before commit 57beb9bd18fc ("arm64: kdump: Remove custom
linux,elfcorehdr handling"). So if you want a fix prior to v5.15, it
will need a different fix.

Rob
