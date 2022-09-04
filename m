Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14145AC640
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 22:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbiIDT7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 15:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiIDT7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 15:59:33 -0400
Received: from 7of9.schinagl.nl (7of9.connected.by.freedominter.net [185.238.129.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDE4B7D3
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 12:59:29 -0700 (PDT)
Received: from localhost (7of9.are-b.org [127.0.0.1])
        by 7of9.schinagl.nl (Postfix) with ESMTP id AF740186CE17;
        Sun,  4 Sep 2022 21:59:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
        t=1662321566; bh=iwMZ7uzxvYMKIoxrcd+Q6G1OEy+h53dtjR3hmBS2kP8=;
        h=From:To:Cc:Subject:Date;
        b=hs+TzS6knz+ZfzCEDOuHCpgkscEHGi10Kh79UdvWwytCNBrH3YgTrEluWwppJ4HHP
         hibfUHQKfFn9DhxIsLlB5nxpP2igMhXxxiIN/WUQhNA6MRTld/3mhUlY1U4j0ffTG9
         uIRbde9nGwGyJwWZyn+36B9MXJm6q4dxYU3omcq4=
X-Virus-Scanned: amavisd-new at schinagl.nl
Received: from 7of9.schinagl.nl ([127.0.0.1])
        by localhost (7of9.schinagl.nl [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id iO484-TzXJdC; Sun,  4 Sep 2022 21:59:25 +0200 (CEST)
Received: from valexia.are-b.org (unknown [10.2.11.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by 7of9.schinagl.nl (Postfix) with ESMTPSA id 55B23186CE12;
        Sun,  4 Sep 2022 21:59:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
        t=1662321565; bh=iwMZ7uzxvYMKIoxrcd+Q6G1OEy+h53dtjR3hmBS2kP8=;
        h=From:To:Cc:Subject:Date;
        b=mIg9xaTq9XCocTN5xuqITIOnLJB6JWD+1YQVmgjQgIGRYiRYqvR+yzWR8YRGujp/A
         fz/b2LvW+3NCMP6thJs3A1XqfdZY6Y9K7ADUutvEWPoxlvVTfKX8uB+P8ZGQPWwLXT
         LnoN0au0gOJpT7A7cgSQeRl/cv+tHa5KsppKLdy8=
From:   Olliver Schinagl <oliver@schinagl.nl>
To:     linux-kernel@vger.kernel.org
Cc:     Olliver Schinagl <oliver+list@schinagl.nl>,
        Matt Wagantall <mattw@codeaurora.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Robert Elliott <elliott@hp.com>, Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Olliver Schinagl <oliver@schinagl.nl>
Subject: [PATCH] iopoll: Introduce ioreadX_poll_timeout[_atomic]
Date:   Sun,  4 Sep 2022 21:59:20 +0200
Message-Id: <20220904195920.1763240-1-oliver@schinagl.nl>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the readX_poll_timeout[_atomic] macro's are great, we are actually
encouraged to use ioreadX where possible (LDDv3 C9) [0]. This patch
introduces macro's for our ioreadX friends.

[0]: https://www.oreilly.com/library/view/linux-device-drivers/0596005903/ch09.html

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
---
 include/linux/iopoll.h | 72 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/include/linux/iopoll.h b/include/linux/iopoll.h
index 2c8860e406bd..0e1dbd8057f4 100644
--- a/include/linux/iopoll.h
+++ b/include/linux/iopoll.h
@@ -188,4 +188,76 @@
 #define readq_relaxed_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
 	readx_poll_timeout_atomic(readq_relaxed, addr, val, cond, delay_us, timeout_us)
 
+#define ioread8_poll_timeout(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout(ioread8, addr, val, cond, delay_us, timeout_us)
+
+#define ioread8be_poll_timeout(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout(ioread8be, addr, val, cond, delay_us, timeout_us)
+
+#define ioread8_rep_poll_timeout(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout(ioread8_rep, addr, val, cond, delay_us, timeout_us)
+
+#define ioread8_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout_atomic(ioread8, addr, val, cond, delay_us, timeout_us)
+
+#define ioread8be_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout_atomic(ioread8be, addr, val, cond, delay_us, timeout_us)
+
+#define ioread8_rep_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout_atomic(ioread8_rep, addr, val, cond, delay_us, timeout_us)
+
+#define ioread16_poll_timeout(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout(ioread16, addr, val, cond, delay_us, timeout_us)
+
+#define ioread16be_poll_timeout(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout(ioread16be, addr, val, cond, delay_us, timeout_us)
+
+#define ioread16_rep_poll_timeout(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout(ioread16_rep, addr, val, cond, delay_us, timeout_us)
+
+#define ioread16_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout_atomic(ioread16, addr, val, cond, delay_us, timeout_us)
+
+#define ioread16_rep_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout_atomic(ioread16_rep, addr, val, cond, delay_us, timeout_us)
+
+#define ioread16be_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout_atomic(ioread16be, addr, val, cond, delay_us, timeout_us)
+
+#define ioread32_poll_timeout(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout(ioread32, addr, val, cond, delay_us, timeout_us)
+
+#define ioread32be_poll_timeout(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout(ioread32be, addr, val, cond, delay_us, timeout_us)
+
+#define ioread32_rep_poll_timeout(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout(ioread32_rep, addr, val, cond, delay_us, timeout_us)
+
+#define ioread32_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout_atomic(ioread32, addr, val, cond, delay_us, timeout_us)
+
+#define ioread32be_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout_atomic(ioread32be, addr, val, cond, delay_us, timeout_us)
+
+#define ioread32_rep_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout_atomic(ioread32_rep, addr, val, cond, delay_us, timeout_us)
+
+#define ioread64_poll_timeout(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout(ioread64, addr, val, cond, delay_us, timeout_us)
+
+#define ioread64be_poll_timeout(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout(ioreab64be, addr, val, cond, delay_us, timeout_us)
+
+#define ioread64_rep_poll_timeout(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout(ioread64_rep, addr, val, cond, delay_us, timeout_us)
+
+#define ioread64_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout_atomic(ioread64, addr, val, cond, delay_us, timeout_us)
+
+#define ioread64be_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout_atomic(ioreab64be, addr, val, cond, delay_us, timeout_us)
+
+#define ioread64_rep_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout_atomic(ioread64_rep, addr, val, cond, delay_us, timeout_us)
+
 #endif /* _LINUX_IOPOLL_H */
-- 
2.37.2

