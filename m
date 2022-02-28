Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C174C7BA2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 22:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiB1VQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 16:16:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiB1VQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 16:16:16 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810CBE019
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 13:15:35 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id 189-20020a4a03c6000000b003179d7b30d8so20290510ooi.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 13:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=IjIt5oAd9CJM5MUxlpFz/Mn3QCxHZ0rV/10NRoEs5gA=;
        b=k5FjNT1Y5NA+RXxHnRvQ0L4bZtfiVOvXd8x+XVq757ySkC4ojwcEUv2bSywlyH1Bs7
         UMP0SExJnFb1TpzHauFo1VmYg0c/UkMxSq3BfChZgmtYQv/vBiUCPdb/IIkxIRkGKz5s
         gnpRz+XBxJA0Pc09geHh4Hsu7EUVa/fEV1vMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=IjIt5oAd9CJM5MUxlpFz/Mn3QCxHZ0rV/10NRoEs5gA=;
        b=WAxHI5AdY2KOJarZwOkrajGgHE4Qp6nInsAuFpf9hi2C2XBqZlOWR1naZlrEc5C/F0
         gmPcr2MThEYo3/nTP+3pkawaf+RucsMQWFqSZJjklgd9lKtyqtYdZkJtmoUxjAM2v/AM
         +MEUg14w98NGNflsKYW+RJNAOEHMHL5nMR8CkXfBVhOQDNtRTupxgFaDDK/e+Aw17M7V
         ZmPv1N1fuICtru1JEH4zsOBfjutPKLeCaPaBfcNzF7m1pQYWdiTm+g9Pxoe+xrpN/91y
         65V8K/XXtBb+vjDriX5Zw+OQMCfuFcg0LY29R9yxa8yy4rBpEcBF099lXdC5gcccmCF5
         N7zQ==
X-Gm-Message-State: AOAM530/7vdxAkHd8CMkDuMTba+IBzTyaRYK6oIw+wQ6JTofZDgXFnVE
        0wyQsN1YBYoSkYJU0ysKPUrG4KdtuXUeEVabiFVJag==
X-Google-Smtp-Source: ABdhPJxOdycyN6mOUporN9zWCpjgv3JJjgWoljVwONiBtWqOqkw5qbUZhVnVbFz3AekiYeyOwAbKHtg7VOElvVbl1OM=
X-Received: by 2002:a05:6870:3c18:b0:d7:22ed:20b0 with SMTP id
 gk24-20020a0568703c1800b000d722ed20b0mr3883479oab.32.1646082934912; Mon, 28
 Feb 2022 13:15:34 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Feb 2022 13:15:34 -0800
MIME-Version: 1.0
In-Reply-To: <6e498021-bf08-3fd8-a3b8-2fcba054f4a0@quicinc.com>
References: <1645716828-15305-1-git-send-email-quic_srivasam@quicinc.com>
 <1645716828-15305-7-git-send-email-quic_srivasam@quicinc.com>
 <CAE-0n53K3Em52tTFK4zmcsf_ZzFbX4uQQ00_uH9=pq44chwyeg@mail.gmail.com> <6e498021-bf08-3fd8-a3b8-2fcba054f4a0@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 28 Feb 2022 13:15:34 -0800
Message-ID: <CAE-0n508Wcb7mnqx1TQN0vndOFRcJuyfvo_4YtJri+Kh-GfSbQ@mail.gmail.com>
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
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivasa Rao Mandadapu (2022-02-25 21:58:03)
>
> On 2/25/2022 5:10 AM, Stephen Boyd wrote:
> Thanks for your time Stephen!!!
> > Quoting Srinivasa Rao Mandadapu (2022-02-24 07:33:45)
> >> diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
> >> index 198f27c..b3af971 100644
[...]
> >> +
> >> +       buf->area = (unsigned char * __force)memremap(buf->addr, buf->bytes, MEMREMAP_WT);
> > What's the cast and __force for now? MEMREMAP_WT is almost never used so
> Here dma_buffer structure has virtual address(buf->area) of unsigned
> char pointer but memremap returns void pointer.
> > this looks wrong. Why can't MEMREMAP_WC be used? But if it's DMA then
> Okay. Will update the flag MEMREMAP_WT
> > why isn't dma_map_resource() being used?
>
> I am sorry bit confused here. You mean some thing like below.
>
> For Physical address mapping: buf->addr = dma_map_resource(pcm->card->dev, drvdata->va_cdc_dma_lpm_buf,
>                              buf->bytes, DMA_BIDIRECTIONAL, 0);

Yes, but I'm not sure about DMA_BIDIRECTIONAL. How does this
va_cdc_dma_lpm_buf work? Does userspace fill it up with bytes and the
DSP reads it out? More details please.

> For virtual address mapping. buf->area = (unsigned char * __force)memremap(buf->addr, buf->bytes, MEMREMAP_WC);

No. I'd expect dma_mmap_attrs() or dma_mmap_coherent() to be used to
mmap it into userspace.  The dma_map_resource() API only returns a
dma_addr_t type, which needs to be mapped via DMA APIs into a virtual
address. Passing it to memremap is incorrect, because it may be possible
to map it into an IOMMU, for which the DMA APIs know what to do in that
situation.
