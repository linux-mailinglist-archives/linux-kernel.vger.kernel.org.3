Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E495AD2AE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 14:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238136AbiIEMcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 08:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237793AbiIEMa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 08:30:26 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BAC6111F
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 05:26:37 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id t12-20020adfa2cc000000b00224f577fad1so1233458wra.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 05:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=VswCSWA+rV4PC5eDv8SsttMbBbTb1fmAEKvfw1RwEtM=;
        b=FaysfHPUHEI9xDQ+DizkafuJSz2Euxr4w8pch7JyeIF7w+mm9SpixN7VAttRnhIcf1
         iHLsEV9jw/pLNwUY4C8KGw1A06689EYkbOQFe18iHyK1OO4vYcFXMfZ5ltlCGAVJ5Riu
         XG1siZwi0o/mlCR+V64/HPoH407x/VrsCnkDyjBQzBqc2hGL0yRU8s5mEz8P1N59BhTg
         hzG3VGefRSfd/eN++lt3E3Gg+z8Tl5riHtwzfLnKb+uWX3YCISAS21Fwh0ERlJq81TyF
         KZxD8W4yBHXpc4Lq6Y1MBvt4ESwZqiGITUw1+GV0SilDaebvQNF1YZTejeneVonkFaZs
         QPng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=VswCSWA+rV4PC5eDv8SsttMbBbTb1fmAEKvfw1RwEtM=;
        b=GDwUDLZei5lRhXXIJL01p7/72FpxBg0HtJobzU8qxPpQn8KLA5jJ6N98Mcbxb1pV4/
         hc6pMJC4AK3o3Z0fHDLvWh8P5EgrebOUSwXobxL5GYJQ9GSAaquKD4LaWblh4Nh/FSKZ
         jXCSSztFubGI3rZGuI4VHOY9ZpzPlfPJFboqzyUoV2pBp2XJlQoMLXABk/U2QDR4n/4t
         xJAk5MWwup1l5CyagvCTOzInjkJV+T0Neio/565Pn+PLUZlhQa59PjO8sYgI0OIH2OAG
         EKITDK3DF+36jPauC7Hb1TfuRRZBNAM69O689fXet+k4aWg27+XeIwchUV5t9bKeoVeY
         PhMg==
X-Gm-Message-State: ACgBeo0qv8HIHQLbWPxWmMyVHeKTrgGla2QF69ypy70w6VB1OacNFP75
        V42RXSDVHWmsMc5cYof3SnvVm8Znn8I=
X-Google-Smtp-Source: AA6agR4gbeELzWeJ61Je42r5xKh3pLfxGhHrG+p/6kCfXsLn7Q35sPMS2Mz+9NAgIsEblPfRPD+7AHIMdIQ=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:b808:8d07:ab4a:554c])
 (user=glider job=sendgmr) by 2002:a5d:4448:0:b0:226:82ff:f3e6 with SMTP id
 x8-20020a5d4448000000b0022682fff3e6mr25180706wrr.115.1662380790918; Mon, 05
 Sep 2022 05:26:30 -0700 (PDT)
Date:   Mon,  5 Sep 2022 14:24:42 +0200
In-Reply-To: <20220905122452.2258262-1-glider@google.com>
Mime-Version: 1.0
References: <20220905122452.2258262-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220905122452.2258262-35-glider@google.com>
Subject: [PATCH v6 34/44] x86: kmsan: skip shadow checks in __switch_to()
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

When instrumenting functions, KMSAN obtains the per-task state (mostly
pointers to metadata for function arguments and return values) once per
function at its beginning, using the `current` pointer.

Every time the instrumented function calls another function, this state
(`struct kmsan_context_state`) is updated with shadow/origin data of the
passed and returned values.

When `current` changes in the low-level arch code, instrumented code can
not notice that, and will still refer to the old state, possibly corrupting
it or using stale data. This may result in false positive reports.

To deal with that, we need to apply __no_kmsan_checks to the functions
performing context switching - this will result in skipping all KMSAN
shadow checks and marking newly created values as initialized,
preventing all false positive reports in those functions. False negatives
are still possible, but we expect them to be rare and impersistent.

Suggested-by: Marco Elver <elver@google.com>
Signed-off-by: Alexander Potapenko <glider@google.com>

---
v2:
 -- This patch was previously called "kmsan: skip shadow checks in files
    doing context switches". Per Mark Rutland's suggestion, we now only
    skip checks in low-level arch-specific code, as context switches in
    common code should be invisible to KMSAN. We also apply the checks
    to precisely the functions performing the context switch instead of
    the whole file.

v5:
 -- Replace KMSAN_ENABLE_CHECKS_process_64.o with __no_kmsan_checks

Link: https://linux-review.googlesource.com/id/I45e3ed9c5f66ee79b0409d1673d66ae419029bcb
---
 arch/x86/kernel/process_64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 1962008fe7437..6b3418bff3261 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -553,6 +553,7 @@ void compat_start_thread(struct pt_regs *regs, u32 new_ip, u32 new_sp, bool x32)
  * Kprobes not supported here. Set the probe on schedule instead.
  * Function graph tracer not supported too.
  */
+__no_kmsan_checks
 __visible __notrace_funcgraph struct task_struct *
 __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 {
-- 
2.37.2.789.g6183377224-goog

