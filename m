Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B46A46607B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 10:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356527AbhLBJgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 04:36:19 -0500
Received: from cpanel.siel.si ([46.19.9.99]:49402 "EHLO cpanel.siel.si"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356439AbhLBJgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 04:36:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=JoWVJsvCXYY1I9He6RtFyygHgrm4/b7pQYSgt5eRc5I=; b=NRIXNTkb1H3IH21rsQLN8s/SPB
        R3weB2PYieJTrJQimij0T58d6xS5b1qj/Xi/RdUkCAgeH7+H81L/+I1btUJraTw1sUtP77+xpN2jB
        pSxhHIne6ZDctDk6/kad5LvHFoyVVLPPuTyde2VsIkHNZNQeTleUspMnkUWTz52QLozwcy4pdFoTX
        Wg2OIo1NMA9ZSLlz/FivNyELI2ApMKqa+1Bz1Yjpkr1X2UJiiwGdPDQTlPkfvdcOmEOPhjBh0o1Kx
        kv+jAaPaxGnfdp1QkkCZDqT48KCqnPHMONN5uoSjEW3q72HqMnKwMuFc0FxvUb8aC0Bzc1uWmZBJY
        bLZ79BNw==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:52018 helo=localhost.localdomain)
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <andrej.picej@norik.com>)
        id 1msiSB-00DPB6-81; Thu, 02 Dec 2021 10:32:42 +0100
From:   Andrej Picej <andrej.picej@norik.com>
To:     support.opensource@diasemi.com, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org
Cc:     andrej.picej@norik.com, wim@linux-watchdog.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 3/4] dt-bindings: watchdog: da9062: add watchdog timeout mode
Date:   Thu,  2 Dec 2021 10:32:29 +0100
Message-Id: <20211202093230.3951996-3-andrej.picej@norik.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211202093230.3951996-1-andrej.picej@norik.com>
References: <20211202093230.3951996-1-andrej.picej@norik.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the watchdog timeout mode property. If this property is used
the user can select what happens on watchdog timeout. Set this property
to 1 to enable SHUTDOWN (the device resets), set it to 0 and the device
will go to POWERDOWN on watchdog timeout.

If this property is not set, don't touch the WATCHDOG_SD bit and leave
the configuration to OTP. This way backward compatibility is not broken.

Signed-off-by: Andrej Picej <andrej.picej@norik.com>
---
Changes in v4:
 - no changes

Changes in v3:
 - add note about using the default OTP setting if this DT binding is
   not specified

Changes in v2:
 - new patch, document new DT binding
---
 Documentation/devicetree/bindings/watchdog/da9062-wdt.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/da9062-wdt.txt b/Documentation/devicetree/bindings/watchdog/da9062-wdt.txt
index 950e4fba8dbc..354314d854ef 100644
--- a/Documentation/devicetree/bindings/watchdog/da9062-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/da9062-wdt.txt
@@ -10,6 +10,12 @@ Optional properties:
 - dlg,use-sw-pm: Add this property to disable the watchdog during suspend.
 	Only use this option if you can't use the watchdog automatic suspend
 	function during a suspend (see register CONTROL_B).
+- dlg,wdt-sd: Set what happens on watchdog timeout. If this bit is set the
+	watchdog timeout triggers SHUTDOWN, if cleared the watchdog triggers
+	POWERDOWN. Can be 0 or 1. Only use this option if you want to change the
+	default chip's OTP setting for WATCHDOG_SD bit. If this property is NOT
+	set the WATCHDOG_SD bit and on timeout watchdog behavior will match the
+	chip's OTP settings.
 
 Example: DA9062
 
-- 
2.25.1

