Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2369B487335
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 07:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbiAGGyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 01:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiAGGyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 01:54:35 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4B4C061245;
        Thu,  6 Jan 2022 22:54:35 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id i130so5131042qke.3;
        Thu, 06 Jan 2022 22:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yrBuwkc3UJOnaZsE53cuiLxqo4psd26IwGHgNiN3kEc=;
        b=oO0AEOwE3Q7d2KwP8pT6tM13zhkurR+sV/NFZx6avdPHtf6QxvpHVspg6DHV1hX58K
         2P9vrplcGu9Bpu1qSrR76Z5PC6CZ2cS1N9PU1U/7YS71mZaQYYTwV5EpGD4tjkW4g1OW
         EiBw6vzdEjxKaO4cEjkvMnjQPpOP0CX6d871mm79vC+GYbku1rom0QwJduQigL6vEpxB
         hpkDnfGx2owN8IopC3GYOL/rVlX9YhegVWuxjrNYLGwAsHvAcKkx4ef+w1FqWbcHg6MF
         YsMNAzXNy7G0rCDnZwSnid90sS8ijvSHfcUg/jgqzS8G1iHLViPpTqgNGmDgYzx8sNR+
         01nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yrBuwkc3UJOnaZsE53cuiLxqo4psd26IwGHgNiN3kEc=;
        b=N6h26S+SIGrCKOYcgLT0hpmdDoBYAEuPQenf7hyk1bCJqr+7p997uNQCbfKFBsY/11
         OflYToPdYKhZrmUAydimGj1gFB1ejBfUopRa9SGEupvUqcBMvU7AkE8UDr82yGIaaNMp
         OGf9fagTxTeayLivK5arq+EgLF+73+/Sbmgqhpb2ZyFydr/zIBudTEWEHM+p3xx157u6
         bFkxk1EpASEy2s4sBeEgzZ9lb3vihfrDaQ80AnPQNWlt5Yj3vww4Hw1Ff87b3VCXNcKR
         PQ7ycbKPWt/1qo1EODmtnpMPRW2HrS0gZV8BXy19FLdsIjPfNgix3Pkb00S3F9uAYs4S
         f7fg==
X-Gm-Message-State: AOAM530uWRbG7kMMCTDpXknE2dYYnp2WtG8413384VJCKuunnF87vjfY
        sqjd+4eMczssNqgbzKq1525qDUSnMQ6w4bZOghA=
X-Google-Smtp-Source: ABdhPJw7h1jUJmt3VmLh8gqvFvgATYpYUaQ7BqtBAAc3WuI6UPuOgXOcgJAA3HbY/m1IBHZO68AJzuKOkskPMly0/t0=
X-Received: by 2002:a37:983:: with SMTP id 125mr42361380qkj.63.1641538474279;
 Thu, 06 Jan 2022 22:54:34 -0800 (PST)
MIME-Version: 1.0
References: <20220106125947.139523-1-gengcixi@gmail.com> <20220106125947.139523-3-gengcixi@gmail.com>
In-Reply-To: <20220106125947.139523-3-gengcixi@gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Fri, 7 Jan 2022 14:55:15 +0800
Message-ID: <CADBw62pCDOu41G6t42dupuYF8F0mdhidNYg9=G7D+ns3AkyE_w@mail.gmail.com>
Subject: Re: [PATCH 2/7] iio: adc: sc27xx: fix read big scale voltage not right
To:     Cixi Geng <gengcixi@gmail.com>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, jic23@kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>, lgirdwood@gmail.com,
        Mark Brown <broonie@kernel.org>, yuming.zhu1@unisoc.com,
        linux-iio@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 6, 2022 at 9:00 PM Cixi Geng <gengcixi@gmail.com> wrote:
>
> From: Cixi Geng <cixi.geng1@unisoc.com>
>
> Fix wrong configuration value of SC27XX_ADC_SCALE_MASK and
> SC27XX_ADC_SCALE_SHIFT by spec documetation.
>
> Signed-off-by: Yuming Zhu <yuming.zhu1@unisoc.com>
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>

Reviewed-by: Baolin Wang <baolin.wang7@gmail.com>

> ---
>  drivers/iio/adc/sc27xx_adc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
> index 00098caf6d9e..aee076c8e2b1 100644
> --- a/drivers/iio/adc/sc27xx_adc.c
> +++ b/drivers/iio/adc/sc27xx_adc.c
> @@ -36,8 +36,8 @@
>
>  /* Bits and mask definition for SC27XX_ADC_CH_CFG register */
>  #define SC27XX_ADC_CHN_ID_MASK         GENMASK(4, 0)
> -#define SC27XX_ADC_SCALE_MASK          GENMASK(10, 8)
> -#define SC27XX_ADC_SCALE_SHIFT         8
> +#define SC27XX_ADC_SCALE_MASK          GENMASK(10, 9)
> +#define SC27XX_ADC_SCALE_SHIFT         9
>
>  /* Bits definitions for SC27XX_ADC_INT_EN registers */
>  #define SC27XX_ADC_IRQ_EN              BIT(0)
> --
> 2.25.1
>


-- 
Baolin Wang
