Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873464747C1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 17:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235927AbhLNQXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 11:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235860AbhLNQWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 11:22:48 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F44C06173E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:22:47 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id ay34-20020a05600c1e2200b00337fd217772so8124467wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pDpFAq/kgLbL4mZTug/Zn/jZQvoibLkfmHC/vYYPKLY=;
        b=V6TLCTroMQ1YFeJUAuCxWCM8TfORF5zXzcc4ylqnnnUmQFBR0wkShjX3TJqpedLfoJ
         OhGXscqmWNGR3eRaLf8qdFbwlf3KhIX0EiqDRTN8sJuq8UUzEnWhnr5dTFLKiyXS6X2T
         sIPx9Sbr+F6MfZddMdDtG76pRYMoFyVl7xP2sc3dWOPGAIQl/vWIKp5uvz26MCsufIC8
         D5t9esKWY42zFJ+INBQpNQr3Zq9zBsN5DOTYEB6P/fW2+gp6TbhSXY7HXXs2KYyuG8Wu
         3Ad+I8gxvLI3sfzZkkglyYeUQ55b52BS6bBCkBjRSFvNDAzqQvwiBjzOqMH9VhpVlD8X
         kS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pDpFAq/kgLbL4mZTug/Zn/jZQvoibLkfmHC/vYYPKLY=;
        b=f+tdy9TcncWDV++I4XYsinKjixPT5MFqdPu1juimY3PDp4AjX6ktVBe5gZz7o3gKNq
         njhmoxVyAOIN5RhAAt8+zQhQnAYJwyl5d0/7oOolPN6s+KuRuyfUsenvsCMDgRb3e6Dw
         ZvTZTWAyzRF/OoiM0GqowuLWP6lSrlFnuZwKn+pRGeveG5v5URwj31ms9NJPVnDBhtVJ
         vBfKGKUi099gwCNs2wfqeQ/K+WVZQjotS7f9AhO9KnhL/x7yTVtGbto1H+mTDvEEeDRW
         dQ2uURlLfvzLlId7tqvx9ez4F/qbL8TrutSqGyauIIKf1UNjoahGT0vf13RQUpmJ4GTo
         CqRA==
X-Gm-Message-State: AOAM531aeGv9RECYGx80BiYrMlYxCjrpjOtAizQVPjE5QUic9mEmkH2b
        OMX21AS/2iP6YLtYAZaBRDt7xWCPX7o=
X-Google-Smtp-Source: ABdhPJz5liaqc6HieOETlQr+PtYSR7daCRhoU6NJ7zV/jC4EZ7e8Cq5zAy4tyC1sowvOKbwx+OaMmBwZf9M=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:357e:2b9d:5b13:a652])
 (user=glider job=sendgmr) by 2002:a05:600c:1d1b:: with SMTP id
 l27mr5819167wms.1.1639498965316; Tue, 14 Dec 2021 08:22:45 -0800 (PST)
Date:   Tue, 14 Dec 2021 17:20:26 +0100
In-Reply-To: <20211214162050.660953-1-glider@google.com>
Message-Id: <20211214162050.660953-20-glider@google.com>
Mime-Version: 1.0
References: <20211214162050.660953-1-glider@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH 19/43] kmsan: init: call KMSAN initialization routines
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

kmsan_initialize_shadow() creates metadata pages for mappings created
at boot time.

kmsan_initialize() initializes the bookkeeping for init_task and enables
KMSAN.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/I7bc53706141275914326df2345881ffe0cdd16bd
---
 init/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/init/main.c b/init/main.c
index bb984ed79de0e..2fc5025db0810 100644
--- a/init/main.c
+++ b/init/main.c
@@ -34,6 +34,7 @@
 #include <linux/percpu.h>
 #include <linux/kmod.h>
 #include <linux/kprobes.h>
+#include <linux/kmsan.h>
 #include <linux/vmalloc.h>
 #include <linux/kernel_stat.h>
 #include <linux/start_kernel.h>
@@ -834,6 +835,7 @@ static void __init mm_init(void)
 	init_mem_debugging_and_hardening();
 	kfence_alloc_pool();
 	report_meminit();
+	kmsan_init_shadow();
 	stack_depot_init();
 	mem_init();
 	mem_init_print_info();
@@ -848,6 +850,7 @@ static void __init mm_init(void)
 	init_espfix_bsp();
 	/* Should be run after espfix64 is set up. */
 	pti_init();
+	kmsan_init_runtime();
 }
 
 #ifdef CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
-- 
2.34.1.173.g76aa8bc2d0-goog

