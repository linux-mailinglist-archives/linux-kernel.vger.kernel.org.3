Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0466586EE5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 18:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbiHAQnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 12:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234067AbiHAQnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 12:43:35 -0400
Received: from aer-iport-7.cisco.com (aer-iport-7.cisco.com [173.38.203.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF72F18B29
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 09:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3003; q=dns/txt; s=iport;
  t=1659372213; x=1660581813;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aIAK846sIpxUUs2d60/tr8U/J7UlBFB97uLmPz10M+M=;
  b=QGvilqvLM+fXK504u8rBofSlY7j+w2Z9fyqYWoCF57UAg3t6O1gaUpna
   Gc7UKFL/tNQ68f9d7YoO7fK8zR89G6J6iSwLe84JazxueK/5ASj77PVhs
   xNBAUt9hN4CJnhuzuT93uu53OVe6KPZvBBo/la5AsUc4soU5kBzbgWjPM
   I=;
X-IronPort-AV: E=Sophos;i="5.93,208,1654560000"; 
   d="scan'208";a="664572"
Received: from aer-iport-nat.cisco.com (HELO aer-core-1.cisco.com) ([173.38.203.22])
  by aer-iport-7.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 01 Aug 2022 16:43:30 +0000
Received: from hce-anki.rd.cisco.com ([10.47.79.243])
        by aer-core-1.cisco.com (8.15.2/8.15.2) with ESMTP id 271GhT0Q012552;
        Mon, 1 Aug 2022 16:43:30 GMT
From:   Hans-Christian Noren Egtvedt <hegtvedt@cisco.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Yury Norov <yury.norov@gmail.com>,
        Allison Randal <allison@lohutok.net>,
        Joe Perches <joe@perches.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Torsten Hilbrich <torsten.hilbrich@secunet.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hans-Christian Noren Egtvedt <hegtvedt@cisco.com>
Subject: [v4.9 PATCH v2 1/6] include/uapi/linux/swab.h: fix userspace breakage, use __BITS_PER_LONG for swap
Date:   Mon,  1 Aug 2022 18:43:23 +0200
Message-Id: <20220801164328.2205839-1-hegtvedt@cisco.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.47.79.243, [10.47.79.243]
X-Outbound-Node: aer-core-1.cisco.com
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Borntraeger <borntraeger@de.ibm.com>

QEMU has a funny new build error message when I use the upstream kernel
headers:

      CC      block/file-posix.o
    In file included from /home/cborntra/REPOS/qemu/include/qemu/timer.h:4,
                     from /home/cborntra/REPOS/qemu/include/qemu/timed-average.h:29,
                     from /home/cborntra/REPOS/qemu/include/block/accounting.h:28,
                     from /home/cborntra/REPOS/qemu/include/block/block_int.h:27,
                     from /home/cborntra/REPOS/qemu/block/file-posix.c:30:
    /usr/include/linux/swab.h: In function `__swab':
    /home/cborntra/REPOS/qemu/include/qemu/bitops.h:20:34: error: "sizeof" is not defined, evaluates to 0 [-Werror=undef]
       20 | #define BITS_PER_LONG           (sizeof (unsigned long) * BITS_PER_BYTE)
          |                                  ^~~~~~
    /home/cborntra/REPOS/qemu/include/qemu/bitops.h:20:41: error: missing binary operator before token "("
       20 | #define BITS_PER_LONG           (sizeof (unsigned long) * BITS_PER_BYTE)
          |                                         ^
    cc1: all warnings being treated as errors
    make: *** [/home/cborntra/REPOS/qemu/rules.mak:69: block/file-posix.o] Error 1
    rm tests/qemu-iotests/socket_scm_helper.o

This was triggered by commit d5767057c9a ("uapi: rename ext2_swab() to
swab() and share globally in swab.h").  That patch is doing

  #include <asm/bitsperlong.h>

but it uses BITS_PER_LONG.

The kernel file asm/bitsperlong.h provide only __BITS_PER_LONG.

Let us use the __ variant in swap.h

Link: http://lkml.kernel.org/r/20200213142147.17604-1-borntraeger@de.ibm.com
Fixes: d5767057c9a ("uapi: rename ext2_swab() to swab() and share globally in swab.h")
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Yury Norov <yury.norov@gmail.com>
Cc: Allison Randal <allison@lohutok.net>
Cc: Joe Perches <joe@perches.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: Torsten Hilbrich <torsten.hilbrich@secunet.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
(cherry picked from commit 467d12f5c7842896d2de3ced74e4147ee29e97c8)
Signed-off-by: Hans-Christian Noren Egtvedt <hegtvedt@cisco.com>
---
 include/uapi/linux/swab.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/swab.h b/include/uapi/linux/swab.h
index 1f42d110987..51502eabdb0 100644
--- a/include/uapi/linux/swab.h
+++ b/include/uapi/linux/swab.h
@@ -134,9 +134,9 @@ static inline __attribute_const__ __u32 __fswahb32(__u32 val)
 
 static __always_inline unsigned long __swab(const unsigned long y)
 {
-#if BITS_PER_LONG == 64
+#if __BITS_PER_LONG == 64
 	return __swab64(y);
-#else /* BITS_PER_LONG == 32 */
+#else /* __BITS_PER_LONG == 32 */
 	return __swab32(y);
 #endif
 }
-- 
2.34.1

