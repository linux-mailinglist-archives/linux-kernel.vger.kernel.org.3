Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4E84BC1A4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 22:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239753AbiBRVQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 16:16:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239659AbiBRVQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 16:16:11 -0500
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFAC28B639;
        Fri, 18 Feb 2022 13:15:52 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id EC6423BAB17;
        Fri, 18 Feb 2022 16:06:46 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id fW0y1t-33qnL; Fri, 18 Feb 2022 16:06:46 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 5BD6B3BA92E;
        Fri, 18 Feb 2022 16:06:45 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 5BD6B3BA92E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1645218405;
        bh=zb3SusDsVJNg+pjuGfT7yEf39MwlGGyPhgXVO4KRkhM=;
        h=From:To:Date:Message-Id;
        b=epdNARr8QSHDvXrxYdsz2N7Wm7ivkowqacmFw9oaQsv4DAroRJ2J06SI3qEGdNeMa
         6IpjKAqGp+s8QeAJW8ZZuuWILwln0ZGJRy0A+4IuA90ZTUt9RvPE07l7PAVFmtrQJy
         xLsoeuYru1E6a8R34RrY7GX0uBDBRvO92tnKgVgDO9imWIXfo5BPsaTSkTLlgMoDB3
         3Oe5RQqdTz8MchQwZQCTbv5tKd+hjeq7aG8EGEijUvQtqSe5pmbV6Xpv1NnWy5T4iV
         TatBDih+5ZwnycNubLVrABhJezl1g4yCNgVwkpXt0eQ2WHgTWGNIoMBX9FkK1ZHTpe
         fx7vd551JhY8Q==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id E1jGpqx5UH-Q; Fri, 18 Feb 2022 16:06:45 -0500 (EST)
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id 0526A3BAB14;
        Fri, 18 Feb 2022 16:06:44 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@ACULAB.COM,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH v2 07/11] lib: implement find_{first,next}_{zero,one}_and_zero_bit
Date:   Fri, 18 Feb 2022 16:06:29 -0500
Message-Id: <20220218210633.23345-8-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220218210633.23345-1-mathieu.desnoyers@efficios.com>
References: <20220218210633.23345-1-mathieu.desnoyers@efficios.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow finding the first or next bit within two input bitmasks which is
either:

- both zero and zero,
- respectively one and zero.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 include/linux/find.h | 110 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/include/linux/find.h b/include/linux/find.h
index 41941cb9cad7..9b6edd00b45e 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -76,6 +76,66 @@ unsigned long find_next_and_bit(const unsigned long *addr1,
 }
 #endif
 
+#ifndef find_next_one_and_zero_bit
+/**
+ * find_next_one_and_zero_bit - find the next bit which is one in addr1 and zero in addr2
+ * @addr1: The first address to base the search on
+ * @addr2: The second address to base the search on
+ * @offset: The bitnumber to start searching at
+ * @size: The bitmap size in bits
+ *
+ * Returns the bit number for the next bit set in addr1 and cleared in addr2
+ * If no corresponding bits meet this criterion, returns @size.
+ */
+static inline
+unsigned long find_next_one_and_zero_bit(const unsigned long *addr1,
+		const unsigned long *addr2, unsigned long size,
+		unsigned long offset)
+{
+	if (small_const_nbits(size)) {
+		unsigned long val;
+
+		if (unlikely(offset >= size))
+			return size;
+
+		val = *addr1 & ~*addr2 & GENMASK(size - 1, offset);
+		return val ? __ffs(val) : size;
+	}
+
+	return _find_next_bit(addr1, addr2, size, offset, 0UL, ~0UL, 0);
+}
+#endif
+
+#ifndef find_next_zero_and_zero_bit
+/**
+ * find_next_zero_and_zero_bit - find the next bit which is zero in addr1 and addr2
+ * @addr1: The first address to base the search on
+ * @addr2: The second address to base the search on
+ * @offset: The bitnumber to start searching at
+ * @size: The bitmap size in bits
+ *
+ * Returns the bit number for the next bit cleared in addr1 and addr2
+ * If no corresponding bits meet this criterion, returns @size.
+ */
+static inline
+unsigned long find_next_zero_and_zero_bit(const unsigned long *addr1,
+		const unsigned long *addr2, unsigned long size,
+		unsigned long offset)
+{
+	if (small_const_nbits(size)) {
+		unsigned long val;
+
+		if (unlikely(offset >= size))
+			return size;
+
+		val = ~*addr1 & ~*addr2 & GENMASK(size - 1, offset);
+		return val ? __ffs(val) : size;
+	}
+
+	return _find_next_bit(addr1, addr2, size, offset, ~0UL, ~0UL, 0);
+}
+#endif
+
 #ifndef find_next_zero_bit
 /**
  * find_next_zero_bit - find the next cleared bit in a memory region
@@ -173,6 +233,56 @@ unsigned long find_first_zero_bit(const unsigned long *addr, unsigned long size)
 }
 #endif
 
+#ifndef find_first_one_and_zero_bit
+/**
+ * find_first_one_and_zero_bit - find the first bit which is one in addr1 and zero in addr2
+ * @addr1: The first address to base the search on
+ * @addr2: The second address to base the search on
+ * @size: The bitmap size in bits
+ *
+ * Returns the bit number for the first bit set in addr1 and cleared in addr2
+ * If no corresponding bits meet this criterion, returns @size.
+ */
+static inline
+unsigned long find_first_one_and_zero_bit(const unsigned long *addr1,
+				 const unsigned long *addr2,
+				 unsigned long size)
+{
+	if (small_const_nbits(size)) {
+		unsigned long val = *addr1 & ~*addr2 & GENMASK(size - 1, 0);
+
+		return val ? __ffs(val) : size;
+	}
+
+	return _find_next_bit(addr1, addr2, size, 0, 0UL, ~0UL, 0);
+}
+#endif
+
+#ifndef find_first_zero_and_zero_bit
+/**
+ * find_first_zero_and_zero_bit - find the first bit which is zero in addr1 and addr2
+ * @addr1: The first address to base the search on
+ * @addr2: The second address to base the search on
+ * @size: The bitmap size in bits
+ *
+ * Returns the bit number for the first bit cleared in addr1 and addr2
+ * If no corresponding bits meet this criterion, returns @size.
+ */
+static inline
+unsigned long find_first_zero_and_zero_bit(const unsigned long *addr1,
+				 const unsigned long *addr2,
+				 unsigned long size)
+{
+	if (small_const_nbits(size)) {
+		unsigned long val = ~*addr1 & ~*addr2 & GENMASK(size - 1, 0);
+
+		return val ? __ffs(val) : size;
+	}
+
+	return _find_next_bit(addr1, addr2, size, 0, ~0UL, ~0UL, 0);
+}
+#endif
+
 #ifndef find_last_bit
 /**
  * find_last_bit - find the last set bit in a memory region
-- 
2.17.1

