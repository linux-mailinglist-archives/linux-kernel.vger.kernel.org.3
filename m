Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00C955C6DA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238727AbiF0Pdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 11:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238365AbiF0PdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 11:33:18 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F55913F08;
        Mon, 27 Jun 2022 08:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656343990; x=1687879990;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tbyIxpKpueAF0ZAPFJeYqVJyHPz52aBeX2V7v4Ze61c=;
  b=CnyM4mTU43+4o15C99aQ6sl/+FZSQuw8eSlEGx4o3bF1Y7Nns/IxzEn6
   +46vCDeQAKry+pyetGzsmK92uDRoDZN/mJR5sNHL7O3r70zbSVii4Y/Cv
   z9QzzkR3A/gUdScOkkzpDrTKUmSP9kyX/3FjfvfHfv+Ism5M0ugVz9qkF
   U=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 27 Jun 2022 08:33:09 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 08:33:08 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 27 Jun 2022 08:33:08 -0700
Received: from [10.110.113.167] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 27 Jun
 2022 08:33:07 -0700
Message-ID: <9b197183-5306-bf19-0195-2dc1bb72c33b@quicinc.com>
Date:   Mon, 27 Jun 2022 08:33:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v1 2/3] drm/msm/dp: decoupling dp->id out of dp
 controller_id at scxxxx_dp_cfg table
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Abhinav Kumar <quic_abhinavk@quicinc.com>, <agross@kernel.org>,
        <airlied@linux.ie>, <bjorn.andersson@linaro.org>,
        <daniel@ffwll.ch>, <dianders@chromium.org>,
        <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <vkoul@kernel.org>, <quic_aravindh@quicinc.com>,
        <quic_sbillaka@quicinc.com>, <freedreno@lists.freedesktop.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1656090912-18074-1-git-send-email-quic_khsieh@quicinc.com>
 <66ff4642-f268-f5b0-7e28-b196368c508a@quicinc.com>
 <5cf094cf-343a-82d7-91c4-1284683f9748@quicinc.com>
 <CAA8EJprqq=vxXT2DmEWii_Ajx2UbkHRexPTT58xFcWkBa_D5hA@mail.gmail.com>
 <26263c16-8cbc-ccca-6081-7eba14635d73@quicinc.com>
 <CAA8EJpqEoXXA=eKGHRGuQ3VOHnmEShY8u_SMZ6WFWORCFhFcrw@mail.gmail.com>
 <8445f93a-00f0-64af-5650-07f2bc487742@quicinc.com>
 <CAA8EJpqB2KPyvFehK9WRGgiVnqvD24cz5BcHsw8a5PQ2Vs1oKA@mail.gmail.com>
 <CAA8EJppZdyutyNBG+OFinickQoDxg0i4GwbaNQubo_LSRWNh4w@mail.gmail.com>
 <1a2e7574-8f78-d48e-a189-020ffcd39f60@quicinc.com>
 <CAE-0n52L1fvvpEH56+HD_UXuV61tMvhh8Qjp781bW9tTKRQymw@mail.gmail.com>
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
In-Reply-To: <CAE-0n52L1fvvpEH56+HD_UXuV61tMvhh8Qjp781bW9tTKRQymw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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


On 6/24/2022 6:15 PM, Stephen Boyd wrote:
> Quoting Kuogee Hsieh (2022-06-24 18:02:50)
>> On 6/24/2022 5:46 PM, Dmitry Baryshkov wrote:
>>> On Sat, 25 Jun 2022 at 03:28, Dmitry Baryshkov
>>> <dmitry.baryshkov@linaro.org> wrote:
>>>> On Sat, 25 Jun 2022 at 03:23, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>>>>> On 6/24/2022 5:21 PM, Dmitry Baryshkov wrote:
>>>>>> On Sat, 25 Jun 2022 at 03:19, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>>>>>>> How can I have eDP call dpu_encoder_init() before DP calls with
>>>>>>> _dpu_kms_initialize_displayport()?
>>>>>> Why do you want to do it? They are two different encoders.
>>>>> eDP is primary display which in normal case should be bring up first if
>>>>> DP is also presented.
>>>> I do not like the concept of primary display. It is the user, who must
>>>> decide which display is primary to him. I have seen people using just
>>>> external monitors and ignoring built-in eDP completely.from
>>>> Also, why does the bring up order matters here? What do you gain by
>>>> bringing up eDP before the DP?
>>> I should probably rephrase my question to be more clear. How does
>>> changing the order of DP vs eDP bringup help you 'to fix screen
>>> corruption'.
>> it did fix the primary display correction issue if edp go first and i do
>> not know the root cause yet.
>>
>> We are still investigating it.
>>
>> However I do think currently msm_dp_config sc7280_dp_cfg has issues need
>> be addressed.
>>
> What issues exist with sc7280_dp_cfg? It looks correct to me.


If we are going to bring up a new chipset with edp as primary only, i am 
not sure the below configuration will work?

> static const struct msm_dp_config sc7280_dp_cfg = {
>          .descs = (const struct msm_dp_desc[]) {
>                  [MSM_DP_CONTROLLER_1] = { .io_start = 0x0aea0000, .connector_type = DRM_MODE_CONNECTOR_eDP, .wide_bus_en = true },
>          },
>          .num_descs = 1,
> };
