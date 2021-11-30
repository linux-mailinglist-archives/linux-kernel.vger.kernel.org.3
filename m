Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E164635B7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 14:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241776AbhK3Nq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 08:46:29 -0500
Received: from cpanel.siel.si ([46.19.9.99]:38808 "EHLO cpanel.siel.si"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229473AbhK3NqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 08:46:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=BvHiFyzOTpt2hGyCVuXl2Hq70zeCH55Isy6IrmH3KWk=; b=cWl9oq/4vTFGXnI+wJBiW6mF9D
        /IK6jOjzj+mymY26YgwwFEqP4Pundtak8vH9c+qepdVo4nypxPu93IoBmYpPnu6U5lItXYiiAk/Tj
        VXT7WV/u3VWc7ugdw8AV3PDJ44EyLnznAcLBYayR9BxKDUL9q3RZz3nfE5YWON2/eIp7dSBCCyklk
        hRguONk6kSdBpxvJSribO/aDhBPcAmebZ0XID07uGfTCkzaxfLC4Jy6ka6BqBvh9AcWvNpxKujBrc
        TTLdf66vW+r0Uxb2YzSACwyXvTlASv65CGLAdoEriO9uw3BeZatVJIW1KzMHBq+dUqxZegqQHkb4/
        jOAwRHcg==;
Received: from [89.212.21.243] (port=49710 helo=localhost.localdomain)
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <andrej.picej@norik.com>)
        id 1ms3PJ-0039GW-Hp; Tue, 30 Nov 2021 14:42:53 +0100
From:   Andrej Picej <andrej.picej@norik.com>
Cc:     andrej.picej@norik.com, support.opensource@diasemi.com,
        wim@linux-watchdog.org, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/4] dt-bindings: watchdog: da9062: add watchdog timeout mode
Date:   Tue, 30 Nov 2021 14:42:41 +0100
Message-Id: <20211130134242.3516619-3-andrej.picej@norik.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211130134242.3516619-1-andrej.picej@norik.com>
References: <20211130134242.3516619-1-andrej.picej@norik.com>
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
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the watchdog timeout mode property. If this property is used
the user can select what happens on watchdog timeout. Set this property
to 1 to enable SHUTDOWN (the device resets), set it to 0 and the device
will go to POWERDOWN on watchdog timeout.

Signed-off-by: Andrej Picej <andrej.picej@norik.com>
---
 Documentation/devicetree/bindings/watchdog/da9062-wdt.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/da9062-wdt.txt b/Documentation/devicetree/bindings/watchdog/da9062-wdt.txt
index 950e4fba8dbc..e3e6e56cee21 100644
--- a/Documentation/devicetree/bindings/watchdog/da9062-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/da9062-wdt.txt
@@ -10,6 +10,9 @@ Optional properties:
 - dlg,use-sw-pm: Add this property to disable the watchdog during suspend.
 	Only use this option if you can't use the watchdog automatic suspend
 	function during a suspend (see register CONTROL_B).
+- dlg,wdt-sd: Set what happens on watchdog timeout. If this bit is set the
+	watchdog timeout triggers SHUTDOWN, if cleared the watchdog triggers
+	POWERDOWN. Can be 0 or 1.
 
 Example: DA9062
 
-- 
2.25.1

