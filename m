Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1A250C559
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 02:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbiDWAIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 20:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbiDWAHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 20:07:01 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B722D210187
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 17:03:51 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id n4-20020a170902f60400b00158d1f2d442so5579755plg.18
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 17:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=s8j9kj4vlgoBbVsMqTWGwW74KTbhvSIyPcu9kjmk3mg=;
        b=Kf/obMymV4dKTLaHQ9vU4iXvPrE4oPgT1V7IU2nfscX8IQV7XePv3hocOPRD9WGWS5
         qbqdVHGKg+NzqNIxosRgBK0ZoTUP+V1zuEf6JCVhnsdtSIorKYV1lMswst4f7/aOwsXN
         TeEL29nm1GDndxDwEEU3sPxLD9aehBKPDUQZpO0M6iqu8+C67ydwXnTP6ypLb2nzUYNl
         3bAkmcX7/05uXq7IYcs+GDKCo15Jr0qbLoY55JX2cug1q4nIlf+sfHk3sMv2J68Dro9K
         XIimltu0kNIfB1I9N9SHiI9/77weHhz3n+dpmKV1HpVytDTq+/WIiA8uWayp2iVwGfBz
         D/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=s8j9kj4vlgoBbVsMqTWGwW74KTbhvSIyPcu9kjmk3mg=;
        b=eUAYzK4k4XqypiG6dopom/TeEJmYTOv79MNDaPUje/D5kKclQ4S0ZDEpP4p2hLAHDp
         Kq3DQjARglgiRDAG9vzQ1Mh8WwbVpPMOQHSMk1FfCrH6XitvhHiJpuhuhJgR2UQ4ejgz
         +zCvkVPtrzcZEQkKmybG14jrNsxL+hCtZve/mCc1jpZ0cWnF39Kh9hQqGAizZs9fbhyo
         J3bHf5PxnG1Ng3cOHfZJMHdWtbTiXdf+/3kNQ+GlrohY4z4IajLsWx2MG1y6HFPVTUpi
         Epw8qzlOnMwDCxRpx+oL+iWUhjQ9xPKkNmZn6C6SnRsf8wVtM6AscDQ0EFrZa/CwY5yK
         /zdw==
X-Gm-Message-State: AOAM533JjmrI6h01gII08RMv1EQaEqhcNLh4BPcVRBd+Z1OuzuWeWAl/
        4P2FCioZykeZPA3Wm5YgefdB7P+ezAoP
X-Google-Smtp-Source: ABdhPJxLdnqeaExMLlAnDRAdqhlgHYhal0Uv3YiRM0Qpe3ApegAEaDu5LxZo18Qe+X+tJK/Krg4ftUZZ1Hoe
X-Received: from rananta-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1bcc])
 (user=rananta job=sendgmr) by 2002:aa7:9522:0:b0:4e1:d277:ce8 with SMTP id
 c2-20020aa79522000000b004e1d2770ce8mr7486812pfp.16.1650672230928; Fri, 22 Apr
 2022 17:03:50 -0700 (PDT)
Date:   Sat, 23 Apr 2022 00:03:28 +0000
In-Reply-To: <20220423000328.2103733-1-rananta@google.com>
Message-Id: <20220423000328.2103733-10-rananta@google.com>
Mime-Version: 1.0
References: <20220423000328.2103733-1-rananta@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v6 9/9] selftests: KVM: aarch64: Add the bitmap firmware
 registers to get-reg-list
From:   Raghavendra Rao Ananta <rananta@google.com>
To:     Marc Zyngier <maz@kernel.org>, Andrew Jones <drjones@redhat.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Peter Shier <pshier@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Oliver Upton <oupton@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Raghavendra Rao Anata <rananta@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the psuedo-firmware registers KVM_REG_ARM_STD_BMAP,
KVM_REG_ARM_STD_HYP_BMAP, and KVM_REG_ARM_VENDOR_HYP_BMAP to
the base_regs[] list.

Also, add the COPROC support for KVM_REG_ARM_FW_FEAT_BMAP.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 tools/testing/selftests/kvm/aarch64/get-reg-list.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/kvm/aarch64/get-reg-list.c b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
index 0b571f3fe64c..d3a7dbfcbb3d 100644
--- a/tools/testing/selftests/kvm/aarch64/get-reg-list.c
+++ b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
@@ -294,6 +294,11 @@ static void print_reg(struct vcpu_config *c, __u64 id)
 			    "%s: Unexpected bits set in FW reg id: 0x%llx", config_name(c), id);
 		printf("\tKVM_REG_ARM_FW_REG(%lld),\n", id & 0xffff);
 		break;
+	case KVM_REG_ARM_FW_FEAT_BMAP:
+		TEST_ASSERT(id == KVM_REG_ARM_FW_FEAT_BMAP_REG(id & 0xffff),
+			    "%s: Unexpected bits set in the bitmap feature FW reg id: 0x%llx", config_name(c), id);
+		printf("\tKVM_REG_ARM_FW_FEAT_BMAP_REG(%lld),\n", id & 0xffff);
+		break;
 	case KVM_REG_ARM64_SVE:
 		if (has_cap(c, KVM_CAP_ARM_SVE))
 			printf("\t%s,\n", sve_id_to_str(c, id));
@@ -692,6 +697,9 @@ static __u64 base_regs[] = {
 	KVM_REG_ARM_FW_REG(1),		/* KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1 */
 	KVM_REG_ARM_FW_REG(2),		/* KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2 */
 	KVM_REG_ARM_FW_REG(3),		/* KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_3 */
+	KVM_REG_ARM_FW_FEAT_BMAP_REG(0),	/* KVM_REG_ARM_STD_BMAP */
+	KVM_REG_ARM_FW_FEAT_BMAP_REG(1),	/* KVM_REG_ARM_STD_HYP_BMAP */
+	KVM_REG_ARM_FW_FEAT_BMAP_REG(2),	/* KVM_REG_ARM_VENDOR_HYP_BMAP */
 	ARM64_SYS_REG(3, 3, 14, 3, 1),	/* CNTV_CTL_EL0 */
 	ARM64_SYS_REG(3, 3, 14, 3, 2),	/* CNTV_CVAL_EL0 */
 	ARM64_SYS_REG(3, 3, 14, 0, 2),
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

