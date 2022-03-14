Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40484D7B04
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 07:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236462AbiCNGza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 02:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236459AbiCNGz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 02:55:29 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44F03FBEB;
        Sun, 13 Mar 2022 23:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647240859; x=1678776859;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=G2DCdxLq8aLFbacaZLu5cAmAlvO2Vs7dvCYi5y0Hm24=;
  b=Ok3Gg6C7bFPdbh+LuqUAJr55B8rWb3GIbRp5zqLLcxk578fHddHaQVFg
   F1+X+dij5kMvU915Zm2ber7Ep6J07KZZ6MMydLW0tGVUDAalZPWCR87qH
   xP8wleFlD8FjqzXGy45qcDACZDgP/3nMrq61F4k9PjAEllyg3IwG6/1Xf
   K5zOSnAEpEsodsCJ1ACG6sG5xARMBVDnY6Zw6Y0D+g6qlLHeTBm3JfE1r
   MuUUYGS/9vHw4Inn3v/HX0/Af2R1lhd021KpW0wl0bKU+/VG2QIK1h14j
   8pd2wDxX3Jeov4qOdUCdy2Ht7oR+miFtWfXpxwpXPwuuTwMkUvdMj8S9W
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="319176545"
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400"; 
   d="scan'208";a="319176545"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 23:54:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400"; 
   d="scan'208";a="580008248"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.92]) ([10.237.72.92])
  by orsmga001.jf.intel.com with ESMTP; 13 Mar 2022 23:54:12 -0700
Message-ID: <83edf9a1-1712-5388-a3fa-d685f1f581df@intel.com>
Date:   Mon, 14 Mar 2022 08:54:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH] mmc: block: enable cache-flushing when mmc cache is on
Content-Language: en-US
To:     Michael Wu <michael@allwinnertech.com>, ulf.hansson@linaro.org,
        avri.altman@wdc.com, beanhuo@micron.com, porzio@gmail.com
Cc:     lixiang <lixiang@allwinnertech.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220312044315.7994-1-michael@allwinnertech.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220312044315.7994-1-michael@allwinnertech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2022 06:43, Michael Wu wrote:
> The mmc core enable cache on default. But it only enables cache-flushing
> when host supports cmd23 and eMMC supports reliable write.
> For hosts which do not support cmd23 or eMMCs which do not support
> reliable write, the cache can not be flushed by `sync` command.
> This may leads to cache data lost.
> This patch enables cache-flushing as long as cache is enabled, no
> matter host supports cmd23 and/or eMMC supports reliable write or not.
> 

Fixes tag?

> Signed-off-by: Michael Wu <michael@allwinnertech.com>
> ---
>  drivers/mmc/core/block.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 689eb9afeeed..1e508c079c1e 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2279,6 +2279,8 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>  	struct mmc_blk_data *md;
>  	int devidx, ret;
>  	char cap_str[10];
> +	bool enable_cache = false;
> +	bool enable_fua = false;
>  
>  	devidx = ida_simple_get(&mmc_blk_ida, 0, max_devices, GFP_KERNEL);
>  	if (devidx < 0) {
> @@ -2375,12 +2377,18 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>  			md->flags |= MMC_BLK_CMD23;
>  	}
>  
> -	if (mmc_card_mmc(card) &&
> -	    md->flags & MMC_BLK_CMD23 &&
> -	    ((card->ext_csd.rel_param & EXT_CSD_WR_REL_PARAM_EN) ||
> -	     card->ext_csd.rel_sectors)) {
> -		md->flags |= MMC_BLK_REL_WR;
> -		blk_queue_write_cache(md->queue.queue, true, true);
> +	if (mmc_card_mmc(card)) {
> +		if (md->flags & MMC_BLK_CMD23 &&
> +			((card->ext_csd.rel_param & EXT_CSD_WR_REL_PARAM_EN) ||
> +			card->ext_csd.rel_sectors)) {
> +			md->flags |= MMC_BLK_REL_WR;
> +			enable_fua = true;
> +		}
> +
> +		if (mmc_cache_enabled(card->host))
> +			enable_cache = true;
> +
> +		blk_queue_write_cache(md->queue.queue, enable_cache, enable_fua);
>  	}

Seems like we should inform block layer about SD card cache also

>  
>  	string_get_size((u64)size, 512, STRING_UNITS_2,

