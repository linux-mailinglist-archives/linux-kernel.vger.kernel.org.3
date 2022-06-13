Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20AC1548032
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 09:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239134AbiFMHNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 03:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiFMHN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 03:13:27 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87AD1A3B2;
        Mon, 13 Jun 2022 00:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655104403; x=1686640403;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=e6TSSclSEf+SmXWUeydiq8kOl+7wu8+wA2N3sf7EVDI=;
  b=Kg1lg4darTEwGDr+bGSn808K+JFUdz7Y1jwedyQBFjDitc9r2Vfaxd38
   Q5vNMORalcWcHeHBjl87a7f/Fjg+vryc/4RIT40Mn44/0ItjLdicWX4C0
   /zMHVYYcp+f6geHHNv2Y8zsvBvZGGaQ9eKIj6Zcbx01Gue27oxS/MYADT
   AzuYYt7XUxDvww+32Wxp9ubqQurEkUx1yoi/5X000IGNGrTD/MeLesmik
   wbhKrsG6kRk3dtqPlud1O9G8qz5AJ5T5CopvIJGk6Mg+y7tJCynXUDmf/
   7uqOavvRCBlbNv7qqDPmVVPU+U+j6pBikBcrrjTEVC0Lw62SJxm4FF4rt
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10376"; a="339866002"
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="339866002"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 00:13:20 -0700
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="639571384"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.58.193])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 00:13:17 -0700
Message-ID: <c0a313ac-20b9-2d1a-4c10-9ba57c62ae95@intel.com>
Date:   Mon, 13 Jun 2022 10:13:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH 4/5] mmc: sdhci-of-arasan: Obviously always return success
 in remove callback
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Michal Simek <michal.simek@xilinx.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220610211257.102071-1-u.kleine-koenig@pengutronix.de>
 <20220610211257.102071-4-u.kleine-koenig@pengutronix.de>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220610211257.102071-4-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

This preparation seems a bit unnatural.

> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 757801dfc308..3997cad1f793 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -1733,7 +1733,6 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>  
>  static int sdhci_arasan_remove(struct platform_device *pdev)
>  {
> -	int ret;
>  	struct sdhci_host *host = platform_get_drvdata(pdev);
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
> @@ -1747,11 +1746,11 @@ static int sdhci_arasan_remove(struct platform_device *pdev)
>  
>  	sdhci_arasan_unregister_sdclk(&pdev->dev);
>  
> -	ret = sdhci_pltfm_unregister(pdev);
> +	sdhci_pltfm_unregister(pdev);
>  
>  	clk_disable_unprepare(clk_ahb);
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static struct platform_driver sdhci_arasan_driver = {

