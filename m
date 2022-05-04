Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B52951B2A1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 01:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379970AbiEDW7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 18:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379246AbiEDWxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 18:53:37 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2632B53E0E
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 15:49:53 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id gg5-20020a17090b0a0500b001d9852bd129so1315403pjb.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 15:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=tN5g3ph93jNOSEVUREKui1+khzaKjUQx/GJZWoxm6Ug=;
        b=rVjdi/ZOIIYdCNIqQS4d2g2lT+YOhy9gLOiBhSJbp2RNGFmKzWYAzVEG5huyNgEWoy
         7oncgiPi5dpBxeGkjXGLZHIuH802r3dWcL5FSIL7pI964jUJajmxUbtD0EAbxBLV9ENo
         eQQqLH3JnsIXCnkThsGexuq3X658ipPxoM97OHgGRIMsCAPuMWj5BQrTaNmX8j8con3+
         wM5MJaH7x7gco7zyvz+k6uG6wAv52W22q0Etf4OXdveD0eF71S1ljE+uS4LJOEhOUUYk
         IlXonds98uO81LAOozrVQeG4ljNozx8yErPYVnGETeEYPeDhOhVp6h2TdhmJdsSYFirC
         +wGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=tN5g3ph93jNOSEVUREKui1+khzaKjUQx/GJZWoxm6Ug=;
        b=LibFkxW8Wbz+7g/rXbJe6SrBny4mQL5v4tSGdjGuXVTuAsr11HkjVDagcVzchaiYqH
         j8ddL6sYbHs9mvQoK7Se2FmhrS/kw0KLLmVxmn4jVJ6ny/ob6GsPEYiK3aVBhbEVjTWn
         nG07P19CQdZRo2D2jAWfJnI2WyKeEig0MqUTqam6MEmtmUytk/2BCcJE7vTdTrrqlTwj
         UDQxL18Um+m/RjAxqbit5Adf8xE8fPsOsYUFkjjCSX5Psi1hd8dp0x/56nPL4mEwOEoO
         fuEz3eFUjyVizKqKsd/VLa8pYU/SnfjbDGWa0YvpHgwDVWsDbNFVg17MYgLK/n4+u3k7
         ZrRg==
X-Gm-Message-State: AOAM531eWf/29u7ZutV5FPSmYrlhpvzeHhou+3wuNxBWTNtcvKDYyd2P
        ELW023xJR0PnQeyhUxmcXqwHL9ysXCQ=
X-Google-Smtp-Source: ABdhPJzPRkUtgpAsl3Q2gmMdKlhCWtSvOFR4jZ9iXbf7HP9hEc0E+x+rnM6/CeEWMBDWVmhiuCFNheRQtQw=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:d512:b0:15e:93de:762a with SMTP id
 b18-20020a170902d51200b0015e93de762amr21785035plg.132.1651704592846; Wed, 04
 May 2022 15:49:52 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  4 May 2022 22:47:18 +0000
In-Reply-To: <20220504224914.1654036-1-seanjc@google.com>
Message-Id: <20220504224914.1654036-13-seanjc@google.com>
Mime-Version: 1.0
References: <20220504224914.1654036-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH 012/128] KVM: selftests: Remove vcpu_get_fd()
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop vcpu_get_fd(), it no longer has any users, and really should not
exist as the framework has failed if tests need to manually operate on
a vCPU fd.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/kvm_util_base.h | 1 -
 tools/testing/selftests/kvm/lib/kvm_util.c          | 9 ---------
 2 files changed, 10 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 6b7a5297053e..c2dfc4341b31 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -214,7 +214,6 @@ static inline int __vcpu_run(struct kvm_vm *vm, uint32_t vcpuid)
 	return __vcpu_ioctl(vm, vcpuid, KVM_RUN, NULL);
 }
 
-int vcpu_get_fd(struct kvm_vm *vm, uint32_t vcpuid);
 void vcpu_run_complete_io(struct kvm_vm *vm, uint32_t vcpuid);
 struct kvm_reg_list *vcpu_get_reg_list(struct kvm_vm *vm, uint32_t vcpuid);
 
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 45895c9ca35a..73123b9d9625 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1608,15 +1608,6 @@ int _vcpu_run(struct kvm_vm *vm, uint32_t vcpuid)
 	return rc;
 }
 
-int vcpu_get_fd(struct kvm_vm *vm, uint32_t vcpuid)
-{
-	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
-
-	TEST_ASSERT(vcpu != NULL, "vcpu not found, vcpuid: %u", vcpuid);
-
-	return vcpu->fd;
-}
-
 void vcpu_run_complete_io(struct kvm_vm *vm, uint32_t vcpuid)
 {
 	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
-- 
2.36.0.464.gb9c8b46e94-goog

