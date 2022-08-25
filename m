Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096785A1C44
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 00:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244413AbiHYWZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 18:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244427AbiHYWY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 18:24:59 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C5B1A066
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 15:24:51 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-33dc345ad78so65526697b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 15:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=PdFlW3aeyvpQT3MZkmueIMafwjble/QzgCjOqfMIR00=;
        b=loSUAPsyjpGzJILk/Y7AJdvdMBUd4xEy94biFZSyQ4UCfufO//sLhB2pJQLBimyUti
         W2ZREJoQdaJMy5g08s8m1tWoMgG0jZWeGnUBSwDp39J6WC1D47CdanbG8I0Z2Loh+ais
         keJldIEYUibmNCwNq2yMC+1fwa/8p7TiRzTbc9U/67H3/GskCKW1HSeVoD3aAOZ93FWb
         QhOq/M/PNZF3PEthQlyT5h0fehOgI34FgkPC8kVn74v1HFS0jNkSL1N/jZjT3wI632n5
         WmHadH9bBkaV7WQjxtBqQouy09lVLAJ8zmKXXLBh9DI4uhLTxu+LDRIIU92M3Na776/h
         Lluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=PdFlW3aeyvpQT3MZkmueIMafwjble/QzgCjOqfMIR00=;
        b=saH57ORzo8W0LYPQNVDwU+HBJV9eM2JedzyhSAW3MFJ/AsGTR/kjeijao4gvYeApU6
         6JehlmWLERzmx+/tDaqV4s5yv2WU2D4b2w5DloZCbL5Hih+ukopL8TXaELTpAYL44suw
         +Qvvn45qsod1oBsEKaIw6fGdDMvyykPmF6O42WTe4nhakJ1iXhpAzrOeaoE2/q5QDhAd
         T2uNOrpdMWKa+ibU7sqAXXZFoiqNiEOmVBIuB+lAikJAafy3CyIJlTbtQI5RV7l25EZt
         dEbi3CVos/ivChbiUqgntIA9LuGMudnxt9uFfHSMBs9UnJ7+2Q3jikG2C0XSrMHwhTFN
         wvsA==
X-Gm-Message-State: ACgBeo0uPCd62OXYOyWoPGzG7YHEyJj2O8E47fJ2XVcur+rCdQ0INult
        M6OajOOFMKfzKLcky3+YKcmITY1fwb0XHWbH8Wxlmza/bXI=
X-Google-Smtp-Source: AA6agR5G/z+VplpWMumU5bOeCKBrnxu6hxYb1oYHHcchn8jYqk1LKbxTZFGJR1NDrun/0JGIv7mMHDn6MkRbDPjguWY=
X-Received: by 2002:a25:94b:0:b0:68f:4e05:e8f0 with SMTP id
 u11-20020a25094b000000b0068f4e05e8f0mr5112010ybm.115.1661466290657; Thu, 25
 Aug 2022 15:24:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220818172852.3548-1-isaacmanjarres@google.com>
In-Reply-To: <20220818172852.3548-1-isaacmanjarres@google.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 25 Aug 2022 15:24:14 -0700
Message-ID: <CAGETcx8RZ7H2T+6=PpofpQHgtiDPzkWxONW8vn2B=2s=iFsoLg@mail.gmail.com>
Subject: Re: [PATCH v2] amba: Fix use-after-free in amba_read_periphid()
To:     "Isaac J. Manjarres" <isaacmanjarres@google.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        patches@armlinux.org.uk, Guenter Roeck <linux@roeck-us.net>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 10:29 AM Isaac J. Manjarres
<isaacmanjarres@google.com> wrote:
>
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
> ---
> KernelVersion: rmk/for-next

Russell,

Can you pull this in for 6.0-rcX please? It fixes crashes in a bunch
of devices. Please let us know if you need this rebased on top of
6.0-rc2

Thanks,
Saravana

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
>         struct amba_device *pcdev = to_amba_device(dev);
>         struct amba_driver *pcdrv = to_amba_driver(drv);
>
> +       mutex_lock(&pcdev->periphid_lock);
>         if (!pcdev->periphid) {
>                 int ret = amba_read_periphid(pcdev);
>
> @@ -218,11 +219,14 @@ static int amba_match(struct device *dev, struct device_driver *drv)
>                  * permanent failure in reading pid and cid, simply map it to
>                  * -EPROBE_DEFER.
>                  */
> -               if (ret)
> +               if (ret) {
> +                       mutex_unlock(&pcdev->periphid_lock);
>                         return -EPROBE_DEFER;
> +               }
>                 dev_set_uevent_suppress(dev, false);
>                 kobject_uevent(&dev->kobj, KOBJ_ADD);
>         }
> +       mutex_unlock(&pcdev->periphid_lock);
>
>         /* When driver_override is set, only bind to the matching driver */
>         if (pcdev->driver_override)
> @@ -532,6 +536,7 @@ static void amba_device_release(struct device *dev)
>
>         if (d->res.parent)
>                 release_resource(&d->res);
> +       mutex_destroy(&d->periphid_lock);
>         kfree(d);
>  }
>
> @@ -584,6 +589,7 @@ static void amba_device_initialize(struct amba_device *dev, const char *name)
>         dev->dev.dma_mask = &dev->dev.coherent_dma_mask;
>         dev->dev.dma_parms = &dev->dma_parms;
>         dev->res.name = dev_name(&dev->dev);
> +       mutex_init(&dev->periphid_lock);
>  }
>
>  /**
> diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
> index e94cdf235f1d..5001e14c5c06 100644
> --- a/include/linux/amba/bus.h
> +++ b/include/linux/amba/bus.h
> @@ -67,6 +67,7 @@ struct amba_device {
>         struct clk              *pclk;
>         struct device_dma_parameters dma_parms;
>         unsigned int            periphid;
> +       struct mutex            periphid_lock;
>         unsigned int            cid;
>         struct amba_cs_uci_id   uci;
>         unsigned int            irq[AMBA_NR_IRQS];
> --
> 2.37.1.595.g718a3a8f04-goog
>
