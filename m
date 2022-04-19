Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02DA50614B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 03:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243717AbiDSAtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241387AbiDSApR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CAB2DABA
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 888846141C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74504C3411E;
        Tue, 19 Apr 2022 00:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328948;
        bh=si1vYmdDplEcyL6k32D1ObE5ErslbKVkX7iAvHlDeXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VwRsmKheDYD0lhT4aoMGiA0XGvcBBZwcoZfFAffPdnEa0ByxP11ftTYh/KsWnMydx
         9xCNYk30yHuy8tG3DG7TN8nnaaScC6T2HhBBaCU4shdZNEEsabtNs2rg0s2qTfpJj6
         gfImkFv36hUd46b8/4vC9LP/pwisWCuYN6f62QCdf9Hve2hO3j64gFZ9256IMzxQrC
         R3lzwtcvEdUoA5DqSxUi57/wONaFP7v1zKkFUHHitXUJvsp90ME/4yYUqsjLfpI1Kt
         +MG1EfEKf1g0Iqa5zKjGcggCT2PqD9jD5VMp8qOzspljpGvNba+gRCpwd0+u86Bs5V
         0fww0hYZMT1Og==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 575835C3232; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 44/61] tools/nolibc/stdlib: add a simple getenv() implementation
Date:   Mon, 18 Apr 2022 17:42:08 -0700
Message-Id: <20220419004225.3952530-44-paulmck@kernel.org>
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

This implementation relies on an extern definition of the environ
variable, that the caller must declare and initialize from envp.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
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
2.31.1.189.g2e36527f23

