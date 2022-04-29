Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70755148D7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 14:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358870AbiD2MKv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 29 Apr 2022 08:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236678AbiD2MKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 08:10:47 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042FEA27C1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 05:07:28 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nkPP0-0002Ha-DR; Fri, 29 Apr 2022 14:07:14 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nkPOx-005wMO-Hq; Fri, 29 Apr 2022 14:07:10 +0200
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nkPOv-00073P-27; Fri, 29 Apr 2022 14:07:09 +0200
Message-ID: <6776293c80bf3f48d7a72a3c9f73e93abee2b369.camel@pengutronix.de>
Subject: Re: [PATCH v4 1/2] usb: host: ehci-sunplus: Add driver for ehci in
 Sunplus SP7021
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Vincent Shih <vincent.sunplus@gmail.com>,
        gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        davem@davemloft.net, vladimir.oltean@nxp.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, wells.lu@sunplus.com
Date:   Fri, 29 Apr 2022 14:07:08 +0200
In-Reply-To: <1651220876-26705-2-git-send-email-vincent.sunplus@gmail.com>
References: <1651220876-26705-1-git-send-email-vincent.sunplus@gmail.com>
         <1651220876-26705-2-git-send-email-vincent.sunplus@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On Fr, 2022-04-29 at 16:27 +0800, Vincent Shih wrote:
[...]
> +static int sp_ehci_platform_power_on(struct platform_device *pdev)
> +{
> +	struct usb_hcd *hcd = platform_get_drvdata(pdev);
> +	struct sp_ehci_priv *sp_priv = hcd_to_sp_ehci_priv(hcd);
> +	int ret;
> +
> +	ret = clk_prepare_enable(sp_priv->ehci_clk);
> +	if (ret)
> +		goto err_ehci_clk;

This should be:

		return ret;

> +
> +	ret = reset_control_deassert(sp_priv->ehci_rstc);
> +	if (ret)
> +		goto err_ehci_reset;

And this should be:

		goto err_ehci_clk;

> +
> +	ret = phy_init(sp_priv->phy);
> +	if (ret)
> +		goto err_ehci_reset;
> +
> +	ret = phy_power_on(sp_priv->phy);
> +	if (ret)
> +		goto err_phy_exit;
> +
> +	return 0;
> +
> +err_phy_exit:
> +	phy_exit(sp_priv->phy);
> +err_ehci_reset:
> +	reset_control_assert(sp_priv->ehci_rstc);
> +err_ehci_clk:
> +	clk_disable_unprepare(sp_priv->ehci_clk);
> +
> +	return ret;
> +}
> +
> +static void sp_ehci_platform_power_off(struct platform_device *pdev)
> +{
> +	struct usb_hcd *hcd = platform_get_drvdata(pdev);
> +	struct sp_ehci_priv *sp_priv = hcd_to_sp_ehci_priv(hcd);
> +
> +	phy_power_off(sp_priv->phy);
> +	phy_exit(sp_priv->phy);
> +
> +	reset_control_assert(sp_priv->ehci_rstc);
> +	clk_disable_unprepare(sp_priv->ehci_clk);
> +}
> +
> +static struct usb_ehci_pdata usb_ehci_pdata = {
> +	.has_tt = 1,
> +	.has_synopsys_hc_bug = 1,
> +	.big_endian_desc = 1,
> +	.big_endian_mmio = 1,
> +	.power_on = sp_ehci_platform_power_on,
> +	.power_suspend = sp_ehci_platform_power_off,
> +	.power_off = sp_ehci_platform_power_off,
> +

Superfluous whitespace.


regards
Philipp
