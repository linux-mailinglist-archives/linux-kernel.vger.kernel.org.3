Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CC5508042
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 06:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359327AbiDTEsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 00:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359324AbiDTEsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 00:48:09 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6366022BFC;
        Tue, 19 Apr 2022 21:45:24 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23K4jFiD068326;
        Tue, 19 Apr 2022 23:45:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650429915;
        bh=yoUJcGH7XjeMYUSfVQBkbwHE7wXqfLs5bUxZT4pWJw8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=PYToANBoBdOP9EHcr3k3y4WAflpKOsSc6WJqk+KZ+21fGfc/dC+4FVU0E+OvxR2Jd
         iNPws0Eu1cpp/ixn9XOn06lN9t0JMk745XZkndWg5GFj9xcMY98x6G5qHmDGCYzoye
         TqqBSyGGL820i16GORH2X5lgK3kjr9eRzqcXbqyc=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23K4jFsw048662
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Apr 2022 23:45:15 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 19
 Apr 2022 23:45:14 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 19 Apr 2022 23:45:15 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23K4jEcw015303;
        Tue, 19 Apr 2022 23:45:14 -0500
Date:   Wed, 20 Apr 2022 10:15:13 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
CC:     Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] spi: cadence-quadspi: further simplify
 cqspi_set_protocol()
Message-ID: <20220420044513.y7i7k3cxypxwlk7n@ti.com>
References: <20220419084640.191299-1-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220419084640.191299-1-matthias.schiffer@ew.tq-group.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 19/04/22 10:46AM, Matthias Schiffer wrote:
> - Remove checks for unsupported modes that are already handled by
>   supports_op(). This allows to change the function to return void.
> - Distinguishing DTR and non-DTR modes is not necessary for the setup of
>   the bus widths
> - Only cmd DTR flag needs to be checked, supports_op() already checks
>   that the DTR flags of all relevant parts of the op match
> - Check nbytes instead of buswidth for 0, for consistency with
>   supports_op() etc.
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>  drivers/spi/spi-cadence-quadspi.c | 73 +++++--------------------------
>  1 file changed, 10 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
> index 19686fb47bb3..96d14f3847b5 100644
> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -368,58 +368,13 @@ static unsigned int cqspi_calc_dummy(const struct spi_mem_op *op, bool dtr)
>  	return dummy_clk;
>  }
>  
> -static int cqspi_set_protocol(struct cqspi_flash_pdata *f_pdata,
> -			      const struct spi_mem_op *op)
> +static void cqspi_set_protocol(struct cqspi_flash_pdata *f_pdata,
> +			       const struct spi_mem_op *op)
>  {
> -	/*
> -	 * For an op to be DTR, cmd phase along with every other non-empty
> -	 * phase should have dtr field set to 1. If an op phase has zero
> -	 * nbytes, ignore its dtr field; otherwise, check its dtr field.
> -	 */
> -	f_pdata->dtr = op->cmd.dtr &&
> -		       (!op->addr.nbytes || op->addr.dtr) &&
> -		       (!op->data.nbytes || op->data.dtr);
> -
> -	f_pdata->inst_width = 0;
> -	if (op->cmd.buswidth)
> -		f_pdata->inst_width = ilog2(op->cmd.buswidth);
> -
> -	f_pdata->addr_width = 0;
> -	if (op->addr.buswidth)
> -		f_pdata->addr_width = ilog2(op->addr.buswidth);
> -
> -	f_pdata->data_width = 0;
> -	if (op->data.buswidth)
> -		f_pdata->data_width = ilog2(op->data.buswidth);
> -
> -	/* Right now we only support 8-8-8 DTR mode. */
> -	if (f_pdata->dtr) {
> -		switch (op->cmd.buswidth) {
> -		case 0:
> -		case 8:
> -			break;
> -		default:
> -			return -EINVAL;
> -		}
> -
> -		switch (op->addr.buswidth) {
> -		case 0:
> -		case 8:
> -			break;
> -		default:
> -			return -EINVAL;
> -		}
> -
> -		switch (op->data.buswidth) {
> -		case 0:
> -		case 8:
> -			break;
> -		default:
> -			return -EINVAL;
> -		}
> -	}
> -
> -	return 0;
> +	f_pdata->inst_width = op->cmd.nbytes ? ilog2(op->cmd.buswidth) : 0;
> +	f_pdata->addr_width = op->addr.nbytes ? ilog2(op->addr.buswidth) : 0;
> +	f_pdata->data_width = op->data.nbytes ? ilog2(op->data.buswidth) : 0;
> +	f_pdata->dtr = op->cmd.dtr;

I would suggest getting rid of these 4 entirely. It seems like 
unnecessary bit of state to carry around when we can get this 
information directly from the op. And it is not like these are re-used 
in lots of places or are particularly complicated to calculate. There 
are only a small number of uses for these, for which we can directly get 
the values by looking at the op. That way we get rid of 
cqspi_set_protocol() entirely and reduce a bit of complexity.

>  }
>  
>  static int cqspi_wait_idle(struct cqspi_st *cqspi)
> @@ -549,9 +504,7 @@ static int cqspi_command_read(struct cqspi_flash_pdata *f_pdata,
>  	size_t read_len;
>  	int status;
>  
> -	status = cqspi_set_protocol(f_pdata, op);
> -	if (status)
> -		return status;
> +	cqspi_set_protocol(f_pdata, op);
>  
>  	status = cqspi_enable_dtr(f_pdata, op, CQSPI_REG_OP_EXT_STIG_LSB,
>  				  f_pdata->dtr);
> @@ -622,9 +575,7 @@ static int cqspi_command_write(struct cqspi_flash_pdata *f_pdata,
>  	size_t write_len;
>  	int ret;
>  
> -	ret = cqspi_set_protocol(f_pdata, op);
> -	if (ret)
> -		return ret;
> +	cqspi_set_protocol(f_pdata, op);
>  
>  	ret = cqspi_enable_dtr(f_pdata, op, CQSPI_REG_OP_EXT_STIG_LSB,
>  			       f_pdata->dtr);
> @@ -1244,9 +1195,7 @@ static ssize_t cqspi_write(struct cqspi_flash_pdata *f_pdata,
>  	const u_char *buf = op->data.buf.out;
>  	int ret;
>  
> -	ret = cqspi_set_protocol(f_pdata, op);
> -	if (ret)
> -		return ret;
> +	cqspi_set_protocol(f_pdata, op);
>  
>  	ret = cqspi_write_setup(f_pdata, op);
>  	if (ret)
> @@ -1348,9 +1297,7 @@ static ssize_t cqspi_read(struct cqspi_flash_pdata *f_pdata,
>  	int ret;
>  
>  	ddata = of_device_get_match_data(dev);
> -	ret = cqspi_set_protocol(f_pdata, op);
> -	if (ret)
> -		return ret;
> +	cqspi_set_protocol(f_pdata, op);
>  
>  	ret = cqspi_read_setup(f_pdata, op);
>  	if (ret)
> -- 
> 2.25.1
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
