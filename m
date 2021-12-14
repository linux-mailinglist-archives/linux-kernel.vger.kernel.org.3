Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE1AF4747ED
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 17:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236204AbhLNQZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 11:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236211AbhLNQX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 11:23:59 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9728FC0619D8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:23:45 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id w14-20020ac87e8e000000b002b6583adcfcso27346445qtj.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nqri0SqMC1etYNLgNBuMYaMAJIzMiZ/6wkGd9gYSOPg=;
        b=G18riu4JI7JtKkKPqFFA5idjWjGGTTZqHBAvDJQauVQAe0CwMxRshD5JmWlf7E37ks
         mwlaBVMnwHTHaPRmvc8izjTpFo/K6aQ60g2MJRtQD09Zi0kt6r+SwE63fluG5YCffcX3
         ETmVIHrvmAmCsts/1Hn+sDZuXNhfiqY6oYEZO/SgyuHGBaFJFcj5R/RMsB2+P8KmbIqF
         LpJ2h0xhFl1+ofZ0d2h/MvnuO8XyFMt5eh/vq7b4V7CqBSjK/yRE6qI8rKVbn9Fylk4v
         FR6UfMNdjUdR8Mf9ICzS9FCWjbZML+EhSd4wW5x7J+ixaHc7MssuLWzv9rurbjT+dAZR
         9RTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nqri0SqMC1etYNLgNBuMYaMAJIzMiZ/6wkGd9gYSOPg=;
        b=jKMOd01H8c1G6e0k4Mde1tMZF6ykgEAFh/+kBb+IFmRQuKvLfgHwms35e9f1zWJp+c
         gWnzzgIjQVimMdxXu3ELw2DtfniXrSejEhL4QjkuFitaEoBZlBJpweT138TVzdV+Epeh
         Rc+wpig4ECvvuDxDYt76M0hutk98ZNsAaH8dmsEbHjYhnTPksir8Zo3IlvwwNBYesEC3
         MdCECO4Ilz783/GPDcX42s/Mr+5A6Rgmff8iu6ByDmZjvo496vLvn9bioIp4zRu6huSd
         JOx7+5WUlXLQ+skEZaq/6DApDEwuvPniQ6VPnCfiJMKQqDQ8KCM2M6EANv89ZmVGBsbw
         rjEw==
X-Gm-Message-State: AOAM532/qwTMPaOUc+WpnASVfkCSZC0++j3ejnCUnEOZWxV/q0OqByQl
        cOX/QxJrjuCPfzvIh1A1gtJgEfk8yPE=
X-Google-Smtp-Source: ABdhPJxdzjFsV5SurqsBYzpnQqwewId1DkZ5ulNTElSjNHN2aEHjpBIN3oypc4pwNeZ7UyA+RJRV8P/AS1U=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:357e:2b9d:5b13:a652])
 (user=glider job=sendgmr) by 2002:a05:622a:18c:: with SMTP id
 s12mr6962473qtw.556.1639499024661; Tue, 14 Dec 2021 08:23:44 -0800 (PST)
Date:   Tue, 14 Dec 2021 17:20:48 +0100
In-Reply-To: <20211214162050.660953-1-glider@google.com>
Message-Id: <20211214162050.660953-42-glider@google.com>
Mime-Version: 1.0
References: <20211214162050.660953-1-glider@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH 41/43] security: kmsan: fix interoperability with auto-initialization
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

Heap and stack initialization is great, but not when we are trying
uses of uninitialized memory. When the kernel is built with KMSAN,
having kernel memory initialization enabled may introduce false
negatives.

We disable CONFIG_INIT_STACK_ALL_PATTERN and CONFIG_INIT_STACK_ALL_ZERO
under CONFIG_KMSAN, making it impossible to auto-initialize stack
variables in KMSAN builds. We also disable CONFIG_INIT_ON_ALLOC_DEFAULT_ON
and CONFIG_INIT_ON_FREE_DEFAULT_ON to prevent accidental use of heap
auto-initialization.

We however still let the users enable heap auto-initialization at
boot-time (by setting init_on_alloc=1 or init_on_free=1), in which case
a warning is printed.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/I86608dd867018683a14ae1870f1928ad925f42e9
---
 mm/page_alloc.c            | 4 ++++
 security/Kconfig.hardening | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index fa8029b714a81..4218dea0c76a2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -855,6 +855,10 @@ void init_mem_debugging_and_hardening(void)
 	else
 		static_branch_disable(&init_on_free);
 
+	if (IS_ENABLED(CONFIG_KMSAN) &&
+	    (_init_on_alloc_enabled_early || _init_on_free_enabled_early))
+		pr_info("mem auto-init: please make sure init_on_alloc and init_on_free are disabled when running KMSAN\n");
+
 #ifdef CONFIG_DEBUG_PAGEALLOC
 	if (!debug_pagealloc_enabled())
 		return;
diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index d051f8ceefddd..bd13a46024457 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -106,6 +106,7 @@ choice
 	config INIT_STACK_ALL_PATTERN
 		bool "pattern-init everything (strongest)"
 		depends on CC_HAS_AUTO_VAR_INIT_PATTERN
+		depends on !KMSAN
 		help
 		  Initializes everything on the stack (including padding)
 		  with a specific debug value. This is intended to eliminate
@@ -124,6 +125,7 @@ choice
 	config INIT_STACK_ALL_ZERO
 		bool "zero-init everything (strongest and safest)"
 		depends on CC_HAS_AUTO_VAR_INIT_ZERO
+		depends on !KMSAN
 		help
 		  Initializes everything on the stack (including padding)
 		  with a zero value. This is intended to eliminate all
@@ -208,6 +210,7 @@ config STACKLEAK_RUNTIME_DISABLE
 
 config INIT_ON_ALLOC_DEFAULT_ON
 	bool "Enable heap memory zeroing on allocation by default"
+	depends on !KMSAN
 	help
 	  This has the effect of setting "init_on_alloc=1" on the kernel
 	  command line. This can be disabled with "init_on_alloc=0".
@@ -220,6 +223,7 @@ config INIT_ON_ALLOC_DEFAULT_ON
 
 config INIT_ON_FREE_DEFAULT_ON
 	bool "Enable heap memory zeroing on free by default"
+	depends on !KMSAN
 	help
 	  This has the effect of setting "init_on_free=1" on the kernel
 	  command line. This can be disabled with "init_on_free=0".
-- 
2.34.1.173.g76aa8bc2d0-goog

