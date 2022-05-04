Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8FF51B248
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 00:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379151AbiEDWxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 18:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378578AbiEDWxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 18:53:11 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540585373E
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 15:49:34 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id l4-20020a170903244400b0015ebe12a192so1361541pls.16
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 15:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=igBOUh84Bmp3sUj2zghGZfHB0YgQf7bYIajTvYgZaa4=;
        b=JskJRQL0qX1iMZYu0hQWsft7snVsKa+MjoSkZRQlc5UCKQ0EaH6ydEWZzTUi5VaUTq
         AnTp/Zy10lS+G0uUoiulH0crwUJjZef4+2e8dznMJJ0RPcovM+vYFBESVJfW1P5d9ip5
         ddlgA8UY3guQ0t+P/KHATBo06vrZBi6IbhLNSMbGrn0tvc+hdM/hpa0OleJHP5mJ/Xg4
         IFI926zcLHTzun4XP0B3mrioNIdtu5i1l/xy/g1jpi00xY0uIvqJRMLRIPw9aR+Vqjl3
         Idt/gNRwu+mKpciTRBHrn3ckn/b2KsgXORgpkQjNHhaeC89c/elqsNs9W7Y+u+7/kMii
         OPMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=igBOUh84Bmp3sUj2zghGZfHB0YgQf7bYIajTvYgZaa4=;
        b=nZhx5LX5QRT6l6XZh0hbt19asYRZWYBoa7L+j+IXD7hTCXbX5Wcj3xyqGeKM75RwlD
         jf89C35gvcyAZXQsP+NGCAbtq7a8UzNRLirGDkr98lq1gMqVDytcx8UASKG8LaXMIdO6
         BK735C8NGRGEpE65rkTxnhsnrXk1hjuRQzs7TuzKzOivGXliSvzy6gLuFcjZ9mqmxTIs
         i1rtfda7j0/Xgcxd8Baqv/NyCp3UMPD9XUTSbc3gC942GXGwPapWHy4kl1cs8WXH8UaJ
         nAW+mV49NlSipDrRYrYw2whWok0Sk37LDPa2G5bra5zFxybERF6TBuhuDS+F7vHFBv3L
         ZMkg==
X-Gm-Message-State: AOAM532R1x+Gf652aCxRKV3Vr1JgesaJQ6naTXRXaaLVfJ0MwRxXxSJn
        m6nQ8byMZcejbSjnjF9NGhSZyLPd3XM=
X-Google-Smtp-Source: ABdhPJxo1AgZHB+N0CuD3I6BjfU5RiC79A+wzHVfo+tKBmoeZ/lTyBXj9wk/tQ6rmslGygYWzkn8C/KfDug=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1e04:b0:1dc:9252:efbc with SMTP id
 pg4-20020a17090b1e0400b001dc9252efbcmr2180226pjb.39.1651704573833; Wed, 04
 May 2022 15:49:33 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  4 May 2022 22:47:07 +0000
In-Reply-To: <20220504224914.1654036-1-seanjc@google.com>
Message-Id: <20220504224914.1654036-2-seanjc@google.com>
Mime-Version: 1.0
References: <20220504224914.1654036-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH 001/128] KVM: selftests: Fix buggy-but-benign check in test_v3_new_redist_regions()
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Oliver Upton <oupton@google.com>,
        Sean Christopherson <seanjc@google.com>
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

Update 'ret' with the return value of _kvm_device_access() prior to
asserting that ret is non-zero.  In the current code base, the flaw is
benign as 'ret' is guaranteed to be -EBUSY from the previous run_vcpu(),
which also means that errno==EBUSY prior to _kvm_device_access(), thus
the "errno == EFAULT" part of the assert means that a false negative is
impossible (unless the kernel is being truly mean and spuriously setting
errno=EFAULT while returning success).

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
2.36.0.464.gb9c8b46e94-goog

