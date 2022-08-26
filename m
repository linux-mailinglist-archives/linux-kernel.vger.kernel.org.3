Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4295A2ACB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 17:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344403AbiHZPO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 11:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343764AbiHZPNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 11:13:41 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445C0DEFD
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 08:09:47 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id hb37-20020a170907162500b0073d7f7fbbbfso725540ejc.17
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 08:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=wnBRr6RijpcrZwDY4IvPeedZIJ4FbGOivCI4jGGTq68=;
        b=Q2dLT3h7TWqrdhr9cKJaZHS7iaLiqYTtydJ8WFBafxLMcKO+tWNvB/c1oHlNA44pJ7
         /OXz8Sr59WCHZVNiYq5ZO1SudMDbRYsAoPTTGJZwqRehknAE2rlYQmFGjPCW+F59/jA8
         4CGBdHbeqGVMdW2YUIUBHbdr0K3ckRBLlyr7LkOy1/yf2HWblMEVwWDcc4r9h7xID/vX
         XMqQsXajhwumZ46fKGFKaccQ9fQsrPuYa0ruT4rNz0CxhrMmw4c71iIpLPuYx4UZ7eQv
         mqdpWuXSHPVCrwsBJhHLWeKUt/81aDaMfsn199V9hC6WQQ+JcGqn5dar3vI5lIw7PM1Z
         VyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=wnBRr6RijpcrZwDY4IvPeedZIJ4FbGOivCI4jGGTq68=;
        b=luXe1OUtwO59MaVgQQ1GzRya3rEJDPbejPrEeScdKIDoBbFa9oPT+JNvtgIhGidMvx
         T3UqJV1fzet95uzzYrdqTaShphiFqt/v3dpTwxI3x+u3RpgxRlfuDkb8hQJBkMAXWzRA
         YNykwn1SwT+ZjNTHRIFqldbH6xweMa/2c+QRW2hU5AgCRwuUWjDDtKKr5SehYN0pJ5KC
         hnPknlD3Y73uM0xHE59V7GqEI92scFbovENSr0IADQ0w+dRTBHbEizHFAZNxQHqIV8qW
         fBKsAqdoE6TPdOmTByffqIm0+ZuyWbw+naOjAbdeUKpB24rUncluXobPQ9wxqChMmCys
         xjwA==
X-Gm-Message-State: ACgBeo311ehU5ZnRfxG5zHb3RTYpa0OvvodK4Bed98alaqvehCBXh02x
        Dmnwyl3DLGhRSc/4lcjLOnylmPTmINA=
X-Google-Smtp-Source: AA6agR5Cviceae2TWrL6o3zdALqTpxVHsH33a+v7kdsRPAsBV/Ys+W35Cv65k+Ev6zMJg2mViJephdzVroE=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:5207:ac36:fdd3:502d])
 (user=glider job=sendgmr) by 2002:a05:6402:268d:b0:43d:b9d0:9efc with SMTP id
 w13-20020a056402268d00b0043db9d09efcmr7340129edd.92.1661526582428; Fri, 26
 Aug 2022 08:09:42 -0700 (PDT)
Date:   Fri, 26 Aug 2022 17:07:55 +0200
In-Reply-To: <20220826150807.723137-1-glider@google.com>
Mime-Version: 1.0
References: <20220826150807.723137-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220826150807.723137-33-glider@google.com>
Subject: [PATCH v5 32/44] objtool: kmsan: list KMSAN API functions as uaccess-safe
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
index 91678252a9b67..577dfdca635e8 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1060,6 +1060,26 @@ static const char *uaccess_safe_builtin[] = {
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
2.37.2.672.g94769d06f0-goog

