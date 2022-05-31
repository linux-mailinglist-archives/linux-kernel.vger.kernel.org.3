Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1EA85389A7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 03:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243422AbiEaBhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 21:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbiEaBhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 21:37:17 -0400
Received: from mail.meizu.com (edge05.meizu.com [157.122.146.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC30E4A3C4;
        Mon, 30 May 2022 18:37:15 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail12.meizu.com
 (172.16.1.108) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 31 May
 2022 09:37:15 +0800
Received: from [172.16.137.70] (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Tue, 31 May
 2022 09:37:13 +0800
Message-ID: <bd81a9a2-f14f-9564-3f68-be853134ecba@meizu.com>
Date:   Tue, 31 May 2022 09:37:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/msm/dpu: Fix pointer dereferenced before checking
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Sean Paul" <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <1653896005-25168-1-git-send-email-baihaowen@meizu.com>
 <68443e94-32fc-a35e-3383-0dcd8ca967c0@quicinc.com>
From:   baihaowen <baihaowen@meizu.com>
In-Reply-To: <68443e94-32fc-a35e-3383-0dcd8ca967c0@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022/5/31 上午8:36, Abhinav Kumar 写道:
>
>
> On 5/30/2022 12:33 AM, Haowen Bai wrote:
>> The ctx->hw is dereferencing before null checking, so move
>> it after checking.
>>
>> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
>
> Agree with Dmitry's comment. Adjust the patch subject to a different one otherwise PW thinks they are same patches.
>
> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>
>> ---
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c
>> index bcccce292937..e59680cdd0ce 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c
>> @@ -155,11 +155,13 @@ static void dpu_hw_wb_roi(struct dpu_hw_wb *ctx, struct dpu_hw_wb_cfg *wb)
>>   static void dpu_hw_wb_setup_qos_lut(struct dpu_hw_wb *ctx,
>>           struct dpu_hw_wb_qos_cfg *cfg)
>>   {
>> -    struct dpu_hw_blk_reg_map *c = &ctx->hw;
>> +    struct dpu_hw_blk_reg_map *c;
>>       u32 qos_ctrl = 0;
>>         if (!ctx || !cfg)
>>           return;
>> +   
>> +    c = &ctx->hw;
>>         DPU_REG_WRITE(c, WB_DANGER_LUT, cfg->danger_lut);
>>       DPU_REG_WRITE(c, WB_SAFE_LUT, cfg->safe_lut);
Sorry, plz ignore this patch.

ctx->hw is dereferenced, &ctx->hw is just a pointer math for pointer address offset, so it would not cause a bug(dereferencing null pointer).

 

-- 
Haowen Bai

