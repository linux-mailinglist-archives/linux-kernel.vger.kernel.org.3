Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8B0500278
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 01:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239212AbiDMXWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 19:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239158AbiDMXW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 19:22:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7079D23BDD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649892003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BGrvBgwYKVcZxNjPAVz0wV8tSGZLIzNr8FbkF5Q7c6c=;
        b=fUUp0c8QjaDU3dfvu3fJh3oyW3x647NxRR7CEOG/rU7Hcirdl6USwFFtoJjYHtTAexSIx5
        SHGenS1tLBnGBDninq7G/DRkbQ1mRSjj7H6XAxcfJAXfgka9GOdZdTn9aF3ws27gi4w3Ml
        QFpE8G5dhwAaN2HK8zAut/DA0Sxgm7A=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-265-0-IDmroPP7iqebaYRhogRQ-1; Wed, 13 Apr 2022 19:20:02 -0400
X-MC-Unique: 0-IDmroPP7iqebaYRhogRQ-1
Received: by mail-qt1-f198.google.com with SMTP id m20-20020a05622a119400b002ef68184e7fso2219907qtk.15
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:20:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BGrvBgwYKVcZxNjPAVz0wV8tSGZLIzNr8FbkF5Q7c6c=;
        b=OanuRGHlgWkd3XGS6ZBv0JUkp93/erllfnCKUWqqEjpqWxY/+PXEOIfL/kO1vHJ9dN
         s5z76+ch4x2RLv2/7zOmudNFfYn/qtwOofc81sgwO4PxMAVQd5bznMl3B3tf9a0mSOYX
         xtEhFyOhBjWhNF929oY1L760Sp1u51VLrRluGSGjc6hYdC5+VnY9YrYJvCsEhvDEZfi7
         J2iPm8H7T3zdiDcVdXkMT2Ov02RL/YbssnMDR5/lsLH/fpHpxdJWQdMSgq8uYBum6B6A
         AixSdmQKoVuO22QKJ4rtWc/OYk3YAP7mBTj0cjBe5mGWzjKmP4odZr64iQ3SLqPRRfhU
         PvGw==
X-Gm-Message-State: AOAM531H3792tPA6/ooYDAN5l1MN11k/O3zbefOlEhSmmfayorMcMkZx
        z5y5mW99WmUGMp2yI273Jr4b/RbVGB5ECEet0crXlXDgMnAtSwPsfsse0jhUlT/W5hBHjm+Hcau
        Sqa0p+4ORCtrJOlA3af7DsQZK
X-Received: by 2002:ac8:7088:0:b0:2f1:89a6:4001 with SMTP id y8-20020ac87088000000b002f189a64001mr5341794qto.588.1649892001938;
        Wed, 13 Apr 2022 16:20:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOD2TTAOnlx406Slej/kYMmagHy+ojVopPnLeDEqApBQ6pl6+0R1x0MQwx/Ef8VLuk5KwadA==
X-Received: by 2002:ac8:7088:0:b0:2f1:89a6:4001 with SMTP id y8-20020ac87088000000b002f189a64001mr5341782qto.588.1649892001687;
        Wed, 13 Apr 2022 16:20:01 -0700 (PDT)
Received: from treble.redhat.com ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id b20-20020a05622a021400b002f08f5658a2sm193925qtx.68.2022.04.13.16.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 16:20:01 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 03/18] objtool: Add sec+offset to warnings
Date:   Wed, 13 Apr 2022 16:19:38 -0700
Message-Id: <76e1ed8e27b6fb3ed584004ad3fb79a95914b7e6.1649891421.git.jpoimboe@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649891421.git.jpoimboe@redhat.com>
References: <cover.1649891421.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change this:

  vmlinux.o: warning: objtool: fixup_exception()+0x2d1: unreachable instruction

to this:

  vmlinux.o: warning: objtool: fixup_exception()+0x2d1: .text+0x76c51: unreachable instruction

It's noisier, but it makes our lives considerably easier.

Make this new 'verbose' mode optional, which will come in handy soon.

Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/include/objtool/warn.h | 39 +++++++++++++---------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/tools/objtool/include/objtool/warn.h b/tools/objtool/include/objtool/warn.h
index dab0dda7c617..a4c6b52a58c9 100644
--- a/tools/objtool/include/objtool/warn.h
+++ b/tools/objtool/include/objtool/warn.h
@@ -15,12 +15,13 @@
 
 extern const char *objname;
 
-static inline char *offstr(struct section *sec, unsigned long offset)
+static inline char *offstr(struct section *sec, unsigned long offset,
+			   bool verbose)
 {
 	bool is_text = (sec->sh.sh_flags & SHF_EXECINSTR);
 	struct symbol *sym = NULL;
-	unsigned long name_off;
-	char *name, *str;
+	char *str;
+	int len;
 
 	if (is_text)
 		sym = find_func_containing(sec, offset);
@@ -28,20 +29,16 @@ static inline char *offstr(struct section *sec, unsigned long offset)
 		sym = find_symbol_containing(sec, offset);
 
 	if (sym) {
-		name = sym->name;
-		name_off = offset - sym->offset;
+		str = malloc(strlen(sym->name) + strlen(sec->name) + 40);
+		len = sprintf(str, "%s%s+0x%lx",
+			      sym->name, is_text ? "()" : "", offset - sym->offset);
+		if (verbose)
+			sprintf(str+len, ": %s+0x%lx", sec->name, offset);
 	} else {
-		name = sec->name;
-		name_off = offset;
+		str = malloc(strlen(sec->name) + 20);
+		sprintf(str, "%s+0x%lx", sec->name, offset);
 	}
 
-	str = malloc(strlen(name) + 20);
-
-	if (sym)
-		sprintf(str, "%s%s+0x%lx", name, is_text ? "()" : "", name_off);
-	else
-		sprintf(str, "%s+0x%lx", name, name_off);
-
 	return str;
 }
 
@@ -52,17 +49,17 @@ static inline char *offstr(struct section *sec, unsigned long offset)
 
 #define WARN_FUNC(format, sec, offset, ...)		\
 ({							\
-	char *_str = offstr(sec, offset);		\
+	char *_str = offstr(sec, offset, true);		\
 	WARN("%s: " format, _str, ##__VA_ARGS__);	\
 	free(_str);					\
 })
 
-#define BT_FUNC(format, insn, ...)			\
-({							\
-	struct instruction *_insn = (insn);		\
-	char *_str = offstr(_insn->sec, _insn->offset); \
-	WARN("  %s: " format, _str, ##__VA_ARGS__);	\
-	free(_str);					\
+#define BT_FUNC(format, insn, ...)				\
+({								\
+	struct instruction *_insn = (insn);			\
+	char *_str = offstr(_insn->sec, _insn->offset, true);	\
+	WARN("  %s: " format, _str, ##__VA_ARGS__);		\
+	free(_str);						\
 })
 
 #define WARN_ELF(format, ...)				\
-- 
2.34.1

