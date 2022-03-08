Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2244D1435
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 11:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345616AbiCHKHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 05:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345611AbiCHKHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 05:07:37 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5D640907;
        Tue,  8 Mar 2022 02:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646734001; x=1678270001;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gQW1oAeon+57DU8wGcNd1CFDpjSEBBQeWTKSocyD9Ts=;
  b=Sm6eyhpQJ4e0YrKm+FoPfTxdKWlI5cI4zIXP3d83QAWbN4lKOKs2wtoH
   u1ALk4Pzk1wGTwGGb19nI3+UuZoSKkRktjZfraOx7WLYUwIIdgEf7yc0V
   sZcbCDGUST4ur1g6Znln+R9JJcPigrOnvgCLHPMaRAgs/kothJD12SL4B
   Ml0CW3F4nsUSh+3fFBjH99RxgPDEspPeF0BZ1/RCTE71tOdEh53fYkvgd
   xz/VlzTgLLkSyw40mAF9VAxDqf129DOUJthMQEYNhZZPm1y59F9U9AwQa
   h/PGnoAZv7AezD9cKfhVoY9BG/kGxogddutW5WutbliPW+dfkORjhVMf0
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="254374481"
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="254374481"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 02:06:34 -0800
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="553558552"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.46.193])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 02:06:30 -0800
Message-ID: <01515ee6-b312-7f81-43f0-e72a0d290046@intel.com>
Date:   Tue, 8 Mar 2022 12:06:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH V4 6/7] mmc: sdhci: Set error state for mmc driver
Content-Language: en-US
To:     Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        asutoshd@quicinc.com, ulf.hansson@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_vbadigan@quicinc.com, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sartgarg@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sayalil@quicinc.com,
        Sayali Lokhande <sayalil@codeaurora.org>,
        "Bao D . Nguyen" <nguyenb@codeaurora.org>
References: <1646226227-32429-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <1646226227-32429-7-git-send-email-quic_c_sbhanu@quicinc.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <1646226227-32429-7-git-send-email-quic_c_sbhanu@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2.3.2022 15.03, Shaik Sajida Bhanu wrote:
> Set error state if any errors observed in eMMC and SD card driver level.
> 
> Signed-off-by: Liangliang Lu <luliang@codeaurora.org>
> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
> Signed-off-by: Bao D. Nguyen <nguyenb@codeaurora.org>
> Signed-off-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
> ---
>  drivers/mmc/host/sdhci.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 741fb06..4ba3797 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -224,6 +224,8 @@ void sdhci_reset(struct sdhci_host *host, u8 mask)
>  		if (timedout) {
>  			pr_err("%s: Reset 0x%x never completed.\n",
>  				mmc_hostname(host->mmc), (int)mask);
> +			if (host->mmc && !host->mmc->err_state)
> +				mmc_debugfs_err_stats_enable(host->mmc);

I really do not understand why this cannot be another err_stats entry
such as MMC_ERR_DRIVER and then as below?

			sdhci_err_stats_inc(host, DRIVER);


>  			sdhci_dumpregs(host);
>  			return;
>  		}
> @@ -1716,6 +1718,8 @@ static bool sdhci_send_command_retry(struct sdhci_host *host,
>  		if (!timeout--) {
>  			pr_err("%s: Controller never released inhibit bit(s).\n",
>  			       mmc_hostname(host->mmc));
> +			if (host->mmc && !host->mmc->err_state)
> +				mmc_debugfs_err_stats_enable(host->mmc);
>  			sdhci_dumpregs(host);
>  			cmd->error = -EIO;
>  			return false;
> @@ -1965,6 +1969,8 @@ void sdhci_enable_clk(struct sdhci_host *host, u16 clk)
>  		if (timedout) {
>  			pr_err("%s: Internal clock never stabilised.\n",
>  			       mmc_hostname(host->mmc));
> +			if (host->mmc && !host->mmc->err_state)
> +				mmc_debugfs_err_stats_enable(host->mmc);
>  			sdhci_dumpregs(host);
>  			return;
>  		}
> @@ -1987,6 +1993,8 @@ void sdhci_enable_clk(struct sdhci_host *host, u16 clk)
>  			if (timedout) {
>  				pr_err("%s: PLL clock never stabilised.\n",
>  				       mmc_hostname(host->mmc));
> +				if (host->mmc && !host->mmc->err_state)
> +					mmc_debugfs_err_stats_enable(host->mmc);
>  				sdhci_dumpregs(host);
>  				return;
>  			}
> @@ -3162,6 +3170,8 @@ static void sdhci_timeout_timer(struct timer_list *t)
>  		mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_REQ_TIMEOUT);
>  		pr_err("%s: Timeout waiting for hardware cmd interrupt.\n",
>  		       mmc_hostname(host->mmc));
> +		if (host->mmc && !host->mmc->err_state)
> +			mmc_debugfs_err_stats_enable(host->mmc);
>  		sdhci_dumpregs(host);
>  
>  		host->cmd->error = -ETIMEDOUT;
> @@ -3185,6 +3195,8 @@ static void sdhci_timeout_data_timer(struct timer_list *t)
>  		mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_REQ_TIMEOUT);
>  		pr_err("%s: Timeout waiting for hardware interrupt.\n",
>  		       mmc_hostname(host->mmc));
> +		if (host->mmc && !host->mmc->err_state)
> +			mmc_debugfs_err_stats_enable(host->mmc);
>  		sdhci_dumpregs(host);
>  
>  		if (host->data) {
> @@ -3236,6 +3248,8 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *intmask_p)
>  			return;
>  		pr_err("%s: Got command interrupt 0x%08x even though no command operation was in progress.\n",
>  		       mmc_hostname(host->mmc), (unsigned)intmask);
> +		if (host->mmc && !host->mmc->err_state)
> +			mmc_debugfs_err_stats_enable(host->mmc);
>  		sdhci_dumpregs(host);
>  		return;
>  	}
> @@ -3289,6 +3303,8 @@ static void sdhci_adma_show_error(struct sdhci_host *host)
>  	void *desc = host->adma_table;
>  	dma_addr_t dma = host->adma_addr;
>  
> +	if (host->mmc && !host->mmc->err_state)
> +		mmc_debugfs_err_stats_enable(host->mmc);
>  	sdhci_dumpregs(host);
>  
>  	while (true) {
> @@ -3378,6 +3394,8 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>  
>  		pr_err("%s: Got data interrupt 0x%08x even though no data operation was in progress.\n",
>  		       mmc_hostname(host->mmc), (unsigned)intmask);
> +		if (host->mmc && !host->mmc->err_state)
> +			mmc_debugfs_err_stats_enable(host->mmc);
>  		sdhci_dumpregs(host);
>  
>  		return;
> @@ -3599,6 +3617,8 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
>  	if (unexpected) {
>  		pr_err("%s: Unexpected interrupt 0x%08x.\n",
>  			   mmc_hostname(host->mmc), unexpected);
> +		if (host->mmc && !host->mmc->err_state)
> +			mmc_debugfs_err_stats_enable(host->mmc);
>  		sdhci_dumpregs(host);
>  	}
>  
> @@ -3962,6 +3982,8 @@ bool sdhci_cqe_irq(struct sdhci_host *host, u32 intmask, int *cmd_error,
>  		sdhci_writel(host, intmask, SDHCI_INT_STATUS);
>  		pr_err("%s: CQE: Unexpected interrupt 0x%08x.\n",
>  		       mmc_hostname(host->mmc), intmask);
> +		if (host->mmc && !host->mmc->err_state)
> +			mmc_debugfs_err_stats_enable(host->mmc);
>  		sdhci_dumpregs(host);
>  	}
>  

