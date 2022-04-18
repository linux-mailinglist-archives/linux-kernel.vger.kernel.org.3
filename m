Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF4B505CD9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 18:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346485AbiDRQyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 12:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346530AbiDRQxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 12:53:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9686C3337E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650300672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x9Fz+Xc8RoGhISO17r8oqMWhPNYKVczvw/S/wtXruE8=;
        b=TXc8k1lX28H+jxqwBqEF8/mSreSqlmRKLe0q63WejVhdL59POmuk6zXqJVS2v1k7X4Ld9Q
        RTRp+fCjfNQgfcovV66hQ9k7jxIoi9TRflhlXfXaZpCqsLBESX8xisnfdtrXiM7C5umCyv
        PBNeYfBNoB1vo/wGiIo55Mq25Bks9gI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-58-wk0xCG6vN12dc_HJz4oq4g-1; Mon, 18 Apr 2022 12:51:11 -0400
X-MC-Unique: wk0xCG6vN12dc_HJz4oq4g-1
Received: by mail-qt1-f198.google.com with SMTP id s9-20020ac87589000000b002e1cfb25db9so2060767qtq.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:51:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x9Fz+Xc8RoGhISO17r8oqMWhPNYKVczvw/S/wtXruE8=;
        b=dBg39bdWPRQw/BDdgiqX5ye/5CJE7hXFIusVibfirY6o8m/RmqgUSgr+1pfnTvNqQG
         /gLd0HfMJFaamONYsaWAbDMNql4HMJyf4ajJBR65OJBKHlpyfZZ6wwS5ectxREdrxcXk
         MzjyDMW5ATTdqKvgh3V5Utw3k0u9ZNZ525idiTGo0E4z2uOQZP+pOW8RQlqKn2lB0qqZ
         VWLQzH1sSghVcWbvWa1Mbj+WZnCwpmoL7KXBIfPT0+biMk5i+kmlXb+sunvPZHtU/lKS
         DsTkm2x8ZexUzts7TMmNyD2fw3Bit5xRff3ilHKP5lkTdjC+ct0BlV8oadZQCsCPjE8C
         gT7w==
X-Gm-Message-State: AOAM532zrkULyGltP+F/0F3XRD9lzkcRQRnq6FIRNmvWj8gexyzotFkD
        ynS+4QXmgWmHRObupEdekRfv5eem+q+yVdHHXlWg0+rVnbYq4kZ60svUFjfdVc5sPWus/+i+kZY
        GekxS3VqEEDMbKuWDfwtvB3uD
X-Received: by 2002:ac8:590e:0:b0:2e1:dcaf:bbb6 with SMTP id 14-20020ac8590e000000b002e1dcafbbb6mr7591137qty.644.1650300670762;
        Mon, 18 Apr 2022 09:51:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwoacZs4E+r8OSfJFZkgztLmXpm2DEK+jp7Kds0Xtg7vwOt61QvoeNvi5Ah8ZbViMiVka4j/g==
X-Received: by 2002:ac8:590e:0:b0:2e1:dcaf:bbb6 with SMTP id 14-20020ac8590e000000b002e1dcafbbb6mr7591122qty.644.1650300670509;
        Mon, 18 Apr 2022 09:51:10 -0700 (PDT)
Received: from treble.redhat.com ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id e15-20020ac8670f000000b002e22d9c756dsm7277059qtp.30.2022.04.18.09.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:51:10 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v2 12/25] objtool: Add option to print section addresses
Date:   Mon, 18 Apr 2022 09:50:31 -0700
Message-Id: <2cea4d5299d53d1a4c09212a6ad7820aa46fda7a.1650300597.git.jpoimboe@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650300597.git.jpoimboe@redhat.com>
References: <cover.1650300597.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To help prevent objtool users from having to do math to convert function
addresses to section addresses, and to help out with finding data
addresses reported by IBT validation, add an option to print the section
address in addition to the function address.

Normal:

  vmlinux.o: warning: objtool: fixup_exception()+0x2d1: unreachable instruction

With '--sec-address':

  vmlinux.o: warning: objtool: fixup_exception()+0x2d1 (.text+0x76c51): unreachable instruction

Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/builtin-check.c           |  1 +
 tools/objtool/include/objtool/builtin.h |  1 +
 tools/objtool/include/objtool/warn.h    | 31 ++++++++++++++-----------
 3 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 8c3eed5b67e4..6acfebd2c6ca 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -50,6 +50,7 @@ const struct option check_options[] = {
 	OPT_BOOLEAN(0, "module", &opts.module, "object is part of a kernel module"),
 	OPT_BOOLEAN(0, "no-fp", &opts.no_fp, "skip frame pointer validation"),
 	OPT_BOOLEAN(0, "no-unreachable", &opts.no_unreachable, "skip 'unreachable instruction' warnings"),
+	OPT_BOOLEAN(0, "sec-address", &opts.sec_address, "print section addresses in warnings"),
 	OPT_BOOLEAN(0, "stats", &opts.stats, "print statistics"),
 	OPT_BOOLEAN(0, "vmlinux", &opts.vmlinux, "vmlinux.o validation"),
 
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/objtool/builtin.h
index 44548e24473c..e0972fbfa09e 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -28,6 +28,7 @@ struct opts {
 	bool module;
 	bool no_fp;
 	bool no_unreachable;
+	bool sec_address;
 	bool stats;
 	bool vmlinux;
 };
diff --git a/tools/objtool/include/objtool/warn.h b/tools/objtool/include/objtool/warn.h
index c4bde3e2a79c..a3e79ae75f2e 100644
--- a/tools/objtool/include/objtool/warn.h
+++ b/tools/objtool/include/objtool/warn.h
@@ -11,30 +11,33 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
+#include <objtool/builtin.h>
 #include <objtool/elf.h>
 
 extern const char *objname;
 
 static inline char *offstr(struct section *sec, unsigned long offset)
 {
-	struct symbol *func;
-	char *name, *str;
-	unsigned long name_off;
+	bool is_text = (sec->sh.sh_flags & SHF_EXECINSTR);
+	struct symbol *sym = NULL;
+	char *str;
+	int len;
 
-	func = find_func_containing(sec, offset);
-	if (!func)
-		func = find_symbol_containing(sec, offset);
-	if (func) {
-		name = func->name;
-		name_off = offset - func->offset;
+	if (is_text)
+		sym = find_func_containing(sec, offset);
+	if (!sym)
+		sym = find_symbol_containing(sec, offset);
+
+	if (sym) {
+		str = malloc(strlen(sym->name) + strlen(sec->name) + 40);
+		len = sprintf(str, "%s+0x%lx", sym->name, offset - sym->offset);
+		if (opts.sec_address)
+			sprintf(str+len, " (%s+0x%lx)", sec->name, offset);
 	} else {
-		name = sec->name;
-		name_off = offset;
+		str = malloc(strlen(sec->name) + 20);
+		sprintf(str, "%s+0x%lx", sec->name, offset);
 	}
 
-	str = malloc(strlen(name) + 20);
-	sprintf(str, "%s+0x%lx", name, name_off);
-
 	return str;
 }
 
-- 
2.34.1

