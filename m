Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA518506131
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242188AbiDSAsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241368AbiDSApR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2944929C8F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7413761411
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F13AC340EE;
        Tue, 19 Apr 2022 00:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328948;
        bh=pMKUJxlDgyiXIIz3wbUuGb7SHTK9BL3YRmJvgpewhGQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C4bePUxgdvbBE5xvfLjASHBuNGihlfWy/j0HEAIEHjVrKYU/eF1/aLPkXVQ5YRPFN
         Dz43ClJGP2UI0uA4GlINSdYeX18iVLDs/Vn2AXtvyIYAZzhyugnl0WK9qsHt7ugDj6
         2/nsQHyOsRQ/u9wrhrMYglYe5VAdeAc9WHEpaim1mKuLnM9SYn/suRB6RnV9/zMuQo
         +clR4rxh0tx8fBLJADEeTPRYAey+AG617T5SwuDRXaSOK0svAiBkQAAT4yga7cEVSd
         MEZ2WENnV2NYm990sS7mI18R0FLXNMarMobg1jHaEecXOjZgViZoL7yMzTAy+qpzdr
         PmGE7GX9/g3iQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 44F455C3132; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 34/61] tools/nolibc/types: define PATH_MAX and MAXPATHLEN
Date:   Mon, 18 Apr 2022 17:41:58 -0700
Message-Id: <20220419004225.3952530-34-paulmck@kernel.org>
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

These ones are often used and commonly set by applications to fallback
values. Let's fix them both to agree on PATH_MAX=4096 by default, as is
already present in linux/limits.h.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/types.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index e0749dc0bd06..e4026e740b56 100644
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
2.31.1.189.g2e36527f23

