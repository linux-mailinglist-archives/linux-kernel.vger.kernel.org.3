Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B613758D544
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 10:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbiHIIWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 04:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiHIIWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 04:22:37 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A2D62EE;
        Tue,  9 Aug 2022 01:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1660033356; x=1691569356;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=4RdQ7P8S4h5nYU0gs8Q75efzkHo4s0hEdG6A0YIeAVQ=;
  b=zefqcnHOUEagItcFXVkPaAAHtwq5bhvT10VU2hzM5Y3/xY3LWxyqCA6O
   OFOnrHqXpDWQja8PND2rRyRja2LhYQVdoSADhlfmkHBWInCTCgBUWR/nL
   LrtstHDUTcFVTzZ7KlY5V9fzC2waUvOAC3cssQ100enlfbL7TIcRz/fUH
   8=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 09 Aug 2022 01:22:36 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 01:22:35 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 9 Aug 2022 01:22:35 -0700
Received: from [10.216.39.97] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 9 Aug 2022
 01:22:29 -0700
Message-ID: <1f340f3d-83f3-6455-7671-34ef40abe6c4@quicinc.com>
Date:   Tue, 9 Aug 2022 13:52:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 7/8] remoteproc: qcom: Add support for memory sandbox
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>, <devicetree@vger.kernel.org>
References: <1659536480-5176-1-git-send-email-quic_srivasam@quicinc.com>
 <1659536480-5176-8-git-send-email-quic_srivasam@quicinc.com>
 <9d78a571-8d02-2967-1f29-21ca737a582f@linaro.org>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <9d78a571-8d02-2967-1f29-21ca737a582f@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/7/2022 2:04 AM, Dmitry Baryshkov wrote:
Thanks for your time and Valuable inputs Dmitry!!!
> On 03/08/2022 17:21, Srinivasa Rao Mandadapu wrote:
>> Add memory sandbox support for ADSP based platforms secure booting.
>
> This repeats commit subject. Please replace it with proper commit 
> message text describing what is done and why.
Okay. Will update it.
>
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> ---
>>   drivers/remoteproc/qcom_q6v5_adsp.c | 101 
>> +++++++++++++++++++++++++++++++++++-
>>   1 file changed, 99 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c 
>> b/drivers/remoteproc/qcom_q6v5_adsp.c
>> index 3dbd035..f81da47 100644
>> --- a/drivers/remoteproc/qcom_q6v5_adsp.c
>> +++ b/drivers/remoteproc/qcom_q6v5_adsp.c
>> @@ -9,6 +9,7 @@
>>   #include <linux/firmware.h>
>>   #include <linux/interrupt.h>
>>   #include <linux/io.h>
>> +#include <linux/iommu.h>
>>   #include <linux/iopoll.h>
>>   #include <linux/kernel.h>
>>   #include <linux/mfd/syscon.h>
>> @@ -48,6 +49,8 @@
>>   #define LPASS_PWR_ON_REG        0x10
>>   #define LPASS_HALTREQ_REG        0x0
>>   +#define SID_MASK_DEFAULT        0xF
>> +
>>   #define QDSP6SS_XO_CBCR        0x38
>>   #define QDSP6SS_CORE_CBCR    0x20
>>   #define QDSP6SS_SLEEP_CBCR    0x3c
>> @@ -77,7 +80,7 @@ struct adsp_pil_data {
>>   struct qcom_adsp {
>>       struct device *dev;
>>       struct rproc *rproc;
>> -
>> +    struct iommu_domain *iommu_dom;
>>       struct qcom_q6v5 q6v5;
>>         struct clk *xo;
>> @@ -332,6 +335,91 @@ static int adsp_load(struct rproc *rproc, const 
>> struct firmware *fw)
>>       return 0;
>>   }
>>   +static int adsp_map_smmu(struct qcom_adsp *adsp, struct rproc *rproc)
>> +{
>> +    struct of_phandle_args args;
>> +    int ret, rc, i;
>> +    long long sid;
>> +
>> +    unsigned long mem_phys;
>> +    unsigned long iova;
>> +    const __be32 *prop;
>> +    int access_level;
>> +    uint32_t len, flag, mem_size;
>> +    int offset;
>> +    struct fw_rsc_hdr *hdr;
>> +    struct fw_rsc_devmem *rsc_fw;
>> +
>> +    rc = of_parse_phandle_with_fixed_args(adsp->dev->of_node, 
>> "iommus", 1, 0, &args);
>
> Please do not add implicit dependency on #iommu-cells value.
Okay. Will change it to "of_parse_phandle_with_args()"
>
>> +    if (rc < 0)
>> +        sid = -1;
>> +    else
>> +        sid = args.args[0] & SID_MASK_DEFAULT;
>> +
>> +    adsp->iommu_dom = iommu_domain_alloc(&platform_bus_type);
>
> please use adsp->dev->bus instead of platform_bus_type here.
Okay. will update it.
>
>> +    if (!adsp->iommu_dom) {
>> +        dev_err(adsp->dev, "failed to allocate iommu domain\n");
>> +        return -ENOMEM;
>> +    }
>> +
>> +    ret = iommu_attach_device(adsp->iommu_dom, adsp->dev);
>> +    if (ret) {
>> +        dev_err(adsp->dev, "could not attach device ret = %d\n", ret);
>> +        return -EBUSY;
>> +    }
>> +
>> +    /* Add SID configuration for ADSP Firmware to SMMU */
>> +    adsp->mem_phys =  adsp->mem_phys | (sid << 32);
>> +
>> +    ret = iommu_map(adsp->iommu_dom, adsp->mem_phys, adsp->mem_phys,
>> +            adsp->mem_size,    IOMMU_READ | IOMMU_WRITE);
>> +    if (ret) {
>> +        dev_err(adsp->dev, "Unable to map ADSP Physical Memory\n");
>> +        return ret;
>> +    }
>> +
>> +    prop = of_get_property(adsp->dev->of_node, "qcom,adsp-memory", 
>> &len);
>
> Non-documented property. So, this chunk is not acceptable.
Okay. Will add it in dt-bindings too.
>
>> +    if (prop) {
>> +        len /= sizeof(__be32);
>> +        for (i = 0; i < len; i++) {
>> +            iova = be32_to_cpu(prop[i++]);
>> +            mem_phys = be32_to_cpu(prop[i++]);
>> +            mem_size = be32_to_cpu(prop[i++]);
>> +            access_level = be32_to_cpu(prop[i]);
>> +
>> +            if (access_level)
>> +                flag = IOMMU_READ | IOMMU_WRITE;
>> +            else
>> +                flag = IOMMU_READ;
>> +
>> +            ret = iommu_map(adsp->iommu_dom, iova, mem_phys, 
>> mem_size, flag);
>> +            if (ret) {
>> +                dev_err(adsp->dev, "failed to map addr = %p mem_size 
>> = %x\n",
>> +                        &(mem_phys), mem_size);
>> +                return ret;
>> +            }
>> +        }
>> +    } else {
>> +        if (!rproc->table_ptr)
>> +            return 0;
>> +
>> +        for (i = 0; i < rproc->table_ptr->num; i++) {
>> +            offset = rproc->table_ptr->offset[i];
>> +            hdr = (void *)rproc->table_ptr + offset;
>> +            rsc_fw = (struct fw_rsc_devmem *)hdr + sizeof(*hdr);
>> +
>> +            ret = iommu_map(rproc->domain, rsc_fw->da, rsc_fw->pa,
>> +                        rsc_fw->len, rsc_fw->flags);
>
> What about filling an sgtable instead and using it?

Here we are just doing IO mapping and allowing ADSP to access the 
specified memory.

I am not sure,  sg_table applicable here or not as it's not any DMA 
activity.

Please correct me if my understanding is not enough and It would help me 
a lot, if any good example shared.

>
>> +            if (ret) {
>> +                pr_err("%s; unable to map adsp memory address\n", 
>> __func__);
>> +                return ret;
>> +            }
>> +        }
>> +    }
>> +    return 0;
>> +}
>> +
>> +
>>   static int adsp_start(struct rproc *rproc)
>>   {
>>       struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
>> @@ -341,7 +429,13 @@ static int adsp_start(struct rproc *rproc)
>>       ret = qcom_q6v5_prepare(&adsp->q6v5);
>>       if (ret)
>>           return ret;
>> -
>> +    if (!adsp->is_wpss) {
>> +        ret = adsp_map_smmu(adsp, rproc);
>
> Is this also applicable to cDSP? To sdm845 adsp?

It's applicable to all ADSP SoC variants. I think it's better to add 
adsp flag("is_adsp") for

distinguishing adsp use cases. Please suggest here.

>
>> +        if (ret) {
>> +            dev_err(adsp->dev, "ADSP smmu mapping failed\n");
>> +            goto adsp_smmu_unmap;
>> +        }
>> +    }
>>       ret = clk_prepare_enable(adsp->xo);
>>       if (ret)
>>           goto disable_irqs;
>> @@ -402,6 +496,9 @@ static int adsp_start(struct rproc *rproc)
>>       clk_disable_unprepare(adsp->xo);
>>   disable_irqs:
>>       qcom_q6v5_unprepare(&adsp->q6v5);
>> +adsp_smmu_unmap:
>> +    iommu_unmap(adsp->iommu_dom, adsp->mem_phys, adsp->mem_size);
>> +    iommu_domain_free(adsp->iommu_dom);
>>         return ret;
>>   }
>
>
