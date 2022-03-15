Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140BC4D9D97
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 15:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349195AbiCOObl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 10:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241818AbiCOObk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 10:31:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE36954FA5;
        Tue, 15 Mar 2022 07:30:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B5FD60C03;
        Tue, 15 Mar 2022 14:30:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E51C340E8;
        Tue, 15 Mar 2022 14:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647354627;
        bh=qn40PxdprBVCzXkn3epsHFdxxB8KZMbmh7d5IAVdaUo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uOazfgLJCw4W0MGwYP9/uXu5w1/mb6AAPrFCqWGxYaudvPtvJdNyEr1Pt1GWx7Yxb
         wjv2kfvC9y7VTq3O5ES6GCWa2l82rTodrd/mcacsbNlqQhxjgpEaK2+e67CYl99sx2
         nZdM3OZfosKXHu5ZfBzle3Y1QlELhKEHsRyMS+6Q=
Date:   Tue, 15 Mar 2022 15:30:21 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     frank zago <frank@zago.net>
Cc:     linux-kernel@vger.kernel.org,
        Jan-Niklas Burfeind <kernel@aiyionpri.me>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Wolfram Sang <wsa@kernel.org>, Johan Hovold <johan@kernel.org>,
        linux-usb@vger.kernel.org, gunar@schorcht.net,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3] mfd: ch341: add driver for the WCH CH341 in I2C/GPIO
 mode
Message-ID: <YjCi/cRY51tYUowD@kroah.com>
References: <20220314030937.22762-1-frank@zago.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314030937.22762-1-frank@zago.net>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 13, 2022 at 10:09:37PM -0500, frank zago wrote:
> +static int ch341_usb_probe(struct usb_interface *iface,
> +			   const struct usb_device_id *usb_id)
> +{
> +	struct usb_host_endpoint *endpoints;
> +	struct ch341_device *dev;
> +	int rc;
> +
> +	dev = kzalloc(sizeof(struct ch341_device), GFP_KERNEL);
> +	if (!dev)
> +		return -ENOMEM;
> +
> +	dev->usb_dev = usb_get_dev(interface_to_usbdev(iface));
> +	dev->iface = iface;
> +	mutex_init(&dev->usb_lock);
> +
> +	if (iface->cur_altsetting->desc.bNumEndpoints != 3) {
> +		rc = -EIO;

-ENODEV is the proper one here.

> +		goto free_dev;
> +	}
> +
> +	endpoints = iface->cur_altsetting->endpoint;
> +	if (!usb_endpoint_is_bulk_in(&endpoints[0].desc) ||
> +	    !usb_endpoint_is_bulk_out(&endpoints[1].desc) ||
> +	    !usb_endpoint_xfer_int(&endpoints[2].desc)) {
> +		rc = -EIO;

Same here.

thanks,

greg k-h
