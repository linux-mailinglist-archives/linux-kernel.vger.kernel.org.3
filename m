Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E73C465D74
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 05:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355507AbhLBEja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 23:39:30 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:41114 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355360AbhLBEjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 23:39:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CF902CE2152
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 04:35:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16425C00446;
        Thu,  2 Dec 2021 04:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638419751;
        bh=pWND3NJkhj9XePIxXtamGmmjwZ+5EXgv2TnFzY3Z7vY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mVXZ9Oxq+6dVSMMrlkH7EFJalBARdvWp2A1RThLkRhvArLttCwwoIVxVbE64Z42Sv
         9tn0A2vj6Ycy4BKut0pNQdjbH+j2+Frk1cVf6FfYG/xgITwBqlZzTqX9uMGCf824et
         JpQH2sjmeWfKAgTxVYkamcxYDg0HXbkLNt7EdRZ3v+gKwRLDFCqhwbji7LvjOSX79h
         d4Gdlv4/0qtcALrPmUCKayRog9lGKnsBhCfe9uZ1/4FbRjkyitPzvspemsGJXhG2IJ
         mFU8pp7JADsuP6tn8p7X/Pd6ewMFT800eTAEjiFWgNFgsjjagX3W+Ayu+dgc/TD0Ay
         8rrAGNPA6/TZQ==
Date:   Thu, 2 Dec 2021 10:05:46 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Al Cooper <alcooperx@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-phy@lists.infradead.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 1/3] phy: usb: Leave some clocks running during suspend
Message-ID: <YahNIinbEwB569C1@matsya>
References: <20211201180653.35097-1-alcooperx@gmail.com>
 <20211201180653.35097-2-alcooperx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201180653.35097-2-alcooperx@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-12-21, 13:06, Al Cooper wrote:
> The PHY client driver does a phy_exit() call on suspend or rmmod and
> the PHY driver needs to know the difference because some clocks need
> to be kept running for suspend but can be shutdown on unbind/rmmod
> (or if there are no PHY clients at all).
> 
> The fix is to use a PM notifier so the driver can tell if a PHY
> client is calling exit() because of a system suspend or a driver
> unbind/rmmod.
> 
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> ---
>  drivers/phy/broadcom/phy-brcm-usb.c | 38 +++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/phy/broadcom/phy-brcm-usb.c b/drivers/phy/broadcom/phy-brcm-usb.c
> index 116fb23aebd9..0f1deb6e0eab 100644
> --- a/drivers/phy/broadcom/phy-brcm-usb.c
> +++ b/drivers/phy/broadcom/phy-brcm-usb.c
> @@ -18,6 +18,7 @@
>  #include <linux/soc/brcmstb/brcmstb.h>
>  #include <dt-bindings/phy/phy.h>
>  #include <linux/mfd/syscon.h>
> +#include <linux/suspend.h>
>  
>  #include "phy-brcm-usb-init.h"
>  
> @@ -70,12 +71,35 @@ struct brcm_usb_phy_data {
>  	int			init_count;
>  	int			wake_irq;
>  	struct brcm_usb_phy	phys[BRCM_USB_PHY_ID_MAX];
> +	struct notifier_block	pm_notifier;
> +	bool			pm_active;
>  };
>  
>  static s8 *node_reg_names[BRCM_REGS_MAX] = {
>  	"crtl", "xhci_ec", "xhci_gbl", "usb_phy", "usb_mdio", "bdc_ec"
>  };
>  
> +static int brcm_pm_notifier(struct notifier_block *notifier,
> +			    unsigned long pm_event,
> +			    void *unused)
> +{
> +	struct brcm_usb_phy_data *priv =
> +		container_of(notifier, struct brcm_usb_phy_data, pm_notifier);
> +
> +	switch (pm_event) {
> +	case PM_HIBERNATION_PREPARE:
> +	case PM_SUSPEND_PREPARE:
> +		priv->pm_active = true;
> +		break;
> +	case PM_POST_RESTORE:
> +	case PM_POST_HIBERNATION:
> +	case PM_POST_SUSPEND:
> +		priv->pm_active = false;
> +		break;
> +	}
> +	return NOTIFY_DONE;
> +}
> +
>  static irqreturn_t brcm_usb_phy_wake_isr(int irq, void *dev_id)
>  {
>  	struct phy *gphy = dev_id;
> @@ -91,6 +115,9 @@ static int brcm_usb_phy_init(struct phy *gphy)
>  	struct brcm_usb_phy_data *priv =
>  		container_of(phy, struct brcm_usb_phy_data, phys[phy->id]);
>  
> +	if (priv->pm_active)
> +		return 0;
> +
>  	/*
>  	 * Use a lock to make sure a second caller waits until
>  	 * the base phy is inited before using it.
> @@ -120,6 +147,9 @@ static int brcm_usb_phy_exit(struct phy *gphy)
>  	struct brcm_usb_phy_data *priv =
>  		container_of(phy, struct brcm_usb_phy_data, phys[phy->id]);
>  
> +	if (priv->pm_active)
> +		return 0;
> +
>  	dev_dbg(&gphy->dev, "EXIT\n");
>  	if (phy->id == BRCM_USB_PHY_2_0)
>  		brcm_usb_uninit_eohci(&priv->ini);
> @@ -488,6 +518,9 @@ static int brcm_usb_phy_probe(struct platform_device *pdev)
>  	if (err)
>  		return err;
>  
> +	priv->pm_notifier.notifier_call = brcm_pm_notifier;
> +	register_pm_notifier(&priv->pm_notifier);
> +
>  	mutex_init(&priv->mutex);
>  
>  	/* make sure invert settings are correct */
> @@ -528,7 +561,10 @@ static int brcm_usb_phy_probe(struct platform_device *pdev)
>  
>  static int brcm_usb_phy_remove(struct platform_device *pdev)
>  {
> +	struct brcm_usb_phy_data *priv = dev_get_drvdata(&pdev->dev);
> +
>  	sysfs_remove_group(&pdev->dev.kobj, &brcm_usb_phy_group);
> +	unregister_pm_notifier(&priv->pm_notifier);
>  
>  	return 0;
>  }
> @@ -539,6 +575,7 @@ static int brcm_usb_phy_suspend(struct device *dev)
>  	struct brcm_usb_phy_data *priv = dev_get_drvdata(dev);
>  
>  	if (priv->init_count) {
> +		dev_dbg(dev, "SUSPEND\n");

debug artifact?

>  		priv->ini.wake_enabled = device_may_wakeup(dev);
>  		if (priv->phys[BRCM_USB_PHY_3_0].inited)
>  			brcm_usb_uninit_xhci(&priv->ini);
> @@ -578,6 +615,7 @@ static int brcm_usb_phy_resume(struct device *dev)
>  	 * Uninitialize anything that wasn't previously initialized.
>  	 */
>  	if (priv->init_count) {
> +		dev_dbg(dev, "RESUME\n");

here too

>  		if (priv->wake_irq >= 0)
>  			disable_irq_wake(priv->wake_irq);
>  		brcm_usb_init_common(&priv->ini);
> -- 
> 2.17.1

-- 
~Vinod
