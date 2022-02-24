Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9828E4C39C6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 00:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235932AbiBXXla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 18:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233806AbiBXXl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 18:41:29 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA17B28D395
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 15:40:58 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id p15so5622580oip.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 15:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=3fp5mLpKZ3zy5G2P4hCvH5DKhH0aCoOyoqp6jDCbikU=;
        b=oMgM+eo6y7yBLKZtFIGN0z/xAVvy85Du3W+bVaDTEQ7kH7+wttbOMI58cXJtq3G41O
         1HbUb2InAJpF42m2aTi46ts1vn4JHH77930E8gNdZDIWc7oNevFKR8OmCr9CRIIc498l
         n7lVcjKE7QAknoybwZayw5Zqx7dXBNofkKUXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=3fp5mLpKZ3zy5G2P4hCvH5DKhH0aCoOyoqp6jDCbikU=;
        b=FzAiZrOtofbpChP0elTexrk0PPoJspbJa0QEwZd3whSe2GTjkgLxcdjEu8bAhIbz8k
         oK34TRgFWOwmj6i1Iyqa3PsMiLs4iPF9hKupiZQUaEFMRXZ6VvtDfptxrsV+ADw7397G
         H3fjGy2cB956+yfI6c7o5koVjDC9/dIO/IMdpzw6EBFHtVy7bGZx9dU3LZJA7dJojof4
         es5wZNZhB5IIh3qL8JgBCQ99LD8oU+GlMjiUeGK7G3tbZqZ0DOP5itErU4efec7fvuLG
         zqJKgEfVNeXohuUFaEn7SC1QatfsZrbv/HsatLoTvtVu+RMvYmyL/UsK9pLc7on1nyVs
         Ozhw==
X-Gm-Message-State: AOAM530edsGvxbvr8TqtMMOpoH54KC/aD3OFyT6wumZK2Lka6c3CfP4+
        /qdpCucIz3MprRQhgNayDfSJTMn6M2Aozxa9ApjlSg==
X-Google-Smtp-Source: ABdhPJwrQs5ORikoc8jsUMv2we/zgkuo7iGssiNXOFNYXobkeXGSbZXD/80AC9Xijdn7PmK1dC4RT/B6HvI+ck/5CdM=
X-Received: by 2002:aca:df44:0:b0:2ce:285f:cb99 with SMTP id
 w65-20020acadf44000000b002ce285fcb99mr294198oig.40.1645746057451; Thu, 24 Feb
 2022 15:40:57 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 24 Feb 2022 15:40:56 -0800
MIME-Version: 1.0
In-Reply-To: <1645716828-15305-7-git-send-email-quic_srivasam@quicinc.com>
References: <1645716828-15305-1-git-send-email-quic_srivasam@quicinc.com> <1645716828-15305-7-git-send-email-quic_srivasam@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 24 Feb 2022 15:40:56 -0800
Message-ID: <CAE-0n53K3Em52tTFK4zmcsf_ZzFbX4uQQ00_uH9=pq44chwyeg@mail.gmail.com>
Subject: Re: [PATCH v16 6/9] ASoC: qcom: Add support for codec dma driver
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, bjorn.andersson@linaro.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        judyhsiao@chromium.org, lgirdwood@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, quic_plai@quicinc.com, robh+dt@kernel.org,
        rohitkr@codeaurora.org, srinivas.kandagatla@linaro.org,
        tiwai@suse.com
Cc:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivasa Rao Mandadapu (2022-02-24 07:33:45)
> diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
> index 198f27c..b3af971 100644
> --- a/sound/soc/qcom/lpass-platform.c
> +++ b/sound/soc/qcom/lpass-platform.c
> @@ -684,6 +953,17 @@ static irqreturn_t lpass_dma_interrupt_handler(
>                 reg = LPAIF_IRQCLEAR_REG(v, LPAIF_IRQ_PORT_HOST);
>                 val = 0;
>         break;
> +       case LPASS_CDC_DMA_RX0 ... LPASS_CDC_DMA_RX9:
> +       case LPASS_CDC_DMA_TX0 ... LPASS_CDC_DMA_TX8:
> +               map = drvdata->rxtx_lpaif_map;
> +               reg = LPAIF_RXTX_IRQCLEAR_REG(v, LPAIF_IRQ_PORT_HOST);
> +               val = 0;
> +       break;
> +       case LPASS_CDC_DMA_VA_TX0 ... LPASS_CDC_DMA_VA_TX8:
> +               map = drvdata->va_lpaif_map;
> +               reg = LPAIF_VA_IRQCLEAR_REG(v, LPAIF_IRQ_PORT_HOST);
> +               val = 0;
> +       break;

These breaks have the wrong indentation.

>         default:
>         dev_err(soc_runtime->dev, "%s: invalid  %d interface\n", __func__, dai_id);
>         return -EINVAL;
> @@ -791,16 +1071,115 @@ static irqreturn_t lpass_platform_hdmiif_irq(int irq, void *data)
>                                 return rv;
>                 }
>         }
> +       return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t lpass_platform_rxtxif_irq(int irq, void *data)
> +{
> +       struct lpass_data *drvdata = data;
> +       struct lpass_variant *v = drvdata->variant;
> +       unsigned int irqs;
> +       irqreturn_t rv;
> +       int chan;
> +
> +       rv = regmap_read(drvdata->rxtx_lpaif_map,
> +                       LPAIF_RXTX_IRQSTAT_REG(v, LPAIF_IRQ_PORT_HOST), &irqs);
> +
> +       /* Handle per channel interrupts */
> +       for (chan = 0; chan < LPASS_MAX_CDC_DMA_CHANNELS; chan++) {
> +               if (irqs & LPAIF_IRQ_ALL(chan) && drvdata->rxtx_substream[chan]) {
> +                       rv = lpass_dma_interrupt_handler(
> +                                               drvdata->rxtx_substream[chan],
> +                                               drvdata, chan, irqs);
> +                       if (rv != IRQ_HANDLED)
> +                               return rv;
> +               }
> +       }
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t lpass_platform_vaif_irq(int irq, void *data)
> +{
> +       struct lpass_data *drvdata = data;
> +       struct lpass_variant *v = drvdata->variant;
> +       unsigned int irqs;
> +       irqreturn_t rv;
> +       int chan;
> +
> +       rv = regmap_read(drvdata->va_lpaif_map,
> +                       LPAIF_VA_IRQSTAT_REG(v, LPAIF_IRQ_PORT_HOST), &irqs);
>
> +       /* Handle per channel interrupts */
> +       for (chan = 0; chan < LPASS_MAX_VA_CDC_DMA_CHANNELS; chan++) {
> +               if (irqs & LPAIF_IRQ_ALL(chan) && drvdata->va_substream[chan]) {
> +                       rv = lpass_dma_interrupt_handler(
> +                                               drvdata->va_substream[chan],
> +                                               drvdata, chan, irqs);
> +                       if (rv != IRQ_HANDLED)
> +                               return rv;
> +               }
> +       }
>         return IRQ_HANDLED;
>  }
>
> +static int lpass_platform_prealloc_cdc_dma_buffer(struct snd_soc_component *component,
> +                                                 struct snd_pcm *pcm, int dai_id)
> +{
> +       struct lpass_data *drvdata = snd_soc_component_get_drvdata(component);
> +       struct snd_pcm_substream *substream;
> +       struct snd_dma_buffer *buf;
> +
> +       if (pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream)
> +               substream = pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream;
> +       else
> +               substream = pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream;
> +
> +       buf = &substream->dma_buffer;
> +       buf->dev.dev = pcm->card->dev;
> +       buf->private_data = NULL;
> +
> +       /* Assign Codec DMA buffer pointers */
> +       buf->dev.type = SNDRV_DMA_TYPE_CONTINUOUS;
> +
> +       switch (dai_id) {
> +       case LPASS_CDC_DMA_RX0 ... LPASS_CDC_DMA_RX9:
> +               buf->bytes = lpass_platform_rxtx_hardware.buffer_bytes_max;
> +               buf->addr = drvdata->rxtx_cdc_dma_lpm_buf;
> +               break;
> +       case LPASS_CDC_DMA_TX0 ... LPASS_CDC_DMA_TX8:
> +               buf->bytes = lpass_platform_rxtx_hardware.buffer_bytes_max;
> +               buf->addr = drvdata->rxtx_cdc_dma_lpm_buf + LPASS_RXTX_CDC_DMA_LPM_BUFF_SIZE;
> +               break;
> +       case LPASS_CDC_DMA_VA_TX0 ... LPASS_CDC_DMA_VA_TX8:
> +               buf->bytes = lpass_platform_va_hardware.buffer_bytes_max;
> +               buf->addr = drvdata->va_cdc_dma_lpm_buf;
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       buf->area = (unsigned char * __force)memremap(buf->addr, buf->bytes, MEMREMAP_WT);

What's the cast and __force for now? MEMREMAP_WT is almost never used so
this looks wrong. Why can't MEMREMAP_WC be used? But if it's DMA then
why isn't dma_map_resource() being used?

> +
> +       return 0;
> +}
> +
>  static int lpass_platform_pcm_new(struct snd_soc_component *component,
>                                   struct snd_soc_pcm_runtime *soc_runtime)
>  {
>         struct snd_pcm *pcm = soc_runtime->pcm;
> +       struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(soc_runtime, 0);
> +       unsigned int dai_id = cpu_dai->driver->id;
> +
>         size_t size = lpass_platform_pcm_hardware.buffer_bytes_max;
>
> +       /*
> +        * Lpass codec dma can access only lpass lpm hardware memory.
> +        * ioremap is for HLOS to access hardware memory.
> +        */
> +       if (is_cdc_dma_port(dai_id))
> +               return lpass_platform_prealloc_cdc_dma_buffer(component, pcm, dai_id);
> +
>         return snd_pcm_set_fixed_buffer_all(pcm, SNDRV_DMA_TYPE_DEV,
>                                             component->dev, size);
>  }
