Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D72853ABAE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 19:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356290AbiFARSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 13:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355397AbiFARSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 13:18:18 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28321255A6;
        Wed,  1 Jun 2022 10:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654103897; x=1685639897;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lHtueAT33ZEVRFIBxGRY7qeK9s/pR03WpxOoLQiugeA=;
  b=NXM3j7qHF2SfX0ABgPdEhAQ6fFvKCDBvhbZMbP05oe7L6VtkpmdfiJ99
   SHBUyY4KBQv7VGlKXCmsqAN+KadgY7FpQSrTa80xwJ29NxMf/X+ulGmay
   gzXmcp9ypEPP7G+m8ROavy7pbObeM2oVQigCNv9wU2Gw84zh6LCiO4bhW
   8=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 01 Jun 2022 10:18:16 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 10:18:16 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 1 Jun 2022 10:18:15 -0700
Received: from [10.38.242.41] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 1 Jun 2022
 10:18:13 -0700
Message-ID: <f8d5e4a7-bba8-ca51-41f7-885ce14a55fe@quicinc.com>
Date:   Wed, 1 Jun 2022 10:18:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2] drm/msm/dpu: Move min BW request and full BW disable
 back to mdss
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
CC:     Kalyan Thota <quic_kalyant@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        <freedreno@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Sean Paul <sean@poorly.run>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        <linux-kernel@vger.kernel.org>
References: <20220531160059.v2.1.Ie7f6d4bf8cce28131da31a43354727e417cae98d@changeid>
 <CAA8EJpqp64eDmXPN1qMTZ78My8BKPUcu7zKunZV1SJpzjSRDuQ@mail.gmail.com>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <CAA8EJpqp64eDmXPN1qMTZ78My8BKPUcu7zKunZV1SJpzjSRDuQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/1/2022 3:04 AM, Dmitry Baryshkov wrote:
> On Wed, 1 Jun 2022 at 02:01, Douglas Anderson <dianders@chromium.org> wrote:
>>
>> In commit a670ff578f1f ("drm/msm/dpu: always use mdp device to scale
>> bandwidth") we fully moved interconnect stuff to the DPU driver. This
>> had no change for sc7180 but _did_ have an impact for other SoCs. It
>> made them match the sc7180 scheme.
> 
> [skipped the description]
> 
>>
>> Changes in v2:
>> - Don't set bandwidth in init.
>>
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c |  8 ----
>>   drivers/gpu/drm/msm/msm_mdss.c          | 57 +++++++++++++++++++++++++
>>   2 files changed, 57 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
>> index 2b9d931474e0..3025184053e0 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
>> @@ -49,8 +49,6 @@
>>   #define DPU_DEBUGFS_DIR "msm_dpu"
>>   #define DPU_DEBUGFS_HWMASKNAME "hw_log_mask"
>>
>> -#define MIN_IB_BW      400000000ULL /* Min ib vote 400MB */
>> -
>>   static int dpu_kms_hw_init(struct msm_kms *kms);
>>   static void _dpu_kms_mmu_destroy(struct dpu_kms *dpu_kms);
>>
> 
> [skipped]
> 
>> diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
>> index 0454a571adf7..e13c5c12b775 100644
>> --- a/drivers/gpu/drm/msm/msm_mdss.c
>> +++ b/drivers/gpu/drm/msm/msm_mdss.c
>> @@ -5,6 +5,7 @@
>>
>>   #include <linux/clk.h>
>>   #include <linux/delay.h>
>> +#include <linux/interconnect.h>
>>   #include <linux/irq.h>
>>   #include <linux/irqchip.h>
>>   #include <linux/irqdesc.h>
>> @@ -25,6 +26,8 @@
>>   #define UBWC_CTRL_2                    0x150
>>   #define UBWC_PREDICTION_MODE           0x154
>>
>> +#define MIN_IB_BW      400000000UL /* Min ib vote 400MB */
> 
> As msm_mdss is now used for both DPU and MDP5 devices, could you
> please confirm that this value is valid for older devices too? E.g.
> db410c or 8974
> 
I need to check with Kalyan on this value (400MB) as I am unable to find 
documentation on this. Will update this thread when I do.

So prior to this change 627dc55c273da ("drm/msm/disp/dpu1: icc path 
needs to be set before dpu runtime resume"), this value was coming from 
the hw catalog

@@ -1191,10 +1193,10 @@ static int __maybe_unused 
dpu_runtime_resume(struct device *dev)

         ddev = dpu_kms->dev;

+       WARN_ON(!(dpu_kms->num_paths));
         /* Min vote of BW is required before turning on AXI clk */
         for (i = 0; i < dpu_kms->num_paths; i++)
-               icc_set_bw(dpu_kms->path[i], 0,
-                       dpu_kms->catalog->perf.min_dram_ib);
+               icc_set_bw(dpu_kms->path[i], 0, Bps_to_icc(MIN_IB_BW));

After this, we moved to a hard-coded value, I am not sure why.

So nothing wrong with this change as such, the only question is whether 
this value is correct for older chips.

But the question here is, are older chips even using icc.

It seems like only sc7180, RB3/RB5 are unless i am mistaken.

So is there really any impact to the older chips with this change.

If not, we should probably let this one go ahead and move back to 
catalog based approach while extending ICC for older chips.

Thanks

Abhinav

>> +
>>   struct msm_mdss {
>>          struct device *dev;
>>
> 
