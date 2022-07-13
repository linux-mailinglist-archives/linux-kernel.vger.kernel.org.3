Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4BC573817
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 15:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236367AbiGMNzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 09:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236377AbiGMNzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 09:55:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69612CDF7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 06:55:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74584B81FE6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 13:55:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF2CC34114;
        Wed, 13 Jul 2022 13:55:43 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="LpCif7I6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1657720541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=bawxo4wQSGz34zHaH54dBSzxxCoLrOF8mCeNb04Rm14=;
        b=LpCif7I6a9KEjcnOn0R4l//g3IiGbLp/2ehMOTGzXhHWltiluo5tYN0mgszeUy3mQ84Ldg
        R658zg4D3TizZSIv/KDx+sEOUDbS2Bhswc7ENI2rbK12NDoZQxZ7r66CqOymwebCrrREda
        sX/Ve7oQDI2VhP/qlZGr+3Npjnm78+Q=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8cc883ad (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 13 Jul 2022 13:55:41 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     johannes@sipsolutions.net, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] um: remove stray ) in macro expression
Date:   Wed, 13 Jul 2022 15:55:39 +0200
Message-Id: <20220713135539.919429-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A commit erroneously added a stray ), causing compile errors:

In file included from /home/zx2c4/Projects/wireguard-linux/crypto/xor.c:17:
/home/zx2c4/Projects/wireguard-linux/crypto/xor.c: In function ‘register_xor_blocks’:
/home/zx2c4/Projects/wireguard-linux/arch/um/include/asm/xor.h:21:74: error: expected ‘;’ before ‘)’ token
   21 |         (time_travel_mode == TT_MODE_INFCPU ? TT_CPU_INF_XOR_DEFAULT : x))
      |                                                                          ^
/home/zx2c4/Projects/wireguard-linux/crypto/xor.c:66:27: note: in expansion of macro ‘XOR_SELECT_TEMPLATE’
   66 |         active_template = XOR_SELECT_TEMPLATE(NULL);
      |                           ^~~~~~~~~~~~~~~~~~~
/home/zx2c4/Projects/wireguard-linux/arch/um/include/asm/xor.h:21:74: error: expected statement before ‘)’ token
   21 |         (time_travel_mode == TT_MODE_INFCPU ? TT_CPU_INF_XOR_DEFAULT : x))
      |                                                                          ^
/home/zx2c4/Projects/wireguard-linux/crypto/xor.c:66:27: note: in expansion of macro ‘XOR_SELECT_TEMPLATE’
   66 |         active_template = XOR_SELECT_TEMPLATE(NULL);
      |                           ^~~~~~~~~~~~~~~~~~~
/home/zx2c4/Projects/wireguard-linux/crypto/xor.c: In function ‘calibrate_xor_blocks’:
/home/zx2c4/Projects/wireguard-linux/arch/um/include/asm/xor.h:21:74: error: expected ‘;’ before ‘)’ token
   21 |         (time_travel_mode == TT_MODE_INFCPU ? TT_CPU_INF_XOR_DEFAULT : x))
      |                                                                          ^
/home/zx2c4/Projects/wireguard-linux/crypto/xor.c:124:19: note: in expansion of macro ‘XOR_SELECT_TEMPLATE’
  124 |         fastest = XOR_SELECT_TEMPLATE(NULL);
      |                   ^~~~~~~~~~~~~~~~~~~
/home/zx2c4/Projects/wireguard-linux/arch/um/include/asm/xor.h:21:74: error: expected statement before ‘)’ token
   21 |         (time_travel_mode == TT_MODE_INFCPU ? TT_CPU_INF_XOR_DEFAULT : x))
      |                                                                          ^
/home/zx2c4/Projects/wireguard-linux/crypto/xor.c:124:19: note: in expansion of macro ‘XOR_SELECT_TEMPLATE’
  124 |         fastest = XOR_SELECT_TEMPLATE(NULL);
      |                   ^~~~~~~~~~~~~~~~~~~
  CC      fs/namei.o
make[3]: *** [/home/zx2c4/Projects/wireguard-linux/scripts/Makefile.build:249: crypto/xor.o] Error 1
make[3]: *** Waiting for unfinished jobs....

Fixes: e3a33af812c6 ("um: fix and optimize xor select template for CONFIG64 and timetravel mode")
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/um/include/asm/xor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/include/asm/xor.h b/arch/um/include/asm/xor.h
index 22b39de73c24..647fae200c5d 100644
--- a/arch/um/include/asm/xor.h
+++ b/arch/um/include/asm/xor.h
@@ -18,7 +18,7 @@
 #undef XOR_SELECT_TEMPLATE
 /* pick an arbitrary one - measuring isn't possible with inf-cpu */
 #define XOR_SELECT_TEMPLATE(x)	\
-	(time_travel_mode == TT_MODE_INFCPU ? TT_CPU_INF_XOR_DEFAULT : x))
+	(time_travel_mode == TT_MODE_INFCPU ? TT_CPU_INF_XOR_DEFAULT : x)
 #endif
 
 #endif
-- 
2.35.1

