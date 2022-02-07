Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88CF54AC654
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383550AbiBGQoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390507AbiBGQe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:34:56 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 927EDC0401DA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:34:52 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 217GOfPn014418;
        Mon, 7 Feb 2022 17:24:41 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 34/42] tools/nolibc/types: define PATH_MAX and MAXPATHLEN
Date:   Mon,  7 Feb 2022 17:23:46 +0100
Message-Id: <20220207162354.14293-35-w@1wt.eu>
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

These ones are often used and commonly set by applications to fallback
values. Let's fix them both to agree on PATH_MAX=4096 by default, as is
already present in linux/limits.h.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/types.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index dac1cc186dab..9ab922bc2f09 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -49,6 +49,17 @@
 #define FD_SETSIZE     256
 #endif
 
+/* PATH_MAX and MAXPATHLEN are often used and found with plenty of different
+ * values.
+ */
+#ifndef PATH_MAX
+#define PATH_MAX       4096
+#endif
+
+#ifndef MAXPATHLEN
+#define MAXPATHLEN     (PATH_MAX)
+#endif
+
 /* Special FD used by all the *at functions */
 #ifndef AT_FDCWD
 #define AT_FDCWD       (-100)
-- 
2.35.1

