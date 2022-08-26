Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3C25A2AD7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 17:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344335AbiHZPOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 11:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343829AbiHZPMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 11:12:37 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17045DEA43
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 08:09:41 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-33dc390f26cso29461217b3.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 08:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=l4zm1sbHMytNqYdogbjGF6C06dm3yrxkJ0CqfKBvE4Y=;
        b=kOld3GJAUrMocd7PaWFDM8/h7CQ5GhgeZ5vgr609uraCY0vVS54oj+Y6R1RPWTH0by
         Bq5BNkaD35EK0na6N/L6VeFnDv7KaDTKmgH3r12GWsfNfB14gNvqr5BIJupwb+18QZwN
         EpJnwctEvW1mQUg89fj3mc+MvJbBuJ+7CVC7Ke4U8VHWQC9tI9ma3K6ekZgZjWQ54T49
         jfxIHJNRWKeLLjMm2ThoMvBFZ4QwkjUTc4z2kPoHnmbFzmrfDXm4QKlvn1DyC5ty9ZjW
         KFjhK6XLeZbpXZp2sTAzuIjtMg/FCCX5xS76W6rdKcowYCqow2Y6Z86qCxoGhCl8H6pW
         cgBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=l4zm1sbHMytNqYdogbjGF6C06dm3yrxkJ0CqfKBvE4Y=;
        b=NCP4EW4+nWmeEx7HKiO/A0kzbnCIBKwuJc+KivIf/imZwO1rIWivOYmFHQajx9uPh/
         6MYA9GNw9Of0Mt4MsUe/ofrhF541TM6b/KESo60Osp+cYKZX+XxaY7zBMeII/X4NuyM4
         00URyE4pjFDDxLVswXKrOnYBAFmQIRY8FkCbn8Hf5ohz92wvudFq/kzmRkFymrK1Ya9T
         tlJ0B+5iVByT31UK6oxS8iSx77SBFJYhIt8+Nc/M0IrFgNGlSgdLtEZuFYtUgB3syFxM
         AQ4YbKqvAc24+hKEu0/trox2csyRmRb5SmwzFMZPrc6u3fSyhMUG/s5N1ZmYMZ6rNxUO
         QbTg==
X-Gm-Message-State: ACgBeo2xmjbkW2o8U5S4ctluEVB0mNuWLkNIM3bDB8aKlVNI6fADRSjO
        Me1ghqON75vXbI8KbndbBZjbYenHrew=
X-Google-Smtp-Source: AA6agR5iGmN+D99SNwa8hGxZHvyED7rP3I7yucWmOXY/88v8RIwEBSFuEsCfj86kvBE/XBr/3trnlWmswJk=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:5207:ac36:fdd3:502d])
 (user=glider job=sendgmr) by 2002:a81:6e06:0:b0:33b:4e1:dd6e with SMTP id
 j6-20020a816e06000000b0033b04e1dd6emr129882ywc.212.1661526579691; Fri, 26 Aug
 2022 08:09:39 -0700 (PDT)
Date:   Fri, 26 Aug 2022 17:07:54 +0200
In-Reply-To: <20220826150807.723137-1-glider@google.com>
Mime-Version: 1.0
References: <20220826150807.723137-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220826150807.723137-32-glider@google.com>
Subject: [PATCH v5 31/44] security: kmsan: fix interoperability with auto-initialization
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index b28093e3bb42a..e5eed276ee41d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -936,6 +936,10 @@ void init_mem_debugging_and_hardening(void)
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
index bd2aabb2c60f9..2739a6776454e 100644
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
@@ -218,6 +220,7 @@ config STACKLEAK_RUNTIME_DISABLE
 
 config INIT_ON_ALLOC_DEFAULT_ON
 	bool "Enable heap memory zeroing on allocation by default"
+	depends on !KMSAN
 	help
 	  This has the effect of setting "init_on_alloc=1" on the kernel
 	  command line. This can be disabled with "init_on_alloc=0".
@@ -230,6 +233,7 @@ config INIT_ON_ALLOC_DEFAULT_ON
 
 config INIT_ON_FREE_DEFAULT_ON
 	bool "Enable heap memory zeroing on free by default"
+	depends on !KMSAN
 	help
 	  This has the effect of setting "init_on_free=1" on the kernel
 	  command line. This can be disabled with "init_on_free=0".
-- 
2.37.2.672.g94769d06f0-goog

