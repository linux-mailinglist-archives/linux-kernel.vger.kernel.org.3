Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B954A9BEE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 16:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359689AbiBDP1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 10:27:11 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33730 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbiBDP1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 10:27:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 600BCB837D5
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 15:27:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 678B8C004E1;
        Fri,  4 Feb 2022 15:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643988428;
        bh=IMwctsXQRVAziVU+Y+/aiMWOA8ESCllASrr1nobYs4g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DvXWugoiPeQJMgkUorhuvQ/oxPoNm1KElruWYNTIKqFy05iHs5WKtvuOhbIIsrr8g
         KpKb4GKWGXteGEmmAKDy03iKnsjl2P2OALlzOPyo3fT11u30y687M6ble6LoD/u4lE
         SDleNjQgk5Oa4Id8TIM8kRNL7tf2Ro+hSO2Bagc8=
Date:   Fri, 4 Feb 2022 16:27:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sami =?iso-8859-1?Q?Ky=F6stil=E4?= <skyostil@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, dtor@chromium.org,
        arnd@arndb.de, evanbenn@chromium.org
Subject: Re: [PATCH v2 1/1] drivers/misc: add a driver for HPS
Message-ID: <Yf1FySKp9bdbVNah@kroah.com>
References: <20220202044937.3187603-1-skyostil@chromium.org>
 <20220202044937.3187603-2-skyostil@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220202044937.3187603-2-skyostil@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 03:49:37PM +1100, Sami Kyöstilä wrote:
> This patch introduces a driver for the ChromeOS screen privacy
> sensor (aka. HPS). The driver supports a sensor connected to the I2C bus
> and identified as "GOOG0020" in the ACPI tables.
> 
> When loaded, the driver exports the sensor to userspace through a
> character device. This device only supports power management, i.e.,
> communication with the sensor must be done through regular I2C
> transmissions from userspace.
> 
> Power management is implemented by enabling the respective power GPIO
> while at least one userspace process holds an open fd on the character
> device. By default, the device is powered down if there are no active
> clients.
> 
> Note that the driver makes no effort to preserve the state of the sensor
> between power down and power up events. Userspace is responsible for
> reinitializing any needed state once power has been restored.
> 
> The device firmware, I2C protocol and other documentation is available
> at https://chromium.googlesource.com/chromiumos/platform/hps-firmware.
> 
> Signed-off-by: Sami Kyöstilä <skyostil@chromium.org>
> ---
> 
> Changes in v2:
> - Removed custom ioctl interface.
> - Reworked to use miscdev.
> 
>  MAINTAINERS            |   6 ++
>  drivers/misc/Kconfig   |  10 +++
>  drivers/misc/Makefile  |   1 +
>  drivers/misc/hps-i2c.c | 184 +++++++++++++++++++++++++++++++++++++++++

Why isn't this in drivers/platform/chrome/ instead?

And what can you do with this hardware when it is enabled?  What
userspace tool uses it?

thanks,

greg k-h
