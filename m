Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB564C540F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 06:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiBZF6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 00:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiBZF6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 00:58:48 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67D932067;
        Fri, 25 Feb 2022 21:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645855094; x=1677391094;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AmXUBSuHFySHyrVMXfN8pTiAjw657UhHtMjurHCjX2M=;
  b=Yk3qdSqnLCsOMf/GtgQyH7Vo6791gz5s4AOHAD2aGPz4UmkIP0E/2zOl
   +7+ZCwReJNBIUyvFiCG5Xn27Uu16WfvxnQ6Gz0yjevsuENLKZHP9LgkWm
   SW7Jkrt/ZeKsjNjCnBeHeprURQoc3S26V+zgbiffdb3JVsf2NcfBN9WX1
   Y=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 25 Feb 2022 21:58:14 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 21:58:13 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 25 Feb 2022 21:58:12 -0800
Received: from [10.216.53.140] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Fri, 25 Feb
 2022 21:58:06 -0800
Message-ID: <6e498021-bf08-3fd8-a3b8-2fcba054f4a0@quicinc.com>
Date:   Sat, 26 Feb 2022 11:28:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v16 6/9] ASoC: qcom: Add support for codec dma driver
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
References: <1645716828-15305-1-git-send-email-quic_srivasam@quicinc.com>
 <1645716828-15305-7-git-send-email-quic_srivasam@quicinc.com>
 <CAE-0n53K3Em52tTFK4zmcsf_ZzFbX4uQQ00_uH9=pq44chwyeg@mail.gmail.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <CAE-0n53K3Em52tTFK4zmcsf_ZzFbX4uQQ00_uH9=pq44chwyeg@mail.gmail.com>
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


On 2/25/2022 5:10 AM, Stephen Boyd wrote:
Thanks for your time Stephen!!!
> Quoting Srinivasa Rao Mandadapu (2022-02-24 07:33:45)
>> diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
>> index 198f27c..b3af971 100644
>> --- a/sound/soc/qcom/lpass-platform.c
>> +++ b/sound/soc/qcom/lpass-platform.c
>> @@ -684,6 +953,17 @@ static irqreturn_t lpass_dma_interrupt_handler(
>>                  reg = LPAIF_IRQCLEAR_REG(v, LPAIF_IRQ_PORT_HOST);
>>                  val = 0;
>>          break;
>> +       case LPASS_CDC_DMA_RX0 ... LPASS_CDC_DMA_RX9:
>> +       case LPASS_CDC_DMA_TX0 ... LPASS_CDC_DMA_TX8:
>> +               map = drvdata->rxtx_lpaif_map;
>> +               reg = LPAIF_RXTX_IRQCLEAR_REG(v, LPAIF_IRQ_PORT_HOST);
>> +               val = 0;
>> +       break;
>> +       case LPASS_CDC_DMA_VA_TX0 ... LPASS_CDC_DMA_VA_TX8:
>> +               map = drvdata->va_lpaif_map;
>> +               reg = LPAIF_VA_IRQCLEAR_REG(v, LPAIF_IRQ_PORT_HOST);
>> +               val = 0;
>> +       break;
> These breaks have the wrong indentation.
Okay. will fix it.
>
>>          default:
>>          dev_err(soc_runtime->dev, "%s: invalid  %d interface\n", __func__, dai_id);
>>          return -EINVAL;
>> @@ -791,16 +1071,115 @@ static irqreturn_t lpass_platform_hdmiif_irq(int irq, void *data)
>>                                  return rv;
>>                  }
>>          }
>> +       return IRQ_HANDLED;
>> +}
>> +
>> +static irqreturn_t lpass_platform_rxtxif_irq(int irq, void *data)
>> +{
>> +       struct lpass_data *drvdata = data;
>> +       struct lpass_variant *v = drvdata->variant;
>> +       unsigned int irqs;
>> +       irqreturn_t rv;
>> +       int chan;
>> +
>> +       rv = regmap_read(drvdata->rxtx_lpaif_map,
>> +                       LPAIF_RXTX_IRQSTAT_REG(v, LPAIF_IRQ_PORT_HOST), &irqs);
>> +
>> +       /* Handle per channel interrupts */
>> +       for (chan = 0; chan < LPASS_MAX_CDC_DMA_CHANNELS; chan++) {
>> +               if (irqs & LPAIF_IRQ_ALL(chan) && drvdata->rxtx_substream[chan]) {
>> +                       rv = lpass_dma_interrupt_handler(
>> +                                               drvdata->rxtx_substream[chan],
>> +                                               drvdata, chan, irqs);
>> +                       if (rv != IRQ_HANDLED)
>> +                               return rv;
>> +               }
>> +       }
>> +
>> +       return IRQ_HANDLED;
>> +}
>> +
>> +static irqreturn_t lpass_platform_vaif_irq(int irq, void *data)
>> +{
>> +       struct lpass_data *drvdata = data;
>> +       struct lpass_variant *v = drvdata->variant;
>> +       unsigned int irqs;
>> +       irqreturn_t rv;
>> +       int chan;
>> +
>> +       rv = regmap_read(drvdata->va_lpaif_map,
>> +                       LPAIF_VA_IRQSTAT_REG(v, LPAIF_IRQ_PORT_HOST), &irqs);
>>
>> +       /* Handle per channel interrupts */
>> +       for (chan = 0; chan < LPASS_MAX_VA_CDC_DMA_CHANNELS; chan++) {
>> +               if (irqs & LPAIF_IRQ_ALL(chan) && drvdata->va_substream[chan]) {
>> +                       rv = lpass_dma_interrupt_handler(
>> +                                               drvdata->va_substream[chan],
>> +                                               drvdata, chan, irqs);
>> +                       if (rv != IRQ_HANDLED)
>> +                               return rv;
>> +               }
>> +       }
>>          return IRQ_HANDLED;
>>   }
>>
>> +static int lpass_platform_prealloc_cdc_dma_buffer(struct snd_soc_component *component,
>> +                                                 struct snd_pcm *pcm, int dai_id)
>> +{
>> +       struct lpass_data *drvdata = snd_soc_component_get_drvdata(component);
>> +       struct snd_pcm_substream *substream;
>> +       struct snd_dma_buffer *buf;
>> +
>> +       if (pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream)
>> +               substream = pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream;
>> +       else
>> +               substream = pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream;
>> +
>> +       buf = &substream->dma_buffer;
>> +       buf->dev.dev = pcm->card->dev;
>> +       buf->private_data = NULL;
>> +
>> +       /* Assign Codec DMA buffer pointers */
>> +       buf->dev.type = SNDRV_DMA_TYPE_CONTINUOUS;
>> +
>> +       switch (dai_id) {
>> +       case LPASS_CDC_DMA_RX0 ... LPASS_CDC_DMA_RX9:
>> +               buf->bytes = lpass_platform_rxtx_hardware.buffer_bytes_max;
>> +               buf->addr = drvdata->rxtx_cdc_dma_lpm_buf;
>> +               break;
>> +       case LPASS_CDC_DMA_TX0 ... LPASS_CDC_DMA_TX8:
>> +               buf->bytes = lpass_platform_rxtx_hardware.buffer_bytes_max;
>> +               buf->addr = drvdata->rxtx_cdc_dma_lpm_buf + LPASS_RXTX_CDC_DMA_LPM_BUFF_SIZE;
>> +               break;
>> +       case LPASS_CDC_DMA_VA_TX0 ... LPASS_CDC_DMA_VA_TX8:
>> +               buf->bytes = lpass_platform_va_hardware.buffer_bytes_max;
>> +               buf->addr = drvdata->va_cdc_dma_lpm_buf;
>> +               break;
>> +       default:
>> +               break;
>> +       }
>> +
>> +       buf->area = (unsigned char * __force)memremap(buf->addr, buf->bytes, MEMREMAP_WT);
> What's the cast and __force for now? MEMREMAP_WT is almost never used so
Here dma_buffer structure has virtual address(buf->area) of unsigned 
char pointer but memremap returns void pointer.
> this looks wrong. Why can't MEMREMAP_WC be used? But if it's DMA then
Okay. Will update the flag MEMREMAP_WT
> why isn't dma_map_resource() being used?

I am sorry bit confused here. You mean some thing like below.

For Physical address mapping: buf->addr = dma_map_resource(pcm->card->dev, drvdata->va_cdc_dma_lpm_buf,
			     buf->bytes, DMA_BIDIRECTIONAL, 0);
For virtual address mapping. buf->area = (unsigned char * __force)memremap(buf->addr, buf->bytes, MEMREMAP_WC);

>
>> +
>> +       return 0;
>> +}
>> +
>>   static int lpass_platform_pcm_new(struct snd_soc_component *component,
>>                                    struct snd_soc_pcm_runtime *soc_runtime)
>>   {
>>          struct snd_pcm *pcm = soc_runtime->pcm;
>> +       struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(soc_runtime, 0);
>> +       unsigned int dai_id = cpu_dai->driver->id;
>> +
>>          size_t size = lpass_platform_pcm_hardware.buffer_bytes_max;
>>
>> +       /*
>> +        * Lpass codec dma can access only lpass lpm hardware memory.
>> +        * ioremap is for HLOS to access hardware memory.
>> +        */
>> +       if (is_cdc_dma_port(dai_id))
>> +               return lpass_platform_prealloc_cdc_dma_buffer(component, pcm, dai_id);
>> +
>>          return snd_pcm_set_fixed_buffer_all(pcm, SNDRV_DMA_TYPE_DEV,
>>                                              component->dev, size);
>>   :
