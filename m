Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7EB477D18
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 21:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241237AbhLPUIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 15:08:04 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:48102 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234059AbhLPUID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 15:08:03 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BGK7suw058679;
        Thu, 16 Dec 2021 14:07:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1639685274;
        bh=y06kAn9IC3WbI952LFtdigmbuoVtt5bJX7zaiQAfKg0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=GZr1K7GuBEGqnXeNj+pY4o8ly5aSsw+jfiBgZw6QVeDXQYABvyMsgN5MFJjgnfx7n
         EnVTospr106RCMIXRbGe8RXwcr0POjY50RVCqYvydFVj3ZDmUxWs9CQgr5WR+/q/+r
         EY9uf2f4bgggTAk95XRfQLBG46UncxsCSgA0myFw=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BGK7sHj116944
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Dec 2021 14:07:54 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 16
 Dec 2021 14:07:54 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 16 Dec 2021 14:07:54 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BGK7r2v119951;
        Thu, 16 Dec 2021 14:07:54 -0600
Date:   Fri, 17 Dec 2021 01:37:53 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Alexander A Sverdlin <alexander.sverdlin@nokia.com>
CC:     <linux-mtd@lists.infradead.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mtd: spi-nor: micron/st: Hardcode erase_proto to
 1-1-1
Message-ID: <20211216200751.u2guamsj5ptezans@ti.com>
References: <20211209100813.61713-1-alexander.sverdlin@nokia.com>
 <20211209100813.61713-2-alexander.sverdlin@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211209100813.61713-2-alexander.sverdlin@nokia.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/21 11:08AM, Alexander A Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> 
> This fixes sector erase on mt25qu256aba8e12-1sit.
> Looks like others like mt35xu512aba could be affected as well.

Indeed. mt35xu512aba would need to set erase_proto to 8D-8D-8D mode.

> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> ---
>  drivers/mtd/spi-nor/micron-st.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
> index 2f3054b..058bbb7 100644
> --- a/drivers/mtd/spi-nor/micron-st.c
> +++ b/drivers/mtd/spi-nor/micron-st.c
> @@ -267,6 +267,12 @@ static void micron_st_default_init(struct spi_nor *nor)
>  	nor->flags &= ~SNOR_F_HAS_16BIT_SR;
>  	nor->params->quad_enable = NULL;
>  	nor->params->set_4byte_addr_mode = st_micron_set_4byte_addr_mode;
> +
> +	/*
> +	 * mt25qu doesn't support all possible write protocols for erase, only
> +	 * 1-1-0, 2-2-0, 4-4-0.
> +	 */
> +	nor->erase_proto = SNOR_PROTO_1_1_1;

If this is only a mt25qu thing, why do it for all Micron flashes? 
Anyway, _if_ you do as I suggest in patch 1, this won't be needed.

>  }
>  
>  static const struct spi_nor_fixups micron_st_fixups = {
> -- 
> 2.10.2
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
