Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816674D5ACC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346528AbiCKFwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346518AbiCKFwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:52:13 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50490ECB28
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:09 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id x10-20020a170902a38a00b00151e09a4e15so3991937pla.15
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=oO6SkjEiUDbSzkcF/OQIzEks0/M78f3nx/F5kOnCdxM=;
        b=a1G2oSVZEWkawgXshmlwrmCPCRYc8bhXsgpGecRuCtowOFkiKW7W3Y1nzMIGVeoCvh
         kkHJHMTJvNZepmQwWpRbl0KCnw077OZlavM5FDAXW53ImTbfQ+OWwzPfZxnxzULTQ73M
         7IzTkIh9R3pQAUbJew+jgabAF3NqoUMhOY5UKHvQg3+BeYmTyL7yp59Mx2a43YpTo3TA
         FxnWl2L1TQjDSGfXDgRpGyS2PQyt0lTq2vqcUe2ZhEPKoshcT+Swm+WnbDoi6WxPvM5h
         36Dp3K1XpnAtOjlZs60t0+E8sow9YfQMBzxqtgIwcXH8W1ghKAHSQIr8bTNGNYpcJywC
         Gu1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=oO6SkjEiUDbSzkcF/OQIzEks0/M78f3nx/F5kOnCdxM=;
        b=tdkddBJmPQVmLZn9lZc/LpCEiJtk7T9iEyT3m+9MuMHGKr2C46MoBUrCRVYDMGJ3sL
         yWBGszCck7d2cDLmvGuhe0DbpIxZH+9/OZ5ZdeawKlDui4WRUxSf+lSlsQE8+TEIzbJ3
         8xsFVmxrKeYa+lbwnNiOTo4gZ8yiWLOOW36gZMzGb8EnbktkcTDNYBVMcHKywEAwipoa
         r5kIRUj1rKdVhef5HryRakfR+FDYCx6JyY3mkkubnbw4hJ3mRRoAvIqKiD4V67s4Mqja
         lGohWWnqGyK5+8a0tJOKfFBSpz6Gaxx24NxgE9WFOQ0UiMc9H6JKcVNONgia4+QpBukm
         MzMw==
X-Gm-Message-State: AOAM533MLHzSJCn859TAhQBjwh8OYbBP4+Wt0qq9hxY/PgRVmDZg61ja
        zSR33718Bt/eapGUKzegPdFNJ/vw5OhUN2Zc7Orxq+cRUIBcdmp5kIKbQM8TDJbs3wnlPqnlf15
        e2RGbwYJlv0KKbcMIZgcbrg+6erwp/mSsOcV7L97j4ZGpYk8qElP/saOKjgbKEibMu0qCcA==
X-Google-Smtp-Source: ABdhPJw8A8W9Rl5o6wUNy4MNv+LN2uMFoxhMW4TTEvvYVyRJpIvD/DaOjA0NsGClaErKXM+0sDka7Eent+s=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:8e82:b0:151:777b:6d7 with SMTP id
 bg2-20020a1709028e8200b00151777b06d7mr8812590plb.172.1646977868706; Thu, 10
 Mar 2022 21:51:08 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:49:12 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-2-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 001/105] KVM: selftests: Fix buggy check in test_v3_new_redist_regions()
From:   Sean Christopherson <seanjc@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>
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

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/aarch64/vgic_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/vgic_init.c b/tools/testing/selftests/kvm/aarch64/vgic_init.c
index 34379c98d2f4..0f046e3e953d 100644
--- a/tools/testing/selftests/kvm/aarch64/vgic_init.c
+++ b/tools/testing/selftests/kvm/aarch64/vgic_init.c
@@ -381,8 +381,8 @@ static void test_v3_new_redist_regions(void)
 	v = vm_gic_create_with_vcpus(KVM_DEV_TYPE_ARM_VGIC_V3, NR_VCPUS);
 	subtest_v3_redist_regions(&v);
 
-	_kvm_device_access(v.gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
-			  KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION, dummy, true);
+	ret = _kvm_device_access(v.gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
+				 KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION, dummy, true);
 	TEST_ASSERT(ret && errno == EFAULT,
 		    "register a third region allowing to cover the 4 vcpus");
 
-- 
2.35.1.723.g4982287a31-goog

