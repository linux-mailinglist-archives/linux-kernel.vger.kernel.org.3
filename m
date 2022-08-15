Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78112593A2F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 21:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245204AbiHOTd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 15:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344909AbiHOT11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 15:27:27 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820655B789
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 11:43:17 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id 130so7043966pfy.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 11:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=EU6K+sVa6W0a7O9upd2Yf0LoGVDPysQI+lhW2bpO+II=;
        b=Ghqf4iMDV+Aih0e2T3tonmRVv6/jPS7ebwaApTEj1IOUWhtSugxx7jwCkxykQMVM3v
         N9LYTzHfrRo30hcVuUKtq1bxWF0QDn8HeTRVGJSIkH6/mB8tEVhFLPhYjhodXmBUrKRv
         HDlhPAyTqAeWInnHnZqT4B1sa1asj9kV/jTBTO7SpwpIi5JBGUr9cTB16lSqWu4VhMcD
         cJZpJRZ/YIIcAAsoVbyVv3yMagfzipBqfoAwM2ASJuELGhIQh1YGyFYj3alWsd3Iib6T
         qJDGGnAPaugy6XbPEqzwKiFizWIsMBVpu2kjiKVcZOgIcHBqEPv4wvJoMxWC3sDnjzJV
         etSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=EU6K+sVa6W0a7O9upd2Yf0LoGVDPysQI+lhW2bpO+II=;
        b=HYcLpKee27QxnE6M+gN4pHoSBnlf/wgnmw/D5+Ef7+0U8/zTnUwzTbm65pS8OJ2vpx
         TbMRo+ab0uFeVwL0Z+L13sYVs1uZLDJNFt36guVeitdfcaCX6EFLypJjyrbB7p8Dl7iK
         Pzrpc5cgG4Y6fPz2U2/Kn/zm6gXJ/45svFdHq9M+4gWOZjP2UZ3LaUOmW7Y1fn+zzsC0
         4To95LKBzM5Lx2/aa8y+n9hTbOKTHuGq9Kp8Vgquo9jFY3goAiO9QMpS67G761Aap4lB
         wfxKLto5QMmjDfgE+WjbJDVmZ9Psh/FP/UOKsA9Wz0mL4g9uVQ9olXsQbX/vhbWMB/bk
         cWYg==
X-Gm-Message-State: ACgBeo1bIiipy+As677WmetnDaVkF2YTfBLq4B00dUWvp2D6g3lt3LGa
        f7fx/IjZtHsC4JeoyGvOgrGLRA==
X-Google-Smtp-Source: AA6agR7kVTsxhemScH4L4843BSFTf80xCn10CgpGE2t1gEfEaBXMn3iB5F9Ga4gRwQNHXleei9jwcw==
X-Received: by 2002:a05:6a00:e85:b0:52b:5db8:f3df with SMTP id bo5-20020a056a000e8500b0052b5db8f3dfmr17746780pfb.14.1660588996681;
        Mon, 15 Aug 2022 11:43:16 -0700 (PDT)
Received: from google.com ([2620:15c:2d:3:2e7e:eaac:df8:6465])
        by smtp.gmail.com with ESMTPSA id f5-20020a170902ce8500b0016ee3d7220esm7344480plg.24.2022.08.15.11.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 11:43:15 -0700 (PDT)
Date:   Mon, 15 Aug 2022 11:43:10 -0700
From:   Isaac Manjarres <isaacmanjarres@google.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Saravana Kannan <saravanak@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@armlinux.org.uk, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] amba: Remove deferred device addition
Message-ID: <YvqTvuqSll30Rv2k@google.com>
References: <1196e002-c07d-44fd-b07a-aa5ae446ea0b@roeck-us.net>
 <YvQnbq2RhMOElQE3@google.com>
 <225747de-4348-58b3-19be-8b14356ab3a0@roeck-us.net>
 <CAGETcx895=9wPF+jnUfiycJ0k8d1S3BA0HLz42nCegtMBeo3LQ@mail.gmail.com>
 <971799be-8c15-fc81-ec71-bbca6483207d@roeck-us.net>
 <YvUzpSAQDktDPRbR@google.com>
 <YvVWEIn8veGL9Psa@google.com>
 <20220811195234.GA4018948@roeck-us.net>
 <YvXhJRlHN9OAIA5l@google.com>
 <1c20eedf-4fa9-9cb1-b232-3bc490c1be7c@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c20eedf-4fa9-9cb1-b232-3bc490c1be7c@roeck-us.net>
X-Spam-Status: No, score=-14.4 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2022 at 08:30:46AM -0700, Guenter Roeck wrote:
> After more testing: the changes above result in qemu sx1 boot failures.
> There is no crash, boot just hangs.
> 
> qemu command line:
> 
> qemu-system-arm -M sx1 -kernel arch/arm/boot/zImage -no-reboot \
> 	-initrd rootfs-armv4.cpio \
> 	--append "rdinit=/sbin/init console=ttyS0,115200 earlycon=uart8250,mmio32,0xfffb0000,115200n8" \
> 	-nographic -monitor null -serial stdio
> 
> with configuration from
> https://github.com/groeck/linux-build-test/blob/master/rootfs/arm/qemu_sx1_defconfig
> and root file system from
> https://github.com/groeck/linux-build-test/blob/master/rootfs/arm/rootfs-armv4.cpio.gz
> 
> This is with your other patch applied.
> 
> Guenter

Thanks for testing out the patch and sharing the qemu commandline you
used for the new issue. I was able to reproduce it on my end :) Can you
please try the following patch instead of the second patch I gave you?
This worked for me on sx1 and versatileab:

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 32b0e0b930c1..110a535648d2 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -209,6 +209,7 @@ static int amba_match(struct device *dev, struct device_driver *drv)
        struct amba_device *pcdev = to_amba_device(dev);
        struct amba_driver *pcdrv = to_amba_driver(drv);

+       mutex_lock(&pcdev->periphid_lock);
        if (!pcdev->periphid) {
                int ret = amba_read_periphid(pcdev);

@@ -218,11 +219,14 @@ static int amba_match(struct device *dev, struct device_driver *drv)
                 * permanent failure in reading pid and cid, simply map it to
                 * -EPROBE_DEFER.
                 */
-               if (ret)
+               if (ret) {
+                       mutex_unlock(&pcdev->periphid_lock);
                        return -EPROBE_DEFER;
+               }
                dev_set_uevent_suppress(dev, false);
                kobject_uevent(&dev->kobj, KOBJ_ADD);
        }
+       mutex_unlock(&pcdev->periphid_lock);

        /* When driver_override is set, only bind to the matching driver */
        if (pcdev->driver_override)
@@ -532,6 +536,7 @@ static void amba_device_release(struct device *dev)

        if (d->res.parent)
                release_resource(&d->res);
+       mutex_destroy(&d->periphid_lock);
        kfree(d);
 }

@@ -584,6 +589,7 @@ static void amba_device_initialize(struct amba_device *dev, const char *name)
        dev->dev.dma_mask = &dev->dev.coherent_dma_mask;
        dev->dev.dma_parms = &dev->dma_parms;
        dev->res.name = dev_name(&dev->dev);
+       mutex_init(&dev->periphid_lock);
 }

 /**
diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index e94cdf235f1d..5001e14c5c06 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -67,6 +67,7 @@ struct amba_device {
        struct clk              *pclk;
        struct device_dma_parameters dma_parms;
        unsigned int            periphid;
+       struct mutex            periphid_lock;
        unsigned int            cid;
        struct amba_cs_uci_id   uci;
        unsigned int            irq[AMBA_NR_IRQS];


Thanks,
Isaac
