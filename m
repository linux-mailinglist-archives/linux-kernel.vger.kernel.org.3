Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68170482FA1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 10:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbiACJuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 04:50:13 -0500
Received: from mga18.intel.com ([134.134.136.126]:59578 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230257AbiACJuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 04:50:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641203411; x=1672739411;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=FVGQyHKuCjh50f2p4QhEPdt73s6LuugpQ3Ux3FscjiQ=;
  b=cHYzdl93FD3XyxE4XmA2YxM3FfKfaH7ohhVuxfIZUdP50yCWTt9oGJ+B
   uy3Ezd+JkX3l3wjSeiWHuk7X0A+S5Vur5hNEENsR5gldTfajEfllP1R6b
   MalKGMzjOp7v1F1Ar9TJ5JxE1YnhDuSY6iPDMwFIEq/pXFCNFBp1Bdevu
   Ga1QFnZ528d/lhIPd3E0btdxb9yQaNYkHuE8zxzF0Xr3P889P9L4yPk9k
   zBGo2cqdit88Tu3LqpIqOcE/xwc9f+w+/jtv9eig292eLFL5WZwmlas94
   XReQ17HszVzgw0JMo/oqjwTM0835Nl/BM1bmlU6zctQdWgBJBKTDPh7Na
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10215"; a="228860193"
X-IronPort-AV: E=Sophos;i="5.88,257,1635231600"; 
   d="scan'208";a="228860193"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2022 01:50:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,257,1635231600"; 
   d="scan'208";a="610714565"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.92]) ([10.237.72.92])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Jan 2022 01:50:07 -0800
Subject: Re: [PATCH V2] mmc: debugfs: add error statistics
To:     "Sajida Bhanu (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>,
        "riteshh@codeaurora.org" <riteshh@codeaurora.org>,
        "Asutosh Das (asd)" <asutoshd@quicinc.com>,
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
        "sayalil@codeaurora.org" <sayalil@codeaurora.org>
References: <1639492863-7053-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <9fbec373-e667-b4a5-4b92-741f9dd2b7ee@intel.com>
 <SJ0PR02MB84499B152C13E541E19DBFB4CD7C9@SJ0PR02MB8449.namprd02.prod.outlook.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <4ba587c1-2092-285c-c13c-e3ed69fec403@intel.com>
Date:   Mon, 3 Jan 2022 11:50:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <SJ0PR02MB84499B152C13E541E19DBFB4CD7C9@SJ0PR02MB8449.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/12/2021 09:16, Sajida Bhanu (Temp) (QUIC) wrote:
> Hi Adrian,
> 
> Thanks for the review.
> 
> Please find the inline comments.

I find the way the inline comments are done a bit difficult to follow, since what I wrote is not quoted, and what you wrote is quoted.  Normally it is the other way around.

> 
> Thanks,
> Sajida
> 
> -----Original Message-----
> From: Adrian Hunter <adrian.hunter@intel.com> 
> Sent: Wednesday, December 15, 2021 7:33 PM
> To: Sajida Bhanu (Temp) (QUIC) <quic_c_sbhanu@quicinc.com>; riteshh@codeaurora.org; Asutosh Das (asd) <asutoshd@quicinc.com>; ulf.hansson@linaro.org; agross@kernel.org; bjorn.andersson@linaro.org; linux-mmc@vger.kernel.org; linux-arm-msm@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: stummala@codeaurora.org; vbadigan@codeaurora.org; Ram Prakash Gupta (QUIC) <quic_rampraka@quicinc.com>; Pradeep Pragallapati (QUIC) <quic_pragalla@quicinc.com>; sartgarg@codeaurora.org; nitirawa@codeaurora.org; sayalil@codeaurora.org
> Subject: Re: [PATCH V2] mmc: debugfs: add error statistics
> 
> On 14/12/2021 16:41, Shaik Sajida Bhanu wrote:
>> Add debugfs entry to query eMMC and SD card errors statistics.
>> This feature is useful for debug and testing
>>
>> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
>> ---
>>
>> Changes since V1:
>> 	-Removed sysfs entry for eMMC and SD card error statistics and added
>> 	 debugfs entry as suggested by Adrian Hunter and Ulf Hansson.
> 
> Thanks for doing this.
> 
>> ---
>>  drivers/mmc/core/debugfs.c | 106 +++++++++++++++++++++++++++++++++++++++++++++
>>  drivers/mmc/core/queue.c   |   2 +
>>  drivers/mmc/host/sdhci.c   |  53 ++++++++++++++++++-----
>>  include/linux/mmc/host.h   |  37 ++++++++++++++++
>>  4 files changed, 186 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c 
>> index 3fdbc80..40210c34 100644
>> --- a/drivers/mmc/core/debugfs.c
>> +++ b/drivers/mmc/core/debugfs.c
>> @@ -223,6 +223,107 @@ static int mmc_clock_opt_set(void *data, u64 
>> val)  DEFINE_DEBUGFS_ATTRIBUTE(mmc_clock_fops, mmc_clock_opt_get, mmc_clock_opt_set,
>>  	"%llu\n");
>>  
>> +static int mmc_err_state_get(void *data, u64 *val) {
>> +	struct mmc_host *host = data;
>> +
>> +	if (!host)
>> +		return -EINVAL;
>> +
>> +	*val = host->err_state ? 1 : 0;
>> +
>> +	return 0;
>> +}
>> +
>> +static int mmc_err_state_clear(void *data, u64 val) {
>> +	struct mmc_host *host = data;
>> +
>> +	if (!host)
>> +		return -EINVAL;
>> +
>> +	host->err_state = false;
> 
> Is there much reason to disable err stats from userspace?
> 
>>>>>> Yes , while debugging we can go and check err_state , It is false means no errors happened in driver level and true means errors happened in driver level and then we can go and check err_stats[] to know more on error details like data CRC , command CRC etc.

That is not exectly how it is programmed.  "err_state is false" means no errors have been recorded, not that no errors happended.

> 
>> +
>> +	return 0;
>> +}
>> +
>> +DEFINE_SIMPLE_ATTRIBUTE(mmc_err_state, mmc_err_state_get,
>> +		mmc_err_state_clear, "%llu\n");
>> +
>> +static int mmc_err_stats_show(struct seq_file *file, void *data) {
>> +	struct mmc_host *host = (struct mmc_host *)file->private;
>> +
>> +	if (!host)
>> +		return -EINVAL;
> 
> I was thinking we needed a way to determine whether stats were being collected because not all drivers would support it at least initially e.g.
> 
> 	if (!host->err_stats_enabled) {
> 		seq_printf(file, "Not supported by driver\n");
> 		return 0;
> 	}
> 
>>>>>>>> You mean declare another variable (err_stats_enabled) and enable it in probe?

Yes, although it is not clear if this is the same as what you want from err_state,
i.e. is err_state different from err_stats_enabled?

> 
>> +
>> +	seq_printf(file, "# Command Timeout Occurred:\t %d\n",
>> +		   host->err_stats[MMC_ERR_CMD_TIMEOUT]);
> 
> Maybe put the descriptions in an array and iterate e.g.
> 
> 	const char *desc[MMC_ERR_MAX] = {
> 		[MMC_ERR_CMD_TIMEOUT] = "Command Timeout Occurred",
> 		etc
> 	};
> 	int i;
> 
> 	if (!host)
> 		return -EINVAL;
> 
> 	for (i = 0; i < MMC_ERR_MAX; i++) {
> 		if (desc[i])
> 			seq_printf(file, "# %s:\t %d\n",
> 				   desc[1], host->err_stats[i]);
> 	}
> 
>>>>>>>> Sure 
> 
>> +
>> +	seq_printf(file, "# Command CRC Errors Occurred:\t %d\n",
>> +		   host->err_stats[MMC_ERR_CMD_CRC]);
>> +
>> +	seq_printf(file, "# Data Timeout Occurred:\t %d\n",
>> +		   host->err_stats[MMC_ERR_DAT_TIMEOUT]);
>> +
>> +	seq_printf(file, "# Data CRC Errors Occurred:\t %d\n",
>> +		   host->err_stats[MMC_ERR_DAT_CRC]);
>> +
>> +	seq_printf(file, "# Auto-Cmd Error Occurred:\t %d\n",
>> +		   host->err_stats[MMC_ERR_ADMA]);
>> +
>> +	seq_printf(file, "# ADMA Error Occurred:\t %d\n",
>> +		   host->err_stats[MMC_ERR_ADMA]);
>> +
>> +	seq_printf(file, "# Tuning Error Occurred:\t %d\n",
>> +		   host->err_stats[MMC_ERR_TUNING]);
>> +
>> +	seq_printf(file, "# CMDQ RED Errors:\t\t %d\n",
>> +		   host->err_stats[MMC_ERR_CMDQ_RED]);
>> +
>> +	seq_printf(file, "# CMDQ GCE Errors:\t\t %d\n",
>> +		   host->err_stats[MMC_ERR_CMDQ_GCE]);
>> +
>> +	seq_printf(file, "# CMDQ ICCE Errors:\t\t %d\n",
>> +		   host->err_stats[MMC_ERR_CMDQ_ICCE]);
>> +
>> +	seq_printf(file, "# Request Timedout:\t %d\n",
>> +		   host->err_stats[MMC_ERR_REQ_TIMEOUT]);
>> +
>> +	seq_printf(file, "# CMDQ Request Timedout:\t %d\n",
>> +		   host->err_stats[MMC_ERR_CMDQ_REQ_TIMEOUT]);
>> +
>> +	seq_printf(file, "# ICE Config Errors:\t\t %d\n",
>> +		   host->err_stats[MMC_ERR_ICE_CFG]);
>> +
>> +	return 0;
>> +}
>> +
>> +static int mmc_err_stats_open(struct inode *inode, struct file *file) 
>> +{
>> +	return single_open(file, mmc_err_stats_show, inode->i_private); }
>> +
>> +static ssize_t mmc_err_stats_write(struct file *filp, const char __user *ubuf,
>> +				   size_t cnt, loff_t *ppos)
>> +{
>> +	struct mmc_host *host = filp->f_mapping->host->i_private;
>> +
>> +	if (!host)
>> +		return -EINVAL;
>> +
>> +	pr_debug("%s: Resetting MMC error statistics\n", __func__);
>> +	memset(host->err_stats, 0, sizeof(host->err_stats));
>> +
>> +	return cnt;
>> +}
>> +
>> +static const struct file_operations mmc_err_stats_fops = {
>> +	.open	= mmc_err_stats_open,
>> +	.read	= seq_read,
>> +	.write	= mmc_err_stats_write,
>> +};
>> +
>>  void mmc_add_host_debugfs(struct mmc_host *host)  {
>>  	struct dentry *root;
>> @@ -236,6 +337,11 @@ void mmc_add_host_debugfs(struct mmc_host *host)
>>  	debugfs_create_file_unsafe("clock", S_IRUSR | S_IWUSR, root, host,
>>  				   &mmc_clock_fops);
>>  
>> +	debugfs_create_file("err_state", 0600, root, host,
>> +		&mmc_err_state);
>> +	debugfs_create_file("err_stats", 0600, root, host,
>> +		&mmc_err_stats_fops);
>> +
>>  #ifdef CONFIG_FAIL_MMC_REQUEST
>>  	if (fail_request)
>>  		setup_fault_attr(&fail_default_attr, fail_request); diff --git 
>> a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c index 
>> b15c034..5243929 100644
>> --- a/drivers/mmc/core/queue.c
>> +++ b/drivers/mmc/core/queue.c
>> @@ -100,6 +100,8 @@ static enum blk_eh_timer_return mmc_cqe_timed_out(struct request *req)
>>  	enum mmc_issue_type issue_type = mmc_issue_type(mq, req);
>>  	bool recovery_needed = false;
>>  
>> +	mmc_debugfs_err_stats_inc(host, MMC_ERR_CMDQ_REQ_TIMEOUT);
>> +
>>  	switch (issue_type) {
>>  	case MMC_ISSUE_ASYNC:
>>  	case MMC_ISSUE_DCMD:
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> 
> I think the core changes should be a separate patch from sdhci.
> I would probably split into 4:
> 	mmc core
> 	mmc block driver
> 	cqhci driver
> 	sdhci driver
> 
>>>>> Sure
> 
>> index 07c6da1..d742051 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -113,6 +113,7 @@ void sdhci_dumpregs(struct sdhci_host *host)
>>  	if (host->ops->dump_vendor_regs)
>>  		host->ops->dump_vendor_regs(host);
>>  
>> +	mmc_debugfs_err_stats_enable(host->mmc);
> 
> Why here and not in e.g. __sdhci_add_host() ?
> 
>>>>> If any errors happened  in driver level then we will call sdhci_dumpregs() right( err_state true means some errors happened in driver level ).  So it is better to call mmc_debugfs_err_stats_enable() here.

Registers are not dumped for most errors.  Please move this to __sdhci_add_host().

> 
>>  	SDHCI_DUMP("============================================\n");
>>  }
>>  EXPORT_SYMBOL_GPL(sdhci_dumpregs);
>> @@ -3159,6 +3160,7 @@ static void sdhci_timeout_timer(struct timer_list *t)
>>  	spin_lock_irqsave(&host->lock, flags);
>>  
>>  	if (host->cmd && !sdhci_data_line_cmd(host->cmd)) {
>> +		mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_REQ_TIMEOUT);
>>  		pr_err("%s: Timeout waiting for hardware cmd interrupt.\n",
>>  		       mmc_hostname(host->mmc));
>>  		sdhci_dumpregs(host);
>> @@ -3181,6 +3183,7 @@ static void sdhci_timeout_data_timer(struct 
>> timer_list *t)
>>  
>>  	if (host->data || host->data_cmd ||
>>  	    (host->cmd && sdhci_data_line_cmd(host->cmd))) {
>> +		mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_REQ_TIMEOUT);
>>  		pr_err("%s: Timeout waiting for hardware interrupt.\n",
>>  		       mmc_hostname(host->mmc));
>>  		sdhci_dumpregs(host);
>> @@ -3240,11 +3243,15 @@ static void sdhci_cmd_irq(struct sdhci_host 
>> *host, u32 intmask, u32 *intmask_p)
>>  
>>  	if (intmask & (SDHCI_INT_TIMEOUT | SDHCI_INT_CRC |
>>  		       SDHCI_INT_END_BIT | SDHCI_INT_INDEX)) {
>> -		if (intmask & SDHCI_INT_TIMEOUT)
>> +		if (intmask & SDHCI_INT_TIMEOUT) {
>>  			host->cmd->error = -ETIMEDOUT;
>> -		else
>> +			mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_CMD_TIMEOUT);
>> +		} else {
>>  			host->cmd->error = -EILSEQ;
>> -
>> +			if (host->cmd->opcode != MMC_SEND_TUNING_BLOCK ||
>> +					host->cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200)
>> +				mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_CMD_CRC);
>> +		}
>>  		/* Treat data command CRC error the same as data CRC error */
>>  		if (host->cmd->data &&
>>  		    (intmask & (SDHCI_INT_CRC | SDHCI_INT_TIMEOUT)) == @@ -3266,6 
>> +3273,7 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *intmask_p)
>>  			  -ETIMEDOUT :
>>  			  -EILSEQ;
>>  
>> +		mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_AUTO_CMD);
>>  		if (sdhci_auto_cmd23(host, mrq)) {
>>  			mrq->sbc->error = err;
>>  			__sdhci_finish_mrq(host, mrq);
>> @@ -3342,6 +3350,7 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>>  			if (intmask & SDHCI_INT_DATA_TIMEOUT) {
>>  				host->data_cmd = NULL;
>>  				data_cmd->error = -ETIMEDOUT;
>> +				mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_CMD_TIMEOUT);
>>  				__sdhci_finish_mrq(host, data_cmd->mrq);
>>  				return;
>>  			}
>> @@ -3375,18 +3384,25 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>>  		return;
>>  	}
>>  
>> -	if (intmask & SDHCI_INT_DATA_TIMEOUT)
>> +	if (intmask & SDHCI_INT_DATA_TIMEOUT) {
>>  		host->data->error = -ETIMEDOUT;
>> +		mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_DAT_TIMEOUT);
>> +	}
>>  	else if (intmask & SDHCI_INT_DATA_END_BIT)
>>  		host->data->error = -EILSEQ;
>>  	else if ((intmask & SDHCI_INT_DATA_CRC) &&
>>  		SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND))
>> -			!= MMC_BUS_TEST_R)
>> +			!= MMC_BUS_TEST_R) {
>>  		host->data->error = -EILSEQ;
>> +		if (host->cmd->opcode != MMC_SEND_TUNING_BLOCK ||
>> +				host->cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200)
>> +			mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_DAT_CRC);
>> +	}
>>  	else if (intmask & SDHCI_INT_ADMA_ERROR) {
>>  		pr_err("%s: ADMA error: 0x%08x\n", mmc_hostname(host->mmc),
>>  		       intmask);
>>  		sdhci_adma_show_error(host);
>> +		mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_ADMA);
>>  		host->data->error = -EIO;
>>  		if (host->ops->adma_workaround)
>>  			host->ops->adma_workaround(host, intmask); @@ -3905,20 +3921,33 @@ 
>> bool sdhci_cqe_irq(struct sdhci_host *host, u32 intmask, int *cmd_error,
>>  	if (!host->cqe_on)
>>  		return false;
>>  
>> -	if (intmask & (SDHCI_INT_INDEX | SDHCI_INT_END_BIT | SDHCI_INT_CRC))
>> +	if (intmask & (SDHCI_INT_INDEX | SDHCI_INT_END_BIT | SDHCI_INT_CRC)) 
>> +{
>>  		*cmd_error = -EILSEQ;
>> -	else if (intmask & SDHCI_INT_TIMEOUT)
>> +		if (intmask & SDHCI_INT_CRC) {
>> +			if (host->cmd->opcode != MMC_SEND_TUNING_BLOCK ||
>> +					host->cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200)
>> +				mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_CMD_CRC);
>> +		}
>> +	} else if (intmask & SDHCI_INT_TIMEOUT) {
>>  		*cmd_error = -ETIMEDOUT;
>> -	else
>> +		mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_CMD_TIMEOUT);
>> +	} else
>>  		*cmd_error = 0;
>>  
>> -	if (intmask & (SDHCI_INT_DATA_END_BIT | SDHCI_INT_DATA_CRC))
>> +	if (intmask & (SDHCI_INT_DATA_END_BIT | SDHCI_INT_DATA_CRC)) {
>>  		*data_error = -EILSEQ;
>> -	else if (intmask & SDHCI_INT_DATA_TIMEOUT)
>> +		if (intmask & SDHCI_INT_DATA_CRC) {
>> +			if (host->cmd->opcode != MMC_SEND_TUNING_BLOCK ||
>> +					host->cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200)
>> +				mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_DAT_CRC);
>> +		}
>> +	} else if (intmask & SDHCI_INT_DATA_TIMEOUT) {
>>  		*data_error = -ETIMEDOUT;
>> -	else if (intmask & SDHCI_INT_ADMA_ERROR)
>> +		mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_DAT_TIMEOUT);
>> +	} else if (intmask & SDHCI_INT_ADMA_ERROR) {
>>  		*data_error = -EIO;
>> -	else
>> +		mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_ADMA);
>> +	} else
>>  		*data_error = 0;
>>  
>>  	/* Clear selected interrupts. */
>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h index 
>> 7afb57c..c263f8f 100644
>> --- a/include/linux/mmc/host.h
>> +++ b/include/linux/mmc/host.h
>> @@ -93,6 +93,23 @@ struct mmc_clk_phase_map {
>>  
>>  struct mmc_host;
>>  
>> +enum mmc_err_stat {
>> +	MMC_ERR_CMD_TIMEOUT,
>> +	MMC_ERR_CMD_CRC,
>> +	MMC_ERR_DAT_TIMEOUT,
>> +	MMC_ERR_DAT_CRC,
>> +	MMC_ERR_AUTO_CMD,
>> +	MMC_ERR_ADMA,
>> +	MMC_ERR_TUNING,
>> +	MMC_ERR_CMDQ_RED,
>> +	MMC_ERR_CMDQ_GCE,
>> +	MMC_ERR_CMDQ_ICCE,
>> +	MMC_ERR_REQ_TIMEOUT,
>> +	MMC_ERR_CMDQ_REQ_TIMEOUT,
>> +	MMC_ERR_ICE_CFG,
>> +	MMC_ERR_MAX,
>> +};
>> +
>>  struct mmc_host_ops {
>>  	/*
>>  	 * It is optional for the host to implement pre_req and post_req in 
>> @@ -500,6 +517,8 @@ struct mmc_host {
>>  
>>  	/* Host Software Queue support */
>>  	bool			hsq_enabled;
>> +	u32                     err_stats[MMC_ERR_MAX];
> 
> If you make it u64 then we don't have to think about the value overflowing.
> 
>>>> Sure
> 
>> +	bool			err_state;
>>  
>>  	unsigned long		private[] ____cacheline_aligned;
>>  };
>> @@ -635,6 +654,24 @@ static inline enum dma_data_direction mmc_get_dma_dir(struct mmc_data *data)
>>  	return data->flags & MMC_DATA_WRITE ? DMA_TO_DEVICE : 
>> DMA_FROM_DEVICE;  }
>>  
>> +static inline void mmc_debugfs_err_stats_enable(struct mmc_host *mmc) 
>> +{
>> +	mmc->err_state = true;
>> +}
>> +
>> +static inline void mmc_debugfs_err_stats_inc(struct mmc_host *mmc,
>> +		enum mmc_err_stat stat) {
>> +
>> +	/*
>> +	 * Ignore the command timeout errors observed during
>> +	 * the card init as those are excepted.
>> +	 */
>> +	if (!mmc->err_state)
>> +		mmc->err_stats[MMC_ERR_CMD_TIMEOUT] = 0;
> 
> This would be better handled in the card init code somewhere, not here.
> 
>>>>> Sure.
> 
>> +
>> +	mmc->err_stats[stat] += 1;
>> +}
>> +
>>  int mmc_send_tuning(struct mmc_host *host, u32 opcode, int 
>> *cmd_error);  int mmc_send_abort_tuning(struct mmc_host *host, u32 
>> opcode);  int mmc_get_ext_csd(struct mmc_card *card, u8 
>> **new_ext_csd);
>>
> 

