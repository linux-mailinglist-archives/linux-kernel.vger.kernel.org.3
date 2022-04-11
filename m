Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145594FBC73
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 14:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346211AbiDKMxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 08:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346241AbiDKMw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 08:52:58 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D4539148;
        Mon, 11 Apr 2022 05:50:42 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id i7-20020a1c3b07000000b0038eb92fa965so465752wma.4;
        Mon, 11 Apr 2022 05:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zTnB8WVccOxUVDlUw5vkzXtIzU9nDF4JTc2pabtWMf0=;
        b=Ow6nqERzOTHAiBNIYzqMqGmV0QACJectDUyZxykLB3WPWHQoqVu6oMf5dgYlB5yM99
         QzHVab1Xzpcgo+vpJ/ExZwp9EAoBasEx6FislnCKkPyKhUegue1meYWecROWs6Z/bpnj
         BQS1l5zBed6u8ACRiXHZDJU4VjmDS8QhrGhQb3Y6Ak75hbju+TBH2SGV0wyzLs8UnX8Q
         nvN88Oi8op54vV8T2sg2Xxhi8EhqMVPOrlZYUTf7URMv8fPnSIfvQ/NLHKnns48PET61
         P/af+TAI388jzBXqkoSfSqObwIDpTQPDAE55IriOTkH2K4/LsUkcwc/J+s0W9te46M+K
         DpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zTnB8WVccOxUVDlUw5vkzXtIzU9nDF4JTc2pabtWMf0=;
        b=ATyUHtAVsIwLDkI8AONMDhNyI5hLerfrVmytr0EDyvFlWpjbX3ecX66cRfJFxC+Aso
         DyFpDhr+WEzyEjCgVLY95bOrqqrBEW4+egJRorCGUT6FwzaFtXnhvS0UAg1XWIYCyZL9
         khzt0WgEn5Lzgthl0IpDHzw5db6C0m54VPOBOhbIXnrSNKxaJllm8ysl0FuI2/g63CdT
         om5ztM3ytCCKhm7UqncyosLrWQcfzd5pClJAetcW1+sqol2FrNbh3IQbA73Bi8dU7t/h
         dC5jvv0m3h6oKppB4lH4kBj5qUyY+1ml/O7C+M5ViyMW3515N2obyzXdRSkFQhAeAvK/
         eZ0w==
X-Gm-Message-State: AOAM530pHxkHGV3rxub4oCl3CzNi3ejsTWXYIKWJV6VqPpdMXcaW70CW
        NbDdVmcXEFHus3fsP2RKaYk19Hay3XGmTWePlG6QC5puK/FjUw==
X-Google-Smtp-Source: ABdhPJwG4G3zEORHuTwL3nQcZeDB02FKrleXGHEgcEVZHpzO0DXU0ndza+T2nBeRLrzTHz6yF3gZZRLz/Ei3XHs/mkU=
X-Received: by 2002:a05:600c:6020:b0:38e:c006:f55f with SMTP id
 az32-20020a05600c602000b0038ec006f55fmr1858651wmb.123.1649681440479; Mon, 11
 Apr 2022 05:50:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220407082148.571442-1-gengcixi@gmail.com> <20220407082148.571442-3-gengcixi@gmail.com>
 <20220410171020.4fb2a894@jic23-huawei>
In-Reply-To: <20220410171020.4fb2a894@jic23-huawei>
From:   Cixi Geng <gengcixi@gmail.com>
Date:   Mon, 11 Apr 2022 20:50:04 +0800
Message-ID: <CAF12kFsvmaAbpVQSRLcCk8wVzvEVX3bovTGCnnMjMm6nT_O53Q@mail.gmail.com>
Subject: Re: [PATCH V3 2/7] iio: adc: sc27xx: fix read big scale voltage not right
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        "baolin.wang7@gmail.com" <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        =?UTF-8?B?5pyx546J5piOIChZdW1pbmcgWmh1LzExNDU3KQ==?= 
        <yuming.zhu1@unisoc.com>, linux-iio@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Cameron <jic23@kernel.org> =E4=BA=8E2022=E5=B9=B44=E6=9C=8811=E6=
=97=A5=E5=91=A8=E4=B8=80 00:02=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu,  7 Apr 2022 16:21:43 +0800
> Cixi Geng <gengcixi@gmail.com> wrote:
>
> > From: Cixi Geng <cixi.geng1@unisoc.com>
> >
> > Fix wrong configuration value of SC27XX_ADC_SCALE_MASK and
> > SC27XX_ADC_SCALE_SHIFT by spec documetation.
> >
> > Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> > Reviewed-by: Baolin Wang <baolin.wang7@gmail.com>
> Fixes tag?
Fixes: 5df362a6cf49c (iio: adc: Add Spreadtrum SC27XX PMICs ADC support)
> No need to resend for this though, just reply with the appropriate
> tag so when I use b4 it'll be picked up.
>
> Thanks,
>
> Jonathan
>
> > ---
> >  drivers/iio/adc/sc27xx_adc.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.=
c
> > index 00098caf6d9e..aee076c8e2b1 100644
> > --- a/drivers/iio/adc/sc27xx_adc.c
> > +++ b/drivers/iio/adc/sc27xx_adc.c
> > @@ -36,8 +36,8 @@
> >
> >  /* Bits and mask definition for SC27XX_ADC_CH_CFG register */
> >  #define SC27XX_ADC_CHN_ID_MASK               GENMASK(4, 0)
> > -#define SC27XX_ADC_SCALE_MASK                GENMASK(10, 8)
> > -#define SC27XX_ADC_SCALE_SHIFT               8
> > +#define SC27XX_ADC_SCALE_MASK                GENMASK(10, 9)
> > +#define SC27XX_ADC_SCALE_SHIFT               9
> >
> >  /* Bits definitions for SC27XX_ADC_INT_EN registers */
> >  #define SC27XX_ADC_IRQ_EN            BIT(0)
>
