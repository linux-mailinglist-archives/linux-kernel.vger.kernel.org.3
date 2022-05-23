Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8367531F61
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 01:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbiEWXvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 19:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiEWXva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 19:51:30 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306004EA00
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 16:51:29 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id i1so14434735plg.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 16:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7AhCdNNL1uDdWvnH8n7UysRuRPz3w0BpqFn1GxNQ6wo=;
        b=1Bbfnz2CEe3CP9LuZgH+Yi1fosFu5sP9Wokpgm4F8+Wl9npqToJoqlWYHB2GNrs2qx
         rlppxfa2xd3Qd9AjvKs+mgZpfPqlNuXBfcrTuvxBRJHcZgOgCi7W88DYelz9vIsKQ8ly
         FnRw1ZnbOobOuwdNsFSuy3GDQgEot5lnQqU81hduACOaAnFAR4bJ+iLBiyoaqUWX8PDd
         tl2Npwks1KsQ3V/+E82XsiXfKk32h0LPfXIQ5d/fwTftR/XFPQHhbavNHKxnWeAco6OW
         l6OQARpN/P0NJ3DBXgyUR6b40b30+NDHtST9M7jU2eloJxdPLbIebTHeen03ZC2PD9SJ
         PzvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7AhCdNNL1uDdWvnH8n7UysRuRPz3w0BpqFn1GxNQ6wo=;
        b=WtQklHRSiY5vRtzi+DcaHn90aRb12XkYXuzbWtuYSJ1WUr+QEnuMkFDfQEbH8ew/SO
         0M87DWTSnqrqTD98sr/EqF8z85gjhOSapgsZsGu8OHOLvoVndQT+MrLrP5tRXSwMWWbY
         BdssFP1F/poNI9dLPXLkaaI9F0UcTtzwYMlKnSgo1iOrdut0x4+PuTaspETTozNJwEUB
         l7J99qdP8hsSApsIMYOYo5fwDc1AXMjkA93uUz25FeCGw0zQ1L7TL3eob61Wi2T2N6M3
         HMKeFyon5NJf67wK5iBFQOgCvAprbThe6W6n1Jp0hFC3dDrGmKZx1pEoPhObAWtrcgkS
         QF/A==
X-Gm-Message-State: AOAM532um8LyPexUYhZbXrF0iJtiH0kmUkp9uLT3vn1ANbSDo7PRF/AJ
        4icvNmJGPGIzQmqrStSjNDUo5jO+BmKy5A==
X-Google-Smtp-Source: ABdhPJxJlgUqBGNmdxfujP8NZXoTi+2Q6koOMV5QKAyTVb2KSJ7aj12JxlVz6k5/PPpb8rvo4xhCeA==
X-Received: by 2002:a17:90b:391:b0:1df:42e2:ae17 with SMTP id ga17-20020a17090b039100b001df42e2ae17mr1543973pjb.198.1653349888392;
        Mon, 23 May 2022 16:51:28 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id pl15-20020a17090b268f00b001df4b919937sm257084pjb.16.2022.05.23.16.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 16:51:27 -0700 (PDT)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alistair Francis <alistair.francis@wdc.com>,
        Bin Meng <bmeng.cn@gmail.com>,
        Atish Patra <atishp@rivosinc.com>,
        Bin Meng <bin.meng@windriver.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, qemu-devel@nongnu.org,
        qemu-riscv@nongnu.org
Subject: [PATCH v9 02/12] target/riscv: Implement PMU CSR predicate function for S-mode
Date:   Mon, 23 May 2022 16:50:47 -0700
Message-Id: <20220523235057.123882-3-atishp@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220523235057.123882-1-atishp@rivosinc.com>
References: <20220523235057.123882-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Atish Patra <atish.patra@wdc.com>

Currently, the predicate function for PMU related CSRs only works if
virtualization is enabled. It also does not check mcounteren bits before
before cycle/minstret/hpmcounterx access.

Support supervisor mode access in the predicate function as well.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Signed-off-by: Atish Patra <atish.patra@wdc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/csr.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index ee3a35afa256..d175fe3f1af3 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -79,6 +79,57 @@ static RISCVException ctr(CPURISCVState *env, int csrno)
         return RISCV_EXCP_ILLEGAL_INST;
     }
 
+    if (env->priv == PRV_S) {
+        switch (csrno) {
+        case CSR_CYCLE:
+            if (!get_field(env->mcounteren, COUNTEREN_CY)) {
+                return RISCV_EXCP_ILLEGAL_INST;
+            }
+            break;
+        case CSR_TIME:
+            if (!get_field(env->mcounteren, COUNTEREN_TM)) {
+                return RISCV_EXCP_ILLEGAL_INST;
+            }
+            break;
+        case CSR_INSTRET:
+            if (!get_field(env->mcounteren, COUNTEREN_IR)) {
+                return RISCV_EXCP_ILLEGAL_INST;
+            }
+            break;
+        case CSR_HPMCOUNTER3...CSR_HPMCOUNTER31:
+            ctr_index = csrno - CSR_CYCLE;
+            if (!get_field(env->mcounteren, 1 << ctr_index)) {
+                return RISCV_EXCP_ILLEGAL_INST;
+            }
+            break;
+        }
+        if (riscv_cpu_mxl(env) == MXL_RV32) {
+            switch (csrno) {
+            case CSR_CYCLEH:
+                if (!get_field(env->mcounteren, COUNTEREN_CY)) {
+                    return RISCV_EXCP_ILLEGAL_INST;
+                }
+                break;
+            case CSR_TIMEH:
+                if (!get_field(env->mcounteren, COUNTEREN_TM)) {
+                    return RISCV_EXCP_ILLEGAL_INST;
+                }
+                break;
+            case CSR_INSTRETH:
+                if (!get_field(env->mcounteren, COUNTEREN_IR)) {
+                    return RISCV_EXCP_ILLEGAL_INST;
+                }
+                break;
+            case CSR_HPMCOUNTER3H...CSR_HPMCOUNTER31H:
+                ctr_index = csrno - CSR_CYCLEH;
+                if (!get_field(env->mcounteren, 1 << ctr_index)) {
+                    return RISCV_EXCP_ILLEGAL_INST;
+                }
+                break;
+            }
+        }
+    }
+
     if (riscv_cpu_virt_enabled(env)) {
         switch (csrno) {
         case CSR_CYCLE:
-- 
2.25.1

