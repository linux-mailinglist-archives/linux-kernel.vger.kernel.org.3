Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23DB525F6C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 12:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379058AbiEMJ2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 05:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379087AbiEMJ0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 05:26:21 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707E92AC60
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 02:26:13 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id z20-20020a50f154000000b0042815e3008cso4610424edl.15
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 02:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=9O8T4d24GJyDP8cnDNbV2+/gozd6tLFGA4/uUL04NR0=;
        b=iaKsTEqI7n6J/fP4v02bJyqUWoPtt5dhrjPs4ksBSNCBKOaXfDWwhOHzfJYQmcM+0l
         Osrd15SpJ/MUZVIrB2FnK9UyK05ZdH+RsxYG+9/juYL0xN4508oz+GpVT+6S4G95JeVn
         lzoKLMokWswGEorBviYK4hjGCsSNM4m8xdzn9TFgjxi2VEnFDGeyRURQzqIbIU6QbqJo
         scrHRXgr3/gzL/+DzERkF9yhkcv8Kd+tWMyBpmqr45Eg/xE0MvCzOrJP1R4LehaAbjl8
         Fq88TC29HBPTuxne5MzNIwAiVYuBgTZ8tWZXEKUE9VWNMUXuAoNg/SJwwN2JllFqQuKH
         0LVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=9O8T4d24GJyDP8cnDNbV2+/gozd6tLFGA4/uUL04NR0=;
        b=xUQUV5XCauhxtqMF5WbyXmLzL8AltjksvgbGIfZWoFsifP1bDuGJBhJFMeKxA8+sMT
         UFZXlLEk5pwD4CnTfbVZ337PNynMdvF6/2pOWshrQQS6EDml3VeyeMF6fxDiYXbw0mb8
         WlfDIV8cSfiCZp/KB/ECKm+X5yfw9J8+z2LVb+9TS9RwLoaNKDKHLOyqz1CNJOge0bF4
         /AF0vBo0Vtn9lxK3T48NTEp9BpmZ8EUZ1B1eITbj2y/ohdgK7CC8GG0F5bQDvq8jSF2K
         w0SJD9lb3rgCalMXSDuVnuaO9rM+Wr+0UznJhaesTFIeV0hWVuBIHrc1W4vY0IqYzGgm
         vUtg==
X-Gm-Message-State: AOAM531u4kZScrxl6bLqAFPXb0ivZ5aG8oNB/5GYndzZAmPq7vkOMkNl
        AMIslnyAcmzW8QAgLilwy6oqh6pIgCIo
X-Google-Smtp-Source: ABdhPJzEbS2hvb75/jq83OEwqeWgJNKE9I/lr4SjkTANlLOQGKApCVrv++PbFYZ8MimaO9CjAM0i3IiAohaE
X-Received: from big-boi.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:129])
 (user=qperret job=sendgmr) by 2002:aa7:c656:0:b0:428:3280:a432 with SMTP id
 z22-20020aa7c656000000b004283280a432mr39932843edr.396.1652433971840; Fri, 13
 May 2022 02:26:11 -0700 (PDT)
Date:   Fri, 13 May 2022 09:26:07 +0000
Message-Id: <20220513092607.35233-1-qperret@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH] KVM: arm64: Don't hypercall before EL2 init
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Quentin Perret <qperret@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Will reported the following splat when running with Protected KVM
enabled:

[    2.427181] ------------[ cut here ]------------
[    2.427668] WARNING: CPU: 3 PID: 1 at arch/arm64/kvm/mmu.c:489 __create_hyp_private_mapping+0x118/0x1ac
[    2.428424] Modules linked in:
[    2.429040] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.18.0-rc2-00084-g8635adc4efc7 #1
[    2.429589] Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
[    2.430286] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    2.430734] pc : __create_hyp_private_mapping+0x118/0x1ac
[    2.431091] lr : create_hyp_exec_mappings+0x40/0x80
[    2.431377] sp : ffff80000803baf0
[    2.431597] x29: ffff80000803bb00 x28: 0000000000000000 x27: 0000000000000000
[    2.432156] x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
[    2.432561] x23: ffffcd96c343b000 x22: 0000000000000000 x21: ffff80000803bb40
[    2.433004] x20: 0000000000000004 x19: 0000000000001800 x18: 0000000000000000
[    2.433343] x17: 0003e68cf7efdd70 x16: 0000000000000004 x15: fffffc81f602a2c8
[    2.434053] x14: ffffdf8380000000 x13: ffffcd9573200000 x12: ffffcd96c343b000
[    2.434401] x11: 0000000000000004 x10: ffffcd96c1738000 x9 : 0000000000000004
[    2.434812] x8 : ffff80000803bb40 x7 : 7f7f7f7f7f7f7f7f x6 : 544f422effff306b
[    2.435136] x5 : 000000008020001e x4 : ffff207d80a88c00 x3 : 0000000000000005
[    2.435480] x2 : 0000000000001800 x1 : 000000014f4ab800 x0 : 000000000badca11
[    2.436149] Call trace:
[    2.436600]  __create_hyp_private_mapping+0x118/0x1ac
[    2.437576]  create_hyp_exec_mappings+0x40/0x80
[    2.438180]  kvm_init_vector_slots+0x180/0x194
[    2.458941]  kvm_arch_init+0x80/0x274
[    2.459220]  kvm_init+0x48/0x354
[    2.459416]  arm_init+0x20/0x2c
[    2.459601]  do_one_initcall+0xbc/0x238
[    2.459809]  do_initcall_level+0x94/0xb4
[    2.460043]  do_initcalls+0x54/0x94
[    2.460228]  do_basic_setup+0x1c/0x28
[    2.460407]  kernel_init_freeable+0x110/0x178
[    2.460610]  kernel_init+0x20/0x1a0
[    2.460817]  ret_from_fork+0x10/0x20
[    2.461274] ---[ end trace 0000000000000000 ]---

Indeed, the Protected KVM mode promotes __create_hyp_private_mapping()
to a hypercall as EL1 no longer has access to the hypervisor's stage-1
page-table. However, the call from kvm_init_vector_slots() happens after
pKVM has been initialized on the primary CPU, but before it has been
initialized on secondaries. As such, if the KVM initcall procedure is
migrated from one CPU to another in this window, the hypercall may end up
running on a CPU for which EL2 has not been initialized.

Fortunately, the pKVM hypervisor doesn't rely on the host to re-map the
vectors in the private range, so the hypercall in question is in fact
superfluous. Skip it when pKVM is enabled.

Reported-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 523bc934fe2f..7347c133efc4 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1436,7 +1436,7 @@ static int kvm_init_vector_slots(void)
 	base = kern_hyp_va(kvm_ksym_ref(__bp_harden_hyp_vecs));
 	kvm_init_vector_slot(base, HYP_VECTOR_SPECTRE_DIRECT);
 
-	if (kvm_system_needs_idmapped_vectors() && !has_vhe()) {
+	if (kvm_system_needs_idmapped_vectors() && !has_vhe() && !is_protected_kvm_enabled()) {
 		err = create_hyp_exec_mappings(__pa_symbol(__bp_harden_hyp_vecs),
 					       __BP_HARDEN_HYP_VECS_SZ, &base);
 		if (err)
-- 
2.36.0.550.gb090851708-goog

