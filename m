Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3C05A2AF2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 17:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344394AbiHZPQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 11:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344443AbiHZPPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 11:15:34 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B9ABA9F6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 08:10:15 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id qa35-20020a17090786a300b0073d4026a97dso718306ejc.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 08:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=rCTBedHFoD5mjPc5axfz3IhJFNkE8btw4kiDfQuZoWM=;
        b=fg/g7W5SFXhbc3u2Ka10S6sfG+hleQgHtIujYd0emCXLuaRjW/Lp6/k4/2cWo7l/yp
         VDQQl06jPUO4V5hkPUjOfNuax5shhJaKnbpXyd21jWZdCRxSmNTw/c5xxG3zrihbz+OE
         Ljd50zcy2oKUZWQBLmYWsMOuW6qxf6tCX2W3+KQJUFv3PXm77b5Ak7Io2QiMeQ/oK9vK
         ZD8Tqs0aoGX8nDwtNuhyBXUzYeCZIaWWl/08zjdMFlG1dJKaN0WeEcKRi8ejkQvW4T1P
         wvM92OSrEzTbGCfmQLEw8aa8qLoI04nx9tn9Pj1TgR/4CFpWvS9JnaF3HfLp1oJuw/pj
         zqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=rCTBedHFoD5mjPc5axfz3IhJFNkE8btw4kiDfQuZoWM=;
        b=48kUcZ0NnFGe3Ss/CC8T8+u43Ct8+5tikaa29+CBqEkKbcVXnvWZE7+fD4qnCISphN
         Z0m06uQR5XXETAGJGY18Pv9Oyvkq2fMM98S5ByLJkmr3qeA7Nri0a2Xq+Jc+PBfMezqV
         0Ee43ZOLSHZqVuCMi2Nv0qQS2FRiHtX49Wu2a/FZx6kViPmSlw1XP4eEOfkfnOhLA1ds
         /vl3LSgN/HX/gZfMWt7FQTmMjHYdw7KchD4heiXlkFBxjd3gGbgwMQFWzaLDd/3wyJer
         zHn/+Gbw6efN1dZUEEd58AHn/UT6saAMe9Jxs+98grSWgW1/eX1xbn0PXknXpjCVFclc
         EEkQ==
X-Gm-Message-State: ACgBeo3VxiVP0LFHMWyiBOreunJEPA7nGNwtOYqGWwgNiX97TS6u5n4J
        cu1/4JjeiA36yV/jaL8ZYYiLo1Ilyis=
X-Google-Smtp-Source: AA6agR7tXjpYxk8MsRplqzj3thTzocuzhsrofVe2ZMXjeqhyHHZW7zWMaS3lAs0uR1Cb77CsZjqkIFO/xsw=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:5207:ac36:fdd3:502d])
 (user=glider job=sendgmr) by 2002:a05:6402:2816:b0:434:ed38:16f3 with SMTP id
 h22-20020a056402281600b00434ed3816f3mr7084895ede.116.1661526610607; Fri, 26
 Aug 2022 08:10:10 -0700 (PDT)
Date:   Fri, 26 Aug 2022 17:08:05 +0200
In-Reply-To: <20220826150807.723137-1-glider@google.com>
Mime-Version: 1.0
References: <20220826150807.723137-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220826150807.723137-43-glider@google.com>
Subject: [PATCH v5 42/44] bpf: kmsan: initialize BPF registers with zeroes
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

When executing BPF programs, certain registers may get passed
uninitialized to helper functions. E.g. when performing a JMP_CALL,
registers BPF_R1-BPF_R5 are always passed to the helper, no matter how
many of them are actually used.

Passing uninitialized values as function parameters is technically
undefined behavior, so we work around it by always initializing the
registers.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/I8ef9dbe94724cee5ad1e3a162f2b805345bc0586
---
 kernel/bpf/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index c1e10d088dbb7..547d139ab98af 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2002,7 +2002,7 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
 static unsigned int PROG_NAME(stack_size)(const void *ctx, const struct bpf_insn *insn) \
 { \
 	u64 stack[stack_size / sizeof(u64)]; \
-	u64 regs[MAX_BPF_EXT_REG]; \
+	u64 regs[MAX_BPF_EXT_REG] = {}; \
 \
 	FP = (u64) (unsigned long) &stack[ARRAY_SIZE(stack)]; \
 	ARG1 = (u64) (unsigned long) ctx; \
-- 
2.37.2.672.g94769d06f0-goog

