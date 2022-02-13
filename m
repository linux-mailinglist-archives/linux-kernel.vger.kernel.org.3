Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692F44B3A5F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 09:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbiBMIxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 03:53:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiBMIxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 03:53:10 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C2405EDCD
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 00:53:05 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 21D8r1Zg031989;
        Sun, 13 Feb 2022 09:53:01 +0100
Date:   Sun, 13 Feb 2022 09:53:01 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/42] tools/nolibc/types: make FD_SETSIZE configurable
Message-ID: <20220213085301.GB31914@1wt.eu>
References: <20220207162354.14293-1-w@1wt.eu>
 <20220207162354.14293-13-w@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207162354.14293-13-w@1wt.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
v2:
- rebase on top of v2 of previous patch
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
2.35.1
