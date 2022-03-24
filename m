Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD384E65F3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 16:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351237AbiCXP1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 11:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240829AbiCXP1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 11:27:50 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 6E80AA8EFF
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 08:26:18 -0700 (PDT)
Received: (qmail 210494 invoked by uid 1000); 24 Mar 2022 11:26:17 -0400
Date:   Thu, 24 Mar 2022 11:26:17 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     WeitaoWangoc <WeitaoWang-oc@zhaoxin.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, tonywwang@zhaoxin.com,
        weitaowang@zhaoxin.com, CobeChen@zhaoxin.com
Subject: Re: [PATCH v2] USB:Fix ehci infinite suspend-resume loop issue in
 zhaoxin
Message-ID: <YjyNmSEks8oVOyao@rowland.harvard.edu>
References: <20220324121735.3803-1-WeitaoWang-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324121735.3803-1-WeitaoWang-oc@zhaoxin.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 08:17:35PM +0800, WeitaoWangoc wrote:
> In zhaoxin platform, some ehci projects will latch a wakeup signal
> internal when plug in a device on port during system S0. This wakeup
> signal will turn on when ehci runtime suspend, which will trigger a
> system control interrupt that will resume ehci back to D0. As no
> device connect, ehci will be set to runtime suspend and turn on the
> internal latched wakeup signal again. It will cause a suspend-resume
> loop and generate system control interrupt continuously.
> 
> Fixed this issue by clear wakeup signal latched in ehci internal when
> ehci resume callback is called.
> 
> Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>

Acked-by: Alan Stern <stern@rowland.harvard.edu>

I'll submit the change to hcd-pci.c after the current merge window 
closes.

Alan Stern

> ---
> v1->v2
>  - Improve this patch with not to clear STS_PCD bit.
>  - Change a boolean flag name to make its meaning more obvious.
>  - Fix "tabs converted to spaces" issue.
> 
>  drivers/usb/host/ehci-hcd.c | 23 +++++++++++++++++++++++
>  drivers/usb/host/ehci-pci.c |  4 ++++
>  drivers/usb/host/ehci.h     |  1 +
>  3 files changed, 28 insertions(+)
> 
> diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
> index 3d82e0b853be..684164fa9716 100644
> --- a/drivers/usb/host/ehci-hcd.c
> +++ b/drivers/usb/host/ehci-hcd.c
> @@ -1103,6 +1103,26 @@ static void ehci_remove_device(struct usb_hcd *hcd, struct usb_device *udev)
>  
>  #ifdef	CONFIG_PM
>  
> +/* Clear wakeup signal locked in zhaoxin platform when device plug in. */
> +static void ehci_zx_wakeup_clear(struct ehci_hcd *ehci)
> +{
> +	u32 __iomem	*reg = &ehci->regs->port_status[4];
> +	u32 		t1 = ehci_readl(ehci, reg);
> +
> +	t1 &= (u32)~0xf0000;
> +	t1 |= PORT_TEST_FORCE;
> +	ehci_writel(ehci, t1, reg);
> +	t1 = ehci_readl(ehci, reg);
> +	msleep(1);
> +	t1 &= (u32)~0xf0000;
> +	ehci_writel(ehci, t1, reg);
> +	ehci_readl(ehci, reg);
> +	msleep(1);
> +	t1 = ehci_readl(ehci, reg);
> +	ehci_writel(ehci, t1 | PORT_CSC, reg);
> +	ehci_readl(ehci, reg);
> +}
> +
>  /* suspend/resume, section 4.3 */
>  
>  /* These routines handle the generic parts of controller suspend/resume */
> @@ -1154,6 +1174,9 @@ int ehci_resume(struct usb_hcd *hcd, bool force_reset)
>  	if (ehci->shutdown)
>  		return 0;		/* Controller is dead */
>  
> +	if (ehci->zx_wakeup_clear_needed)
> +		ehci_zx_wakeup_clear(ehci);
> +
>  	/*
>  	 * If CF is still set and reset isn't forced
>  	 * then we maintained suspend power.
> diff --git a/drivers/usb/host/ehci-pci.c b/drivers/usb/host/ehci-pci.c
> index e87cf3a00fa4..b11a6f82aee2 100644
> --- a/drivers/usb/host/ehci-pci.c
> +++ b/drivers/usb/host/ehci-pci.c
> @@ -222,6 +222,10 @@ static int ehci_pci_setup(struct usb_hcd *hcd)
>  			ehci->has_synopsys_hc_bug = 1;
>  		}
>  		break;
> +	case PCI_VENDOR_ID_ZHAOXIN:
> +		if (pdev->device == 0x3104 && (pdev->revision & 0xf0) == 0x90)
> +			ehci->zx_wakeup_clear_needed = 1;
> +		break;
>  	}
>  
>  	/* optional debug port, normally in the first BAR */
> diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
> index fdd073cc053b..ad3f13a3eaf1 100644
> --- a/drivers/usb/host/ehci.h
> +++ b/drivers/usb/host/ehci.h
> @@ -220,6 +220,7 @@ struct ehci_hcd {			/* one per controller */
>  	unsigned		imx28_write_fix:1; /* For Freescale i.MX28 */
>  	unsigned		spurious_oc:1;
>  	unsigned		is_aspeed:1;
> +	unsigned		zx_wakeup_clear_needed:1;
>  
>  	/* required for usb32 quirk */
>  	#define OHCI_CTRL_HCFS          (3 << 6)
> -- 
> 2.32.0
