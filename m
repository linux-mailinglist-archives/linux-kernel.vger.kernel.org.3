Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63DD510414
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 18:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353183AbiDZQsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 12:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353132AbiDZQrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 12:47:53 -0400
Received: from mail-lj1-x249.google.com (mail-lj1-x249.google.com [IPv6:2a00:1450:4864:20::249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B14191446
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:44:45 -0700 (PDT)
Received: by mail-lj1-x249.google.com with SMTP id l8-20020a2ea808000000b0024da289e41dso4843014ljq.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ednioRVQi+463GyxSxojLtYXRmMb4k6reZrR8s7PDTk=;
        b=s7nDKeE2uO8tPBSHXhKtgeVd4KJBULrFKzji5KxbrLSqAsd9qwd5XqsiW4sxXc2Zuj
         /LDHzi6oYDxLjayBmNbbHHd8x60Z1q11m24TiSwhP8RYbreiv3W6YuCWDnMHnOA40Zg6
         2XAh/SQC3o2WwNcd888BCR1ayDkPme9nLNf+yFJmAhhH+5m2makPEnGrUgDcpKDvSpAx
         uZ/EMSRFu7oZ7g4w8LFxCUmwK7SAeXqsUvws74aRat1Udaq+/e8oYjQBcJ/MQ0phtMYp
         ItWJ4UPus1+bGv6Mz6YHzcXh/jQw/SqfpbBVzObyfR2JQ5g2erl9ttRuMQ0dfEHG3Yf8
         GoPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ednioRVQi+463GyxSxojLtYXRmMb4k6reZrR8s7PDTk=;
        b=io1OmFgsqAM6OdKPBiLUsx5B5NGYGAeOC+i0OLtlWZIkiRs8u2akNbtA2E3rJHd5Kl
         +04GS8uLj4QFrfO5yyfXNdeQbsGHcthEfRHQBlxHsmEjY4xK1gsaVKmTn2avPiOtSIFY
         CLlt6RPA200M51E5kXtjIQ6H2rGG/Ab1DM7CEucKP0ytGc89V8148qmLgI4ssKHV/ig3
         DVktISon6qblLWctEiQMPIJiith7beVFX35TNttAvc606b3LS9Mln5dfTG9gq4gkKi5T
         j4S2BtJ0/SogB5JCdfZYIruPdvI5GoWvOJnlisynVZBzkbiSBSZrCP+14nhDHsuG7BWn
         fnVg==
X-Gm-Message-State: AOAM532PLZpaEtbBHe//z4GmQAcj17ApIfiw83/OZQIPG6KlH28ESxDP
        d6P260aREUkB1Aj2Jphz5aKd9dMtqU8=
X-Google-Smtp-Source: ABdhPJxHrJcKOCcTiJCxWbbHxqyDNc8yKbgnQVG+zhnL2F1NE0oryK8Ze862y3s98aS3FdAQ1AuU/NMiTCE=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:d580:abeb:bf6d:5726])
 (user=glider job=sendgmr) by 2002:a05:6512:114f:b0:471:b097:4a29 with SMTP id
 m15-20020a056512114f00b00471b0974a29mr17572189lfg.93.1650991483323; Tue, 26
 Apr 2022 09:44:43 -0700 (PDT)
Date:   Tue, 26 Apr 2022 18:42:38 +0200
In-Reply-To: <20220426164315.625149-1-glider@google.com>
Message-Id: <20220426164315.625149-10-glider@google.com>
Mime-Version: 1.0
References: <20220426164315.625149-1-glider@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v3 09/46] kmsan: mark noinstr as __no_sanitize_memory
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
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

noinstr functions should never be instrumented, so make KMSAN skip them
by applying the __no_sanitize_memory attribute.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
v2:
 -- moved this patch earlier in the series per Mark Rutland's request

Link: https://linux-review.googlesource.com/id/I3c9abe860b97b49bc0c8026918b17a50448dec0d
---
 include/linux/compiler_types.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 1c2c33ae1b37d..a9ba5edd8208b 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -227,7 +227,8 @@ struct ftrace_likely_data {
 /* Section for code which can't be instrumented at all */
 #define noinstr								\
 	noinline notrace __attribute((__section__(".noinstr.text")))	\
-	__no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage
+	__no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage \
+	__no_sanitize_memory
 
 #endif /* __KERNEL__ */
 
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

