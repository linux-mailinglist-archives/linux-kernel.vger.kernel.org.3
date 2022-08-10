Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9524558F3EC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 23:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbiHJVrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 17:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbiHJVrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 17:47:33 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA6374CE3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 14:47:32 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so3396811pjf.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 14:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=39s0Ek4Db0oxJyHd+GleiubqVQyhMKltBfpXe156+eA=;
        b=KUXVZy9iPxCn3vCnVwwTl0rsqFb2K5awdIJe6z/Vl/sZA92yzBGQvYZV7BUn3/0lwC
         dmg2BHhzxfaHMSl15ixFd8t9MFSsXbaI7sV8+jZqK7yPBBUHpcPGXu17IesLT1aHk0hN
         laCPF5+Rb4U7sYEHadRuPZ1GactiMqd2rry3CWcnl/2gh+RPlflcuKEt3I+Z/sRxejko
         kfPEcf03uZtLMmQseHBxHB1sN1VtIcqPlzmuezCW42dXDp4dpLqpkUz/5zlAsFN/e25q
         puy6JZ+7MWjhdkyW89LW49QbmtO0XSkp/b7nHKimqeBVLgzhoBU7L+XXXqhddqIWAZEs
         7utw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=39s0Ek4Db0oxJyHd+GleiubqVQyhMKltBfpXe156+eA=;
        b=33nQTb7xuf2jwEHzurTiUxV1Ngs4LD9wO7/g+GIil28nWKhEjNvpOu1eqTCg5c8/Ft
         iToBCtonUJDZc/Ftt1q/IQbhkBSKssSMQZqSeXqjmx2+vuONlDJp9lURtfDqc1XoyDgN
         3QDGExVjlVgTiYvErYLe6TGZLeSdI7IExM7vOd5LZTbHLpVTs71W+HmfdNYXW+w8PH0n
         bjMShKaxiFsaHF17RQWZiIEshAuVPnQ6gcEZBNNOv8nsDgFfwC0xf2XdpNExmmyqMAlN
         iUTG0USJfSOQEoZBOS24TMOPBc5nHVz6ogXOLYN6l0kXiM5QbrqisNYCNAnhU8BoGrM0
         +W0g==
X-Gm-Message-State: ACgBeo3qAJdvgwFCC8v4ryga4u72PfDZFC4X9jNqegS5LJ73m+VmZwOw
        g4DeW2/WEVjs9Iw9lHJpxEoTmg==
X-Google-Smtp-Source: AA6agR4ftHK8AOHPJWHHGj7Z96vk++JHis/prZQOqY3s/4Xk2tfSi0tiQdYoC1V6Xv0HrkC4Vkm/nw==
X-Received: by 2002:a17:903:4054:b0:16d:afc6:e7b5 with SMTP id n20-20020a170903405400b0016dafc6e7b5mr29121414pla.55.1660168052014;
        Wed, 10 Aug 2022 14:47:32 -0700 (PDT)
Received: from google.com ([2620:15c:2d:3:3bf:333a:7203:b168])
        by smtp.gmail.com with ESMTPSA id l14-20020a170903244e00b001709f01c423sm8258436pls.32.2022.08.10.14.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 14:47:31 -0700 (PDT)
Date:   Wed, 10 Aug 2022 14:47:26 -0700
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
Message-ID: <YvQnbq2RhMOElQE3@google.com>
References: <20220727181936.3250466-1-saravanak@google.com>
 <20220809103052.GA1778649@roeck-us.net>
 <CAGETcx_ATE6vy9YhygHnBA2P1GDVi54np-=E+50F+cwnj6Wg4A@mail.gmail.com>
 <0c6ef9a3-bbb1-9f1c-7f00-ceb05589594e@roeck-us.net>
 <CAGETcx8yKqEthtyd8Zb=mqMBNp1TPRXbQOoFp+OxeCoXnTs2kw@mail.gmail.com>
 <1196e002-c07d-44fd-b07a-aa5ae446ea0b@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1196e002-c07d-44fd-b07a-aa5ae446ea0b@roeck-us.net>
X-Spam-Status: No, score=-14.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 05:58:58AM -0700, Guenter Roeck wrote:
> On 8/9/22 20:33, Saravana Kannan wrote:
> [ ... ]
> 
> > 
> > Can you give me more details on the qemu configuration so I could try
> > to reproduce it?
> 
> qemu-system-arm -M vexpress-a9 -kernel arch/arm/boot/zImage -no-reboot \
>     -initrd rootfs-armv5.cpio -m 128 \
>     --append "rdinit=/sbin/init console=ttyAMA0,115200" \
>     -dtb arch/arm/boot/dts/vexpress-v2p-ca9.dtb \
>     -nographic -monitor null -serial stdio
> 
> using multi_v7_defconfig will hang nicely with your patch applied,
> and boot as expected without. This was with qemu v7.0, but I am
> sure older qemu versions will show the same behavior. The initrd
> used should not matter, but you'll find it at
> https://github.com/groeck/linux-build-test/blob/master/rootfs/arm-v7/rootfs-armv5.cpio.gz
> 
> Guenter
>
Hi Guenter,

Thanks for the information; I was able to reproduce this on my end as
well. The following changes fixed the problem for me. Can you please try
them out?

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 70f79fc71539..b377f18d8acc 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -881,6 +881,11 @@ static int __device_attach_driver(struct device_driver *drv, void *_data)
                dev_dbg(dev, "Device match requests probe deferral\n");
                dev->can_match = true;
                driver_deferred_probe_add(dev);
+               /*
+                * Device can't match with the bus right now, so don't attempt
+                * to match or bind with other drivers on the bus.
+                */
+               return ret;
        } else if (ret < 0) {
                dev_dbg(dev, "Bus failed to match device: %d\n", ret);
                return ret;
@@ -1120,6 +1125,11 @@ static int __driver_attach(struct device *dev, void *data)
                dev_dbg(dev, "Device match requests probe deferral\n");
                dev->can_match = true;
                driver_deferred_probe_add(dev);
+               /*
+                * Driver could not match with device, but may match with
+                * another device on the bus.
+                */
+               return 0;
        } else if (ret < 0) {
                dev_dbg(dev, "Bus failed to match device: %d\n", ret);
                return ret;


Thanks,
Isaac
