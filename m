Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C789531C15
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239158AbiEWQsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 12:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238868AbiEWQsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 12:48:35 -0400
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F280D64711;
        Mon, 23 May 2022 09:48:28 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 24NGlJD3027017;
        Tue, 24 May 2022 01:47:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 24NGlJD3027017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1653324442;
        bh=OPPqcQX7KRBrP4YgLtPFe5APY9NxrEXk3WDczoy7XFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KXobn1tM1jO44veJR9t6DyZzix/Smavyiyz/0ke8gujtlblK2LG98W2h97RT36vGc
         K2lxPHqfZqv1gjnr6Jreae4moShUp+H0IRyE/YblJzFBFHavCF+S39CrnA8oSiA/56
         YXxJLJC8oCWV9ncTyfFwX9eqXW1grGGvmiyBJ3sd7j6Xh5MjSqtRMOOgQeyfKfxB+B
         TBsx4GVKQa8SAXNnLY16QsK+oEdTDAKtxcQat/RduDumC+PH2KadmJWcuO1TBGj2IB
         6dWRdBiYh/nzCeDlIRGpA2f3oMjtewPtZ84ywRmw4HJk6WkQrx+e8CgKKCur24mPeA
         vEp7aGJ3/Hxdw==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 4/5] modpost: reuse ARRAY_SIZE() macro for section_mismatch()
Date:   Tue, 24 May 2022 01:46:25 +0900
Message-Id: <20220523164626.858340-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220523164626.858340-1-masahiroy@kernel.org>
References: <20220523164626.858340-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move ARRAY_SIZE() from file2alias.c to modpost.h to reuse it in
section_mismatch().

Also, move the variable 'check' inside the for-loop.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/file2alias.c | 2 --
 scripts/mod/modpost.c    | 7 +++----
 scripts/mod/modpost.h    | 3 +++
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 5258247d78ac..e8a9c6816fec 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -734,8 +734,6 @@ static int do_vio_entry(const char *filename, void *symval,
 	return 1;
 }
 
-#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
-
 static void do_input(char *alias,
 		     kernel_ulong_t *arr, unsigned int min, unsigned int max)
 {
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 77c315dea1a3..48a18b59f908 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1049,8 +1049,6 @@ static const struct sectioncheck *section_mismatch(
 		const char *fromsec, const char *tosec)
 {
 	int i;
-	int elems = sizeof(sectioncheck) / sizeof(struct sectioncheck);
-	const struct sectioncheck *check = &sectioncheck[0];
 
 	/*
 	 * The target section could be the SHT_NUL section when we're
@@ -1061,14 +1059,15 @@ static const struct sectioncheck *section_mismatch(
 	if (*tosec == '\0')
 		return NULL;
 
-	for (i = 0; i < elems; i++) {
+	for (i = 0; i < ARRAY_SIZE(sectioncheck); i++) {
+		const struct sectioncheck *check = &sectioncheck[i];
+
 		if (match(fromsec, check->fromsec)) {
 			if (check->bad_tosec[0] && match(tosec, check->bad_tosec))
 				return check;
 			if (check->good_tosec[0] && !match(tosec, check->good_tosec))
 				return check;
 		}
-		check++;
 	}
 	return NULL;
 }
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index d9daeff07b83..044bdfb894b7 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -97,6 +97,9 @@ static inline void __endian(const void *src, void *dest, unsigned int size)
 #endif
 
 #define NOFAIL(ptr)   do_nofail((ptr), #ptr)
+
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+
 void *do_nofail(void *ptr, const char *expr);
 
 struct buffer {
-- 
2.32.0

