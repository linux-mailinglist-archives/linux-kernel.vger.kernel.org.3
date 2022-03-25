Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C983A4E73AF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 13:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359160AbiCYMpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 08:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243507AbiCYMo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 08:44:58 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552AA4ECF1;
        Fri, 25 Mar 2022 05:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648212203; x=1679748203;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=VaeaGhex6shcMYfaLH/E7RKSbb3O3jheJPitTeTJ9iE=;
  b=XMpddZ8GW4kVapx/a64twviRsgoYIa4m7B0JGFLPxmZ311MByKYr5rkB
   fIttvGr/fh9RJUy+IqfmN0yDoZbYqb54plD+79LNqBOYZQb8GuCQdwxo7
   DMWtBTHdsGYcTIusAAZw42c3tEQa/t8U3DTDrDJpFPo7uWh9hy/Rzjfwj
   6Mla00bbkNJJHOga9j1aeiWiury5egOkiGkmnhbzgkLL7JaClXcJGya5M
   IWwcj9Bi2sRR4vhoSKtPl4KXMpwPqDvhpMSNlMfc/dGFrslf92bmwjNfU
   KMmfKQUdWyBlUf+b42neVJCTGSpe+5ujUEbS8pSTp0hCIxxk2obMWfNWs
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="238565533"
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="238565533"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 05:43:09 -0700
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="718198523"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 05:43:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nXjGy-006OiI-8k;
        Fri, 25 Mar 2022 14:42:32 +0200
Date:   Fri, 25 Mar 2022 14:42:32 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Christian =?iso-8859-1?Q?L=F6hle?= <CLoehle@hyperstone.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCHv5] mmc: block: Check for errors after write on SPI
Message-ID: <Yj24uOLsosD8evp3@smile.fi.intel.com>
References: <76f6f5d2b35543bab3dfe438f268609c@hyperstone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76f6f5d2b35543bab3dfe438f268609c@hyperstone.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 02:18:41PM +0000, Christian Löhle wrote:
> Introduce a SEND_STATUS check for writes through SPI to not mark
> an unsuccessful write as successful.
> 
> Since SPI SD/MMC does not have states, after a write, the card will
> just hold the line LOW until it is ready again. The driver marks the
> write therefore as completed as soon as it reads something other than
> all zeroes.
> The driver does not distinguish from a card no longer signalling busy
> and it being disconnected (and the line being pulled-up by the host).
> This lead to writes being marked as successful when disconnecting
> a busy card.
> Now the card is ensured to be still connected by an additional CMD13,
> just like non-SPI is ensured to go back to TRAN state.
> 
> While at it and since we already poll for the post-write status anyway,
> we might as well check for SPIs error bits (any of them).
> 
> The disconnecting card problem is reproducable for me after continuous
> write activity and randomly disconnecting, around every 20-50 tries
> on SPI DS for some card.

LGTM, FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: 7213d175e3b6f ("MMC/SD card driver learns SPI")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> ---
> v2:
>   - Reorder err and status check for err to take precedence and look cleaner
> v3:
>   - Move the logic into its own function
> v4:
>   - Move block layer handling out of the spi-specific function
> v5:
>   - reorder err and status check
> 
>  drivers/mmc/core/block.c | 34 +++++++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 4e67c1403cc9..be2078684417 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1880,6 +1880,31 @@ static inline bool mmc_blk_rq_error(struct mmc_blk_request *brq)
>  	       brq->data.error || brq->cmd.resp[0] & CMD_ERRORS;
>  }
> 
> +static int mmc_spi_err_check(struct mmc_card *card)
> +{
> +	u32 status = 0;
> +	int err;
> +
> +	/*
> +	 * SPI does not have a TRAN state we have to wait on, instead the
> +	 * card is ready again when it no longer holds the line LOW.
> +	 * We still have to ensure two things here before we know the write
> +	 * was successful:
> +	 * 1. The card has not disconnected during busy and we actually read our
> +	 * own pull-up, thinking it was still connected, so ensure it
> +	 * still responds.
> +	 * 2. Check for any error bits, in particular R1_SPI_IDLE to catch a
> +	 * just reconnected card after being disconnected during busy.
> +	 */
> +	err = __mmc_send_status(card, &status, 0);
> +	if (err)
> +		return err;
> +	/* All R1 and R2 bits of SPI are errors in our case */
> +	if (status)
> +		return -EIO;
> +	return 0;
> +}
> +
>  static int mmc_blk_busy_cb(void *cb_data, bool *busy)
>  {
>  	struct mmc_blk_busy_data *data = cb_data;
> @@ -1903,9 +1928,16 @@ static int mmc_blk_card_busy(struct mmc_card *card, struct request *req)
>  	struct mmc_blk_busy_data cb_data;
>  	int err;
> 
> -	if (mmc_host_is_spi(card->host) || rq_data_dir(req) == READ)
> +	if (rq_data_dir(req) == READ)
>  		return 0;
> 
> +	if (mmc_host_is_spi(card->host)) {
> +		err = mmc_spi_err_check(card);
> +		if (err)
> +			mqrq->brq.data.bytes_xfered = 0;
> +		return err;
> +	}
> +
>  	cb_data.card = card;
>  	cb_data.status = 0;
>  	err = __mmc_poll_for_busy(card->host, 0, MMC_BLK_TIMEOUT_MS,
> --
> 2.34.1
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
> Managing Director: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782
> 

-- 
With Best Regards,
Andy Shevchenko


