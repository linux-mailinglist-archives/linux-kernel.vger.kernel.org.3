Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B8557EC87
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 09:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237104AbiGWHnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 03:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237004AbiGWHnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 03:43:04 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4225E4F18C;
        Sat, 23 Jul 2022 00:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658562184; x=1690098184;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=qUq+H1frG1Bumibkq8JeFlN8w10jAIu+y1VymbrL+Os=;
  b=K9c+lJzr13tlefzSxd4swnVg1rYLFA+cvM7SbAstxFfV2gSg4H/ekuzh
   93MATC5ZWKzyFaEz5tVnrpPMeyYFYI9mgf4bTZwk2dAYkVxygMGeiBejy
   3/RVLrcBxGMSFM4kr6OYPMWmGQ3BG2g+LQlF6qVthAd/Z8jjBZRx3spQT
   mfXLSxHRE8VYejSlQQe8B6bzLa7L/CjMaDOiMhkkNFoZweN1MCTaKczR7
   w69Nyp80gBL34KihmMpZwXM+yDeLbAFifJwgpaVf+PfH51F8uSIHOqBa2
   2b0eelnXQL0FaTnp7gUuO0HYUb4w0f81OVQ30cvQlP1OyYGdv2j2P33nr
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10416"; a="267845768"
X-IronPort-AV: E=Sophos;i="5.93,187,1654585200"; 
   d="scan'208";a="267845768"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2022 00:43:03 -0700
X-IronPort-AV: E=Sophos;i="5.93,187,1654585200"; 
   d="scan'208";a="657493472"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.55.193])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2022 00:43:01 -0700
Message-ID: <992cc198-6c7c-977a-1af8-56665e939cc9@intel.com>
Date:   Sat, 23 Jul 2022 10:42:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] mmc: block: Dont report successful writes with errors
Content-Language: en-US
To:     Christian Loehle <CLoehle@hyperstone.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Avri Altman <Avri.Altman@wdc.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <ca06b94aa48a484d965744e64e17a4ef@hyperstone.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <ca06b94aa48a484d965744e64e17a4ef@hyperstone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/22 18:34, Christian Loehle wrote:
> Be as conservative about successful write reporting to the
> block layer for SPI as with normal SD and MMC.
> That means on any errors bytes_xfered is ignored and the
> whole write must be repeated.
> 
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> ---
>  drivers/mmc/core/block.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index f4a1281658db..63d1c05582a9 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1765,8 +1765,12 @@ static bool mmc_blk_status_error(struct request *req, u32 status)
>  	struct mmc_queue *mq = req->q->queuedata;
>  	u32 stop_err_bits;
>  
> +	/*
> +	 * Either write timed out during busy and data->error is set
> +	 * or we actually received a valid R2 and check for error bits.
> +	 */
>  	if (mmc_host_is_spi(mq->card->host))
> -		return false;
> +		return brq->data.error || !!status;

This function is for checking status, so brq->data.error does not
belong here.  Also it would be more readable to use a define e.g.

		return status & SPI_R2_ERRORS;

I think clearing bytes_xfered for SPI brq->data.error should be a
separate patch, and you would need to explain a bit more for that
case too.

>  
>  	stop_err_bits = mmc_blk_stop_err_bits(brq);
>  

