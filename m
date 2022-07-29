Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3777584FEF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 14:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235959AbiG2MDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 08:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236133AbiG2MDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 08:03:49 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED805863E5;
        Fri, 29 Jul 2022 05:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659096229; x=1690632229;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XOAdHZkPV7ADdDAhCaojbFXiiCwa7LMrSGb8t7JH/qw=;
  b=rf55HMnwN68sEANp9+l3uD8cYfS910/Nj0+cq2lfCFk48ifOUrrYNGhY
   Arn9xPh/nkp8/zBOf/g0q6EpzKfFg5V6UbuzQRM4n5bn/5DALvoHhJyfx
   /ReRGLGzvTc1kgXqkLbLF1F2SRxl+TIXSy3nzvOkUS6SU9MCcVcBl/LaY
   M=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 29 Jul 2022 05:03:49 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 05:03:48 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 29 Jul 2022 05:03:47 -0700
Received: from [10.216.46.173] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 29 Jul
 2022 05:03:42 -0700
Message-ID: <f350e75c-d1af-83ad-c7aa-8d29e2b74544@quicinc.com>
Date:   Fri, 29 Jul 2022 17:33:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] ASoC: qcom: SC7280: Add support for external DMIC bias
 supply
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <quic_rohkumar@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>, <devicetree@vger.kernel.org>
References: <1659016789-9933-1-git-send-email-quic_srivasam@quicinc.com>
 <YuKbpXVOeGn2l2gd@sirena.org.uk>
 <a92891b1-1fd0-82fa-3dc4-34282e6c2ef3@quicinc.com>
 <278edf67-834b-b673-8d71-88213130d4c8@linaro.org>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <278edf67-834b-b673-8d71-88213130d4c8@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/29/2022 2:09 PM, Srinivas Kandagatla wrote:
> Thanks for your time and valuable input Srini!!!
>
> On 28/07/2022 17:09, Srinivasa Rao Mandadapu wrote:
>>
>> On 7/28/2022 7:52 PM, Mark Brown wrote:
>> Thanks for your time Mark!!!
>>> On Thu, Jul 28, 2022 at 07:29:49PM +0530, Srinivasa Rao Mandadapu 
>>> wrote:
>>>> Update SC7280 machine driver for enabling external dmic bias supply,
>>>> which is required for villager evt boards.
>>>> +++ b/sound/soc/qcom/sc7280.c
>>>> @@ -356,6 +356,7 @@ static const struct snd_soc_ops sc7280_ops = {
>>>>   static const struct snd_soc_dapm_widget sc7280_snd_widgets[] = {
>>>>       SND_SOC_DAPM_HP("Headphone Jack", NULL),
>>>>       SND_SOC_DAPM_MIC("Headset Mic", NULL),
>>>> +    SND_SOC_DAPM_REGULATOR_SUPPLY("DMICVDD", 0, 0),
>>>>   };
>>>>   static int sc7280_snd_platform_probe(struct platform_device *pdev)
>>> Don't you want to connect this to something?  This won't do anything
>>> as-is.  I can't see any references to DMICVDD which might be failing to
>>> resolve in the current sound/soc/qcom.
>>
>> The connection is being done to "VA DMIC"through audio routing in 
>> board specific dts file.
>>
>> Will post the changes once the main dts patches are landed.
>>
>> Ex:-
>>
>> &sound {
>>      DMICVDD-supply = <&pp1800_l2c>;
>>
>>      audio-routing =
>>              "IN1_HPHL", "HPHL_OUT",
>>              "IN2_HPHR", "HPHR_OUT",
>>              "AMIC1", "MIC BIAS1",
>>              "AMIC2", "MIC BIAS2",
>>              "VA DMIC0", "DMICVDD",
>>              "VA DMIC1", "DMICVDD",
>>              "VA DMIC2", "DMICVDD",
>>              "VA DMIC3", "DMICVDD",
>
> You should just use "vdd-micb" instead of DMICVDD.
> There is already a SUPPLY DAPM in lpass-va-macro codec.
>
> --srini
Yes it's available in va macro. Will test with vdd-micb DAPM. if that 
works,  I think we can drop this patch.
>>              .....
>>
>>              .....
>>
>> };
>>
>>
