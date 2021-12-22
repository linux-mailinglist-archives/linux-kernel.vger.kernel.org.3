Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B9E47D711
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 19:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344852AbhLVSoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 13:44:00 -0500
Received: from whuk3.redbackinternet.net ([109.203.107.222]:44154 "EHLO
        whuk3.redbackinternet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344842AbhLVSn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 13:43:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=fbautosys.co.uk; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uh3/03ZY2B6VFhogjxuEJz3khwd9oGCZ4nLQPSXcWj0=; b=PvW3MfHJRoUYxgH6+ExBrR2VmX
        VAnC6mD/CfT1WA54WDiWESNe0CbZhQbOAmT06z5F7Mp/CEVtvOsB/dDgkTbxh8GE/mx31M6TU/FLF
        +hk+ib0B3zdLW86YjoY9dqrRvQHOuu9n9cArJ8W6902kf7Ho9yvdCioSQBTgaluUzfSoRzX8+12wP
        QutC+SNf//riEybWkyXtgr6/Pzlu/+DhkOrE1oQI6EXWYZ7KE/o1+MOeB5kRroHBZL4QocAukh0My
        LPw5suYT6xUVmBNPdxV6p1jcupAkH5chLCxZaPdTg0IoRw71YCkiXTp+wGr1hTd4ZCI6Frpdb28qq
        wvIoktpg==;
Received: from 24.54.187.81.in-addr.arpa ([81.187.54.24]:44088 helo=kernelcomp.corp.firebladeautomationsystems.co.uk)
        by whuk3.redbackinternet.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <linuxkernel@fbautosys.co.uk>)
        id 1n06ah-000CmX-8Y; Wed, 22 Dec 2021 18:43:56 +0000
From:   linuxkernel@fbautosys.co.uk
To:     linux-kernel@vger.kernel.org
Cc:     broonie@kernel.org
Subject: [RFC PATCH v2 2/5] Altered regmap_format_X_X_write functions to account for padding bits
Date:   Wed, 22 Dec 2021 18:43:37 +0000
Message-Id: <20211222184340.1907240-3-linuxkernel@fbautosys.co.uk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211222184340.1907240-1-linuxkernel@fbautosys.co.uk>
References: <20211222184340.1907240-1-linuxkernel@fbautosys.co.uk>
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

Altered regmap_format_X_X_write functions to account for padding bits by
adjusting reg position shifts by value of map->reg_shift

as map->format.format_write is selected based on
(config->reg_bits + map->reg_shift) each regmap_format_X_X_write needs
to account for map->reg_shift or will be misaligned if padding bits
greater than zero

	modified:   drivers/base/regmap/regmap.c

Signed-off-by: Christopher Tyerman <c.tyerman@firebladeautomationsystems.co.uk>
---
 drivers/base/regmap/regmap.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 05c104659381..05c65312a9b3 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -220,9 +220,14 @@ static void regmap_format_12_20_write(struct regmap *map,
 				     unsigned int reg, unsigned int val)
 {
 	u8 *out = map->work_buf;
+	u8 shift = map->reg_shift;
 
-	out[0] = reg >> 4;
-	out[1] = (reg << 4) | (val >> 16);
+	if (shift <= 4)
+		out[0] = reg >> (4 - shift);
+	else
+		out[0] = reg << (shift - 4);
+
+	out[1] = (reg << 4 + shift) | (val >> 16);
 	out[2] = val >> 8;
 	out[3] = val;
 }
@@ -232,42 +237,52 @@ static void regmap_format_2_6_write(struct regmap *map,
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
+		out[0] = reg << (shift - 2);
 }
 
 static void regmap_format_8(void *buf, unsigned int val, unsigned int shift)
-- 
2.25.1

