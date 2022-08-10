Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A6C58EF1B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 17:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbiHJPRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 11:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiHJPRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 11:17:38 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587CA77559
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 08:17:37 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id j8so28278928ejx.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 08:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=17Px2Q0XnRJSkgeDgK2Uc7SLf0lUYwKRriKLtd/OTEc=;
        b=ZUTMtDxdkka7efEt+gZA1raHqb9DkP/Lg4D5j1qxD1fYN7g9jdBex/U0K7uwm+S0qo
         uaIyaLY56a/OsYEm2hLsIhzkYYqGLH6I6neFSQP8w6D3oPjQxUIMBNYrsXvWYbhdrkkI
         R2nnDfbjJY0oVKV/0lLQLRzB7Byj55mIV2c3XJYJiHLa58Ji+kmfv2mJYSFZvC0bCWtK
         /FGxayOpGV8huVrXNUzMhj1u9cvXOmXACwbtG18l1QNlAkwtPd3pkY6WwfDo4x676h5Y
         EB28HD4V3LczIn3BY7N/pdTuoMuZtvs0x5Yx/QtI2ybf14VoykXzue7zvGFyK3FeY/+a
         +dEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=17Px2Q0XnRJSkgeDgK2Uc7SLf0lUYwKRriKLtd/OTEc=;
        b=kE8nG/FnzLlZ7RMYRmBaYKFHLaN46AJ41t5NgNj/qhntntdJQehagowXhgPPpz856y
         sDEvyLgNwMoVOioE2M1YN6RvFb/7YoKfECyCIG6tGL8jQ7gs4qUfFECiFpmZOntqwJkE
         jtrgtlFrbKXNsXd/W7g2P/unS0SwcuzyFYbxrQAZLtWKJGo6RQYwb/6P+Os/lfK+VaL+
         dctySLJquEyNQSAutgKpFTpIlwXoKAcuu9mwWI4aE4JJK/USvW618VZcoOsv4HvTIcyS
         1Yz+C7fDuAgQl3oWJ1sOm8/SD2XfJQWX3gDHQiDmkofDheUgwXkAcWgBNc/OT/h5EZM+
         fmqw==
X-Gm-Message-State: ACgBeo20T9pTdZhVUEuDaNsmt2N7pf4TuydsyniLiuRVgsQ0Crsduerl
        02vu5IxWgkXU9+tLOAnj8a6B+MS8yViK0G5jpCubWA==
X-Google-Smtp-Source: AA6agR7oVMUUXFe//QlOo+zHflIW7QAtuhApnXJl+A4r2Npaw5Vr5HKEjpabzylR8mRvvEvfsG7wpSeFR8oo557sIwo=
X-Received: by 2002:a17:907:a068:b0:731:366a:6005 with SMTP id
 ia8-20020a170907a06800b00731366a6005mr13932745ejc.344.1660144655892; Wed, 10
 Aug 2022 08:17:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220809201428.118523-1-sudip.mukherjee@sifive.com>
 <20220809201428.118523-3-sudip.mukherjee@sifive.com> <361fa56d-617c-ee92-151e-5d8fe0a29e53@microchip.com>
 <498c33a8-014f-e542-f143-cba5760fafdd@microchip.com>
In-Reply-To: <498c33a8-014f-e542-f143-cba5760fafdd@microchip.com>
From:   Sudip Mukherjee <sudip.mukherjee@sifive.com>
Date:   Wed, 10 Aug 2022 16:17:24 +0100
Message-ID: <CAHyZL-cKJernGp93+H69zdNnn50Pj0LpYrgmUZuck0YfAZq+2A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mtd: spi-nor: add SFDP fixups for Quad Page Program
To:     Tudor Ambarus <Tudor.Ambarus@microchip.com>
Cc:     Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        William Salmon <william.salmon@sifive.com>,
        Adnan Chowdhury <adnan.chowdhury@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 9:25 AM <Tudor.Ambarus@microchip.com> wrote:
>
> On 8/10/22 11:06, Tudor.Ambarus@microchip.com wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >
> > On 8/9/22 23:14, Sudip Mukherjee wrote:
> >> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >>
> >> SFDP table of some flash chips do not advertise support of Quad Input
> >> Page Program even though it has support. Use fixup flags and add hardware
> >> cap for these chips.
> >>
> >> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
> >> ---
> >>  drivers/mtd/spi-nor/core.c | 9 +++++++++
> >>  drivers/mtd/spi-nor/core.h | 2 ++
> >>  2 files changed, 11 insertions(+)
> >>
> >> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> >> index f2c64006f8d7..7542404332a5 100644
> >> --- a/drivers/mtd/spi-nor/core.c
> >> +++ b/drivers/mtd/spi-nor/core.c
> >> @@ -1962,6 +1962,12 @@ spi_nor_spimem_adjust_hwcaps(struct spi_nor *nor, u32 *hwcaps)
> >>         if (nor->flags & SNOR_F_BROKEN_RESET)
> >>                 *hwcaps &= ~(SNOR_HWCAPS_X_X_X | SNOR_HWCAPS_X_X_X_DTR);
> >>
> >> +       if (nor->flags & SNOR_F_HAS_QUAD_PP) {
> >> +               *hwcaps |= SNOR_HWCAPS_PP_1_1_4;
> >> +               spi_nor_set_pp_settings(&params->page_programs[SNOR_CMD_PP_1_1_4],
> >> +                                       SPINOR_OP_PP_1_1_4, SNOR_PROTO_1_1_4);
> >> +       }
> >
> > setting SPINOR_OP_PP_1_1_4 should be done in spi_nor_late_init_params().
> > spi_nor_late_init_params() is used to adjust the ops supported by the flash
>
> ^ s/spi_nor_late_init_params/spi_nor_spimem_adjust_hwcaps

So, do you mean something like this:

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index f2c64006f8d7..2f41937b826d 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -1962,6 +1962,12 @@ spi_nor_spimem_adjust_hwcaps(struct spi_nor
*nor, u32 *hwcaps)
  if (nor->flags & SNOR_F_BROKEN_RESET)
  *hwcaps &= ~(SNOR_HWCAPS_X_X_X | SNOR_HWCAPS_X_X_X_DTR);

+ if (nor->info->flags & SPI_NOR_QUAD_PP) {
+ *hwcaps |= SNOR_HWCAPS_PP_1_1_4;
+ spi_nor_set_pp_settings(&params->page_programs[SNOR_CMD_PP_1_1_4],
+ SPINOR_OP_PP_1_1_4, SNOR_PROTO_1_1_4);
+ }
+
  for (cap = 0; cap < sizeof(*hwcaps) * BITS_PER_BYTE; cap++) {
  int rdidx, ppidx;

diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 85b0cf254e97..10aa1c72000f 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -507,6 +507,7 @@ struct flash_info {
 #define SPI_NOR_NO_ERASE BIT(6)
 #define NO_CHIP_ERASE BIT(7)
 #define SPI_NOR_NO_FR BIT(8)
+#define SPI_NOR_QUAD_PP BIT(9)

  u8 no_sfdp_flags;
 #define SPI_NOR_SKIP_SFDP BIT(0)
diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
index 89a66a19d754..014cd9038bed 100644
--- a/drivers/mtd/spi-nor/issi.c
+++ b/drivers/mtd/spi-nor/issi.c
@@ -71,8 +71,9 @@ static const struct flash_info issi_nor_parts[] = {
  { "is25wp128",  INFO(0x9d7018, 0, 64 * 1024, 256)
  NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
  { "is25wp256", INFO(0x9d7019, 0, 64 * 1024, 512)
- NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
+ PARSE_SFDP
  FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
+ FLAGS(SPI_NOR_QUAD_PP)
  .fixups = &is25lp256_fixups },

  /* PMC */


--
Regards
Sudip
