Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86B44F505E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1453173AbiDFBXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573543AbiDETUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 15:20:03 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A765EEBB90;
        Tue,  5 Apr 2022 12:18:03 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 235JHxYK082442;
        Tue, 5 Apr 2022 14:17:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1649186279;
        bh=E9zif9I5bUgBOTveI/9CsfWv9DV8Jc8LKT9ySYgZmtY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=mGH/m1LnUZ0aqJzLlvnsqjtJr02p9p4rvmihNAh+eTCUiV9wJqfjsuTthz8zlG2Zf
         TgU20lX6XohEfDssOB1uD97wUkPGjYehfw8ver6y2FnF33Vp/OX5b4no3k6eepe2LZ
         ie5MK98lk/hrhJZHrVX/gBSzn6GANX1sxbl3ItXs=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 235JHx8t010500
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Apr 2022 14:17:59 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 5
 Apr 2022 14:17:58 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 5 Apr 2022 14:17:58 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 235JHwCh019604;
        Tue, 5 Apr 2022 14:17:58 -0500
Date:   Wed, 6 Apr 2022 00:47:57 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
CC:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-spi@vger.kernel.org>,
        Michal Simek <michal.simek@xilinx.com>, <git@xilinx.com>,
        <saikrishna12468@gmail.com>, <sgoud@xilinx.com>
Subject: Re: [PATCH 2/2] spi: cadence-quadspi: Add support for OSPI device
 reset
Message-ID: <20220405191757.3rzc6q477reusywp@ti.com>
References: <1649156437-15609-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
 <1649156437-15609-3-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1649156437-15609-3-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04/22 04:30PM, Sai Krishna Potthuri wrote:
> Cadence OSPI controller always start in SDR mode and it doesn't know
> the current mode of the flash device (SDR or DDR). This creates issue
> during Cadence OSPI driver probe if OSPI flash device is in DDR mode.
> This patch add OSPI flash device reset using HW reset pin for Xilinx
> Versal platform, this will make sure both Controller and Flash device
> are in same mode (SDR).

Is this supposed to reset the OSPI flash or the controller? If you are 
resetting it in the flash then you should handle this from the flash 
driver, not from here.

Also, as of now at least, SPI NOR only works when the flash is in SDR 
mode. For TI platforms, we reset the flash in the bootloader (U-Boot), 
before handing control off to the kernel. If you do want to properly 
handle flashes that are handed to the kernel in DDR mode, I would 
suggest you update SPI NOR instead to detect the flash mode and work 
from there. This would also allow us to support flashes that boot in DDR 
mode, so would still be in DDR mode even after a reset.

> Xilinx Versal platform has a dedicated pin used for OSPI device reset.
> As part of the reset sequence, configure the pin to enable
> hysteresis and set the direction of the pin to output before toggling
> the pin. Provided the required delay ranges while toggling the pin to
> meet the most of the OSPI flash devices reset pulse width, reset recovery
> and CS high to reset high timings.
> 
> Signed-off-by: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
[...]

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
