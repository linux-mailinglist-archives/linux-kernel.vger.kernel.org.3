Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B25A7492260
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 10:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345471AbiARJQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 04:16:15 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44070 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240550AbiARJQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 04:16:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78FB7B81256;
        Tue, 18 Jan 2022 09:16:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F23C00446;
        Tue, 18 Jan 2022 09:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642497370;
        bh=HOOeZJnmlX+xWzYaqQwJS/wp3FB2EuV2kUQrtVs5OQ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f9SZH2rN8+DeAbYLS/0Qx9HLYYI17t7gQwaaduyRFKqBcFNf1WSqLi8v4aMTiR2/u
         0M6J5lTUqmk+KNl3YZHxjVitOVGdAph7mGjv/UZKQcbQiWn+gZOy4hP9JhdzleW86p
         QCho4xj48bIHAyj0dCW1bMXBCM5awxkV2X95t3z8=
Date:   Tue, 18 Jan 2022 10:16:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH V2] usb: common: ulpi: Fix crash in ulpi_match()
Message-ID: <YeaFVypshfTRmQvQ@kroah.com>
References: <20220117150039.44058-1-jonathanh@nvidia.com>
 <YeWN1Hb0tpjDzn+C@kroah.com>
 <ae60ab9f-2fd7-b706-3584-ef8ab6bc39de@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae60ab9f-2fd7-b706-3584-ef8ab6bc39de@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 09:02:36AM +0000, Jon Hunter wrote:
> 
> On 17/01/2022 15:40, Greg KH wrote:
> > On Mon, Jan 17, 2022 at 03:00:39PM +0000, Jon Hunter wrote:
> > > Commit 7495af930835 ("ARM: multi_v7_defconfig: Enable drivers for
> > > DragonBoard 410c") enables the CONFIG_PHY_QCOM_USB_HS for the ARM
> > > multi_v7_defconfig. Enabling this Kconfig is causing the kernel to crash
> > > on the Tegra20 Ventana platform in the ulpi_match() function.
> > > 
> > > The Qualcomm USB HS PHY driver that is enabled by CONFIG_PHY_QCOM_USB_HS,
> > > registers a ulpi_driver but this driver does not provide an 'id_table',
> > > so when ulpi_match() is called on the Tegra20 Ventana platform, it
> > > crashes when attempting to deference the id_table pointer which is not
> > > valid. The Qualcomm USB HS PHY driver uses device-tree for matching the
> > > ULPI driver with the device and so fix this crash by using device-tree
> > > for matching if the id_table is not valid.
> > > 
> > > Fixes: ef6a7bcfb01c ("usb: ulpi: Support device discovery via DT")
> > > Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> > 
> > No cc: of stable since this is a bug going back to 4.11?
> 
> 
> Yes good point.
> 
> Heikki, let me know if you want me to resend or if you can add the stable
> tag?

I can add it myself.  I'll do so after 5.17-rc1 is out, when I can apply
things to my tree.

thanks,

greg k-h
