Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3451D4A372B
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 16:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355370AbiA3PLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 10:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349175AbiA3PLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 10:11:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9D6C061714;
        Sun, 30 Jan 2022 07:11:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8ADB6123B;
        Sun, 30 Jan 2022 15:11:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9DDEC340E4;
        Sun, 30 Jan 2022 15:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643555472;
        bh=oYvKAImQNUHKveacXyI4MjLN9QGhpLq3yA19e/9Eri8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NreeKZBiXnASrKDL6r3UzlLBbK4CgrRFna25soR7h/Q1u7RhIMSmf2IJLhKaBfXGU
         /zXrkRPbJNSKfD5YCS1Kx0SwJl1qmawCgqOgzYAS0/iM3C9+dL+maAhXXw1XaTsbL8
         o9YczUxPc05DfRlQN2yt3XoArE/+ASqQqlz4mhCych6rZKmauHj4RusfKbIoeeJRLN
         ZGcoC/OtZ6e3+SlRNRyIEs4gT7kNWlO3wruFk6YlkLwsVdzhDqlYWnK+V2Hc6E2G3O
         0uLXaSiPOaKYMKpjeMHLLWzUh61NpwtRQFSsLrI3h+qmgIk6fr7y9RUlTsoKXhueg4
         JF8D+dpHx9E1Q==
Date:   Sun, 30 Jan 2022 15:17:37 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nikos Latmos <n.latmos@deepsea.ai>
Cc:     jmaneyrol@invensense.com, lars@metafoo.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PROBLEM]: Error during probing process in inv_icm42600_i2c
 driver
Message-ID: <20220130151737.43ef5b08@jic23-huawei>
In-Reply-To: <CAC-bbXbkt0oYPn+EWLdEYKyj8G_muWGDZWTApyFv3cb591dc0A@mail.gmail.com>
References: <20211208135644.3523024-1-n.latmos@deepsea.ai>
        <CAC-bbXbkt0oYPn+EWLdEYKyj8G_muWGDZWTApyFv3cb591dc0A@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Dec 2021 16:33:52 +0200
Nikos Latmos <n.latmos@deepsea.ai> wrote:

> Hello,
> 
> I have an ARM device based on the Broadcom BCM2837 processor (quad-core
> ARM Cortex-A53, 1.2GHz), which has an Invensense ICM-42605 IMU chip
> connected over I2C. I'm running an unmodified Linux 5.4.83 kernel. The I2C
> driver for my device is in the following path:
> drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c.
> 
> The problem is that the device driver cannot be probed. More specifically,
> dmesg returns the following error message:
> 
> inv-icm42600-i2c 0-0068: mounting matrix not found: using identity...
> inv-icm42600-i2c 0-0068: 0-0068 supply vdd not found, using dummy regulator
> inv-icm42600-i2c 0-0068: 0-0068 supply vddio not found, using dummy regulator
> inv-icm42600-i2c: probe of 0-0068 failed with error -121
> 
> During the debugging procedure, I found out that the failure occurred when
> the driver tried to set up the I2C bus parameters. More precisely, by setting
> the INV_ICM42600_REG_INTF_CONFIG6 register according to the values described
> in the datasheet for the I2C communication, actually caused the probe function
> to fail and return the error -121.
> 
> After I experimented with different values in the specific register bits,
> I came to the conclusion, that the setting of the bit
> INV_ICM42600_INTF_CONFIG6_I3C_SDR_EN caused the system to successfully
> probe the driver. Any other bit setting combinations failed to do so.
> 
> Any hints on why would the driver behave so?
> 
> Here is a patch that I have so far and it seems to solve the issue.
> 
> Best regards,
> Nick Latmos

Hi All,

Anyone familiar with this part able to help Nick?

Thanks,

Jonathan

> 
> 
> From d7b3922cd0182ba880ff729edb4a156b55dfb6f0 Mon Sep 17 00:00:00 2001
> From: nicklat <n.latmos@deepsea.ai>
> Date: Wed, 8 Dec 2021 15:51:28 +0200
> Subject: [PATCH] iio: imu: inv_icm42600: enable SDR mode
> 
> Add SDR (Single Data Rate) support.
> In SDR mode, data is only clocked on one edge of the clock.
> 
> Without this option enabled, the probing process fails.
> 
> Signed-off-by: nicklat <n.latmos@deepsea.ai>
> ---
>  drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
> b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
> index 85b1934cec60..ea31f102fbca 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
> @@ -21,7 +21,8 @@ static int inv_icm42600_i2c_bus_setup(struct
> inv_icm42600_state *st)
>         /* setup interface registers */
>         ret = regmap_update_bits(st->map, INV_ICM42600_REG_INTF_CONFIG6,
>                                  INV_ICM42600_INTF_CONFIG6_MASK,
> -                                INV_ICM42600_INTF_CONFIG6_I3C_EN);
> +                                INV_ICM42600_INTF_CONFIG6_I3C_EN |
> +                                INV_ICM42600_INTF_CONFIG6_I3C_SDR_EN);
>         if (ret)
>                 return ret;
> 
> --
> 2.25.1

