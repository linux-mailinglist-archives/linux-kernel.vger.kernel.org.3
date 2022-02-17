Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8EE14BAA00
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 20:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244295AbiBQTla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 14:41:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239204AbiBQTl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 14:41:26 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB0A11109A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 11:41:10 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id o128-20020a4a4486000000b003181707ed40so812228ooa.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 11:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=3wvP+CouT5s7ckbu1I32aqEIyb+Q3SaOSxhlymVyShY=;
        b=JYLlipsvhfV7sqXYVa9saWxp8b9zR4ENVos6xsFloI664t0SttD4jiRU6dK7Qx9iEt
         S61i1/8tNV3jUM9VR3ZG7wp64r5V9E5vQnsZaBANQYM82bvxAaQ8ox9L1jtOsfI5rKNU
         GTeaDejUOd6Xe6Z2bxX5z5J05qs9XflVLniFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=3wvP+CouT5s7ckbu1I32aqEIyb+Q3SaOSxhlymVyShY=;
        b=fwr5lQ5odhQvcAuj/XtN5TwaXgIPxYw3fjPHyH6IPdcs2knlF3zo2Psj4Fh8CXZLUd
         hmE/1UwLv2B8ZWtHOM1G0LPs5jXw8W98iBswgzszWmiJI5hY5QhZW1X6/8OMwC2nz2SE
         vDuQuWGNxZn7pnnOl8MJQap2RO3iUtPFFkgL8qfqCgomaD+u1G5WsVAeG81pK4CYVWpN
         dLzJ52fQMkjH8tBns/8MsMjm0UkrXs/w7Qni9Vqh15FRE1H9T5QunZpr14HU/MAx/KOr
         UTTwq69s/fpVbiIV/DypLPaqZq6wQ1UECrPwexywjj8rgQyLE8+OshoLe/Ra9mw5SaGf
         MURg==
X-Gm-Message-State: AOAM530wbRtZ7VJeAwfe1nrq8c7LW6IoNDHRav00P7OJaLFKWapZ9RST
        l8CCxrm7Ak07jkOZANTOlI/VQ4BZ5EehA3cOG/pKMA==
X-Google-Smtp-Source: ABdhPJzxaar8ksZKNkxlbNXjnGcgtRXh0N8gzo3lIPEiGAozeBu5nup8a4c7u8qz9MRLb9V5pCHw9rvSl1uX+9jgK+s=
X-Received: by 2002:a4a:d58b:0:b0:319:8746:ac3e with SMTP id
 z11-20020a4ad58b000000b003198746ac3emr1291325oos.1.1645126868547; Thu, 17 Feb
 2022 11:41:08 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Feb 2022 11:41:08 -0800
MIME-Version: 1.0
In-Reply-To: <13007276-c827-0cc4-5db1-396c5184bb35@quicinc.com>
References: <1644850708-11099-1-git-send-email-quic_srivasam@quicinc.com>
 <1644850708-11099-5-git-send-email-quic_srivasam@quicinc.com>
 <CAE-0n504R0avU9Ybj68jxqDRH-Ya5ro0hPo5GJ=2zC6p2SZ_=g@mail.gmail.com> <13007276-c827-0cc4-5db1-396c5184bb35@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 17 Feb 2022 11:41:08 -0800
Message-ID: <CAE-0n538Lhp7U=pEB_7R5EARG6LveeO=jvF+kE7HCCEXUEm-kQ@mail.gmail.com>
Subject: Re: [RESEND v13 04/10] ASoC: qcom: Add helper function to get dma
 control and lpaif handle
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

Quoting Srinivasa Rao Mandadapu (2022-02-15 21:11:29)
>
> On 2/15/2022 6:40 AM, Stephen Boyd wrote:
> Thanks for your time Stephen!!!
> > Quoting Srinivasa Rao Mandadapu (2022-02-14 06:58:22)
> >> Add support function to get dma control and lpaif handle to avoid
> >> repeated code in platform driver
> >>
> >> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> >> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> >> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> >> Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> >> ---
> >>   sound/soc/qcom/lpass-platform.c | 113 +++++++++++++++++++++++-----------------
> >>   1 file changed, 66 insertions(+), 47 deletions(-)
> >>
> >> diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
> >> index a44162c..5d77240 100644
> >> --- a/sound/soc/qcom/lpass-platform.c
> >> +++ b/sound/soc/qcom/lpass-platform.c
> >> @@ -177,6 +177,49 @@ static int lpass_platform_pcmops_close(struct snd_soc_component *component,
> >>          return 0;
> >>   }
> >>
> >> +static void __lpass_get_lpaif_handle(struct snd_pcm_substream *substream,
> > const?
> Okay. will add const to substream pointer.
> >
> >> +                                    struct snd_soc_component *component,
> > const?
> Here const is giving compilation errors in below code.

Ok

> >
> >> +                       l_id = pcm_data->dma_ch;
> >> +                       l_dmactl = drvdata->rd_dmactl;
> >> +               } else {
> >> +                       l_dmactl = drvdata->wr_dmactl;
> >> +                       l_id = pcm_data->dma_ch - v->wrdma_channel_start;
> >> +               }
> >> +               l_map = drvdata->lpaif_map;
> >> +               break;
> >> +       case LPASS_DP_RX:
> >> +               l_id = pcm_data->dma_ch;
> >> +               l_dmactl = drvdata->hdmi_rd_dmactl;
> >> +               l_map = drvdata->hdmiif_map;
> >> +               break;
> >> +       default:
> >> +               break;
> >> +       }
> >> +       if (dmactl)
> >> +               *dmactl = l_dmactl;
> >> +       if (id)
> >> +               *id = l_id;
> >> +       if (map)
> >> +               *map = l_map;
> > Why not 'return 0' here and return -EINVAL in the default case above? Then
> > we can skip the checks for !map or !dmactl below and simply bail out if
> > it failed with an error value.
>
> Here the check is for input params. some users call for only damctl or
> only map.

Yes the check is to make sure there's a pointer to store the value into.
I get that. The users are all internal to this driver though because
the function is static. If the function returned an error because it
couldn't find something then we wouldn't have to test the resulting
pointers for success, instead we could check for a return value.
Similarly, it may be clearer to have a single get for each item and then
return a pointer from the function vs. passing it in to extract
something. It may duplicate some code but otherwise the code would be
clearer because we're getting one thing and can pass an error value
through the pointer with PTR_ERR().
