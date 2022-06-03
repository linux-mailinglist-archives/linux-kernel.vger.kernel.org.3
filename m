Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A1753C253
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 04:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237726AbiFCAte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 20:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240164AbiFCAo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 20:44:56 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B60D344CC
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 17:44:54 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id c14-20020a17090a1d0e00b001e328238e7eso3403556pjd.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 17:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=hnhNz3Ofe6LEPVXH+Amyp+XINRrzOMpsHHCdOeUGVmg=;
        b=kTTX6shv/RmLvPSjjFRuP0FKoEB6fBja5N2hjLlvRl9c4lVLzxZHmFC3V1+jOAwAUH
         y3OHKXroMxXps81s19DFEZa4UCkblB0rWVyo5MEL2YE1IT7o7478ZsDpaAFlwxcywCa1
         L7sRfI+w+lhmd9Z3WDoOTfRX+48xPt3tX3bJ0iG4jSn25uyP79YJ6LxtIpKCrrXk5jTy
         Ut2Z/S47K9RezDu/W+b5981Ahi67oIouC/sCNjpUE4STwLt8yhyg8D0Xl564af1IZFgz
         lFFNA8bfrz7Vu7uWax1JLzE0uWb13xLgneXbWIJeBtAVEpqVlTD2oPOx19RNx6KF/Pty
         pNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=hnhNz3Ofe6LEPVXH+Amyp+XINRrzOMpsHHCdOeUGVmg=;
        b=OYfBlAJBCtxYKCXKhZoG+Rog3aYcTQpYjuhq8rwyqc3KdZn3+mti8FpsvQnC5pM9Ey
         KlWetjR7dmcRSov5YhYRLbmqwvBxJw1K2V65PZnN+OA+fJdTYnjQD7UjxCoUGkQJcnCE
         9bbKOW6vrOFKnNS1a87DtOusZDi+R3d2wtVKa/Ov7nVkQ/x48W3VoG+CZ4i8RKar0hqV
         NMWIRoOjqY8dN4eSaVwaiDyc15ktH8Ep9jrcpzmvk2keO6YFcJLYBz8uYzXkvmpehsTC
         LWXzp0DM/zcDXbXdwaSUlhgfYn6QkpSWQ/ZGRUUaoxmgoH58NunKsNQbGkABZY3+anj6
         stKQ==
X-Gm-Message-State: AOAM533F8uuRYFXVrtAiaihEkC3P8jinzK1/G5mWS6vHMBOGkwlIyeh4
        NUN5Gqa8ckKWyz77TXC8tdQhHhtW+GE=
X-Google-Smtp-Source: ABdhPJw8pu/Nf51rsweJnU5stWxffZj9igryX7G6VP1K81DCh4dmzRq0Q5Szzb/vxWxRDLUWN9nTXEEobUg=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a65:6250:0:b0:3c6:8a09:249 with SMTP id
 q16-20020a656250000000b003c68a090249mr6575731pgv.389.1654217094111; Thu, 02
 Jun 2022 17:44:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  3 Jun 2022 00:41:49 +0000
In-Reply-To: <20220603004331.1523888-1-seanjc@google.com>
Message-Id: <20220603004331.1523888-43-seanjc@google.com>
Mime-Version: 1.0
References: <20220603004331.1523888-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v2 042/144] KVM: selftests: Use vm_create_without_vcpus() in psci_test
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Oliver Upton <oupton@google.com>, linux-kernel@vger.kernel.org
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

Use vm_create_without_vcpus() instead of open coding a rough equivalent
in psci_test.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/aarch64/psci_test.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/psci_test.c b/tools/testing/selftests/kvm/aarch64/psci_test.c
index 1485d0b05b66..c9b82c0cc8d5 100644
--- a/tools/testing/selftests/kvm/aarch64/psci_test.c
+++ b/tools/testing/selftests/kvm/aarch64/psci_test.c
@@ -78,8 +78,7 @@ static struct kvm_vm *setup_vm(void *guest_code)
 	struct kvm_vcpu_init init;
 	struct kvm_vm *vm;
 
-	vm = vm_create(DEFAULT_GUEST_PHY_PAGES);
-	kvm_vm_elf_load(vm, program_invocation_name);
+	vm = vm_create_without_vcpus(VM_MODE_DEFAULT, DEFAULT_GUEST_PHY_PAGES);
 	ucall_init(vm, NULL);
 
 	vm_ioctl(vm, KVM_ARM_PREFERRED_TARGET, &init);
-- 
2.36.1.255.ge46751e96f-goog

