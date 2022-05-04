Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C2C51AD2C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377233AbiEDSsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377165AbiEDSr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:47:57 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580726574
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 11:44:21 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id q14-20020a17090a178e00b001dc970bf587so1681054pja.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 11:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=VCyTBnecYpNJdRLQCPsrzRcQbyCBtqwFjPmA2xqKa88=;
        b=YNx+vJHh5la1cqk7J51+Ly9mRTpv5jSKyWf75UCfc3ZOzIf9YBKLf7iKP1caXry4f2
         Qr0R9DNxiq560S3gHUdf4bSx/YjMrtnurM+IPCP1p/+8edfGwRboRhxREYbP56zp18Mn
         WzF3fBxbsYfmkBjcmDOGWD3gfgs+OVzowspbyrFoZcePIvyywBwRWkH5gahjMjcAFFny
         H3OSivgwBzQFGXneVm5nXwj5smH3Rd03MY2z9yHT7LYDIKv3WkgVsWms/VH2wKlZS7/d
         ACQ/ZzMZwM/BPd8U5F6qUMXU6EmwN8G32e0z2WtIUOYK2ZvzNd6M0LHaHWwFSxBB9pm0
         MJhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=VCyTBnecYpNJdRLQCPsrzRcQbyCBtqwFjPmA2xqKa88=;
        b=HNtHNKNpbxGom0aAp1HM/9V4rx8uqH33pCfc1djevrxn/s0grSd2QLoHPe1+Bm5N2o
         SlTayLoKGFXQV5HlcWT+1H1dvnd8oBNNtjch2dZ2ITkwaSsJdyyjgwWOfSFVamDN4qIZ
         c3EmkyFHCtcW1JSk3Xdxt5wUWRzsUcyEE9f3EympibUkADJmcuyxX85BQZjes/FEw9ka
         WQNap1/0Zg6Js7MHReh5JIX0Y83xwkg4lYahzanX4vizNyJ+cLt7/yUp2ZDZNPXAwdh0
         BV7c/bTYiodM0TuIOu/1HZgOiSsHq3ouPMxv9I4okGfgICOFDxgZoqWbACvPB0vDSkb8
         5lEg==
X-Gm-Message-State: AOAM533dgMH5jEXiMyiYT86yJGESrk39jnfYWSYfLW4D4PBi9BDxwLmL
        PGu/Jg4clnlCueNaP0zdaBWJ00r5XcPH
X-Google-Smtp-Source: ABdhPJxcxmOQZgwG7ijdgiiboeoF9R0zWhsHRFBvRXOGMQ63dEaW3j2rbPdrIFcHlR+d3fNJwVhWG1ZOtPrm
X-Received: from rananta-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1bcc])
 (user=rananta job=sendgmr) by 2002:a05:6a00:1a4d:b0:50d:5921:1a8f with SMTP
 id h13-20020a056a001a4d00b0050d59211a8fmr21991848pfv.64.1651689860717; Wed,
 04 May 2022 11:44:20 -0700 (PDT)
Date:   Wed,  4 May 2022 18:44:15 +0000
Message-Id: <20220504184415.1905224-1-rananta@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [PATCH] selftests: KVM: aarch64: Let hypercalls use UAPI *_BIT_COUNT
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
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hypercalls test currently defines its own *_BMAP_BIT_MAX macros to
define the last valid feature bit for each bitmap firmware register.
However, since these definitions are already present in the uapi header,
kvm.h, as *_BMAP_BIT_COUNT, and would help to keep the test updated as
features grow, use these instead.

No functional change intended.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 tools/testing/selftests/kvm/aarch64/hypercalls.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/hypercalls.c b/tools/testing/selftests/kvm/aarch64/hypercalls.c
index 41e0210b7a5e..dea019ec4dd9 100644
--- a/tools/testing/selftests/kvm/aarch64/hypercalls.c
+++ b/tools/testing/selftests/kvm/aarch64/hypercalls.c
@@ -18,20 +18,15 @@
 
 #define FW_REG_ULIMIT_VAL(max_feat_bit) (GENMASK(max_feat_bit, 0))
 
-/* Last valid bits of the bitmapped firmware registers */
-#define KVM_REG_ARM_STD_BMAP_BIT_MAX		0
-#define KVM_REG_ARM_STD_HYP_BMAP_BIT_MAX	0
-#define KVM_REG_ARM_VENDOR_HYP_BMAP_BIT_MAX	1
-
 struct kvm_fw_reg_info {
 	uint64_t reg;		/* Register definition */
 	uint64_t max_feat_bit;	/* Bit that represents the upper limit of the feature-map */
 };
 
-#define FW_REG_INFO(r)			\
-	{					\
-		.reg = r,			\
-		.max_feat_bit = r##_BIT_MAX,	\
+#define FW_REG_INFO(r)					\
+	{						\
+		.reg = r,				\
+		.max_feat_bit = r##_BIT_COUNT - 1,	\
 	}
 
 static const struct kvm_fw_reg_info fw_reg_info[] = {
-- 
2.36.0.512.ge40c2bad7a-goog

