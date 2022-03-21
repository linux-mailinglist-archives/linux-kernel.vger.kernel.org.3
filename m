Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5056D4E2CFC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349367AbiCUP6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236298AbiCUP6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:58:05 -0400
X-Greylist: delayed 672 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Mar 2022 08:56:39 PDT
Received: from louie.mork.no (louie.mork.no [IPv6:2001:41c8:51:8a:feff:ff:fe00:e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3D75D1B6;
        Mon, 21 Mar 2022 08:56:39 -0700 (PDT)
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:c9f:8600:0:0:0:1])
        (authenticated bits=0)
        by louie.mork.no (8.15.2/8.15.2) with ESMTPSA id 22LFj3Jb506661
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
        Mon, 21 Mar 2022 15:45:05 GMT
Received: from miraculix.mork.no ([IPv6:2a01:799:c9f:8602:8cd5:a7b0:d07:d516])
        (authenticated bits=0)
        by canardo.dyn.mork.no (8.15.2/8.15.2) with ESMTPSA id 22LFj2lX1245399
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
        Mon, 21 Mar 2022 16:45:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
        t=1647877503; bh=eQHJWF+2Qkckbxc6boV6Ua513xsiPv7/H/5mXqIvaF8=;
        h=From:To:Cc:Subject:References:Date:Message-ID:From;
        b=CEHzqXz9IPk4GobVdbrQC0kKK23X+r4qs3QFYPDpbUhNNP45Zvb4YzY03Ox6D5jSz
         PE+j54KI4Z2+vNUt8cOHFFuILpB+ApDllVRHBBfLUBYVwxpFj1dnwKSrMMr7d45MEE
         gZ6/3Ws75fxF+YPCKskNO6fFk1g2iBnP/l40Cj04=
Received: (nullmailer pid 902608 invoked by uid 1000);
        Mon, 21 Mar 2022 15:45:01 -0000
From:   =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To:     Daehwan Jung <dh10.jung@samsung.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>, sc.suh@samsung.com
Subject: Re: [PATCH v3 4/4] usb: host: add xhci-exynos driver
In-Reply-To: <1647853194-62147-5-git-send-email-dh10.jung@samsung.com>
        (Daehwan Jung's message of "Mon, 21 Mar 2022 17:59:54 +0900")
Organization: m
References: <1647853194-62147-1-git-send-email-dh10.jung@samsung.com>
        <CGME20220321090205epcas2p15ac16f281554b663062e0e31666defab@epcas2p1.samsung.com>
        <1647853194-62147-5-git-send-email-dh10.jung@samsung.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Mon, 21 Mar 2022 16:45:01 +0100
Message-ID: <87r16v9uo2.fsf@miraculix.mork.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.3 at canardo
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daehwan Jung <dh10.jung@samsung.com> writes:

> +++ b/drivers/usb/host/xhci-exynos.c
> @@ -0,0 +1,982 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * xhci-exynos.c - xHCI host controller driver platform Bus Glue for Exy=
nos.
> + *
> + * Copyright (C) 2022 Samsung Electronics Incorporated - http://www.sams=
ung.com
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

The xhci-plat.c file is Copyright (C) 2012 Texas Instruments Incorporated
You can't just steal it.

Besides, even if you could, this isn't about copying as much code as
posible from A to B.  The point is to add as *little* code as possible
to support your hardware.

> +static int xhci_exynos_vendor_init(struct xhci_hcd *xhci)
> +{
> +	/* TODO */
> +	return 0;
> +}

And you didn't even add that?

> +static int xhci_exynos_wake_lock(struct xhci_hcd_exynos *xhci_exynos,
> +				   int is_main_hcd, int is_lock)
> +{
> +	struct usb_hcd	*hcd =3D xhci_exynos->hcd;
> +	struct xhci_hcd *xhci =3D hcd_to_xhci(hcd);
> +	struct wakeup_source *main_wakelock, *shared_wakelock;
> +
> +	main_wakelock =3D xhci_exynos->main_wakelock;
> +	shared_wakelock =3D xhci_exynos->shared_wakelock;

Are these fields initialized anywhere?


> +
> +	if (xhci->xhc_state & XHCI_STATE_REMOVING)
> +		return -ESHUTDOWN;
> +
> +	if (is_lock) {

bool?

> +		if (is_main_hcd)

another bool?

> +			__pm_stay_awake(main_wakelock);
> +		else
> +			__pm_stay_awake(shared_wakelock);
> +	} else {
> +		if (is_main_hcd)
> +			__pm_relax(main_wakelock);
> +		else
> +			__pm_relax(shared_wakelock);
> +	}

Looks interesting.   Are you signalling relax/wakeups events to the PM
core on device suspend/resume?  Why?

> +static int xhci_exynos_address_device(struct usb_hcd *hcd, struct usb_de=
vice *udev)
> +{
> +	struct xhci_hcd *xhci;
> +	int ret;
> +
> +	ret =3D xhci_address_device(hcd, udev);
> +	xhci =3D hcd_to_xhci(hcd);
> +
> +	return ret;
> +}

What's left here if we drop the unused parts?

> +#ifdef CONFIG_OF
> +static const struct xhci_plat_priv xhci_plat_marvell_armada =3D {
> +	.init_quirk =3D xhci_mvebu_mbus_init_quirk,
> +};
> +
> +static const struct xhci_plat_priv xhci_plat_marvell_armada3700 =3D {
> +	.plat_setup =3D xhci_mvebu_a3700_plat_setup,
> +	.init_quirk =3D xhci_mvebu_a3700_init_quirk,
> +};


Right...

> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id usb_xhci_acpi_match[] =3D {
> +	/* XHCI-compliant USB Controller */
> +	{ "PNP0D10", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, usb_xhci_acpi_match);
> +#endif

Nice one

There's no need to copy me if you plan to resend any of this.  I'm just
a drive-by reader here anyway, and I've seen enough.

Good luck!




Bj=C3=B8rn
