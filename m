Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98FA4E5F93
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 08:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348694AbiCXHjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243967AbiCXHjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:39:05 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFD91B6;
        Thu, 24 Mar 2022 00:37:34 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id u16so5335582wru.4;
        Thu, 24 Mar 2022 00:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jCVPCJICg9locbJaOYqFD84RnZE57Jl55NgEDRe/OGY=;
        b=d9Y0con6YPsB1dIpXULd3jLFTkTuABc3w+m5HpRequP2RVLsLaatWJNJy/Yi0c3T5G
         zK81X44glWZZK5LfJeM/uk0KMlm0ArwzsRQbra7NAQznRzl314WDjeLfm1ZOFe4rijKI
         NPk2naPOGgXQB2X5x5rJ5xVXIudqezVgttJ9k7EIuWut5QKMVdSPw6q+e2iCxuIyml8g
         SwlW47PZ0w0QWPFKhRqEAvffcCu9Z4FsBYQ8IVg5hzW3Sd0uBINvi6hUiyJeNw4OayZT
         qYGAJPvh6ppROpdvG7aDD24HqkZLipzCHjDtmTOPnLU6KcERri5B37JGYK8tXJ1pxrys
         mpQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jCVPCJICg9locbJaOYqFD84RnZE57Jl55NgEDRe/OGY=;
        b=hV64kb/HVK9QtPl8c1QhYpJJQ04hlm9zkjLbSiF797Vm08SzQSvFD9DTjwTI9Z2tEG
         aRzRrPElxHNkZf2wGXVV+ZC71j3v3LMAGFoYQKBeN+g4t+a6Lu6PbCKtHr08jCTTTPd/
         o8y/4ISQugw+AFPh5+2uNiLpHh7ez2m7LtjV6CNL8QOv3jeaeRpyPy3s0BWFCeOWVhzf
         VwPH1QJsFeOoUJ0ieTe0V+cM0RBmITS0sPCiSSLuo9e9NTk3tkS2ByNLXfjv6OKUpspV
         Sr77gS61D0s4hFFnXj74BIKKTkQY2wdwloojSaV4+HCEMckNTMPQumd0jVl8filhz5DX
         0gAg==
X-Gm-Message-State: AOAM532tr4Hlkqwt5+DvLbH1xfaH1nxxOWD8fJ9tI9QL+ey3bvQil0/k
        UJKAYPPbJqva87VwT07kfHi+u7s38FODyexu2IR9Hyq8GyL8lA==
X-Google-Smtp-Source: ABdhPJxkSQmpeySAOI/QQ+/6O0r1eQ5Hm0qLSdNlE+wBlAjrwKZyC6XiR6wyrH3C+PE3XyWlNVKfRIMqBR0qMtpACmE=
X-Received: by 2002:a5d:414b:0:b0:205:89b7:91bf with SMTP id
 c11-20020a5d414b000000b0020589b791bfmr3348040wrq.217.1648107452650; Thu, 24
 Mar 2022 00:37:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220311164628.378849-1-gengcixi@gmail.com> <20220311164628.378849-3-gengcixi@gmail.com>
 <20220320133229.6026f51a@jic23-huawei>
In-Reply-To: <20220320133229.6026f51a@jic23-huawei>
From:   Cixi Geng <gengcixi@gmail.com>
Date:   Thu, 24 Mar 2022 15:36:56 +0800
Message-ID: <CAF12kFvPp4eVJtWD7zd=Kvx2mHQGWiy_dDOD1bvMLQgeNgBvzQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/7] iio: adc: sc27xx: fix read big scale voltage not right
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        "baolin.wang7@gmail.com" <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, lgirdwood@gmail.com,
        Mark Brown <broonie@kernel.org>,
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

Jonathan Cameron <jic23@kernel.org> =E4=BA=8E2022=E5=B9=B43=E6=9C=8820=E6=
=97=A5=E5=91=A8=E6=97=A5 21:25=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, 12 Mar 2022 00:46:23 +0800
> Cixi Geng <gengcixi@gmail.com> wrote:
>
> > From: Cixi Geng <cixi.geng1@unisoc.com>
> >
> > Fix wrong configuration value of SC27XX_ADC_SCALE_MASK and
> > SC27XX_ADC_SCALE_SHIFT by spec documetation.
> >
> > Signed-off-by: Yuming Zhu <yuming.zhu1@unisoc.com>
> > Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> >
> No blank lines in a tag block (they break people's scripts)
> Also, if this is a fix, I'd expect a fixes tag.
I will add in next version
>
> > Reviewed-by: Baolin Wang <baolin.wang7@gmail.com>
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
>
> This driver would benefit from use of FIELD_GET() / FIELD_PREP()
> but that is obviously unrelated to this particular series.
>
the next patch in this set need to use the fixed define value
>
> Jonathan
>
> >
> >  /* Bits definitions for SC27XX_ADC_INT_EN registers */
> >  #define SC27XX_ADC_IRQ_EN            BIT(0)
>
