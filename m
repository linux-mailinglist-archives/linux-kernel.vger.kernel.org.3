Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D85047D714
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 19:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344844AbhLVSoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 13:44:08 -0500
Received: from whuk3.redbackinternet.net ([109.203.107.222]:44206 "EHLO
        whuk3.redbackinternet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344868AbhLVSoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 13:44:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=fbautosys.co.uk; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=N/tjh8yplC+ohuJ64Uxf0ilzaTYxBP/RdfxkuRoN980=; b=aw5EhYmrdJ02XSGWcp6w9G5dZf
        d2fkiuCnLCDKdMLtzc7lLjNJ74mfUfMzF7QS6BUB+qrMBkMSD6osWk7pLipBlZPNP6U6RpSqrSEsm
        67LaHxHhviuvUCXaEbHDrW9wowV0dKMNvfin+Gs2LpNrrWeseVy88JjzXXZAkPwzFn+EubxcczU66
        IR6MhZu9TF+ZQ3Twlv3jTjOaJ9Fmts/Q/tlfx8lDjVihD6UV45C+zCl8hQM2tG8YkqAT0TzHtdt4Q
        wk1Kqge9wNIPcQvvyeFYJIubE5Bi2WLHKDmDgh5pG8ANmfU3Z7YpE95aMw/+FEkU3q2oeRqw+kxp1
        POVpiUww==;
Received: from 24.54.187.81.in-addr.arpa ([81.187.54.24]:44088 helo=kernelcomp.corp.firebladeautomationsystems.co.uk)
        by whuk3.redbackinternet.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <linuxkernel@fbautosys.co.uk>)
        id 1n06am-000CmX-8x; Wed, 22 Dec 2021 18:44:01 +0000
From:   linuxkernel@fbautosys.co.uk
To:     linux-kernel@vger.kernel.org
Cc:     broonie@kernel.org
Subject: [RFC PATCH v2 5/5] Add parser for X_9 formats
Date:   Wed, 22 Dec 2021 18:43:40 +0000
Message-Id: <20211222184340.1907240-6-linuxkernel@fbautosys.co.uk>
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

added 9 bit Parser functions

these operate in same way as 16 bit parsers but mask out higher bits

regmap_parse_9_be()
regmap_parse_9_be_inplace()
regmap_parse_9_le()
regmap_parse_9_le_inplace()
regmap_parse_9_native()

	modified:   drivers/base/regmap/regmap.c

Signed-off-by: Christopher Tyerman <c.tyerman@firebladeautomationsystems.co.uk>
---
 drivers/base/regmap/regmap.c | 53 ++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 177f2010a490..40579975209a 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -370,6 +370,39 @@ static unsigned int regmap_parse_8(const void *buf)
 	return b[0];
 }
 
+static unsigned int regmap_parse_9_be(const void *buf)
+{
+	return get_unaligned_be16(buf) & 0x1FF;
+}
+
+static unsigned int regmap_parse_9_le(const void *buf)
+{
+
+	return get_unaligned_le16(buf) & 0x1FF;
+}
+
+static void regmap_parse_9_be_inplace(void *buf)
+{
+	u16 v = get_unaligned_be16(buf) & 0x1FF;
+
+	memcpy(buf, &v, sizeof(v));
+}
+
+static void regmap_parse_9_le_inplace(void *buf)
+{
+	u16 v = get_unaligned_le16(buf) & 0x1FF;
+
+	memcpy(buf, &v, sizeof(v));
+}
+
+static unsigned int regmap_parse_9_native(const void *buf)
+{
+	u16 v;
+
+	memcpy(&v, buf, sizeof(v));
+	return v & 0x1FF;
+}
+
 static unsigned int regmap_parse_16_be(const void *buf)
 {
 	return get_unaligned_be16(buf);
@@ -1052,6 +1085,26 @@ struct regmap *__regmap_init(struct device *dev,
 		map->format.parse_val = regmap_parse_8;
 		map->format.parse_inplace = regmap_parse_inplace_noop;
 		break;
+	case 9:
+		switch (val_endian) {
+		case REGMAP_ENDIAN_BIG:
+			//map->format.format_val = regmap_format_9_be;
+			map->format.parse_val = regmap_parse_9_be;
+			map->format.parse_inplace = regmap_parse_9_be_inplace;
+			break;
+		case REGMAP_ENDIAN_LITTLE:
+			//map->format.format_val = regmap_format_9_le;
+			map->format.parse_val = regmap_parse_9_le;
+			map->format.parse_inplace = regmap_parse_9_le_inplace;
+			break;
+		case REGMAP_ENDIAN_NATIVE:
+			//map->format.format_val = regmap_format_9_native;
+			map->format.parse_val = regmap_parse_9_native;
+			break;
+		default:
+			goto err_hwlock;
+		}
+		break;
 	case 16:
 		switch (val_endian) {
 		case REGMAP_ENDIAN_BIG:
-- 
2.25.1

