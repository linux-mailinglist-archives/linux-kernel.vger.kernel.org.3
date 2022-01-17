Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF717490B94
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 16:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240558AbiAQPkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 10:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237314AbiAQPkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 10:40:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7B4C061574;
        Mon, 17 Jan 2022 07:40:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34CD1B810F5;
        Mon, 17 Jan 2022 15:40:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3063FC36AEF;
        Mon, 17 Jan 2022 15:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642434007;
        bh=uX1Nzu6ud1l1C70Ts3ffEy/I1QZlKKPuL/lL0tIjKdQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qYBnWKV4AgjvJESWAfOjRKk5KGWyNBt9fAj+rhJzvIx08u8qTzS9ZGvhlQw+tNG52
         xlX2Ngv7quLX26fT4VYiTAqfPx9n0dM2TJFtIuBIs6lkGiKZryObvKa6jmUA6yw7VF
         BH7oO4EOxnY6XvuazDHedKVCXfYJDT2aiC9ccO9I=
Date:   Mon, 17 Jan 2022 16:40:04 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH V2] usb: common: ulpi: Fix crash in ulpi_match()
Message-ID: <YeWN1Hb0tpjDzn+C@kroah.com>
References: <20220117150039.44058-1-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220117150039.44058-1-jonathanh@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 03:00:39PM +0000, Jon Hunter wrote:
> Commit 7495af930835 ("ARM: multi_v7_defconfig: Enable drivers for
> DragonBoard 410c") enables the CONFIG_PHY_QCOM_USB_HS for the ARM
> multi_v7_defconfig. Enabling this Kconfig is causing the kernel to crash
> on the Tegra20 Ventana platform in the ulpi_match() function.
> 
> The Qualcomm USB HS PHY driver that is enabled by CONFIG_PHY_QCOM_USB_HS,
> registers a ulpi_driver but this driver does not provide an 'id_table',
> so when ulpi_match() is called on the Tegra20 Ventana platform, it
> crashes when attempting to deference the id_table pointer which is not
> valid. The Qualcomm USB HS PHY driver uses device-tree for matching the
> ULPI driver with the device and so fix this crash by using device-tree
> for matching if the id_table is not valid.
> 
> Fixes: ef6a7bcfb01c ("usb: ulpi: Support device discovery via DT")
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>

No cc: of stable since this is a bug going back to 4.11?

thanks,

greg k-h
