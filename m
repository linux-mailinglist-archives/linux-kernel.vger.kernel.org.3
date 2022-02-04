Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F6F4AA455
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346512AbiBDX2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:28:40 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:16374 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231867AbiBDX2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:28:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644017319; x=1675553319;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tspsD82vPq9nN5xt5GD0/TAzgz4Dn//ZDbjM9FIM80g=;
  b=T6obCSlbxnQWcqiEymrBFKpg7ulEl8uel25xh7e52GjIUbjbBMjunsyf
   fOUk6DHh/DXqGj/okpHqwdbewEvdGBJ3H4PaRSuI1STjIt3Q3VvO03n1k
   ro5BbgDiKLcgzDZtjOQUrdjzA0uKikM0QbzOxLymzjZfR37C7edepsyBO
   A=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 04 Feb 2022 15:28:38 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 15:28:38 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 4 Feb 2022 15:26:08 -0800
Received: from [10.110.103.75] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Fri, 4 Feb 2022
 15:26:07 -0800
Message-ID: <5da479b3-701c-cb5b-2e40-84c5ab4fb90b@quicinc.com>
Date:   Fri, 4 Feb 2022 15:26:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 1/3] drm/msm/dp: revise timing engine programming to
 support widebus feature
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <vkoul@kernel.org>,
        <daniel@ffwll.ch>, <airlied@linux.ie>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>
CC:     <quic_abhinavk@quicinc.com>, <quic_aravindh@quicinc.com>,
        <quic_sbillaka@quicinc.com>, <freedreno@lists.freedesktop.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1643999801-20359-1-git-send-email-quic_khsieh@quicinc.com>
 <1643999801-20359-2-git-send-email-quic_khsieh@quicinc.com>
 <215d1870-bfa6-fe08-c885-c32161a74ff7@linaro.org>
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
In-Reply-To: <215d1870-bfa6-fe08-c885-c32161a74ff7@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/4/2022 2:05 PM, Dmitry Baryshkov wrote:
> On 04/02/2022 21:36, Kuogee Hsieh wrote:
>> Widebus feature will transmit two pixel data per pixel clock to 
>> interface.
>> Timing engine provides driving force for this purpose. This patch base
>> on HPG (Hardware Programming Guide) to revise timing engine register
>> setting to accommodate both widebus and non widebus application. Also
>> horizontal width parameters need to be reduced by half since two pixel
>> data are clocked out per pixel clock when widebus feature enabled.
>> In addition, revised timing engine function is an generic function and
>> intend to be shared by all platforms to reduce maintenance efforts.
>>
>> Changes in v2:
>> -- remove compression related code from timing
>> -- remove op_info from  struct msm_drm_private
>> -- remove unnecessary wide_bus_en variables
>> -- pass wide_bus_en into timing configuration by struct msm_dp
>>
>> Changes in v3:
>> -- split patch into 3 patches
>>
>> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
>> ---
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        | 10 +++
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h        |  2 +
>>   .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c   | 14 +++
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c        | 99 
>> ++++++++++++++--------
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h        |  2 +
>>   5 files changed, 93 insertions(+), 34 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c 
>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>> index 0d315b4..0c22839 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>> @@ -208,6 +208,8 @@ struct dpu_encoder_virt {
>>         u32 idle_timeout;
>>   +    bool wide_bus_en;
>> +
>>       struct msm_dp *dp;
>>   };
>>   @@ -217,6 +219,14 @@ static u32 dither_matrix[DITHER_MATRIX_SZ] = {
>>       15, 7, 13, 5, 3, 11, 1, 9, 12, 4, 14, 6, 0, 8, 2, 10
>>   };
>>   +
>> +bool dpu_encoder_is_widebus_enabled(struct drm_encoder *drm_enc)
>> +{
>> +    struct dpu_encoder_virt *dpu_enc = to_dpu_encoder_virt(drm_enc);
>> +
>> +    return dpu_enc->wide_bus_en;
>> +}
>> +
>>   static void _dpu_encoder_setup_dither(struct dpu_hw_pingpong 
>> *hw_pp, unsigned bpc)
>>   {
>>       struct dpu_hw_dither_cfg dither_cfg = { 0 };
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h 
>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
>> index 99a5d73..893d74d 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
>> @@ -168,4 +168,6 @@ int dpu_encoder_get_linecount(struct drm_encoder 
>> *drm_enc);
>>    */
>>   int dpu_encoder_get_frame_count(struct drm_encoder *drm_enc);
>>   +bool dpu_encoder_is_widebus_enabled(struct drm_encoder *drm_enc);
>> +
>>   #endif /* __DPU_ENCODER_H__ */
>
> This chunk does not apply against the msm-next. The conflict is 
> trivial, but it would be nice to know that the code was tested against 
> the current tip.
My fault, I forget to cherry-pick to msm-next this time before upload 
for review
>
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c 
>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
>> index 185379b..3d6c914 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
>> @@ -110,6 +110,20 @@ static void drm_mode_to_intf_timing_params(
>>           timing->v_back_porch += timing->v_front_porch;
>>           timing->v_front_porch = 0;
>>       }
>> +
>> +    timing->wide_bus_en = 
>> dpu_encoder_is_widebus_enabled(phys_enc->parent);
>> +
>> +    /*
>> +     * for DP, divide the horizonal parameters by 2 when
>> +     * widebus is enabled
>> +     */
>> +    if (timing->wide_bus_en) {
>> +        timing->width = timing->width >> 1;
>> +        timing->xres = timing->xres >> 1;
>> +        timing->h_back_porch = timing->h_back_porch >> 1;
>> +        timing->h_front_porch = timing->h_front_porch >> 1;
>> +        timing->hsync_pulse_width = timing->hsync_pulse_width >> 1;
>> +    }
>>   }
>>     static u32 get_horizontal_total(const struct intf_timing_params 
>> *timing)
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c 
>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
>> index 116e2b5..35d4aaa 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
>> @@ -33,6 +33,7 @@
>>   #define INTF_TP_COLOR1                  0x05C
>>   #define INTF_CONFIG2                    0x060
>>   #define INTF_DISPLAY_DATA_HCTL          0x064
>> +#define INTF_ACTIVE_DATA_HCTL           0x068
>>   #define INTF_FRAME_LINE_COUNT_EN        0x0A8
>>   #define INTF_FRAME_COUNT                0x0AC
>>   #define   INTF_LINE_COUNT               0x0B0
>> @@ -90,68 +91,95 @@ static void 
>> dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *ctx,
>>       u32 hsync_period, vsync_period;
>>       u32 display_v_start, display_v_end;
>>       u32 hsync_start_x, hsync_end_x;
>> +    u32 hsync_data_start_x, hsync_data_end_x;
>>       u32 active_h_start, active_h_end;
>>       u32 active_v_start, active_v_end;
>>       u32 active_hctl, display_hctl, hsync_ctl;
>>       u32 polarity_ctl, den_polarity, hsync_polarity, vsync_polarity;
>>       u32 panel_format;
>> -    u32 intf_cfg, intf_cfg2 = 0, display_data_hctl = 0;
>> +    u32 intf_cfg, intf_cfg2 = 0;
>> +    u32 display_data_hctl = 0, active_data_hctl = 0;
>> +    u32 data_width;
>> +    bool dp_intf = false;
>>         /* read interface_cfg */
>>       intf_cfg = DPU_REG_READ(c, INTF_CONFIG);
>> +
>> +    if (ctx->cap->type == INTF_EDP || ctx->cap->type == INTF_DP)
>> +        dp_intf = true;
>> +
>>       hsync_period = p->hsync_pulse_width + p->h_back_porch + p->width +
>>       p->h_front_porch;
>>       vsync_period = p->vsync_pulse_width + p->v_back_porch + 
>> p->height +
>>       p->v_front_porch;
>>         display_v_start = ((p->vsync_pulse_width + p->v_back_porch) *
>> -    hsync_period) + p->hsync_skew;
>> +            hsync_period) + p->hsync_skew;
>>       display_v_end = ((vsync_period - p->v_front_porch) * 
>> hsync_period) +
>> -    p->hsync_skew - 1;
>> +            p->hsync_skew - 1;
>> +
>> +    hsync_ctl = (hsync_period << 16) | p->hsync_pulse_width;
>>         hsync_start_x = p->h_back_porch + p->hsync_pulse_width;
>>       hsync_end_x = hsync_period - p->h_front_porch - 1;
>>   -    if (p->width != p->xres) {
>> -        active_h_start = hsync_start_x;
>> -        active_h_end = active_h_start + p->xres - 1;
>> -    } else {
>> -        active_h_start = 0;
>> -        active_h_end = 0;
>> -    }
>> +    /*
>> +     * DATA_HCTL_EN controls data timing which can be different from
>> +     * video timing. It is recommended to enable it for all cases, 
>> except
>> +     * if compression is enabled in 1 pixel per clock mode
>> +     */
>> +    if (p->wide_bus_en)
>> +        intf_cfg2 |= BIT(4);
>>   -    if (p->height != p->yres) {
>> -        active_v_start = display_v_start;
>> -        active_v_end = active_v_start + (p->yres * hsync_period) - 1;
>> -    } else {
>> -        active_v_start = 0;
>> -        active_v_end = 0;
>> -    }
>> +    if (p->wide_bus_en)
>> +        intf_cfg2 |= BIT(0);
>>   -    if (active_h_end) {
>> -        active_hctl = (active_h_end << 16) | active_h_start;
>> -        intf_cfg |= BIT(29);    /* ACTIVE_H_ENABLE */
>> -    } else {
>> -        active_hctl = 0;
>> -    }
>> +    /*
>> +     * If widebus is disabled:
>> +     * For uncompressed stream, the data is valid for the entire active
>> +     * window period.
>> +     * For compressed stream, data is valid for a shorter time period
>> +     * inside the active window depending on the compression ratio.
>> +     *
>> +     * If widebus is enabled:
>> +     * For uncompressed stream, data is valid for only half the active
>> +     * window, since the data rate is doubled in this mode.
>> +     * p->width holds the adjusted width for DP but unadjusted width 
>> for DSI
>> +     * For compressed stream, data validity window needs to be 
>> adjusted for
>> +     * compression ratio and then further halved.
>> +     */
>> +    data_width = p->width;
>
> This assignment is rewritten in the next few lines! Please drop it, 
> it's unused.
>
>> +
>> +    if (!dp_intf && p->wide_bus_en)
>
> This condition does not make sense. wide_bus_en can only be enabled 
> for dp_intf, can it not? So the condition is always false.
>
>> +        data_width = p->width >> 1;
>> +    else
>> +        data_width = p->width;
>>   -    if (active_v_end)
>> -        intf_cfg |= BIT(30); /* ACTIVE_V_ENABLE */
>> +    hsync_data_start_x = hsync_start_x;
>> +    hsync_data_end_x =  hsync_start_x + data_width - 1;
>>   -    hsync_ctl = (hsync_period << 16) | p->hsync_pulse_width;
>>       display_hctl = (hsync_end_x << 16) | hsync_start_x;
>> +    display_data_hctl = (hsync_data_end_x << 16) | hsync_data_start_x;
>>   -    if (ctx->cap->type == INTF_EDP || ctx->cap->type == INTF_DP) {
>> -        active_h_start = hsync_start_x;
>> -        active_h_end = active_h_start + p->xres - 1;
>> -        active_v_start = display_v_start;
>> -        active_v_end = active_v_start + (p->yres * hsync_period) - 1;
>> -
>> +    if (dp_intf) {
>> +        // DP timing adjustment
>
> This is the only place with the C99 comment. Please use the 
> surrounding syntax.
>
>>           display_v_start += p->hsync_pulse_width + p->h_back_porch;
>> +        display_v_end   -= p->h_front_porch;
>> +    }
>> +
>> +    active_h_start = hsync_start_x;
>> +    active_h_end = active_h_start + p->xres - 1;
>> +
>> +    active_v_start = display_v_start;
>> +    active_v_end = active_v_start + (p->yres * hsync_period) - 1;
>
> These assignments were only applied for the DP/eDP case. Could you 
> please elaborate the change? Why are you enabling them for the DSI and 
> HDMI outputs?

All interface have those registers for active_v_xx and acrive_h_xx, I am 
not sure they are dedicated for DP or eDP.

If so, then those register should be no effects after written.

>
>>   -        active_hctl = (active_h_end << 16) | active_h_start;
>> +    intf_cfg |= BIT(29);    /* ACTIVE_H_ENABLE */
>> +    intf_cfg |= BIT(30);    /* ACTIVE_V_ENABLE */
>
> These were enabled only when active_h_end / active_v_end were 
> non-zero. Any comments?
active_h_end and active_v_end should never be 0.
>
>> +
>> +    active_hctl = (active_h_end << 16) | active_h_start;
>> +
>> +    if (dp_intf)
>>           display_hctl = active_hctl;
>> -    }
>>         den_polarity = 0;
>>       if (ctx->cap->type == INTF_HDMI) {
>> @@ -204,6 +232,9 @@ static void 
>> dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *ctx,
>>       DPU_REG_WRITE(c, INTF_FRAME_LINE_COUNT_EN, 0x3);
>>       DPU_REG_WRITE(c, INTF_CONFIG, intf_cfg);
>>       DPU_REG_WRITE(c, INTF_PANEL_FORMAT, panel_format);
>> +    DPU_REG_WRITE(c, INTF_CONFIG2, intf_cfg2);
>> +    DPU_REG_WRITE(c, INTF_DISPLAY_DATA_HCTL, display_data_hctl);
>> +    DPU_REG_WRITE(c, INTF_ACTIVE_DATA_HCTL, active_data_hctl);
>
> I see. These writes are currently under the if (ctx->cap->features & 
> BIT(DPU_DATA_HCTL_EN)) condition. Please leave them there unless the 
> condition is wrong.
>
>>   }
>>     static void dpu_hw_intf_enable_timing_engine(
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h 
>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
>> index 3568be8..e4a518a 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
>> @@ -30,6 +30,8 @@ struct intf_timing_params {
>>       u32 border_clr;
>>       u32 underflow_clr;
>>       u32 hsync_skew;
>> +
>> +    bool wide_bus_en;
>>   };
>>     struct intf_prog_fetch {
>
>
