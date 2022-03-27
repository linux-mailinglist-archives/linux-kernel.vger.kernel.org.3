Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713AE4E891B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 19:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236163AbiC0RfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 13:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbiC0RfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 13:35:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9772F4AE2F;
        Sun, 27 Mar 2022 10:33:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5159FB80D60;
        Sun, 27 Mar 2022 17:33:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7E1BC340EC;
        Sun, 27 Mar 2022 17:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648402418;
        bh=tjfrzTXUP10JWkL6oPjMYE35EKBK417x0WxwMGZ4myI=;
        h=From:To:Cc:Subject:Date:From;
        b=DXqy42CcUS1rjGd1vGkHK4CONo+k2b9lZTJdciTZ4xLOG9nN1PxSzXXPSGQSubAFF
         Kxl0lc8+TI8nmxSxbMui7RaOLBI5hdHNPS7YItyYQzkrZAK1B1AoDKmmJ4qVv9tRi4
         KBDaiWkEA+U80GydpKtftOkbkry/aILqcGW/FYyfEtHEjbgbM0kVOdCMy2o8HCSVpo
         RHLOq3bV8iSItjDeCu7Y5MN4ZAslQF5LfHUo+utRBEDSyTs3GDXyawgCJV8zBOP2VW
         BLb2TfSDFSl9xaM5tFXaIsf1vOjklYKO1alKqSwi2mYqNRqXdIMEPE0DMk6pKMEF9N
         wVoKzoY8vAotA==
From:   kbusch@kernel.org
To:     linux-block@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH] block: move lower_48_bits() to block
Date:   Sun, 27 Mar 2022 11:33:16 -0600
Message-Id: <20220327173316.315-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.17.2
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

The function is not generally applicable enough to be included in the core
kernel header. Move it to block since it's the only subsystem using it.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/linux/kernel.h | 9 ---------
 include/linux/t10-pi.h | 9 +++++++++
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 08ba5995aa8b..a890428bcc1a 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -63,15 +63,6 @@
 }					\
 )
 
-/**
- * lower_48_bits() - return bits 0-47 of a number
- * @n: the number we're accessing
- */
-static inline u64 lower_48_bits(u64 n)
-{
-	return n & ((1ull << 48) - 1);
-}
-
 /**
  * upper_32_bits - return bits 32-63 of a number
  * @n: the number we're accessing
diff --git a/include/linux/t10-pi.h b/include/linux/t10-pi.h
index a4b1af581f69..248f4ac95642 100644
--- a/include/linux/t10-pi.h
+++ b/include/linux/t10-pi.h
@@ -59,6 +59,15 @@ struct crc64_pi_tuple {
 	__u8   ref_tag[6];
 };
 
+/**
+ * lower_48_bits() - return bits 0-47 of a number
+ * @n: the number we're accessing
+ */
+static inline u64 lower_48_bits(u64 n)
+{
+	return n & ((1ull << 48) - 1);
+}
+
 static inline u64 ext_pi_ref_tag(struct request *rq)
 {
 	unsigned int shift = ilog2(queue_logical_block_size(rq->q));
-- 
2.17.2

