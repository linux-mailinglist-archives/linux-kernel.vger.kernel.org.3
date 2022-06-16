Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9BD54E0E0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 14:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377066AbiFPMdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 08:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376998AbiFPMdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 08:33:41 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E824BFC5;
        Thu, 16 Jun 2022 05:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655382820; x=1686918820;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UEAtVi5CbjSvC5o9X0UlIfBwcav5LyW1HQ2wFacU4jg=;
  b=IUUQM2h3tW2kQ0sM2RdCmtORIeZdcxXZMcdoTPdYTys5ee/Otlg3HnhD
   ZXgP013F26bdfLUn62DBa9MkxRkNNeXco3K2AVpMPl7o0GGpHrD8K5Lqb
   LIJHGXBjvQyKowFumvIpftBFW2553zkTmf4N+oJ91LXmOiWd+RCfJTU81
   RwdQm89ktDw6hjikL8fd8ExaX/eb6t+yakeo/2WtRhz0lFRAxKhKeS2XA
   e+3NwWDAPqji1RrQWIb62RBwJgBPdPnufu7ep8urSY1rDkAgit9yIEpHi
   uI6ejZIVH1OPi4uqy+Z03oLSzJxPHZSeTIfh4eVqZIrdyLx9QxWevBdHh
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="259699864"
X-IronPort-AV: E=Sophos;i="5.91,305,1647327600"; 
   d="scan'208";a="259699864"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 05:33:38 -0700
X-IronPort-AV: E=Sophos;i="5.91,305,1647327600"; 
   d="scan'208";a="674999504"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 05:33:34 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 16 Jun 2022 15:33:31 +0300
Date:   Thu, 16 Jun 2022 15:33:31 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Oleksandr Ocheretnyi <oocheret@cisco.com>
Cc:     tudor.ambarus@microchip.com, miquel.raynal@bootlin.com,
        p.yadav@ti.com, michael@walle.cc, richard@nod.at, vigneshr@ti.com,
        broonie@kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, mauro.lima@eclypsium.com,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        xe-linux-external@cisco.com
Subject: Re: [PATCH v2] mtd: spi-nor: handle unsupported FSR opcodes properly
Message-ID: <YqsjGx54+Gd8Aws/@lahna>
References: <YqsHcL5NPcZ4De77@lahna>
 <20220616121446.293408-1-oocheret@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616121446.293408-1-oocheret@cisco.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 05:14:45AM -0700, Oleksandr Ocheretnyi wrote:
> Originally commit 094d3b9 ("mtd: spi-nor: Add USE_FSR flag for n25q*
> entries") and following one 8f93826 ("mtd: spi-nor: micron-st: convert
> USE_FSR to a manufacturer flag") enabled SPINOR_OP_RDFSR opcode handling
> ability, however some controller drivers still cannot handle it properly
> in the micron_st_nor_ready() call what breaks some mtd callbacks with
> next error logs:
> 
> mtdblock: erase of region [address1, size1] on "BIOS" failed
> mtdblock: erase of region [address2, size2] on "BIOS" failed
> 
> The Intel SPI controller does not support low level operations, like
> reading the flag status register (FSR). It only exposes a set of high
> level operations for software to use. For this reason check the return
> value of micron_st_nor_read_fsr() and if the operation was not
> supported, use the status register value only. This allows the chip to
> work even when attached to Intel SPI controller (there are such systems
> out there).
> 
> Signed-off-by: Oleksandr Ocheretnyi <oocheret@cisco.com>
> Link: https://lore.kernel.org/lkml/YmZUCIE%2FND82BlNh@lahna/
> ---
>  PATCH v2 updates PATCH v1 taking into account changes from
>  https://lore.kernel.org/linux-mtd/20220506105158.43613-1-mika.westerberg@linux.intel.com
>  to check -EOPNOTSUPP value from micron_st_nor_read_fsr() as well.
> 
>  drivers/mtd/spi-nor/micron-st.c | 12 ++++++++++--
>  drivers/spi/spi-intel.c         |  3 ++-
>  2 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
> index a96f74e0f568..fd52e8feea44 100644
> --- a/drivers/mtd/spi-nor/micron-st.c
> +++ b/drivers/mtd/spi-nor/micron-st.c
> @@ -399,8 +399,16 @@ static int micron_st_nor_ready(struct spi_nor *nor)
>  		return sr_ready;
>  
>  	ret = micron_st_nor_read_fsr(nor, nor->bouncebuf);
> -	if (ret)
> -		return ret;
> +	if (ret < 0) {
> +		/*
> +		 * Some controllers, such as Intel SPI, do not support low
> +		 * level operations such as reading the flag status
> +		 * register. They only expose small amount of high level
> +		 * operations to the software. If this is the case we use
> +		 * only the status register value.
> +		 */
> +		return (ret == -ENOTSUPP || ret == -EOPNOTSUPP) ? sr_ready : ret;

The -EOPNOTSUPP here is not needed as you change the Intel SPI driver in
the below.

> +	}
>  
>  	if (nor->bouncebuf[0] & (FSR_E_ERR | FSR_P_ERR)) {
>  		if (nor->bouncebuf[0] & FSR_E_ERR)
> diff --git a/drivers/spi/spi-intel.c b/drivers/spi/spi-intel.c
> index 50f42983b950..f0313a718d1b 100644
> --- a/drivers/spi/spi-intel.c
> +++ b/drivers/spi/spi-intel.c
> @@ -352,7 +352,8 @@ static int intel_spi_hw_cycle(struct intel_spi *ispi, u8 opcode, size_t len)
>  		val |= HSFSTS_CTL_FCYCLE_RDSR;
>  		break;
>  	default:
> -		return -EINVAL;
> +		dev_dbg(ispi->dev, "%#x not supported\n", opcode);
> +		return -ENOTSUPP;
>  	}
>  
>  	if (len > INTEL_SPI_FIFO_SZ)
> -- 
> 2.27.0
