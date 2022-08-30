Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A4C5A5B1A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 07:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiH3FbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 01:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiH3Fa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 01:30:59 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0750F79639
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 22:30:58 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id i7-20020a17090adc0700b001fd7ccbec3cso848121pjv.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 22:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=NgkaPIndM+nXYYk2tWH3yLyDrSfApuh9yEF+Dmvk7zc=;
        b=cKCDPYSqV7JChbxkSAZt4PSuOQgwMr/xA6Q0/Zdu/J4Ii9EWZiqVVqm4b5EtO6HuCI
         6WPD4Hm9ADq5UiRCCnCowxPgcljokIoRlyAEUi7jsj7px0aX/lWVgzPQIWya169Z8UjD
         Ig0f7wFTTx9YnqK7LSSEsdLNmZJDA/n8tgB3nFZYMeoz1OS6IZ6D8A9NwJtQgQJmLgNV
         XOZ0IVvvC0qFY8kBt++tqFxjn7/DifJmksMnuYwaeMa4jWshR9vHiZszMs5VhhCA3Stq
         0H5Mp8tVbYNKBeCsB8vkg9MdqcQpkrz+yTnAm1LAsYLe27fKkB0zOy/hWVzu/Cf+yVBY
         ++7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=NgkaPIndM+nXYYk2tWH3yLyDrSfApuh9yEF+Dmvk7zc=;
        b=QKGAIFop60g2bC4zhEEPmYuMmbz24DcvLnmfWnH9WBAXGL3hc40RsigPriFGXnrZ5h
         gcvTgtNA3tvxBnZotF770i34S1IjlSJI+oM5Z/BAaAYgu5d0OGQ52emuEJSaLrv0592N
         awZXXUrDU5funsMnouc2xzoA9DucZT85p4KUTflzpD6aDPk/Y/qUOesCm3BhezfIRgxT
         EFx7Q4zBwL8P8SGbajUao6VtaEpVc7XrOFKxI0AmSGmwSTYO4+ZzdG2S4xm/KpdKT+L+
         rZnQhCKLWsFzUJvXCUUNBnUhDkeJ+njpjvhikXVjZTx7FWlAcvCwG5kTlaYh0+a1FBr+
         CBYA==
X-Gm-Message-State: ACgBeo3U2zpwPSTu75NTQnSpCmHZAEsaWq29vlH73yYE0JtkGbSj46Il
        ns0N9cDvn41J1CpJmnqIOTI=
X-Google-Smtp-Source: AA6agR4s5wYyIeLO95qNdGsMNyTpr043N656B/wi05ODv/tFJCp1WVsDlDHX+yS44f1hgNhug4aOJQ==
X-Received: by 2002:a17:90b:4a09:b0:1fd:d4be:fed4 with SMTP id kk9-20020a17090b4a0900b001fdd4befed4mr8159546pjb.6.1661837457509;
        Mon, 29 Aug 2022 22:30:57 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i137-20020a62878f000000b00538664195d1sm2032264pfe.123.2022.08.29.22.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 22:30:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 29 Aug 2022 22:30:54 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Isaac J. Manjarres" <isaacmanjarres@google.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@google.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        patches@armlinux.org.uk, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] amba: Fix use-after-free in amba_read_periphid()
Message-ID: <20220830053054.GA3995268@roeck-us.net>
References: <20220818172852.3548-1-isaacmanjarres@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818172852.3548-1-isaacmanjarres@google.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 10:28:51AM -0700, Isaac J. Manjarres wrote:
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
>  clk_disable+0x14/0x34
>  amba_read_periphid+0xdc/0x134
>  amba_match+0x3c/0x84
>  __driver_attach+0x20/0x158
>  bus_for_each_dev+0x74/0xc0
>  bus_add_driver+0x154/0x1e8
>  driver_register+0x88/0x11c
>  do_one_initcall+0x8c/0x2fc
>  kernel_init_freeable+0x190/0x220
>  kernel_init+0x10/0x108
>  ret_from_fork+0x14/0x3c
>  0x0
> 
> kfence-#19: 0x(ptrval)-0x(ptrval), size=36, cache=kmalloc-64
> 
> allocated by task 8 on cpu 0 at 11.629931s:
>  clk_hw_create_clk+0x38/0x134
>  amba_get_enable_pclk+0x10/0x68
>  amba_read_periphid+0x28/0x134
>  amba_match+0x3c/0x84
>  __device_attach_driver+0x2c/0xc4
>  bus_for_each_drv+0x80/0xd0
>  __device_attach+0xb0/0x1f0
>  bus_probe_device+0x88/0x90
>  deferred_probe_work_func+0x8c/0xc0
>  process_one_work+0x23c/0x690
>  worker_thread+0x34/0x488
>  kthread+0xd4/0xfc
>  ret_from_fork+0x14/0x3c
>  0x0
> 
> freed by task 8 on cpu 0 at 11.630095s:
>  amba_read_periphid+0xec/0x134
>  amba_match+0x3c/0x84
>  __device_attach_driver+0x2c/0xc4
>  bus_for_each_drv+0x80/0xd0
>  __device_attach+0xb0/0x1f0
>  bus_probe_device+0x88/0x90
>  deferred_probe_work_func+0x8c/0xc0
>  process_one_work+0x23c/0x690
>  worker_thread+0x34/0x488
>  kthread+0xd4/0xfc
>  ret_from_fork+0x14/0x3c
>  0x0
> 
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: patches@armlinux.org.uk
> Fixes: f2d3b9a46e0e ("ARM: 9220/1: amba: Remove deferred device addition")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
> KernelVersion: rmk/for-next
> 
>  drivers/amba/bus.c       | 8 +++++++-
>  include/linux/amba/bus.h | 1 +
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> v1 -> v2:
> - Applied on rmk/for-next
> 
> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index 32b0e0b930c1..110a535648d2 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -209,6 +209,7 @@ static int amba_match(struct device *dev, struct device_driver *drv)
>  	struct amba_device *pcdev = to_amba_device(dev);
>  	struct amba_driver *pcdrv = to_amba_driver(drv);
>  
> +	mutex_lock(&pcdev->periphid_lock);
>  	if (!pcdev->periphid) {
>  		int ret = amba_read_periphid(pcdev);
>  
> @@ -218,11 +219,14 @@ static int amba_match(struct device *dev, struct device_driver *drv)
>  		 * permanent failure in reading pid and cid, simply map it to
>  		 * -EPROBE_DEFER.
>  		 */
> -		if (ret)
> +		if (ret) {
> +			mutex_unlock(&pcdev->periphid_lock);
>  			return -EPROBE_DEFER;
> +		}
>  		dev_set_uevent_suppress(dev, false);
>  		kobject_uevent(&dev->kobj, KOBJ_ADD);
>  	}
> +	mutex_unlock(&pcdev->periphid_lock);
>  
>  	/* When driver_override is set, only bind to the matching driver */
>  	if (pcdev->driver_override)
> @@ -532,6 +536,7 @@ static void amba_device_release(struct device *dev)
>  
>  	if (d->res.parent)
>  		release_resource(&d->res);
> +	mutex_destroy(&d->periphid_lock);
>  	kfree(d);
>  }
>  
> @@ -584,6 +589,7 @@ static void amba_device_initialize(struct amba_device *dev, const char *name)
>  	dev->dev.dma_mask = &dev->dev.coherent_dma_mask;
>  	dev->dev.dma_parms = &dev->dma_parms;
>  	dev->res.name = dev_name(&dev->dev);
> +	mutex_init(&dev->periphid_lock);
>  }
>  
>  /**
> diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
> index e94cdf235f1d..5001e14c5c06 100644
> --- a/include/linux/amba/bus.h
> +++ b/include/linux/amba/bus.h
> @@ -67,6 +67,7 @@ struct amba_device {
>  	struct clk		*pclk;
>  	struct device_dma_parameters dma_parms;
>  	unsigned int		periphid;
> +	struct mutex		periphid_lock;
>  	unsigned int		cid;
>  	struct amba_cs_uci_id	uci;
>  	unsigned int		irq[AMBA_NR_IRQS];
> -- 
> 2.37.1.595.g718a3a8f04-goog
> 
