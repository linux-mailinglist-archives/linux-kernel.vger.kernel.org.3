Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA6E53C2FE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 04:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239928AbiFCAny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 20:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239918AbiFCAnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 20:43:43 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F014933887
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 17:43:42 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id x16-20020a63f710000000b003f6082673afso3039787pgh.15
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 17:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=5n2c/bNAwgFAvfU6CoWalYhox7GUhMiGZPzXVhSXkXM=;
        b=G0uLfFZcUuPsl19sVR93iZbJ11T7hqXURRRV0pDNRgUt3yKRR5Vxbhb5xdN+8lEuWm
         QwoG0JIiL+VDEvFd3i0/NNCXztPiEGErys0/u4agJD16+6SjqaKUEa4oY9SBBfyTqmDG
         7WicQKsA1cUpx7HIToVurviIrbDDD9G2LddpaVSrqvLV6xLnzqOdA7sm5uHAkiYmxrw0
         lg38DbRmY45bjq4wBzjTW73fwsBjTtxdKf4euBleSDcMrB51NtzrZaFkqNkEETKDrOEp
         UlpAQZJ5R43D31e/TodebkWpq3T4UbvAN2ZPhUmgofaZ7NQd9DwtFpf8k+ZxYhVL8htC
         JRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=5n2c/bNAwgFAvfU6CoWalYhox7GUhMiGZPzXVhSXkXM=;
        b=CSdQZGVYHO5gn3VNFTHEw/yGoFBHpm2oRrrkx3kENsWmQQv5c2bi4eZEMHi5BCFrXr
         1Ym4jehzoDrscUGd5F85x3Vrt0hHBHJq9hdAVTBV5/QOdv/VhpZ+b1rCm8MPX8Ys6Jkf
         qz7M4vZ2oSO7d8PJ8xPwQBKlv8SkqDpioLQ/gQxu4ntVrGEfNY7MaWEr3gGFk0bSqClR
         M3caK534Lo17wC8dGYCYAfoyV0/KuZ7vb7Rc0W9m5/orK9xa7R5Wj+/NoL9a5mWiiuPw
         cmZXuJM+wtWxl3lLTiMyh/OmqgU/8+7defWYFjPqiOBlcLZ9NOX0kSgNTa8COhflr/X6
         WWlg==
X-Gm-Message-State: AOAM532tXC7peaLfeLP1778qlNaihpZZaq3gQE0Z3WJVyRsNDeGxs4l7
        FxNNYSl9WNkjDWD8H27u6SyWlWqU3Rk=
X-Google-Smtp-Source: ABdhPJwW6+Sh+L/OQ/rp4QMwq/Rdk4aJjk37EogYWOqfZ9WjG7G4Dj+apcjHf/0kRCNGSg1f6yYEXNB7x2E=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:903:20f:b0:158:d86a:f473 with SMTP id
 r15-20020a170903020f00b00158d86af473mr7727577plh.92.1654217022350; Thu, 02
 Jun 2022 17:43:42 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  3 Jun 2022 00:41:10 +0000
In-Reply-To: <20220603004331.1523888-1-seanjc@google.com>
Message-Id: <20220603004331.1523888-4-seanjc@google.com>
Mime-Version: 1.0
References: <20220603004331.1523888-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v2 003/144] KVM: selftests: Fix typo in vgic_init test
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

When iterating over vCPUs, invoke access_v3_redist_reg() on the "current"
vCPU instead of vCPU0, which is presumably what was intended by iterating
over all vCPUs.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/aarch64/vgic_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/aarch64/vgic_init.c b/tools/testing/selftests/kvm/aarch64/vgic_init.c
index 0f046e3e953d..5e3c26564192 100644
--- a/tools/testing/selftests/kvm/aarch64/vgic_init.c
+++ b/tools/testing/selftests/kvm/aarch64/vgic_init.c
@@ -426,7 +426,7 @@ static void test_v3_typer_accesses(void)
 			  KVM_DEV_ARM_VGIC_CTRL_INIT, NULL, true);
 
 	for (i = 0; i < NR_VCPUS ; i++) {
-		ret = access_v3_redist_reg(v.gic_fd, 0, GICR_TYPER, &val, false);
+		ret = access_v3_redist_reg(v.gic_fd, i, GICR_TYPER, &val, false);
 		TEST_ASSERT(!ret && !val, "read GICR_TYPER before rdist region setting");
 	}
 
-- 
2.36.1.255.ge46751e96f-goog

