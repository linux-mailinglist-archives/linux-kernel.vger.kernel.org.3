Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E705079C2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 21:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357500AbiDSTEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 15:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357548AbiDSTEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 15:04:42 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBA73FD8E
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 12:01:30 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id n33-20020a17090a5aa400b001d28f5ee3f9so2828745pji.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 12:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=0/oQDgWDKgmKaJrohYsI3DhqEyHGwnTiXQyc5afVPxU=;
        b=r5Y6BdrIe60BFSIxEfcbpjb2XAlOTSE0R1Gd/KjZFYaR5clMDpg9XmTgaUarTL2xCf
         u577kG8fTcWM1vjuNJsgQ2naUeIXRmpDGHBr9oSiOjFm9tEoBHv+KBYxFdhAWDPPMzfr
         Y9MeVh52Ce5Pwq9lzMpf2/pEMU2HFOYFcycgNxh6uPQEkXGkuf4amhrqR9bdZZRHE8H1
         F1nJ802dr8vIKkounGPtZanpsIWBE/7nBiWMGKeTcZf2w2ymg/kpPjFt9+DjpLGV2wG5
         vUbcA6rnXwSMFzI1RnAFBlyQQdWCXRQSEPIbs64J0gCesJNmy8WCOTP/15zDExEAeTy0
         wK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=0/oQDgWDKgmKaJrohYsI3DhqEyHGwnTiXQyc5afVPxU=;
        b=01igysysAvJgo7dQikt8/ZQ9WPASaE7w7rwDx+t/CB4l88xZQFGP2dN5zjEXdQDcxf
         Klg1uOx0/h65/paWd+g84f7oBGXLm3Fs3cKeW0gWeUXs2Z8rvY4Ue8El4f1hT/Ph7MCN
         1+/UFvLUZnghN0cuV3aHKecxRCm/g88LBMU2QejLUYWV9vR3O7Pke/2Q0TV2bYfHeb3C
         GWGAtXoiOGco5gimzG/fEOGCb61FRCOGb0sceMqaHRKlCgH9Aw6ATZ8/925quRUtROv4
         edd5UCsmTDrJct6Q3ZRyXBXjXQNJZFhcszIfB+cF8xmbudMKHzUCHhxcWjwNbGbZKT/W
         r21A==
X-Gm-Message-State: AOAM533D1dO7mZ4vYyhjRKchiuXQYPcC7/1FPjEH+Q+tatEO0vl63LUo
        UosJtUCtlyW5JmaPa3tOulneqg==
X-Google-Smtp-Source: ABdhPJyqsNP5BMD+uH1qubeFi/1H7/73bMXcJyq80BvSra40EaQLV770b0HPc/I1NLsyTe5OCWknyA==
X-Received: by 2002:a17:902:c7c4:b0:158:f139:29d8 with SMTP id r4-20020a170902c7c400b00158f13929d8mr14690808pla.166.1650394890419;
        Tue, 19 Apr 2022 12:01:30 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id d16-20020a056a00245000b004f7728a4346sm18336865pfj.79.2022.04.19.12.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 12:01:30 -0700 (PDT)
Subject: [PATCH v1] RISC-V: Move the "Call Trace" to dump_backtrace()
Date:   Tue, 19 Apr 2022 10:48:42 -0700
Message-Id: <20220419174842.488-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        peterz@infradead.org, keescook@chromium.org, jszhang@kernel.org,
        geert@linux-m68k.org, chenhuang5@huawei.com, changbin.du@intel.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     dvyukov@google.com, nogikh@google.com, syzkaller@googlegroups.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

Our oopses include "Call Trace:", but in a different place than some
other targets do.  This is breaking at least syzkaller, and likely other
bits of tooling that are trying to parse kernel stack traces.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

---

I'm sort of just dead-reckoning this one based on the syzkaller issues
being reported in
<CACT4Y+ZA7CRNfYgPmi6jHTKD9rwvaJy=nh5Gz_c-PFHq3tuziQ@mail.gmail.com>, I
haven't tested this at all.  There's a lot of other stuff here that
arm64 is doing, much of which seems like it could be pulled out into
generic code.  I seem to remember having said that before, though...

I've left this as "Call Trace:" after seeing some patches to convert the
arm/ print from "Call trace:" to "Call Trace:".  I can't find it again
and I remember it sounding like that wasn't necessary, but since we've
already got the capital I see no reason to change it.  That looks to be
the more popular way.

Presumably this will break any tools parsing the current log format, but
given that we've changed it a handful of times and it looks like it's
just blowing up for folks as-is.
---
 arch/riscv/kernel/stacktrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index 08d11a53f39e..d5b91c0d1881 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -108,12 +108,12 @@ static bool print_trace_address(void *arg, unsigned long pc)
 noinline void dump_backtrace(struct pt_regs *regs, struct task_struct *task,
 		    const char *loglvl)
 {
+	pr_cont("%sCall Trace:\n", loglvl);
 	walk_stackframe(task, regs, print_trace_address, (void *)loglvl);
 }
 
 void show_stack(struct task_struct *task, unsigned long *sp, const char *loglvl)
 {
-	pr_cont("%sCall Trace:\n", loglvl);
 	dump_backtrace(NULL, task, loglvl);
 }
 
-- 
2.34.1

