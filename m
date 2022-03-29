Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B064EAD77
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 14:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235716AbiC2Mpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 08:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236597AbiC2MoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 08:44:05 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22543236B9B
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 05:41:46 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id do20-20020a170906c11400b006e0de97a0e9so3083996ejc.19
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 05:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NcXyKO/GU5wv+AINtBvHToR0v2IpKVpreq+8SU9KtO4=;
        b=DIWfKg7bP7QnSfYaoX5/svSrQlbraANJFz4ZkJPOWATm87bCAU2GbOOvwevJcEHoKi
         wbdwLM4FSdQAgqD+aGltFF1nNlgaZOezyHxrai+rBf8lAExLt9TsIObDqEZCzGpIi7nH
         xwWzJXVyfWrhAFtE1DDgdB13tMX7M2TNnBpf5xo5AKOhlt6Ra/sgjz/MvMdpU1BtHlRO
         AokxmkFDUGancBTS6WUAyS0jZ1/25Z/5/NnX5iVI36FKkApjAbgSShp4qxN4eRySlGQN
         LaDPdH7+3zFsETzZOVpB1jP5H2P3l6+9CkkA76YAQaezI3vMYZPtpAZ47ee1hp/xomfj
         t6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NcXyKO/GU5wv+AINtBvHToR0v2IpKVpreq+8SU9KtO4=;
        b=bMDzZNdiTXyTf29dFM8CRqBoAHU7IKe9szeT2d0RsQpk5TJtb5K+o4KKcnMW/7NspH
         Rbbq61fJoqhlQ/S61diPza/65AsU+FcEoSPZFocWRJ7dwZl58Mo9FG0tV3d2u2TfGlg8
         EaobwBn4tE6LadKAmc09hY3vT2fX2CVTz6mk/SKHukTYdENtX9rKFvBF7RCB23EGoHUQ
         2yuTyWn6dnzhEaxecCA5GakHumeFICqrlEgtX+BnIPZ0O+iLNGkSUtJaCuE57K5edDVn
         FMnj/XXITFYrJGIy/rR12dofFzv69msDvwrYSdXZraLFVTZAhehZA6YE7rZtdmlsRsXw
         JR8w==
X-Gm-Message-State: AOAM530P0WqD0WabTaIHu5fpn59tVBTJ8I4QXGyHe8xqzzmY+5yX0lGQ
        NXz3Dy3WbPjFMYYG+RMdpWAvglcnKxM=
X-Google-Smtp-Source: ABdhPJwPdBpHIJ0mASGI8QRZZRZI3D7LOk/yhFizlkS2OYABeZsKpvCixcNsVmSaozXNqIJyvElCXIKXLNA=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:36eb:759:798f:98c3])
 (user=glider job=sendgmr) by 2002:a17:907:1dc8:b0:6df:f5fc:f4f9 with SMTP id
 og8-20020a1709071dc800b006dff5fcf4f9mr34096038ejc.739.1648557704420; Tue, 29
 Mar 2022 05:41:44 -0700 (PDT)
Date:   Tue, 29 Mar 2022 14:39:57 +0200
In-Reply-To: <20220329124017.737571-1-glider@google.com>
Message-Id: <20220329124017.737571-29-glider@google.com>
Mime-Version: 1.0
References: <20220329124017.737571-1-glider@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v2 28/48] kmsan: instrumentation.h: add instrumentation_begin_with_regs()
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
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
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling KMSAN-instrumented functions from non-instrumented
functions, function parameters may not be initialized properly, leading
to false positive reports. In particular, this happens all the time when
calling interrupt handlers from `noinstr` IDT entries.

We introduce instrumentation_begin_with_regs(), which calls
instrumentation_begin() and notifies KMSAN about the beginning of the
potentially instrumented region by calling
kmsan_instrumentation_begin(), which:
 - wipes the current KMSAN state at the beginning of the region, ensuring
   that the first call of an instrumented function receives initialized
   parameters (this is a pretty good approximation of having all other
   instrumented functions receive initialized parameters);
 - unpoisons the `struct pt_regs` set up by the non-instrumented assembly
   code.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/I0f5e3372e00bd5fe25ddbf286f7260aae9011858
---
 include/linux/instrumentation.h |  6 ++++++
 include/linux/kmsan.h           | 11 +++++++++++
 mm/kmsan/hooks.c                | 16 ++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/include/linux/instrumentation.h b/include/linux/instrumentation.h
index 24359b4a96053..3bbce9d556381 100644
--- a/include/linux/instrumentation.h
+++ b/include/linux/instrumentation.h
@@ -15,6 +15,11 @@
 })
 #define instrumentation_begin() __instrumentation_begin(__COUNTER__)
 
+#define instrumentation_begin_with_regs(regs) do {			\
+	__instrumentation_begin(__COUNTER__);				\
+	kmsan_instrumentation_begin(regs);				\
+} while (0)
+
 /*
  * Because instrumentation_{begin,end}() can nest, objtool validation considers
  * _begin() a +1 and _end() a -1 and computes a sum over the instructions.
@@ -55,6 +60,7 @@
 #define instrumentation_end() __instrumentation_end(__COUNTER__)
 #else
 # define instrumentation_begin()	do { } while(0)
+# define instrumentation_begin_with_regs(regs) kmsan_instrumentation_begin(regs)
 # define instrumentation_end()		do { } while(0)
 #endif
 
diff --git a/include/linux/kmsan.h b/include/linux/kmsan.h
index 55f976b721566..209a5a2192e22 100644
--- a/include/linux/kmsan.h
+++ b/include/linux/kmsan.h
@@ -247,6 +247,13 @@ void kmsan_handle_dma_sg(struct scatterlist *sg, int nents,
  */
 void kmsan_handle_urb(const struct urb *urb, bool is_out);
 
+/**
+ * kmsan_instrumentation_begin() - handle instrumentation_begin().
+ * @regs: pointer to struct pt_regs that non-instrumented code passes to
+ *        instrumented code.
+ */
+void kmsan_instrumentation_begin(struct pt_regs *regs);
+
 #else
 
 static inline void kmsan_init_shadow(void)
@@ -343,6 +350,10 @@ static inline void kmsan_handle_urb(const struct urb *urb, bool is_out)
 {
 }
 
+static inline void kmsan_instrumentation_begin(struct pt_regs *regs)
+{
+}
+
 #endif
 
 #endif /* _LINUX_KMSAN_H */
diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
index d95fd16a4b1dc..6b133533ff7d9 100644
--- a/mm/kmsan/hooks.c
+++ b/mm/kmsan/hooks.c
@@ -366,3 +366,19 @@ void kmsan_check_memory(const void *addr, size_t size)
 					   REASON_ANY);
 }
 EXPORT_SYMBOL(kmsan_check_memory);
+
+void kmsan_instrumentation_begin(struct pt_regs *regs)
+{
+	struct kmsan_context_state *state = &kmsan_get_context()->cstate;
+
+	if (state)
+		__memset(state, 0, sizeof(struct kmsan_context_state));
+	if (!kmsan_enabled || !regs)
+		return;
+	/*
+	 * @regs may reside in cpu_entry_area, for which KMSAN does not allocate
+	 * metadata. Do not force an error in that case.
+	 */
+	kmsan_internal_unpoison_memory(regs, sizeof(*regs), /*checked*/ false);
+}
+EXPORT_SYMBOL(kmsan_instrumentation_begin);
-- 
2.35.1.1021.g381101b075-goog

