Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68EE50610E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbiDSAqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241192AbiDSApO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C282B19F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 508EF613F1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0775C385B6;
        Tue, 19 Apr 2022 00:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328947;
        bh=DJezPgdQVx7Xqos2h9pBVVxFTllTTI0ZE3fr3CMglNM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LFzJFBcztbSWEXa+cV0rA0BSmvuyao8TeL1MTYPheMhGbwSKuQep+WaKwE2CcDubk
         0ZReY0Ddvpul8TYBl4QCw4YEtgCWQLwbAvkrZ9bAAV9tnHi8tnDUXcGjuNeALsefSR
         uwpYDkvtQKdVUq0+KVRaIDAxP418Dld0yyN0yAQ4zWqbw4uMVX34whXzb5RSKgOx6B
         jWl8heY0DIaVgDW2FHyL/BVVuCf06Lc97TAhfQCNm8/xQ2Y/nkpDU+PjfnmXVrAzVl
         BVVYMrqmA1AqV81vj6EhlaN730smO0qs7Ux5Odb0UhAGeGeucjuwaRyQBIezb9DyrG
         4iqhc+dqrC3Kg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1C73B5C1369; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 12/61] tools/nolibc/types: make FD_SETSIZE configurable
Date:   Mon, 18 Apr 2022 17:41:36 -0700
Message-Id: <20220419004225.3952530-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419004219.GA3952301@paulmck-ThinkPad-P17-Gen-1>
References: <20220419004219.GA3952301@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Willy Tarreau <w@1wt.eu>

The macro was hard-coded to 256 but it's common to see it redefined.
Let's support this and make sure we always allocate enough entries for
the cases where it wouldn't be multiple of 32.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/types.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index a4dda0a22fc2..563dbbad0496 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -45,7 +45,9 @@
 #define DT_SOCK        0xc
 
 /* commonly an fd_set represents 256 FDs */
+#ifndef FD_SETSIZE
 #define FD_SETSIZE     256
+#endif
 
 /* Special FD used by all the *at functions */
 #ifndef AT_FDCWD
@@ -72,7 +74,7 @@
 
 /* for select() */
 typedef struct {
-	uint32_t fd32[FD_SETSIZE / 32];
+	uint32_t fd32[(FD_SETSIZE + 31) / 32];
 } fd_set;
 
 #define FD_CLR(fd, set) do {                                            \
@@ -101,7 +103,7 @@ typedef struct {
 #define FD_ZERO(set) do {                                               \
 		fd_set *__set = (set);                                  \
 		int __idx;                                              \
-		for (__idx = 0; __idx < FD_SETSIZE / 32; __idx ++)      \
+		for (__idx = 0; __idx < (FD_SETSIZE+31) / 32; __idx ++) \
 			__set->fd32[__idx] = 0;                         \
 	} while (0)
 
-- 
2.31.1.189.g2e36527f23

