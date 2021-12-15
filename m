Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8341047629A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 21:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbhLOUGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 15:06:10 -0500
Received: from polaris.svanheule.net ([84.16.241.116]:48978 "EHLO
        polaris.svanheule.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhLOUGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 15:06:10 -0500
Received: from mars.. (unknown [IPv6:2a02:a03f:eafe:c901:b1b8:ded9:465d:f19c])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id EBE1E28197F;
        Wed, 15 Dec 2021 21:06:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1639598768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zwXkMI5QETfIiv404UlgcSE+x8gNpXVjO5/v4Qt9sqo=;
        b=uMeUOkmOtAy1nAl2/DmXaM4kwAmebrFxqPggKHrbCxz6FQ4YMt0Fkn+P+R/+xfmT9wgkU/
        oezCn+/1ssp3EXwuyiQHVVnQRQIxMIJbK4ZO6R/i5LysAwfE/B8RuhSJcdZf50vF3Cy5Se
        PBeZceK0A+++lLR0keT58CVs5m3nQ8KA2/282U4jqqy+WNctgVrg1RvKb4jFdJ9QNNH04Z
        VXt32O1K+/7CSiF329+2iJNfIlqOhlIJrEh1oMOlA1OP637CMhXE+Ex895SklgJTzsB0rP
        W+t36g1n/n9S0vLw2FvZTeNV/1rGOEg0UrI0T2rqPdBgP3zDAPw7sgI2gph1SA==
From:   Sander Vanheule <sander@svanheule.net>
To:     linux-mips@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org,
        Sander Vanheule <sander@svanheule.net>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Bert Vermeulen <bert@biot.com>
Subject: [PATCH] MIPS: drop selected EARLY_PRINTK configs for MACH_REALTEK_RTL
Date:   Wed, 15 Dec 2021 21:06:02 +0100
Message-Id: <20211215200602.6546-1-sander@svanheule.net>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MACH_REALTEK_RTL declares that the system supports early printk , but
this is not actually implemented as intended. The system is left with a
non-functional early0 console because the setup_8250_early_printk_port()
call provided for MIPS_GENERIC is never used to set this up. Generic
ns16550a earlycon works, so devices should use that for early output.
This means that SYS_HAS_EARLY_PRINTK and USE_GENERIC_EARLY_PRINTK_8250
do not need to be selected.

Additionally, as reported by Lukas Bulwahn, the selected symbol
SYS_HAS_EARLY_PRINTK_8250 does not actually exist, so should also be
dropped.

Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Bert Vermeulen <bert@biot.com>
Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
 arch/mips/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 63eb66a22691..9a3a2330fc69 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -642,9 +642,6 @@ config MACH_REALTEK_RTL
 	select SYS_SUPPORTS_MIPS16
 	select SYS_SUPPORTS_MULTITHREADING
 	select SYS_SUPPORTS_VPE_LOADER
-	select SYS_HAS_EARLY_PRINTK
-	select SYS_HAS_EARLY_PRINTK_8250
-	select USE_GENERIC_EARLY_PRINTK_8250
 	select BOOT_RAW
 	select PINCTRL
 	select USE_OF
-- 
2.33.1

