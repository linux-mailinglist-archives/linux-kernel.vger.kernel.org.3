Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFCF528627
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 15:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244185AbiEPN4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 09:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243935AbiEPNzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 09:55:00 -0400
Received: from mail.bitwise.fi (mail.bitwise.fi [109.204.228.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9042ACC;
        Mon, 16 May 2022 06:54:40 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.bitwise.fi (Postfix) with ESMTP id 3DFF646002E;
        Mon, 16 May 2022 16:49:04 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at 
Received: from mail.bitwise.fi ([127.0.0.1])
        by localhost (mustetatti.dmz.bitwise.fi [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1tcgcijmrJA4; Mon, 16 May 2022 16:49:02 +0300 (EEST)
Received: from localhost.net (fw1.dmz.bitwise.fi [192.168.69.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: anssiha)
        by mail.bitwise.fi (Postfix) with ESMTPSA id 58193460031;
        Mon, 16 May 2022 16:48:57 +0300 (EEST)
From:   Anssi Hannula <anssi.hannula@bitwise.fi>
To:     Jimmy Assarsson <extja@kvaser.com>
Cc:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/12] can: kvaser_usb_leaf: Fix wrong CAN state after stopping
Date:   Mon, 16 May 2022 16:47:46 +0300
Message-Id: <20220516134748.3724796-11-anssi.hannula@bitwise.fi>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220516134748.3724796-1-anssi.hannula@bitwise.fi>
References: <20220516134748.3724796-1-anssi.hannula@bitwise.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

0bfd:0124 Kvaser Mini PCI Express 2xHS FW 4.18.778 sends a
CMD_CHIP_STATE_EVENT indicating bus-off after stopping the device,
causing a stopped device to appear as CAN_STATE_BUS_OFF instead of
CAN_STATE_STOPPED.

Fix that by not handling error events on stopped devices.

Fixes: 080f40a6fa28 ("can: kvaser_usb: Add support for Kvaser CAN/USB devices")
Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 7ed2ced8ba08..742626e69dd8 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -879,6 +879,10 @@ static void kvaser_usb_leaf_rx_error(const struct kvaser_usb *dev,
 	leaf = priv->sub_priv;
 	stats = &priv->netdev->stats;
 
+	/* Ignore e.g. state change to bus-off reported just after stopping */
+	if (!netif_running(priv->netdev))
+		return;
+
 	/* Update all of the CAN interface's state and error counters before
 	 * trying any memory allocation that can actually fail with -ENOMEM.
 	 *
-- 
2.34.1

