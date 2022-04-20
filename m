Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78775086EE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 13:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378027AbiDTL2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 07:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378029AbiDTL2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 07:28:18 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E671E3D0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 04:25:24 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id s137so1342877pgs.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 04:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W/lhXgecBDWrQwrmi3IwcGDaw2Q0aGQ9eYgSFA2SGhM=;
        b=mq0MqMZABzTc+/HenZrx4jIjHskHGbPWFO0zolX7aGm6nOvmdHo3sUi4z1OzbFH1kY
         FZYRRTiZGfmnFe905yHmrNmy082WbSRJL5akr43VqfbRTWKbyWgJh2aUSPzmG/g1Qjqb
         RRIDlaEWJVGnkZ7JhAPFeyh9XKD5/PSU4g1P/ofzzHSV50GyRPFTt1SJniBKJ1xXP97N
         hV49noZYTRKb/YbNmpp8lI55WEJcKdgvoU45RRpHcSHe0xh0pefKcprDEFalAnYcp1iI
         7gn7AJxBgE3WHX2UtcXxYc1BxfBHMcEyFOwGqYMjbp6Yu2rC5WGzKGJNeg4xVwiP2+q0
         Rc0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W/lhXgecBDWrQwrmi3IwcGDaw2Q0aGQ9eYgSFA2SGhM=;
        b=dfgT0DvP7EbbKopWvD/Z3FNUNz+o5V2YqvEzq/VtdNABuRGhkpHekg6O5S/L5ka7Zw
         49/+wdudblTVyFvVxarWL7ETbqFFk0EIcuXL4jCiLaah078+JBhV/AitHuhPhbLh2ybK
         k9dL/YooBNRbl8KwFIJ6S/WuGdXG3uKrLYHJHFznJ12Vfzqdfu1Jp8vjTBkzjs52+ObB
         HkFPCQndDCrpFrXzauVlB4ud2xKQO+bMTtbw/x0iw1bLU3J74Ij1sFvnKMsbVhiIatMV
         Iqd1w48Aig2VNIXyj167VR+6VxOqi+fsps92iMsfKHBF4arAk77pVHykLBFSYIZG5RVU
         0AeQ==
X-Gm-Message-State: AOAM530VK/Xq/isa3nZ5wBtcuRDYYCME8cKPvSXZKL+N1wSLhAFsBkYf
        7CsdFghzcVFMfEs6Ysh71qq1vQ==
X-Google-Smtp-Source: ABdhPJz9nV0msPZvcrWhZpToFAJ37v3xNoclCZihIzibbkZvB62z1STbaDlTLIG+owmRpdjqD288fQ==
X-Received: by 2002:a05:6a00:996:b0:505:b6d2:abc8 with SMTP id u22-20020a056a00099600b00505b6d2abc8mr22909619pfg.11.1650453924256;
        Wed, 20 Apr 2022 04:25:24 -0700 (PDT)
Received: from localhost.localdomain ([122.167.88.101])
        by smtp.gmail.com with ESMTPSA id u12-20020a17090a890c00b001b8efcf8e48sm22529274pjn.14.2022.04.20.04.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 04:25:23 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v2 5/7] RISC-V: KVM: Reduce KVM_MAX_VCPUS value
Date:   Wed, 20 Apr 2022 16:54:48 +0530
Message-Id: <20220420112450.155624-6-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220420112450.155624-1-apatel@ventanamicro.com>
References: <20220420112450.155624-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the KVM_MAX_VCPUS value is 16384 for RV64 and 128
for RV32.

The KVM_MAX_VCPUS value is too high for RV64 and too low for
RV32 compared to other architectures (e.g. x86 sets it to 1024
and ARM64 sets it to 512). The too high value of KVM_MAX_VCPUS
on RV64 also leads to VCPU mask on stack consuming 2KB.

We set KVM_MAX_VCPUS to 1024 for both RV64 and RV32 to be
aligned other architectures.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/asm/kvm_host.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
index 806f74dc0bfc..61d8b40e3d82 100644
--- a/arch/riscv/include/asm/kvm_host.h
+++ b/arch/riscv/include/asm/kvm_host.h
@@ -16,8 +16,7 @@
 #include <asm/kvm_vcpu_fp.h>
 #include <asm/kvm_vcpu_timer.h>
 
-#define KVM_MAX_VCPUS			\
-	((HGATP_VMID_MASK >> HGATP_VMID_SHIFT) + 1)
+#define KVM_MAX_VCPUS			1024
 
 #define KVM_HALT_POLL_NS_DEFAULT	500000
 
-- 
2.25.1

