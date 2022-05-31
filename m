Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE8B5398F7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 23:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348093AbiEaVsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 17:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbiEaVsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 17:48:15 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C859C8D69D;
        Tue, 31 May 2022 14:48:13 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id c19so23574285lfv.5;
        Tue, 31 May 2022 14:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ybk7O8dN6b6H5xbFDEoMCkqNz4qnfNPoCfwRQJbaMWE=;
        b=Cgm6GprlcUCBuJ8R9gwHR/U6yIcGBQ1j0i9r/Y19cnMF6yfiex3zX156nHpM6PWbxZ
         /pasrG3B9WLzDjRSg3Q7QpcnySf+6cBKafEA49vxuVLkZJpRnM/3XXQsyl+P3iqrP2SR
         3M4Fa5Ey7i3i7bXM3pUJK/vKrvfXa+8U6Fhk1pVwZ9ygtYHkhjQV7qO0x04j9NMsccis
         BTO4q01NB5fIL72dqBfydVgJ4d4gy5OrvsNgU7BYnblwB5wtD/MT2SyK/pBC3OJimTUd
         8CrIKuGDEm/Ym6h5DCWj3n6hUn2ZSFdWWcm+1kdPlaOkhFqnPAyocNLGNNGYdKNwWKaC
         lXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ybk7O8dN6b6H5xbFDEoMCkqNz4qnfNPoCfwRQJbaMWE=;
        b=YMTrGBWDQhefbnRIDiQLHEgOaPILwDU5xwi54alpQ3YVhk5j6+JwCTP9N81zXy2trB
         WiVklSql+f0P0XwdjYfTeYKG1z2h7f+ihH6690IRkBvn+uIH7wr2S/Mk6+d98cbe+SBh
         4hkAHDYHg4vEsiX+bSfFbW7OTavwe7A+cEXNhSS9+r/rtVR5zrWYF/v4rNKeP6GMBBWf
         xyogARAYCcOvzhnRj0LI6uSAoGmIWgTx+JcuVDtgWHdxDrMwm1V9LGjf5+zWjD91CoB0
         dmLn530h1/Xs9+oaGXbk7xBP1eSyhUHPinPG4hT7zQkyCn6Bi6NLLsJbg2tuydTx0EI5
         /D8Q==
X-Gm-Message-State: AOAM5322xdcHzCTkgrHPXoI23brmH/W2sbfiW9imnDffUCRXKtNQuksC
        jRi5dUAQuRTxlZNjSeaOxZP5SfttaA0/QcWFnZFZ1hYVNHQ=
X-Google-Smtp-Source: ABdhPJx+qwKcx7leYf5D73FowWhfAJA6/AHPi6i6vR9MWlyar+cEFQ36m84oTWlNMVbd2BNnkrqW7jTW3lQggmxgPas=
X-Received: by 2002:a17:907:381:b0:6fe:9ca8:c4b4 with SMTP id
 ss1-20020a170907038100b006fe9ca8c4b4mr52900857ejb.147.1654033681191; Tue, 31
 May 2022 14:48:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220531211842.71998-1-andriy.shevchenko@linux.intel.com> <20220531211842.71998-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220531211842.71998-3-andriy.shevchenko@linux.intel.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 31 May 2022 23:47:50 +0200
Message-ID: <CAFBinCDf4UfEPFV4_Qf3m16DE-NzNUk_ZVcHZhgxVvn_pokdgw@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] iio: adc: meson_saradc: Use temporary variable for
 struct device
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Tue, May 31, 2022 at 11:18 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
[...]
> @@ -650,11 +648,12 @@ static int meson_sar_adc_clk_init(struct iio_dev *indio_dev,
>                                   void __iomem *base)
>  {
>         struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
> +       struct device *idev = &indio_dev->dev;
> +       struct device *dev = dev->parent;
It looks like this should read:
    struct device *dev = idev->parent;

That said, I think this kind of typo is very easy with the current
naming schema.
It's been a while since I looked at other drivers but maybe the IIO
maintainers have some recommendations for us (which would apply to
multiple IIO drivers, not just meson_saradc).
For example: I am not sure if iio_{err,warn} functions (which take a
struct iio_dev pointer) have been proposed/discussed before. I think
they could be useful for other drivers as well.


Best regards,
Martin
