Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB0A4E2F45
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 18:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350072AbiCURod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 13:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349403AbiCURob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 13:44:31 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CA5DFF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 10:43:01 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 22LHgqcv000374;
        Mon, 21 Mar 2022 12:42:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1647884572;
        bh=w1nssn3aZv3EvnBbeSHoVlZA7OBBWbfhVwK6ZRd350A=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=nC62Q8oW8++CQMPC1p4CAkSWBrjQdp6p80If1ZrYwtWvySL+YxejaOM9VhYr/Atdd
         vMOLTmbWtA6A0TltvdlCHYnj2RV41Pb/Bywd+KgUOVxuab4liQTZpbIHFgcpxeKvYr
         oRYFYjCzxVRxsBqx8hbzHp73HEYp8edhuQ7mdkL4=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 22LHgqJk027761
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Mar 2022 12:42:52 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 21
 Mar 2022 12:42:52 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 21 Mar 2022 12:42:52 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 22LHgpei021588;
        Mon, 21 Mar 2022 12:42:52 -0500
Date:   Mon, 21 Mar 2022 23:12:51 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     <Tudor.Ambarus@microchip.com>
CC:     <michael@walle.cc>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH v2 3/8] mtd: spi-nor: core: Use auto-detection only once
Message-ID: <20220321174251.ehhobu26tgoxrbps@ti.com>
References: <20220228111712.111737-1-tudor.ambarus@microchip.com>
 <20220228111712.111737-4-tudor.ambarus@microchip.com>
 <20220321121455.bpql7x4ebhq7s36l@ti.com>
 <b4e8c044-f16a-a72d-6047-c42cdcc253f1@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b4e8c044-f16a-a72d-6047-c42cdcc253f1@microchip.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/22 12:50PM, Tudor.Ambarus@microchip.com wrote:
> On 3/21/22 14:14, Pratyush Yadav wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On 28/02/22 01:17PM, Tudor Ambarus wrote:
> >> In case spi_nor_match_name() returned NULL, the auto detection was
> >> issued twice. There's no reason to try to detect the same chip twice,
> >> do the auto detection only once.
> >>
> >> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> >> ---
> >>  drivers/mtd/spi-nor/core.c | 10 ++++++----
> >>  1 file changed, 6 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> >> index f87cb7d3daab..b1d6fa65417d 100644
> >> --- a/drivers/mtd/spi-nor/core.c
> >> +++ b/drivers/mtd/spi-nor/core.c
> >> @@ -2894,13 +2894,15 @@ static const struct flash_info *spi_nor_match_name(struct spi_nor *nor,
> >>  static const struct flash_info *spi_nor_get_flash_info(struct spi_nor *nor,
> >>                                                      const char *name)
> >>  {
> >> -     const struct flash_info *info = NULL;
> >> +     const struct flash_info *info = NULL, *detected_info = NULL;
> >>
> >>       if (name)
> >>               info = spi_nor_match_name(nor, name);
> >>       /* Try to auto-detect if chip name wasn't specified or not found */
> >> -     if (!info)
> >> -             info = spi_nor_read_id(nor);
> >> +     if (!info) {
> >> +             detected_info = spi_nor_read_id(nor);
> >> +             info = detected_info;
> >> +     }
> >>       if (IS_ERR_OR_NULL(info))
> >>               return ERR_PTR(-ENOENT);
> >>
> >> @@ -2908,7 +2910,7 @@ static const struct flash_info *spi_nor_get_flash_info(struct spi_nor *nor,
> >>        * If caller has specified name of flash model that can normally be
> >>        * detected using JEDEC, let's verify it.
> >>        */
> >> -     if (name && info->id_len) {
> >> +     if (name && !detected_info && info->id_len) {
> >>               const struct flash_info *jinfo;
> >>
> >>               jinfo = spi_nor_read_id(nor);
> > 
> > I think the flow can be a little bit better. How about:
> > 
> >         if (name)
> >                 info = spi_nor_match_name();
> > 
> >         if (!info) {
> >                 info = spi_nor_read_id();
> >                 if (IS_ERR_OR_NULL(info))
> >                         return ERR_PTR(-ENOENT);
> > 
> >                 return info;
> >         }
> 
> Here we miss the IS_ERR check in case info is retrieved with spi_nor_match_name().
> Do you expect spi_nor_match_name() to ever return an error? As it is now it doesn't.
> I'm fine either way. In case you want me to follow your suggestion, give me a sign
> and I'll make a dedicated patch to move the IS_ERR_OR_NULL check. Will add your
> Suggested-by tag.

I think it should be safe to assume it won't ever return an error since 
all it does is iterate over an array that is always present. I don't see 
that changing in the foreseeable future either. So I think not having 
the IS_ERR check is fine.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
