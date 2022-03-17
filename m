Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E56F4DBE69
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 06:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiCQFe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 01:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiCQFez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 01:34:55 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9182335F8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 22:02:36 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id kd12so3495348qvb.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 22:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VvVRu/eQ4rluWWC4xLbR2tgbkWAUCRDnVAYNhV1Z6xc=;
        b=M8svGS/iYe/6Axq12vi5bRDCEMlzc6Ij8qRz9Jv2zShz/ObYi/K8LvxnXddnqwdlZ5
         Hy8n9AmCKbusB4osSPTnHAVp8vUxmh7SSg9lwbwwufhybms+bvk63V8UIvo3q7mbeWUr
         ms0f7znXjC7cHbVmrOohql/i6f8ctFGbu8I9sNEgFyiZeOLtmREtacl8Yw4snmOA8pXM
         kQilYsz8Wh8v2crCMneeQf+7yJnPEZ2x4vdo/qdi/D/NOFRsSbZ+5MsxXFKvgaMYLpf+
         WUk8rZ4g3h3S5QvnL30UOp/JJuMmWm3L6uvPr4rQBgKs/g6hiojbCciTRUP/h0N9SzjX
         D/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VvVRu/eQ4rluWWC4xLbR2tgbkWAUCRDnVAYNhV1Z6xc=;
        b=AC1TZFB+NXjyApUwfjEqJG8AnFd/vH2QU5AKNbpXNYrAExtcGNlSTcCag1tS2Smuly
         zF7KoOxgCchy4RjquJQs74qtuVfrpHyJDMC7fS0xsAgrs3FuWKddp0A4fDQAg9DT05J4
         hxuHjkDIyegAcXd14C5QLP7OBsdQlDvJfSqS1ySn33h7JTvbyWbxcYtMe2Zluv6TCTf9
         yUCTMNzWVQshhIfuEcjdpnnFequB0h6QgjVI9hCR3S8qTYkcg4bWZ1E/oQMwtvNY+Tjg
         A1hK2v810M9grJuTknG0Gj5BUotgBx99IxYPo295sgHsLAxGalROff3Ljb3d8fmd8SPO
         eR4A==
X-Gm-Message-State: AOAM533dvB6pb0wILK6ICz5KeFwWilIsokqi1hGXXOErbITuoriA38CH
        ddhWTKlzYqMSrsEm5NWPNo/f7/4p8+Xznw==
X-Google-Smtp-Source: ABdhPJyi19/Qz8TowVm2OmKd/W9qF6RFe2vVau6sqR7JL6Hr7iGFozZcp/GI1PSjE0Jf1/f0WMuLow==
X-Received: by 2002:a17:903:234d:b0:153:b63f:8abf with SMTP id c13-20020a170903234d00b00153b63f8abfmr3060697plh.51.1647489342392;
        Wed, 16 Mar 2022 20:55:42 -0700 (PDT)
Received: from localhost.localdomain ([122.171.160.59])
        by smtp.gmail.com with ESMTPSA id 132-20020a62168a000000b004f40e8b3133sm5074436pfw.188.2022.03.16.20.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 20:55:41 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>,
        stable@vger.kernel.org
Subject: [PATCH] RISC-V: KVM: Don't clear hgatp CSR in kvm_arch_vcpu_put()
Date:   Thu, 17 Mar 2022 09:25:21 +0530
Message-Id: <20220317035521.272486-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
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

We might have RISC-V systems (such as QEMU) where VMID is not part
of the TLB entry tag so these systems will have to flush all TLB
enteries upon any change in hgatp.VMID.

Currently, we zero-out hgatp CSR in kvm_arch_vcpu_put() and we
re-program hgatp CSR in kvm_arch_vcpu_load(). For above described
systems, this will flush all TLB enteries whenever VCPU exits to
user-space hence reducing performance.

This patch fixes above described performance issue by not clearing
hgatp CSR in kvm_arch_vcpu_put().

Fixes: 34bde9d8b9e6 ("RISC-V: KVM: Implement VCPU world-switch")
Cc: stable@vger.kernel.org
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/kvm/vcpu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index 624166004e36..6785aef4cbd4 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -653,8 +653,6 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 				     vcpu->arch.isa);
 	kvm_riscv_vcpu_host_fp_restore(&vcpu->arch.host_context);
 
-	csr_write(CSR_HGATP, 0);
-
 	csr->vsstatus = csr_read(CSR_VSSTATUS);
 	csr->vsie = csr_read(CSR_VSIE);
 	csr->vstvec = csr_read(CSR_VSTVEC);
-- 
2.25.1

