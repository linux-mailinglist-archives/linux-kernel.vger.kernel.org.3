Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14C06478FA4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 16:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238181AbhLQP3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 10:29:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238010AbhLQP3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 10:29:48 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB148C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 07:29:47 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id t3so5302712lfe.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 07:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SKyfWTyKOCoSRkTw1gpTygsg+Ll1+r3jq0N230gAei4=;
        b=CzhhijgfP6vnsfiGneOe8PaSN6dLVFqfXXdBftLmGe9PCC03petzPTlBbADJSJxY96
         c+WvGzW6j8BwxljWavL3juGgeUu7uBoPnxXsl50TtIqy0phu5DNmp9NKB1q6ybwwyqCl
         A5+gP4Of3tfKZyTbnA7nCObENYYYaqzqGj4sHaHfgyxVGgzmlFaOqxFVMfECMwhNgKba
         d0YvDDFALh66lX8lhRjXY91EOUfzB3n030EgsE4Wg+HJqy/APhMb+QGalfUFis7+sxN8
         TLFSEfhNpnCf1aJfkUnIDoKUyKMwe/OWTGchP+Ns+dlTV/eQNRpF/VVQLoloSlWyylNZ
         Bu6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SKyfWTyKOCoSRkTw1gpTygsg+Ll1+r3jq0N230gAei4=;
        b=jLjjC4cTT/oaJhlxqKHdCyGQarTbrV/Qd/zQMM1TYhNvArTPZG4ciuZGEmJX9TVWsZ
         QUHefVpFxnb2spwSI15b8Nz5ggh23dBZGuIK59gVf4jevSjV4n/bHSkbekbSp+0Yuk2U
         i6dAZ2itS6kdVzA+wl2gTo/GP4t5N9VFVZo1ovv4bVJ7jsUjiCsxTlg+xGOmJ0EpHQst
         eIXww8JpZOcIlOdxTI7p7/Ncn4svn/F7zIuQOA09btM7y6OEtIPT0K7KBhe99248Yh5d
         zcFZRo6tSgTu32fnnGt2fBpiiv+lYVktx/svMw/98Nk2u84WKK96Fw9cOthmvs3ueksH
         wZ9g==
X-Gm-Message-State: AOAM531o9EEs0cSv9fKI8H6t7Zc17l15if4qmSCCG8igbjKzSqpzEjEM
        bh/1NfzKhXrmVMUcyKvQdcT2Uffm7KU=
X-Google-Smtp-Source: ABdhPJwW+rgWY+mtXVOj58sICuGmP0VvvzN1hU00mtUDEXPIxNMFBmK/Kk1DoZfHeW/S8afL7nyRgQ==
X-Received: by 2002:a05:6512:39c7:: with SMTP id k7mr3315391lfu.571.1639754986075;
        Fri, 17 Dec 2021 07:29:46 -0800 (PST)
Received: from [192.168.2.145] (94-29-63-156.dynamic.spd-mgts.ru. [94.29.63.156])
        by smtp.googlemail.com with ESMTPSA id w6sm1777067ljj.118.2021.12.17.07.29.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 07:29:45 -0800 (PST)
Subject: Re: [PATCH v2] mfd: rk808: add reboot support to rk808.c
To:     Peter Geis <pgwipeout@gmail.com>, Lee Jones <lee.jones@linaro.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        linux-kernel@vger.kernel.org
References: <20211217145544.341617-1-pgwipeout@gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <2bebe0ae-27df-f75d-97d6-2e4d2dd032b0@gmail.com>
Date:   Fri, 17 Dec 2021 18:29:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211217145544.341617-1-pgwipeout@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

17.12.2021 17:55, Peter Geis пишет:
> This adds reboot support to the rk808o pmic driver and enables it for
> the rk809 and rk817 devices.
> This only enables if the rockchip,system-power-controller flag is set.
> 
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
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
> V2:
> - Squash the patch from Frank Wunderlich for rk809 support.
> - Remove support for the rk805, rk808, and rk818 devices.
> - Only register the reset handler for supported devices.
> - Remove unnecessary dev_err and dev_warn statements.
> - Register the reset handler directly
> 
>  drivers/mfd/rk808.c       | 43 +++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/rk808.h |  1 +
>  2 files changed, 44 insertions(+)
...
> +static struct notifier_block rk808_restart_handler = {
> +	.notifier_call = rk808_restart_notify,
> +	.priority = 255,
> +};

Hello!

Please use the default 128 priority if there are no other conflicting
handlers on this RK.

>  static void rk8xx_shutdown(struct i2c_client *client)
>  {
>  	struct rk808 *rk808 = i2c_get_clientdata(client);
> @@ -727,6 +757,19 @@ static int rk808_probe(struct i2c_client *client,
>  	if (of_property_read_bool(np, "rockchip,system-power-controller")) {
>  		rk808_i2c_client = client;
>  		pm_power_off = rk808_pm_power_off;
> +
> +		switch (rk808->variant) {
> +		case RK809_ID:
> +		case RK817_ID:
> +			ret = register_restart_handler(&rk808_restart_handler);

There is no corresponding unregister_restart_handler(), which you should
add to rk808_remove(). Otherwise kernel will crash on reboot if you'll
unload this driver module.

> +			break;
> +		default:
> +			dev_info(&client->dev, "pmic controlled board reset not supported\n");

I'd set ret=0 explicitly here. Later on somebody may change the code and
ret won't be zero anymore, this is not an uncommon trouble in kernel.

> +			break;
> +		}
> +
> +		if (ret)
> +			dev_err(&client->dev, "failed to register restart handler, %d\n", ret);



