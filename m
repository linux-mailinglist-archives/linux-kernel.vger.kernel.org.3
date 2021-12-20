Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1A447A7A5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 11:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbhLTKRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 05:17:11 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44200 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbhLTKRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 05:17:10 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BKAGhIY120274;
        Mon, 20 Dec 2021 04:16:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1639995403;
        bh=GYj8kGPgj1hxPl8S3pgnPwD1ZsWJ0oyCz/WNMErvZJA=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=ms/B71igNuhL26J1hXkFY/JxMt+qmf0P27b8x46jA9o9j8lt2oQk0284jRpdKFewd
         h+UqNmhZtu1Y/PunW8izSBPLYt1tU1hG1EVtUyezTVEqadSkBgV3s2BlTYMCUWWKWp
         ZSGy71W9Y/tkaY6ZVkaGYz8ViWDx9PIpHO9AevPs=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BKAGhtV055115
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Dec 2021 04:16:43 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 20
 Dec 2021 04:16:42 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 20 Dec 2021 04:16:42 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BKAGgj6095180;
        Mon, 20 Dec 2021 04:16:42 -0600
Date:   Mon, 20 Dec 2021 15:46:41 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     <Tudor.Ambarus@microchip.com>
CC:     <michael@walle.cc>, <vigneshr@ti.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Nicolas.Ferre@microchip.com>,
        <zhengxunli@mxic.com.tw>, <jaimeliao@mxic.com.tw>
Subject: Re: [PATCH v2 2/2] mtd: spi-nor: macronix: Add support for
 mx66lm1g45g
Message-ID: <20211220101639.ycdz4twnhhp5bvlj@ti.com>
References: <20211209190436.401946-1-tudor.ambarus@microchip.com>
 <20211209190436.401946-2-tudor.ambarus@microchip.com>
 <20211217113810.mzqrwf6vxfniggn3@ti.com>
 <c94a306d-a71f-6465-bb3d-d9e6ae55148b@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c94a306d-a71f-6465-bb3d-d9e6ae55148b@microchip.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tudor,

On 17/12/21 12:38PM, Tudor.Ambarus@microchip.com wrote:
> On 12/17/21 1:38 PM, Pratyush Yadav wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On 09/12/21 09:04PM, Tudor Ambarus wrote:
> >> mx66lm1g45g supports just 1-1-1, 8-8-8 and 8d-8d-8d modes. There are
> >> versions of mx66lm1g45g which do not support SFDP, thus use
> >> SPI_NOR_SKIP_SFDP. The RDID command issued through the octal peripheral
> >> interface outputs data always in STR mode for whatever reason. Since
> > 
> > Huh! I hope this is a mistake from the chip designers, because if it
> > isn't they need a stern talking-to ;-)
> > 
> >> 8d-8d-8s is not common, avoid reading the ID when enabling the octal dtr
> >> mode. Instead, read back the CR2 to check if the switch was successful.
> >> Tested in 1-1-1 and 8d-8d-8d modes using sama7g5 QSPI IP.
> > 
> > Datasheet?
> 
> MX66LM1G45G datasheet:
> https://www.macronix.com/Lists/Datasheet/Attachments/7929/MX66LM1G45G,%203V,%201Gb,%20v1.1.pdf

Thanks.

I see that the RDID waveform holds each byte of the ID for a whole clock 
cycle. So you would read ab ab cd cd ef ef. I've seen this before 
somewhere, and sure enough, digging through my inbox I've found this 
patch [0]. In this read ID is performed but only alternate bytes are 
compared since they are repeated. I think you should do the same. I feel 
like reading/comparing 3 bytes is more "robust".

BTW, this patch series also adds support for mx66lm1g45g. You might want 
to use this as reference.

[0] https://lore.kernel.org/all/20210812150135.4005-2-zhengxunli.mxic@gmail.com/

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
