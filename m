Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045814FF971
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 16:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235848AbiDMOxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 10:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbiDMOxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 10:53:17 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1700A62BF4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 07:50:56 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id i11-20020a9d4a8b000000b005cda3b9754aso1310532otf.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 07:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+NNFF3WYjd8C1QYq4detVhKQK1MffqpGN9VKt8TJvZs=;
        b=By63kXptljWQTyCi/GWdKBpb6G/eWPjK9x+6S4EATkV/dFTtjOxMuSD48XhbDhRbwG
         JrpviCrGwYtMtaDhYdsMiWHPlgyMhpbzli5QgVah2F0HKHZmotoEAfMJ4zlM3CBb2Zqh
         Wrb1s0Ll2Vsfc/Xzb7gRLKWZUA/uUiNvp2iiyUHba0Pz2pcu6Z6PgewIJW7sSINk9w7F
         lpfcyy/QVA+9Y/o5Kb5EBP9NHNvyL5aH2hTFqgDxau/Se+bo9KTATpt+bdb6y82m9chu
         eixTnKsVUniCZLmEOyqqUNGVWS14f1N0CpLT71j9RO6Fb5h2CT4w6c5Gy7585TadB43P
         elSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+NNFF3WYjd8C1QYq4detVhKQK1MffqpGN9VKt8TJvZs=;
        b=qyoyOrWpufTCSY4Ek58Rbb2MwbplBjb6SkikEFS75FKFh7LHMLm7GqMS3GSeTg9Zkz
         wtFP5Xaz1LfjndZTwADbJN85ew6QczrMAH/U9hngqTAGsgeH9Wcd+OqplXq2FWftxPLu
         PPAsMA5n7FxoW65uafcjB9Fr4sahPPr5QCTI8CdiHxf0u8w0xBTjDcwwlZFcgCk+2UX4
         GaIvBTBsCAwSVCUxuq2a99iFSblENkeIjqeuL8lMMDAZtqi2RbE1B/nh9nlgMEpIybnM
         umsVGQnBAVu9lEcTdIrFLq1qWc9cZXITm/cd+YM8WbtzenCzm7BrnaXN6a8+Kk8e4Hsh
         ASDw==
X-Gm-Message-State: AOAM53170FSRtWQHvj1kK98CFiJ8qz4k/16Xfg8f4hnd+6gBmf2O+dcS
        +xiobkpkkaHYMVFCw8eeMWXDhyVZQqaEIHOzKDU=
X-Google-Smtp-Source: ABdhPJyn1dTCnUoWxb5z+Sq3ql5W24Hh52Mp7FwrEfgqZXjfodffCZUMuZevwAXM2BfvpWEVe8b6al5mf2N/CV2U+ic=
X-Received: by 2002:a05:6830:2b0d:b0:5cd:aca2:f3f2 with SMTP id
 l13-20020a0568302b0d00b005cdaca2f3f2mr14990347otv.212.1649861455407; Wed, 13
 Apr 2022 07:50:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220413083824.247136-1-gch981213@gmail.com> <20220413145843.46a3d9b5@xps13>
In-Reply-To: <20220413145843.46a3d9b5@xps13>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Wed, 13 Apr 2022 22:50:43 +0800
Message-ID: <CAJsYDV+3J0ipbR+N-xE=DH-WXsjierdHe_pJtKf1Xbt7fdaiWw@mail.gmail.com>
Subject: Re: [PATCH v2] mtd: spinand: add support for ESMT F50x1G41LB
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Palmer <daniel@0x0f.com>,
        open list <linux-kernel@vger.kernel.org>
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

Hi!

On Wed, Apr 13, 2022 at 8:58 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> [...]
> > This patch is made purely based on datasheet info without testing
> > on any actual chips.
>
> Do you plan to get one of these any time soon?

No. I already have way more spi-nand chips than I possibly
need due to my last GigaDevice submission :)

I need to replace the spi-nand driver for mediatek in OpenWrt
with my recent submission, and this chip is used in one of the
currently supported router. So I made this patch from
datasheet for it.

BTW Rockchip added identical chip support in their u-boot.[0]
I assume they've tested it.

> I am not really confident merging a 100% non-tested driver :)

I can understand that.
I'll roll this patch out in OpenWrt anyway. I can wait for a test
there and resubmit piled downstream patches for chip supports
after next OpenWrt stable release.

>
> [...]
> > +
> > +/* ESMT uses GigaDevice 0xc8 JECDEC ID on some SPI NANDs */
> > +#define SPINAND_MFR_ESMT_C8                  0xc8
>
> What happens if the gigadevice driver probes first?

Their device ID aren't conflicting yet, so nothing will happen
at the moment.

There is a solution for future conflict: Recent SPI-NAND chips
contain a parameter page which has the exact chip vendor
and model. We can do one more detection with the parameter
page content.
Winbond W25N01KV is a 2k+96 SPI-NAND with 4-bit ECC.
It uses the exact same chip id as the current W25N01GV
(2k+64 1-bit ECC). We need to support detection using
parameter page for this crazy decision by Winbond anyway.
I'll try to code something for this with my free time.

My current idea is: We first do a detection based on chip id.
If that failed, try to read the parameter page. If we got a
valid one, match the chip vendor and model string.

Any thoughts?

(BTW this ESMT chip is POWERCHIP PSU1GS20DX
according to the parameter page in their datasheet.
But I can't find a datasheet for this model number.)

>
> > +
> > +#define F50L2G41XA_ECC_STATUS_MASK           GENMASK(6, 4)
> > +#define F50L2G41XA_STATUS_ECC_1_3_BITFLIPS   (1 << 4)
> > +#define F50L2G41XA_STATUS_ECC_4_6_BITFLIPS   (3 << 4)
> > +#define F50L2G41XA_STATUS_ECC_7_8_BITFLIPS   (5 << 4)

Oops. These are left-over defines when I discovered that ESMT 2G/4G
SPI-NANDs are repackaged micron parts and dropped their support
from this file.
A v3 is needed anyway. I'll wait for a test before submitting it.

[0]: https://github.com/rockchip-linux/u-boot/commit/52b0060178285488737854a48ddecd381f8b236e
-- 
Regards,
Chuanhong Guo
