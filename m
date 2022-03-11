Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1339D4D5AD8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346608AbiCKFx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346555AbiCKFw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:52:26 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1105FED957
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:23 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id e1-20020a17090a280100b001bf44b6d74bso7304690pjd.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=+lJW77CrTm1B5aYz/GHbu6G+GH67Q3IwynG0m3AG3M8=;
        b=a37KJrIsD3S5wc8jpFWQwt3/bF4nolB/GhKJQV63KiaY66vsJop7Z0TjUEzYXV1x2b
         yuSc7qPkXs6f02gTE65qsI71X56ZQvq0TFaMkAHi+cuW914Qk9G75sW1lnMMNE/FTtI+
         dygSBDmqDKia+hy8JVYd2FPTJT5DmNtf6FE/OfZJ9jk1TCurym1Ba3r8A7o3tGz429Bq
         cJln5/fRzt2DGvPJFSuxOWdCvIl3EYsMqDSaYylYn8VBCHJAumsbO89PJR26Aly22XxE
         wNunZfiPcU39a1wCSsVFPsNS+1uIjWEG5jIameMoi1SuqzPm5OJdNgjV+Xp9XKQFJpk2
         7Ecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=+lJW77CrTm1B5aYz/GHbu6G+GH67Q3IwynG0m3AG3M8=;
        b=Zw922W8yRnotavYWIKd3K4T3eco1Gb5kXUFdNTsbnLKz10KkaT7bLLxRlI6szulpN1
         kyd0yx7on71im83D6AJv9YtLQNvuOftDvZ5j6oUE4CCGUzDbGcFtzT0deNR/z8FZJ9ia
         5XYKZEd4vtookArM8NRM7IgChqa8ckGjgTIq7ncIl9F2QjDOkVjEVd0x/ZCkVESWw1aE
         OWIb17io3IZdg4lZH/mTsZZ/GlXC/tmga1obV+oE3TPR5uR8Dd2xJRdd6yh2A/9+YR5o
         43OVWPXHnsgFzTxLnUhHCd0acQhL5yVyWX7uTW7AwSbjwYBaWaHTKEQn3j3FO1rcKkuc
         Z7SQ==
X-Gm-Message-State: AOAM531zKxx4ZiwERsXD5QKp5M7kvy5I+0pEaUdXu2kh3EJdvUh4I2Mp
        3s/5qrDqzmtkJHdhPTGWMbwOU1RsNnPDVxIo2oS6qMdhh44pZJ5EqjE02V4qlk2iKl1NHQOQRJJ
        kucbBdpTYMTDyEzBQ4aNH/MNaCg4odNa23cG6HQQY0MJATCLCKQlzKe11v9f+Nw7jZktQOw==
X-Google-Smtp-Source: ABdhPJy6q6yDkWs+K7zAlRT7vXU9elcC/F75OvWXhDJ1dGArInDVi6jwR/aWi6z3GK0japZQbYEohuadGyI=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:e791:b0:151:dbbd:aeae with SMTP id
 cp17-20020a170902e79100b00151dbbdaeaemr8842641plb.171.1646977882810; Thu, 10
 Mar 2022 21:51:22 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:49:21 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-11-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 010/105] KVM: selftests: Use vcpu_access_device_attr() in
 arm64 code
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
 tools/testing/selftests/kvm/aarch64/arch_timer.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/arch_timer.c b/tools/testing/selftests/kvm/aarch64/arch_timer.c
index 9ad38bd360a4..92b2a6611e89 100644
--- a/tools/testing/selftests/kvm/aarch64/arch_timer.c
+++ b/tools/testing/selftests/kvm/aarch64/arch_timer.c
@@ -349,12 +349,10 @@ static void test_run(struct kvm_vm *vm)
 static void test_init_timer_irq(struct kvm_vm *vm)
 {
 	/* Timer initid should be same for all the vCPUs, so query only vCPU-0 */
-	int vcpu0_fd = vcpu_get_fd(vm, 0);
-
-	kvm_device_access(vcpu0_fd, KVM_ARM_VCPU_TIMER_CTRL,
-			KVM_ARM_VCPU_TIMER_IRQ_PTIMER, &ptimer_irq, false);
-	kvm_device_access(vcpu0_fd, KVM_ARM_VCPU_TIMER_CTRL,
-			KVM_ARM_VCPU_TIMER_IRQ_VTIMER, &vtimer_irq, false);
+	vcpu_access_device_attr(vm, 0, KVM_ARM_VCPU_TIMER_CTRL,
+				KVM_ARM_VCPU_TIMER_IRQ_PTIMER, &ptimer_irq, false);
+	vcpu_access_device_attr(vm, 0, KVM_ARM_VCPU_TIMER_CTRL,
+				KVM_ARM_VCPU_TIMER_IRQ_VTIMER, &vtimer_irq, false);
 
 	sync_global_to_guest(vm, ptimer_irq);
 	sync_global_to_guest(vm, vtimer_irq);
-- 
2.35.1.723.g4982287a31-goog

