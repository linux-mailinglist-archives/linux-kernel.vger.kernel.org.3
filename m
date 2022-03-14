Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1672C4D7C3A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 08:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236800AbiCNHqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 03:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiCNHq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 03:46:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A134130B;
        Mon, 14 Mar 2022 00:45:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BFF81B80D09;
        Mon, 14 Mar 2022 07:45:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18F5C340E9;
        Mon, 14 Mar 2022 07:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647243917;
        bh=6H3Vbn9VR1mMJRpELS186RqQ5UVHJOtW0iryZ9qTxFw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u6Lxj3gDjbxuaZcnuMvGZB4xWpj5dqfIx+sfeV+Hp/UvsmdURV5i3/sTG9+//YkQW
         FO9zez8Ow1g0aXp/klQoGbICEDFtV/MkUI0XbZUM/h5ILbbPbYpKqdJgFiG5oIYqs1
         847Uk5zIAhw2vD78S5KuCd7/slv2K+t/KPqDl5bo=
Date:   Mon, 14 Mar 2022 08:45:13 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "WeitaoWang-oc@zhaoxin.com" <WeitaoWang-oc@zhaoxin.com>
Cc:     stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, CobeChen@zhaoxin.com,
        TimGuo@zhaoxin.com, tonywwang@zhaoxin.com, weitaowang@zhaoxin.com
Subject: Re: [PATCH] USB:Fix ehci infinite suspend-resume loop issue in
 zhaoxin
Message-ID: <Yi7yiafFBs3AeJKs@kroah.com>
References: <3d0ae3ca-9dad-bb8f-5c41-45bdcb07b9cd@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d0ae3ca-9dad-bb8f-5c41-45bdcb07b9cd@zhaoxin.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 03:35:37PM +0800, WeitaoWang-oc@zhaoxin.com wrote:
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
> ---
>  drivers/usb/host/ehci-hcd.c | 26 ++++++++++++++++++++++++++
>  drivers/usb/host/ehci-pci.c |  4 ++++
>  drivers/usb/host/ehci.h     |  1 +
>  3 files changed, 31 insertions(+)
> 
> diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
> index 3d82e0b..e4840ef 100644
> --- a/drivers/usb/host/ehci-hcd.c
> +++ b/drivers/usb/host/ehci-hcd.c
> @@ -1103,6 +1103,30 @@ static void ehci_remove_device(struct usb_hcd *hcd,
> struct usb_device *udev)
> 
>  #ifdef CONFIG_PM
> 
> +/* Clear wakeup signal locked in zhaoxin platform when device plug in. */
> +static void ehci_zx_wakeup_clear(struct ehci_hcd *ehci)
> +{
> +       u32 __iomem     *reg = &ehci->regs->port_status[4];
> +       u32     t1 = ehci_readl(ehci, reg);
> +
> +       t1 &= (u32)~0xf0000;
> +       t1 |= PORT_TEST_FORCE;
> +       ehci_writel(ehci, t1, reg);
> +       t1 = ehci_readl(ehci, reg);
> +       msleep(1);
> +       t1 &= (u32)~0xf0000;
> +       ehci_writel(ehci, t1, reg);
> +       ehci_readl(ehci, reg);
> +       msleep(1);
> +       t1 = ehci_readl(ehci, reg);
> +       ehci_writel(ehci, t1 | PORT_CSC, reg);
> +       ehci_readl(ehci, reg);
> +       udelay(500);
> +       t1 = ehci_readl(ehci, &ehci->regs->status);
> +       ehci_writel(ehci, t1 & STS_PCD, &ehci->regs->status);
> +       ehci_readl(ehci, &ehci->regs->status);
> +}
> +
>  /* suspend/resume, section 4.3 */
> 
>  /* These routines handle the generic parts of controller suspend/resume */
> @@ -1154,6 +1178,8 @@ int ehci_resume(struct usb_hcd *hcd, bool force_reset)
>         if (ehci->shutdown)
>                 return 0;               /* Controller is dead */
> 
> +       if (ehci->zx_wakeup_clear == 1)
> +               ehci_zx_wakeup_clear(ehci);
>         /*
>          * If CF is still set and reset isn't forced
>          * then we maintained suspend power.
> diff --git a/drivers/usb/host/ehci-pci.c b/drivers/usb/host/ehci-pci.c
> index e87cf3a..a5e27de 100644
> --- a/drivers/usb/host/ehci-pci.c
> +++ b/drivers/usb/host/ehci-pci.c
> @@ -222,6 +222,10 @@ static int ehci_pci_setup(struct usb_hcd *hcd)
>                         ehci->has_synopsys_hc_bug = 1;
>                 }
>                 break;
> +       case PCI_VENDOR_ID_ZHAOXIN:
> +               if (pdev->device == 0x3104 && (pdev->revision & 0xf0) ==
> 0x90)
> +                       ehci->zx_wakeup_clear = 1;
> +               break;
>         }
> 
>         /* optional debug port, normally in the first BAR */
> diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
> index fdd073c..712fdd0 100644
> --- a/drivers/usb/host/ehci.h
> +++ b/drivers/usb/host/ehci.h
> @@ -220,6 +220,7 @@ struct ehci_hcd {                   /* one per
> controller */
>         unsigned                imx28_write_fix:1; /* For Freescale i.MX28
> */
>         unsigned                spurious_oc:1;
>         unsigned                is_aspeed:1;
> +       unsigned                zx_wakeup_clear:1;
> 
>         /* required for usb32 quirk */
>         #define OHCI_CTRL_HCFS          (3 << 6)
> -- 
> 2.7.4

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
  and can not be applied.  Please read the file,
  Documentation/email-clients.txt in order to fix this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
