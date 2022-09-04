Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598395AC415
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 13:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbiIDLPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 07:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiIDLPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 07:15:18 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC8033436
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 04:15:16 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 29so3025343edv.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 04:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=+VfT7oibjSJZGJfKyqzJo5S6Yt+ptxSsKOxbHzL0zng=;
        b=Mtzj0BtU1iEebcePl5RtTNv4MMJDAa4mGuF4oU2xR4OksqFHX6B9Adam/kNkF7k6gc
         KOWPkauEV+ov2I80pmvxb0dRhp5wX0MRoFRdz1OSq0N/jMbRTmuxamvXr0M5SEnGHuE8
         kVVQ/atMdt8Fsq/HCfnS0BzsiB3XO6ywc6Gn3XTfk+MRFMSTqQ4RZBQWxbYYea+H5BVK
         OJIvSSjF52p1Bv493KAPfGZaVn69goI9tyXXnBMOkQF8/64+dTDBcoFvArPGWycprM/S
         TuLx+3bzUREZsDhBK/Gx2Q/RawUBoCkkFybi7s5B1B5t3gaGkfsPVOLMwWeegIx9o4+a
         9Kdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=+VfT7oibjSJZGJfKyqzJo5S6Yt+ptxSsKOxbHzL0zng=;
        b=fy3lwtD48PiucPS2lg5mqlKIByNoXdwv6tHU84STyngv8bbLv6d5M6hxGRcuhSaDWp
         ff/lw2Xo3CC9PlU8CUFn+lPVvoSISDe7szM3hu1n6iBd0Uiy92n+YyYDcvP6qp4gZMss
         UlrVYyRz3AzPr4UBX+M267XyNhwnaYXPI6Mufz/2ajwfk1uxUUtcFn7BNx6XC7ST4iOp
         MVhAQjkqfGGuNkXBX93zE1C6Up+w6E20sedDvT8mGchubwRGKKjxpWCqHgTwTMq9qH5z
         +RMXNJmYB07jUh5d5gU8yQERn2Av4yiivdZz/2ieRBVGcq2Fct01UyrqgyK8+tdL0HW+
         aIcQ==
X-Gm-Message-State: ACgBeo0PCFWYkiOzGS9Ua/co6tha9EvwtMEytdtTRV/WKg5E/lS3FhRP
        +piMmXgD3FiHOHjJbBmFTXY=
X-Google-Smtp-Source: AA6agR4hKm46ofTTSkszGKki38GIEFoZs7tjncdoj6rOGKR6hxXX21iHXDhou8wZQcvfR57cYwDOiw==
X-Received: by 2002:a05:6402:28cd:b0:448:3856:41a3 with SMTP id ef13-20020a05640228cd00b00448385641a3mr30187539edb.6.1662290114438;
        Sun, 04 Sep 2022 04:15:14 -0700 (PDT)
Received: from [192.168.0.10] (ip5f5bd57f.dynamic.kabel-deutschland.de. [95.91.213.127])
        by smtp.gmail.com with ESMTPSA id h13-20020a17090791cd00b0073dd11cd1c6sm3589979ejz.34.2022.09.04.04.15.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Sep 2022 04:15:13 -0700 (PDT)
Message-ID: <094b6125-6b3e-1b8e-024f-a924e4775305@gmail.com>
Date:   Sun, 4 Sep 2022 13:15:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2] amba: Fix use-after-free in amba_read_periphid()
To:     "Isaac J. Manjarres" <isaacmanjarres@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@google.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc:     patches@armlinux.org.uk, Guenter Roeck <linux@roeck-us.net>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
References: <20220818172852.3548-1-isaacmanjarres@google.com>
Content-Language: en-US
From:   Gabriel Francisco <frc.gabriel@gmail.com>
In-Reply-To: <20220818172852.3548-1-isaacmanjarres@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch alone on top of v6.0-rc2 still gives me the null pointer.

But combining it with Zhen Lei's patch (from 
https://lkml.org/lkml/2022/8/27/164) my device boots successfully.

Thank you!

Tested-by: Gabriel Francisco <frc.gabriel@gmail.com>

On 18/08/2022 19:28, Isaac J. Manjarres wrote:
> After commit f2d3b9a46e0e ("ARM: 9220/1: amba: Remove deferred device
> addition"), it became possible for amba_read_periphid() to be invoked
> concurrently from two threads for a particular AMBA device.
>
> Consider the case where a thread (T0) is registering an AMBA driver, and
> searching for all of the devices it can match with on the AMBA bus.
> Suppose that another thread (T1) is executing the deferred probe work,
> and is searching through all of the AMBA drivers on the bus for a driver
> that matches a particular AMBA device. Assume that both threads begin
> operating on the same AMBA device and the device's peripheral ID is
> still unknown.
>
> In this scenario, the amba_match() function will be invoked for the
> same AMBA device by both threads, which means amba_read_periphid()
> can also be invoked by both threads, and both threads will be able
> to manipulate the AMBA device's pclk pointer without any synchronization.
> It's possible that one thread will initialize the pclk pointer, then the
> other thread will re-initialize it, overwriting the previous value, and
> both will race to free the same pclk, resulting in a use-after-free for
> whichever thread frees the pclk last.
>
> Add a lock per AMBA device to synchronize the handling with detecting the
> peripheral ID to avoid the use-after-free scenario.
>
> The following KFENCE bug report helped detect this problem:
> ==================================================================
> BUG: KFENCE: use-after-free read in clk_disable+0x14/0x34
>
> Use-after-free read at 0x(ptrval) (in kfence-#19):
>   clk_disable+0x14/0x34
>   amba_read_periphid+0xdc/0x134
>   amba_match+0x3c/0x84
>   __driver_attach+0x20/0x158
>   bus_for_each_dev+0x74/0xc0
>   bus_add_driver+0x154/0x1e8
>   driver_register+0x88/0x11c
>   do_one_initcall+0x8c/0x2fc
>   kernel_init_freeable+0x190/0x220
>   kernel_init+0x10/0x108
>   ret_from_fork+0x14/0x3c
>   0x0
>
> kfence-#19: 0x(ptrval)-0x(ptrval), size=36, cache=kmalloc-64
>
> allocated by task 8 on cpu 0 at 11.629931s:
>   clk_hw_create_clk+0x38/0x134
>   amba_get_enable_pclk+0x10/0x68
>   amba_read_periphid+0x28/0x134
>   amba_match+0x3c/0x84
>   __device_attach_driver+0x2c/0xc4
>   bus_for_each_drv+0x80/0xd0
>   __device_attach+0xb0/0x1f0
>   bus_probe_device+0x88/0x90
>   deferred_probe_work_func+0x8c/0xc0
>   process_one_work+0x23c/0x690
>   worker_thread+0x34/0x488
>   kthread+0xd4/0xfc
>   ret_from_fork+0x14/0x3c
>   0x0
>
> freed by task 8 on cpu 0 at 11.630095s:
>   amba_read_periphid+0xec/0x134
>   amba_match+0x3c/0x84
>   __device_attach_driver+0x2c/0xc4
>   bus_for_each_drv+0x80/0xd0
>   __device_attach+0xb0/0x1f0
>   bus_probe_device+0x88/0x90
>   deferred_probe_work_func+0x8c/0xc0
>   process_one_work+0x23c/0x690
>   worker_thread+0x34/0x488
>   kthread+0xd4/0xfc
>   ret_from_fork+0x14/0x3c
>   0x0
>
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: patches@armlinux.org.uk
> Fixes: f2d3b9a46e0e ("ARM: 9220/1: amba: Remove deferred device addition")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
> ---
> KernelVersion: rmk/for-next
>
>   drivers/amba/bus.c       | 8 +++++++-
>   include/linux/amba/bus.h | 1 +
>   2 files changed, 8 insertions(+), 1 deletion(-)
>
> v1 -> v2:
> - Applied on rmk/for-next
>
> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index 32b0e0b930c1..110a535648d2 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -209,6 +209,7 @@ static int amba_match(struct device *dev, struct device_driver *drv)
>   	struct amba_device *pcdev = to_amba_device(dev);
>   	struct amba_driver *pcdrv = to_amba_driver(drv);
>   
> +	mutex_lock(&pcdev->periphid_lock);
>   	if (!pcdev->periphid) {
>   		int ret = amba_read_periphid(pcdev);
>   
> @@ -218,11 +219,14 @@ static int amba_match(struct device *dev, struct device_driver *drv)
>   		 * permanent failure in reading pid and cid, simply map it to
>   		 * -EPROBE_DEFER.
>   		 */
> -		if (ret)
> +		if (ret) {
> +			mutex_unlock(&pcdev->periphid_lock);
>   			return -EPROBE_DEFER;
> +		}
>   		dev_set_uevent_suppress(dev, false);
>   		kobject_uevent(&dev->kobj, KOBJ_ADD);
>   	}
> +	mutex_unlock(&pcdev->periphid_lock);
>   
>   	/* When driver_override is set, only bind to the matching driver */
>   	if (pcdev->driver_override)
> @@ -532,6 +536,7 @@ static void amba_device_release(struct device *dev)
>   
>   	if (d->res.parent)
>   		release_resource(&d->res);
> +	mutex_destroy(&d->periphid_lock);
>   	kfree(d);
>   }
>   
> @@ -584,6 +589,7 @@ static void amba_device_initialize(struct amba_device *dev, const char *name)
>   	dev->dev.dma_mask = &dev->dev.coherent_dma_mask;
>   	dev->dev.dma_parms = &dev->dma_parms;
>   	dev->res.name = dev_name(&dev->dev);
> +	mutex_init(&dev->periphid_lock);
>   }
>   
>   /**
> diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
> index e94cdf235f1d..5001e14c5c06 100644
> --- a/include/linux/amba/bus.h
> +++ b/include/linux/amba/bus.h
> @@ -67,6 +67,7 @@ struct amba_device {
>   	struct clk		*pclk;
>   	struct device_dma_parameters dma_parms;
>   	unsigned int		periphid;
> +	struct mutex		periphid_lock;
>   	unsigned int		cid;
>   	struct amba_cs_uci_id	uci;
>   	unsigned int		irq[AMBA_NR_IRQS];
