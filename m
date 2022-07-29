Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C16585551
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 21:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238703AbiG2TDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 15:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238542AbiG2TCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 15:02:49 -0400
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86FC88CED;
        Fri, 29 Jul 2022 12:02:48 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id A09ED318B57;
        Fri, 29 Jul 2022 15:02:47 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ehFCq0xdU8uH; Fri, 29 Jul 2022 15:02:47 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 975F931900F;
        Fri, 29 Jul 2022 15:02:44 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 975F931900F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1659121364;
        bh=8X0HKRr4vzicIb3vy2m1DCC4ns3X3lY0CyPw6s0VI/k=;
        h=From:To:Date:Message-Id;
        b=agBVs/r8a9Dextj6marfS4RLkIYIzjXzu7uTHbH9zvjmfPIXwWnRos+LaSZ8UEMEI
         E1pagUe9zljyh08AzrsGimRS5oGMIYNhu2ckwOX8Zm0aG0i1XrcbBtme3CAaUQ1GHu
         xZQZSJB65WBeQKPuzqGK/kW8A+NVuNirOQLIbKOyP8BTPV+0wuNBzJndwo/QbxirOj
         L5FRnfAj5O/79DmdN5uv1ojLgSfD3wwtQl1Nazo/mIL39GnlUVuKyYAgTwoupLudfj
         9QEq3NCBw+NW9L+1fzLXN37avennCeHTmpjKAEciIMFaXwGxHK9fWlejWGlbpVtG0r
         thkppT1RRf7Xg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id h6mpaK2qQ_Jr; Fri, 29 Jul 2022 15:02:44 -0400 (EDT)
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id CA6E9318E8E;
        Fri, 29 Jul 2022 15:02:42 -0400 (EDT)
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
Subject: [PATCH v3 07/23] lib: implement find_{first,next}_{zero,one}_and_zero_bit
Date:   Fri, 29 Jul 2022 15:02:09 -0400
Message-Id: <20220729190225.12726-8-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220729190225.12726-1-mathieu.desnoyers@efficios.com>
References: <20220729190225.12726-1-mathieu.desnoyers@efficios.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 41941cb9cad7..ad446f248b36 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -76,6 +76,66 @@ unsigned long find_next_and_bit(const unsigned long *addr1,
 }
 #endif
 
+#ifndef find_next_one_and_zero_bit
+/**
+ * find_next_one_and_zero_bit - find the next bit which is one in addr1 and zero in addr2 memory region
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
+ * find_next_zero_and_zero_bit - find the next bit which is zero in addr1 and addr2 memory regions
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
+ * find_first_one_and_zero_bit - find the first bit which is one in addr1 and zero in addr2 memory region
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
+ * find_first_zero_and_zero_bit - find the first bit which is zero in addr1 and addr2 memory regions
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

