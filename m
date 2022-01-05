Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4CA485837
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 19:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242924AbiAES3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 13:29:53 -0500
Received: from aposti.net ([89.234.176.197]:41636 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242911AbiAES3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 13:29:47 -0500
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
Subject: [PATCH v2 0/6] DEV_PM_OPS macros rework v2
Date:   Wed,  5 Jan 2022 18:29:33 +0000
Message-Id: <20220105182939.106885-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A V2 of my patchset that tweaks a bit the *_DEV_PM_OPS() macros that
were introduced recently.

Changes since V1:
- Previous patches [2/8], [6/8] and [7/8] were merged together to [2/6]
  to create an atomic patch.
- Remove useless empty line in patch [3/8] (now [3/6])
- Remove the patch that updated the mpu3050 driver, since it wasn't a
  very good example.
- Update the bmp280 pressure sensor driver to use
  EXPORT_RUNTIME_DEV_PM_OPS(), which should be a much better showcase
  than the mpu3050.

Cheers,
-Paul

Paul Cercueil (6):
  PM: core: Remove DEFINE_UNIVERSAL_DEV_PM_OPS() macro
  PM: core: Remove static qualifier in DEFINE_SIMPLE_DEV_PM_OPS macro
  PM: core: Add EXPORT[_GPL]_SIMPLE_DEV_PM_OPS macros
  PM: runtime: Add DEFINE_RUNTIME_DEV_PM_OPS() macro
  PM: runtime: Add EXPORT[_GPL]_RUNTIME_DEV_PM_OPS macros
  iio: pressure: bmp280: Use new PM macros

 drivers/iio/pressure/bmp280-core.c | 11 ++-----
 drivers/iio/pressure/bmp280-i2c.c  |  2 +-
 drivers/iio/pressure/bmp280-spi.c  |  2 +-
 drivers/mmc/host/jz4740_mmc.c      |  4 +--
 drivers/mmc/host/mxcmmc.c          |  2 +-
 include/linux/pm.h                 | 52 +++++++++++++++++++++---------
 include/linux/pm_runtime.h         | 21 ++++++++++++
 7 files changed, 65 insertions(+), 29 deletions(-)

-- 
2.34.1

