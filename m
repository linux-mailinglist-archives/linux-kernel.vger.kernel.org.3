Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4B84BAA4B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 20:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245545AbiBQTut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 14:50:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245540AbiBQTur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 14:50:47 -0500
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56B0151694
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 11:50:31 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id p206-20020a4a2fd7000000b0031bfec11983so836698oop.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 11:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=eWaEdeMD4Xv456vmrRGc9qq+PbUbRsqsTAjVK+O/A3k=;
        b=PQ/+IxLufKEfZw3+3BxKwa39k5Der0KnGqK9LOeDgyvMzu+9rYUbaXvDW5F2sDCK9i
         rHPE+pmib/x+k9+D9i9Y2t5i4znFUgb3PS9gS6vVcNu/X78T5zEaV8RnW8dYBHe5ADrl
         33JqjY3PS+zvUy8ZV8YPmX2cw56SZNWHf5DW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=eWaEdeMD4Xv456vmrRGc9qq+PbUbRsqsTAjVK+O/A3k=;
        b=L52jXXu0tyhJ4rMnGIxx3evY9XY1P/uQIYkV+jq/18AkeNpuWfasunIbak7VMhJWM/
         oezQwtujfF2qT8vIUIWGCo6OOZWjfj50Ve9uFIHVIfbdrVHbzT+i87cQ6vYCfwH/OBUN
         B/t6elhghZxvOB+gorLtbSWT+pBZ0WYAqx+OOJkXYUdzZVmlMZzJve9vm9xyXWIS4Uo6
         nsL0CEU43g+xzuONKoFQdCSVtpkTh7ZO0JUwqWGWOSZT9jdY5jhJy9agHI4eqMeiocjj
         gTmuE+Tivh6N0HB8xIaUTZbTHeh2N/Tomj2CTsbvIg90Q6Ply11aRrHtGbwdsOy5CIX6
         NuuA==
X-Gm-Message-State: AOAM533ak5VPWppLO8X1ktAJF0t/8ExSatVWHM16lhHWag534t1C7eKr
        pbLkiDY1fZpdkSqnQ8nR+E/yP7NuD1LhHcltKxpfGA==
X-Google-Smtp-Source: ABdhPJygWUf+9oy/v+5ILtSSdP1c6aKp1Fl/1GiMiljIGiyPEsgSm7xOdBhhbwj67EUli0MEDgFysnA46NQ92dSAXMk=
X-Received: by 2002:a05:6870:5829:b0:c8:9f42:f919 with SMTP id
 r41-20020a056870582900b000c89f42f919mr1722376oap.54.1645127431001; Thu, 17
 Feb 2022 11:50:31 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Feb 2022 11:50:30 -0800
MIME-Version: 1.0
In-Reply-To: <0093b56c-95a0-7344-1480-2473f790db90@quicinc.com>
References: <1644850708-11099-1-git-send-email-quic_srivasam@quicinc.com>
 <1644850708-11099-8-git-send-email-quic_srivasam@quicinc.com>
 <CAE-0n507RB89eoTPGUemdWh4cbcXtWkxKLt_0nCy8xGeJhb1sA@mail.gmail.com> <0093b56c-95a0-7344-1480-2473f790db90@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 17 Feb 2022 11:50:30 -0800
Message-ID: <CAE-0n52+r5nN6HC6KQt-Yioh3r+9bgY_V-KA1yQ071-zY7qfEQ@mail.gmail.com>
Subject: Re: [RESEND v13 07/10] ASoC: qcom: Add support for codec dma driver
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
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivasa Rao Mandadapu (2022-02-15 22:53:11)
>
> On 2/15/2022 6:57 AM, Stephen Boyd wrote:
> Thanks for your time and valuable review comments Stephen!!!
> > Quoting Srinivasa Rao Mandadapu (2022-02-14 06:58:25)
> >> diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
> >> index 5d77240..12b8d40 100644
> >> --- a/sound/soc/qcom/lpass-platform.c
> >> +++ b/sound/soc/qcom/lpass-platform.c
[...]
> >
> >> +       if (ret)
> >> +               return ret;
> >> +
> >> +       buf = &substream->dma_buffer;
> >> +       buf->dev.dev = pcm->card->dev;
> >> +       buf->private_data = NULL;
> >> +
> >> +       /* Assign Codec DMA buffer pointers */
> >> +       buf->dev.type = SNDRV_DMA_TYPE_CONTINUOUS;
> >> +
> >> +       switch (dai_id) {
> >> +       case LPASS_CDC_DMA_RX0 ... LPASS_CDC_DMA_RX9:
> >> +               buf->bytes = lpass_platform_rxtx_hardware.buffer_bytes_max;
> >> +               buf->addr = drvdata->rxtx_cdc_dma_lpm_buf;
> >> +               break;
> >> +       case LPASS_CDC_DMA_TX0 ... LPASS_CDC_DMA_TX8:
> >> +               buf->bytes = lpass_platform_rxtx_hardware.buffer_bytes_max;
> >> +               buf->addr = drvdata->rxtx_cdc_dma_lpm_buf + LPASS_RXTX_CDC_DMA_LPM_BUFF_SIZE;
> >> +               break;
> >> +       case LPASS_CDC_DMA_VA_TX0 ... LPASS_CDC_DMA_VA_TX8:
> >> +               buf->bytes = lpass_platform_va_hardware.buffer_bytes_max;
> >> +               buf->addr = drvdata->va_cdc_dma_lpm_buf;
> >> +               break;
> >> +       default:
> >> +               break;
> >> +       }
> >> +
> >> +       buf->area = (unsigned char * __force)ioremap(buf->addr, buf->bytes);
> > Why aren't we using the DMA mapping framework?
> Here, Need to use hardware memory, that is LPASS LPM region for codec DMA.

It does not look like iomem, so the usage of ioremap() is wrong. I
understand that it is some place inside the audio subsystem used to DMA.
ioremap() memory should be accessed through the io accessors,
readl/writel, ioread/iowrite.

> >> @@ -827,6 +1207,31 @@ static int lpass_platform_pcmops_resume(struct snd_soc_component *component)
> >>          return regcache_sync(map);
> >>   }
> >>
> >> +static int lpass_platform_copy(struct snd_soc_component *component,
> >> +                              struct snd_pcm_substream *substream, int channel,
> >> +                              unsigned long pos, void __user *buf, unsigned long bytes)
> >> +{
> >> +       struct snd_pcm_runtime *rt = substream->runtime;
> >> +       unsigned int dai_id = component->id;
> >> +       int ret = 0;
> >> +
> >> +       void __iomem *dma_buf = rt->dma_area + pos +
> >> +                               channel * (rt->dma_bytes / rt->channels);
> >> +
> >> +       if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> >> +               if (is_cdc_dma_port(dai_id))
> >> +                       ret = copy_from_user_toio(dma_buf, buf, bytes);
> >> +               else
> >> +                       ret = copy_from_user((void __force *)dma_buf, buf, bytes);
> >> +       } else if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
> >> +               if (is_cdc_dma_port(dai_id))
> >> +                       ret = copy_to_user_fromio(buf, dma_buf, bytes);
> >> +               else
> >> +                       ret = copy_to_user(buf, (void __force *)dma_buf, bytes);
> > Having __force in here highlights the lack of DMA API usage. I guess
> > there's a sound dma wrapper library in sound/core/memalloc.c? Why can't
> > that be used?
> Didn't see any memcopy wrapper functions in memalloc.c. Could You please
> elaborate or share some example.

Can you add some memcpy wrappers to memalloc.c? Or implement the copy
wrapper you need?

> >
> >> +       }
> >> +
> >> +       return ret;
> >> +}
> >>
> >>   static const struct snd_soc_component_driver lpass_component_driver = {
> >>          .name           = DRV_NAME,
> >> @@ -837,9 +1242,11 @@ static const struct snd_soc_component_driver lpass_component_driver = {
> >>          .prepare        = lpass_platform_pcmops_prepare,
> >>          .trigger        = lpass_platform_pcmops_trigger,
> >>          .pointer        = lpass_platform_pcmops_pointer,
> >> +       .mmap           = lpass_platform_pcmops_mmap,
> >>          .pcm_construct  = lpass_platform_pcm_new,
> >>          .suspend                = lpass_platform_pcmops_suspend,
> >>          .resume                 = lpass_platform_pcmops_resume,
> >> +       .copy_user              = lpass_platform_copy,
> >>
> >>   };
> >>
> >> @@ -877,6 +1284,60 @@ int asoc_qcom_lpass_platform_register(struct platform_device *pdev)
> >>                  return ret;
> >>          }
> >>
> >> +       if (drvdata->codec_dma_enable) {
> >> +               ret = regmap_write(drvdata->rxtx_lpaif_map,
> >> +                       LPAIF_RXTX_IRQEN_REG(v, LPAIF_IRQ_PORT_HOST), 0x0);
> >> +               if (ret) {
> >> +                       dev_err(&pdev->dev, "error writing to rxtx irqen reg: %d\n", ret);
> >> +                       return ret;
> >> +               }
> >> +               ret = regmap_write(drvdata->va_lpaif_map,
> >> +                       LPAIF_VA_IRQEN_REG(v, LPAIF_IRQ_PORT_HOST), 0x0);
> >> +               if (ret) {
> >> +                       dev_err(&pdev->dev, "error writing to rxtx irqen reg: %d\n", ret);
> >> +                       return ret;
> >> +               }
> >> +               drvdata->rxtxif_irq = platform_get_irq_byname(pdev, "lpass-irq-rxtxif");
> >> +               if (drvdata->rxtxif_irq < 0)
> >> +                       return -ENODEV;
> >> +
> >> +               ret = devm_request_irq(&pdev->dev, drvdata->rxtxif_irq,
> >> +                               lpass_platform_rxtxif_irq, IRQF_TRIGGER_RISING,
> > Drop flags and get it from firmware please.
> Same is followed in existing for other i2s and HDMI interrupts. Could
> You please give some example if it's really matters?

It matters in the case that the hardware team decides to change the pin
to falling. DT already has the flags encoded, so having a zero here
avoids conflicting with what DT has set and also alleviates us from
having to set different flags on different devices. Everyone wins. Look
around for drivers that pass 0 in place of IRQF_TRIGGER_RISING, there
are many examples.
