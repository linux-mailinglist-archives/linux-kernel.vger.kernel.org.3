Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD254D85C9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 14:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241525AbiCNNOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 09:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237179AbiCNNOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 09:14:32 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25F1FD25;
        Mon, 14 Mar 2022 06:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647263602; x=1678799602;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PZa4Z/AnozBB1/b7y4Pc4aEBj3nvFtO2eJ4umuQ0508=;
  b=Z6Wz0W9vSK6xcKDbfyPFxJfb2HF1uNL4RaLCH8gODRJm2GYn2OyPDUuv
   pHf6PEHjz6yI1fi1HjFthYDmQ8ZdArKj+DvqpRR75FJdmKsCaMYGRGzXF
   cGg1WjLg1LoWDKgU6qtZkZVEazAXDpYzOMHaOHHXQSf0hYcQbD4BHpFvV
   lgv6ns2sJLU6z/zEgAVDzXPOl79EtFJj2obHOi7k0Z1fKAZQtiWdySJyc
   obuh89WqFoNwq0p5es1KP8zj67JruC5J4LK8v96wpjhdkRYXbv1XOZTnf
   9NTigYueu3j5C88GzmE8J9NygpoHlCYcBspsAAeFBF91D+2tt9SFSm3mE
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="256209204"
X-IronPort-AV: E=Sophos;i="5.90,180,1643702400"; 
   d="scan'208";a="256209204"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 06:11:48 -0700
X-IronPort-AV: E=Sophos;i="5.90,180,1643702400"; 
   d="scan'208";a="556413166"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.53.145])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 06:11:45 -0700
Message-ID: <50d4b87c-003f-818a-c8ba-a3bac9c0f171@intel.com>
Date:   Mon, 14 Mar 2022 15:11:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH] mmc: core: Set HS clock speed before sending HS CMD13
Content-Language: en-US
To:     Brian Norris <briannorris@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc@vger.kernel.org
References: <20220310125636.1.I484f4ee35609f78b932bd50feed639c29e64997e@changeid>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220310125636.1.I484f4ee35609f78b932bd50feed639c29e64997e@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.3.2022 22.56, Brian Norris wrote:
> Way back in commit 4f25580fb84d ("mmc: core: changes frequency to
> hs_max_dtr when selecting hs400es"), Rockchip engineers noticed that
> some eMMC don't respond to SEND_STATUS commands very reliably if they're
> still running at a low initial frequency. As mentioned in that commit,
> JESD84-B51 P49 suggests a sequence in which the host:
> 1. sets HS_TIMING
> 2. bumps the clock ("<= 52 MHz")
> 3. sends further commands
> 
> It doesn't exactly require that we don't use a lower-than-52MHz
> frequency, but in practice, these eMMC don't like it.
> 
> Anyway, the aforementioned commit got that right for HS400ES, but the
> refactoring in 53e60650f74e ("mmc: core: Allow CMD13 polling when
> switching to HS mode for mmc") messed that back up again, by reordering
> step 2 after step 3.

That description might not be accurate.

It looks like 4f25580fb84d did not have the intended effect because
CMD13 was already being sent by mmc_select_hs(), still before increasing
the frequency.  53e60650f74e just kept that behaviour.

> 
> Let's fix that, and also apply the same logic to HS200/400, where this
> eMMC has problems too.
> 
> This resolves errors like this seen when booting some RK3399 Gru/Scarlet
> systems:
> 
> [    2.058881] mmc1: CQHCI version 5.10
> [    2.097545] mmc1: SDHCI controller on fe330000.mmc [fe330000.mmc] using ADMA
> [    2.209804] mmc1: mmc_select_hs400es failed, error -84
> [    2.215597] mmc1: error -84 whilst initialising MMC card
> [    2.417514] mmc1: mmc_select_hs400es failed, error -110
> [    2.423373] mmc1: error -110 whilst initialising MMC card
> [    2.605052] mmc1: mmc_select_hs400es failed, error -110
> [    2.617944] mmc1: error -110 whilst initialising MMC card
> [    2.835884] mmc1: mmc_select_hs400es failed, error -110
> [    2.841751] mmc1: error -110 whilst initialising MMC card
> 
> Fixes: 53e60650f74e ("mmc: core: Allow CMD13 polling when switching to HS mode for mmc")
> Cc: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> 
>  drivers/mmc/core/mmc.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 13abfcd130a5..821b90caba2f 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1390,12 +1390,17 @@ static int mmc_select_hs400es(struct mmc_card *card)
>  	}
>  
>  	mmc_set_timing(host, MMC_TIMING_MMC_HS);
> +
> +	/*
> +	 * Bump to HS frequency. Some cards don't handle SEND_STATUS reliably
> +	 * at the initial frequency.
> +	 */
> +	mmc_set_clock(host, card->ext_csd.hs_max_dtr);
> +
>  	err = mmc_switch_status(card, true);
>  	if (err)
>  		goto out_err;
>  
> -	mmc_set_clock(host, card->ext_csd.hs_max_dtr);
> -
>  	/* Switch card to DDR with strobe bit */
>  	val = EXT_CSD_DDR_BUS_WIDTH_8 | EXT_CSD_BUS_WIDTH_STROBE;
>  	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> @@ -1487,6 +1492,12 @@ static int mmc_select_hs200(struct mmc_card *card)
>  		old_timing = host->ios.timing;
>  		mmc_set_timing(host, MMC_TIMING_MMC_HS200);
>  
> +		/*
> +		 * Bump to HS frequency. Some cards don't handle SEND_STATUS
> +		 * reliably at the initial frequency.
> +		 */
> +		mmc_set_clock(host, card->ext_csd.hs_max_dtr);

Is card->ext_csd.hs_max_dtr better than card->ext_csd.hs200_max_dtr here?

> +
>  		/*
>  		 * For HS200, CRC errors are not a reliable way to know the
>  		 * switch failed. If there really is a problem, we would expect

