Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9AC51599A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 03:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379126AbiD3B3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 21:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240105AbiD3B3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 21:29:31 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id B838A7F209
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 18:26:11 -0700 (PDT)
Received: (qmail 966577 invoked by uid 1000); 29 Apr 2022 21:26:11 -0400
Date:   Fri, 29 Apr 2022 21:26:11 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Vincent Shih <vincent.sunplus@gmail.com>
Cc:     gregkh@linuxfoundation.org, p.zabel@pengutronix.de,
        davem@davemloft.net, vladimir.oltean@nxp.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, wells.lu@sunplus.com
Subject: Re: [PATCH v4 1/2] usb: host: ehci-sunplus: Add driver for ehci in
 Sunplus SP7021
Message-ID: <YmyQM3Yp31E1lfrn@rowland.harvard.edu>
References: <1651220876-26705-1-git-send-email-vincent.sunplus@gmail.com>
 <1651220876-26705-2-git-send-email-vincent.sunplus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1651220876-26705-2-git-send-email-vincent.sunplus@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 04:27:55PM +0800, Vincent Shih wrote:
> Add driver for ehci in Sunplus SP7021
> 
> Signed-off-by: Vincent Shih <vincent.sunplus@gmail.com>
> ---

> diff --git a/drivers/usb/host/ehci-sunplus.c b/drivers/usb/host/ehci-sunplus.c
> new file mode 100644
> index 0000000..4d8e20d
> --- /dev/null
> +++ b/drivers/usb/host/ehci-sunplus.c

> +static struct usb_ehci_pdata usb_ehci_pdata = {
> +	.has_tt = 1,
> +	.has_synopsys_hc_bug = 1,
> +	.big_endian_desc = 1,
> +	.big_endian_mmio = 1,
> +	.power_on = sp_ehci_platform_power_on,
> +	.power_suspend = sp_ehci_platform_power_off,
> +	.power_off = sp_ehci_platform_power_off,
> +
> +};
> +
> +static int ehci_sunplus_reset(struct usb_hcd *hcd)
> +{
> +	struct platform_device *pdev = to_platform_device(hcd->self.controller);
> +	struct usb_ehci_pdata *pdata = pdev->dev.platform_data;
> +	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
> +	int retval;
> +
> +	hcd->has_tt = pdata->has_tt;
> +	ehci->has_synopsys_hc_bug = pdata->has_synopsys_hc_bug;
> +	ehci->big_endian_desc = pdata->big_endian_desc;
> +	ehci->big_endian_mmio = pdata->big_endian_mmio;

By the way, you don't need to add all this pdata stuff.  You can just 
set hcd->has_tt, ehci->has_synopsys_hc_bug, ehci_big_endian_desc, and 
ehci->big_endian_mmio directly, since you already know what their values 
should be.

It looks like you simply copied the code from the ehci-platform driver.  
But that driver has to handle many different kinds of platform devices, 
so it needs to be told about their individual differences, whereas your 
driver only has to handle one kind.

In fact, there's no obvious reason why you didn't just use the 
ehci-platform driver instead of writing your own driver.  
That's the sort of thing you need to explain the patch description.

Alan Stern
