Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF2C4850F5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 11:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239358AbiAEKRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 05:17:44 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4343 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239340AbiAEKRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 05:17:35 -0500
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JTQK409VWz67twb;
        Wed,  5 Jan 2022 18:12:40 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Wed, 5 Jan 2022 11:17:32 +0100
Received: from localhost (10.47.83.118) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Wed, 5 Jan
 2022 10:17:31 +0000
Date:   Wed, 5 Jan 2022 10:17:37 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Paul Cercueil <paul@crapouillou.net>
CC:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Arnd Bergmann" <arnd@arndb.de>, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>, <list@opendingux.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mips@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 0/8] DEV_PM_OPS macros rework
Message-ID: <20220105101737.00000957@Huawei.com>
In-Reply-To: <20220104214214.198843-1-paul@crapouillou.net>
References: <20220104214214.198843-1-paul@crapouillou.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.83.118]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jan 2022 21:42:06 +0000
Paul Cercueil <paul@crapouillou.net> wrote:

> Hi,
> 
> This set of commits rework a bit the *_DEV_PM_OPS() macros that were
> introduced recently.
> 
> - Remove the DEFINE_UNIVERSAL_DEV_PM_OPS() macro, since I highly doubt
>   anything is going to use it. The macro it replaces
>   (UNIVERSAL_DEV_PM_OPS) seems to only be used incorrectly in code that
>   hasn't been updated in ages.
> 
> - Remove the static qualifier in DEFINE_SIMPLE_DEV_PM_OPS, so that the
>   macro is more in line with what's done elsewhere in the kernel.
> 
> - Add a DEFINE_RUNTIME_DEV_PM_OPS() macro, for use with drivers that use
>   runtime PM, and use runtime_pm_force_suspend/runtime_pm_force_resume
>   as their system sleep callbacks.
> 
> - Add EXPORT_*_DEV_PM_OPS macros, which can be used for when the
>   underlying dev_pm_ops is to be exported. With CONFIG_PM set, the
>   symbol is exported as you would expect. With CONFIG_PM disabled, the
>   dev_pm_ops is garbage-collected along with the suspend/resume
>   callbacks.
> 
> - Update the two places which used DEFINE_SIMPLE_DEV_PM_OPS, to add back
>   the "static" qualifier that was stripped from the macro.
> 
> - Update one driver to use EXPORT_RUNTIME_DEV_PM_OPS(), just to showcase
>   how to use this macro in the case where a dev_pm_ops is to be
>   exported.
>   Note that the driver itself is GPL, and the symbol is only used within
>   a GPL driver, so I would assume the symbol would be exported as GPL.
>   But it was not the case in the original code, so I did not change the
>   behaviour.
> 
> Feedback welcome.

Comments on individual patches (in particular bad pick for that final example ;)

Given how late we are in the cycle, I'd argue we 'need' patches 2 (+ 5,6 which
should probably be all one patch to avoid introducing then fixing a warning in
different patches).  The others could wait for the following cycle if needed.

It would slow down a few patches I have queued up behind this, but most of them
would be unaffected so it wouldn't annoy me too much. Can't speak for others
however!

Jonathan

> 
> Cheers,
> -Paul
> 
> 
> Paul Cercueil (8):
>   PM: core: Remove DEFINE_UNIVERSAL_DEV_PM_OPS() macro
>   PM: core: Remove static qualifier in DEFINE_SIMPLE_DEV_PM_OPS macro
>   PM: core: Add EXPORT[_GPL]_SIMPLE_DEV_PM_OPS macros
>   PM: runtime: Add DEFINE_RUNTIME_DEV_PM_OPS() macro
>   PM: runtime: Add EXPORT[_GPL]_RUNTIME_DEV_PM_OPS macros
>   mmc: mxc: Make dev_pm_ops struct static
>   mmc: jz4740: Make dev_pm_ops struct static
>   iio: gyro: mpu3050: Use new PM macros
> 
>  drivers/iio/gyro/mpu3050-core.c | 13 +++-----
>  drivers/iio/gyro/mpu3050-i2c.c  |  2 +-
>  drivers/mmc/host/jz4740_mmc.c   |  4 +--
>  drivers/mmc/host/mxcmmc.c       |  2 +-
>  include/linux/pm.h              | 53 +++++++++++++++++++++++----------
>  include/linux/pm_runtime.h      | 21 +++++++++++++
>  6 files changed, 67 insertions(+), 28 deletions(-)
> 

