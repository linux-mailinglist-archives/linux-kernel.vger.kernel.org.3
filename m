Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A026B5AD2DF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 14:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237881AbiIEMcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 08:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237754AbiIEMaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 08:30:24 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D426110B
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 05:26:34 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id x21-20020a05640226d500b0044856301c62so5706683edd.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 05:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=mxKrKakNES2O6WNVUjUiVAG/aqg8NEyyXmfzwvDy3M8=;
        b=Hll0XPDmwrA/wkE0+inHBLREQNrLcoBNQOLJv6vlBIuGAkWI+xpzOnwpEHVMNRdEFq
         LadRtvkYKT0rBaCGIQh+SpcYQSYJ6+D3urzxB4a+suX0OZKqBBYIRUGR9X7fE50HgxBz
         B2g0i4X6vQks1KpTx5jgpjFZyeuT89E6vIhppFNHjDfbX+1QPnLtmUz9mtN+7ySfB+bR
         PFoDRy3NBTPBWZ7NAt+/xQb5yB7Y9UmTQE95ZWJNyoXXzQAFuUS4huF8Aevejgh3HJgS
         M1OLT91cEQYlIRh7PZL9bQgnExoipMKZwEt+JNxRwLYODVp7nciM3moyVQjv2BbTAuZX
         Rk6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=mxKrKakNES2O6WNVUjUiVAG/aqg8NEyyXmfzwvDy3M8=;
        b=3N7I7lLV0H73q2S8LA0j+us0cMgmQHa6pa01/rAvs7RuNjE69e3kd8blt0BiCUGgvy
         PUjNoGfBbZxjxxfIHSFZ/wq2QBOdRbOrXysseOFRWT7TBBmP6h7BAMD6qDuqNqSI06co
         fBD3RFaoBoYkp5meUuIc1OZhlVvZMH0eRLlSiV7muwb64yGI88YbvJz8uF3KqaFUXWvj
         clgUETPRvEy4QoiaGmY+ykvbSwOkLTcyQ+c1DVHsHazHBlmH6s3eOWYl9HQqjPN1N2mC
         H0TxReqe0UP0XuH5bZLgyBQMZSQMF/DXjJce2aHe4zH8CyoUd9BNH1pL3lf5xssFO9ky
         ZKYA==
X-Gm-Message-State: ACgBeo3wjdkLmvFN09cXAm4fe33Td0u9Io00khi5xjAbi9Rew2QtW5ZL
        quGFZxl//2E/dU74K/c89OBhbtzgSz0=
X-Google-Smtp-Source: AA6agR4pZP+Qf1sER/Bcc0sCrTDiYtuFvoFMz4Z9eHlW4ZWYhhtKJNa6WbLDpJSuTZ9T3g+moO7a0PvtFbY=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:b808:8d07:ab4a:554c])
 (user=glider job=sendgmr) by 2002:a17:906:845c:b0:730:bbf1:196a with SMTP id
 e28-20020a170906845c00b00730bbf1196amr36512046ejy.13.1662380785638; Mon, 05
 Sep 2022 05:26:25 -0700 (PDT)
Date:   Mon,  5 Sep 2022 14:24:40 +0200
In-Reply-To: <20220905122452.2258262-1-glider@google.com>
Mime-Version: 1.0
References: <20220905122452.2258262-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220905122452.2258262-33-glider@google.com>
Subject: [PATCH v6 32/44] objtool: kmsan: list KMSAN API functions as uaccess-safe
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KMSAN inserts API function calls in a lot of places (function entries
and exits, local variables, memory accesses), so they may get called
from the uaccess regions as well.

KMSAN API functions are used to update the metadata (shadow/origin pages)
for kernel memory accesses. The metadata pages for kernel pointers are
also located in the kernel memory, so touching them is not a problem.
For userspace pointers, no metadata is allocated.

If an API function is supposed to read or modify the metadata, it does so
for kernel pointers and ignores userspace pointers.
If an API function is supposed to return a pair of metadata pointers for
the instrumentation to use (like all __msan_metadata_ptr_for_TYPE_SIZE()
functions do), it returns the allocated metadata for kernel pointers and
special dummy buffers residing in the kernel memory for userspace
pointers.

As a result, none of KMSAN API functions perform userspace accesses, but
since they might be called from UACCESS regions they use
user_access_save/restore().

Signed-off-by: Alexander Potapenko <glider@google.com>
---
v3:
 -- updated the patch description

v4:
 -- add kmsan_unpoison_entry_regs()

Link: https://linux-review.googlesource.com/id/I242bc9816273fecad4ea3d977393784396bb3c35
---
 tools/objtool/check.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e55fdf952a3a1..7c048c11ce7da 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1062,6 +1062,26 @@ static const char *uaccess_safe_builtin[] = {
 	"__sanitizer_cov_trace_cmp4",
 	"__sanitizer_cov_trace_cmp8",
 	"__sanitizer_cov_trace_switch",
+	/* KMSAN */
+	"kmsan_copy_to_user",
+	"kmsan_report",
+	"kmsan_unpoison_entry_regs",
+	"kmsan_unpoison_memory",
+	"__msan_chain_origin",
+	"__msan_get_context_state",
+	"__msan_instrument_asm_store",
+	"__msan_metadata_ptr_for_load_1",
+	"__msan_metadata_ptr_for_load_2",
+	"__msan_metadata_ptr_for_load_4",
+	"__msan_metadata_ptr_for_load_8",
+	"__msan_metadata_ptr_for_load_n",
+	"__msan_metadata_ptr_for_store_1",
+	"__msan_metadata_ptr_for_store_2",
+	"__msan_metadata_ptr_for_store_4",
+	"__msan_metadata_ptr_for_store_8",
+	"__msan_metadata_ptr_for_store_n",
+	"__msan_poison_alloca",
+	"__msan_warning",
 	/* UBSAN */
 	"ubsan_type_mismatch_common",
 	"__ubsan_handle_type_mismatch",
-- 
2.37.2.789.g6183377224-goog

