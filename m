Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87B64E44DB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 18:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239478AbiCVRSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 13:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239470AbiCVRSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 13:18:30 -0400
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709B58B6E6;
        Tue, 22 Mar 2022 10:17:02 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id r13so37669101ejd.5;
        Tue, 22 Mar 2022 10:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=q+lj2+eglVzyIZy6D62HSSh9Bqggm9fvG7QeNRbTAEM=;
        b=OcUZNDcj4OBqxpR7NyMW0Yi3zC0s7+/LMFp/BViteljdQtWyw9p/AqQHdqqPTVf9DA
         UgntSQaDqbBSsYvxb8jCDCqXY29/8RuchQwDdJBHZ1IJra02riKX6M8F2WomHVjkxFpB
         07VPOwk+bVEmeBvhJ8O0IjMvyHEuEmz/hcj0Oywy7ZQGNBPu7D4T6v3ZzmHyL18Nf6a8
         s6Cb1G0wR8z4dmRxDLFDSc1JARa+95yZ/mEivt0UT2BwEAO0chfniRY5iVWmu3o0Hsj7
         FSB1VRoXx6t9wrimoTNotZcff9yyP9sQmL9IL9Ot+z4MJ0YtsAUePENeoOJn3I7TTdm4
         Mlew==
X-Gm-Message-State: AOAM532qLXQOioQQ9Qb4rDzsl++gVxk8pLikLpBsY+dL5KcSs6SJs7F9
        b9arXkdloTZGEg3HX9F7yX8=
X-Google-Smtp-Source: ABdhPJw3b+3IRS5Kx4B8u8PWXxdSKGd4XEx58S1oGPs9C6IS9h54geqZaRybiuOxnvWmaonOVN+zYw==
X-Received: by 2002:a17:907:3d87:b0:6e0:bef:c3cb with SMTP id he7-20020a1709073d8700b006e00befc3cbmr10925458ejc.503.1647969420820;
        Tue, 22 Mar 2022 10:17:00 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id g9-20020aa7c849000000b00412fc6bf26dsm10246688edt.80.2022.03.22.10.16.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 10:17:00 -0700 (PDT)
Message-ID: <d5161e80-789b-8481-3b8f-bf0cfd9875b6@kernel.org>
Date:   Tue, 22 Mar 2022 18:16:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 4/4] usb: host: add xhci-exynos driver
Content-Language: en-US
To:     Daehwan Jung <dh10.jung@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>, sc.suh@samsung.com
References: <1647853194-62147-1-git-send-email-dh10.jung@samsung.com>
 <CGME20220321090205epcas2p15ac16f281554b663062e0e31666defab@epcas2p1.samsung.com>
 <1647853194-62147-5-git-send-email-dh10.jung@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <1647853194-62147-5-git-send-email-dh10.jung@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2022 09:59, Daehwan Jung wrote:
> This driver supports USB Audio offload with Co-processor.
> It only cares DCBAA, Device Context, Transfer Ring, Event Ring, and ERST.
> They are allocated on specific address with xhci hooks.
> Co-processor could use them directly without xhci driver after then.
> 
> Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> ---
>  drivers/usb/host/Kconfig       |   9 +
>  drivers/usb/host/Makefile      |   1 +
>  drivers/usb/host/xhci-exynos.c | 982 +++++++++++++++++++++++++++++++++
>  drivers/usb/host/xhci-exynos.h |  63 +++
>  4 files changed, 1055 insertions(+)
>  create mode 100644 drivers/usb/host/xhci-exynos.c
>  create mode 100644 drivers/usb/host/xhci-exynos.h
> 
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 57ca5f97a3dc..850e6b71fac5 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -783,3 +783,12 @@ config USB_XEN_HCD
>  	  by the Xen host (usually Dom0).
>  	  Only needed if the kernel is running in a Xen guest and generic
>  	  access to a USB device is needed.
> +
> +config USB_XHCI_EXYNOS
> +	tristate "XHCI support for Samsung Exynos SoC Series"
> +	depends on ARCH_EXYNOS || COMPILE_TEST
> +	help
> +	  Enable support for the Samsung Exynos SOC's on-chip XHCI
> +	  controller.
> +
> +	  If unsure, say N.
> diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
> index 2948983618fb..300f22b6eb1b 100644
> --- a/drivers/usb/host/Makefile
> +++ b/drivers/usb/host/Makefile
> @@ -86,3 +86,4 @@ obj-$(CONFIG_USB_HCD_SSB)	+= ssb-hcd.o
>  obj-$(CONFIG_USB_FOTG210_HCD)	+= fotg210-hcd.o
>  obj-$(CONFIG_USB_MAX3421_HCD)	+= max3421-hcd.o
>  obj-$(CONFIG_USB_XEN_HCD)	+= xen-hcd.o
> +obj-$(CONFIG_USB_XHCI_EXYNOS)	+= xhci-exynos.o
> diff --git a/drivers/usb/host/xhci-exynos.c b/drivers/usb/host/xhci-exynos.c
> new file mode 100644
> index 000000000000..19ee21f1d024
> --- /dev/null
> +++ b/drivers/usb/host/xhci-exynos.c
> @@ -0,0 +1,982 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * xhci-exynos.c - xHCI host controller driver platform Bus Glue for Exynos.
> + *
> + * Copyright (C) 2022 Samsung Electronics Incorporated - http://www.samsung.com
> + * Author: Daehwan Jung <dh10.jung@samsung.com>
> + *
> + * A lot of code borrowed from the Linux xHCI driver.
> + */
> +#include <linux/clk.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/usb/phy.h>
> +#include <linux/slab.h>
> +#include <linux/acpi.h>
> +#include <linux/usb/of.h>
> +
> +#include "xhci.h"
> +#include "xhci-plat.h"
> +#include "xhci-mvebu.h"
> +#include "xhci-rcar.h"

Could you explain why do you need RCAR and Marvell code in Exynos? Is it
even a real driver here? On what platforms this can be tested? Where are
the bindings?


(...)


> +static const struct of_device_id usb_xhci_of_match[] = {
> +	{
> +		.compatible = "generic-xhci",
> +	}, {
> +		.compatible = "xhci-platform",
> +	},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, usb_xhci_of_match);
> +#endif

No, this not generic-xhci but Exynos driver. This does not make any sense.


Best regards,
Krzysztof
