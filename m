Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B430C57D304
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 20:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbiGUSMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 14:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiGUSMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 14:12:25 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEC63DF0B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 11:12:24 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id q5so2540132plr.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 11:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z3XlA8t9TDZtl4uJYv9cJwWL/SPmBlhXJhsAi+NFr/o=;
        b=GtaROVH6xLNFe7Zt86i4dGHacmXliXAJ+jJ5NtiNtpXOdKGq5Wi/W1tWudXPPjPhn1
         m0WFChGHEZMBukYbZ0DoyDoddePkAohw06EUPzmYlwXgyflgQhLTz9TrabJUWdOUdxcW
         W79guXjajscHP2hNeVNzaGsNRDHU7Sl4Rb4VTOx2toedbRxGUqxFJ6k78dj+rRdWJZqK
         1mFREVmwu4rxsebqhPXl+4Djtv52pG55bPaACi70S/EfuIEaQGytAnpq9FB+gpozzpTu
         dPyyrXSrZTSR4lKIpiHSm4j1S2Ts66ARlqhSCx4XdtyCnn55BoUwMKnYcXb+rx7LSRuk
         JvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z3XlA8t9TDZtl4uJYv9cJwWL/SPmBlhXJhsAi+NFr/o=;
        b=lq8wxZL5SuPQX1XznRrujLABJdz5O2Fm5y7wlbHBrLggBzV8OsfTi9LLPi3X1BaWO5
         0JafkRfw/X2pdd2T4EJq/1BQ27aCLGVkypJrBRFPWSB+oz6ai5DFjbkXvwE/leCLAhui
         zv8shQRBMXXlJiDkVyb85lj+5B25WpEePTdbufZxRRNNSMCVJBPw1Gn2M90TmsBLZOWZ
         6hB1VVechxLWKXCzKETwjzNWDTWZJDfJvjGmIx6GxiwWvS8nd1yGEMzeBSbJxDrPrO6R
         Y0XZpBLifvGMy/YH9aY0AlamLe2r8kjMuABEl9JHYq0Kkg9POhU+lLx8VXrD2egoxZWh
         Q94Q==
X-Gm-Message-State: AJIora+GzBiKYIT8OVE4umQvHhN/ovstzqdwsmJxuTkF1LHUQB/mSMHQ
        L/uUA53jgVhjVULfsBhLsKJmOYtTfzN2Xg==
X-Google-Smtp-Source: AGRyM1sLmCNHB6ZRJMx1svZh7gpfJhld21Y8gtdIzvTWghKGcfXD4XoqTqvJKRLL+Of38AF1zX9oXw==
X-Received: by 2002:a17:902:e841:b0:16c:3053:c7e6 with SMTP id t1-20020a170902e84100b0016c3053c7e6mr44852245plg.163.1658427144286;
        Thu, 21 Jul 2022 11:12:24 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id b12-20020a1709027e0c00b0016d3a354cffsm617358plm.89.2022.07.21.11.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 11:12:24 -0700 (PDT)
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
        Thomas Gleixner <tglx@linutronix.de>,
        Tsukasa OI <research_trasio@irq.a4lg.com>,
        Wei Fu <wefu@redhat.com>
Subject: [PATCH v6 1/4] RISC-V: Add SSTC extension CSR details
Date:   Thu, 21 Jul 2022 11:12:09 -0700
Message-Id: <20220721181212.3705138-2-atishp@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220721181212.3705138-1-atishp@rivosinc.com>
References: <20220721181212.3705138-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

