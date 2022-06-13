Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29F4547F72
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 08:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234380AbiFMGTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 02:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbiFMGS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 02:18:57 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C351219F93;
        Sun, 12 Jun 2022 23:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655101119; x=1686637119;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RI6qAwFkvyfDJbNSty7ikmbQQ/e8na613HjB1kmUOqU=;
  b=WeXnuC3UbWR6a+8d+HiMBnio2FQ80b9Nk+futyypGOcq5XOqaRyl8ooo
   QaLBofjKD0MA5VWOqB74N/yXv91qlE6pjf4cl7Yf33A5VjMcywREtQfIF
   1HABdlVG58jAOkaLPa0DIQuZAITJdGFDheHV1m5Z3bp1fByT+FgdyixmA
   F19f9RioFSBxX9PuWcKDBBkEQ54k8M83ziN36Mc4PltEY8AwpSdFmXh/t
   HG/pQfdc4NiFYlfQy9wfvzbcackkKNQs0OdB3ma7on99tMEo1Mhupj36/
   Vn5bnC2kkkQ8m+23OpO5a32vmQ6/Oz0I7rdhEq0qPmQ1lLayCo+bBLPFX
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10376"; a="364508178"
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="364508178"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2022 23:18:39 -0700
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="673098050"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2022 23:18:34 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 13 Jun 2022 09:18:31 +0300
Date:   Mon, 13 Jun 2022 09:18:31 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Oleksandr Ocheretnyi <oocheret@cisco.com>
Cc:     tudor.ambarus@microchip.com, miquel.raynal@bootlin.com,
        p.yadav@ti.com, michael@walle.cc, richard@nod.at, vigneshr@ti.com,
        broonie@kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, mauro.lima@eclypsium.com,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        xe-linux-external@cisco.com
Subject: Re: [PATCH] mtd: spi-nor: handle unsupported FSR opcodes properly
Message-ID: <YqbWt9f3of+7Z76e@lahna>
References: <YmZUCIE/ND82BlNh@lahna>
 <20220610191548.3626218-1-oocheret@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610191548.3626218-1-oocheret@cisco.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 10, 2022 at 12:15:48PM -0700, Oleksandr Ocheretnyi wrote:
> Commit 094d3b9 ("mtd: spi-nor: Add USE_FSR flag for n25q* entries")
> and following one 8f93826 ("mtd: spi-nor: micron-st: convert USE_FSR
> to a manufacturer flag") enables SPINOR_OP_RDFSR opcode handling ability,
> however some controller drivers still cannot handle it properly in
> the micron_st_nor_ready() call what breaks some mtd callbacks with
> next error logs:
> 
> mtdblock: erase of region [address1, size1] on "BIOS" failed
> mtdblock: erase of region [address2, size2] on "BIOS" failed
> 
> Just skip subsequent processing of the SPINOR_OP_RDFSR opcode's results
> because of -ENOTSUPP return value of the micron_st_nor_read_fsr()
> if there is no proper handling of that opcode as it's been before
> commit 094d3b9 ("mtd: spi-nor: Add USE_FSR flag for n25q* entries")
> 
> Signed-off-by: Oleksandr Ocheretnyi <oocheret@cisco.com>

I sent similar patch some time ago here:

https://lore.kernel.org/linux-mtd/20220506105158.43613-1-mika.westerberg@linux.intel.com/#t

but so far it has not been picked up by the maintainers. I'm fine if we
go with your patch instead, just one minor comment:

> ---
>  drivers/mtd/spi-nor/micron-st.c | 6 +++++-
>  drivers/spi/spi-intel.c         | 3 ++-
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
> index a96f74e0f568..507e675d81e0 100644
> --- a/drivers/mtd/spi-nor/micron-st.c
> +++ b/drivers/mtd/spi-nor/micron-st.c
> @@ -399,8 +399,12 @@ static int micron_st_nor_ready(struct spi_nor *nor)
>  		return sr_ready;
>  
>  	ret = micron_st_nor_read_fsr(nor, nor->bouncebuf);
> -	if (ret)
> +	if (ret < 0) {
> +		/* Check if read FSR is supported. If not, skip it. */
> +		if (ret == -ENOTSUPP)
> +			return sr_ready;
>  		return ret;
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

I don't think this is necessary because we already return -EOPNOTSUPP in
intel_spi_exec_mem_op() so we can just check that one in
micron_st_nor_ready().

With that changed feel free to add my,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
