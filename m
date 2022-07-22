Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E7E57E4D8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 18:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235987AbiGVQvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 12:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235870AbiGVQu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 12:50:57 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2C92A260
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 09:50:56 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id bh13so4884058pgb.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 09:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z3XlA8t9TDZtl4uJYv9cJwWL/SPmBlhXJhsAi+NFr/o=;
        b=7tomhJF3u9LLXyYKG/mq8DM+QQ5eXZlTmLQ/bRtzbuFTsoGyHBxFMuvLF9qFtb26F0
         7nLXbAx65p0+2AImCE2S5PQ8m6o5oHJbnmu7aaNWTr9cmaTfyX/W8lpenujNRCaLf7Dx
         pZ1WFMUz4YOgIr5bZZrSJir6FzhWmkFhsJ85EqoL+hdVXHW/QxnfSaFeDh09LlnVytZi
         jCUXfBfbQ8tEWhDDuY9lEVL0Pbx0LjXwtUjFT++6Ejxse9NuUgPOiP/1ts68BBDr58U8
         5oUiDb67b1rZgKGa+zUEfvOfPfGea9NSwkjUv3c1t7fUFb6Ja+kV3bW2HBmJNIJUhAJ6
         aong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z3XlA8t9TDZtl4uJYv9cJwWL/SPmBlhXJhsAi+NFr/o=;
        b=H4imSP0FBdNEDs323CfFDw7QgZJq2iEmwz42HSZE1a2/cyBt7d2w3Lv278qvgCkfy5
         KbKUueuHS7CZmR9MByTqHUSfKLnBTRPDiON8V/yd/HRnYJIc7+yFAAPDhDqAaiNgPAaD
         zSs2fZDQirrjlK86IMpu2qcS6eesSU3xwLtAisX2QG+dnMfq8FVHwiTeuDEioq5iM9oj
         CsQ1EJBC4mOqRmcQWOF93P/Onf8XOjacZR7nYe/aXtHCYTLEzmEEV0pSwFXrXS17xo6r
         uBv+RrxSPtuLffrufC5Pg8Xgad97FUf6FugcdZa/vnV7cGBqISql7M+w3UMEfPf+4TED
         nj8A==
X-Gm-Message-State: AJIora+t8ITP+uv6tfHdXGIE6hxk0dz0G8lTt+rBKj0DRbKC/K+patCU
        UTIjwE7TWOBkw/b7oN6ziFbp7+wHI9o94A==
X-Google-Smtp-Source: AGRyM1s+HPeBLYkB+YD2xjmmGBSIoqOGqhGo5tNM6KQjvnM0lOzs/Zmq8GIH6N4CmqMxSOzReT4cUQ==
X-Received: by 2002:a62:4e85:0:b0:52b:3245:ba20 with SMTP id c127-20020a624e85000000b0052b3245ba20mr767732pfb.5.1658508655499;
        Fri, 22 Jul 2022 09:50:55 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id s7-20020a170902ea0700b0016a3f9e4865sm4028476plg.148.2022.07.22.09.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 09:50:55 -0700 (PDT)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guo Ren <guoren@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tsukasa OI <research_trasio@irq.a4lg.com>,
        Wei Fu <wefu@redhat.com>
Subject: [PATCH v7 1/4] RISC-V: Add SSTC extension CSR details
Date:   Fri, 22 Jul 2022 09:50:44 -0700
Message-Id: <20220722165047.519994-2-atishp@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220722165047.519994-1-atishp@rivosinc.com>
References: <20220722165047.519994-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch just introduces the required CSR fields related to the
SSTC extension.

Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/csr.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 17516afc389a..0e571f6483d9 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -247,6 +247,9 @@
 #define CSR_SIP			0x144
 #define CSR_SATP		0x180
 
+#define CSR_STIMECMP		0x14D
+#define CSR_STIMECMPH		0x15D
+
 #define CSR_VSSTATUS		0x200
 #define CSR_VSIE		0x204
 #define CSR_VSTVEC		0x205
@@ -256,6 +259,8 @@
 #define CSR_VSTVAL		0x243
 #define CSR_VSIP		0x244
 #define CSR_VSATP		0x280
+#define CSR_VSTIMECMP		0x24D
+#define CSR_VSTIMECMPH		0x25D
 
 #define CSR_HSTATUS		0x600
 #define CSR_HEDELEG		0x602
-- 
2.25.1

