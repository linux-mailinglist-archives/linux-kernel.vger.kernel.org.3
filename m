Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B79EC495A4E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 08:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378842AbiAUHIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 02:08:25 -0500
Received: from mga01.intel.com ([192.55.52.88]:14871 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348894AbiAUHIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 02:08:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642748904; x=1674284904;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=f2n2M0YrGGmIPjwguhNnNQI4fdXjaIv8iH3a5z/qtZ8=;
  b=IFM8VG1zIOCfHBf1AguIvNZN4/WJVAIRY/LRRGm7EXUZLPO9K/5e3cyA
   T5tGPMjyKEkaGFCt3U6bIsPHaoOYlZyuuw6kIvyuOB5Fw3n1BXdwTmlF4
   AN8n9/pms0PUUQcMTwGOE7OmvW1v6jr7/ne6Y+wH0K91jOU5Lxd1KSP7x
   ry1JgokGJlsHtzxtA0sp48IZD/AeNhFV2R2fb7uut/uYDvppcGIj8zJ1r
   OXccudMG30WprCD2mCHIjV3j+vWPcqXH4kgsoLBwX9cpX/Z6LCC+d1abi
   mDh5uI/h/QIYSGnHuVcGqi5KCYKZwCZp+wc0u6uB/F6yEWpT2X0rCA+Dh
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10233"; a="270003709"
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="270003709"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 23:08:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="694540485"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.92]) ([10.237.72.92])
  by orsmga005.jf.intel.com with ESMTP; 20 Jan 2022 23:08:18 -0800
Subject: Re: [PATCH V3 1/4] mmc: sdhci: Capture eMMC and SD card errors
To:     Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        quic_asutoshd@quicinc.com, ulf.hansson@linaro.org,
        agross@kernel.org, bjorn.andersson@linaro.org,
        linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     stummala@codeaurora.org, vbadigan@codeaurora.org,
        quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        sartgarg@codeaurora.org, nitirawa@codeaurora.org,
        sayalil@codeaurora.org, Liangliang Lu <luliang@codeaurora.org>,
        "Bao D . Nguyen" <nguyenb@codeaurora.org>
References: <1642699582-14785-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <1642699582-14785-2-git-send-email-quic_c_sbhanu@quicinc.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <b28d2d19-b8fb-c58b-f661-6b5f0760b1a4@intel.com>
Date:   Fri, 21 Jan 2022 09:08:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1642699582-14785-2-git-send-email-quic_c_sbhanu@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/2022 19:26, Shaik Sajida Bhanu wrote:
> Add changes to capture eMMC and SD card errors.
> This is useful for debug and testing.
> 
> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
> Signed-off-by: Liangliang Lu <luliang@codeaurora.org>
> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
> Signed-off-by: Bao D. Nguyen <nguyenb@codeaurora.org>
> ---
>  drivers/mmc/host/sdhci-msm.c |  3 ++
>  drivers/mmc/host/sdhci.c     | 72 ++++++++++++++++++++++++++++++++++++--------
>  include/linux/mmc/host.h     | 31 +++++++++++++++++++
>  3 files changed, 94 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 50c71e0..309eb7b 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -128,6 +128,8 @@
>  
>  #define MSM_MMC_AUTOSUSPEND_DELAY_MS	50
>  
> +#define MSM_MMC_ERR_STATS_ENABLE 1
> +
>  /* Timeout value to avoid infinite waiting for pwr_irq */
>  #define MSM_PWR_IRQ_TIMEOUT_MS 5000
>  
> @@ -2734,6 +2736,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto pm_runtime_disable;
>  
> +	host->mmc->err_stats_enabled = MSM_MMC_ERR_STATS_ENABLE;

Please remove this. SDHCI will enable error stats.

>  	pm_runtime_mark_last_busy(&pdev->dev);
>  	pm_runtime_put_autosuspend(&pdev->dev);
>  
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 07c6da1..74b356e 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -113,6 +113,8 @@ void sdhci_dumpregs(struct sdhci_host *host)
>  	if (host->ops->dump_vendor_regs)
>  		host->ops->dump_vendor_regs(host);
>  
> +	if (host->mmc->err_stats_enabled)
> +		mmc_debugfs_err_stats_enable(host->mmc);

Please move this to sdhci_setup_host() and call it unconditionally i.e. just

	mmc_debugfs_err_stats_enable(host->mmc);

>  	SDHCI_DUMP("============================================\n");
>  }
>  EXPORT_SYMBOL_GPL(sdhci_dumpregs);
> @@ -3159,6 +3161,8 @@ static void sdhci_timeout_timer(struct timer_list *t)
>  	spin_lock_irqsave(&host->lock, flags);
>  
>  	if (host->cmd && !sdhci_data_line_cmd(host->cmd)) {
> +		if (host->mmc && host->mmc->err_stats_enabled)
> +			mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_REQ_TIMEOUT);

Please remove the 'if ()', i.e. just make it, unconditionally:

		mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_REQ_TIMEOUT);

Same for other calls to mmc_debugfs_err_stats_inc()

>  		pr_err("%s: Timeout waiting for hardware cmd interrupt.\n",
>  		       mmc_hostname(host->mmc));
>  		sdhci_dumpregs(host);
> @@ -3181,6 +3185,8 @@ static void sdhci_timeout_data_timer(struct timer_list *t)
>  
>  	if (host->data || host->data_cmd ||
>  	    (host->cmd && sdhci_data_line_cmd(host->cmd))) {
> +		if (host->mmc && host->mmc->err_stats_enabled)
> +			mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_REQ_TIMEOUT);
>  		pr_err("%s: Timeout waiting for hardware interrupt.\n",
>  		       mmc_hostname(host->mmc));
>  		sdhci_dumpregs(host);
> @@ -3240,11 +3246,18 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *intmask_p)
>  
>  	if (intmask & (SDHCI_INT_TIMEOUT | SDHCI_INT_CRC |
>  		       SDHCI_INT_END_BIT | SDHCI_INT_INDEX)) {
> -		if (intmask & SDHCI_INT_TIMEOUT)
> +		if (intmask & SDHCI_INT_TIMEOUT) {
>  			host->cmd->error = -ETIMEDOUT;
> -		else
> +			if (host->mmc && host->mmc->err_stats_enabled)
> +				mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_CMD_TIMEOUT);
> +		} else {
>  			host->cmd->error = -EILSEQ;
> -
> +			if (host->cmd->opcode != MMC_SEND_TUNING_BLOCK ||
> +					host->cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200) {
> +				if (host->mmc && host->mmc->err_stats_enabled)
> +					mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_CMD_CRC);
> +			}
> +		}
>  		/* Treat data command CRC error the same as data CRC error */
>  		if (host->cmd->data &&
>  		    (intmask & (SDHCI_INT_CRC | SDHCI_INT_TIMEOUT)) ==
> @@ -3265,6 +3278,8 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *intmask_p)
>  		int err = (auto_cmd_status & SDHCI_AUTO_CMD_TIMEOUT) ?
>  			  -ETIMEDOUT :
>  			  -EILSEQ;
> +		if (host->mmc && host->mmc->err_stats_enabled)
> +			mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_AUTO_CMD);
>  
>  		if (sdhci_auto_cmd23(host, mrq)) {
>  			mrq->sbc->error = err;
> @@ -3342,6 +3357,8 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>  			if (intmask & SDHCI_INT_DATA_TIMEOUT) {
>  				host->data_cmd = NULL;
>  				data_cmd->error = -ETIMEDOUT;
> +				if (host->mmc && host->mmc->err_stats_enabled)
> +					mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_CMD_TIMEOUT);
>  				__sdhci_finish_mrq(host, data_cmd->mrq);
>  				return;
>  			}
> @@ -3375,18 +3392,29 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>  		return;
>  	}
>  
> -	if (intmask & SDHCI_INT_DATA_TIMEOUT)
> +	if (intmask & SDHCI_INT_DATA_TIMEOUT) {
>  		host->data->error = -ETIMEDOUT;
> +		if (host->mmc && host->mmc->err_stats_enabled)
> +			mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_DAT_TIMEOUT);
> +	}
>  	else if (intmask & SDHCI_INT_DATA_END_BIT)
>  		host->data->error = -EILSEQ;
>  	else if ((intmask & SDHCI_INT_DATA_CRC) &&
>  		SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND))
> -			!= MMC_BUS_TEST_R)
> +			!= MMC_BUS_TEST_R) {
>  		host->data->error = -EILSEQ;
> +		if (host->cmd->opcode != MMC_SEND_TUNING_BLOCK ||
> +				host->cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200) {
> +			if (host->mmc && host->mmc->err_stats_enabled)
> +				mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_DAT_CRC);
> +		}
> +	}
>  	else if (intmask & SDHCI_INT_ADMA_ERROR) {
>  		pr_err("%s: ADMA error: 0x%08x\n", mmc_hostname(host->mmc),
>  		       intmask);
>  		sdhci_adma_show_error(host);
> +		if (host->mmc && host->mmc->err_stats_enabled)
> +			mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_ADMA);
>  		host->data->error = -EIO;
>  		if (host->ops->adma_workaround)
>  			host->ops->adma_workaround(host, intmask);
> @@ -3905,20 +3933,40 @@ bool sdhci_cqe_irq(struct sdhci_host *host, u32 intmask, int *cmd_error,
>  	if (!host->cqe_on)
>  		return false;
>  
> -	if (intmask & (SDHCI_INT_INDEX | SDHCI_INT_END_BIT | SDHCI_INT_CRC))
> +	if (intmask & (SDHCI_INT_INDEX | SDHCI_INT_END_BIT | SDHCI_INT_CRC)) {
>  		*cmd_error = -EILSEQ;
> -	else if (intmask & SDHCI_INT_TIMEOUT)
> +		if (intmask & SDHCI_INT_CRC) {
> +			if (host->cmd->opcode != MMC_SEND_TUNING_BLOCK ||
> +					host->cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200) {
> +				if (host->mmc && host->mmc->err_stats_enabled)
> +					mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_CMD_CRC);
> +			}
> +		}
> +	} else if (intmask & SDHCI_INT_TIMEOUT) {
>  		*cmd_error = -ETIMEDOUT;
> -	else
> +		if (host->mmc && host->mmc->err_stats_enabled)
> +			mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_CMD_TIMEOUT);
> +	} else
>  		*cmd_error = 0;
>  
> -	if (intmask & (SDHCI_INT_DATA_END_BIT | SDHCI_INT_DATA_CRC))
> +	if (intmask & (SDHCI_INT_DATA_END_BIT | SDHCI_INT_DATA_CRC)) {
>  		*data_error = -EILSEQ;
> -	else if (intmask & SDHCI_INT_DATA_TIMEOUT)
> +		if (intmask & SDHCI_INT_DATA_CRC) {
> +			if (host->cmd->opcode != MMC_SEND_TUNING_BLOCK ||
> +					host->cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200) {
> +				if (host->mmc && host->mmc->err_stats_enabled)
> +					mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_DAT_CRC);
> +			}
> +		}
> +	} else if (intmask & SDHCI_INT_DATA_TIMEOUT) {
>  		*data_error = -ETIMEDOUT;
> -	else if (intmask & SDHCI_INT_ADMA_ERROR)
> +		if (host->mmc && host->mmc->err_stats_enabled)
> +			mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_DAT_TIMEOUT);
> +	} else if (intmask & SDHCI_INT_ADMA_ERROR) {
>  		*data_error = -EIO;
> -	else
> +		if (host->mmc && host->mmc->err_stats_enabled)
> +			mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_ADMA);
> +	} else
>  		*data_error = 0;
>  
>  	/* Clear selected interrupts. */
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h

Changes to host.h are core changes and belong in patch 3,
which should be the first patch.

> index 7afb57c..883b50b 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -93,6 +93,23 @@ struct mmc_clk_phase_map {
>  
>  struct mmc_host;
>  
> +enum mmc_err_stat {
> +	MMC_ERR_CMD_TIMEOUT,
> +	MMC_ERR_CMD_CRC,
> +	MMC_ERR_DAT_TIMEOUT,
> +	MMC_ERR_DAT_CRC,
> +	MMC_ERR_AUTO_CMD,
> +	MMC_ERR_ADMA,
> +	MMC_ERR_TUNING,
> +	MMC_ERR_CMDQ_RED,
> +	MMC_ERR_CMDQ_GCE,
> +	MMC_ERR_CMDQ_ICCE,
> +	MMC_ERR_REQ_TIMEOUT,
> +	MMC_ERR_CMDQ_REQ_TIMEOUT,
> +	MMC_ERR_ICE_CFG,
> +	MMC_ERR_MAX,
> +};
> +
>  struct mmc_host_ops {
>  	/*
>  	 * It is optional for the host to implement pre_req and post_req in
> @@ -500,6 +517,9 @@ struct mmc_host {
>  
>  	/* Host Software Queue support */
>  	bool			hsq_enabled;
> +	u32                     err_stats[MMC_ERR_MAX];
> +	bool 			err_stats_enabled;
> +	bool			err_state;

Please drop err_state for now

>  
>  	unsigned long		private[] ____cacheline_aligned;
>  };
> @@ -635,6 +655,17 @@ static inline enum dma_data_direction mmc_get_dma_dir(struct mmc_data *data)
>  	return data->flags & MMC_DATA_WRITE ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
>  }
>  
> +static inline void mmc_debugfs_err_stats_enable(struct mmc_host *mmc)

Please use 'host' as the mmc_host parameter in this file.

> +{
> +	mmc->err_state = true;

Let's make this:

	host->err_stats_enabled = true;

> +}
> +
> +static inline void mmc_debugfs_err_stats_inc(struct mmc_host *mmc,
> +		enum mmc_err_stat stat) {
> +

Please remove blank line here

> +	mmc->err_stats[stat] += 1;
> +}
> +
>  int mmc_send_tuning(struct mmc_host *host, u32 opcode, int *cmd_error);
>  int mmc_send_abort_tuning(struct mmc_host *host, u32 opcode);
>  int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd);
> 

