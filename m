Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2074FDDDF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353835AbiDLL2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 07:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235986AbiDLLZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 07:25:43 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FF02C64D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 03:08:48 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id h15-20020a17090a054f00b001cb7cd2b11dso2395435pjf.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 03:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W/lhXgecBDWrQwrmi3IwcGDaw2Q0aGQ9eYgSFA2SGhM=;
        b=h96ap3yBa7UWyXmUVI8Mn1cCYzFKS822KyCaO1ta5E/N3e11l7Mas1O1ootLjyK1Nw
         YySh+UsQ7SE9/6Dg7T+QDaeYVPIJDN5moEr1xxzQ/b1HtxmmSf6d+vRD5MSWGb4piamq
         WJDoHbJ6lqSi1YHB4Z9WylWlnlxJDrOKpfkduxm17Vrv5eTD10KEB8dTKmDt75Jpd75h
         zgj2QNBIBQU0ddaJxo4GCxiNQSx1xTArtxUqzJ7IlbJrgqjOKVMD3lOsjURzagezx2HY
         Yz3TNu3a8OiEIiUFyF3EdSKTsKxPnQLZ9gVkugQ1mVAT+atXCXdE6bjFL5ikeMKjDXvX
         nWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W/lhXgecBDWrQwrmi3IwcGDaw2Q0aGQ9eYgSFA2SGhM=;
        b=ZMAaI0puzPGpjbaqJGQ8HsJ9khrfL/JmO44G0rnAyXpsvwvwMsp4pnOpE6F7PtV9j4
         tVGLgAClcUqsvhN8SZz7vHcYyzykkxzSPxpMSY3Mz4LMCVR4EoJxpwqWleTvhgV76C/x
         QDY0N3qLafvGjuALaI3crXVqeIwvk81zhYnQybSUOHmKH0fSy9YkRJJQSZ1GmkVCbLsA
         D4GHBkji8sps0mYa83f5CE5ayGPc4YmlMe7PeYEdDhJCiGWjoxw2ejo6qu2R0L7HNqYO
         6KVj06a0JU18kshoFH+qzjUfryenH+2C2nyMn2xAFs+ADNzK9d20/sVVwLB7M15XvjkC
         KAdQ==
X-Gm-Message-State: AOAM5338LfhUTO8MfHeEsZTclO2d0rHtqZhEsfwbJUZeQMkB3GBgR1Ry
        zzYWIe926M7btm0nDIdQ5fjmHg==
X-Google-Smtp-Source: ABdhPJzfzwvBiu8Li0ASK1JZWYVvOBz4tGixFxoLswx6dav7qX6DPPIdLdqcrCA/FeYV0cFPx+7lZQ==
X-Received: by 2002:a17:90a:7f94:b0:1cb:1853:da1b with SMTP id m20-20020a17090a7f9400b001cb1853da1bmr4096478pjl.14.1649758127854;
        Tue, 12 Apr 2022 03:08:47 -0700 (PDT)
Received: from localhost.localdomain ([122.182.197.47])
        by smtp.gmail.com with ESMTPSA id j9-20020a056a00130900b004f73df40914sm37515088pfu.82.2022.04.12.03.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 03:08:47 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 5/6] RISC-V: KVM: Reduce KVM_MAX_VCPUS value
Date:   Tue, 12 Apr 2022 15:37:12 +0530
Message-Id: <20220412100713.1415094-6-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220412100713.1415094-1-apatel@ventanamicro.com>
References: <20220412100713.1415094-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

