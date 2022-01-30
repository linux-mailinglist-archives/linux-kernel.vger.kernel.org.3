Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5794A3AC1
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 23:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356733AbiA3Wi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 17:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbiA3WiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 17:38:20 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BF5C061714;
        Sun, 30 Jan 2022 14:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=1t/hAfD4sljpm/fYcrJJQBJptypIl3Z3zsM9UZkZOfw=; b=jJTQZfQ/Zwy2norvJ1sOwqR8SC
        MJz7VlMpASnp5vU3HVVBfY7JNZs8AuSl8amkjX1lHeaUuXy8SyyZYyxXZZ89DtwnotKdYgUwpQ66f
        YtdzaTuM3hd9ABp0Cs7UN3BebBupoFueMk/Sxwtw03YJslUQU1Gvvtu5QMd0n1Y3RuEulGr/s281m
        YoercRcVgXmXVbUS47XPxoLsKUtUiyhLj0k6Vz1pIpNcDkoyZTZTaPMIL/+v9b30z4tFbwv2Bq5MI
        GS92WGFRdKxWg87lDMbftcJH8hXQqsQgoDRZUdGoGhIQeaPyCZ3WnOIPb6eYHV+xRwqGqhff15z1b
        wpMpkFRA==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nEIpv-007aLn-Kx; Sun, 30 Jan 2022 22:38:19 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] acpi: require CRC32 to build
Date:   Sun, 30 Jan 2022 14:38:18 -0800
Message-Id: <20220130223818.16985-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI core now requires crc32() but the kernel build can fail when
CRC32 is not set/enabled, so select it in the ACPI Kconfig entry.

Fixes this build error:

ia64-linux-ld: drivers/acpi/scan.o: in function `acpi_store_pld_crc':
include/acpi/platform/aclinuxex.h:62: undefined reference to `crc32_le'

Fixes: 882c982dada4 ("acpi: Store CRC-32 hash of the _PLD in struct acpi_device")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 drivers/acpi/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20220128.orig/drivers/acpi/Kconfig
+++ linux-next-20220128/drivers/acpi/Kconfig
@@ -11,6 +11,7 @@ menuconfig ACPI
 	depends on ARCH_SUPPORTS_ACPI
 	select PNP
 	select NLS
+	select CRC32
 	default y if X86
 	help
 	  Advanced Configuration and Power Interface (ACPI) support for 
