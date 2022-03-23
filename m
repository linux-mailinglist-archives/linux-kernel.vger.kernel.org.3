Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D754E4ECA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 09:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242985AbiCWI72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 04:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242843AbiCWI7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 04:59:24 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A3C7307A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 01:57:52 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id h7so1558474lfl.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 01:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=+qaXC3e57Tiy30ZXHo3R6JiVE4H5pqyKCj5fJD4m4ys=;
        b=zqNNso2fFQIURdKn+WCA/vJQdsxFIVL22/L/nbroH9TaQ5BMjR9n+6Qg4QmAR/7Q4b
         jxP6IL+fSjauUtN0GUsgR5rScJGv/jpBLVydr0e7AG0CmeTB6iIgC8goReiBaudA8nC0
         lmIS4pgYLY4nqwCxRznov31I79k3xiuaCGMqac26PV9V8Nwp/dA7Ri/tqKwsNpX9OL1W
         EJuMCxFR4sx2DB+N+ZVNRgrrSfGWuynXnK4FIFTBgC2miCWqxn1o4apcFsxQcoVyQIL7
         XnhlHsW+2m6Xzvk25IsPVBqYFOCE1YNoPHHrO+PX8+Fa+35BE7DUFrVAyhHOdEoTdF5d
         9qdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=+qaXC3e57Tiy30ZXHo3R6JiVE4H5pqyKCj5fJD4m4ys=;
        b=ZIcETYcFIQTEx5ZS2zAFDrQT88KEVYHDJGYMWCS30zZPoJhh5iPXHIN+WSuveE+pow
         QjMnpvMIXb/l+c6oh46gOTH/rKSCENU3YNplMb7cOjQHE/MBCCMv8WWyADIV8GWpUTPE
         mDnEA99m4WtIjVzrLj74oBB1T03SxtRKpKdPD3Ou68epBSdlomGecyC+W5PdOUGZG7rx
         RTX4kPbX1S4IYgLPozotB4bX0Fr4RPhLWZIPQMujieANzi7IjTsRTbyawswQi7v0aFDZ
         CLhzc0Tps+U08HokkUJYyu1QIZzmNmViUENsDnVO6MvIMqV10uzk+Eb7TZ5ngmq0w54U
         aZPQ==
X-Gm-Message-State: AOAM533jkHkFtehcklJ6a2+yDxCGbGWKMoPLPQo/DHjDZYbFTtnZRrdP
        D/e4kYLvFyGGtQGTQM02AGMwhKgPGcU/yw==
X-Google-Smtp-Source: ABdhPJx/2cLioJKyQq21MTxnrumXwt4HgT60/HKz/TXrfghvo/u6E3itGwmET3Nei+dOXQ78PmJ4Pw==
X-Received: by 2002:a05:6512:1585:b0:445:908b:ad71 with SMTP id bp5-20020a056512158500b00445908bad71mr20542778lfb.200.1648025870850;
        Wed, 23 Mar 2022 01:57:50 -0700 (PDT)
Received: from wkz-x280 (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id y23-20020a2e95d7000000b00247e4e386aasm2684910ljh.121.2022.03.23.01.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 01:57:49 -0700 (PDT)
From:   Tobias Waldekranz <tobias@waldekranz.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: gpio_wdt: Support GPO lines with the toggle
 algorithm
In-Reply-To: <8b41a486-92af-2f2d-ba05-205650a90ee2@roeck-us.net>
References: <20220322222911.519238-1-tobias@waldekranz.com>
 <8b41a486-92af-2f2d-ba05-205650a90ee2@roeck-us.net>
Date:   Wed, 23 Mar 2022 09:57:49 +0100
Message-ID: <87tubphwqa.fsf@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 17:04, Guenter Roeck <linux@roeck-us.net> wrote:
> On 3/22/22 15:29, Tobias Waldekranz wrote:
>> Support using GPO lines (i.e. GPIOs that are output-only) with
>> gpio_wdt using the "toggle" algorithm.
>> 
>> Since its inception, gpio_wdt has configured its GPIO line as an input
>> when using the "toggle" algorithm, even though it is used as an output
>> when kicking. This needlessly barred hardware with output-only pins
>> from using the driver.
>> 
>> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
>> ---
>> 
>> Hi,
>> 
>> This patch has been in our downstream tree for a long time. We need it
>> because our kick GPIO can't be used as an input.
>> 
>> What I really can't figure out is why the driver would request the pin
>> as in input, when it's always going to end up being used as an output
>> anyway.
>> 
>> So I thought I'd send it upstream in the hopes of either getting it
>> merged, or an explanation as to why it is needed.
>> 
>
> I _think_ the assumption / idea was that "toggle" implies that the output
> is connected to a pull-up resistor and that the pin either floats or is
> pulled down to ground, causing the signal to toggle. I don't know if/how
> that works in practice, though.

Ah I see. Yeah I'm not sure it has the intended effect. AFAIK, that type
of connection should be specified using the GPIOD_OUT_LOW_OPEN_DRAIN
flag, no?

Beyond that though, it seems unnecessary for the driver to impose that
restriction. If an open drain configuration is required on the GPIO,
then I think that should be specified via the device tree. Looking at
some code, gpiod_configure_flags seems to support this:

	if (lflags & GPIO_OPEN_DRAIN)
		set_bit(FLAG_OPEN_DRAIN, &desc->flags);
	else if (dflags & GPIOD_FLAGS_BIT_OPEN_DRAIN) {
		/*
		 * This enforces open drain mode from the consumer side.
		 * This is necessary for some busses like I2C, but the lookup
		 * should *REALLY* have specified them as open drain in the
		 * first place, so print a little warning here.
		 */
		set_bit(FLAG_OPEN_DRAIN, &desc->flags);
		gpiod_warn(desc,
			   "enforced open drain please flag it properly in DT/ACPI DSDT/board file\n");
	}

In other words, a DT node like this...

	&watchdog {
		compatible = "linux,wdt-gpio";
        	gpios = <&my-gpio 42 GPIO_ACTIVE_HIGH>;
	};

...the GPIO will behave like it does with the "level" algo today. If an
open-drain config is required, using this binding...

	&watchdog {
		compatible = "linux,wdt-gpio";
        	gpios = <&my-gpio 42 (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>;
	};

...will give you that.

In other words, with this patch applied, the setup of the GPIO is
completely deferred to the device tree. In the general case, my guess is
that who ever wrote that has a better chance of specifying the correct
flags.
