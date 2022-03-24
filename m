Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF9E4E5ECA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 07:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242950AbiCXGjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 02:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238142AbiCXGjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 02:39:05 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79810972CF;
        Wed, 23 Mar 2022 23:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648103854; x=1679639854;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=vGnoJXGRL6ujYV30poCK9XvjO9C9pS2+Bxng2MtKLec=;
  b=nGqXrUkN8DOyB5k3F5AV+RC9T8qkdfJLWv6VyxNGlGplKmtLDiKeBfdl
   ozD6LlJ9mn57khQhdubgFVKUCxgPfGt3PCVzD+WPJy2mdGk8WJuyK6OPv
   ENED0GDfiIWz2utIbwIaAlLF1BsB49K1ZMTJOMMWNn1OR+u2l3yY74sDr
   g=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 23 Mar 2022 23:37:34 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 23:37:33 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 23 Mar 2022 23:37:33 -0700
Received: from c-sanm-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 23 Mar 2022 23:37:27 -0700
From:   Sandeep Maheswaram <quic_c_sanm@quicinc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Subject: [PATCH v3 1/3] usb: xhci: refactor quirks and plat private data
Date:   Thu, 24 Mar 2022 12:07:09 +0530
Message-ID: <1648103831-12347-2-git-send-email-quic_c_sanm@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1648103831-12347-1-git-send-email-quic_c_sanm@quicinc.com>
References: <1648103831-12347-1-git-send-email-quic_c_sanm@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavankumar Kondeti <quic_pkondeti@quicinc.com>

This refactoring allows drivers like dwc3 host glue driver to
specify their xhci quirks.

Signed-off-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
---
 drivers/usb/cdns3/host.c        |  2 +-
 drivers/usb/host/xhci-plat.c    |  3 +-
 drivers/usb/host/xhci-plat.h    | 24 ---------------
 drivers/usb/host/xhci-rcar.c    |  3 +-
 drivers/usb/host/xhci.h         | 60 ++++--------------------------------
 include/linux/usb/xhci-plat.h   | 23 ++++++++++++++
 include/linux/usb/xhci-quirks.h | 67 +++++++++++++++++++++++++++++++++++++++++
 7 files changed, 101 insertions(+), 81 deletions(-)
 delete mode 100644 drivers/usb/host/xhci-plat.h
 create mode 100644 include/linux/usb/xhci-plat.h
 create mode 100644 include/linux/usb/xhci-quirks.h

diff --git a/drivers/usb/cdns3/host.c b/drivers/usb/cdns3/host.c
index 9643b90..7fb8049 100644
--- a/drivers/usb/cdns3/host.c
+++ b/drivers/usb/cdns3/host.c
@@ -15,8 +15,8 @@
 #include "drd.h"
 #include "host-export.h"
 #include <linux/usb/hcd.h>
+#include <linux/usb/xhci-plat.h>
 #include "../host/xhci.h"
-#include "../host/xhci-plat.h"
 
 #define XECP_PORT_CAP_REG	0x8000
 #define XECP_AUX_CTRL_REG1	0x8120
diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 649ffd8..601e656 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -19,9 +19,10 @@
 #include <linux/slab.h>
 #include <linux/acpi.h>
 #include <linux/usb/of.h>
+#include <linux/usb/xhci-quirks.h>
+#include <linux/usb/xhci-plat.h>
 
 #include "xhci.h"
-#include "xhci-plat.h"
 #include "xhci-mvebu.h"
 #include "xhci-rcar.h"
 
diff --git a/drivers/usb/host/xhci-plat.h b/drivers/usb/host/xhci-plat.h
deleted file mode 100644
index 1fb149d..0000000
--- a/drivers/usb/host/xhci-plat.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * xhci-plat.h - xHCI host controller driver platform Bus Glue.
- *
- * Copyright (C) 2015 Renesas Electronics Corporation
- */
-
-#ifndef _XHCI_PLAT_H
-#define _XHCI_PLAT_H
-
-#include "xhci.h"	/* for hcd_to_xhci() */
-
-struct xhci_plat_priv {
-	const char *firmware_name;
-	unsigned long long quirks;
-	void (*plat_start)(struct usb_hcd *);
-	int (*init_quirk)(struct usb_hcd *);
-	int (*suspend_quirk)(struct usb_hcd *);
-	int (*resume_quirk)(struct usb_hcd *);
-};
-
-#define hcd_to_xhci_priv(h) ((struct xhci_plat_priv *)hcd_to_xhci(h)->priv)
-#define xhci_to_priv(x) ((struct xhci_plat_priv *)(x)->priv)
-#endif	/* _XHCI_PLAT_H */
diff --git a/drivers/usb/host/xhci-rcar.c b/drivers/usb/host/xhci-rcar.c
index aef0258..18d3272 100644
--- a/drivers/usb/host/xhci-rcar.c
+++ b/drivers/usb/host/xhci-rcar.c
@@ -12,9 +12,10 @@
 #include <linux/of.h>
 #include <linux/usb/phy.h>
 #include <linux/sys_soc.h>
+#include <linux/usb/xhci-quirks.h>
+#include <linux/usb/xhci-plat.h>
 
 #include "xhci.h"
-#include "xhci-plat.h"
 #include "xhci-rcar.h"
 
 /*
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 473a33c..ae400da 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -17,6 +17,8 @@
 #include <linux/kernel.h>
 #include <linux/usb/hcd.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/usb/xhci-quirks.h>
+#include <linux/usb/xhci-plat.h>
 
 /* Code sharing between pci-quirks and xhci hcd */
 #include	"xhci-ext-caps.h"
@@ -1847,60 +1849,6 @@ struct xhci_hcd {
 #define XHCI_STATE_HALTED	(1 << 1)
 #define XHCI_STATE_REMOVING	(1 << 2)
 	unsigned long long	quirks;
-#define	XHCI_LINK_TRB_QUIRK	BIT_ULL(0)
-#define XHCI_RESET_EP_QUIRK	BIT_ULL(1)
-#define XHCI_NEC_HOST		BIT_ULL(2)
-#define XHCI_AMD_PLL_FIX	BIT_ULL(3)
-#define XHCI_SPURIOUS_SUCCESS	BIT_ULL(4)
-/*
- * Certain Intel host controllers have a limit to the number of endpoint
- * contexts they can handle.  Ideally, they would signal that they can't handle
- * anymore endpoint contexts by returning a Resource Error for the Configure
- * Endpoint command, but they don't.  Instead they expect software to keep track
- * of the number of active endpoints for them, across configure endpoint
- * commands, reset device commands, disable slot commands, and address device
- * commands.
- */
-#define XHCI_EP_LIMIT_QUIRK	BIT_ULL(5)
-#define XHCI_BROKEN_MSI		BIT_ULL(6)
-#define XHCI_RESET_ON_RESUME	BIT_ULL(7)
-#define	XHCI_SW_BW_CHECKING	BIT_ULL(8)
-#define XHCI_AMD_0x96_HOST	BIT_ULL(9)
-#define XHCI_TRUST_TX_LENGTH	BIT_ULL(10)
-#define XHCI_LPM_SUPPORT	BIT_ULL(11)
-#define XHCI_INTEL_HOST		BIT_ULL(12)
-#define XHCI_SPURIOUS_REBOOT	BIT_ULL(13)
-#define XHCI_COMP_MODE_QUIRK	BIT_ULL(14)
-#define XHCI_AVOID_BEI		BIT_ULL(15)
-#define XHCI_PLAT		BIT_ULL(16)
-#define XHCI_SLOW_SUSPEND	BIT_ULL(17)
-#define XHCI_SPURIOUS_WAKEUP	BIT_ULL(18)
-/* For controllers with a broken beyond repair streams implementation */
-#define XHCI_BROKEN_STREAMS	BIT_ULL(19)
-#define XHCI_PME_STUCK_QUIRK	BIT_ULL(20)
-#define XHCI_MTK_HOST		BIT_ULL(21)
-#define XHCI_SSIC_PORT_UNUSED	BIT_ULL(22)
-#define XHCI_NO_64BIT_SUPPORT	BIT_ULL(23)
-#define XHCI_MISSING_CAS	BIT_ULL(24)
-/* For controller with a broken Port Disable implementation */
-#define XHCI_BROKEN_PORT_PED	BIT_ULL(25)
-#define XHCI_LIMIT_ENDPOINT_INTERVAL_7	BIT_ULL(26)
-#define XHCI_U2_DISABLE_WAKE	BIT_ULL(27)
-#define XHCI_ASMEDIA_MODIFY_FLOWCONTROL	BIT_ULL(28)
-#define XHCI_HW_LPM_DISABLE	BIT_ULL(29)
-#define XHCI_SUSPEND_DELAY	BIT_ULL(30)
-#define XHCI_INTEL_USB_ROLE_SW	BIT_ULL(31)
-#define XHCI_ZERO_64B_REGS	BIT_ULL(32)
-#define XHCI_DEFAULT_PM_RUNTIME_ALLOW	BIT_ULL(33)
-#define XHCI_RESET_PLL_ON_DISCONNECT	BIT_ULL(34)
-#define XHCI_SNPS_BROKEN_SUSPEND    BIT_ULL(35)
-#define XHCI_RENESAS_FW_QUIRK	BIT_ULL(36)
-#define XHCI_SKIP_PHY_INIT	BIT_ULL(37)
-#define XHCI_DISABLE_SPARSE	BIT_ULL(38)
-#define XHCI_SG_TRB_CACHE_SIZE_QUIRK	BIT_ULL(39)
-#define XHCI_NO_SOFT_RETRY	BIT_ULL(40)
-#define XHCI_BROKEN_D3COLD	BIT_ULL(41)
-#define XHCI_EP_CTX_BROKEN_DCS	BIT_ULL(42)
 
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
@@ -1966,6 +1914,10 @@ static inline struct usb_hcd *xhci_to_hcd(struct xhci_hcd *xhci)
 	return xhci->main_hcd;
 }
 
+/* For xhci-plat drivers */
+#define hcd_to_xhci_priv(h) ((struct xhci_plat_priv *)hcd_to_xhci(h)->priv)
+#define xhci_to_priv(x) ((struct xhci_plat_priv *)(x)->priv)
+
 #define xhci_dbg(xhci, fmt, args...) \
 	dev_dbg(xhci_to_hcd(xhci)->self.controller , fmt , ## args)
 #define xhci_err(xhci, fmt, args...) \
diff --git a/include/linux/usb/xhci-plat.h b/include/linux/usb/xhci-plat.h
new file mode 100644
index 0000000..906e907
--- /dev/null
+++ b/include/linux/usb/xhci-plat.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * xhci-plat.h - xHCI host controller driver platform Bus Glue.
+ *
+ * Copyright (C) 2015 Renesas Electronics Corporation
+ */
+
+#ifndef _XHCI_PLAT_H
+#define _XHCI_PLAT_H
+
+#include <linux/types.h>
+#include <linux/usb/hcd.h>
+
+struct xhci_plat_priv {
+	const char *firmware_name;
+	unsigned long long quirks;
+	void (*plat_start)(struct usb_hcd *hcd);
+	int (*init_quirk)(struct usb_hcd *hcd);
+	int (*suspend_quirk)(struct usb_hcd *hcd);
+	int (*resume_quirk)(struct usb_hcd *hcd);
+};
+
+#endif	/* _XHCI_PLAT_H */
diff --git a/include/linux/usb/xhci-quirks.h b/include/linux/usb/xhci-quirks.h
new file mode 100644
index 0000000..57ae0b1
--- /dev/null
+++ b/include/linux/usb/xhci-quirks.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * xHCI host controller driver quirks
+ *
+ * Copyright (C) 2008 Intel Corp.
+ */
+
+#ifndef _XHCI_QUIRKS_H
+#define _XHCI_QUIRKS_H
+
+#define XHCI_LINK_TRB_QUIRK	BIT_ULL(0)
+#define XHCI_RESET_EP_QUIRK	BIT_ULL(1)
+#define XHCI_NEC_HOST		BIT_ULL(2)
+#define XHCI_AMD_PLL_FIX	BIT_ULL(3)
+#define XHCI_SPURIOUS_SUCCESS	BIT_ULL(4)
+/*
+ * Certain Intel host controllers have a limit to the number of endpoint
+ * contexts they can handle.  Ideally, they would signal that they can't handle
+ * anymore endpoint contexts by returning a Resource Error for the Configure
+ * Endpoint command, but they don't.  Instead they expect software to keep track
+ * of the number of active endpoints for them, across configure endpoint
+ * commands, reset device commands, disable slot commands, and address device
+ * commands.
+ */
+#define XHCI_EP_LIMIT_QUIRK	BIT_ULL(5)
+#define XHCI_BROKEN_MSI		BIT_ULL(6)
+#define XHCI_RESET_ON_RESUME	BIT_ULL(7)
+#define XHCI_SW_BW_CHECKING	BIT_ULL(8)
+#define XHCI_AMD_0x96_HOST	BIT_ULL(9)
+#define XHCI_TRUST_TX_LENGTH	BIT_ULL(10)
+#define XHCI_LPM_SUPPORT	BIT_ULL(11)
+#define XHCI_INTEL_HOST		BIT_ULL(12)
+#define XHCI_SPURIOUS_REBOOT	BIT_ULL(13)
+#define XHCI_COMP_MODE_QUIRK	BIT_ULL(14)
+#define XHCI_AVOID_BEI		BIT_ULL(15)
+#define XHCI_PLAT		BIT_ULL(16)
+#define XHCI_SLOW_SUSPEND	BIT_ULL(17)
+#define XHCI_SPURIOUS_WAKEUP	BIT_ULL(18)
+/* For controllers with a broken beyond repair streams implementation */
+#define XHCI_BROKEN_STREAMS	BIT_ULL(19)
+#define XHCI_PME_STUCK_QUIRK	BIT_ULL(20)
+#define XHCI_MTK_HOST		BIT_ULL(21)
+#define XHCI_SSIC_PORT_UNUSED	BIT_ULL(22)
+#define XHCI_NO_64BIT_SUPPORT	BIT_ULL(23)
+#define XHCI_MISSING_CAS	BIT_ULL(24)
+/* For controller with a broken Port Disable implementation */
+#define XHCI_BROKEN_PORT_PED	BIT_ULL(25)
+#define XHCI_LIMIT_ENDPOINT_INTERVAL_7	BIT_ULL(26)
+#define XHCI_U2_DISABLE_WAKE	BIT_ULL(27)
+#define XHCI_ASMEDIA_MODIFY_FLOWCONTROL	BIT_ULL(28)
+#define XHCI_HW_LPM_DISABLE	BIT_ULL(29)
+#define XHCI_SUSPEND_DELAY	BIT_ULL(30)
+#define XHCI_INTEL_USB_ROLE_SW	BIT_ULL(31)
+#define XHCI_ZERO_64B_REGS	BIT_ULL(32)
+#define XHCI_DEFAULT_PM_RUNTIME_ALLOW	BIT_ULL(33)
+#define XHCI_RESET_PLL_ON_DISCONNECT	BIT_ULL(34)
+#define XHCI_SNPS_BROKEN_SUSPEND    BIT_ULL(35)
+#define XHCI_RENESAS_FW_QUIRK	BIT_ULL(36)
+#define XHCI_SKIP_PHY_INIT	BIT_ULL(37)
+#define XHCI_DISABLE_SPARSE	BIT_ULL(38)
+#define XHCI_SG_TRB_CACHE_SIZE_QUIRK	BIT_ULL(39)
+#define XHCI_NO_SOFT_RETRY	BIT_ULL(40)
+#define XHCI_BROKEN_D3COLD	BIT_ULL(41)
+#define XHCI_EP_CTX_BROKEN_DCS	BIT_ULL(42)
+
+#endif /* _XHCI_QUIRKS_H */
-- 
2.7.4

