Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCC050613C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 03:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242877AbiDSAtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241355AbiDSApR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290D22AC51
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8649761414
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F625C385D3;
        Tue, 19 Apr 2022 00:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328948;
        bh=RBEg4sZg2GUtm8F+2yQeNOCWMkwo4ljqlX2gODDUP64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hNJ8C457UBusnNn8v2YZLcxQ8/NEJtZdvZDTQsHp/jpMAxUrOHPDCY/AxKlXTDl4a
         NCRca43b+4ZWE14EzD1JnDCrhE6obQFqoptc7dJRm2moJ1DWghqeCZfYejr26GCXGy
         ilLdDfck3TT/79IMpVKmqbsBPU6hLeGWV9PayI1NB2r4YpZUTTzEmN74OUXPQxOvWe
         lY2ohnahIyqVRkUVHf3QqftCfAk2tf66nSdxzCu2Nk/ET8mNEjDWDVLh1HKkxZ40TR
         CxJG2DaxVNXDdvw/bGF/uGMIqcdlkRmDU6bHQH6eeGic1P57MwrYMe4pMVdqzZPF2B
         3eHba+Rg6UAbw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3A7065C30FF; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 28/61] tools/nolibc/string: use unidirectional variants for memcpy()
Date:   Mon, 18 Apr 2022 17:41:52 -0700
Message-Id: <20220419004225.3952530-28-paulmck@kernel.org>
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

Till now memcpy() relies on memmove(), but it's always included for libgcc,
so we have a larger than needed function. Let's implement two unidirectional
variants to copy from bottom to top and from top to bottom, and use the
former for memcpy(). The variants are optimized to be compact, and at the
same time the compiler is sometimes able to detect the loop and to replace
it with a "rep movsb". The new function is 24 bytes instead of 52 on x86_64.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/string.h | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
index 8a23cda2d450..6d8fad7a92e6 100644
--- a/tools/include/nolibc/string.h
+++ b/tools/include/nolibc/string.h
@@ -25,6 +25,28 @@ int memcmp(const void *s1, const void *s2, size_t n)
 	return c1;
 }
 
+static __attribute__((unused))
+void *_nolibc_memcpy_up(void *dst, const void *src, size_t len)
+{
+	size_t pos = 0;
+
+	while (pos < len) {
+		((char *)dst)[pos] = ((const char *)src)[pos];
+		pos++;
+	}
+	return dst;
+}
+
+static __attribute__((unused))
+void *_nolibc_memcpy_down(void *dst, const void *src, size_t len)
+{
+	while (len) {
+		len--;
+		((char *)dst)[len] = ((const char *)src)[len];
+	}
+	return dst;
+}
+
 static __attribute__((unused))
 void *memmove(void *dst, const void *src, size_t len)
 {
@@ -42,7 +64,7 @@ void *memmove(void *dst, const void *src, size_t len)
 __attribute__((weak,unused))
 void *memcpy(void *dst, const void *src, size_t len)
 {
-	return memmove(dst, src, len);
+	return _nolibc_memcpy_up(dst, src, len);
 }
 
 static __attribute__((unused))
-- 
2.31.1.189.g2e36527f23

