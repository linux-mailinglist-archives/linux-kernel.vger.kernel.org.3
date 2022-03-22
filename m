Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA2D4E3982
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 08:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237398AbiCVHWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 03:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237368AbiCVHWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 03:22:02 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5229011A3F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 00:20:35 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 123-20020a1c1981000000b0038b3616a71aso748461wmz.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 00:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=bzpFrSzrXo2BM8zRHeiSsIXfXIbf/+0Z9qJ+hEHcyck=;
        b=piSGzePXCQS+M1ea3xDE/Ld3nqhfubd49LAkLDNd6DxG/TQ7YPN7gvvUHdl7j5WmVw
         ODidazNI1++iE0up8plYmjhQiYLDqUZPpAOBRg1f/Jsmxq2Yjik0QNNP68rQZ7CSy/Ib
         f3q+C1/o9dHTQO0iQe6b3qIdIOVZc9oji2FWTfGJ/XxQ5Je0ro5MIBgaKdQgEb3244C2
         6e5AhbSn6M73wtaC5eK8FcWntyfBmDLVlhwi4YERAdJqShgvhcGx3PqJxA6XUeROymyg
         nNjMQn2LxCQGEHEZ9+0YbI+yIk+4XhKX4+HF5glpZLhmtkh+/aBQFISXvq9FNrqTTSv8
         eVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bzpFrSzrXo2BM8zRHeiSsIXfXIbf/+0Z9qJ+hEHcyck=;
        b=aooK4dXZKqBKsLv2O2GxVR/7yY+ofA8oGVlfZpVmR+xZYDOpTH0tIcUEdhS20Qj9cl
         MHFupj/VnmGD4YEiV7NUu/PujXHQYfjFYAR7EwoCj5+VCVxTnShQFVRiax2UbPupfwGL
         EUKSi5KHiGtrdfPETPfX5T/rhaNltm+9vtH2GMkqContqCBXzETS+xhmSmwN8lCSv+jh
         0QZvZlcwCE5DY8Gu6s3VUUcCB4zaWmQPhLiqS0T7bfDm3gP5w5lNeoTjcc4O+N1D28wj
         s6DSkxKsQsURx8noflStvls8iTeRT2g05neQBh2Ax/RO4V8MaGnHaa/INmyulx6YntA1
         xOwQ==
X-Gm-Message-State: AOAM531wTCvlTZeTpRJXxR0N9JeJ+VvX2SYRu5eAEvmhPv700XCAVfet
        CC7AToZITZj/uru5exvetCmvyA==
X-Google-Smtp-Source: ABdhPJyZGyCciYgYgQQVk9uZGB8QxLDoXlmjUxqT1byRdDYnNP0z6B/vmudajeJUvItlX/IhREUoBw==
X-Received: by 2002:a05:600c:1d8e:b0:389:d079:cc0 with SMTP id p14-20020a05600c1d8e00b00389d0790cc0mr2357937wms.98.1647933633915;
        Tue, 22 Mar 2022 00:20:33 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id i35-20020adf90a6000000b00203e767a1d2sm13214056wri.103.2022.03.22.00.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 00:20:33 -0700 (PDT)
Date:   Tue, 22 Mar 2022 07:20:31 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2 2/2] mfd: arizona-spi: Add Android board ACPI table
 handling
Message-ID: <Yjl4v/Cg3iSQdzIY@google.com>
References: <20220307173844.199135-1-hdegoede@redhat.com>
 <20220307173844.199135-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220307173844.199135-2-hdegoede@redhat.com>
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

> x86/ACPI boards with an arizona WM5102 codec ship with either Windows or
> Android as factory installed OS.
> 
> The ACPI fwnode for the codec on Android boards misses 2 things compared
> to the Windows boards (this is hardcoded in the Android board kernels):
> 
> 1. There is no CLKE ACPI method to enabe the 32 KHz clock the codec needs
>    for jack-detection.
> 
> 2. The GPIOs used by the codec are not listed in the fwnode for the codec.
> 
> The ACPI tables on x86/ACPI boards shipped with Android being incomplete
> happens a lot. The special drivers/platform/x86/x86-android-tablets.c
> module contains DMI based per model handling to compensate for this.
> 
> This module will enable the 32KHz clock through the pinctrl framework
> to fix 1. and it will also register a gpio-lookup table for all GPIOs
> needed by the codec + machine driver, including the GPIOs coming from
> the codec itself.
> 
> Add an arizona_spi_acpi_android_probe() function which waits for the
> x86-android-tablets to have set things up before continue with probing
> the arizona WM5102 codec.
> 
> Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> - Wrap long dev_info_once() line
> ---
>  drivers/mfd/arizona-spi.c | 35 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
