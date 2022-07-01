Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92D856357A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 16:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbiGAO2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 10:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbiGAO1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 10:27:19 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1144650729
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 07:24:48 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id qa41-20020a17090786a900b00722f313a60eso835931ejc.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 07:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=z3bEqNJSKGgtE+5cRSN2oSZAKY283RHsG2GOYMoI00Y=;
        b=qnQCWjKq5yG4F3jPwXLMHLCDtYd3ls2GTNlYs9o6Wm5n9ZlXM2kcHIEFbE0tYS3KKn
         HmTASR9qhhcfDdychxG1CfugY/2EWvcCDInodoMg7RU0zMb9HYdN78o9NjljMlNc8rMd
         hIPR0zujO1oAwrMaZfThO3gQ6658HJ1jfgOwDhl9ZusUhjpUAC4OrXaLRqEtr0Uzsch/
         DsH42O9o1nqIfH3L8cjBMMq0dkqxJiiaM9JZTR6pQdrxlRJnL8p1AzkkSc/He2avvllk
         IPUugX4/4fHGoOL5a8zYmVOjP0tM9Ig0OyWFD1/fv11wQ/OCoEsmw4o/l++EGmFeYma8
         W7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=z3bEqNJSKGgtE+5cRSN2oSZAKY283RHsG2GOYMoI00Y=;
        b=mddypiYeilBDqhr/RVewhi4bp0SbNqxlo31/MVPV9f2iFpE0GH8NZ8tVFGik3u6Qwj
         RA5uaJkhWEz9bQLPgUP9IZYlS230N9TJSGwtiJrN3Fu2icsPcmSsmYwuH1lbcgy2lMD/
         QsjXBDisvbkVft+YUwsf1K3a4SoNRVaVPfILpxR+xk0WCbtn6dVb8gMVJyAcfWHAMhVy
         6uCicQXFJ8cszwO/842+WtuN48L5XjH1HGK6vAfKp3ggaQM38+lhDa0dVMc+oUJQQx2E
         pOo16cxpcGCJXCx+4pm0+F7CTf78Lwito/TwfzlfW9Kzi4MYa79GrmfJYUdQhG+RQf92
         pmjQ==
X-Gm-Message-State: AJIora+2B7lHZP+4ocG0KOJzgXKYGcL3UYo1c7jhmKyTm3gvz/IgPVsj
        BaVs7LaSXN1DLpJEpdFtrozTR3lim4E=
X-Google-Smtp-Source: AGRyM1v3S88h3I8S3PNOLZJhMmyQhBUBhKM4ToewpYwCFFWW8Gw6EHSPC9ywT4YZ1DjScWDrCrHuxSVSgLc=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:a6f5:f713:759c:abb6])
 (user=glider job=sendgmr) by 2002:a17:906:2086:b0:717:4e91:f1db with SMTP id
 6-20020a170906208600b007174e91f1dbmr14229924ejq.345.1656685485180; Fri, 01
 Jul 2022 07:24:45 -0700 (PDT)
Date:   Fri,  1 Jul 2022 16:22:57 +0200
In-Reply-To: <20220701142310.2188015-1-glider@google.com>
Message-Id: <20220701142310.2188015-33-glider@google.com>
Mime-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v4 32/45] objtool: kmsan: list KMSAN API functions as uaccess-safe
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
index 864bb9dd35845..1cf260c966441 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1013,6 +1013,26 @@ static const char *uaccess_safe_builtin[] = {
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
2.37.0.rc0.161.g10f37bed90-goog

