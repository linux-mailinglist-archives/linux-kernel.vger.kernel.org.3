Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168E953229C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 07:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbiEXFsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 01:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbiEXFsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 01:48:43 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC8B55487;
        Mon, 23 May 2022 22:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653371322; x=1684907322;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ICDQEeff55Q5ppoKsc2WzqCAuVZf3QAJdDgf/74KjG8=;
  b=oL1HkXI+o7Uc1b1DxCu6qt1nMiz6fqjagk3R4TC8jaW+oHznRnP7v3Fi
   FjTsy9oxXLfGHrcsnLdzmAkkawLp9aL0UNmxjqD2aPUg6IIla/rHIfdja
   FrJlyl9mY6+Xmfsgf23OnAbeuzMH3Wqd+W4aVaimBMnlt8EiDRTZh8IE6
   0=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 23 May 2022 22:48:42 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 22:48:41 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 23 May 2022 22:48:41 -0700
Received: from [10.216.49.5] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 23 May
 2022 22:48:35 -0700
Message-ID: <fb990092-e855-3421-3996-d481fb6b08ef@quicinc.com>
Date:   Tue, 24 May 2022 11:18:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH V6 2/5] mmc: sdhci: Capture eMMC and SD card errors
Content-Language: en-US
To:     Adrian Hunter <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <wsa+renesas@sang-engineering.com>, <shawn.lin@rock-chips.com>,
        <yoshihiro.shimoda.uh@renesas.com>, <digetx@gmail.com>,
        <quic_asutoshd@quicinc.com>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_rampraka@quicinc.com>,
        <quic_pragalla@quicinc.com>, <quic_sartgarg@quicinc.com>,
        <quic_nitirawa@quicinc.com>, <quic_sayalil@quicinc.com>,
        Liangliang Lu <quic_luliang@quicinc.com>,
        "Bao D . Nguyen" <quic_nguyenb@quicinc.com>
References: <1652857340-6040-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <1652857340-6040-3-git-send-email-quic_c_sbhanu@quicinc.com>
 <2fe7d7a1-b6ab-3268-3a9b-20d79086eec6@intel.com>
From:   "Sajida Bhanu (Temp)" <quic_c_sbhanu@quicinc.com>
In-Reply-To: <2fe7d7a1-b6ab-3268-3a9b-20d79086eec6@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrain,

Thank You for the review.

Please find the inline comments.

Thanks,

Sajida

On 5/23/2022 12:44 PM, Adrian Hunter wrote:
> On 18/05/22 10:02, Shaik Sajida Bhanu wrote:
>> Add changes to capture eMMC and SD card errors.
>> This is useful for debug and testing.
>>
>> Signed-off-by: Liangliang Lu <quic_luliang@quicinc.com>
>> Signed-off-by: Sayali Lokhande <quic_sayalil@quicinc.com>
>> Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
>> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
> Misplaced blank line (see below) and seems to need to be
Sure will address
> re-based on Ulf's next branch:
>
> 	git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git next
>
> Otherwise:
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>
>> ---
>>   drivers/mmc/host/sdhci.c | 59 ++++++++++++++++++++++++++++++++++++------------
>>   drivers/mmc/host/sdhci.h |  3 +++
>>   include/linux/mmc/mmc.h  |  6 +++++
>>   3 files changed, 53 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 7728f26..bd4372c 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -224,6 +224,7 @@ void sdhci_reset(struct sdhci_host *host, u8 mask)
>>   		if (timedout) {
>>   			pr_err("%s: Reset 0x%x never completed.\n",
>>   				mmc_hostname(host->mmc), (int)mask);
>> +			sdhci_err_stats_inc(host, CTRL_TIMEOUT);
>>   			sdhci_dumpregs(host);
>>   			return;
>>   		}
>> @@ -1719,6 +1720,7 @@ static bool sdhci_send_command_retry(struct sdhci_host *host,
>>   		if (!timeout--) {
>>   			pr_err("%s: Controller never released inhibit bit(s).\n",
>>   			       mmc_hostname(host->mmc));
>> +			sdhci_err_stats_inc(host, CTRL_TIMEOUT);
>>   			sdhci_dumpregs(host);
>>   			cmd->error = -EIO;
>>   			return false;
>> @@ -1968,6 +1970,7 @@ void sdhci_enable_clk(struct sdhci_host *host, u16 clk)
>>   		if (timedout) {
>>   			pr_err("%s: Internal clock never stabilised.\n",
>>   			       mmc_hostname(host->mmc));
>> +			sdhci_err_stats_inc(host, CTRL_TIMEOUT);
>>   			sdhci_dumpregs(host);
>>   			return;
>>   		}
>> @@ -1990,6 +1993,7 @@ void sdhci_enable_clk(struct sdhci_host *host, u16 clk)
>>   			if (timedout) {
>>   				pr_err("%s: PLL clock never stabilised.\n",
>>   				       mmc_hostname(host->mmc));
>> +				sdhci_err_stats_inc(host, CTRL_TIMEOUT);
>>   				sdhci_dumpregs(host);
>>   				return;
>>   			}
>> @@ -3145,6 +3149,7 @@ static void sdhci_timeout_timer(struct timer_list *t)
>>   	if (host->cmd && !sdhci_data_line_cmd(host->cmd)) {
>>   		pr_err("%s: Timeout waiting for hardware cmd interrupt.\n",
>>   		       mmc_hostname(host->mmc));
>> +		sdhci_err_stats_inc(host, REQ_TIMEOUT);
>>   		sdhci_dumpregs(host);
>>   
>>   		host->cmd->error = -ETIMEDOUT;
>> @@ -3167,6 +3172,7 @@ static void sdhci_timeout_data_timer(struct timer_list *t)
>>   	    (host->cmd && sdhci_data_line_cmd(host->cmd))) {
>>   		pr_err("%s: Timeout waiting for hardware interrupt.\n",
>>   		       mmc_hostname(host->mmc));
>> +		sdhci_err_stats_inc(host, REQ_TIMEOUT);
>>   		sdhci_dumpregs(host);
>>   
>>   		if (host->data) {
>> @@ -3218,17 +3224,21 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *intmask_p)
>>   			return;
>>   		pr_err("%s: Got command interrupt 0x%08x even though no command operation was in progress.\n",
>>   		       mmc_hostname(host->mmc), (unsigned)intmask);
>> +		sdhci_err_stats_inc(host, UNEXPECTED_IRQ);
>>   		sdhci_dumpregs(host);
>>   		return;
>>   	}
>>   
>>   	if (intmask & (SDHCI_INT_TIMEOUT | SDHCI_INT_CRC |
>>   		       SDHCI_INT_END_BIT | SDHCI_INT_INDEX)) {
>> -		if (intmask & SDHCI_INT_TIMEOUT)
>> +		if (intmask & SDHCI_INT_TIMEOUT) {
>>   			host->cmd->error = -ETIMEDOUT;
>> -		else
>> +			sdhci_err_stats_inc(host, CMD_TIMEOUT);
>> +		} else {
>>   			host->cmd->error = -EILSEQ;
>> -
>> +			if (!mmc_op_tuning(host->cmd->opcode))
>> +				sdhci_err_stats_inc(host, CMD_CRC);
>> +		}
>>   		/* Treat data command CRC error the same as data CRC error */
>>   		if (host->cmd->data &&
>>   		    (intmask & (SDHCI_INT_CRC | SDHCI_INT_TIMEOUT)) ==
>> @@ -3249,6 +3259,8 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *intmask_p)
>>   		int err = (auto_cmd_status & SDHCI_AUTO_CMD_TIMEOUT) ?
>>   			  -ETIMEDOUT :
>>   			  -EILSEQ;
> Blank line better here
>
>> +		sdhci_err_stats_inc(host, AUTO_CMD);
>> +
> This makes double blank line
>
>>   
>>   		if (mrq->sbc && (host->flags & SDHCI_AUTO_CMD23)) {
>>   			mrq->sbc->error = err;
>> @@ -3326,6 +3338,7 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>>   			if (intmask & SDHCI_INT_DATA_TIMEOUT) {
>>   				host->data_cmd = NULL;
>>   				data_cmd->error = -ETIMEDOUT;
>> +				sdhci_err_stats_inc(host, CMD_TIMEOUT);
>>   				__sdhci_finish_mrq(host, data_cmd->mrq);
>>   				return;
>>   			}
>> @@ -3354,23 +3367,30 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>>   
>>   		pr_err("%s: Got data interrupt 0x%08x even though no data operation was in progress.\n",
>>   		       mmc_hostname(host->mmc), (unsigned)intmask);
>> +		sdhci_err_stats_inc(host, UNEXPECTED_IRQ);
>>   		sdhci_dumpregs(host);
>>   
>>   		return;
>>   	}
>>   
>> -	if (intmask & SDHCI_INT_DATA_TIMEOUT)
>> +	if (intmask & SDHCI_INT_DATA_TIMEOUT) {
>>   		host->data->error = -ETIMEDOUT;
>> -	else if (intmask & SDHCI_INT_DATA_END_BIT)
>> +		sdhci_err_stats_inc(host, DAT_TIMEOUT);
>> +	} else if (intmask & SDHCI_INT_DATA_END_BIT) {
>>   		host->data->error = -EILSEQ;
>> -	else if ((intmask & SDHCI_INT_DATA_CRC) &&
>> +		if (!mmc_op_tuning(SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND))))
>> +			sdhci_err_stats_inc(host, DAT_CRC);
>> +	} else if ((intmask & SDHCI_INT_DATA_CRC) &&
>>   		SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND))
>> -			!= MMC_BUS_TEST_R)
>> +			!= MMC_BUS_TEST_R) {
>>   		host->data->error = -EILSEQ;
>> -	else if (intmask & SDHCI_INT_ADMA_ERROR) {
>> +		if (!mmc_op_tuning(SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND))))
>> +			sdhci_err_stats_inc(host, DAT_CRC);
>> +	} else if (intmask & SDHCI_INT_ADMA_ERROR) {
>>   		pr_err("%s: ADMA error: 0x%08x\n", mmc_hostname(host->mmc),
>>   		       intmask);
>>   		sdhci_adma_show_error(host);
>> +		sdhci_err_stats_inc(host, ADMA);
>>   		host->data->error = -EIO;
>>   		if (host->ops->adma_workaround)
>>   			host->ops->adma_workaround(host, intmask);
>> @@ -3568,6 +3588,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
>>   	if (unexpected) {
>>   		pr_err("%s: Unexpected interrupt 0x%08x.\n",
>>   			   mmc_hostname(host->mmc), unexpected);
>> +		sdhci_err_stats_inc(host, UNEXPECTED_IRQ);
>>   		sdhci_dumpregs(host);
>>   	}
>>   
>> @@ -3889,20 +3910,27 @@ bool sdhci_cqe_irq(struct sdhci_host *host, u32 intmask, int *cmd_error,
>>   	if (!host->cqe_on)
>>   		return false;
>>   
>> -	if (intmask & (SDHCI_INT_INDEX | SDHCI_INT_END_BIT | SDHCI_INT_CRC))
>> +	if (intmask & (SDHCI_INT_INDEX | SDHCI_INT_END_BIT | SDHCI_INT_CRC)) {
>>   		*cmd_error = -EILSEQ;
>> -	else if (intmask & SDHCI_INT_TIMEOUT)
>> +		if (!mmc_op_tuning(host->cmd->opcode))
>> +			sdhci_err_stats_inc(host, CMD_CRC);
>> +	} else if (intmask & SDHCI_INT_TIMEOUT) {
>>   		*cmd_error = -ETIMEDOUT;
>> -	else
>> +		sdhci_err_stats_inc(host, CMD_TIMEOUT);
>> +	} else
>>   		*cmd_error = 0;
>>   
>> -	if (intmask & (SDHCI_INT_DATA_END_BIT | SDHCI_INT_DATA_CRC))
>> +	if (intmask & (SDHCI_INT_DATA_END_BIT | SDHCI_INT_DATA_CRC)) {
>>   		*data_error = -EILSEQ;
>> -	else if (intmask & SDHCI_INT_DATA_TIMEOUT)
>> +		if (!mmc_op_tuning(host->cmd->opcode))
>> +			sdhci_err_stats_inc(host, DAT_CRC);
>> +	} else if (intmask & SDHCI_INT_DATA_TIMEOUT) {
>>   		*data_error = -ETIMEDOUT;
>> -	else if (intmask & SDHCI_INT_ADMA_ERROR)
>> +		sdhci_err_stats_inc(host, DAT_TIMEOUT);
>> +	} else if (intmask & SDHCI_INT_ADMA_ERROR) {
>>   		*data_error = -EIO;
>> -	else
>> +		sdhci_err_stats_inc(host, ADMA);
>> +	} else
>>   		*data_error = 0;
>>   
>>   	/* Clear selected interrupts. */
>> @@ -3918,6 +3946,7 @@ bool sdhci_cqe_irq(struct sdhci_host *host, u32 intmask, int *cmd_error,
>>   		sdhci_writel(host, intmask, SDHCI_INT_STATUS);
>>   		pr_err("%s: CQE: Unexpected interrupt 0x%08x.\n",
>>   		       mmc_hostname(host->mmc), intmask);
>> +		sdhci_err_stats_inc(host, UNEXPECTED_IRQ);
>>   		sdhci_dumpregs(host);
>>   	}
>>   
>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>> index 6c689be..2c02ded 100644
>> --- a/drivers/mmc/host/sdhci.h
>> +++ b/drivers/mmc/host/sdhci.h
>> @@ -356,6 +356,9 @@ struct sdhci_adma2_64_desc {
>>    */
>>   #define MMC_CMD_TRANSFER_TIME	(10 * NSEC_PER_MSEC) /* max 10 ms */
>>   
>> +#define sdhci_err_stats_inc(host, err_name) \
>> +	mmc_debugfs_err_stats_inc((host)->mmc, MMC_ERR_##err_name)
>> +
>>   enum sdhci_cookie {
>>   	COOKIE_UNMAPPED,
>>   	COOKIE_PRE_MAPPED,	/* mapped by sdhci_pre_req() */
>> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
>> index d9a65c6..9c50bc4 100644
>> --- a/include/linux/mmc/mmc.h
>> +++ b/include/linux/mmc/mmc.h
>> @@ -99,6 +99,12 @@ static inline bool mmc_op_multi(u32 opcode)
>>   	       opcode == MMC_READ_MULTIPLE_BLOCK;
>>   }
>>   
>> +static inline bool mmc_op_tuning(u32 opcode)
>> +{
>> +	return opcode == MMC_SEND_TUNING_BLOCK ||
>> +			opcode == MMC_SEND_TUNING_BLOCK_HS200;
>> +}
>> +
>>   /*
>>    * MMC_SWITCH argument format:
>>    *
