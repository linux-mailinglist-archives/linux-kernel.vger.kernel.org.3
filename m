Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A181259AD19
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 12:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344974AbiHTKGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 06:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244208AbiHTKGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 06:06:42 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A0461D8C;
        Sat, 20 Aug 2022 03:06:41 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id x5so4909100qtv.9;
        Sat, 20 Aug 2022 03:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=jyXGlQzM69be3uApeeeOgOOHTnpCx2Xve0ckZD0KFa0=;
        b=jwI7T7MBvCdhJKiGb+WMZJhkvk3YDXSsC6SrOJRChMmpl/ANOLHOqutfZVqOLb1oMn
         OJ0J0jkKTwrnzUiMwSoyT7JFa16Vx4KNAVGNCzMWw6fyQg+z5ps3U+ZNZ3+V8oV8BiHl
         sXIqhcNqIedSoOoDFtWGmtXQRdPk6K7R5D7YoV3ZiQO/uPOzlJTXXZ/OlbErPruHtbG4
         YDjzjH2yTMlvYl8cce6Y38njLsZGJ6J1Ey4XsfBuGvqBg7RS5svuyTVp8zm1adT0x/sF
         dS28mYlF58dvBgz5MGy+hgAf0KMREo7p8f24nWbkaDQl3DRQlOcaQ5wUNu2WTK5cAJoc
         +O/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=jyXGlQzM69be3uApeeeOgOOHTnpCx2Xve0ckZD0KFa0=;
        b=IKD3H7LIehIJ3asF03wNXk7ZoAX6CWNc3kVkua8QZVB5ngeAuD59gXIKjhiwFIJnfA
         kof0ZQ6a+MVOojqrAuHgyh150CILefRGHRPmXIPiTRpQ4cFlx3iW/u3Qcg4BQmRG21+f
         w39uWRIYFiH6/vXLyTRbDbvjjxQHLL6ggo9P9Hf02bPXBqioyiXBkfKDePtzq+81JkZK
         Cu7K9Z7pz33yp8t8mrYCxdZHUCmuB1RLkFB7f5moQm9VgnLqFhO3htuoRDjLA2gUei3c
         2e/aIrIfY8uoEbijEPTVdgZsOE7Lel1Qsi7QJJgA8yyGVvpkpTxLRLLBc0vDurHHOXR+
         dSHw==
X-Gm-Message-State: ACgBeo17ePcF0OctyJLeX++oLcE/EKB+xc4rXqidiX1V0eSgSJo3grk4
        2tdH8wuHAhAaZagHKgLdfvwhlc4Xd2x9M8iAElQ=
X-Google-Smtp-Source: AA6agR7iPdaXhjV41aB1G4OWbORwxriO7v7qcra94eHS6QZ/EIBiOAAABsUbBXPoeJZ1nwUBL28hE8Pol8Hdwvl9HE8=
X-Received: by 2002:a05:622a:1787:b0:344:94c1:fb0e with SMTP id
 s7-20020a05622a178700b0034494c1fb0emr8282105qtk.82.1660990000784; Sat, 20 Aug
 2022 03:06:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220818221815.346233-1-robimarko@gmail.com> <20220818221815.346233-3-robimarko@gmail.com>
 <20220819183052.49cf14e9@jic23-huawei>
In-Reply-To: <20220819183052.49cf14e9@jic23-huawei>
From:   Robert Marko <robimarko@gmail.com>
Date:   Sat, 20 Aug 2022 12:06:30 +0200
Message-ID: <CAOX2RU5w8Z-TT+_UgpxCtqed4HMGrnWQGmK8jqAgadN-9jSbEQ@mail.gmail.com>
Subject: Re: [PATCH v8 3/5] iio: adc: qcom-spmi-adc5: add ADC5_VREF_VADC to
 rev2 ADC5
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lars@metafoo.de,
        sboyd@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
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

On Fri, 19 Aug 2022 at 19:20, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Fri, 19 Aug 2022 00:18:13 +0200
> Robert Marko <robimarko@gmail.com> wrote:
>
> > Add support for ADC5_VREF_VADC channel to rev2 ADC5 channel list.
> > This channel measures the VADC reference LDO output.
> >
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> I've changed my mind on this, mostly because we've reached a new
> cycle and I'd rather not see a v9 series + Lee is (I think)
> keen to only take stuff through MFD if there is a build time
> dependency.
>
> Applied this patch directly to the togreg branch of iio.git
> and pushed that out as testing for 0-day to play with it.

Thanks,
Robert

> > ---
> >  drivers/iio/adc/qcom-spmi-adc5.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
> > index e96da2ef1964..821fee60a765 100644
> > --- a/drivers/iio/adc/qcom-spmi-adc5.c
> > +++ b/drivers/iio/adc/qcom-spmi-adc5.c
> > @@ -597,6 +597,8 @@ static const struct adc5_channels adc5_chans_rev2[ADC5_MAX_CHANNEL] = {
> >                                       SCALE_HW_CALIB_DEFAULT)
> >       [ADC5_1P25VREF]         = ADC5_CHAN_VOLT("vref_1p25", 0,
> >                                       SCALE_HW_CALIB_DEFAULT)
> > +     [ADC5_VREF_VADC]        = ADC5_CHAN_VOLT("vref_vadc", 0,
> > +                                     SCALE_HW_CALIB_DEFAULT)
> >       [ADC5_VPH_PWR]          = ADC5_CHAN_VOLT("vph_pwr", 1,
> >                                       SCALE_HW_CALIB_DEFAULT)
> >       [ADC5_VBAT_SNS]         = ADC5_CHAN_VOLT("vbat_sns", 1,
>
