Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B854D11E7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 09:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344908AbiCHIQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 03:16:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344558AbiCHIQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 03:16:57 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B773EBAF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 00:16:01 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id h15so2784156wrc.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 00:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=NAh/CXeN1EQ9Q7OSXVfdKzT+J7cgU1gZRumRtRt75/Y=;
        b=AXeJdU3qhDIoy3iQ8SiqDmW4Xk+5qx/iLxs0g1Q23iK25ShQNb22ZtIgyi4F5V8u+a
         3H+XqQqXmIJiALcVJk+13Xof1hs0haM3VqWhSEvFD2i/DJdihofzYNcHoSzfnHzgbZf7
         AtSfj6NgQ5V1hkjL62sIWl6KHBsqTiXHNT1/NgX2Wpq7+sWErCPKgS2CzVvMUFHVuTGU
         5RuDHTTF6zB5xIxxG2V+EEGweSrW0Dg5SfKSHlX8uDXbGvnDlY5J+N0bdttHBiUa8LMd
         nsbHDJfgMv/jcjgkGLnP3TI7E+eg2OItF49xaZW/NJjSXUtc8zLgOFfl1orFlPypDOXt
         IwLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NAh/CXeN1EQ9Q7OSXVfdKzT+J7cgU1gZRumRtRt75/Y=;
        b=7okfMr8bbRsbfFTf9CE/GL332440yZb3MWd6YEuL85uljWa01B4dvtKXH72cVsvcW9
         O8O2nILAGDP7ZdKGVnAj3MIaOcExZnZNDhyU7INbJhZRfYBMm40DA49m5uiCaSN1IpB6
         tCcQgzSoF4AcK0HwiiKhLIOyFv6xI3Mui6/fPnFnHcQdU9y7l7fJ69ng+i0h0oxiT0dn
         97Jt2szGRYRkuIZ6f5wqEQEBQy0b6FHfWBqLmB5h+MhfELc+Eu+4U+ODgxtmc9yVLai6
         vkR4/KZEWr8QB9D74JkyeOndc+O0suoGrce7rsihs0R5YQB3meD6W6ghrUDGJBUB5HBH
         XpfQ==
X-Gm-Message-State: AOAM532d0ZOM21p0Y3QbIAhaFUVSKap2So7Yda9PoaqrTqevcTLSsgPT
        SJeXFWtxfaKL6gp8Uu9fycqzkepVZH2Jy2gM
X-Google-Smtp-Source: ABdhPJyjx4vs9TnSKNPFhA+JODx3gduoMjJBtzpW0QATw3zZ42zFBgCG0uuLWCVgXGcNUmBwYQq5gQ==
X-Received: by 2002:adf:dd8e:0:b0:1f0:22f1:aed8 with SMTP id x14-20020adfdd8e000000b001f022f1aed8mr11246429wrl.269.1646727360271;
        Tue, 08 Mar 2022 00:16:00 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id l7-20020adfe9c7000000b001f06f8ec92dsm10697531wrn.30.2022.03.08.00.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 00:15:59 -0800 (PST)
Date:   Tue, 8 Mar 2022 08:15:58 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mfd: arizona-spi: Add Android board ACPI table
 handling
Message-ID: <YicQvl2VKe4pxLuD@google.com>
References: <20220223134222.730886-1-hdegoede@redhat.com>
 <20220223134222.730886-2-hdegoede@redhat.com>
 <YiYb+Ea7aKO99gXL@google.com>
 <ac21f173-2cba-0ddc-67db-27e06950c2d4@redhat.com>
 <YiYicoaSc7KYTbvj@google.com>
 <743f08ed-1a26-8cc0-4f7a-32e41f5040f1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <743f08ed-1a26-8cc0-4f7a-32e41f5040f1@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Mar 2022, Hans de Goede wrote:

> Hi,
> 
> On 3/7/22 16:19, Lee Jones wrote:
> > On Mon, 07 Mar 2022, Hans de Goede wrote:
> > 
> >> Hi,
> >>
> >> On 3/7/22 15:51, Lee Jones wrote:
> >>> On Wed, 23 Feb 2022, Hans de Goede wrote:
> >>>
> >>>> x86/ACPI boards with an arizona WM5102 codec ship with either Windows or
> >>>> Android as factory installed OS.
> >>>>
> >>>> The ACPI fwnode for the codec on Android boards misses 2 things compared
> >>>> to the Windows boards (this is hardcoded in the Android board kernels):
> >>>>
> >>>> 1. There is no CLKE ACPI method to enabe the 32 KHz clock the codec needs
> >>>>    for jack-detection.
> >>>>
> >>>> 2. The GPIOs used by the codec are not listed in the fwnode for the codec.
> >>>>
> >>>> The ACPI tables on x86/ACPI boards shipped with Android being incomplete
> >>>> happens a lot. The special drivers/platform/x86/x86-android-tablets.c
> >>>> module contains DMI based per model handling to compensate for this.
> >>>>
> >>>> This module will enable the 32KHz clock through the pinctrl framework
> >>>> to fix 1. and it will also register a gpio-lookup table for all GPIOs
> >>>> needed by the codec + machine driver, including the GPIOs coming from
> >>>> the codec itself.
> >>>>
> >>>> Add an arizona_spi_acpi_android_probe() function which waits for the
> >>>> x86-android-tablets to have set things up before continue with probing
> >>>> the arizona WM5102 codec.
> >>>>
> >>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >>>> ---
> >>>>  drivers/mfd/arizona-spi.c | 34 +++++++++++++++++++++++++++++++++-
> >>>>  1 file changed, 33 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/mfd/arizona-spi.c b/drivers/mfd/arizona-spi.c
> >>>> index 238355542ab1..2c686e71db21 100644
> >>>> --- a/drivers/mfd/arizona-spi.c
> >>>> +++ b/drivers/mfd/arizona-spi.c
> >>>> @@ -81,6 +81,29 @@ static int arizona_spi_acpi_windows_probe(struct arizona *arizona)
> >>>>  	return 0;
> >>>>  }
> >>>>  
> >>>> +/* For ACPI tables from boards which ship with Android as factory OS */
> >>>> +static int arizona_spi_acpi_android_probe(struct arizona *arizona)
> >>>> +{
> >>>> +	int ret;
> >>>> +
> >>>> +	/*
> >>>> +	 * Get the reset GPIO, treating -ENOENT as -EPROBE_DEFER to wait for
> >>>> +	 * the x86-android-tablets module to register the board specific GPIO
> >>>> +	 * lookup table.
> >>>> +	 */
> >>>> +	arizona->pdata.reset = devm_gpiod_get(arizona->dev, "reset", GPIOD_OUT_LOW);
> >>>> +	if (IS_ERR(arizona->pdata.reset)) {
> >>>> +		ret = PTR_ERR(arizona->pdata.reset);
> >>>> +		if (ret == -ENOENT) {
> >>>> +			dev_info_once(arizona->dev, "Deferring probe till GPIO lookup is registered\n");
> >>>
> >>> Nit: How many chars is this?
> >>
> >> 105.
> >>
> >>> I thought we were drawing the line at 100 these days?
> >>
> >> We have an exception for log lines, since we don't want to break them
> >> up because that makes grepping for them impossible.
> >>
> >>> Does this patch pass checkpatch.pl?
> >>
> >> Yes because of the exception for log lines:
> >>
> >> [hans@x1 linux]$ scripts/checkpatch.pl 0001-mfd-arizona-spi-Add-Android-board-ACPI-table-handlin.patch 
> >> total: 0 errors, 0 warnings, 54 lines checked
> >>
> >> 0001-mfd-arizona-spi-Add-Android-board-ACPI-table-handlin.patch has no obvious style problems and is ready for submission.
> > 
> > What do you mean by long lines?
> 
> Not long lines, log lines, as in lines logging a message,
> sorry if that was unclear.

My fault, I misread.

> > I'm aware of the exception for long strings.
> > 
> > Not sure why anyone would grep for "dev_info_once(arizona->dev, ".
> > 
> > I would break this after the first comma.
> 
> Ok, I'll send a v2 with a break after the first comma.

Thank you.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
