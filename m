Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8F94ADC98
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351735AbiBHP1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380187AbiBHP0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:26:55 -0500
X-Greylist: delayed 400 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Feb 2022 07:26:54 PST
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 7A888C061577
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 07:26:54 -0800 (PST)
Received: (qmail 529214 invoked by uid 1000); 8 Feb 2022 10:20:13 -0500
Date:   Tue, 8 Feb 2022 10:20:13 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Neal Liu <neal_liu@aspeedtech.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tao Ren <rentao.bupt@gmail.com>, BMC-SW@aspeedtech.com
Subject: Re: [PATCH v2] usb: ehci: add pci device support for Aspeed platforms
Message-ID: <YgKKLb7cXGJQuKiO@rowland.harvard.edu>
References: <20220208101657.76459-1-neal_liu@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208101657.76459-1-neal_liu@aspeedtech.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 06:16:57PM +0800, Neal Liu wrote:
> Enable Aspeed quirks in commit 7f2d73788d90 ("usb: ehci:
> handshake CMD_RUN instead of STS_HALT") to support Aspeed
> ehci-pci device.
> 
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

>  drivers/usb/host/ehci-pci.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/usb/host/ehci-pci.c b/drivers/usb/host/ehci-pci.c
> index e87cf3a00fa4..638f03b89739 100644
> --- a/drivers/usb/host/ehci-pci.c
> +++ b/drivers/usb/host/ehci-pci.c
> @@ -21,6 +21,9 @@ static const char hcd_name[] = "ehci-pci";
>  /* defined here to avoid adding to pci_ids.h for single instance use */
>  #define PCI_DEVICE_ID_INTEL_CE4100_USB	0x2e70
>  
> +#define PCI_VENDOR_ID_ASPEED		0x1a03
> +#define PCI_DEVICE_ID_ASPEED_EHCI	0x2603
> +
>  /*-------------------------------------------------------------------------*/
>  #define PCI_DEVICE_ID_INTEL_QUARK_X1000_SOC		0x0939
>  static inline bool is_intel_quark_x1000(struct pci_dev *pdev)
> @@ -222,6 +225,12 @@ static int ehci_pci_setup(struct usb_hcd *hcd)
>  			ehci->has_synopsys_hc_bug = 1;
>  		}
>  		break;
> +	case PCI_VENDOR_ID_ASPEED:
> +		if (pdev->device == PCI_DEVICE_ID_ASPEED_EHCI) {
> +			ehci_info(ehci, "applying Aspeed HC workaround\n");
> +			ehci->is_aspeed = 1;
> +		}
> +		break;
>  	}
>  
>  	/* optional debug port, normally in the first BAR */
> -- 
> 2.25.1
> 
