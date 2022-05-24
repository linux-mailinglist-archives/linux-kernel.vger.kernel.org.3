Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06F95322BC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 07:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbiEXF53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 01:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234676AbiEXF5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 01:57:13 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE84C13E93;
        Mon, 23 May 2022 22:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653371828; x=1684907828;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FHI8QRmyOTRfQUFkl+0Ym1ZbTysS5KsRUOlji7tis1M=;
  b=XIAJDxnB7ybRtzkk0ZHzR/rD4PP84AbZY/hVKg/bLrzpRslRZOD3eZp7
   LfHM1iNmnDAtVTGw990kuh/NGPx5dOoIUAkyFaFUyV2mkenuGsBZXswe6
   vO0D52SmWiy9PASOTyMqyM+m1MLeFE6yBTystwExscTsUUvXR2N8LXfXe
   Q=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 23 May 2022 22:57:03 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 22:57:03 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 23 May 2022 22:57:02 -0700
Received: from [10.216.49.5] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 23 May
 2022 22:56:56 -0700
Message-ID: <da3cc8d2-4f10-feb5-50fb-9b99c61db1ad@quicinc.com>
Date:   Tue, 24 May 2022 11:26:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH V6 1/5] mmc: core: Capture eMMC and SD card errors
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
 <1652857340-6040-2-git-send-email-quic_c_sbhanu@quicinc.com>
 <23b27e40-5b6d-22cb-8e87-19e7378db849@intel.com>
From:   "Sajida Bhanu (Temp)" <quic_c_sbhanu@quicinc.com>
In-Reply-To: <23b27e40-5b6d-22cb-8e87-19e7378db849@intel.com>
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

On 5/23/2022 12:44 PM, Adrian Hunter wrote:
> On 18/05/22 10:02, Shaik Sajida Bhanu wrote:
>> Add changes to capture eMMC and SD card errors.
>> This is useful for debug and testing.
>>
>> Signed-off-by: Liangliang Lu <quic_luliang@quicinc.com>
>> Signed-off-by: Sayali Lokhande <quic_sayalil@quicinc.com>
>> Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
>> Signed-off-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
>> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
> Seems to need to be re-based on Ulf's next branch:
>
> 	git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git next
Sure Thank You for the review.
>
> Otherwise:
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>
>> ---
>>   drivers/mmc/core/core.c  | 10 +++++++++-
>>   include/linux/mmc/host.h | 26 ++++++++++++++++++++++++++
>>   2 files changed, 35 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index 368f104..5db5adf 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -943,9 +943,11 @@ int mmc_execute_tuning(struct mmc_card *card)
>>   	}
>>   
>>   	/* Only print error when we don't check for card removal */
>> -	if (!host->detect_change)
>> +	if (!host->detect_change) {
>>   		pr_err("%s: tuning execution failed: %d\n",
>>   			mmc_hostname(host), err);
>> +		mmc_debugfs_err_stats_inc(host, MMC_ERR_TUNING);
>> +	}
>>   
>>   	return err;
>>   }
>> @@ -2242,6 +2244,12 @@ void mmc_rescan(struct work_struct *work)
>>   		if (freqs[i] <= host->f_min)
>>   			break;
>>   	}
>> +
>> +	/*
>> +	 * Ignore the command timeout errors observed during
>> +	 * the card init as those are excepted.
>> +	 */
>> +	host->err_stats[MMC_ERR_CMD_TIMEOUT] = 0;
>>   	mmc_release_host(host);
>>   
>>    out:
>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>> index 0c0c9a0..0d7c0f7 100644
>> --- a/include/linux/mmc/host.h
>> +++ b/include/linux/mmc/host.h
>> @@ -93,6 +93,25 @@ struct mmc_clk_phase_map {
>>   
>>   struct mmc_host;
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
>> +	MMC_ERR_CTRL_TIMEOUT,
>> +	MMC_ERR_UNEXPECTED_IRQ,
>> +	MMC_ERR_MAX,
>> +};
>> +
>>   struct mmc_host_ops {
>>   	/*
>>   	 * It is optional for the host to implement pre_req and post_req in
>> @@ -498,6 +517,7 @@ struct mmc_host {
>>   	/* Host Software Queue support */
>>   	bool			hsq_enabled;
>>   
>> +	u32			err_stats[MMC_ERR_MAX];
>>   	unsigned long		private[] ____cacheline_aligned;
>>   };
>>   
>> @@ -632,6 +652,12 @@ static inline enum dma_data_direction mmc_get_dma_dir(struct mmc_data *data)
>>   	return data->flags & MMC_DATA_WRITE ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
>>   }
>>   
>> +static inline void mmc_debugfs_err_stats_inc(struct mmc_host *host,
>> +					     enum mmc_err_stat stat)
>> +{
>> +	host->err_stats[stat] += 1;
>> +}
>> +
>>   int mmc_send_tuning(struct mmc_host *host, u32 opcode, int *cmd_error);
>>   int mmc_send_abort_tuning(struct mmc_host *host, u32 opcode);
>>   
