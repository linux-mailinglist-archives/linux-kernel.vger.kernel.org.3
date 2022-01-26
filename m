Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC5849C346
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 06:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbiAZFbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 00:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbiAZFbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 00:31:17 -0500
Received: from mx.msync.work (mx.msync.work [IPv6:2a01:4f9:2b:2dc2::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD06C061744;
        Tue, 25 Jan 2022 21:31:16 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C42BE282C36;
        Wed, 26 Jan 2022 05:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1643175074; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=3t996u2cCjv/tctIaoZzV+hoyE2QUpyMSv9doBI04So=;
        b=ajkW+Lz5FzQfoGu79yh2Bv8jcbbpZj4x0a1JSyZSNniu5+k7NkFJ8HXPXsJVcf+81fqhis
        z+WzzLUm6Z8MM2DszUPoNEw0e+/eSornVrM+qDDRdKoutfYwC9sN3N7UFtbum5G7EzIahv
        btt42ubNeOPlki/Kg+ykyFR2A7cLPcwoMmyL7a09XnhnS6Esh//Y9voToO+7rVnvhacKOq
        aPO1eZXABb3ke4GLw7jYhwn0bVXdhwShZB6xkZbTa07ug9A9HsBY9ic3fxedTp3HMxkqJ2
        X7BaKuxZeaLftciWmCP8f/TVbWd51bhxpHaMwWFHc1vQQPnqh2GJ/c0R3VUKwA==
From:   Vyacheslav Bocharov <adeep@lexina.in>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rudi Heitbaum <rudi@heitbaum.com>
Subject: [PATCH v6 1/2] Bluetooth: btrtl: Add support for RTL8822C hci_ver 0x08
Date:   Wed, 26 Jan 2022 08:31:02 +0300
Message-Id: <20220126053103.3261693-2-adeep@lexina.in>
In-Reply-To: <20220126053103.3261693-1-adeep@lexina.in>
References: <20220126053103.3261693-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a variation of RTL8822CS with hci_ver = 0x08. This is fully similar
to RTL8822CS with hci_ver = 0x0a observed on the Tanix TX6 Android
set-top box and JetHome JetHub H1.

Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>
---
 drivers/bluetooth/btrtl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index c2bdd1e6060e..c2030f7e25b4 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -148,6 +148,14 @@ static const struct id_table ic_id_table[] = {
 	  .fw_name  = "rtl_bt/rtl8761bu_fw.bin",
 	  .cfg_name = "rtl_bt/rtl8761bu_config" },
 
+	/* 8822C with UART interface */
+	{ IC_INFO(RTL_ROM_LMP_8822B, 0xc, 0x8, HCI_UART),
+	  .config_needed = true,
+	  .has_rom_version = true,
+	  .has_msft_ext = true,
+	  .fw_name  = "rtl_bt/rtl8822cs_fw.bin",
+	  .cfg_name = "rtl_bt/rtl8822cs_config" },
+
 	/* 8822C with UART interface */
 	{ IC_INFO(RTL_ROM_LMP_8822B, 0xc, 0xa, HCI_UART),
 	  .config_needed = true,
-- 
2.30.2

