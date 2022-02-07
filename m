Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26324AC635
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237062AbiBGQnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390544AbiBGQfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:35:01 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2CFD2C0401D1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:35:00 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 217GOemG014408;
        Mon, 7 Feb 2022 17:24:40 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 25/42] tools/nolibc/stdlib: avoid a 64-bit shift in u64toh_r()
Date:   Mon,  7 Feb 2022 17:23:37 +0100
Message-Id: <20220207162354.14293-26-w@1wt.eu>
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

The build of printf() on mips requires libgcc for functions __ashldi3 and
__lshrdi3 due to 64-bit shifts when scanning the input number. These are
not really needed in fact since we scan the number 4 bits at a time. Let's
arrange the loop to perform two 32-bit shifts instead on 32-bit platforms.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/stdlib.h | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/include/nolibc/stdlib.h b/tools/include/nolibc/stdlib.h
index 82a4cf606d3c..db47362a750f 100644
--- a/tools/include/nolibc/stdlib.h
+++ b/tools/include/nolibc/stdlib.h
@@ -200,14 +200,18 @@ int u64toh_r(uint64_t in, char *buffer)
 	int dig;
 
 	do {
-		dig = in >> pos;
-		in -= (uint64_t)dig << pos;
+		if (sizeof(long) >= 8) {
+			dig = (in >> pos) & 0xF;
+		} else {
+			/* 32-bit platforms: avoid a 64-bit shift */
+			uint32_t d = (pos >= 32) ? (in >> 32) : in;
+			dig = (d >> (pos & 31)) & 0xF;
+		}
+		if (dig > 9)
+			dig += 'a' - '0' - 10;
 		pos -= 4;
-		if (dig || digits || pos < 0) {
-			if (dig > 9)
-				dig += 'a' - '0' - 10;
+		if (dig || digits || pos < 0)
 			buffer[digits++] = '0' + dig;
-		}
 	} while (pos >= 0);
 
 	buffer[digits] = 0;
-- 
2.35.1

