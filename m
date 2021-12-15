Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1884D475A48
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 15:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243162AbhLOOFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 09:05:33 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43976 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237761AbhLOOFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 09:05:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09392B81F22;
        Wed, 15 Dec 2021 14:05:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59DAC34604;
        Wed, 15 Dec 2021 14:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639577129;
        bh=/Q1+Yl+os6xMFdaAa25nXA7C/WN0tlvptnF2rFLIH7g=;
        h=From:To:Cc:Subject:Date:From;
        b=Plcdc4sfEezjytn2y1IKZAlVONOTRIEGFT8D4FdgF3BwflWCJ2DOjVKMzZbcxuTgS
         0l/l0yRxmrqYsEzGGor+SlYcD/pLVk6AmMrH4QLQ7HAFdEGXVY4sUNGqdRTxPohzic
         qHSqtntSWi6McgMIQTK5lKI/DoZjlNVbqjxJwuDq8asx+vEx44198EeL1ChrcV9k6F
         d7r5UYE7mmafXyurKO8JqaCj1E1qeZLJKM2gePiEIN+XqZvck24FjZv29ioVSouzod
         W51J+6t/5j2e0kPM43Lv8YbKFj4p/e8vSzh250tPzewC8Ca0cADw/PyicLEe+P94Gd
         /ipjrHU/aZNww==
From:   Arnd Bergmann <arnd@kernel.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Dong Aisheng <aisheng.dong@nxp.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PM / devfreq: sun8i: addd COMMON_CLK dependency
Date:   Wed, 15 Dec 2021 15:03:09 +0100
Message-Id: <20211215140523.481425-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Compile-testing the driver without CONFIG_COMMON_CLK causes
a link failure:

arm-linux-gnueabi-ld: drivers/devfreq/sun8i-a33-mbus.o: in function `sun8i_a33_mbus_remove':
sun8i-a33-mbus.c:(.text+0x450): undefined reference to `clk_rate_exclusive_put'
arm-linux-gnueabi-ld: sun8i-a33-mbus.c:(.text+0x460): undefined reference to `clk_rate_exclusive_put'
arm-linux-gnueabi-ld: drivers/devfreq/sun8i-a33-mbus.o: in function `sun8i_a33_mbus_probe':
sun8i-a33-mbus.c:(.text+0x85c): undefined reference to `clk_rate_exclusive_get'
arm-linux-gnueabi-ld: sun8i-a33-mbus.c:(.text+0x878): undefined reference to `clk_rate_exclusive_get'

Fixes: 8bfd4858b4bb ("PM / devfreq: Add a driver for the sun8i/sun50i MBUS")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/devfreq/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index b94eb04761f6..87eb2b837e68 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -135,6 +135,7 @@ config ARM_RK3399_DMC_DEVFREQ
 config ARM_SUN8I_A33_MBUS_DEVFREQ
 	tristate "sun8i/sun50i MBUS DEVFREQ Driver"
 	depends on ARCH_SUNXI || COMPILE_TEST
+	depends on COMMON_CLK
 	select DEVFREQ_GOV_SIMPLE_ONDEMAND
 	help
 	  This adds the DEVFREQ driver for the MBUS controller in some
-- 
2.29.2

