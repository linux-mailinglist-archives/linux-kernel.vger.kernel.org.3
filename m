Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A053C4EAA6A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 11:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbiC2JXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 05:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234605AbiC2JXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 05:23:30 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565C09D0CD
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 02:21:46 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:d553:ff0a:6830:6bde])
        by baptiste.telenet-ops.be with bizsmtp
        id C9Mk2700T49QC44019MkcM; Tue, 29 Mar 2022 11:21:45 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nZ82q-007Ecu-2L; Tue, 29 Mar 2022 11:21:44 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nZ82p-00CBgc-GL; Tue, 29 Mar 2022 11:21:43 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Iwona Winiarska <iwona.winiarska@intel.com>,
        Jason M Bills <jason.m.bills@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Joel Stanley <joel@jms.id.au>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc:     openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] peci: PECI should depend on ARCH_ASPEED
Date:   Tue, 29 Mar 2022 11:21:37 +0200
Message-Id: <f7ea35c723da72a89028da5b976ad417fbd7bf52.1648545587.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Platform Environment Control Interface (PECI) is only available on
Baseboard Management Controllers (BMC) for Intel processors.  Currently
the only supported BMCs are ASpeed BMC SoCs.  Hence add a dependency on
ARCH_ASPEED, to prevent asking the user about the PECI subsystem when
configuring a kernel without ASpeed SoC support.

Fixes: 6523d3b2ffa238ac ("peci: Add core infrastructure")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/peci/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/peci/Kconfig b/drivers/peci/Kconfig
index 89872ad833201510..0d3ef8ba0998d649 100644
--- a/drivers/peci/Kconfig
+++ b/drivers/peci/Kconfig
@@ -2,6 +2,7 @@
 
 menuconfig PECI
 	tristate "PECI support"
+	depends on ARCH_ASPEED || COMPILE_TEST
 	help
 	  The Platform Environment Control Interface (PECI) is an interface
 	  that provides a communication channel to Intel processors and
-- 
2.25.1

