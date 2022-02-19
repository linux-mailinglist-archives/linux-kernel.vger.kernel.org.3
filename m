Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5014BCA26
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 19:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242970AbiBSSpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 13:45:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237985AbiBSSpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 13:45:43 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5612D0B7F;
        Sat, 19 Feb 2022 10:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645296323; x=1676832323;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5v+5eGF0fWqQFfqO8WRWVTuzMoPWbF2CAaKbG/Q1V5s=;
  b=cv+A/fga6dk3Z/MjR/dfGD1quAdIMnw5kwVHl7+SeyLHtxeVdPwIuL/n
   2IYcqUOIMuHxU/QtMZTvCR3h+IP49OCGIVT6LaWYR4jTH0ToTb1yAR9kc
   EUBgRXCpl+XN8U7LprUv3htX/CQTXQtH6lZ8MKDkozDTeZXgZr8N6fPVD
   Q=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 19 Feb 2022 10:45:23 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2022 10:45:23 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Sat, 19 Feb 2022 10:45:22 -0800
Received: from [10.216.20.52] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Sat, 19 Feb
 2022 10:45:16 -0800
Message-ID: <356abae0-c19b-ccbb-fa5f-4e91619243bf@quicinc.com>
Date:   Sun, 20 Feb 2022 00:15:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [RESEND v13 04/10] ASoC: qcom: Add helper function to get dma
 control and lpaif handle
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>, <agross@kernel.org>,
        <alsa-devel@alsa-project.org>, <bgoswami@codeaurora.org>,
        <bjorn.andersson@linaro.org>, <broonie@kernel.org>,
        <devicetree@vger.kernel.org>, <judyhsiao@chromium.org>,
        <lgirdwood@gmail.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <perex@perex.cz>,
        <quic_plai@quicinc.com>, <robh+dt@kernel.org>,
        <rohitkr@codeaurora.org>, <srinivas.kandagatla@linaro.org>,
        <tiwai@suse.com>
CC:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1644850708-11099-1-git-send-email-quic_srivasam@quicinc.com>
 <1644850708-11099-5-git-send-email-quic_srivasam@quicinc.com>
 <CAE-0n504R0avU9Ybj68jxqDRH-Ya5ro0hPo5GJ=2zC6p2SZ_=g@mail.gmail.com>
 <13007276-c827-0cc4-5db1-396c5184bb35@quicinc.com>
 <CAE-0n538Lhp7U=pEB_7R5EARG6LveeO=jvF+kE7HCCEXUEm-kQ@mail.gmail.com>
From:   "Srinivasa Rao Mandadapu (Temp)" <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <CAE-0n538Lhp7U=pEB_7R5EARG6LveeO=jvF+kE7HCCEXUEm-kQ@mail.gmail.com>
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


On 2/18/2022 1:11 AM, Stephen Boyd wrote:
Thanks for Your time Stephen!!!
> Quoting Srinivasa Rao Mandadapu (2022-02-15 21:11:29)
>> On 2/15/2022 6:40 AM, Stephen Boyd wrote:
>> Thanks for your time Stephen!!!
>>> Quoting Srinivasa Rao Mandadapu (2022-02-14 06:58:22)
>>>> Add support function to get dma control and lpaif handle to avoid
>>>> repeated code in platform driver
>>>>
>>>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>>>> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>>>> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>>>> Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>>> ---
>>>>    sound/soc/qcom/lpass-platform.c | 113 +++++++++++++++++++++++-----------------
>>>>    1 file changed, 66 insertions(+), 47 deletions(-)
>>>>
>>>> diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
>>>> index a44162c..5d77240 100644
>>>> --- a/sound/soc/qcom/lpass-platform.c
>>>> +++ b/sound/soc/qcom/lpass-platform.c
>>>> @@ -177,6 +177,49 @@ static int lpass_platform_pcmops_close(struct snd_soc_component *component,
>>>>           return 0;
>>>>    }
>>>>
>>>> +static void __lpass_get_lpaif_handle(struct snd_pcm_substream *substream,
>>> const?
>> Okay. will add const to substream pointer.
>>>> +                                    struct snd_soc_component *component,
>>> const?
>> Here const is giving compilation errors in below code.
> Ok
>
>>>> +                       l_id = pcm_data->dma_ch;
>>>> +                       l_dmactl = drvdata->rd_dmactl;
>>>> +               } else {
>>>> +                       l_dmactl = drvdata->wr_dmactl;
>>>> +                       l_id = pcm_data->dma_ch - v->wrdma_channel_start;
>>>> +               }
>>>> +               l_map = drvdata->lpaif_map;
>>>> +               break;
>>>> +       case LPASS_DP_RX:
>>>> +               l_id = pcm_data->dma_ch;
>>>> +               l_dmactl = drvdata->hdmi_rd_dmactl;
>>>> +               l_map = drvdata->hdmiif_map;
>>>> +               break;
>>>> +       default:
>>>> +               break;
>>>> +       }
>>>> +       if (dmactl)
>>>> +               *dmactl = l_dmactl;
>>>> +       if (id)
>>>> +               *id = l_id;
>>>> +       if (map)
>>>> +               *map = l_map;
>>> Why not 'return 0' here and return -EINVAL in the default case above? Then
>>> we can skip the checks for !map or !dmactl below and simply bail out if
>>> it failed with an error value.
>> Here the check is for input params. some users call for only damctl or
>> only map.
> Yes the check is to make sure there's a pointer to store the value into.
> I get that. The users are all internal to this driver though because
> the function is static. If the function returned an error because it
> couldn't find something then we wouldn't have to test the resulting
> pointers for success, instead we could check for a return value.
> Similarly, it may be clearer to have a single get for each item and then
> return a pointer from the function vs. passing it in to extract
> something. It may duplicate some code but otherwise the code would be
> clearer because we're getting one thing and can pass an error value
> through the pointer with PTR_ERR().

Okay. Agreed. But in initial review comments, asked to make common 
function for code readability,

and to avoid duplicate code.

Anyway will change accordingly and re post it.

