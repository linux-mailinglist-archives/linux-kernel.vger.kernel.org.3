Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CB54B7FE7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 06:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344555AbiBPFLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 00:11:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234289AbiBPFLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 00:11:52 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1563245AA;
        Tue, 15 Feb 2022 21:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644988300; x=1676524300;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Azx+hgNEsA4sO0hfumOMvKLBACFPaBZZE4zmVrEYDic=;
  b=eK4t0oHh2P4A3V7RVPUqa/sVdeAElmw6oqH+MceGB4+oCQJ9N7Mx1d5V
   i1JTNLyCkFP1HPEMplwQCetJZX9D7obzCJeXiF0VLQ3IkRYNHyU+scBqG
   sL4xQ/I+IsnsLJ+vbDC9w4qaRdEyFdckWMMFtjL/c28wqmyGWu5GEdv0n
   s=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 15 Feb 2022 21:11:40 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 21:11:38 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 15 Feb 2022 21:11:38 -0800
Received: from [10.216.55.237] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Tue, 15 Feb
 2022 21:11:32 -0800
Subject: Re: [RESEND v13 04/10] ASoC: qcom: Add helper function to get dma
 control and lpaif handle
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
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
Message-ID: <13007276-c827-0cc4-5db1-396c5184bb35@quicinc.com>
Date:   Wed, 16 Feb 2022 10:41:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAE-0n504R0avU9Ybj68jxqDRH-Ya5ro0hPo5GJ=2zC6p2SZ_=g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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


On 2/15/2022 6:40 AM, Stephen Boyd wrote:
Thanks for your time Stephen!!!
> Quoting Srinivasa Rao Mandadapu (2022-02-14 06:58:22)
>> Add support function to get dma control and lpaif handle to avoid
>> repeated code in platform driver
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   sound/soc/qcom/lpass-platform.c | 113 +++++++++++++++++++++++-----------------
>>   1 file changed, 66 insertions(+), 47 deletions(-)
>>
>> diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
>> index a44162c..5d77240 100644
>> --- a/sound/soc/qcom/lpass-platform.c
>> +++ b/sound/soc/qcom/lpass-platform.c
>> @@ -177,6 +177,49 @@ static int lpass_platform_pcmops_close(struct snd_soc_component *component,
>>          return 0;
>>   }
>>
>> +static void __lpass_get_lpaif_handle(struct snd_pcm_substream *substream,
> const?
Okay. will add const to substream pointer.
>
>> +                                    struct snd_soc_component *component,
> const?
Here const is giving compilation errors in below code.
>
>> +                                    struct lpaif_dmactl **dmactl, int *id, struct regmap **map)
>> +{
>> +       struct snd_soc_pcm_runtime *soc_runtime = asoc_substream_to_rtd(substream);
>> +       struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(soc_runtime, 0);
>> +       struct lpass_data *drvdata = snd_soc_component_get_drvdata(component);
>> +       struct snd_pcm_runtime *rt = substream->runtime;
>> +       struct lpass_pcm_data *pcm_data = rt->private_data;
>> +       struct lpass_variant *v = drvdata->variant;
>> +       int dir = substream->stream;
>> +       unsigned int dai_id = cpu_dai->driver->id;
>> +       struct lpaif_dmactl *l_dmactl = NULL;
>> +       struct regmap *l_map = NULL;
>> +       int l_id = 0;
>> +
>> +       switch (dai_id) {
>> +       case MI2S_PRIMARY ... MI2S_QUINARY:
>> +               if (dir == SNDRV_PCM_STREAM_PLAYBACK) {
> Please write if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) and
> drop 'dir' local variable.
Okay. will change it.
>
>> +                       l_id = pcm_data->dma_ch;
>> +                       l_dmactl = drvdata->rd_dmactl;
>> +               } else {
>> +                       l_dmactl = drvdata->wr_dmactl;
>> +                       l_id = pcm_data->dma_ch - v->wrdma_channel_start;
>> +               }
>> +               l_map = drvdata->lpaif_map;
>> +               break;
>> +       case LPASS_DP_RX:
>> +               l_id = pcm_data->dma_ch;
>> +               l_dmactl = drvdata->hdmi_rd_dmactl;
>> +               l_map = drvdata->hdmiif_map;
>> +               break;
>> +       default:
>> +               break;
>> +       }
>> +       if (dmactl)
>> +               *dmactl = l_dmactl;
>> +       if (id)
>> +               *id = l_id;
>> +       if (map)
>> +               *map = l_map;
> Why not 'return 0' here and return -EINVAL in the default case above? Then
> we can skip the checks for !map or !dmactl below and simply bail out if
> it failed with an error value.

Here the check is for input params. some users call for only damctl or 
only map.

so check seems mandatory for updating only valid fields. Will remove 
default case which may never occurs.

>
>> +}
>> +
>>   static int lpass_platform_pcmops_hw_params(struct snd_soc_component *component,
>>                                             struct snd_pcm_substream *substream,
>>                                             struct snd_pcm_hw_params *params)
>> @@ -191,21 +234,15 @@ static int lpass_platform_pcmops_hw_params(struct snd_soc_component *component,
>>          unsigned int channels = params_channels(params);
>>          unsigned int regval;
>>          struct lpaif_dmactl *dmactl;
>> -       int id, dir = substream->stream;
>> +       int id;
>>          int bitwidth;
>>          int ret, dma_port = pcm_data->i2s_port + v->dmactl_audif_start;
>>          unsigned int dai_id = cpu_dai->driver->id;
>>
>> -       if (dir ==  SNDRV_PCM_STREAM_PLAYBACK) {
>> -               id = pcm_data->dma_ch;
>> -               if (dai_id == LPASS_DP_RX)
>> -                       dmactl = drvdata->hdmi_rd_dmactl;
>> -               else
>> -                       dmactl = drvdata->rd_dmactl;
>> -
>> -       } else {
>> -               dmactl = drvdata->wr_dmactl;
>> -               id = pcm_data->dma_ch - v->wrdma_channel_start;
>> +       __lpass_get_lpaif_handle(substream, component, &dmactl, &id, NULL);
>> +       if (!dmactl) {
>> +               dev_err(soc_runtime->dev, "failed to get dmactl handle\n");
>> +               return -EINVAL;
>>          }
>>
>>          bitwidth = snd_pcm_format_width(format);
>> @@ -350,10 +387,11 @@ static int lpass_platform_pcmops_hw_free(struct snd_soc_component *component,
>>          struct regmap *map;
>>          unsigned int dai_id = cpu_dai->driver->id;
>>
>> -       if (dai_id == LPASS_DP_RX)
>> -               map = drvdata->hdmiif_map;
>> -       else
>> -               map = drvdata->lpaif_map;
>> +       __lpass_get_lpaif_handle(substream, component, NULL, NULL, &map);
>> +       if (!map) {
>> +               dev_err(soc_runtime->dev, "failed to get dmactl handle\n");
>> +               return -EINVAL;
>> +       }
>>
>>          reg = LPAIF_DMACTL_REG(v, pcm_data->dma_ch, substream->stream, dai_id);
>>          ret = regmap_write(map, reg, 0);
>> @@ -379,22 +417,12 @@ static int lpass_platform_pcmops_prepare(struct snd_soc_component *component,
>>          int ret, id, ch, dir = substream->stream;
>>          unsigned int dai_id = cpu_dai->driver->id;
>>
>> -
>>          ch = pcm_data->dma_ch;
>> -       if (dir ==  SNDRV_PCM_STREAM_PLAYBACK) {
>> -               if (dai_id == LPASS_DP_RX) {
>> -                       dmactl = drvdata->hdmi_rd_dmactl;
>> -                       map = drvdata->hdmiif_map;
>> -               } else {
>> -                       dmactl = drvdata->rd_dmactl;
>> -                       map = drvdata->lpaif_map;
>> -               }
>>
>> -               id = pcm_data->dma_ch;
>> -       } else {
>> -               dmactl = drvdata->wr_dmactl;
>> -               id = pcm_data->dma_ch - v->wrdma_channel_start;
>> -               map = drvdata->lpaif_map;
>> +       __lpass_get_lpaif_handle(substream, component, &dmactl, &id, &map);
>> +       if (!dmactl) {
>> +               dev_err(soc_runtime->dev, "failed to get dmactl handle\n");
>> +               return -EINVAL;
>>          }
>>
>>          ret = regmap_write(map, LPAIF_DMABASE_REG(v, ch, dir, dai_id),
>> @@ -444,25 +472,15 @@ static int lpass_platform_pcmops_trigger(struct snd_soc_component *component,
>>          struct lpaif_dmactl *dmactl;
>>          struct regmap *map;
>>          int ret, ch, id;
>> -       int dir = substream->stream;
>>          unsigned int reg_irqclr = 0, val_irqclr = 0;
>>          unsigned int  reg_irqen = 0, val_irqen = 0, val_mask = 0;
>>          unsigned int dai_id = cpu_dai->driver->id;
>>
>>          ch = pcm_data->dma_ch;
>> -       if (dir ==  SNDRV_PCM_STREAM_PLAYBACK) {
>> -               id = pcm_data->dma_ch;
>> -               if (dai_id == LPASS_DP_RX) {
>> -                       dmactl = drvdata->hdmi_rd_dmactl;
>> -                       map = drvdata->hdmiif_map;
>> -               } else {
>> -                       dmactl = drvdata->rd_dmactl;
>> -                       map = drvdata->lpaif_map;
>> -               }
>> -       } else {
>> -               dmactl = drvdata->wr_dmactl;
>> -               id = pcm_data->dma_ch - v->wrdma_channel_start;
>> -               map = drvdata->lpaif_map;
>> +       __lpass_get_lpaif_handle(substream, component, &dmactl, &id, &map);
>> +       if (!dmactl) {
>> +               dev_err(soc_runtime->dev, "failed to get dmactl handle\n");
>> +               return -EINVAL;
>>          }
>>
>>          switch (cmd) {
>> @@ -597,10 +615,11 @@ static snd_pcm_uframes_t lpass_platform_pcmops_pointer(
>>          struct regmap *map;
>>          unsigned int dai_id = cpu_dai->driver->id;
>>
>> -       if (dai_id == LPASS_DP_RX)
>> -               map = drvdata->hdmiif_map;
>> -       else
>> -               map = drvdata->lpaif_map;
>> +       __lpass_get_lpaif_handle(substream, component, NULL, NULL, &map);
>> +       if (!map) {
>> +               dev_err(soc_runtime->dev, "failed to get dmactl handle\n");
>> +               return -EINVAL;
>> +       }
>>
>>          ch = pcm_data->dma_ch;
>>
>> --
>> 2.7.4
>>
