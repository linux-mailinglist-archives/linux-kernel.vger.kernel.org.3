Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29CBE4AC649
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382414AbiBGQoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390553AbiBGQfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:35:03 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D02DC0401D1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:35:02 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 217GOcUE014395;
        Mon, 7 Feb 2022 17:24:38 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 12/42] tools/nolibc/types: make FD_SETSIZE configurable
Date:   Mon,  7 Feb 2022 17:23:24 +0100
Message-Id: <20220207162354.14293-13-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20220207162354.14293-1-w@1wt.eu>
References: <20220207162354.14293-1-w@1wt.eu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro was hard-coded to 256 but it's common to see it redefined.
Let's support this and make sure we always allocate enough entries for
the cases where it wouldn't be multiple of 32.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/types.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index b79e10025780..81f69fd5826c 100644
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
 		int __idx;                                              \
 		fd_set *__set = (fd_set *)(set);                        \
-		for (__idx = 0; __idx < FD_SETSIZE / 32; __idx ++)      \
+		for (__idx = 0; __idx < (FD_SETSIZE+31) / 32; __idx ++)	\
 			__set->fd32[__idx] = 0;                         \
 	} while (0)
 
-- 
2.35.1

