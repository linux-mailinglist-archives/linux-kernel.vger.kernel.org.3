Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374294CC6E5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 21:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236283AbiCCUOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 15:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236167AbiCCUOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 15:14:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E14DC622F;
        Thu,  3 Mar 2022 12:13:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6DE361CAD;
        Thu,  3 Mar 2022 20:13:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88133C340F0;
        Thu,  3 Mar 2022 20:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646338401;
        bh=O41aGTB4glPsCrp+yeZIdtPQ8+Or7tPxMyO0j3WKWCE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TtkIUYQcZXjOQZvrWAyvy5S9dW4eTUfobrwlQ7ye401li9GT1LtPfC9XU+LEKj+os
         jXlTOZqZ9ribCMo5yg7rd1/kZo5iZ2suTohllcIYBzhM9iZgK7kZNPIO/gwMgpnqod
         IoqmsY2dVoFo7bqifsg9kBihY3sUELg4TnHQlT0SSr4s9T6RfoLUUQRo7uemMAkaH8
         vCF72Xp40i9tphKswGBdX6nJwCyXse7ej/E0x8E3Flqs4EGXHb+4IEfWSFWa0xc0hH
         LjSkcrgtkWP0+dG7hzH6hcsoVJ2A2Fq2AAsX0qh7mTPdB+KRXQi1ZH7fEkR1PAQBvF
         ZtjaRRIjBvNMA==
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
        Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
Subject: [PATCHv4 5/8] lib: add rocksoft model crc64
Date:   Thu,  3 Mar 2022 12:13:09 -0800
Message-Id: <20220303201312.3255347-6-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20220303201312.3255347-1-kbusch@kernel.org>
References: <20220303201312.3255347-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NVM Express specification extended data integrity fields to 64 bits
using the Rocksoft parameters. Add the poly to the crc64 table
generation, and provide a generic library routine implementing the
algorithm.

The Rocksoft 64-bit CRC model parameters are as follows:
    Poly: 0xAD93D23594C93659
    Initial value: 0xFFFFFFFFFFFFFFFF
    Reflected Input: True
    Reflected Output: True
    Xor Final: 0xFFFFFFFFFFFFFFFF

Since this model used reflected bits, the implementation generates the
reflected table so the result is ordered consistently.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v3->v4:

  Require the caller to provide 0 for the initial value. This means the
  calculation is responsible to invert it now, and makes updating the
  crc in multiple chunks easier.

 include/linux/crc64.h |  2 ++
 lib/crc64.c           | 28 ++++++++++++++++++++++++
 lib/gen_crc64table.c  | 51 +++++++++++++++++++++++++++++++++----------
 3 files changed, 70 insertions(+), 11 deletions(-)

diff --git a/include/linux/crc64.h b/include/linux/crc64.h
index c756e65a1b58..9480f38cc7cf 100644
--- a/include/linux/crc64.h
+++ b/include/linux/crc64.h
@@ -8,4 +8,6 @@
 #include <linux/types.h>
 
 u64 __pure crc64_be(u64 crc, const void *p, size_t len);
+u64 __pure crc64_rocksoft_generic(u64 crc, const void *p, size_t len);
+
 #endif /* _LINUX_CRC64_H */
diff --git a/lib/crc64.c b/lib/crc64.c
index 9f852a89ee2a..61ae8dfb6a1c 100644
--- a/lib/crc64.c
+++ b/lib/crc64.c
@@ -22,6 +22,13 @@
  * x^24 + x^23 + x^22 + x^21 + x^19 + x^17 + x^13 + x^12 + x^10 + x^9 +
  * x^7 + x^4 + x + 1
  *
+ * crc64rocksoft[256] table is from the Rocksoft specification polynomial
+ * defined as,
+ *
+ * x^64 + x^63 + x^61 + x^59 + x^58 + x^56 + x^55 + x^52 + x^49 + x^48 + x^47 +
+ * x^46 + x^44 + x^41 + x^37 + x^36 + x^34 + x^32 + x^31 + x^28 + x^26 + x^23 +
+ * x^22 + x^19 + x^16 + x^13 + x^12 + x^10 + x^9 + x^6 + x^4 + x^3 + 1
+ *
  * Copyright 2018 SUSE Linux.
  *   Author: Coly Li <colyli@suse.de>
  */
@@ -55,3 +62,24 @@ u64 __pure crc64_be(u64 crc, const void *p, size_t len)
 	return crc;
 }
 EXPORT_SYMBOL_GPL(crc64_be);
+
+/**
+ * crc64_rocksoft_generic - Calculate bitwise Rocksoft CRC64
+ * @crc: seed value for computation. 0 for a new CRC calculation, or the
+ * 	 previous crc64 value if computing incrementally.
+ * @p: pointer to buffer over which CRC64 is run
+ * @len: length of buffer @p
+ */
+u64 __pure crc64_rocksoft_generic(u64 crc, const void *p, size_t len)
+{
+	const unsigned char *_p = p;
+	size_t i;
+
+	crc = ~crc;
+
+	for (i = 0; i < len; i++)
+		crc = (crc >> 8) ^ crc64rocksofttable[(crc & 0xff) ^ *_p++];
+
+	return ~crc;
+}
+EXPORT_SYMBOL_GPL(crc64_rocksoft_generic);
diff --git a/lib/gen_crc64table.c b/lib/gen_crc64table.c
index 094b43aef8db..55e222acd0b8 100644
--- a/lib/gen_crc64table.c
+++ b/lib/gen_crc64table.c
@@ -17,10 +17,30 @@
 #include <stdio.h>
 
 #define CRC64_ECMA182_POLY 0x42F0E1EBA9EA3693ULL
+#define CRC64_ROCKSOFT_POLY 0x9A6C9329AC4BC9B5ULL
 
 static uint64_t crc64_table[256] = {0};
+static uint64_t crc64_rocksoft_table[256] = {0};
 
-static void generate_crc64_table(void)
+static void generate_reflected_crc64_table(uint64_t table[256], uint64_t poly)
+{
+	uint64_t i, j, c, crc;
+
+	for (i = 0; i < 256; i++) {
+		crc = 0ULL;
+		c = i;
+
+		for (j = 0; j < 8; j++) {
+			if ((crc ^ (c >> j)) & 1)
+				crc = (crc >> 1) ^ poly;
+			else
+				crc >>= 1;
+		}
+		table[i] = crc;
+	}
+}
+
+static void generate_crc64_table(uint64_t table[256], uint64_t poly)
 {
 	uint64_t i, j, c, crc;
 
@@ -30,26 +50,22 @@ static void generate_crc64_table(void)
 
 		for (j = 0; j < 8; j++) {
 			if ((crc ^ c) & 0x8000000000000000ULL)
-				crc = (crc << 1) ^ CRC64_ECMA182_POLY;
+				crc = (crc << 1) ^ poly;
 			else
 				crc <<= 1;
 			c <<= 1;
 		}
 
-		crc64_table[i] = crc;
+		table[i] = crc;
 	}
 }
 
-static void print_crc64_table(void)
+static void output_table(uint64_t table[256])
 {
 	int i;
 
-	printf("/* this file is generated - do not edit */\n\n");
-	printf("#include <linux/types.h>\n");
-	printf("#include <linux/cache.h>\n\n");
-	printf("static const u64 ____cacheline_aligned crc64table[256] = {\n");
 	for (i = 0; i < 256; i++) {
-		printf("\t0x%016" PRIx64 "ULL", crc64_table[i]);
+		printf("\t0x%016" PRIx64 "ULL", table[i]);
 		if (i & 0x1)
 			printf(",\n");
 		else
@@ -58,9 +74,22 @@ static void print_crc64_table(void)
 	printf("};\n");
 }
 
+static void print_crc64_tables(void)
+{
+	printf("/* this file is generated - do not edit */\n\n");
+	printf("#include <linux/types.h>\n");
+	printf("#include <linux/cache.h>\n\n");
+	printf("static const u64 ____cacheline_aligned crc64table[256] = {\n");
+	output_table(crc64_table);
+
+	printf("\nstatic const u64 ____cacheline_aligned crc64rocksofttable[256] = {\n");
+	output_table(crc64_rocksoft_table);
+}
+
 int main(int argc, char *argv[])
 {
-	generate_crc64_table();
-	print_crc64_table();
+	generate_crc64_table(crc64_table, CRC64_ECMA182_POLY);
+	generate_reflected_crc64_table(crc64_rocksoft_table, CRC64_ROCKSOFT_POLY);
+	print_crc64_tables();
 	return 0;
 }
-- 
2.25.4

