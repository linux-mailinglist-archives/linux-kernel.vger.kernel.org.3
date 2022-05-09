Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B1A52026E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 18:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239068AbiEIQaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 12:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239041AbiEIQaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 12:30:12 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1D320132C
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 09:26:17 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2f825f8c944so124609447b3.15
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 09:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xGoqp6X+CPpEHo725m8Wu+g1erF1chW9bMEShQucuQI=;
        b=N0Zb4Gxa4HC1uAASPa5PNvN6IZjx7J7GkqJJxcHMPKOV18yjIl3pcEmceZOJesdcnG
         QyYuP15OLQgQAzxZvOx9T/u4IcSod9jZabxpWQQRxegBDjAddti9A+I5FItlHEwguaJN
         TpTsFWnpbz8e2DrUL88byAshOTHwqCzr3yK86hOE/LVy9b/KYkpySe/p+6GKXer9+ZsT
         AJn8WeUun7zv6Aus63gh3Xr1mdIhrS9YxFDp64pMHUMFpR3ooGR2iVg+ijhT2AzXWlvC
         0smRDvmncy7dBiwIBRAlq8Ds4xGlgiZR/k0QeJkvUFeyICFF+QBvChLD1FP9jVkilG9n
         6zEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xGoqp6X+CPpEHo725m8Wu+g1erF1chW9bMEShQucuQI=;
        b=me2ZD/+/gznvKhH1JT8MWEZqjMlf3pWQ3EehW23+jT7sF73LGc2gbdEKV0xVJkZyQ8
         56OE9+FXT4fyiayn/4iJmC/CDOKPMxSwXfJTI7gurCkSSgwtY29eEEhR8aEwDpLWT4ql
         PIhMweeWnDAlzYn4a3BDqPJPzy5OSAA0ISls/V9tSZHf0LeqrZG3ZIimBhMJt3+PwErh
         vT7M8sdszp3GXWvJWxtYgvnw64NSRQJHcQBZ3l1OLL7AgXn89fAza0SLGuOpORZsp5Gb
         4eBSTTPLwR+/TASZBUTqWqV56G2257qTW8drMqxCW9wBbV2e8GE/KElV60srwLDLHroO
         LD9Q==
X-Gm-Message-State: AOAM530FlXCYBvAAQxskTgFIE0enDxcaYapY7lU01DQqSfolpuY3hs5/
        3Rj0GoxNgO8VNaPQESJL3713L8JJb+0=
X-Google-Smtp-Source: ABdhPJwbEmmNk02jHZlxW+mCJH3BMBXB3kvXc9tx+Zc+AF6gVkBuuuHex37mMcuOHpy47pgj2Z6U4qDyQ2M=
X-Received: from oupton3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:21eb])
 (user=oupton job=sendgmr) by 2002:a25:3157:0:b0:649:b216:bb4e with SMTP id
 x84-20020a253157000000b00649b216bb4emr14278182ybx.387.1652113576747; Mon, 09
 May 2022 09:26:16 -0700 (PDT)
Date:   Mon,  9 May 2022 16:25:59 +0000
In-Reply-To: <20220509162559.2387784-1-oupton@google.com>
Message-Id: <20220509162559.2387784-3-oupton@google.com>
Mime-Version: 1.0
References: <20220509162559.2387784-1-oupton@google.com>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [PATCH 2/2] KVM: arm64: pkvm: Don't mask already zeroed FEAT_SVE
From:   Oliver Upton <oupton@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, maz@kernel.org, james.morse@arm.com,
        alexandru.elisei@arm.com, suzuki.poulose@arm.com, tabba@google.com,
        qperret@google.com, will@kernel.org,
        Oliver Upton <oupton@google.com>
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

FEAT_SVE is already masked by the fixed configuration for
ID_AA64PFR0_EL1; don't try and mask it at runtime.

No functional change intended.

Signed-off-by: Oliver Upton <oupton@google.com>
---
 arch/arm64/kvm/hyp/nvhe/sys_regs.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/sys_regs.c b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
index 33f5181af330..3f5d7bd171c5 100644
--- a/arch/arm64/kvm/hyp/nvhe/sys_regs.c
+++ b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
@@ -90,9 +90,6 @@ static u64 get_pvm_id_aa64pfr0(const struct kvm_vcpu *vcpu)
 	u64 set_mask = 0;
 	u64 allow_mask = PVM_ID_AA64PFR0_ALLOW;
 
-	if (!vcpu_has_sve(vcpu))
-		allow_mask &= ~ARM64_FEATURE_MASK(ID_AA64PFR0_SVE);
-
 	set_mask |= get_restricted_features_unsigned(id_aa64pfr0_el1_sys_val,
 		PVM_ID_AA64PFR0_RESTRICT_UNSIGNED);
 
-- 
2.36.0.512.ge40c2bad7a-goog

