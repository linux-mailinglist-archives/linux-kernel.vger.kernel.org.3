Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B220349C4A5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 08:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237976AbiAZHjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 02:39:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237931AbiAZHjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 02:39:18 -0500
Received: from mx.msync.work (mx.msync.work [IPv6:2a01:4f9:2b:2dc2::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6141C061744;
        Tue, 25 Jan 2022 23:39:18 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9129E2832BF;
        Wed, 26 Jan 2022 07:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1643182756; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=3t996u2cCjv/tctIaoZzV+hoyE2QUpyMSv9doBI04So=;
        b=ZbAmdST9wItFPgThyuBvXuh1wxpvKVzE0iQpUatK/2NwifqiNMURuUhR9SPZg+aHOcBWVr
        I5gOBDHEZf3osK04JmFhmpv0EafWiwC5grOWzbNqJ/NxvESwZ9R7fiaHLXU9BAY2KORuK3
        XgEh2YhAa+/KvS2j46/I6YuNeLGyHbLWeKE68jQ75RCK8WuQ1C2OeprrEYH3mSoboApuf6
        g00hBZ7nWLd7u7NIl3yol9bNoPa0MlIxiPqIWU+QjNKzRFNUPRPfNEFIceCy2dHJ4/InzL
        N/9ALbG4Nsu5kdvsRwK7FtrGbWAoO3sx785UAszS28llOU0qYembC4Zti/pPQQ==
From:   Vyacheslav Bocharov <adeep@lexina.in>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rudi Heitbaum <rudi@heitbaum.com>
Subject: [PATCH v7 1/2] Bluetooth: btrtl: Add support for RTL8822C hci_ver 0x08
Date:   Wed, 26 Jan 2022 10:39:04 +0300
Message-Id: <20220126073905.3637841-2-adeep@lexina.in>
In-Reply-To: <20220126073905.3637841-1-adeep@lexina.in>
References: <20220126073905.3637841-1-adeep@lexina.in>
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

