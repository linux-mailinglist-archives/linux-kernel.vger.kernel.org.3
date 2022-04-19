Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF85506123
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241685AbiDSApx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241096AbiDSApN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A26827CCC
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDA7961386
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08D6C385BB;
        Tue, 19 Apr 2022 00:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328947;
        bh=UmO1hp+XGaTQwCFqLp+65TE9Dy96tWIcIbtYJw8gVdg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=czLeANH/mmnUhlgFBOq6MhswWz0Amwo6bWRkUr6tGVofoKecr03HUjEEpGM2esbGF
         hmGyz+6LQwxhIQ8YDYteZfG7Ozc8smeiAntpPycyKxe0wsljMv860LISP2o/26A3DG
         y2RhwgTfPdu+9tWJ2kjIYLaobpzv2fAsMSaeoPVkrYfTxvvcbG+WEt4TAf3IVh2OBN
         JgKDwjaEE/y0O9BRW7xz0MHWBcSxs1NeGkylrfX+NnBj6D29hYZ9AzMgnoa71tmuUQ
         E+uj7OnK7rGrUay2habDbjCytNgRFjeIxkjNqGOxuUvxDn2dOS0q5I4LRULMBx7ja4
         bXwSFKfmUsFxg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1E6915C23F4; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 13/61] tools/nolibc/types: move makedev to types.h and make it a macro
Date:   Mon, 18 Apr 2022 17:41:37 -0700
Message-Id: <20220419004225.3952530-13-paulmck@kernel.org>
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

The makedev() man page says it's supposed to be a macro and that some
OSes have it with the other ones in sys/types.h so it now makes sense
to move it to types.h as a macro. Let's also define major() and
minor() that perform the reverse operation.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
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
index 563dbbad0496..b1bff5e717b6 100644
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
2.31.1.189.g2e36527f23

