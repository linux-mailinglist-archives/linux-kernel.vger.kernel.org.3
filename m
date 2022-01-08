Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2500488166
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 06:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiAHFLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 00:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiAHFLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 00:11:30 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFFAC06173F
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 21:11:29 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id b1-20020a17090a990100b001b14bd47532so8827136pjp.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 21:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openresty-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=y9WGOS+NmTpwsfWAaNLR4kcuvqh/6mnBxgOTqljYllg=;
        b=mn2CR4XIf7DQVYu0fqTfWTYBxNu65IiPfwv1HlAf/ALTTJ3+P5rVhrRHdYxevNiaEg
         eWlsdKRIF5v0DxpsZMlAIEpHb0S/agb+1TdIR9v0sQ8oqq5LsWggYlFx+Y6NuqxSxSil
         6aHqXsfbOBznPGcdmOkoo9ZjdtpLRAdUfasPQUBIutE0s7VoSHZ6ZJFP6HFj1jBP4Q+H
         8cS6VvNs64y+ERwLuQ8uCSZn+0CjY9EBR5c4CjGjELaeGf+ZnVnMRijop4DNpXUvUyD5
         iEWxkQeQvZ1i6aW/7eGjVrpqJVYX2m9ttGiovsLfxWH+b5lEYilpvnRalcdBEJ8I5QHd
         CiYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=y9WGOS+NmTpwsfWAaNLR4kcuvqh/6mnBxgOTqljYllg=;
        b=IwvsO1JHEXaovX3uvn/ZGMA/3176DW0aw0KORZbYrPe9jrb4+X451jLzvYEhbxO5hO
         p027POGyRkZkkrGz1DcFd+RXzdd23MHyso9Y3QpafhBrgKRS0ch1dABgOeKB6ihZM9e5
         j6pJ5BH2EMkaQmT/eMKzZT6ZOvYnwQsr87zmHpAAq+x+Y5ZtvMEatx2zc5+bAxdCmdnf
         tCDGM22otzJ/iPMSa2chuzxf/TnfgwFvvLOeHogQ9jW26c50XCfb9hoZd1vXHHPHv6ML
         P+iemDlUTPUYE991dmBOZQeGXl8V9ssbuP+QW/2Z57GcOSpV9hHOjmrlsEbd8DALo1Ip
         +ZyQ==
X-Gm-Message-State: AOAM5300uG4eAsUwaaGA5e7DtEl5YPKIXeqG7/kvCOXA7qsEEaOWjYAR
        kZ3U0PsZ+XPU9KE1qYDIiBYEYA==
X-Google-Smtp-Source: ABdhPJyXnncodsFk1sYhJ9INkN1BNwdN6A1mtZXDP0lfXNH1P2YDSCXWdLhFwc1/n3/1bKwdV6/4ZQ==
X-Received: by 2002:a17:90b:30cc:: with SMTP id hi12mr19315174pjb.50.1641618689293;
        Fri, 07 Jan 2022 21:11:29 -0800 (PST)
Received: from localhost.localdomain (c-98-35-249-89.hsd1.ca.comcast.net. [98.35.249.89])
        by smtp.gmail.com with ESMTPSA id q16sm552808pfu.31.2022.01.07.21.11.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jan 2022 21:11:28 -0800 (PST)
From:   "Yichun Zhang (agentzh)" <yichun@openresty.com>
To:     yichun@openresty.com
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bpf: core: Fix the call ins's offset s32 -> s16 truncation
Date:   Fri,  7 Jan 2022 21:11:21 -0800
Message-Id: <20220108051121.28632-1-yichun@openresty.com>
X-Mailer: git-send-email 2.17.2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BPF interpreter always truncates the BPF CALL instruction's 32-bit
jump offset to 16-bit. Large BPF programs run by the interpreter often
hit this issue and result in weird behaviors when jumping to the wrong
destination instructions.

The BPF JIT compiler does not have this bug.

Fixes: 1ea47e01ad6ea ("bpf: add support for bpf_call to interpreter")
Signed-off-by: Yichun Zhang (agentzh) <yichun@openresty.com>
---
 kernel/bpf/core.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 2405e39d800f..dc3c90992f33 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -59,6 +59,9 @@
 #define CTX	regs[BPF_REG_CTX]
 #define IMM	insn->imm
 
+static u64 (*interpreters_args[])(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5,
+				  const struct bpf_insn *insn);
+
 /* No hurry in this branch
  *
  * Exported for the bpf jit load helper.
@@ -1560,10 +1563,10 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
 		CONT;
 
 	JMP_CALL_ARGS:
-		BPF_R0 = (__bpf_call_base_args + insn->imm)(BPF_R1, BPF_R2,
-							    BPF_R3, BPF_R4,
-							    BPF_R5,
-							    insn + insn->off + 1);
+		BPF_R0 = (interpreters_args[insn->off])(BPF_R1, BPF_R2,
+							BPF_R3, BPF_R4,
+							BPF_R5,
+							insn + insn->imm + 1);
 		CONT;
 
 	JMP_TAIL_CALL: {
@@ -1810,9 +1813,7 @@ EVAL4(PROG_NAME_LIST, 416, 448, 480, 512)
 void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth)
 {
 	stack_depth = max_t(u32, stack_depth, 1);
-	insn->off = (s16) insn->imm;
-	insn->imm = interpreters_args[(round_up(stack_depth, 32) / 32) - 1] -
-		__bpf_call_base_args;
+	insn->off = (round_up(stack_depth, 32) / 32) - 1;
 	insn->code = BPF_JMP | BPF_CALL_ARGS;
 }
 
-- 
2.17.2

