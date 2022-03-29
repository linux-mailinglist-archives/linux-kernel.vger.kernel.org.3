Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE324EADA8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 14:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236762AbiC2Mup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 08:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236748AbiC2MrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 08:47:10 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0907725719A
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 05:42:07 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id m21-20020a50d7d5000000b00418c7e4c2bbso10963961edj.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 05:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XAH4acQx+nIWehlAydXzel6kNYbNIXLv2CmwLsxzisk=;
        b=YpPQVEPURN2ajRY1n46PwqwFtWp7RlcVqb0MoMfwIeS/m0CwFkAlmK9veRToXX/Nh0
         b6E4uZScKbMj2h/RFOMhq1XJYUrJq4RW8RMzRp9Z6yBNz7KYsvHe+FzobtEv1SE+z8z0
         bBRHxkEnq08sMogy1ImUi3Oswt0oie9fh2FqU81kZAPoJIolXyiL4DuviryqlAYyJ0cl
         fP2//D93tGjpn2gvBqCfUGSh263yJnEsQm+Ik3DPQuyteuBuA1cheprPsGBkm0p9BeA1
         Z+owbpU+GHDWSgeR7eKuS6SEv9VgACxZntokNlAC2HOBzVv0eGiDKuMeIWei48sQH+i1
         OfdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XAH4acQx+nIWehlAydXzel6kNYbNIXLv2CmwLsxzisk=;
        b=6axhx/te3mhvqdlgtp6vpOCoa7yraIlHcuKxM2Q8Z9Mx3e3bYq2miIosISq99qyKQr
         EEmI206ycwalQrYk0c08cc8uPPAzZJDdLHE2AlGF1E6dgR2f6tR413KWC2xYVhI/bzuM
         UHeoq5624fGEU/YectpobB8EpgY5izRzRDe+bXmO+cWGB8d9UzX3HhtRcE3RHDf+ZHWN
         nvROrSInb1NziWunbtorS04u8nxCwrro89PMCDii/E2QbkQUjP6/3qeHU9EVcHxqUQB0
         xyRY5CGx67wkdBrJ5aORMGJG2Bpnge9rS6Ilt+yeyfLvuU4adDvNnzjiUEv7Beyj4ugK
         +udA==
X-Gm-Message-State: AOAM531Jzz9XsVtBGbsa4rTkIjm+m6V2/CCANmm26YGzEHhJUhVGNRQd
        jG1utsktpM1MsxeCvVZtc9xMekM6+Qk=
X-Google-Smtp-Source: ABdhPJw8wyFM62Ut2Sf7rG+vUT6fWVoAt6oG05coCAtugWeflqaBDOLOCgDn81VaIvvOcjBAOP8lwoc0QHY=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:36eb:759:798f:98c3])
 (user=glider job=sendgmr) by 2002:a17:906:4313:b0:6b8:b3e5:a46 with SMTP id
 j19-20020a170906431300b006b8b3e50a46mr33446870ejm.417.1648557725791; Tue, 29
 Mar 2022 05:42:05 -0700 (PDT)
Date:   Tue, 29 Mar 2022 14:40:05 +0200
In-Reply-To: <20220329124017.737571-1-glider@google.com>
Message-Id: <20220329124017.737571-37-glider@google.com>
Mime-Version: 1.0
References: <20220329124017.737571-1-glider@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v2 36/48] kmsan: kcov: unpoison area->list in kcov_remote_area_put()
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
2.35.1.1021.g381101b075-goog

