Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2783C4E545B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 15:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244761AbiCWOjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 10:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbiCWOjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 10:39:19 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F50E7CDE8;
        Wed, 23 Mar 2022 07:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648046269; x=1679582269;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=qv2sPx6zB4xaL7h6TqKidl8/bFWiEudh02hJa+vu600=;
  b=feb+I/5xD9dJ5lOOMJuAbDABd15GelEQiNpJ41wSFyaWgZtuSq6055N1
   5C7XSXq3hYiQUyvVQYBBLCdX72kMTDA4mJ8kV0SD4OF9tFQBlS/zcLp6m
   o0JlwsC79HdGpGrCzVjmbvQET8oWY30TdrhZVBnZdB+/C+i+EsZz/QTtF
   Hhc2H0jmiXHa8iG11EOZo/JcQiRrio4i9wSTtT5k5iIGXRtx+QgJKDQ3O
   g/YAxbZ0Pkt/GsGL3itEwdSQmw5AMEdetcytZQYRDhXJrRDor0aio8kMO
   y2004lkY/2J9iu242D4bqj1NYMwUpYTw8H/E1CcdnjEd9s33AoOd+nH3X
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="257838138"
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; 
   d="scan'208";a="257838138"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 07:37:49 -0700
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; 
   d="scan'208";a="717419023"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 07:37:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nX26o-005Br2-AY;
        Wed, 23 Mar 2022 16:37:10 +0200
Date:   Wed, 23 Mar 2022 16:37:09 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Christian =?iso-8859-1?Q?L=F6hle?= <CLoehle@hyperstone.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "cloehle@posteo.de" <cloehle@posteo.de>,
        Avri Altman <Avri.Altman@wdc.com>,
        "david-b@pacbell.net" <david-b@pacbell.net>
Subject: Re: [PATCHv2] mmc: block: Check for errors after write on SPI
Message-ID: <YjswlWK+pPaQddvh@smile.fi.intel.com>
References: <9d1ea819e4bb4222a227a02d5f6ad97c@hyperstone.com>
 <cf04ac31665c48be9f275ed21332763b@hyperstone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cf04ac31665c48be9f275ed21332763b@hyperstone.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 02:12:43PM +0000, Christian Löhle wrote:
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

(Next time send a new version of the patch as a separate email thread,
 so tools won't mess with the different versions in one thread. I hope
 no need for resend this time and Ulf handles this)

> Fixes: 7213d175e3b6f ("MMC/SD card driver learns SPI")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> ---
> v2:
>   - Reorder err and status check for err to take precedence and look cleaner
> 
>  drivers/mmc/core/block.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 4e67c1403cc9..54c2009f398f 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1903,9 +1903,34 @@ static int mmc_blk_card_busy(struct mmc_card *card, struct request *req)
>  	struct mmc_blk_busy_data cb_data;
>  	int err;
> 
> -	if (mmc_host_is_spi(card->host) || rq_data_dir(req) == READ)
> +	if (rq_data_dir(req) == READ)
>  		return 0;
> 
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
> +	if (mmc_host_is_spi(card->host)) {
> +		u32 status = 0;
> +
> +		err = __mmc_send_status(card, &status, 0);
> +		/* All R1 and R2 bits of SPI are errors in our case */
> +		if (err || status) {
> +			mqrq->brq.data.bytes_xfered = 0;
> +			if (err)
> +				return err;
> +			return -EIO;
> +		}
> +		return 0;
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


