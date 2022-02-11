Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0504B1DFF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 06:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237072AbiBKFvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 00:51:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbiBKFvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 00:51:06 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2383C25CC;
        Thu, 10 Feb 2022 21:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644558666; x=1676094666;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JSqH0wIueNaqGLKm9E39H+VPyZFNXpJlkeXrQp+kWpk=;
  b=M/xk9At2dGLIzOlqvVSR8ZY+AwX6pxAsKeXK18vwuN9PXUDS9D8Ih20S
   svw9xcJBqdaxuyPKS1V+JADBwu0Hd3otqyOuDKq0nksRlI3BL+uoAr5xb
   2dqkM0i9LRpW9MLQr+frP6y33CqOhGEyV8EcCWZ3YUWEs4E16cK68T70b
   GKbgpV0XrTYoYGbrbAg2+9vzyly459Y9+Nm+q8akw0/XfpZX1VfU2ywzQ
   YrSjHINO/AyyWjwF0pxYroxFohxSXE9kB3LR1L2CucF26m+r4XI3OAPMf
   nPQvp6hbLmIF3g8Z9Pt+MmE8PiEtSD0zCsBgrPJBooaWoskBzJFDPv40j
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="274222243"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="274222243"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 21:51:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="526829709"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.92]) ([10.237.72.92])
  by orsmga007.jf.intel.com with ESMTP; 10 Feb 2022 21:51:00 -0800
Message-ID: <d56166f7-762f-413c-ab49-15b91f1c95a9@intel.com>
Date:   Fri, 11 Feb 2022 07:51:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH V3 1/4] mmc: sdhci: Capture eMMC and SD card errors
Content-Language: en-US
To:     "Sajida Bhanu (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>,
        "Asutosh Das (QUIC)" <quic_asutoshd@quicinc.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "agross@kernel.org" <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "stummala@codeaurora.org" <stummala@codeaurora.org>,
        "vbadigan@codeaurora.org" <vbadigan@codeaurora.org>,
        "Ram Prakash Gupta (QUIC)" <quic_rampraka@quicinc.com>,
        "Pradeep Pragallapati (QUIC)" <quic_pragalla@quicinc.com>,
        "sartgarg@codeaurora.org" <sartgarg@codeaurora.org>,
        "nitirawa@codeaurora.org" <nitirawa@codeaurora.org>,
        "sayalil@codeaurora.org" <sayalil@codeaurora.org>,
        Liangliang Lu <luliang@codeaurora.org>,
        "Bao D . Nguyen" <nguyenb@codeaurora.org>
References: <1642699582-14785-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <1642699582-14785-2-git-send-email-quic_c_sbhanu@quicinc.com>
 <b28d2d19-b8fb-c58b-f661-6b5f0760b1a4@intel.com>
 <SJ0PR02MB844953E6B8E29BCDCC6222ACCD5F9@SJ0PR02MB8449.namprd02.prod.outlook.com>
 <a999067d-3723-1c9b-ed7e-91cd4856b7ee@intel.com>
 <SJ0PR02MB84499D9B53FAE4E3173669CFCD2D9@SJ0PR02MB8449.namprd02.prod.outlook.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <SJ0PR02MB84499D9B53FAE4E3173669CFCD2D9@SJ0PR02MB8449.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2022 21:04, Sajida Bhanu (Temp) (QUIC) wrote:
> Hi,
> 
> Thanks for the review.
> 
> Please find the inline comments
> 
> Thanks,
> Sajida
> -----Original Message-----
> From: Adrian Hunter <adrian.hunter@intel.com> 
> Sent: Tuesday, February 1, 2022 7:28 PM
> To: Sajida Bhanu (Temp) <c_sbhanu@qti.qualcomm.com>; Sajida Bhanu (Temp) (QUIC) <quic_c_sbhanu@quicinc.com>; Asutosh Das (QUIC) <quic_asutoshd@quicinc.com>; ulf.hansson@linaro.org; agross@kernel.org; bjorn.andersson@linaro.org; linux-mmc@vger.kernel.org; linux-arm-msm@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: stummala@codeaurora.org; vbadigan@codeaurora.org; Ram Prakash Gupta (QUIC) <quic_rampraka@quicinc.com>; Pradeep Pragallapati (QUIC) <quic_pragalla@quicinc.com>; sartgarg@codeaurora.org; nitirawa@codeaurora.org; sayalil@codeaurora.org; Liangliang Lu <luliang@codeaurora.org>; Bao D . Nguyen <nguyenb@codeaurora.org>
> Subject: Re: [PATCH V3 1/4] mmc: sdhci: Capture eMMC and SD card errors
> 
> On 25/01/2022 20:17, Sajida Bhanu (Temp) wrote:
>> Hi,
>>
>> Thanks for  the Review.
>>
>> Please find the inline comments.
>>
>> Thanks,
>> Sajida
>>
>> -----Original Message-----
>> From: Adrian Hunter <adrian.hunter@intel.com>
>> Sent: Friday, January 21, 2022 12:38 PM
>> To: Sajida Bhanu (Temp) (QUIC) <quic_c_sbhanu@quicinc.com>; Asutosh 
>> Das (QUIC) <quic_asutoshd@quicinc.com>; ulf.hansson@linaro.org; 
>> agross@kernel.org; bjorn.andersson@linaro.org; 
>> linux-mmc@vger.kernel.org; linux-arm-msm@vger.kernel.org; 
>> linux-kernel@vger.kernel.org
>> Cc: stummala@codeaurora.org; vbadigan@codeaurora.org; Ram Prakash 
>> Gupta (QUIC) <quic_rampraka@quicinc.com>; Pradeep Pragallapati (QUIC) 
>> <quic_pragalla@quicinc.com>; sartgarg@codeaurora.org; 
>> nitirawa@codeaurora.org; sayalil@codeaurora.org; Liangliang Lu 
>> <luliang@codeaurora.org>; Bao D . Nguyen <nguyenb@codeaurora.org>
>> Subject: Re: [PATCH V3 1/4] mmc: sdhci: Capture eMMC and SD card 
>> errors
>>
>> On 20/01/2022 19:26, Shaik Sajida Bhanu wrote:
>>> Add changes to capture eMMC and SD card errors.
>>> This is useful for debug and testing.
>>>
>>> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
>>> Signed-off-by: Liangliang Lu <luliang@codeaurora.org>
>>> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
>>> Signed-off-by: Bao D. Nguyen <nguyenb@codeaurora.org>
>>> ---
>>>  drivers/mmc/host/sdhci-msm.c |  3 ++
>>>  drivers/mmc/host/sdhci.c     | 72 ++++++++++++++++++++++++++++++++++++--------
>>>  include/linux/mmc/host.h     | 31 +++++++++++++++++++
>>>  3 files changed, 94 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-msm.c 
>>> b/drivers/mmc/host/sdhci-msm.c index 50c71e0..309eb7b 100644
>>> --- a/drivers/mmc/host/sdhci-msm.c
>>> +++ b/drivers/mmc/host/sdhci-msm.c
>>> @@ -128,6 +128,8 @@
>>>  
>>>  #define MSM_MMC_AUTOSUSPEND_DELAY_MS	50
>>>  
>>> +#define MSM_MMC_ERR_STATS_ENABLE 1
>>> +
>>>  /* Timeout value to avoid infinite waiting for pwr_irq */  #define 
>>> MSM_PWR_IRQ_TIMEOUT_MS 5000
>>>  
>>> @@ -2734,6 +2736,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>>>  	if (ret)
>>>  		goto pm_runtime_disable;
>>>  
>>> +	host->mmc->err_stats_enabled = MSM_MMC_ERR_STATS_ENABLE;
>>
>> Please remove this. SDHCI will enable error stats.
>>
>>>>>>>> Sure.
>>
>>>  	pm_runtime_mark_last_busy(&pdev->dev);
>>>  	pm_runtime_put_autosuspend(&pdev->dev);
>>>  
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c 
>>> index 07c6da1..74b356e 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -113,6 +113,8 @@ void sdhci_dumpregs(struct sdhci_host *host)
>>>  	if (host->ops->dump_vendor_regs)
>>>  		host->ops->dump_vendor_regs(host);
>>>  
>>> +	if (host->mmc->err_stats_enabled)
>>> +		mmc_debugfs_err_stats_enable(host->mmc);
>>
>> Please move this to sdhci_setup_host() and call it unconditionally 
>> i.e. just
>>
>> 	mmc_debugfs_err_stats_enable(host->mmc);
>>
>>
>>>>>>>>> mmc_debugfs_err_stats_enable() will set err_state , that means some errors occurred in driver level.
>> If we move this call to sdhci_setup_host(), then it will set if no errors also right?
> 
> Then it seems like you want to set err_state = true in mmc_debugfs_err_stats_inc()
> 
>>>>>> No ..I have updated  err_state = true in sdhci_dumpregs() because if any errors (serious) in driver,  we are calling sdhci_dumpregs().

I see, but it is not OK to mix up the register dump with error logging.
Perhaps add another error type and increment that when needed.

> 
>>
>>
>>>  	SDHCI_DUMP("============================================\n");
>>>  }
>>>  EXPORT_SYMBOL_GPL(sdhci_dumpregs);
>>> @@ -3159,6 +3161,8 @@ static void sdhci_timeout_timer(struct timer_list *t)
>>>  	spin_lock_irqsave(&host->lock, flags);
>>>  
>>>  	if (host->cmd && !sdhci_data_line_cmd(host->cmd)) {
>>> +		if (host->mmc && host->mmc->err_stats_enabled)
>>> +			mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_REQ_TIMEOUT);
>>
>> Please remove the 'if ()', i.e. just make it, unconditionally:
>>
>> 		mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_REQ_TIMEOUT);
>>
>> Same for other calls to mmc_debugfs_err_stats_inc()
>>
>>>>>>>>>> Sure.
>>
>>>  		pr_err("%s: Timeout waiting for hardware cmd interrupt.\n",
>>>  		       mmc_hostname(host->mmc));
>>>  		sdhci_dumpregs(host);
>>> @@ -3181,6 +3185,8 @@ static void sdhci_timeout_data_timer(struct 
>>> timer_list *t)
>>>  
>>>  	if (host->data || host->data_cmd ||
>>>  	    (host->cmd && sdhci_data_line_cmd(host->cmd))) {
>>> +		if (host->mmc && host->mmc->err_stats_enabled)
>>> +			mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_REQ_TIMEOUT);
>>>  		pr_err("%s: Timeout waiting for hardware interrupt.\n",
>>>  		       mmc_hostname(host->mmc));
>>>  		sdhci_dumpregs(host);
>>> @@ -3240,11 +3246,18 @@ static void sdhci_cmd_irq(struct sdhci_host 
>>> *host, u32 intmask, u32 *intmask_p)
>>>  
>>>  	if (intmask & (SDHCI_INT_TIMEOUT | SDHCI_INT_CRC |
>>>  		       SDHCI_INT_END_BIT | SDHCI_INT_INDEX)) {
>>> -		if (intmask & SDHCI_INT_TIMEOUT)
>>> +		if (intmask & SDHCI_INT_TIMEOUT) {
>>>  			host->cmd->error = -ETIMEDOUT;
>>> -		else
>>> +			if (host->mmc && host->mmc->err_stats_enabled)
>>> +				mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_CMD_TIMEOUT);
>>> +		} else {
>>>  			host->cmd->error = -EILSEQ;
>>> -
>>> +			if (host->cmd->opcode != MMC_SEND_TUNING_BLOCK ||
>>> +					host->cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200) {
>>> +				if (host->mmc && host->mmc->err_stats_enabled)
>>> +					mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_CMD_CRC);
>>> +			}
>>> +		}
>>>  		/* Treat data command CRC error the same as data CRC error */
>>>  		if (host->cmd->data &&
>>>  		    (intmask & (SDHCI_INT_CRC | SDHCI_INT_TIMEOUT)) == @@ -3265,6
>>> +3278,8 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 
>>> +intmask, u32 *intmask_p)
>>>  		int err = (auto_cmd_status & SDHCI_AUTO_CMD_TIMEOUT) ?
>>>  			  -ETIMEDOUT :
>>>  			  -EILSEQ;
>>> +		if (host->mmc && host->mmc->err_stats_enabled)
>>> +			mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_AUTO_CMD);
>>>  
>>>  		if (sdhci_auto_cmd23(host, mrq)) {
>>>  			mrq->sbc->error = err;
>>> @@ -3342,6 +3357,8 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>>>  			if (intmask & SDHCI_INT_DATA_TIMEOUT) {
>>>  				host->data_cmd = NULL;
>>>  				data_cmd->error = -ETIMEDOUT;
>>> +				if (host->mmc && host->mmc->err_stats_enabled)
>>> +					mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_CMD_TIMEOUT);
>>>  				__sdhci_finish_mrq(host, data_cmd->mrq);
>>>  				return;
>>>  			}
>>> @@ -3375,18 +3392,29 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>>>  		return;
>>>  	}
>>>  
>>> -	if (intmask & SDHCI_INT_DATA_TIMEOUT)
>>> +	if (intmask & SDHCI_INT_DATA_TIMEOUT) {
>>>  		host->data->error = -ETIMEDOUT;
>>> +		if (host->mmc && host->mmc->err_stats_enabled)
>>> +			mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_DAT_TIMEOUT);
>>> +	}
>>>  	else if (intmask & SDHCI_INT_DATA_END_BIT)
>>>  		host->data->error = -EILSEQ;
>>>  	else if ((intmask & SDHCI_INT_DATA_CRC) &&
>>>  		SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND))
>>> -			!= MMC_BUS_TEST_R)
>>> +			!= MMC_BUS_TEST_R) {
>>>  		host->data->error = -EILSEQ;
>>> +		if (host->cmd->opcode != MMC_SEND_TUNING_BLOCK ||
>>> +				host->cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200) {
>>> +			if (host->mmc && host->mmc->err_stats_enabled)
>>> +				mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_DAT_CRC);
>>> +		}
>>> +	}
>>>  	else if (intmask & SDHCI_INT_ADMA_ERROR) {
>>>  		pr_err("%s: ADMA error: 0x%08x\n", mmc_hostname(host->mmc),
>>>  		       intmask);
>>>  		sdhci_adma_show_error(host);
>>> +		if (host->mmc && host->mmc->err_stats_enabled)
>>> +			mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_ADMA);
>>>  		host->data->error = -EIO;
>>>  		if (host->ops->adma_workaround)
>>>  			host->ops->adma_workaround(host, intmask); @@ -3905,20 +3933,40 
>>> @@ bool sdhci_cqe_irq(struct sdhci_host *host, u32 intmask, int *cmd_error,
>>>  	if (!host->cqe_on)
>>>  		return false;
>>>  
>>> -	if (intmask & (SDHCI_INT_INDEX | SDHCI_INT_END_BIT | SDHCI_INT_CRC))
>>> +	if (intmask & (SDHCI_INT_INDEX | SDHCI_INT_END_BIT | 
>>> +SDHCI_INT_CRC)) {
>>>  		*cmd_error = -EILSEQ;
>>> -	else if (intmask & SDHCI_INT_TIMEOUT)
>>> +		if (intmask & SDHCI_INT_CRC) {
>>> +			if (host->cmd->opcode != MMC_SEND_TUNING_BLOCK ||
>>> +					host->cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200) {
>>> +				if (host->mmc && host->mmc->err_stats_enabled)
>>> +					mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_CMD_CRC);
>>> +			}
>>> +		}
>>> +	} else if (intmask & SDHCI_INT_TIMEOUT) {
>>>  		*cmd_error = -ETIMEDOUT;
>>> -	else
>>> +		if (host->mmc && host->mmc->err_stats_enabled)
>>> +			mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_CMD_TIMEOUT);
>>> +	} else
>>>  		*cmd_error = 0;
>>>  
>>> -	if (intmask & (SDHCI_INT_DATA_END_BIT | SDHCI_INT_DATA_CRC))
>>> +	if (intmask & (SDHCI_INT_DATA_END_BIT | SDHCI_INT_DATA_CRC)) {
>>>  		*data_error = -EILSEQ;
>>> -	else if (intmask & SDHCI_INT_DATA_TIMEOUT)
>>> +		if (intmask & SDHCI_INT_DATA_CRC) {
>>> +			if (host->cmd->opcode != MMC_SEND_TUNING_BLOCK ||
>>> +					host->cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200) {
>>> +				if (host->mmc && host->mmc->err_stats_enabled)
>>> +					mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_DAT_CRC);
>>> +			}
>>> +		}
>>> +	} else if (intmask & SDHCI_INT_DATA_TIMEOUT) {
>>>  		*data_error = -ETIMEDOUT;
>>> -	else if (intmask & SDHCI_INT_ADMA_ERROR)
>>> +		if (host->mmc && host->mmc->err_stats_enabled)
>>> +			mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_DAT_TIMEOUT);
>>> +	} else if (intmask & SDHCI_INT_ADMA_ERROR) {
>>>  		*data_error = -EIO;
>>> -	else
>>> +		if (host->mmc && host->mmc->err_stats_enabled)
>>> +			mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_ADMA);
>>> +	} else
>>>  		*data_error = 0;
>>>  
>>>  	/* Clear selected interrupts. */
>>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>>
>> Changes to host.h are core changes and belong in patch 3, which should be the first patch.
>>
>>>>>>> Sure.
>>
>>> index 7afb57c..883b50b 100644
>>> --- a/include/linux/mmc/host.h
>>> +++ b/include/linux/mmc/host.h
>>> @@ -93,6 +93,23 @@ struct mmc_clk_phase_map {
>>>  
>>>  struct mmc_host;
>>>  
>>> +enum mmc_err_stat {
>>> +	MMC_ERR_CMD_TIMEOUT,
>>> +	MMC_ERR_CMD_CRC,
>>> +	MMC_ERR_DAT_TIMEOUT,
>>> +	MMC_ERR_DAT_CRC,
>>> +	MMC_ERR_AUTO_CMD,
>>> +	MMC_ERR_ADMA,
>>> +	MMC_ERR_TUNING,
>>> +	MMC_ERR_CMDQ_RED,
>>> +	MMC_ERR_CMDQ_GCE,
>>> +	MMC_ERR_CMDQ_ICCE,
>>> +	MMC_ERR_REQ_TIMEOUT,
>>> +	MMC_ERR_CMDQ_REQ_TIMEOUT,
>>> +	MMC_ERR_ICE_CFG,
>>> +	MMC_ERR_MAX,
>>> +};
>>> +
>>>  struct mmc_host_ops {
>>>  	/*
>>>  	 * It is optional for the host to implement pre_req and post_req in 
>>> @@ -500,6 +517,9 @@ struct mmc_host {
>>>  
>>>  	/* Host Software Queue support */
>>>  	bool			hsq_enabled;
>>> +	u32                     err_stats[MMC_ERR_MAX];
>>> +	bool 			err_stats_enabled;
>>> +	bool			err_state;
>>
>> Please drop err_state for now
>>
>>>>>>>>> first we can check this variable right,  if it is set then we can go and check err_stats[] to know more on type of error (data /cmd timeout or CRC errors etc.).
>> Please let me know your opinion on this.
> 
> As I wrote above, you could set err_state in mmc_debugfs_err_stats_inc().
> But maybe make the err_state addition a separate patch so it is easy to see how it works.
> 
>>>>>> Sure will post separate patch for err_state settings.
> 
>>
>>>  
>>>  	unsigned long		private[] ____cacheline_aligned;
>>>  };
>>> @@ -635,6 +655,17 @@ static inline enum dma_data_direction mmc_get_dma_dir(struct mmc_data *data)
>>>  	return data->flags & MMC_DATA_WRITE ? DMA_TO_DEVICE : 
>>> DMA_FROM_DEVICE;  }
>>>  
>>> +static inline void mmc_debugfs_err_stats_enable(struct mmc_host 
>>> +*mmc)
>>
>> Please use 'host' as the mmc_host parameter in this file.
>>
>>> +{
>>> +	mmc->err_state = true;
>>
>> Let's make this:
>>
>> 	host->err_stats_enabled = true;
>>
>>>>>>>> Sure.
>>
>>> +}
>>> +
>>> +static inline void mmc_debugfs_err_stats_inc(struct mmc_host *mmc,
>>> +		enum mmc_err_stat stat) {
>>> +
>>
>> Please remove blank line here
>>
>>>>>>>> sure.
>>
>>> +	mmc->err_stats[stat] += 1;
>>> +}
>>> +
>>>  int mmc_send_tuning(struct mmc_host *host, u32 opcode, int 
>>> *cmd_error);  int mmc_send_abort_tuning(struct mmc_host *host, u32 
>>> opcode);  int mmc_get_ext_csd(struct mmc_card *card, u8 
>>> **new_ext_csd);
>>>
>>
> 

