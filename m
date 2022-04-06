Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B624F6AC3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 22:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbiDFUE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 16:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235185AbiDFUDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 16:03:45 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27337E5A3
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 10:21:02 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-e1dcc0a327so3670868fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 10:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=RUU1F0wpujC7WhqVwBC+2pTO1HYEQ6X5S3p8UJ+PTMc=;
        b=iE0ztCXOiYH9yto1ZKUgnifI908erHLqfQyguoCUhqSjQjwBN3nHvyPzvdgfKblAaC
         txVXePDctGgXJNraMQvZ1ugNcw3UiGH/2MPqUDn0HFb+eDuEfcQNXfzBHDL837S8x2df
         tSfN2hzVdetG7C75UtpGguKAqnkdia10CyhDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=RUU1F0wpujC7WhqVwBC+2pTO1HYEQ6X5S3p8UJ+PTMc=;
        b=sfVXgv8YGujp0b3LU05uz0gc2ePkouRCHA7akILfhc818bfe6uyqPSRUUCgVm5oQER
         olmcN9CyIHIrQGi1HVOw9sy0n3KBXdNWP8aOkHFDVi4h+UF82kUg4Zhv3LXOGpBnEe2U
         XWlIhd1YdTwMUYWOMpqEF1WWTcT4Ky0KQ2JPvXYxSpGQQRnmnkCAU5og/guYMw43yhGF
         JMPH8/l/psMMieuSIZUYUpigXlFDPjzarNy9idqPwGBMuiEEAJzoJVKlm6o1FmO3w/1U
         5jGrrkROmBYmumEOqPcI/JO0eJD7TnjvrIFH4ko9Q0H9DOfWAKpD9RZRXsr1Qga/zGhX
         RiMw==
X-Gm-Message-State: AOAM533yJ80LZ1b5nRelgZhpVwVx/FNc8tU4T8Z/JBoLaN9Yh/Dr0K3y
        53hPdjSB5X4oKwoCZVJYn08wXvCjF0PWjdNWEsB3Mg==
X-Google-Smtp-Source: ABdhPJyZQyu/K5x1uJUUL3GjBmaiHMZMMBfeE1A4A4cNNBRKCil6XVdMRFMtXJn+fZcA2z3NkLK8jXc2zoN5xcSGrbU=
X-Received: by 2002:a05:6870:e314:b0:e1:e5f0:d777 with SMTP id
 z20-20020a056870e31400b000e1e5f0d777mr4254311oad.193.1649265661935; Wed, 06
 Apr 2022 10:21:01 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 6 Apr 2022 10:21:01 -0700
MIME-Version: 1.0
In-Reply-To: <Yk3Bfnxe/meBYokp@sirena.org.uk>
References: <1649166633-25872-1-git-send-email-quic_c_skakit@quicinc.com>
 <1649166633-25872-5-git-send-email-quic_c_skakit@quicinc.com>
 <CAE-0n53G-atsuwqcgNvi3nvWyiO3P=pSj5zDUMYj0ELVYJE54Q@mail.gmail.com>
 <Yk1B4f51WMGIV9WB@sirena.org.uk> <CAE-0n53Cv_bR92M64dhdnDge_=_jeOs4VZzDhUkksN90Y7rgog@mail.gmail.com>
 <Yk21pdu16lyR8jXm@sirena.org.uk> <CAE-0n50C8khP2x4sgNP5xnfLVMRQj2=LChyWWx1BWL+Xgecgyw@mail.gmail.com>
 <Yk3Bfnxe/meBYokp@sirena.org.uk>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 6 Apr 2022 10:21:01 -0700
Message-ID: <CAE-0n53O23=N0zkZpg87Q3EyKquLe3WLNJT8qnZz4WEor6QK7A@mail.gmail.com>
Subject: Re: [PATCH V9 4/6] regulator: Add a regulator driver for the PM8008 PMIC
To:     Mark Brown <broonie@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_collinsd@quicinc.com,
        quic_subbaram@quicinc.com, quic_jprakash@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mark Brown (2022-04-06 09:36:14)
> On Wed, Apr 06, 2022 at 08:51:48AM -0700, Stephen Boyd wrote:
> > Quoting Mark Brown (2022-04-06 08:45:41)
>
> > > There's a MFD parent for it, and if it's for an I2C device for a pm8008
> > > why would it have a -regulators in the name?
>
> > There are two i2c devices. One is pm8008 at i2c address 0x8 and one is
> > pm8008-regulators at i2c address 0x9. Earlier revisions of this patch
> > series were making it very confusing by redoing the pm8008 binding and
> > adding the pm8008-regulator i2c address device to the same binding and
> > driver.
>
> > My guess is that this is one IC that responds to multiple i2c addresses.
> > The "main" qcom,pm8008 address is 0x8 and that supports things like
> > interrupts. Then there's an address for regulators at 0x9 which controls
> > the handful of LDOs on the PMIC.
>
> So it's like the TI TWL4030 and Palmas - in which case it should
> probably be handled similarly?

How did those work out? I wasn't involved and I don't know what you
mean. Do they have multiple i2c addresses they respond to?

> Note that the original sumbission was
> *also* a MFD subfunction, but using a DT compatible to match the
> platform device - this is the first I've heard of this being a separate
> I2C function.

I'm mainly looking at the dts file now. It clearly has two i2c devices
at 0x8 and 0x9. Maybe the regulator driver followed the mfd design
because the first driver for this device is an mfd.
