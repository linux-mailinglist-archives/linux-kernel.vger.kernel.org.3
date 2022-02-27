Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33DE54C5CC9
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 17:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbiB0QI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 11:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbiB0QIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 11:08:25 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 69B5F219F
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 08:07:38 -0800 (PST)
Received: (qmail 1134330 invoked by uid 1000); 27 Feb 2022 11:07:37 -0500
Date:   Sun, 27 Feb 2022 11:07:37 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Vincent Shih <vincent.sunplus@gmail.com>
Cc:     gregkh@linuxfoundation.org, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        wells.lu@sunplus.com
Subject: Re: [PATCH v2 1/2] usb: host: ehci-sunplus: Add driver for ehci in
 Sunplus SP7021
Message-ID: <YhuhyXSg4nO0k7Uq@rowland.harvard.edu>
References: <1645955441-6496-1-git-send-email-vincent.sunplus@gmail.com>
 <1645955441-6496-2-git-send-email-vincent.sunplus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1645955441-6496-2-git-send-email-vincent.sunplus@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 27, 2022 at 05:50:40PM +0800, Vincent Shih wrote:
> Add driver for ehci in Sunplus SP7021
> 
> Signed-off-by: Vincent Shih <vincent.sunplus@gmail.com>
> ---

> +static struct usb_ehci_pdata usb_ehci_pdata = {
> +};
> +
> +static int ehci_sunplus_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct sp_ehci_priv *sp_priv;
> +	struct resource *res_mem;
> +	struct usb_hcd *hcd;
> +	int irq, ret;
> +
> +	if (usb_disabled())
> +		return -ENODEV;
> +
> +	pdev->dev.platform_data = &usb_ehci_pdata;

What reason is there for doing this?  I can't see any justification for 
storing a pointer to data that contains nothing but zeros.

Alan Stern
