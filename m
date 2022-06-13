Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FB054803D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 09:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239144AbiFMHOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 03:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239305AbiFMHOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 03:14:18 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD451A3A6;
        Mon, 13 Jun 2022 00:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655104457; x=1686640457;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wvl/B4oq3q+IXNEFYXE9Z2uZbSwi0g50OFlczbgIglM=;
  b=GaXj+bO3X8cjT8yYIyMQcjSzBxupw+qwQ+zBiWfLjfVA5vP8J1FfOeaT
   WL85qviOcLHGw15H5pzoEz6zrM/ep9dmcRNa8M85l6xzYClNKSt57PI5U
   O8xGs+1vCNaiafarHsv6GtWFVCpS372zhOxF/b7i+l9rRFqhcvdmsiJ2M
   h3PWI7ZxIxSIyCk7+VY38pi69Wyfrstqp/yEnicP1Jv0t1Njg0r9t+Q3j
   Y5hfFiEvm9FzqvFVOwV1/SRids14hdmDJfNxzF5EmTLtGQdCzVwFlVTfA
   Sdo8yeAb5ikDcv7s43B3swXxl/0Dn8Ak9qqZNCmY+0s98GzV+IHjEdlnh
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10376"; a="303586783"
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="303586783"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 00:14:16 -0700
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="639571875"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.58.193])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 00:14:14 -0700
Message-ID: <f4fd942e-2bc8-b70b-d8ec-56690750efbb@intel.com>
Date:   Mon, 13 Jun 2022 10:14:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH 5/5] mmc: sdhci-st: Obviously always return success in
 remove callback
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     kernel@pengutronix.de, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220610211257.102071-1-u.kleine-koenig@pengutronix.de>
 <20220610211257.102071-5-u.kleine-koenig@pengutronix.de>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220610211257.102071-5-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/22 00:12, Uwe Kleine-König wrote:
> sdhci_pltfm_unregister() returns 0 unconditionally and returning an
> error in a platform remove callback isn't very sensible. (The only
> effect of the latter is that the device core emits a generic warning and
> then removes the device anyhow.)
> 
> So return 0 unconditionally to make it obvious there is no error
> forwarded to the upper layers.
> 
> This is a preparation for making platform remove callbacks return void.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-st.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-st.c b/drivers/mmc/host/sdhci-st.c
> index d41582c21aa3..6415916fbd91 100644
> --- a/drivers/mmc/host/sdhci-st.c
> +++ b/drivers/mmc/host/sdhci-st.c
> @@ -440,15 +440,14 @@ static int sdhci_st_remove(struct platform_device *pdev)
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct st_mmc_platform_data *pdata = sdhci_pltfm_priv(pltfm_host);
>  	struct reset_control *rstc = pdata->rstc;
> -	int ret;
>  
> -	ret = sdhci_pltfm_unregister(pdev);
> +	sdhci_pltfm_unregister(pdev);
>  
>  	clk_disable_unprepare(pdata->icnclk);
>  
>  	reset_control_assert(rstc);
>  
> -	return ret;
> +	return 0;
>  }
>  
>  #ifdef CONFIG_PM_SLEEP

