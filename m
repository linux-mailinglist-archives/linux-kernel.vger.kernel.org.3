Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E326251C8D0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 21:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384936AbiEETVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 15:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384925AbiEETVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 15:21:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8533F4B848;
        Thu,  5 May 2022 12:18:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46001B82F20;
        Thu,  5 May 2022 19:18:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F115C385A8;
        Thu,  5 May 2022 19:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651778279;
        bh=m3BSN+54NVRaC/iJQn28GUNDH+kVUNyA61dRWvK4XN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mSTw/aIfNEqccH08hbSo/aXsI2VL0YAw4Ieu2Jzd0J2IjVPyWwbQY4di6KlSItYRo
         3uP2EpdkeJ5+Ay0N818sifX2HJaxG22Y+ooDdybEMJLMV96SkOryXMShF+UxMxG56q
         dz8tMy85+vA8fAaEVapMSEDefhhZdCBtWA9Qioy0ACYzRBoIbd5C+LoJKU1mMQUJxh
         wCUhnPdWECkz85e2qX9L/qwcW8oNyLQ0EZaFSwK9yPg9RmQbW09KwT/TdsyPTyRQv9
         bcMXEcL4q0vRL9A+JsROrs//3ijUaacn2qSWZ8TFnvqe+chGqjHBupb8LuYRfYqY0S
         1SPjirRnGY5DQ==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Changbin Du <changbin.du@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH v1 1/3] kallsyms: avoid hardcoding the buffer size
Date:   Thu,  5 May 2022 21:16:43 +0200
Message-Id: <20220505191704.22812-2-ojeda@kernel.org>
In-Reply-To: <20220505191704.22812-1-ojeda@kernel.org>
References: <20220505191704.22812-1-ojeda@kernel.org>
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

From: Boqun Feng <boqun.feng@gmail.com>

This makes it easier to update the size later on.

Furthermore, a static assert is added to ensure both are updated
when that happens. The relationship used is one that keeps the new
size (512+1) close to the original buffer size (500).

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 scripts/kallsyms.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 8caabddf817c..880c4404731b 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -27,8 +27,18 @@
 
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof(arr[0]))
 
+#define _stringify_1(x)	#x
+#define _stringify(x)	_stringify_1(x)
+
 #define KSYM_NAME_LEN		128
 
+/* A substantially bigger size than the current maximum. */
+#define KSYM_NAME_LEN_BUFFER	512
+_Static_assert(
+	KSYM_NAME_LEN_BUFFER == KSYM_NAME_LEN * 4,
+	"Please keep KSYM_NAME_LEN_BUFFER in sync with KSYM_NAME_LEN"
+);
+
 struct sym_entry {
 	unsigned long long addr;
 	unsigned int len;
@@ -197,15 +207,15 @@ static void check_symbol_range(const char *sym, unsigned long long addr,
 
 static struct sym_entry *read_symbol(FILE *in)
 {
-	char name[500], type;
+	char name[KSYM_NAME_LEN_BUFFER+1], type;
 	unsigned long long addr;
 	unsigned int len;
 	struct sym_entry *sym;
 	int rc;
 
-	rc = fscanf(in, "%llx %c %499s\n", &addr, &type, name);
+	rc = fscanf(in, "%llx %c %" _stringify(KSYM_NAME_LEN_BUFFER) "s\n", &addr, &type, name);
 	if (rc != 3) {
-		if (rc != EOF && fgets(name, 500, in) == NULL)
+		if (rc != EOF && fgets(name, KSYM_NAME_LEN_BUFFER + 1, in) == NULL)
 			fprintf(stderr, "Read error or end of file.\n");
 		return NULL;
 	}
-- 
2.35.3

