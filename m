Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30735A7782
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 09:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbiHaHat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 03:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiHaHan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 03:30:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A362865276;
        Wed, 31 Aug 2022 00:30:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60519B81F59;
        Wed, 31 Aug 2022 07:30:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837B6C433C1;
        Wed, 31 Aug 2022 07:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661931038;
        bh=O0rPw8Oihaz4yR+43b4ZmSmPtj+BredqtoyyQMI4C2Y=;
        h=From:To:Cc:Subject:Date:From;
        b=TK8dakXDG2+vKT3sCKygQduTtkrc1DQ60DU3BQMLwG4t407IwBEynrsGRrPxIqXrn
         f2zH67/O7+fkn4DCSNDgdRfBXiapmHK9ud2mO3s0xOdJk+LL7BsgmnCcFJE13qP0ip
         Aw1I3ZKYypDb3S/19LxejwwcNl5Eo7OOxfcQJgjA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-usb@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel test robot <lkp@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] USB: hcd: remove unused hcd_name variables
Date:   Wed, 31 Aug 2022 09:30:32 +0200
Message-Id: <20220831073032.1409291-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2490; i=gregkh@linuxfoundation.org; h=from:subject; bh=O0rPw8Oihaz4yR+43b4ZmSmPtj+BredqtoyyQMI4C2Y=; b=owGbwMvMwCRo6H6F97bub03G02pJDMn8fGK3/50x2i5lMetzz10Oq0kB0/IVWhxYD1ZV1TOaKT+K bu7uiGVhEGRikBVTZPmyjefo/opDil6Gtqdh5rAygQxh4OIUgIksvcQwP7N19a74T/alykKrJbmF0i b9VDOcyjDPpnmy2tsYtw9T7ZqilzEKZmsKr84BAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the commit 10174220f55a ("usb: reduce kernel log spam on driver
registration") a lot of unneeded kernel log messages were removed, but
that caused a few build warnings to show up where the variable
`hcd_name` was being set but never used anymore.

Resolve this by just removing these variables as they are not needed
anymore

Reported-by: kernel test robot <lkp@intel.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>
Cc: Rob Herring <robh@kernel.org>
Cc: linux-usb@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Fixes: 10174220f55a ("usb: reduce kernel log spam on driver registration")
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/ehci-exynos.c   | 1 -
 drivers/usb/host/ehci-platform.c | 2 --
 drivers/usb/host/ohci-platform.c | 2 --
 3 files changed, 5 deletions(-)

diff --git a/drivers/usb/host/ehci-exynos.c b/drivers/usb/host/ehci-exynos.c
index a65e365e3a04..c8e152c2e0ce 100644
--- a/drivers/usb/host/ehci-exynos.c
+++ b/drivers/usb/host/ehci-exynos.c
@@ -32,7 +32,6 @@
 	(EHCI_INSNREG00_ENA_INCR16 | EHCI_INSNREG00_ENA_INCR8 |	\
 	 EHCI_INSNREG00_ENA_INCR4 | EHCI_INSNREG00_ENA_INCRX_ALIGN)
 
-static const char hcd_name[] = "ehci-exynos";
 static struct hc_driver __read_mostly exynos_ehci_hc_driver;
 
 #define PHY_NUMBER 3
diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
index 50491eea9409..fe497c876d76 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -53,8 +53,6 @@ struct ehci_platform_priv {
 	struct delayed_work poll_work;
 };
 
-static const char hcd_name[] = "ehci-platform";
-
 static int ehci_platform_reset(struct usb_hcd *hcd)
 {
 	struct platform_device *pdev = to_platform_device(hcd->self.controller);
diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
index 6d56b52966c7..4e7946024ce7 100644
--- a/drivers/usb/host/ohci-platform.c
+++ b/drivers/usb/host/ohci-platform.c
@@ -41,8 +41,6 @@ struct ohci_platform_priv {
 	struct reset_control *resets;
 };
 
-static const char hcd_name[] = "ohci-platform";
-
 static int ohci_platform_power_on(struct platform_device *dev)
 {
 	struct usb_hcd *hcd = platform_get_drvdata(dev);
-- 
2.37.2

