Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D917484A09
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 22:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbiADVmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 16:42:24 -0500
Received: from aposti.net ([89.234.176.197]:52028 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233569AbiADVmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 16:42:22 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>, list@opendingux.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pm@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 0/8] DEV_PM_OPS macros rework
Date:   Tue,  4 Jan 2022 21:42:06 +0000
Message-Id: <20220104214214.198843-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This set of commits rework a bit the *_DEV_PM_OPS() macros that were
introduced recently.

- Remove the DEFINE_UNIVERSAL_DEV_PM_OPS() macro, since I highly doubt
  anything is going to use it. The macro it replaces
  (UNIVERSAL_DEV_PM_OPS) seems to only be used incorrectly in code that
  hasn't been updated in ages.

- Remove the static qualifier in DEFINE_SIMPLE_DEV_PM_OPS, so that the
  macro is more in line with what's done elsewhere in the kernel.

- Add a DEFINE_RUNTIME_DEV_PM_OPS() macro, for use with drivers that use
  runtime PM, and use runtime_pm_force_suspend/runtime_pm_force_resume
  as their system sleep callbacks.

- Add EXPORT_*_DEV_PM_OPS macros, which can be used for when the
  underlying dev_pm_ops is to be exported. With CONFIG_PM set, the
  symbol is exported as you would expect. With CONFIG_PM disabled, the
  dev_pm_ops is garbage-collected along with the suspend/resume
  callbacks.

- Update the two places which used DEFINE_SIMPLE_DEV_PM_OPS, to add back
  the "static" qualifier that was stripped from the macro.

- Update one driver to use EXPORT_RUNTIME_DEV_PM_OPS(), just to showcase
  how to use this macro in the case where a dev_pm_ops is to be
  exported.
  Note that the driver itself is GPL, and the symbol is only used within
  a GPL driver, so I would assume the symbol would be exported as GPL.
  But it was not the case in the original code, so I did not change the
  behaviour.

Feedback welcome.

Cheers,
-Paul


Paul Cercueil (8):
  PM: core: Remove DEFINE_UNIVERSAL_DEV_PM_OPS() macro
  PM: core: Remove static qualifier in DEFINE_SIMPLE_DEV_PM_OPS macro
  PM: core: Add EXPORT[_GPL]_SIMPLE_DEV_PM_OPS macros
  PM: runtime: Add DEFINE_RUNTIME_DEV_PM_OPS() macro
  PM: runtime: Add EXPORT[_GPL]_RUNTIME_DEV_PM_OPS macros
  mmc: mxc: Make dev_pm_ops struct static
  mmc: jz4740: Make dev_pm_ops struct static
  iio: gyro: mpu3050: Use new PM macros

 drivers/iio/gyro/mpu3050-core.c | 13 +++-----
 drivers/iio/gyro/mpu3050-i2c.c  |  2 +-
 drivers/mmc/host/jz4740_mmc.c   |  4 +--
 drivers/mmc/host/mxcmmc.c       |  2 +-
 include/linux/pm.h              | 53 +++++++++++++++++++++++----------
 include/linux/pm_runtime.h      | 21 +++++++++++++
 6 files changed, 67 insertions(+), 28 deletions(-)

-- 
2.34.1

