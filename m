Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3952522051
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346884AbiEJQA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347248AbiEJPwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:52:08 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78D022BD2
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:48:04 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id l1so10505527qvh.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ORTCHnAqwd1LkHDszTdi37+rhpmYONfb9qJXBfSDiuE=;
        b=VDtJj557CbGsgXZsBMLxRRgOXF/lbKagIedVBBN0YtWpbB6czJI1IrMb5JZnoOoMEV
         96iOstUXRGYkyl1xhR4EMVx7Zr7r47XBfXtPF4F/ZyJLVUHzRLa+oQg6l6R6LlryjySa
         pdHPvQc0iwk7GJcjgmjGDYCAIWGwuq6YBl5smqEla/pnpIeIXEwEaEuY8beHVu6hk33C
         01X3PALm+xlI5IqjCND5OqedHUWaTJaFIddfQjjcwNTFowF5CFfHjv91aRZDJgmTB4qv
         QQ149aM2bfBzEmIP/ZD/ycouypZrrNENYWHDzYfDBZQizUuvOz5EYuMDvouepRw6KX5j
         feLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ORTCHnAqwd1LkHDszTdi37+rhpmYONfb9qJXBfSDiuE=;
        b=twG92nV93xWdWE2C5meXGCq5EAGygW1Zvld5xJHXGd8RxeIZ6OY0XxNf/6R7I6i4Ga
         1KDDgliWQHVQQa/g5MTe5dFIVdYuSPkbmWrt9h1ztuff0dm34TKKpo/f+y3BpUFNtaov
         qAhYdCGgH/jIBfVB6ORCqowjbw3yqmkU4FnDjqW5z8KN7LKBDAuNZ3nGIdycV8uV08SA
         EMm3DVPDoP+sDTha2AmoE4TJq/H5OkmUuo1XzOYNFVcwkY9LCSZg816VKEd7sima/8D5
         1jbt5krucxxXJbmS31ab2DGUeUruVvwRw70U/bys6Z7/UAwWmaFkOZ6Hq0V3gTbdvha7
         Kl1g==
X-Gm-Message-State: AOAM531MSTnxPI0A1+tLLp+8X95HID2hNdij3e8NNRpCKJyk0gpiSyw/
        9UZnvKjjGeuUxgshCttXFvs=
X-Google-Smtp-Source: ABdhPJxGRjjQ+MXFnzoRE+rNBKwoGD3RJH05Q4YwDoHlhkbkt7OiNafsGZymV0A4ejSRRqqOTgNYew==
X-Received: by 2002:a05:6214:d87:b0:45a:bb62:fa24 with SMTP id e7-20020a0562140d8700b0045abb62fa24mr18061167qve.71.1652197683948;
        Tue, 10 May 2022 08:48:03 -0700 (PDT)
Received: from localhost ([98.242.65.84])
        by smtp.gmail.com with ESMTPSA id c1-20020ac853c1000000b002f39b99f693sm9671775qtq.45.2022.05.10.08.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 08:48:03 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Matti Vaittinen <Matti.Vaittinen@fi.rohmeurope.com>,
        linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Zankel <chris@zankel.net>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH 08/22] bitops: introduce MANY_BITS() macro
Date:   Tue, 10 May 2022 08:47:36 -0700
Message-Id: <20220510154750.212913-9-yury.norov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220510154750.212913-1-yury.norov@gmail.com>
References: <20220510154750.212913-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/xtensa/kernel/traps.c and include/linux/log2.h define very similar
functions with different behaviour. XTENSA defines IS_POW2(), and
log2.h defines is_power_of_2(). The difference is that IS_POW2()
considers 0 as power of 2, while is_power_of_2() - does not.

This discrepancy may confuse reader. From mathematical point of view,
0 is not a power of 2. So let's introduce macro MANY_BITS(), which
returns true if 2 or more bits are set in a number (which is what
XTENSA actually needs), and use it in is_power_of_2().

CC: Alexei Starovoitov <ast@kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Chris Zankel <chris@zankel.net>
CC: Christophe Leroy <christophe.leroy@csgroup.eu>
CC: Eric W. Biederman <ebiederm@xmission.com>
CC: Kumar Kartikeya Dwivedi <memxor@gmail.com>
CC: Max Filippov <jcmvbkbc@gmail.com>
CC: Toke Høiland-Jørgensen <toke@redhat.com>
CC: linux-xtensa@linux-xtensa.org
CC: linux-kernel@vger.kernel.org
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/xtensa/kernel/traps.c | 5 +----
 include/linux/bitops.h     | 3 +++
 include/linux/log2.h       | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index 138a86fbe9d7..040ec38bfce2 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -203,10 +203,7 @@ static void do_multihit(struct pt_regs *regs)
 
 #if XTENSA_FAKE_NMI
 
-#define IS_POW2(v) (((v) & ((v) - 1)) == 0)
-
-#if !(PROFILING_INTLEVEL == XCHAL_EXCM_LEVEL && \
-      IS_POW2(XTENSA_INTLEVEL_MASK(PROFILING_INTLEVEL)))
+#if (MANY_BITS(XTENSA_INTLEVEL_MASK(PROFILING_INTLEVEL)) || PROFILING_INTLEVEL != XCHAL_EXCM_LEVEL)
 #warning "Fake NMI is requested for PMM, but there are other IRQs at or above its level."
 #warning "Fake NMI will be used, but there will be a bugcheck if one of those IRQs fire."
 
diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 7aaed501f768..96bc6a2552d6 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -21,6 +21,9 @@
 #define BITS_TO_U32(nr)		__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(u32))
 #define BITS_TO_BYTES(nr)	__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(char))
 
+/* Return: nonzero if 2 or more bits are set */
+#define MANY_BITS(n)		((n) & ((n) - 1))
+
 extern unsigned int __sw_hweight8(unsigned int w);
 extern unsigned int __sw_hweight16(unsigned int w);
 extern unsigned int __sw_hweight32(unsigned int w);
diff --git a/include/linux/log2.h b/include/linux/log2.h
index 9f30d087a128..335b9dbd302d 100644
--- a/include/linux/log2.h
+++ b/include/linux/log2.h
@@ -44,7 +44,7 @@ int __ilog2_u64(u64 n)
 static inline __attribute__((const))
 bool is_power_of_2(unsigned long n)
 {
-	return (n != 0 && ((n & (n - 1)) == 0));
+	return n != 0 && !MANY_BITS(n);
 }
 
 /**
-- 
2.32.0

