Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725DD51F8C5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 12:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbiEIJyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 05:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240057AbiEIJsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 05:48:11 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28566AE266;
        Mon,  9 May 2022 02:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652089458; x=1683625458;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LHL52xpf9fNO2i40bs+m4ylQ6avZ700ivayzAClrluA=;
  b=VvCFg2x9v6WXDtpufiSDRZuNY8tEyjYs0OcQRgZ/6he9iDei/m3sdcrX
   wXvhbc6RSYaf8L183YLR6TzIcck6eyxj9ekI1VlRci2RftOjLvo72LX3B
   UWPirkn3GdXis3fRexhKH9hTXoRR7nyLV0iO7ZKh8Y1kWvtB9JIvRiz+U
   4=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 09 May 2022 02:44:18 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 02:44:17 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 9 May 2022 02:44:16 -0700
Received: from [10.216.5.153] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 9 May 2022
 02:44:11 -0700
Message-ID: <42d7cbc9-06ec-20c3-71fb-23edb451ff9c@quicinc.com>
Date:   Mon, 9 May 2022 15:14:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH V5 4/5] mmc: debugfs: Add debug fs error state entry for
 mmc driver
Content-Language: en-US
To:     Adrian Hunter <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <wsa+renesas@sang-engineering.com>,
        <yoshihiro.shimoda.uh@renesas.com>, <linus.walleij@linaro.org>,
        <digetx@gmail.com>, <briannorris@chromium.org>,
        <quic_riteshh@quicinc.com>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_asutoshd@quicinc.com>, <quic_rampraka@quicinc.com>,
        <quic_pragalla@quicinc.com>, <quic_sartgarg@quicinc.com>,
        <quic_nitirawa@quicinc.com>, <quic_sayalil@quicinc.com>,
        Liangliang Lu <quic_luliang@quicinc.com>,
        "Bao D . Nguyen" <quic_nguyenb@quicinc.com>
References: <1650902443-26357-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <1650902443-26357-5-git-send-email-quic_c_sbhanu@quicinc.com>
 <ce5582e3-0d8d-f1cf-0d23-8fbf17226775@intel.com>
 <3459875e-782d-d2bd-ba1f-c945e22e312e@intel.com>
From:   "Sajida Bhanu (Temp)" <quic_c_sbhanu@quicinc.com>
In-Reply-To: <3459875e-782d-d2bd-ba1f-c945e22e312e@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for review.

Please find the inline comments.

Thanks,

Sajida

On 4/26/2022 1:28 PM, Adrian Hunter wrote:
> On 26/04/22 10:54, Adrian Hunter wrote:
>> On 25/04/22 19:00, Shaik Sajida Bhanu wrote:
>>> Add debug fs entry error state to query eMMC and SD card errors statistics.
>>> If any errors occurred in eMMC and SD card driver level then
>>> err_state value will be set to 1.
>>>
>>> Signed-off-by: Liangliang Lu <quic_luliang@quicinc.com>
>>> Signed-off-by: Sayali Lokhande <quic_sayalil@quicinc.com>
>>> Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
>>> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
>>> ---
>>>   drivers/mmc/core/debugfs.c | 25 +++++++++++++++++++++++++
>>>   1 file changed, 25 insertions(+)
>>>
>>> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
>>> index 6aa5a60..2f5b63f 100644
>>> --- a/drivers/mmc/core/debugfs.c
>>> +++ b/drivers/mmc/core/debugfs.c
>>> @@ -222,6 +222,29 @@ static int mmc_clock_opt_set(void *data, u64 val)
>>>   
>>>   DEFINE_DEBUGFS_ATTRIBUTE(mmc_clock_fops, mmc_clock_opt_get, mmc_clock_opt_set,
>>>   	"%llu\n");
>> A blank line would be nice here
>>
>>> +static int mmc_err_state_get(void *data, u64 *val)
>>> +{
>>> +	struct mmc_host *host = data;
>>> +
>>> +	if (!host)
>>> +		return -EINVAL;
>>> +
>> I am not sure why you have left out some err_stats[].
>> Why not all of them?  At least, it needs a comment to explain.
>>
>>> +	*val = host->err_stats[MMC_ERR_REQ_TIMEOUT] ||
>>> +	       host->err_stats[MMC_ERR_ADMA] ||
>>> +	       host->err_stats[MMC_ERR_CTRL_TIMEOUT] ||
>>> +	       host->err_stats[MMC_ERR_UNEXPECTED_IRQ] ||
>>> +	       host->err_stats[MMC_ERR_CMDQ_RED] ||
>>> +	       host->err_stats[MMC_ERR_CMDQ_GCE] ||
>>> +	       host->err_stats[MMC_ERR_CMDQ_ICCE] ||
>>> +	       host->err_stats[MMC_ERR_DAT_TIMEOUT] ||
>>> +	       host->err_stats[MMC_ERR_DAT_CRC] ||
>>> +	       host->err_stats[MMC_ERR_CMD_CRC] ||
>>> +	       host->err_stats[MMC_ERR_CMD_TIMEOUT];
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +DEFINE_SIMPLE_ATTRIBUTE(mmc_err_state, mmc_err_state_get, NULL, "%llu\n");
> Also, if possible, please use DEFINE_DEBUGFS_ATTRIBUTE / debugfs_create_file_unsafe
> in this case
Sure.. will use  DEFINE_DEBUGFS_ATTRIBUTE
>
>>>   
>>>   static int mmc_err_stats_show(struct seq_file *file, void *data)
>>>   {
>>> @@ -289,6 +312,8 @@ void mmc_add_host_debugfs(struct mmc_host *host)
>>>   	debugfs_create_file_unsafe("clock", S_IRUSR | S_IWUSR, root, host,
>>>   				   &mmc_clock_fops);
>>>   
>>> +	debugfs_create_file("err_state", 0600, root, host,
>>> +			    &mmc_err_state);
>>>   	debugfs_create_file("err_stats", 0600, root, host,
>>>   			    &mmc_err_stats_fops);
>>>   
