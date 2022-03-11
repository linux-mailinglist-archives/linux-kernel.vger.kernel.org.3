Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4B54D5AD9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240149AbiCKFxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346559AbiCKFw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:52:27 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2047CF11A6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:25 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id e14-20020a17090a684e00b001bf09ac2385so4717285pjm.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=54mSR6Tud/AFQVI6bwk1W/vBoapcvRIqx1EJHluJf+w=;
        b=YNCRWr+YcJSSRC9dm+eOFAcuuNdURungE5bimPeuPOaz928FLAQBzQS+otqX1TpC7U
         hiiuaG4coq1QgCk2fP3r5v0QefVQZyXr6UkgSuMfEyn2Q6V3rqLIQEaOOCTCGxjpfman
         Ab8m1+C1YJVqKuyPVZjmnMFT0pjVlIs0m5EHERUgZd5kzFKvjmBdwTC2BMpWlSp7YTyd
         cQJTzFQlwZjcIo4bWZP7kAEgmIiHa6zwefR3s9uPRIK/A1ZIcdeIohHR7SqpJPZJhdOl
         CAnmmW4YFwLZobg3HWz3hNmQL6UeXmBCD+Mn8LTe2tb+0Ei1Ra9DWQZXuXNdACklTg6j
         /LxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=54mSR6Tud/AFQVI6bwk1W/vBoapcvRIqx1EJHluJf+w=;
        b=qUpEwPiAeZAzUnkEZzajRDxco7fLWy1Qf2DeFc3un7LrtQ0wutoqNEYCTN4DXNMPqG
         0HSfyHdDZ1T79fqwV6Cr+wjsWjbiLdsxSharubzWdcX8FPHcf4AVO1Qs9hHOVx2W/Ne1
         1XateYQOqrGxJFcg1Lz8jV7qs6RTR6POSDLnLJcD/kLh8tG76mQW8+fMcpP00DPJqZBM
         G/dS4Y0wltzfjJvH0+aTnAK2JrpOdNvbzR+lh12gNyaf3+H0L2163Id7cRFCxvf9AQea
         kTRea+VDOX/Rrqui9gVO5+p1jwgMYpdhP0dZOtCmSv8aPqGwZSUuDZZSPIWM1s3OdPW7
         suzw==
X-Gm-Message-State: AOAM532Tm2kI4aO48uZL5aX5/UNr2cOXVt7QsKM0K/ZFpxrBM24ghqYf
        RRqg+zKjsOPc8g8rGRooHS6QC8Dm0V0iDyoqS3uTkGSkFMPBM8uwFca0vponS0kclrP0Wvq0XBx
        4iq8u10DsItN+2tQJ6+XHupZi9DjOsgSjj9wTtVQKA3x0xOl0/8n7C0usrC6oXATbcRgzUQ==
X-Google-Smtp-Source: ABdhPJwHBeTgJSAkaJdl22sS1uirZxKLjbgjmnLV6y7SstmdRAQd+lWiateXxCghyyGAl5rxb9a5RGxwUVA=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1e10:b0:1bf:6c78:54a9 with SMTP id
 pg16-20020a17090b1e1000b001bf6c7854a9mr460344pjb.1.1646977884184; Thu, 10 Mar
 2022 21:51:24 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:49:22 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-12-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 011/105] KVM: selftests: Remove vcpu_get_fd()
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
 tools/testing/selftests/kvm/include/kvm_util_base.h | 1 -
 tools/testing/selftests/kvm/lib/kvm_util.c          | 9 ---------
 2 files changed, 10 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index f4bf77eed00a..be8882dbe38a 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -208,7 +208,6 @@ static inline int __vcpu_run(struct kvm_vm *vm, uint32_t vcpuid)
 	return __vcpu_ioctl(vm, vcpuid, KVM_RUN, NULL);
 }
 
-int vcpu_get_fd(struct kvm_vm *vm, uint32_t vcpuid);
 void vcpu_run_complete_io(struct kvm_vm *vm, uint32_t vcpuid);
 struct kvm_reg_list *vcpu_get_reg_list(struct kvm_vm *vm, uint32_t vcpuid);
 
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 066314ea880c..52fefa51071a 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1570,15 +1570,6 @@ int _vcpu_run(struct kvm_vm *vm, uint32_t vcpuid)
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
2.35.1.723.g4982287a31-goog

