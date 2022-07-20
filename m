Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA8B57BE58
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 21:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbiGTTX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 15:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbiGTTXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 15:23:54 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D98528A3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 12:23:53 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id s18-20020a17090aa11200b001f1e9e2438cso3027030pjp.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 12:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z3XlA8t9TDZtl4uJYv9cJwWL/SPmBlhXJhsAi+NFr/o=;
        b=iGs/G8Fk8ICWu/8fkztpMX5VcYaKBChHqfCs1g5Yp+fv5KwxH+DRPv+4Cn9Le5g9hq
         5g2I2tD2ixzrPbpgPQSJSEcBaa1BeEyrnJ+uyosHqPFaWgXDfL2YVrSv3v/NtEukLPuW
         RCVHM/eSjFmbUh1z9d2RCywE+GRiF6jYxX2Dv0ppyXm4qaCZ498dXsnvvt428KcKUzlg
         bnmpjbxCLgFb851k+iBmTb02jv5bwsI8tB1hKW24E867I8ebe4Sm1ETvxpJ01mDEQIJG
         R0Sbj2sgj5wCd2H6wstT6sWfqMUoXQ3UZlOVdFy3okYNSStxgxE4GEN5XOeIfpk4LsTD
         /M2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z3XlA8t9TDZtl4uJYv9cJwWL/SPmBlhXJhsAi+NFr/o=;
        b=EuXwSMZ1fJRHqfRkfz3UGPfOmUwaWjA10mB2Ppk9rTy1iLZSYpM79jY7z+U2uRI+kS
         jcy17shCl4LH0Ov1MUZZxRS9H9sleRz6874beWlTvjDOO6/megySxazIm3+QqoYjLNcE
         IRvAytZmbxF55jbiipZ0VAU31N/F2/jYDDbfoEt4TWjxe6MMLacbx8MyqsDD2Tab/iBA
         VHnwINb3HN+oJsB6vvBQ5TlMiYsA+EHppGOF74CnjxEEiE496KzzIlGOxn9kIFy8mwUR
         rDQzXLknG8AuZPDH8nm8tyPkMlU9QD95hV02bwQ9tucEBc8O5lmlzb6Qs4LFSj93V4NU
         +x7A==
X-Gm-Message-State: AJIora+INZHldv27Q/IZV24Tjo1yP92Dz6TU6pXy4rFUQXBY/9OhhDYk
        MT5skn4eXfLKwSZ+kBSzQduOvQpfnEmFKg==
X-Google-Smtp-Source: AGRyM1uO6DuNqM2Sqju5yNtntBjmlH8f8n/3L/OrpS4Iy1m8+BKt/id8mOYe3xVwttvCP45QG4aMPw==
X-Received: by 2002:a17:902:d2d1:b0:16c:223e:a3db with SMTP id n17-20020a170902d2d100b0016c223ea3dbmr40728628plc.37.1658345032791;
        Wed, 20 Jul 2022 12:23:52 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id y23-20020a17090264d700b0016d2e772550sm219902pli.175.2022.07.20.12.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 12:23:52 -0700 (PDT)
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
        Liu Shaohua <liush@allwinnertech.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tsukasa OI <research_trasio@irq.a4lg.com>,
        Wei Fu <wefu@redhat.com>
Subject: [PATCH v5 1/4] RISC-V: Add SSTC extension CSR details
Date:   Wed, 20 Jul 2022 12:23:39 -0700
Message-Id: <20220720192342.3428144-2-atishp@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220720192342.3428144-1-atishp@rivosinc.com>
References: <20220720192342.3428144-1-atishp@rivosinc.com>
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

