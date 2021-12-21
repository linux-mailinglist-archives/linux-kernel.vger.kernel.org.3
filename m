Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7AF47C363
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 16:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236809AbhLUP4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 10:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236700AbhLUP4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:56:39 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4807CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 07:56:39 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id k21so12195113lfu.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 07:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RalMfMgmm4bE+mLMQy4sGVVWjCHlDXopwkwD5NVelf8=;
        b=VLl1YCl6USv0bxS6MkGksCaQGmN4vDXbADincTVtd0JSYiqGA+9HN55sTGz0DLEAPn
         7J+yXBZVsGf8rY4nm7YFSUEi3dCjlKFlZWqjyx+G0y0U2zSXMIM9+9u9bJoKJGA3a6NW
         pAayd/m6U8/g7mNTgevay7/YfjDojP/ScMnJDbzlhkdxjjiqgECiBGjAM4fF3s1Xq6MT
         3CaVrfeC58xJqyEszl0j5aEcKVmEsqXigTlyAEqAmC9ZB0Kfs+CT4Pkvu2GXm+0dIyXt
         itqe27aozDSlwLIoK7tDVPxNrVXT1FqtjaX+IpNbcsGvz5kYQlw9YsO3NUsUgKJ517XU
         MphA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RalMfMgmm4bE+mLMQy4sGVVWjCHlDXopwkwD5NVelf8=;
        b=sy/ns+vk6tAd4gDCPPZhfWazje/ec2DSgEl5h+iMRK+qEFpTtlqSuOM4VFA9pqPrMX
         GhoZzLQXJeL3mWzfezlC9YOJZUuCDm/HXJJaSE46YLN6oQfvyZpo/Yrb9aXMRH7Jk6xo
         oUNTzRut8U+AQhZ/koqPDcxNjqDheA42ORJdC9wKWwnMGjdJg3KuIosMAXi/lfyKKar1
         FeUOrQ5l4mp28NdkXWfV8eRjb4bIOdWFDZRlAqeHOxfUweqJr/a/qnYDxwu1QWneETcA
         d7LpPZl8XCn/SNHRyK0+Nish6f34S/8D8HKTAxTXjZaacaHkaxLBQzMPQgZS+2E7FKIk
         c0Vg==
X-Gm-Message-State: AOAM5300jCAkKZlPuRrzsU1tU0eeJufPJDxsxXLc08BTXQuVMLsuKkhF
        biAegya61e5ME1GGQBIALIb524JllBk=
X-Google-Smtp-Source: ABdhPJz7fLFCGBuy61gb99wKVKgo0CIIMFH8e40g+6PLGobQlr8Q/9ZuMZna0ReWYAXfzjAqXvpTyw==
X-Received: by 2002:a05:6512:2398:: with SMTP id c24mr3674756lfv.194.1640102197484;
        Tue, 21 Dec 2021 07:56:37 -0800 (PST)
Received: from [192.168.2.145] (46-138-43-24.dynamic.spd-mgts.ru. [46.138.43.24])
        by smtp.googlemail.com with ESMTPSA id w10sm1882066lfu.173.2021.12.21.07.56.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 07:56:37 -0800 (PST)
Subject: Re: [PATCH v3] mfd: rk808: add reboot support to rk808.c
To:     Peter Geis <pgwipeout@gmail.com>, Lee Jones <lee.jones@linaro.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        linux-kernel@vger.kernel.org
References: <20211220170624.1009898-1-pgwipeout@gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c4ad88c5-42bd-9116-2934-135c49781ce8@gmail.com>
Date:   Tue, 21 Dec 2021 18:56:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211220170624.1009898-1-pgwipeout@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

20.12.2021 20:06, Peter Geis пишет:
> This adds reboot support to the rk808 pmic driver and enables it for
> the rk809 and rk817 devices.
> This only enables if the rockchip,system-power-controller flag is set.
> 
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> ---
> This patch was created to address issues with psci-reset on rk356x
> chips. Until the rk356x series ATF open source code is released so we
> can fix the issue at the source, this is the only way to ensure reliable
> resetting on devices using these chips.
> 
> After testing the rk808 (thanks Robin!), it was found DEV_OFF_RST does
> not reset the PMIC to a power on state. Since the rk805 and rk818 match
> this register layout, I'm removing support for all three in the v2.
> It may be possible to add support to them using an RTC wakeup, but that
> has not been explored and is outside the scope of this patch.
> 
> Changelog:
> V4:
> - reorder rk808_restart_notify (Thanks Dmitry)
> - drop of_property_read_bool before unregister (Good catch Frank)

Might be better to resend it with v4 in the commit title, to avoid
confusion.
