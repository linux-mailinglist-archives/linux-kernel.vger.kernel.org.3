Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739334B7671
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242063AbiBOQ7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:59:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242048AbiBOQ7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:59:25 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F85F11B2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 08:59:15 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id i21so1649791oie.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 08:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YPExe43oiU2kbYuof8MAvM6DxTVmL+Y9rgGUD/NUjBo=;
        b=ei/j2mpRiSvBEbwW4PhTHwo8MRfnAdUB8oK/mvFHvKeX4aX4ZXhdx4B63i6JZe/fwk
         lZLOoxC3voXhGLJGx7Bs8sXCJ7C4158v70/mpaWRNO5u68o0L6EClrTuZCzau2MbJp7n
         Cga9PMm/xZhvYAIn463oUDtXpTzQDzbeHxXlkVAsKMp3JiQyNmtaBvyjRu4Q2WXwxPpH
         dRqhKVWETA5YDOHXnjKnh72/OiQ8PG3FapE6Nd64fBKN3zcx8H+IGiYFf7LL4CgJdXuB
         foelGLCreR71CqB0vqQj5M/zQ62+5twqT6zCiqZNIcEPASIU/uw4oxUhcnuSMhkhbbwI
         5i8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YPExe43oiU2kbYuof8MAvM6DxTVmL+Y9rgGUD/NUjBo=;
        b=Eu+oqOYB3/X6y2qS/52Vodw2wdTHZIw+a/e3rBnztJ2M2ip1UynNLVmksMv9nXzKYU
         6HlHjRAMIeyy2PPmGhb2ktatbdhrr1VzAhSVqMASqeKa6kv4ddQvHaZIxYWiTHD8Dwk7
         NPRfnAkPZHm9+ArasmJIxzNrjVkr+sbwCen9gBnIbnNbFx8QW+CBB5mTF42JxQLtmmKE
         ppPPvYfhE0Tbirla1p85uswCtqg11PAksx2zjDE3MPJnWLZhEWNSpSq6DIWwOZrm4dMm
         sEE3SlvsKin+PPPsyziZhkblYBQskWVrXpINg4Lu1FmqVFgnlNMFUoXxqbV26cfeWjjK
         veTQ==
X-Gm-Message-State: AOAM533k2lO/xMOWFqJmBl3EO107tj1hjaBack9+f7uJzTBCIb8revb8
        yUPxKSVRTrcSp8g4W1/VJR2LQw==
X-Google-Smtp-Source: ABdhPJyLr97qtxQJpgNZ2Yr9x/XnvRC6XNfhjoLYiqk7mthC2wVrNYvVs5CTUGX5YwFPdjs+DFpPjg==
X-Received: by 2002:a05:6808:1705:b0:2d4:d7a:9c25 with SMTP id bc5-20020a056808170500b002d40d7a9c25mr1618511oib.51.1644944354403;
        Tue, 15 Feb 2022 08:59:14 -0800 (PST)
Received: from yoga ([2600:1700:a0:3dc8:5c39:baff:fe03:898d])
        by smtp.gmail.com with ESMTPSA id x1sm13993943oto.38.2022.02.15.08.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 08:59:13 -0800 (PST)
Date:   Tue, 15 Feb 2022 10:59:11 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Cc:     adrian.hunter@intel.com, quic_asutoshd@quicinc.com,
        ulf.hansson@linaro.org, agross@kernel.org,
        linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stummala@codeaurora.org,
        vbadigan@codeaurora.org, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, sartgarg@codeaurora.org,
        nitirawa@codeaurora.org, sayalil@codeaurora.org,
        Liangliang Lu <luliang@codeaurora.org>,
        "Bao D . Nguyen" <nguyenb@codeaurora.org>
Subject: Re: [PATCH V3 1/4] mmc: sdhci: Capture eMMC and SD card errors
Message-ID: <Ygvb38vVeafYS4O0@yoga>
References: <1642699582-14785-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <1642699582-14785-2-git-send-email-quic_c_sbhanu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1642699582-14785-2-git-send-email-quic_c_sbhanu@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 20 Jan 11:26 CST 2022, Shaik Sajida Bhanu wrote:

> Add changes to capture eMMC and SD card errors.
> This is useful for debug and testing.
> 
> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
> Signed-off-by: Liangliang Lu <luliang@codeaurora.org>
> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
> Signed-off-by: Bao D. Nguyen <nguyenb@codeaurora.org>

Please read
https://docs.kernel.org/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin
and the one section below on what your S-o-b actually means.

In particular this does not say "the four of us authored this patch", it
documents the path the patch took to this point. In which case Bao is
the last one stating that he _handled_ the patch - but then somehow it
came out of your mailbox.

You're probably looking for Co-developed-by, which is described just
below that.

Regards,
Bjorn

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
>  	SDHCI_DUMP("============================================\n");
>  }
>  EXPORT_SYMBOL_GPL(sdhci_dumpregs);
> @@ -3159,6 +3161,8 @@ static void sdhci_timeout_timer(struct timer_list *t)
>  	spin_lock_irqsave(&host->lock, flags);
>  
>  	if (host->cmd && !sdhci_data_line_cmd(host->cmd)) {
> +		if (host->mmc && host->mmc->err_stats_enabled)
> +			mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_REQ_TIMEOUT);
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
>  
>  	unsigned long		private[] ____cacheline_aligned;
>  };
> @@ -635,6 +655,17 @@ static inline enum dma_data_direction mmc_get_dma_dir(struct mmc_data *data)
>  	return data->flags & MMC_DATA_WRITE ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
>  }
>  
> +static inline void mmc_debugfs_err_stats_enable(struct mmc_host *mmc)
> +{
> +	mmc->err_state = true;
> +}
> +
> +static inline void mmc_debugfs_err_stats_inc(struct mmc_host *mmc,
> +		enum mmc_err_stat stat) {
> +
> +	mmc->err_stats[stat] += 1;
> +}
> +
>  int mmc_send_tuning(struct mmc_host *host, u32 opcode, int *cmd_error);
>  int mmc_send_abort_tuning(struct mmc_host *host, u32 opcode);
>  int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd);
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
> of Code Aurora Forum, hosted by The Linux Foundation
> 
