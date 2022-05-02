Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FFC517707
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 20:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387002AbiEBTDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 15:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiEBTDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 15:03:05 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFC9654B
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 11:59:35 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id k126-20020a1ca184000000b003943fd07180so99524wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 11:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=kw3f9KINiTdwTbt/+DaeVDEWIMOIamgUP2eEKwHR5N4=;
        b=pengUl1W4caLgN0nR8g2V3IGDf5pF1lFNpM1u0PHT5U2Td+eIGaE5Sen9sYQ41Wd1U
         xD6vQUdoHIwmAnFWyLf+8P5IbkKnTzp8BFns86e3UL/9sm3p58W7Q+IGRHa1aMWiBejZ
         Kv6xYMwdKQN56XoGZCCvF295rtXA0Y1IQSQVjyoFtBSJ+XttLPo+R7Gc80l5XT90Qjlq
         +oi1l/hkuTGIZZarjokL4J/FYQ58qU822UMti3u2AkFmXfHOMnqGPwFUi5QTjXV7TFu6
         OUaXy89ndWjTb8vhTsoazLnas/ltBvY7EZL8skhpVBuS1INz7d1pk3uQg98311gwgMNa
         2pFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kw3f9KINiTdwTbt/+DaeVDEWIMOIamgUP2eEKwHR5N4=;
        b=cabf0+ZVh2q3BeYuwKBt6V6hWDBoADiQc0Tv5ZQryyJGy+F7UoKxzClxN0tL938Juz
         6rxSLrUPIrQEbfCaT2QPw/cIFjTmn8qGNbLf3eXg2kXs5d1rHDBWQgpAl0KdhGKSOpBU
         +XIkHqTc2qd7Y8gW+A6G829Sl3HG9Aw9n7TwxgUQJ17g8ICI23GmroJQl/HVO0xzzhFB
         Y3MBJaElk66nG0ncXTcy26ygUX7VMWkvmzDKiXqxKg0DuC8KAVSgzbJFxIg22kK9ldFI
         dHKLmvhNMhYZmPPvrThE0ccElDdUA/rrP8vfaYM3ckpcRYUv83w2xoxNA9nz3hluc5sr
         OfMQ==
X-Gm-Message-State: AOAM530VhDFddZNCh6B5ZBtPzLC4/DQC58J7FRjqUwj86Fq/r2vhhqcv
        Y07obI5SVGHvGK/U3KuCmrhmMXYr2mfiNg==
X-Google-Smtp-Source: ABdhPJwIeLgYMEwUxrmCp/aC/3AN4cpDx01maV+9LVll+JoEtq9Ti7ElrqO73oW279Eb4NXFDCjRzA==
X-Received: by 2002:a05:600c:4f56:b0:394:3fa3:97bb with SMTP id m22-20020a05600c4f5600b003943fa397bbmr391224wmq.83.1651517973538;
        Mon, 02 May 2022 11:59:33 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id p6-20020a05600c1d8600b003942a244f34sm80137wms.13.2022.05.02.11.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 11:59:32 -0700 (PDT)
Date:   Mon, 2 May 2022 20:59:27 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: acpi_power_meter: convert to
 hwmon_device_register_with_info
Message-ID: <YnAqDxfTU27USQI+@Red>
References: <20220502124249.682058-1-clabbe@baylibre.com>
 <20220502124249.682058-2-clabbe@baylibre.com>
 <0b154a30-7765-e3ac-9980-0ecc7447d7ad@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b154a30-7765-e3ac-9980-0ecc7447d7ad@roeck-us.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mon, May 02, 2022 at 06:34:44AM -0700, Guenter Roeck a écrit :
> On 5/2/22 05:42, Corentin Labbe wrote:
> > Booting lead to a hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
> > So let's convert the driver to use hwmon_device_register_with_info().
> > 
> > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > ---
> >   drivers/hwmon/acpi_power_meter.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
> > index d2545a1be9fc..98293727f980 100644
> > --- a/drivers/hwmon/acpi_power_meter.c
> > +++ b/drivers/hwmon/acpi_power_meter.c
> > @@ -891,7 +891,10 @@ static int acpi_power_meter_add(struct acpi_device *device)
> >   	if (res)
> >   		goto exit_free_capability;
> >   
> > -	resource->hwmon_dev = hwmon_device_register(&device->dev);
> > +	resource->hwmon_dev = hwmon_device_register_with_info(&device->dev,
> > +							      ACPI_POWER_METER_DEVICE_NAME,
> > +							      NULL, NULL,
> > +							      NULL);
> 
> NACK. That isn't a conversion to the new API, it just abuses the fact
> that the new API has to accept a NULL info pointer for historic reasons.
> 

Hello

I am sorry, I found a driver doing it, so I believed it was okay.
Converting seems not to hard but, by using the new API, how can I convert power1_model_number/power1_is_battery attribute ?
There are the remaining attributes I dont find how to convert.

Regards
