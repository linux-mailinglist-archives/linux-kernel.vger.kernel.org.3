Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D160585792
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 02:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbiG3Akp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 20:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbiG3Akk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 20:40:40 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 29 Jul 2022 17:40:39 PDT
Received: from alln-iport-3.cisco.com (alln-iport-3.cisco.com [173.37.142.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C99625C73
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 17:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2106; q=dns/txt; s=iport;
  t=1659141639; x=1660351239;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QYUIQiqKa5aMGkZG2v4BRtLfqtbRnJ1ee+zluUbrc1c=;
  b=aSKobH8VmTz0bNouPIuwVSp5Q6IOvPiDm9HdAZAkM/280fS3T8bsVXiw
   niaIPm8CBY6OI0pIK6jKcMc32JVZnQEp6ZDlaLPP2IkKdW8aIOiNbuF94
   nz6FQMErGGl/Wdt8vU6rW78LuHv2hnGlUd9pi7ZGzNbsY9YBZ4LycXj3T
   U=;
X-IronPort-AV: E=Sophos;i="5.93,202,1654560000"; 
   d="scan'208";a="916105308"
Received: from alln-core-8.cisco.com ([173.36.13.141])
  by alln-iport-3.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 30 Jul 2022 00:39:36 +0000
Received: from localhost.localdomain (sjc-balsup-nitro2.cisco.com [10.19.202.195])
        (authenticated bits=0)
        by alln-core-8.cisco.com (8.15.2/8.15.2) with ESMTPSA id 26U0dPCQ020109
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 30 Jul 2022 00:39:33 GMT
From:   Billie Alsup <balsup@cisco.com>
To:     balsup@cisco.com, linux@armlinux.org.uk, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, arnd@arndb.de,
        linus.walleij@linaro.org, ardb@kernel.org,
        rmk+kernel@armlinux.org.uk, rostedt@goodmis.org,
        nick.hawkins@hpe.com, john@phrozen.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Allow configuration of ARCH_NR_GPIO
Date:   Fri, 29 Jul 2022 17:38:46 -0700
Message-Id: <20220730003846.1730265-1-balsup@cisco.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: balsup@cisco.com
X-Outbound-SMTP-Client: 10.19.202.195, sjc-balsup-nitro2.cisco.com
X-Outbound-Node: alln-core-8.cisco.com
X-Spam-Status: No, score=-12.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Billie R Alsup <balsup@cisco.com>

Problem: Some systems support a high number of GPIO pins.  Allow
the kernel builder to configure the maximum number of pins, rather
than forcing a large value on everyone.

Impact: Once a .config is generated, the ARCH_NR_GPIO setting
will persist.  To return to a default setting, the CONFIG_ARCH_NR_GPIO
must be removed from .config file first.

Trade-offs: It is possible to achieve similar via command line
parameters, e.g.

    make KBUILD_CFLAGS_KERNEL=-DARCH_NR_GPIOS=16384

to the build. This is problematic because the setting does not
show up in /proc/config.gz.  It is also problematic for out-of-tree
module builds, which require similar if they invoke the API
gpio_is_valid().  In both cases, one could envision one system
working normally, and another failing, even though they both have
the same kernel version and /proc/config.gz.  Therefore, it is
better to have the setting available in .config

Signed-off-by: Billie R Alsup <balsup@cisco.com>
---
 arch/arm/Kconfig | 2 +-
 arch/x86/Kconfig | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 7630ba9cb6cc..7fc6e52d1d3c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1226,7 +1226,7 @@ config ARM_PSCI
 # a multiplatform kernel, we just want the highest value required by the
 # selected platforms.
 config ARCH_NR_GPIO
-	int
+	int "Maximum number of GPIOs supported"
 	default 2048 if ARCH_INTEL_SOCFPGA
 	default 1024 if ARCH_BRCMSTB || ARCH_RENESAS || ARCH_TEGRA || \
 		ARCH_ZYNQ || ARCH_ASPEED
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 52a7f91527fe..a59cef517f56 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -347,9 +347,13 @@ config ARCH_HIBERNATION_POSSIBLE
 	def_bool y
 
 config ARCH_NR_GPIO
-	int
+	int "Maximum number of GPIOs supported"
 	default 1024 if X86_64
 	default 512
+	help
+	  Maximum number of GPIOs in the system.
+
+	  If unsure, leave the default value.
 
 config ARCH_SUSPEND_POSSIBLE
 	def_bool y
-- 
2.27.0

