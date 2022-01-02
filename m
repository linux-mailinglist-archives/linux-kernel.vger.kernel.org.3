Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF21482ACA
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 12:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbiABLAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 06:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbiABLAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 06:00:00 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B066EC06173E
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jan 2022 02:59:59 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id j11so67548667lfg.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jan 2022 02:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6gEyJfg8JUmaaGwj32IW/dpbCJkePLqJ3QKtpvWW39Y=;
        b=c5qJtmgiymOvOI+y++V7Kehdq0h1niRnY+QaRXEze6yRs+hndFZSPbBW4615g8VIrj
         5QHI6OLJaMmdFGjBM+VPvYVuJAWO7kVyQc2IRY5Uk+ZoOyuz0l7gj/XkCkBe75unCKr7
         jD3KpkPWrlq7lBiF9LEiy9lWEeknDZVHdlBlUMxFb1+5iuhdI+Q04EEgh9rGg3FFJOQN
         atZ74Hv6S4ZZsnPMuVpZx3TgaBmSiPUdoSPZJLQX0kwXQT4ye6JL78mnGZJQdGyJtLof
         kCmWy4CqHN4A5j77fnc4k9mzXmr3TTBO6P6sp9wi7laAKCyBrB4gDa0/iLY+DL6ovgGZ
         081w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6gEyJfg8JUmaaGwj32IW/dpbCJkePLqJ3QKtpvWW39Y=;
        b=qbPrzpWS/nmikfHqo63ScdDT9639lEMJnurisPsCm0JVofokdJeWREkBUTYevkAXcx
         OHZra+Av/5nFUezccmqZdcE7ETozsJso2g2ohgF4l1hKItlk8b+kLU47Er/a9KMDQGIa
         tTQHmplOIsIzYD8KVWmtdjsj7y2CBogPtRIFxaiHBZ6Lq0rtWUCCAbsJVBL0bW/jLtk5
         N/Q4KtemuE2AgbFGNtKfswTRKGYewRmsdMrkfQY569YYIFA5lY5Sk6CbAMqQXlIjHtxX
         DPU99uHk+PNREcEJGJ/BODO+cvBUg7z55Ob+sZLAdMAiTQSMhL+dvwatwU/cMQ0sdnWs
         XLqg==
X-Gm-Message-State: AOAM530RExfGSFD4dYYubN21vP8MWqI9P2d6M+gKBKxSmeP3cAJs8GWq
        TKZVDtP9dqTem5RvW06Rpegm24szgNW8DROkeMg=
X-Google-Smtp-Source: ABdhPJxPfx1VzqXdZABrNvR+yPxE1Vt0DPx8vAZd17mUjM7WFs93muKkt6lBjUcoM4rqPpSHPy6IpA==
X-Received: by 2002:ac2:5388:: with SMTP id g8mr36849331lfh.64.1641121197612;
        Sun, 02 Jan 2022 02:59:57 -0800 (PST)
Received: from [192.168.112.17] (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id q125sm225871ljq.77.2022.01.02.02.59.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jan 2022 02:59:57 -0800 (PST)
Subject: Re: [PATCH] iio: stm: don't always auto-enable I2C and SPI interface
 drivers
To:     Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Cai Huoqing <caihuoqing@baidu.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211229072916.2567155-1-nikita.yoush@cogentembedded.com>
 <CACRpkdYcR7SA1bfzAtMBpXZiXZeZnV8hWGddx26VvvKwiZC4Sw@mail.gmail.com>
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Message-ID: <0f233def-99c8-d6f1-b4e6-26cc21187a01@cogentembedded.com>
Date:   Sun, 2 Jan 2022 13:59:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdYcR7SA1bfzAtMBpXZiXZeZnV8hWGddx26VvvKwiZC4Sw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



02.01.2022 10:02, Linus Walleij wrote:
> On Wed, Dec 29, 2021 at 8:29 AM Nikita Yushchenko
> <nikita.yoush@cogentembedded.com> wrote:
> 
>>   config IIO_ST_ACCEL_I2C_3AXIS
>> -       tristate
>> -       depends on IIO_ST_ACCEL_3AXIS
>> -       depends on IIO_ST_SENSORS_I2C
>> +       tristate "STMicroelectronics accelerometers 3-Axis I2C Interface"
>> +       depends on (I2C && IIO_ST_ACCEL_3AXIS)
>> +       default y if (I2C && IIO_ST_ACCEL_3AXIS)
>> +       select IIO_ST_SENSORS_I2C
> 
> This thing that a Kconfig symbol is made to depend on itself just
> boggles my head but it wouldn't surprise me if KConfig is this weird :(
> 
> I CCed Arnd who knows KConfig a bit better than anyone I know.

Sorry but I don't see a dependency on itself here.

"IIO_ST_ACCEL_I2C_3AXIS" depends on "IIO_ST_ACCEL_3AXIS"

Name with I2C embedded not at end could be a bit wired, but in this patch I don't change any names to 
keep things 100% backward-compatible.

Nikita
