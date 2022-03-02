Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056F14CA1AA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 11:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239982AbiCBKEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 05:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237229AbiCBKEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 05:04:05 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E7B5AEF4;
        Wed,  2 Mar 2022 02:03:22 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 222A2vmS063787;
        Wed, 2 Mar 2022 04:02:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1646215377;
        bh=kzmAL4ny+b45rxh4hmDCUUkeFdO+HSD8mHyPXmdqx28=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=jP/E/dCOqyWe+EM99Tf5536jGnNFwZFtO+EukKIujh7KfhMoZiOWoPWxWUucTveM5
         0o44PJtBJsGIO4nsSo/rRHL+ESqLTr0DIgX8M2MeWsSsEfJS8woKhzJwUm154fNRic
         8em28FYVPjiu1Xil631fwUzWDzrBjhXfvghoVeew=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 222A2vJD092066
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Mar 2022 04:02:57 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 2
 Mar 2022 04:02:57 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 2 Mar 2022 04:02:56 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 222A2uoV112376;
        Wed, 2 Mar 2022 04:02:56 -0600
Date:   Wed, 2 Mar 2022 15:32:55 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
CC:     <michael@walle.cc>, <broonie@kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <zhengxunli@mxic.com.tw>, <jaimeliao@mxic.com.tw>
Subject: Re: [PATCH 1/4] spi: spi-mem: Allow specifying the byte order in DTR
 mode
Message-ID: <20220302100255.gseqjbdyxrgmt3zf@ti.com>
References: <20220218145900.1440045-1-tudor.ambarus@microchip.com>
 <20220218145900.1440045-2-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220218145900.1440045-2-tudor.ambarus@microchip.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tudor,

I'm reviewing the code here. I still have not thought through the 
discussion about Kconfig option yet.

On 18/02/22 04:58PM, Tudor Ambarus wrote:
> There are NOR flashes (Macronix) that swap the bytes on a 16-bit boundary
> when configured in DTR mode. The byte order of 16-bit words is swapped

s/DTR mode/ Octal DTR mode/

I don't think this would apply to a 4D-4D-4D flash since it would only 
transmit one byte per clock cycle.

> when read or written in Double Transfer Rate (DTR) mode compared to
> Single Transfer Rate (STR) mode. If one writes D0 D1 D2 D3 bytes using
> 1-1-1 mode, and uses 8D-8D-8D SPI mode for reading, it will read back
> D1 D0 D3 D2. Swapping the bytes is a bad design decision because this may
> introduce some endianness problems. It can affect the boot sequence if the
> entire boot sequence is not handled in either 8D-8D-8D mode or 1-1-1 mode.
> Fortunately there are controllers that can swap back the bytes at runtime,
> fixing the endiannesses. Provide a way for the upper layers to specify the
> byte order in DTR mode.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  include/linux/spi/spi-mem.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
> index 85e2ff7b840d..e1878417420c 100644
> --- a/include/linux/spi/spi-mem.h
> +++ b/include/linux/spi/spi-mem.h
> @@ -89,6 +89,8 @@ enum spi_mem_data_dir {
>   * @dummy.dtr: whether the dummy bytes should be sent in DTR mode or not
>   * @data.buswidth: number of IO lanes used to send/receive the data
>   * @data.dtr: whether the data should be sent in DTR mode or not
> + * @data.dtr_bswap16: whether the byte order of 16-bit words is swapped when
> + *		      read or written in DTR mode compared to STR mode.
>   * @data.dir: direction of the transfer
>   * @data.nbytes: number of data bytes to send/receive. Can be zero if the
>   *		 operation does not involve transferring data
> @@ -119,6 +121,7 @@ struct spi_mem_op {
>  	struct {
>  		u8 buswidth;
>  		u8 dtr : 1;
> +		u8 dtr_bswap16 : 1;

You also need to add this capability to spi_controller_mem_caps and 
update spi_mem_default_supports_op() to check for it.

>  		enum spi_mem_data_dir dir;
>  		unsigned int nbytes;
>  		union {
> -- 
> 2.25.1
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
