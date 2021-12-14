Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14C584747E6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 17:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236106AbhLNQYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 11:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236110AbhLNQXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 11:23:49 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D690DC06137C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:23:43 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id p17-20020adff211000000b0017b902a7701so4854247wro.19
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=U+qm7d/TRHtCZVnNcOhiGaVBA5CqP9KjwHQr2QaBZAQ=;
        b=pEM4RdPSzm/510AmsumYiHSDTA2WOU3NZ8sZhhdvwWgVTHPJc7Bdlah4MCZ32atX3G
         jGo/raNtb4LQI8I4r1YFjxd2ggdk5XJT0ob764gqF9JvZZCy42c/S2H0f040ScrApf57
         gqIbh2Fc5O7kzVK2vUnbOkdFc1yq4EhbCmjUdgO0DasR2T5NyKPtdENN0LclCZG691Mt
         jOsBshdRwd+qj3IuZFNYMMsTlZzXepIRKPzicER+gtxYt9YdqeLXcIRg38AD7gTceUhp
         zYaKpHAFuXnw+voswqHRX1JELRSYcJyCHZvdEy65ACsMvgcqOGXpdF4F9wp7EfuQJXz5
         4ySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=U+qm7d/TRHtCZVnNcOhiGaVBA5CqP9KjwHQr2QaBZAQ=;
        b=0wnPT3+0N5NUACoMgNVCzxtlSyNM4ttXbe6Y7VvKxohpHo77VgstB6CgcjicZ24o/g
         vua0mB8ZcwEkoMXxf01XVbUR40weOuG5Fd81JmRqeyQg059psT/MdRzx3PWbghL52Yxy
         WXpjCVxZiK4HmxTsXu54dMGtaZM0dsCbsLOAlc4b5hGi5WjB4Fp7S6h32TVtBtJRfQY1
         W/lvoUCHP406uH0Ah2kzYXRJ8gRkhmY3U0NbyVA4H5ahKuC+rzp6eBxcQsIvnPSIfbnr
         f/s0PFAq/3pgOaj5b9jBfT/uwYUUC46AzgYKHU2kFgSjLo2T+48/m6DRKjHrOfJvAc/E
         CBNw==
X-Gm-Message-State: AOAM532US7QUBBYdQwnLBPa7jU9TODM4Yv2p21omsDOE1Coua4H3Spw4
        ToCdMOi2ArYsr9R9C7iJkLPONQEAEgA=
X-Google-Smtp-Source: ABdhPJzrl2gcQ/iPrl04EH5ZpIOzMTprjVo1ITZdjtHUSdKKRp22IBfVvKgCgO2cFELLY6fChdDG+6nJUr0=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:357e:2b9d:5b13:a652])
 (user=glider job=sendgmr) by 2002:a5d:452b:: with SMTP id j11mr6749890wra.432.1639499022128;
 Tue, 14 Dec 2021 08:23:42 -0800 (PST)
Date:   Tue, 14 Dec 2021 17:20:47 +0100
In-Reply-To: <20211214162050.660953-1-glider@google.com>
Message-Id: <20211214162050.660953-41-glider@google.com>
Mime-Version: 1.0
References: <20211214162050.660953-1-glider@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH 40/43] kmsan: kcov: unpoison area->list in kcov_remote_area_put()
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KMSAN does not instrument kernel/kcov.c for performance reasons (with
CONFIG_KCOV=y virtually every place in the kernel invokes kcov
instrumentation). Therefore the tool may miss writes from kcov.c that
initialize memory.

When CONFIG_DEBUG_LIST is enabled, list pointers from kernel/kcov.c are
passed to instrumented helpers in lib/list_debug.c, resulting in false
positives.

To work around these reports, we unpoison the contents of area->list after
initializing it.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/Ie17f2ee47a7af58f5cdf716d585ebf0769348a5a
---
 kernel/kcov.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index 36ca640c4f8e7..88ffdddc99ba1 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -11,6 +11,7 @@
 #include <linux/fs.h>
 #include <linux/hashtable.h>
 #include <linux/init.h>
+#include <linux/kmsan-checks.h>
 #include <linux/mm.h>
 #include <linux/preempt.h>
 #include <linux/printk.h>
@@ -152,6 +153,12 @@ static void kcov_remote_area_put(struct kcov_remote_area *area,
 	INIT_LIST_HEAD(&area->list);
 	area->size = size;
 	list_add(&area->list, &kcov_remote_areas);
+	/*
+	 * KMSAN doesn't instrument this file, so it may not know area->list
+	 * is initialized. Unpoison it explicitly to avoid reports in
+	 * kcov_remote_area_get().
+	 */
+	kmsan_unpoison_memory(&area->list, sizeof(struct list_head));
 }
 
 static notrace bool check_kcov_mode(enum kcov_mode needed_mode, struct task_struct *t)
-- 
2.34.1.173.g76aa8bc2d0-goog

