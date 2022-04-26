Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAB950F310
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240760AbiDZHyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242699AbiDZHyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:54:47 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECC0A1AC;
        Tue, 26 Apr 2022 00:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650959500; x=1682495500;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AF4hNHwrM38viZOG6GKR5ftamlJBG8twUEdWLdAN5HQ=;
  b=FaiI3cR+eDnrL67PAVSBE7wjzTKxb0FQgwOqhvDId8WmFXXifMTxOBuG
   dSDYLK/Dre8yeLeQ/xUBL3WQN3vYZqNkCH5VIpZI0+/4fmm62W4p+Y4QI
   uTXkiry+mkhnZstGrkMATOmh6FDhqQyTs4UYOPGqJEBctrWDnqQ3JQRTa
   WFHnmGtblJmeH9B3mwIW5WPUIPNMwi1rQfSD+3vD0fZEJb73trk7qqas8
   IOB2GWBvGtuU60ctlWs1VP92kre1jmRYPL5ZKXqjicF7fCniL3P78cY/0
   YmRGUpYt+/yDUPyqK3QQ8s94PEcoRtnapGu0h+7/k7SzYQwZaHF32cRFS
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="325977114"
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="325977114"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 00:51:40 -0700
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="558170957"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.58.98])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 00:51:35 -0700
Message-ID: <d643e80e-a7a7-818f-5d75-09d198e1a5b3@intel.com>
Date:   Tue, 26 Apr 2022 10:51:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH V5 2/5] mmc: sdhci: Capture eMMC and SD card errors
Content-Language: en-US
To:     Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        ulf.hansson@linaro.org, wsa+renesas@sang-engineering.com,
        yoshihiro.shimoda.uh@renesas.com, linus.walleij@linaro.org,
        digetx@gmail.com, briannorris@chromium.org,
        quic_riteshh@quicinc.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sartgarg@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sayalil@quicinc.com,
        Liangliang Lu <quic_luliang@quicinc.com>,
        "Bao D . Nguyen" <quic_nguyenb@quicinc.com>
References: <1650902443-26357-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <1650902443-26357-3-git-send-email-quic_c_sbhanu@quicinc.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <1650902443-26357-3-git-send-email-quic_c_sbhanu@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/22 19:00, Shaik Sajida Bhanu wrote:
> Add changes to capture eMMC and SD card errors.
> This is useful for debug and testing.
> 
> Signed-off-by: Liangliang Lu <quic_luliang@quicinc.com>
> Signed-off-by: Sayali Lokhande <quic_sayalil@quicinc.com>
> Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>

Looks good.  A couple of minor comments.

> ---
>  drivers/mmc/host/sdhci.c | 54 ++++++++++++++++++++++++++++++++++++------------
>  drivers/mmc/host/sdhci.h |  3 +++
>  include/linux/mmc/mmc.h  |  6 ++++++
>  3 files changed, 50 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 2215202..1cda28ba 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -224,6 +224,7 @@ void sdhci_reset(struct sdhci_host *host, u8 mask)
>  		if (timedout) {
>  			pr_err("%s: Reset 0x%x never completed.\n",
>  				mmc_hostname(host->mmc), (int)mask);
> +			sdhci_err_stats_inc(host, CTRL_TIMEOUT);
>  			sdhci_dumpregs(host);
>  			return;
>  		}
> @@ -1716,6 +1717,7 @@ static bool sdhci_send_command_retry(struct sdhci_host *host,
>  		if (!timeout--) {
>  			pr_err("%s: Controller never released inhibit bit(s).\n",
>  			       mmc_hostname(host->mmc));
> +			sdhci_err_stats_inc(host, CTRL_TIMEOUT);
>  			sdhci_dumpregs(host);
>  			cmd->error = -EIO;
>  			return false;
> @@ -1965,6 +1967,7 @@ void sdhci_enable_clk(struct sdhci_host *host, u16 clk)
>  		if (timedout) {
>  			pr_err("%s: Internal clock never stabilised.\n",
>  			       mmc_hostname(host->mmc));
> +			sdhci_err_stats_inc(host, CTRL_TIMEOUT);
>  			sdhci_dumpregs(host);
>  			return;
>  		}
> @@ -1987,6 +1990,7 @@ void sdhci_enable_clk(struct sdhci_host *host, u16 clk)
>  			if (timedout) {
>  				pr_err("%s: PLL clock never stabilised.\n",
>  				       mmc_hostname(host->mmc));
> +				sdhci_err_stats_inc(host, CTRL_TIMEOUT);
>  				sdhci_dumpregs(host);
>  				return;
>  			}
> @@ -3161,6 +3165,7 @@ static void sdhci_timeout_timer(struct timer_list *t)
>  	if (host->cmd && !sdhci_data_line_cmd(host->cmd)) {
>  		pr_err("%s: Timeout waiting for hardware cmd interrupt.\n",
>  		       mmc_hostname(host->mmc));
> +		sdhci_err_stats_inc(host, REQ_TIMEOUT);
>  		sdhci_dumpregs(host);
>  
>  		host->cmd->error = -ETIMEDOUT;
> @@ -3183,6 +3188,7 @@ static void sdhci_timeout_data_timer(struct timer_list *t)
>  	    (host->cmd && sdhci_data_line_cmd(host->cmd))) {
>  		pr_err("%s: Timeout waiting for hardware interrupt.\n",
>  		       mmc_hostname(host->mmc));
> +		sdhci_err_stats_inc(host, REQ_TIMEOUT);
>  		sdhci_dumpregs(host);
>  
>  		if (host->data) {
> @@ -3234,17 +3240,21 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *intmask_p)
>  			return;
>  		pr_err("%s: Got command interrupt 0x%08x even though no command operation was in progress.\n",
>  		       mmc_hostname(host->mmc), (unsigned)intmask);
> +		sdhci_err_stats_inc(host, UNEXPECTED_IRQ);
>  		sdhci_dumpregs(host);
>  		return;
>  	}
>  
>  	if (intmask & (SDHCI_INT_TIMEOUT | SDHCI_INT_CRC |
>  		       SDHCI_INT_END_BIT | SDHCI_INT_INDEX)) {
> -		if (intmask & SDHCI_INT_TIMEOUT)
> +		if (intmask & SDHCI_INT_TIMEOUT) {
>  			host->cmd->error = -ETIMEDOUT;
> -		else
> +			sdhci_err_stats_inc(host, CMD_TIMEOUT);
> +		} else {
>  			host->cmd->error = -EILSEQ;
> -
> +			if (!mmc_op_tuning(host->cmd->opcode))
> +				sdhci_err_stats_inc(host, CMD_CRC);
> +		}
>  		/* Treat data command CRC error the same as data CRC error */
>  		if (host->cmd->data &&
>  		    (intmask & (SDHCI_INT_CRC | SDHCI_INT_TIMEOUT)) ==
> @@ -3266,6 +3276,8 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *intmask_p)
>  			  -ETIMEDOUT :
>  			  -EILSEQ;
>  
> +		sdhci_err_stats_inc(host, AUTO_CMD);
> +
>  		if (sdhci_auto_cmd23(host, mrq)) {
>  			mrq->sbc->error = err;
>  			__sdhci_finish_mrq(host, mrq);
> @@ -3342,6 +3354,7 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>  			if (intmask & SDHCI_INT_DATA_TIMEOUT) {
>  				host->data_cmd = NULL;
>  				data_cmd->error = -ETIMEDOUT;
> +				sdhci_err_stats_inc(host, CMD_TIMEOUT);
>  				__sdhci_finish_mrq(host, data_cmd->mrq);
>  				return;
>  			}
> @@ -3370,23 +3383,29 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>  
>  		pr_err("%s: Got data interrupt 0x%08x even though no data operation was in progress.\n",
>  		       mmc_hostname(host->mmc), (unsigned)intmask);
> +		sdhci_err_stats_inc(host, UNEXPECTED_IRQ);
>  		sdhci_dumpregs(host);
>  
>  		return;
>  	}
>  
> -	if (intmask & SDHCI_INT_DATA_TIMEOUT)
> +	if (intmask & SDHCI_INT_DATA_TIMEOUT) {
>  		host->data->error = -ETIMEDOUT;
> -	else if (intmask & SDHCI_INT_DATA_END_BIT)
> +		sdhci_err_stats_inc(host, DAT_TIMEOUT);
> +	} else if (intmask & SDHCI_INT_DATA_END_BIT)
>  		host->data->error = -EILSEQ;

Seems to be missing here:

		sdhci_err_stats_inc(host, DAT_CRC);

Also it would be nice to have braces {} on all arms of if-else-if
Can use checkpatch.pl --strict to see where

>  	else if ((intmask & SDHCI_INT_DATA_CRC) &&
>  		SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND))
> -			!= MMC_BUS_TEST_R)
> +			!= MMC_BUS_TEST_R) {
>  		host->data->error = -EILSEQ;
> +		if (!mmc_op_tuning(host->cmd->opcode))
> +			sdhci_err_stats_inc(host, DAT_CRC);
> +	}
>  	else if (intmask & SDHCI_INT_ADMA_ERROR) {
>  		pr_err("%s: ADMA error: 0x%08x\n", mmc_hostname(host->mmc),
>  		       intmask);
>  		sdhci_adma_show_error(host);
> +		sdhci_err_stats_inc(host, ADMA);
>  		host->data->error = -EIO;
>  		if (host->ops->adma_workaround)
>  			host->ops->adma_workaround(host, intmask);
> @@ -3584,6 +3603,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
>  	if (unexpected) {
>  		pr_err("%s: Unexpected interrupt 0x%08x.\n",
>  			   mmc_hostname(host->mmc), unexpected);
> +		sdhci_err_stats_inc(host, UNEXPECTED_IRQ);
>  		sdhci_dumpregs(host);
>  	}
>  
> @@ -3905,20 +3925,27 @@ bool sdhci_cqe_irq(struct sdhci_host *host, u32 intmask, int *cmd_error,
>  	if (!host->cqe_on)
>  		return false;
>  
> -	if (intmask & (SDHCI_INT_INDEX | SDHCI_INT_END_BIT | SDHCI_INT_CRC))
> +	if (intmask & (SDHCI_INT_INDEX | SDHCI_INT_END_BIT | SDHCI_INT_CRC)) {
>  		*cmd_error = -EILSEQ;
> -	else if (intmask & SDHCI_INT_TIMEOUT)
> +		if (!mmc_op_tuning(host->cmd->opcode))
> +			sdhci_err_stats_inc(host, CMD_CRC);
> +	} else if (intmask & SDHCI_INT_TIMEOUT) {
>  		*cmd_error = -ETIMEDOUT;
> -	else
> +		sdhci_err_stats_inc(host, CMD_TIMEOUT);
> +	} else
>  		*cmd_error = 0;
>  
> -	if (intmask & (SDHCI_INT_DATA_END_BIT | SDHCI_INT_DATA_CRC))
> +	if (intmask & (SDHCI_INT_DATA_END_BIT | SDHCI_INT_DATA_CRC)) {
>  		*data_error = -EILSEQ;
> -	else if (intmask & SDHCI_INT_DATA_TIMEOUT)
> +		if (!mmc_op_tuning(host->cmd->opcode))
> +			sdhci_err_stats_inc(host, DAT_CRC);
> +	} else if (intmask & SDHCI_INT_DATA_TIMEOUT) {
>  		*data_error = -ETIMEDOUT;
> -	else if (intmask & SDHCI_INT_ADMA_ERROR)
> +		sdhci_err_stats_inc(host, DAT_TIMEOUT);
> +	} else if (intmask & SDHCI_INT_ADMA_ERROR) {
>  		*data_error = -EIO;
> -	else
> +		sdhci_err_stats_inc(host, ADMA);
> +	} else
>  		*data_error = 0;
>  
>  	/* Clear selected interrupts. */
> @@ -3934,6 +3961,7 @@ bool sdhci_cqe_irq(struct sdhci_host *host, u32 intmask, int *cmd_error,
>  		sdhci_writel(host, intmask, SDHCI_INT_STATUS);
>  		pr_err("%s: CQE: Unexpected interrupt 0x%08x.\n",
>  		       mmc_hostname(host->mmc), intmask);
> +		sdhci_err_stats_inc(host, UNEXPECTED_IRQ);
>  		sdhci_dumpregs(host);
>  	}
>  
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index d7929d7..95a08f0 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -356,6 +356,9 @@ struct sdhci_adma2_64_desc {
>   */
>  #define MMC_CMD_TRANSFER_TIME	(10 * NSEC_PER_MSEC) /* max 10 ms */
>  
> +#define sdhci_err_stats_inc(host, err_name) \
> +	mmc_debugfs_err_stats_inc((host)->mmc, MMC_ERR_##err_name)
> +
>  enum sdhci_cookie {
>  	COOKIE_UNMAPPED,
>  	COOKIE_PRE_MAPPED,	/* mapped by sdhci_pre_req() */
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index d9a65c6..9c50bc4 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -99,6 +99,12 @@ static inline bool mmc_op_multi(u32 opcode)
>  	       opcode == MMC_READ_MULTIPLE_BLOCK;
>  }
>  
> +static inline bool mmc_op_tuning(u32 opcode)
> +{
> +	return opcode == MMC_SEND_TUNING_BLOCK ||
> +			opcode == MMC_SEND_TUNING_BLOCK_HS200;
> +}
> +
>  /*
>   * MMC_SWITCH argument format:
>   *

There does not seem to be any:

	sdhci_err_stats_inc(host, TUNING);

MMC_ERR_TUNING does not seem to get used.
