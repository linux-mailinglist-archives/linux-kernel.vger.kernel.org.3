Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29EF74EA887
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 09:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbiC2Hb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 03:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbiC2HbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 03:31:24 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C021D315
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 00:29:37 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id mp6-20020a17090b190600b001c6841b8a52so1317121pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 00:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0HpwULoTFveWXl4V/JL0uWMQpAlO9P0Ps2jhRe3PZdI=;
        b=kF8viRN8VFCL1uNo9D6ZUyCgw9eFpyecK3uRGR8wpUQFmHxTfHZFyptqrp5t0lZu06
         JFlvhmxASkTOycvxyaHDul06KAd/YihiOZC8edSC3ff6j/40/8pp6+YK383GA9SvQ0U1
         td+9tyfhMqXLjIQ7gkcPM+R4LC+xWeOD4B+AJshFKXebhMR+zOOUivCtkd6oH6k3LJU8
         YyK1oOWO/cu04eR6ymTj0ZJ41ojlIeG0wP+GOzrN20Na3uEDphlN56znbvx8I2SGzc3g
         cOfTHjGK3GYZDNodXAjBwVvrSVBr4tqTndpghoEp7OdOnqAy0rZ3ns689yM76MRYlLfR
         80mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0HpwULoTFveWXl4V/JL0uWMQpAlO9P0Ps2jhRe3PZdI=;
        b=ZjA5KzJhMNmzJn/j8g+z03+DfCtXrCNbCsRbYag7UjfcghECU67aBI+3dp9l594d0Q
         6lhBwlYDBp3oyXDySO2YKu/wlPX1Zn/uWhiFx49WwXuIqKcZd6jEER38okbZo3ohcWRp
         jwCZyMVW/ePwEopbB7pzU8KVL23lUmBGYx+8OktjryDBgmGcx/HVSOyGWO+hxD+XClqB
         NXQfn1jKKr+4lndz4q8o05yRLJnzTofNTFYMGVhv+KrJ/6gFTClpCMdWOGbKBHY9M5Sl
         ge7XnVc/eHBQ2RrCS3AsaWyfY8Sfl56adhJGjXRBT5qW2EfQP1wBEEgMNEjO6gHqU+VM
         HTFw==
X-Gm-Message-State: AOAM531vraKQm+iZiUfF9LeygaC0qz6iXNU0O2L+N9vAmRrwfQ76PPYe
        1lSrOpImZHZF1Xy5lgQCK70d3w==
X-Google-Smtp-Source: ABdhPJwv9HEf1+Tg5g89cxyYW4osYZtB2rzBNpuRrv2oD5B9ruSdYimiL5jrIew81samurr7NTJlFQ==
X-Received: by 2002:a17:902:e545:b0:154:4d5b:2006 with SMTP id n5-20020a170902e54500b001544d5b2006mr29028859plf.94.1648538977366;
        Tue, 29 Mar 2022 00:29:37 -0700 (PDT)
Received: from localhost.localdomain ([122.171.166.231])
        by smtp.gmail.com with ESMTPSA id z6-20020a056a00240600b004e17ab23340sm19440564pfh.177.2022.03.29.00.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 00:29:36 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 2/3] KVM: selftests: riscv: Fix alignment of the guest_hang() function
Date:   Tue, 29 Mar 2022 12:59:10 +0530
Message-Id: <20220329072911.1692766-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220329072911.1692766-1-apatel@ventanamicro.com>
References: <20220329072911.1692766-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The guest_hang() function is used as the default exception handler
for various KVM selftests applications by setting it's address in
the vstvec CSR. The vstvec CSR requires exception handler base address
to be at least 4-byte aligned so this patch fixes alignment of the
guest_hang() function.

Fixes: 3e06cdf10520 ("KVM: selftests: Add initial support for RISC-V
64-bit")
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 tools/testing/selftests/kvm/lib/riscv/processor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
index d377f2603d98..3961487a4870 100644
--- a/tools/testing/selftests/kvm/lib/riscv/processor.c
+++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
@@ -268,7 +268,7 @@ void vcpu_dump(FILE *stream, struct kvm_vm *vm, uint32_t vcpuid, uint8_t indent)
 		core.regs.t3, core.regs.t4, core.regs.t5, core.regs.t6);
 }
 
-static void guest_hang(void)
+static void __aligned(16) guest_hang(void)
 {
 	while (1)
 		;
-- 
2.25.1

