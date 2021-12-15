Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC89475C6D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 16:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244315AbhLOP4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 10:56:13 -0500
Received: from marcansoft.com ([212.63.210.85]:52918 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244287AbhLOP4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 10:56:06 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 84F53424D0;
        Wed, 15 Dec 2021 15:56:02 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Sven Peter <sven@svenpeter.dev>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <kettenis@openbsd.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 2/2] mailbox: apple: Bind to generic compatibles
Date:   Thu, 16 Dec 2021 00:55:27 +0900
Message-Id: <20211215155527.36775-3-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211215155527.36775-1-marcan@marcan.st>
References: <20211215155527.36775-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As with other blocks, we intend to have drivers bind to generic
compatibles as long as there are no SoC-specific quirks. This allows
forward-compatibility with future SoCs.

No upstream DTs instantiate this yet, so it's still safe to make this
breaking change.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/mailbox/apple-mailbox.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/apple-mailbox.c b/drivers/mailbox/apple-mailbox.c
index 72942002a54a..496c4951ccb1 100644
--- a/drivers/mailbox/apple-mailbox.c
+++ b/drivers/mailbox/apple-mailbox.c
@@ -364,8 +364,8 @@ static const struct apple_mbox_hw apple_mbox_m3_hw = {
 };
 
 static const struct of_device_id apple_mbox_of_match[] = {
-	{ .compatible = "apple,t8103-asc-mailbox", .data = &apple_mbox_asc_hw },
-	{ .compatible = "apple,t8103-m3-mailbox", .data = &apple_mbox_m3_hw },
+	{ .compatible = "apple,asc-mailbox-v4", .data = &apple_mbox_asc_hw },
+	{ .compatible = "apple,m3-mailbox-v2", .data = &apple_mbox_m3_hw },
 	{}
 };
 MODULE_DEVICE_TABLE(of, apple_mbox_of_match);
-- 
2.33.0

