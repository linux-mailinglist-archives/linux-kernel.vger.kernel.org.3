Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C3F490164
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 06:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbiAQFeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 00:34:22 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:40390 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbiAQFeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 00:34:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 976F760DFE;
        Mon, 17 Jan 2022 05:34:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62E02C36AEF;
        Mon, 17 Jan 2022 05:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642397654;
        bh=kWktUvUlCwi/4bf68o/bwuJIQH3GPpyvsrJ7wnMnoBE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OtURDb6PW59utsE8hVr0/79W62ePNUA4tQVjY3nMVFl5CxvKTXufJfhUoVXxqT/BG
         8V57TANBlkg7PhVq7dPIXfIq3L90f7y2Blgbaei4b0LxjOnjd/L4AlZyAgMQVCTovY
         6TO4ZFPHSAPkWpLhU/ksEt5PMzsWYjpqqp3Xm8jrxfhdA6kSi2ksPWRw/pwSsgWGGR
         vW+HgPtkHI6+fgClNP+1SbNda4W3tlqB4w/uMTVGLbNaojfNmzAONo0293YY3YTXjp
         mSW0I4Oq64sy7zkipeYL7iNKL9RV3QcFf3JFhYnVbjJqNJN1Wo+5PvuWsXw8K1dHqf
         9CcFwzb9+R76Q==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH v3 03/19] kallsyms: use the correct buffer size for symbols
Date:   Mon, 17 Jan 2022 06:33:33 +0100
Message-Id: <20220117053349.6804-4-ojeda@kernel.org>
In-Reply-To: <20220117053349.6804-1-ojeda@kernel.org>
References: <20220117053349.6804-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boqun Feng <boqun.feng@gmail.com>

The buffered name size should be larger than `KSYM_NAME_LEN`, otherwise
we cannot tell whether the size of a symbol name is too long.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 scripts/kallsyms.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 72ba0fe4e43b..0e37c19d84af 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -27,6 +27,9 @@
 
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof(arr[0]))
 
+#define _stringify_1(x)	#x
+#define _stringify(x)	_stringify_1(x)
+
 #define KSYM_NAME_LEN		512
 
 struct sym_entry {
@@ -197,15 +200,15 @@ static void check_symbol_range(const char *sym, unsigned long long addr,
 
 static struct sym_entry *read_symbol(FILE *in)
 {
-	char name[500], type;
+	char name[KSYM_NAME_LEN+1], type;
 	unsigned long long addr;
 	unsigned int len;
 	struct sym_entry *sym;
 	int rc;
 
-	rc = fscanf(in, "%llx %c %499s\n", &addr, &type, name);
+	rc = fscanf(in, "%llx %c %" _stringify(KSYM_NAME_LEN) "s\n", &addr, &type, name);
 	if (rc != 3) {
-		if (rc != EOF && fgets(name, 500, in) == NULL)
+		if (rc != EOF && fgets(name, KSYM_NAME_LEN + 1, in) == NULL)
 			fprintf(stderr, "Read error or end of file.\n");
 		return NULL;
 	}
-- 
2.34.1

