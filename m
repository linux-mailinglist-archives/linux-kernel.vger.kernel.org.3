Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B399588A0C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 12:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235981AbiHCKCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 06:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbiHCKB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 06:01:59 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78F91836B;
        Wed,  3 Aug 2022 03:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659520919; x=1691056919;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1rVxQ4eqI3N9wCVO+tgYoYxdpipoicSFsvvHXjVF02g=;
  b=C3Cu6vOsuzPJuzImBkgFrMpA39OFtZBJnzHRhL1gPpYkCXFfM9ufo5Cm
   f7HrPkGh/Jr7QW1INMGoqqL18jJuppc/P1JvnOESosfsiwojecjjsT1f6
   iylDLVO+2Ny4jaDZ59bd4338xhctqw/rvWAMKsU2WR9bBE6LgbVmx+Eeu
   E=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 03 Aug 2022 03:01:59 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 03:01:58 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 3 Aug 2022 03:01:57 -0700
Received: from [10.216.24.92] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 3 Aug 2022
 03:01:51 -0700
Message-ID: <0f90ef4d-4b74-2746-a37c-4a661cc0d5ea@quicinc.com>
Date:   Wed, 3 Aug 2022 15:31:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 0/5] clk/qcom: Support gdsc collapse polling using 'reset'
 inteface
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     freedreno <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rob Herring" <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1659172664-10345-1-git-send-email-quic_akhilpo@quicinc.com>
 <34ae275e-8d4c-3735-c08c-4769caf2909c@linaro.org>
 <CAF6AEGv_cgPtaFpxSPCzWXeBcJvqE2fGucriRvMAJMbQ7ULndQ@mail.gmail.com>
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
In-Reply-To: <CAF6AEGv_cgPtaFpxSPCzWXeBcJvqE2fGucriRvMAJMbQ7ULndQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/2022 12:02 AM, Rob Clark wrote:
> On Tue, Aug 2, 2022 at 12:02 AM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
>> On 30/07/2022 12:17, Akhil P Oommen wrote:
>>> Some clients like adreno gpu driver would like to ensure that its gdsc
>>> is collapsed at hardware during a gpu reset sequence. This is because it
>>> has a votable gdsc which could be ON due to a vote from another subsystem
>>> like tz, hyp etc or due to an internal hardware signal.
>> If this is votable, do we have any guarantee that the gdsc will collapse
>> at all? How can we proceed if it did not collapse?
> Other potential votes should be transient.  But I guess we eventually
> need to timeout and give up.  At which point we are no worse off than
> before.
>
> But hmm, we aren't using RBBM_SW_RESET_CMD for sw reset like we have
> on previous generations?  That does seem a bit odd.  Looks like kgsl
> does use it.
>
> BR,
> -R
Like Rob mentioned there could be transient votes from other 
clients/subsystem. It could be even stuck ON when hardware is in bad 
shape in some very rare cases. For the worst case scenario, I have added 
a timeout (500msec) in the gdsc reset op.

I have added the Soft reset in [1]. But this resets only the core gpu 
blocks, not everything. For eg. GMU.

[1] [PATCH v3 7/8] drm/msm/a6xx: Improve gpu recovery sequence

>
>>> To allow
>>> this, gpucc driver can expose an interface to the client driver using
>>> reset framework. Using this the client driver can trigger a polling within
>>> the gdsc driver.
>> Trigger the polling made me think initially that we will actually
>> trigger something in the HW. Instead the client uses reset framework to
>> poll for the gdsc to be reset.
Yes. I should replace 'trigger' with 'start' here.

-Akhil.
>>
>>> This series is rebased on top of linus's master branch.
>>>
>>> Related discussion: https://patchwork.freedesktop.org/patch/493144/
>>>
>>>
>>> Akhil P Oommen (5):
>>>     dt-bindings: clk: qcom: Support gpu cx gdsc reset
>>>     clk: qcom: Allow custom reset ops
>>>     clk: qcom: gpucc-sc7280: Add cx collapse reset support
>>>     clk: qcom: gdsc: Add a reset op to poll gdsc collapse
>>>     arm64: dts: qcom: sc7280: Add Reset support for gpu
>>>
>>>    arch/arm64/boot/dts/qcom/sc7280.dtsi          |  3 +++
>>>    drivers/clk/qcom/gdsc.c                       | 23 +++++++++++++++++++----
>>>    drivers/clk/qcom/gdsc.h                       |  7 +++++++
>>>    drivers/clk/qcom/gpucc-sc7280.c               |  6 ++++++
>>>    drivers/clk/qcom/reset.c                      |  6 ++++++
>>>    drivers/clk/qcom/reset.h                      |  2 ++
>>>    include/dt-bindings/clock/qcom,gpucc-sc7280.h |  3 +++
>>>    7 files changed, 46 insertions(+), 4 deletions(-)
>>>
>>
>> --
>> With best wishes
>> Dmitry

