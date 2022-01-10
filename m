Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 413F2489E82
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 18:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238455AbiAJRic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 12:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238197AbiAJRib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 12:38:31 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED86C06173F;
        Mon, 10 Jan 2022 09:38:31 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id m6so29713805ybc.9;
        Mon, 10 Jan 2022 09:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Pn6vNul4e8iM8CW/s9gLrUxSfmYfz22osJ3AQncpgc=;
        b=dYKHIkrcNLqV7aZ5YS2d0PD7VjHHEGH8HDRv9QyfT5dn+VCNyEcsW2FxN6Vmk0NMTf
         bcXskwMcgp7C8CIj99r8+LrXobvEIY19i80LN6AuCDpX89pf2S2gvaHXtRlwdJvzLoYC
         /ye74Evk/XKaQiHWGGykaQkyiEzGDQT55tc2NaFeqj5pFGnMrp3n2N6qW2oG9SjsiSSY
         aJRNYFTa7EBx3DZwxw1/waiUF74t9ATkYpmwHD5IgAKFRoZ7BAch8tO9/yTBh2ljMOSN
         1PyIrijWdjE4LtCR4zaWhrwO+Kk5ZMIkEHWvPLznZSDVHBnBkxBfqwETQ8Q7YtN0TDdz
         uI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Pn6vNul4e8iM8CW/s9gLrUxSfmYfz22osJ3AQncpgc=;
        b=AXNO4hvR8ruoB972sDib7gbmdwJh23EPMsOCUZzM8HkrvG+7vxZcjbP8bCn7c03wZI
         tfaWe/W3X8e9MPXNfAiWx9TgF9885YkyTTxfbD4gHTYqwvk0AtN/tFJMSB3zSTF7FHp3
         wxKPV0Kw2DQ42j8rsltdSMofDS1SZ54eDYpqfF0PJBg/DksuPAG+5BZh7r8BB/KfS9Nk
         nsGPIWp1cQZRZP53d97zSW9/YG41Vxzh4wD7Cm7Bi4nb9n2T1QLR93caqs+pcjm9gjr5
         EIfHp4JJCb/Wl7TSuCDuJfGwh0d/5fxTH6Dyexv2Q5F91KJj0q8Dvm1AIb04ZL1oXmoW
         8O7g==
X-Gm-Message-State: AOAM533YbtcqCwXqY1OOcRjPa3LiyxN15IbWgiYufWByMi7idD5juMsZ
        2oYPMO1CZFW0EOTEmdBsJ3IZxCBErj/pA/In/W4=
X-Google-Smtp-Source: ABdhPJwcUSh0xH7r+hddfZUIZH6eKPebjm73mmFFYO2yTdvDNeKVFMfghW3SvqjRYFJPTH8P/2ccW96yDptlmUnXVLo=
X-Received: by 2002:a25:4153:: with SMTP id o80mr834176yba.147.1641836310214;
 Mon, 10 Jan 2022 09:38:30 -0800 (PST)
MIME-Version: 1.0
References: <20220107184614.2670254-1-f.fainelli@gmail.com>
In-Reply-To: <20220107184614.2670254-1-f.fainelli@gmail.com>
From:   Kamal Dasu <kdasu.kdev@gmail.com>
Date:   Mon, 10 Jan 2022 12:38:19 -0500
Message-ID: <CAC=U0a3V8973MqyCU2M=hG0bkhcNZN3kSySZGaZmFHnEZeqYRA@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] BCMA support for brcmnand
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     MTD Maling List <linux-mtd@lists.infradead.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Colin Ian King <colin.king@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM SPECIFIC AMBA DRIVER (BCMA)" 
        <linux-wireless@vger.kernel.org>,
        "open list:BROADCOM STB NAND FLASH DRIVER" 
        <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Florian,

On Fri, Jan 7, 2022 at 1:46 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> Hi all,
>
> This patch series adds support for the BRCMNAND controller revision 3.4
> embedded in MIPS-based SoCs such as 5357, typically found in the Netgear
> WNR3500L v2 and other kinds of Wi-Fi routers. The upstream platform that
> uses this controller is under arch/mips/bcm47xx/ and does not use Device
> Tree (and probably never will by now). BCMA (Broadcom AMBA) is a special
> kind of discoverable memory mapped interface which requires the use of
> special accessors to read from/write to the hardware block.
>
> The integration of brcmnand into that SoC is a bit quirky in that every
> register offering byte level data about the flash (OOB, device ID, etc.)
> requires byte swapping. The command shift should also have been 24, but
> is in fact 0, took me a while to understand why no reads were actually
> working because of that.
>
> This has been tested with Linux 5.10.82 and Linus' master with OpenWrt
> and confirmed that the squashfs + jffs2 overlay that OpenWrt creates is
> entirely functional and that written data is made persistent.
>
> Changes in v3:
>
> - fixed a few typo/grammar errors in the commit messages, mention when
>   changes are non functional changes
> - removed the stray hunk in 2 to enable the static key
>
> Changes in v2:
>
> - re-ordered the patch such that the soc variable is initialized as
>   early as possible
> - corrected bug in the conversion of brcmnand_init_cs() which
>   incorrectly used the wrong device_node variable (parent instead of
>   child)
> - took Andy's feedback to make the test for a valid interrupt to be > 0
>   while calling platform_get_irq_optional()
> - utilized static branch (disabled by default) and conditional
>   compilation and confirm with disassembly that the generated code is
>   as efficient as before if not enabling the BCMA shim and as efficient
>   as possible if enabling BCMA shim
> - updated BCMA shim driver descriptor, author and added helper function
>   to encapsulate the container_of usage
> - added comment to explain why a slightly different platform device name
>   is used for the 5357-style NAND controller
>
> Florian Fainelli (9):
>   mtd: rawnand: brcmnand: Assign soc as early as possible
>   mtd: rawnand: brcmnand: Allow SoC to provide I/O operations
>   mtd: rawnand: brcmnand: Avoid pdev in brcmnand_init_cs()
>   mtd: rawnand: brcmnand: Move OF operations out of brcmnand_init_cs()
>   mtd: rawnand: brcmnand: Allow working without interrupts
>   mtd: rawnand: brcmnand: Add platform data structure for BCMA
>   mtd: rawnand: brcmnand: Allow platform data instantation
>   mtd: rawnand: brcmnand: BCMA controller uses command shift of 0
>   mtd: rawnand: brcmnand: Add BCMA shim
>
>  MAINTAINERS                                 |   1 +
>  drivers/bcma/driver_chipcommon_nflash.c     |  20 ++-
>  drivers/mtd/nand/raw/Kconfig                |  13 ++
>  drivers/mtd/nand/raw/brcmnand/Makefile      |   2 +
>  drivers/mtd/nand/raw/brcmnand/bcma_nand.c   | 132 ++++++++++++++++
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c    | 160 +++++++++++++-------
>  drivers/mtd/nand/raw/brcmnand/brcmnand.h    |  29 ++++
>  include/linux/bcma/bcma_driver_chipcommon.h |   5 +
>  include/linux/platform_data/brcmnand.h      |  12 ++
>  9 files changed, 321 insertions(+), 53 deletions(-)
>  create mode 100644 drivers/mtd/nand/raw/brcmnand/bcma_nand.c
>  create mode 100644 include/linux/platform_data/brcmnand.h
>
> --
> 2.25.1
>

The patch series as in v3  LGTM

Kamal
