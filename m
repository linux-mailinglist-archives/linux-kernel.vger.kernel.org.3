Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E4D4795A6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 21:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240857AbhLQUnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 15:43:17 -0500
Received: from whuk3.redbackinternet.net ([109.203.107.222]:55112 "EHLO
        whuk3.redbackinternet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240874AbhLQUnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 15:43:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=fbautosys.co.uk; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BdcbMVXQBTRDzwZvUDSH+xArL+v5gRK64otFW/vciqo=; b=EeRU/lVTAgCCPPDfJrCUDjbo1C
        Tk7M+zQNYRoYyHH2XGo6Yv8LbC6LmKZk3cYB/YsDVK+JEkwjI1clVCLoP51aGy/LtI7O2I8LfPlMr
        e1GX3R0z4YIntu3jvtonEjOS+1CMhAxTAJLVB9vQ64abLKB8bSj90psLc2q2RwMbaRi1Fyt1TSrnF
        L2ozEIClwpwYoAvcltqNCGioetKU3YKR7Vp+xiO/CJc0GeHdl11FtoT7uOKvNOy1hBcU1KKVSY3SM
        sx6LjQTLsTsWbYVNV09QBaI1S3xqqac6hHlevrrxSwjKiwTi7hRk5Rf2sTDYF94OsjePc3mnaZvr0
        0JMOp3Qg==;
Received: from 24.54.187.81.in-addr.arpa ([81.187.54.24]:28253 helo=kernelcomp.corp.firebladeautomationsystems.co.uk)
        by whuk3.redbackinternet.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <linuxkernel@fbautosys.co.uk>)
        id 1myJgM-0001AJ-E1; Fri, 17 Dec 2021 20:18:23 +0000
From:   linuxkernel@fbautosys.co.uk
To:     linux-kernel@vger.kernel.org
Cc:     broonie@kernel.org
Subject: [RFC PATCH 2/5] Altered regmap_X_X_write functions to account for padding bits
Date:   Fri, 17 Dec 2021 20:17:55 +0000
Message-Id: <20211217201758.1743750-3-linuxkernel@fbautosys.co.uk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211217201758.1743750-1-linuxkernel@fbautosys.co.uk>
References: <20211217201758.1743750-1-linuxkernel@fbautosys.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - whuk3.redbackinternet.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - fbautosys.co.uk
X-Get-Message-Sender-Via: whuk3.redbackinternet.net: authenticated_id: linuxkernel@fbautosys.co.uk
X-Authenticated-Sender: whuk3.redbackinternet.net: linuxkernel@fbautosys.co.uk
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christopher Tyerman <c.tyerman@firebladeautomationsystems.co.uk>

	modified:   drivers/base/regmap/regmap.c

Signed-off-by: Christopher Tyerman <c.tyerman@firebladeautomationsystems.co.uk>
---
 drivers/base/regmap/regmap.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 05c104659381..07d6d804c4b9 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -232,42 +232,52 @@ static void regmap_format_2_6_write(struct regmap *map,
 				     unsigned int reg, unsigned int val)
 {
 	u8 *out = map->work_buf;
+	u8 shift = map->reg_shift;
 
-	*out = (reg << 6) | val;
+	*out = (reg << (6 + shift) | val);
 }
 
 static void regmap_format_4_12_write(struct regmap *map,
 				     unsigned int reg, unsigned int val)
 {
+	u8 shift = map->reg_shift;
 	__be16 *out = map->work_buf;
-	*out = cpu_to_be16((reg << 12) | val);
+
+	*out = cpu_to_be16((reg << (12 + shift)) | val);
 }
 
 static void regmap_format_7_9_write(struct regmap *map,
 				    unsigned int reg, unsigned int val)
 {
+	u8 shift = map->reg_shift;
 	__be16 *out = map->work_buf;
-	*out = cpu_to_be16((reg << 9) | val);
+
+	*out = cpu_to_be16((reg << (9 + shift)) | val);
 }
 
 static void regmap_format_7_17_write(struct regmap *map,
 				    unsigned int reg, unsigned int val)
 {
+	u8 shift = map->reg_shift;
 	u8 *out = map->work_buf;
 
 	out[2] = val;
 	out[1] = val >> 8;
-	out[0] = (val >> 16) | (reg << 1);
+	out[0] = (val >> 16) | (reg << (1 + shift));
 }
 
 static void regmap_format_10_14_write(struct regmap *map,
 				    unsigned int reg, unsigned int val)
 {
+	u8 shift = map->reg_shift;
 	u8 *out = map->work_buf;
 
 	out[2] = val;
-	out[1] = (val >> 8) | (reg << 6);
-	out[0] = reg >> 2;
+	out[1] = (val >> 8) | (reg << (6 + shift));
+	if (shift <= 2)
+		out[0] = reg >> (2 - shift);
+	else
+		out[0] = reg << shift;
 }
 
 static void regmap_format_8(void *buf, unsigned int val, unsigned int shift)
-- 
2.25.1

