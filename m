Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE2251E030
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 22:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443197AbiEFUjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 16:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443204AbiEFUjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 16:39:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8602BEB3;
        Fri,  6 May 2022 13:35:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2054460B07;
        Fri,  6 May 2022 20:35:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD7CC385A8;
        Fri,  6 May 2022 20:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651869324;
        bh=65ko2VgV4hklZgR4OxvVNIdExSe/uakUcSdJsONNAww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WbdUXGkAtWpHCKf0pJ9f44irXNKgkwGL/vSSu7EhqpaEr1EAZSqdwDUOvtagzrM6j
         fJJIHezSbfv0TnxsDShnCwU/nLIfU50bTnQh3R48nX0NnGrQ2dQCBLupkySMeGyAY2
         3pdPAdU8UV40zh16yPZWhkqBLu8vTThFHLq0thAKqynF5C7AiE06bP6NPPVMCWMByF
         /zHYTxJaGu4hXdzqQo/zJnrBz5VFR8/HejGH8gcmqFzYmMvZNBvqufADUb+A/YbIYo
         1P9s9NrVKIDSYrKL2pLlvz3eAwYuSnAbfkXKItYQMPyA+6iXkWl602Eupk19DPG1Dm
         dUFxCqft/b1Dg==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Changbin Du <changbin.du@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     rust-for-linux@vger.kernel.org
Subject: [PATCH v2 1/3] kallsyms: avoid hardcoding the buffer size
Date:   Fri,  6 May 2022 22:34:22 +0200
Message-Id: <20220506203443.24721-2-ojeda@kernel.org>
In-Reply-To: <20220506203443.24721-1-ojeda@kernel.org>
References: <20220506203443.24721-1-ojeda@kernel.org>
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

Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
v2:
  - Collected Reviewed-by.
  - Use `sizeof(name)` in one instance, suggested by Kees Cook.

 scripts/kallsyms.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 8caabddf817c..82d6508bdf29 100644
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
+		if (rc != EOF && fgets(name, sizeof(name), in) == NULL)
 			fprintf(stderr, "Read error or end of file.\n");
 		return NULL;
 	}
-- 
2.35.3

