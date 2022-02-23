Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243944C16DF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 16:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242097AbiBWPdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 10:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242091AbiBWPdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 10:33:35 -0500
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F88B188B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 07:33:06 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:c0fe:4675:4cef:99a5])
        by andre.telenet-ops.be with bizsmtp
        id yfZ42600D4Plfy301fZ47H; Wed, 23 Feb 2022 16:33:04 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nMtdY-001eas-AC; Wed, 23 Feb 2022 16:33:04 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nMtdX-00BYwL-P9; Wed, 23 Feb 2022 16:33:03 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] usb: misc: USB_QCOM_EUD should depend on ARCH_QCOM
Date:   Wed, 23 Feb 2022 16:33:02 +0100
Message-Id: <f3ba3ea0d7f5e628c71cb7a9d62c9fb4589297b1.1645630266.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm Embedded USB Debugger is not a pluggable USB device, and
can only be present on Qualcomm SoCs.  Hence add a dependency on
ARCH_QCOM, to prevent asking the user about this driver when configuring
a kernel without Qualcomm SoC support.

Fixes: 9a1bf58ccd443268 ("usb: misc: eud: Add driver support for Embedded USB Debugger(EUD)")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/usb/misc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
index c9407b86790ce4dd..4c5ddbd75b7e9f75 100644
--- a/drivers/usb/misc/Kconfig
+++ b/drivers/usb/misc/Kconfig
@@ -139,6 +139,7 @@ config USB_APPLEDISPLAY
 
 config USB_QCOM_EUD
 	tristate "QCOM Embedded USB Debugger(EUD) Driver"
+	depends on ARCH_QCOM || COMPILE_TEST
 	select USB_ROLE_SWITCH
 	help
 	  This module enables support for Qualcomm Technologies, Inc.
-- 
2.25.1

