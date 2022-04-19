Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33FF50612C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243284AbiDSAre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241325AbiDSApQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBD922BE2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7411F6140D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 517F8C340F3;
        Tue, 19 Apr 2022 00:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328948;
        bh=bdy13tgqOx3aSuE/ziig4w/6vZsrF8Cx81UBzLocFqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ngMK4RG/mCsFW5Rhj5gwV+/w0d6yoz4YV7c3ip2QKBApPQqzguS5cw+ZloQtpjzff
         VERR2/XIrEx3Mhelw9NG76ZLydDF22OIqxeMaKCZ4f2FdO8nKPFVFXJ72mc08+UCVj
         y8brA/clq7yOnSc2xwDkiBxBhObs4fYxfQdX46qeVgwxUjytgXb5cRwMuktdu3KmmC
         zTlr7KB+3kyLcZ7O5EQQof/HOO99DtPfleIUn+STNoPPnJiVj1FJRuP8rr+3TPKbzP
         j1l2ajrXL5dErB+lRvISDc/pko57SsqVdRzbJD50r3yrXwCxnJ5+wy05ab/iqE56pS
         X/5qn0kYJSlbQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 46BF15C313C; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 35/61] tools/nolibc/string: export memset() and memmove()
Date:   Mon, 18 Apr 2022 17:41:59 -0700
Message-Id: <20220419004225.3952530-35-paulmck@kernel.org>
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

"clang -Os" and "gcc -Ofast" without -ffreestanding may ignore memset()
and memmove(), hoping to provide their builtin equivalents, and finally
not find them. Thus we must export these functions for these rare cases.
Note that as they're set in their own sections, they will be eliminated
by the linker if not used. In addition, they do not prevent gcc from
identifying them and replacing them with the shorter "rep movsb" or
"rep stosb" when relevant.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/string.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
index c1661589cb3c..4554b6fcb400 100644
--- a/tools/include/nolibc/string.h
+++ b/tools/include/nolibc/string.h
@@ -47,7 +47,10 @@ void *_nolibc_memcpy_down(void *dst, const void *src, size_t len)
 	return dst;
 }
 
-static __attribute__((unused))
+/* might be ignored by the compiler without -ffreestanding, then found as
+ * missing.
+ */
+__attribute__((weak,unused,section(".text.nolibc_memmove")))
 void *memmove(void *dst, const void *src, size_t len)
 {
 	size_t dir, pos;
@@ -75,7 +78,10 @@ void *memcpy(void *dst, const void *src, size_t len)
 	return _nolibc_memcpy_up(dst, src, len);
 }
 
-static __attribute__((unused))
+/* might be ignored by the compiler without -ffreestanding, then found as
+ * missing.
+ */
+__attribute__((weak,unused,section(".text.nolibc_memset")))
 void *memset(void *dst, int b, size_t len)
 {
 	char *p = dst;
-- 
2.31.1.189.g2e36527f23

