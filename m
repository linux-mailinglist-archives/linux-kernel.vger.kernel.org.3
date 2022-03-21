Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6454E2F1A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 18:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349206AbiCURfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 13:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348534AbiCURe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 13:34:57 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C1F2566617
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 10:33:30 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 22LHXNrS007571;
        Mon, 21 Mar 2022 18:33:23 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: [PATCH 2/8] tools/nolibc/stdlib: add a simple getenv() implementation
Date:   Mon, 21 Mar 2022 18:33:08 +0100
Message-Id: <20220321173314.7519-3-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20220321173314.7519-1-w@1wt.eu>
References: <20220321173314.7519-1-w@1wt.eu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This implementation relies on an extern definition of the environ
variable, that the caller must declare and initialize from envp.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/stdlib.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/include/nolibc/stdlib.h b/tools/include/nolibc/stdlib.h
index 733105c574ee..aca8616335e3 100644
--- a/tools/include/nolibc/stdlib.h
+++ b/tools/include/nolibc/stdlib.h
@@ -60,6 +60,29 @@ int atoi(const char *s)
 	return atol(s);
 }
 
+/* Tries to find the environment variable named <name> in the environment array
+ * pointed to by global variable "environ" which must be declared as a char **,
+ * and must be terminated by a NULL (it is recommended to set this variable to
+ * the "envp" argument of main()). If the requested environment variable exists
+ * its value is returned otherwise NULL is returned.
+ */
+static __attribute__((unused))
+char *getenv(const char *name)
+{
+	extern char **environ;
+	int idx, i;
+
+	if (environ) {
+		for (idx = 0; environ[idx]; idx++) {
+			for (i = 0; name[i] && name[i] == environ[idx][i];)
+				i++;
+			if (!name[i] && environ[idx][i] == '=')
+				return &environ[idx][i+1];
+		}
+	}
+	return NULL;
+}
+
 /* Converts the unsigned long integer <in> to its hex representation into
  * buffer <buffer>, which must be long enough to store the number and the
  * trailing zero (17 bytes for "ffffffffffffffff" or 9 for "ffffffff"). The
-- 
2.35.1

