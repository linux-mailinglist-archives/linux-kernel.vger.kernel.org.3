Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D63FB49F459
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 08:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346805AbiA1H3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 02:29:41 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:61640 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346799AbiA1H3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 02:29:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643354979; x=1674890979;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZGcuH87Cwn7NyyRqG7ZxtYxzEEkANIYIdOtWtks7Iv4=;
  b=SGHuiHhyodhT2aSU04GxNPCSYj4ShScTbkLjuQOSEXlAGCDc8dMaMG/7
   fqST/dJnfIxWb4ZaS9+6tMNV2zKE+7eKxxAPpdLtfpum4SiXdVoinEGPT
   XJl3y7kKMkUpuBtN1wXBMxZ9TDd61ypC5h7k7xEjU8YOrvvbUV2qfOKKI
   4=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 27 Jan 2022 23:29:39 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 23:29:38 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 27 Jan 2022 23:29:38 -0800
Received: from [10.50.57.134] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Thu, 27 Jan
 2022 23:29:34 -0800
Message-ID: <8f0d544f-ea79-9fab-9579-7bdfed6dcf1b@quicinc.com>
Date:   Fri, 28 Jan 2022 12:59:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH 2/9] soc: qcom: llcc: Update the logic for version info
 extraction
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <cover.1643353154.git.quic_saipraka@quicinc.com>
 <e311b16376329b9e9483fed8ae910a31d0f7bcba.1643353154.git.quic_saipraka@quicinc.com>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <e311b16376329b9e9483fed8ae910a31d0f7bcba.1643353154.git.quic_saipraka@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/2022 12:39 PM, Sai Prakash Ranjan wrote:
> LLCC HW version info is made up of major, branch, minor and echo
> version bits each of which are 8bits. Several features in newer
> LLCC HW are based on the full version rather than just major or
> minor versions such as write-subcache enable which is applicable
> for versions greater than v2.0.0.0 and upcoming write-subcache
> cacheable for SM8450 SoC which is only present in versions v2.1.0.0
> and later, so it makes it easier and cleaner to just directly
> compare with the full version than adding additional major/branch/
> minor/echo version checks. So remove the earlier major version check
> and add full version check for those features.
>
> Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
> ---
>   drivers/soc/qcom/llcc-qcom.c       | 9 ++++-----
>   include/linux/soc/qcom/llcc-qcom.h | 4 ++--
>   2 files changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
> index b3a34f117a7c..a06764f16023 100644
> --- a/drivers/soc/qcom/llcc-qcom.c
> +++ b/drivers/soc/qcom/llcc-qcom.c
> @@ -37,7 +37,6 @@
>   #define CACHE_LINE_SIZE_SHIFT         6
>   
>   #define LLCC_COMMON_HW_INFO           0x00030000
> -#define LLCC_MAJOR_VERSION_MASK       GENMASK(31, 24)
>   
>   #define LLCC_COMMON_STATUS0           0x0003000c
>   #define LLCC_LB_CNT_MASK              GENMASK(31, 28)
> @@ -55,6 +54,8 @@
>   
>   #define BANK_OFFSET_STRIDE	      0x80000
>   
> +#define LLCC_VERSION_2_0_0_0          0x02000000
> +
>   /**
>    * struct llcc_slice_config - Data associated with the llcc slice
>    * @usecase_id: Unique id for the client's use case
> @@ -504,7 +505,7 @@ static int _qcom_llcc_cfg_program(const struct llcc_slice_config *config,
>   			return ret;
>   	}
>   
> -	if (drv_data->major_version == 2) {
> +	if (drv_data->version >= LLCC_VERSION_2_0_0_0) {
>   		u32 wren;
>   
>   		wren = config->write_scid_en << config->slice_id;
> @@ -598,13 +599,11 @@ static int qcom_llcc_probe(struct platform_device *pdev)
>   		goto err;
>   	}
>   
> -	/* Extract major version of the IP */
> +	/* Extract version of the IP */
>   	ret = regmap_read(drv_data->bcast_regmap, LLCC_COMMON_HW_INFO, &version);
>   	if (ret)
>   		goto err;
>   
> -	drv_data->major_version = FIELD_GET(LLCC_MAJOR_VERSION_MASK, version);
> -

Sorry, I missed assigning version info to drv_data here in this version. 
I am sending a v2 with the fix.

Thanks,
Sai

>   	ret = regmap_read(drv_data->regmap, LLCC_COMMON_STATUS0,
>   						&num_banks);
>   	if (ret)
> diff --git a/include/linux/soc/qcom/llcc-qcom.h b/include/linux/soc/qcom/llcc-qcom.h
> index 9e8fd92c96b7..beecf00b707d 100644
> --- a/include/linux/soc/qcom/llcc-qcom.h
> +++ b/include/linux/soc/qcom/llcc-qcom.h
> @@ -83,7 +83,7 @@ struct llcc_edac_reg_data {
>    * @bitmap: Bit map to track the active slice ids
>    * @offsets: Pointer to the bank offsets array
>    * @ecc_irq: interrupt for llcc cache error detection and reporting
> - * @major_version: Indicates the LLCC major version
> + * @version: Indicates the LLCC version
>    */
>   struct llcc_drv_data {
>   	struct regmap *regmap;
> @@ -96,7 +96,7 @@ struct llcc_drv_data {
>   	unsigned long *bitmap;
>   	u32 *offsets;
>   	int ecc_irq;
> -	u32 major_version;
> +	u32 version;
>   };
>   
>   #if IS_ENABLED(CONFIG_QCOM_LLCC)


