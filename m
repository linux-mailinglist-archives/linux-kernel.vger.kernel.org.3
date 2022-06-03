Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285ED53C222
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 04:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240399AbiFCAqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 20:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240038AbiFCAoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 20:44:22 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D533465F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 17:44:16 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d11-20020a170902cecb00b00163fe890197so3487183plg.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 17:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=v2jaQRJGWpcmy76dpAvw8l7NidvPTlJiWvZRZAZ3L9w=;
        b=Pb5aoG1ap2O/sO+RGYrxN0XX/Ei9F4k6tM3mzx5d5jWrfhDiEQCqy0GBKphx4Sloh3
         HYXQTS8/ucaMWlPkkwaHXp1Q0LYTn7Iu+4i/XOXnF7yjbML1gYrKlUl83Q6iA/Nk1fgw
         nTt9MxPGziMKrB9fe2eI6Iq/+r/h2739YcEzeBpYFZ4C23ClSKFKE12kkY3v2Iv1b3QT
         sSpbF14FSMevMIpveJa/S9hn2TrhnCki3s3eU8pPeW2Uj4l7LUozecRR0sZc/fagwlLh
         +ZUsgftgNPaW54nAvyzpJ+7Dc0NfdxZsx+L00bgm/zyiAjO1DXq4k6qS/E+DjIw8qG1x
         zsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=v2jaQRJGWpcmy76dpAvw8l7NidvPTlJiWvZRZAZ3L9w=;
        b=ERS6Dzx6TlgLL9j3tVFsABGdX2p7fqp2Ni5o4+gtlxbdyevEfqBwOo3X5+gonK1PGS
         iueVn5GGydP2Ke3rqzEUqxoUJC82jf9Nb2g8FIYYMsSGLZBOd+1fNK4GplH3yky3p1qw
         T2mn16I9o16Nqk78x6MXqdfB7EVxijTAxYw2gmXMmO83JkzkIWsBO1QRx4V9TePsS2de
         GgK57DwhlqOqHroUc8OUMGRG6Xu6KepPLTXrRopCKEfRtmi1viHJIT6SVp/6q+ItQs6O
         CI80BwWryA/AJkZsnsgGsH4tGyeu25R6Lvz4Pw/PKo+e0edszOUruPm87wkflEamUi4Y
         9YJw==
X-Gm-Message-State: AOAM533JvOk0CFLP/8vgSfDFfpAkJIQy0hLXn34/Omj7WoPd9ucfpNDW
        WSoID3tWiEdR0qSeaPrZSaiKlRXdl4c=
X-Google-Smtp-Source: ABdhPJxRuhX9NJxoaddaDhffSdeHQF7rzzWs2tqLQsPe1agbkSns4K4u1Md2xcK5DPMpvIordbVQUQ/myTc=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:4b09:b0:1e0:4905:dcef with SMTP id
 lx9-20020a17090b4b0900b001e04905dcefmr8073825pjb.21.1654217055510; Thu, 02
 Jun 2022 17:44:15 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  3 Jun 2022 00:41:29 +0000
In-Reply-To: <20220603004331.1523888-1-seanjc@google.com>
Message-Id: <20220603004331.1523888-23-seanjc@google.com>
Mime-Version: 1.0
References: <20220603004331.1523888-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v2 022/144] KVM: selftests: Use KVM_IOCTL_ERROR() for one-off
 arm64 ioctls
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the KVM_IOCTL_ERROR() macro to generate error messages for a handful
of one-off arm64 ioctls.  The calls in question are made without an
associated struct kvm_vm/kvm_vcpu as they are used to configure those
structs, i.e. can't be easily converted to e.g. vcpu_ioctl().

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/lib/aarch64/processor.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/aarch64/processor.c b/tools/testing/selftests/kvm/lib/aarch64/processor.c
index 388bd7d87c02..2e73853f485e 100644
--- a/tools/testing/selftests/kvm/lib/aarch64/processor.c
+++ b/tools/testing/selftests/kvm/lib/aarch64/processor.c
@@ -472,15 +472,15 @@ void aarch64_get_supported_page_sizes(uint32_t ipa,
 	TEST_ASSERT(vm_fd >= 0, KVM_IOCTL_ERROR(KVM_CREATE_VM, vm_fd));
 
 	vcpu_fd = ioctl(vm_fd, KVM_CREATE_VCPU, 0);
-	TEST_ASSERT(vcpu_fd >= 0, "Can't create vcpu");
+	TEST_ASSERT(vcpu_fd >= 0, KVM_IOCTL_ERROR(KVM_CREATE_VCPU, vcpu_fd));
 
 	err = ioctl(vm_fd, KVM_ARM_PREFERRED_TARGET, &preferred_init);
-	TEST_ASSERT(err == 0, "Can't get target");
+	TEST_ASSERT(err == 0, KVM_IOCTL_ERROR(KVM_ARM_PREFERRED_TARGET, err));
 	err = ioctl(vcpu_fd, KVM_ARM_VCPU_INIT, &preferred_init);
-	TEST_ASSERT(err == 0, "Can't get init vcpu");
+	TEST_ASSERT(err == 0, KVM_IOCTL_ERROR(KVM_ARM_VCPU_INIT, err));
 
 	err = ioctl(vcpu_fd, KVM_GET_ONE_REG, &reg);
-	TEST_ASSERT(err == 0, "Can't get MMFR0");
+	TEST_ASSERT(err == 0, KVM_IOCTL_ERROR(KVM_GET_ONE_REG, vcpu_fd));
 
 	*ps4k = ((val >> 28) & 0xf) != 0xf;
 	*ps64k = ((val >> 24) & 0xf) == 0;
-- 
2.36.1.255.ge46751e96f-goog

