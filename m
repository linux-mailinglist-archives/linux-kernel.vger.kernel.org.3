Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983DA54A176
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352402AbiFMVbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353130AbiFMV3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 17:29:18 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B9831D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 14:25:30 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id n8-20020a170902d2c800b001663868e2c2so3627269plc.21
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 14:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=q6y/cC7ApzMVwblo2wX2ATrZhvcsAJbJjDOeRfXShtw=;
        b=RN4Ahs2YdEGqhtKw34QQe3IO/xafb0O5TijAX1HUmRKqJ5SPvgQBNF9hDRuK4I/rLo
         IcP4HvdCBbNrtqzDZxXk4P7qWw1bf0z304OUkJ5gd4As+5RYdXhGQXAYpaUednwXsceK
         1qr0bayaCTCYN4HzkgxTbjkceHZjHWESZt/7Iu3pOw8Lkv+Bbcuhfr6ACeDCeUas6G8O
         9u6vj1t96vO0oufnlrHIFZAInvk/eCa+BqvV0btNPG22I7xBwCClYfYJzRoVbltrG2Eu
         iC8wXOPHRy11Ym07Ttf3LH4ulolEHI3AiwXY+QCE1QprbAj6S57opoZCh22HQ1I0sXtc
         nWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=q6y/cC7ApzMVwblo2wX2ATrZhvcsAJbJjDOeRfXShtw=;
        b=oXtFJu4uKIHwWGfPJ5Mzpf03GbYr0HQNgg/d1EPddbPfm9CCa3dRNXEQaRhAN/2gwe
         7+4CxVZQvayiFUpeYjZCkI77ALsErzTUtFOXVhyGK0B2rx7bB3KinspVFfHYtdlR24ry
         0f5ru5+f7ofbUfB/iSA2O4jbUkYKVzom384qLZanNrzHNhNe/8dkDOsrok/hVpo2nwg0
         sbbkYqVkIJ97ReMtY4e/CAlaze180ZvPT1mYDcQy//HchnUIoUSSyMPU81HaJyQWaj/4
         vbRCAQxMRxjnQVfJ/z/rnzRURWBQQj6NYPBIOs4ghF/qBjGOENo0l20heAKIbLqlWy+5
         gTfQ==
X-Gm-Message-State: AJIora+stFRp8fIatsueV22/Wss6JWxgdjxykAOOjkLGeA/DCQQDx0sv
        Rk2/cuFhHxU611VafZFxQWDakci3WhI2
X-Google-Smtp-Source: AGRyM1vUtxSBaOadpUzI1R0wd/z2CXO0o1CfpyEq9BbjSFAphaDKd24NnJRz1w7VV3Qj/dH1ku1jH+IeLDz+
X-Received: from sweer.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:e45])
 (user=bgardon job=sendgmr) by 2002:a17:90b:2247:b0:1e8:9f24:269a with SMTP id
 hk7-20020a17090b224700b001e89f24269amr774220pjb.14.1655155529508; Mon, 13 Jun
 2022 14:25:29 -0700 (PDT)
Date:   Mon, 13 Jun 2022 21:25:15 +0000
In-Reply-To: <20220613212523.3436117-1-bgardon@google.com>
Message-Id: <20220613212523.3436117-3-bgardon@google.com>
Mime-Version: 1.0
References: <20220613212523.3436117-1-bgardon@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH v9 02/10] KVM: selftests: Read binary stats header in lib
From:   Ben Gardon <bgardon@google.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Dunn <daviddunn@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Junaid Shahid <junaids@google.com>,
        Ben Gardon <bgardon@google.com>
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

Move the code to read the binary stats header to the KVM selftests
library. It will be re-used by other tests to check KVM behavior.

No functional change intended.

Reviewed-by: David Matlack <dmatlack@google.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Ben Gardon <bgardon@google.com>
---
 tools/testing/selftests/kvm/include/kvm_util_base.h | 8 ++++++++
 tools/testing/selftests/kvm/kvm_binary_stats_test.c | 4 ++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index cdaea2383543..3d3dd144f427 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -303,6 +303,14 @@ static inline int vm_get_stats_fd(struct kvm_vm *vm)
 	return fd;
 }
 
+static inline void read_stats_header(int stats_fd, struct kvm_stats_header *header)
+{
+	ssize_t ret;
+
+	ret = read(stats_fd, header, sizeof(*header));
+	TEST_ASSERT(ret == sizeof(*header), "Read stats header");
+}
+
 void vm_create_irqchip(struct kvm_vm *vm);
 
 void vm_set_user_memory_region(struct kvm_vm *vm, uint32_t slot, uint32_t flags,
diff --git a/tools/testing/selftests/kvm/kvm_binary_stats_test.c b/tools/testing/selftests/kvm/kvm_binary_stats_test.c
index ae48d4153f85..64db17faacd2 100644
--- a/tools/testing/selftests/kvm/kvm_binary_stats_test.c
+++ b/tools/testing/selftests/kvm/kvm_binary_stats_test.c
@@ -33,8 +33,8 @@ static void stats_test(int stats_fd)
 	struct kvm_stats_desc *pdesc;
 
 	/* Read kvm stats header */
-	ret = read(stats_fd, &header, sizeof(header));
-	TEST_ASSERT(ret == sizeof(header), "Read stats header");
+	read_stats_header(stats_fd, &header);
+
 	size_desc = sizeof(*stats_desc) + header.name_size;
 
 	/* Read kvm stats id string */
-- 
2.36.1.476.g0c4daa206d-goog

