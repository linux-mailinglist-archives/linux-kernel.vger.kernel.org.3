Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0494E3C60
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 11:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbiCVKXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 06:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbiCVKXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 06:23:25 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B85F80239
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 03:21:54 -0700 (PDT)
Received: from integral2.. (unknown [182.2.69.158])
        by gnuweeb.org (Postfix) with ESMTPSA id 1429F7E337;
        Tue, 22 Mar 2022 10:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1647944513;
        bh=V1krABsPZ17e1z+Qe7nb1l0Lb2juQEQNEq83Qg0iKqs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LJuHOmOqi1WzLHHHhvu29FB/FfiPGXUMvTUoErRz0j0xu96Cvn5Yvo2jbaSRZNC2+
         lfBlsRCX9XFZ5I2OKIOyLI4JQuA5npVpMDer1KMVSo0JEJbv+4/pnjLIjLO9FqjCKd
         Rn0SPSB1l74gWhNkklRbuWxPxhRutHwuqGSH9MhnoLiZTSsDy/FLQXkWA0Furalszx
         QcAi/ppH+J4uV5oM4L6wFfDA6BXJdv6omCDDP1IEMcp7EF9kmSi7LrOrtgQiyzs7cn
         VuHexLNTbrpXN8g6PdWVHq/mb9AXindGVAhfias0G8JxHHD0YdqQYHsv8ERcdCcR57
         uAncV4TQvTN4w==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: [RFC PATCH v2 5/8] tools/nolibc/types: Implement `offsetof()` and `container_of()` macro
Date:   Tue, 22 Mar 2022 17:21:12 +0700
Message-Id: <20220322102115.186179-6-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220322102115.186179-1-ammarfaizi2@gnuweeb.org>
References: <20220322102115.186179-1-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement `offsetof()` and `container_of()` macro. The first use case
of these macros is for `malloc()`, `realloc()` and `free()`.

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 tools/include/nolibc/types.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index 357e60ad38a8..959997034e55 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -191,4 +191,15 @@ struct stat {
 #define major(dev) ((unsigned int)(((dev) >> 8) & 0xfff))
 #define minor(dev) ((unsigned int)(((dev) & 0xff))
 
+#ifndef offsetof
+#define offsetof(TYPE, FIELD) ((size_t) &((TYPE *)0)->FIELD)
+#endif
+
+#ifndef container_of
+#define container_of(PTR, TYPE, FIELD) ({			\
+	__typeof__(((TYPE *)0)->FIELD) *__FIELD_PTR = (PTR);	\
+	(TYPE *)((char *) __FIELD_PTR - offsetof(TYPE, FIELD));	\
+})
+#endif
+
 #endif /* _NOLIBC_TYPES_H */
-- 
Ammar Faizi

