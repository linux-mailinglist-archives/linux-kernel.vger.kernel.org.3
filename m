Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB664AC64D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383196AbiBGQoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351628AbiBGQfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:35:07 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 77051C0401E2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:35:05 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 217GOcOx014396;
        Mon, 7 Feb 2022 17:24:38 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 13/42] tools/nolibc/types: move makedev to types.h and make it a macro
Date:   Mon,  7 Feb 2022 17:23:25 +0100
Message-Id: <20220207162354.14293-14-w@1wt.eu>
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

The makedev() man page says it's supposed to be a macro and that some
OSes have it with the other ones in sys/types.h so it now makes sense
to move it to types.h as a macro. Let's also define major() and
minor() that perform the reverse operation.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/nolibc.h | 9 ---------
 tools/include/nolibc/types.h  | 5 +++++
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 2267d98337ea..23fb81414b1b 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -116,13 +116,4 @@ const char *ltoa(long in)
 	return pos + 1;
 }
 
-/* Here come a few helper functions */
-
-/* WARNING, it only deals with the 4096 first majors and 256 first minors */
-static __attribute__((unused))
-dev_t makedev(unsigned int major, unsigned int minor)
-{
-	return ((major & 0xfff) << 8) | (minor & 0xff);
-}
-
 #endif /* _NOLIBC_H */
diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index 81f69fd5826c..fb4d35f60850 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -162,4 +162,9 @@ struct stat {
 	time_t    st_ctime;   /* time of last status change */
 };
 
+/* WARNING, it only deals with the 4096 first majors and 256 first minors */
+#define makedev(major, minor) ((dev_t)((((major) & 0xfff) << 8) | ((minor) & 0xff)))
+#define major(dev) ((unsigned int)(((dev) >> 8) & 0xfff))
+#define minor(dev) ((unsigned int)(((dev) & 0xff))
+
 #endif /* _NOLIBC_TYPES_H */
-- 
2.35.1

