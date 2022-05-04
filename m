Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422345195F6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 05:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344453AbiEDD3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 23:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344329AbiEDD2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 23:28:44 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D557028983
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 20:25:07 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id t14-20020a1709028c8e00b0015cf7e541feso145454plo.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 20:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NIhRSvo0alW8fiKrqDE7euXam9U1frIcI+HOhIjC5O8=;
        b=V9xzQvDqrgHvUdtlyGb5v/iPWp9z+JbG22BBtUhVm7fyagF2xY6KyS3lsxNnwitDhr
         z3fPMqY+Hxgp3n3KJ6/NkeTVfPNk0jANvZ+RzwjqD1Yjm6mqbmeK6ea8btwbNh3x/FxU
         fzr7bD1CZLXo1/bHQsWZMCV7PxcCr04fSzHG/ShHKKjvhOVDOXe5TroOr0vLdlJS7pVU
         6VjnjfXssAZQztQooG4OSmqBsMVWCXFSylsqJtMfXAbQpkA4YAOX3RDwAuSAZShXxoyR
         4PFdqBp1rUgoZhGaRwS4c6dHRV6luP7fXCGVhPvYI0uqcFYk9tcxSpWJFEjnJIqjkYdL
         5kTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NIhRSvo0alW8fiKrqDE7euXam9U1frIcI+HOhIjC5O8=;
        b=cNDyP3X9VTLisQkR2N5u/FojzxntDOULWATN/FTHagTIPa5i12Y9sCiDvK3ZJH91yT
         Xloikjyu0XKWzdez5/cKObwigRbhCcooZAvsQNmKea887cY9HXS1lgt7WxfeTFedZhbb
         3KZeZTcAZ0wk/bTiog3U6Ebu2AkOZWBjn2Bb+PLzCKM3ccBIm5qAjFw+IfKVWmmDoUwJ
         ZmnOyMh50rZ4sEl3ANPX8UNoWPOPUjx7B7E1iZcNADHiHsakKzBYmwYMkedjdhKBItIk
         zObWjRX9NmdjC8sHFWKlHHEH+nNeXMzqElpwQnlqFf8IlOxd0OlZYQD0hlU04NKIwIMs
         mSIA==
X-Gm-Message-State: AOAM531v41t95SrKcDU99KfOdxxpT/j9+pi5NMVtMcAGE+6PGhMsZqXD
        VgSPxwFKYA8HtbP8hCAIFW0YmfqsWzE=
X-Google-Smtp-Source: ABdhPJx6qcRBndYRKLByoCKibt8KPKYbnYrz0DVxKSNCmNZ79ySqr5+Cv2YGUkJVJo++YbHWCUuOmNESmbU=
X-Received: from oupton3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:21eb])
 (user=oupton job=sendgmr) by 2002:a05:6a00:1995:b0:50e:610b:5e53 with SMTP id
 d21-20020a056a00199500b0050e610b5e53mr3997389pfl.37.1651634706895; Tue, 03
 May 2022 20:25:06 -0700 (PDT)
Date:   Wed,  4 May 2022 03:24:42 +0000
In-Reply-To: <20220504032446.4133305-1-oupton@google.com>
Message-Id: <20220504032446.4133305-9-oupton@google.com>
Mime-Version: 1.0
References: <20220504032446.4133305-1-oupton@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v6 08/12] selftests: KVM: Rename psci_cpu_on_test to psci_test
From:   Oliver Upton <oupton@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, maz@kernel.org, james.morse@arm.com,
        alexandru.elisei@arm.com, suzuki.poulose@arm.com,
        reijiw@google.com, ricarkol@google.com,
        Oliver Upton <oupton@google.com>,
        Andrew Jones <drjones@redhat.com>
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

There are other interactions with PSCI worth testing; rename the PSCI
test to make it more generic.

No functional change intended.

Signed-off-by: Oliver Upton <oupton@google.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
---
 tools/testing/selftests/kvm/.gitignore                          | 2 +-
 tools/testing/selftests/kvm/Makefile                            | 2 +-
 .../selftests/kvm/aarch64/{psci_cpu_on_test.c => psci_test.c}   | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename tools/testing/selftests/kvm/aarch64/{psci_cpu_on_test.c => psci_test.c} (100%)

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index 0b0e4402bba6..1bb575dfc42e 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -2,7 +2,7 @@
 /aarch64/arch_timer
 /aarch64/debug-exceptions
 /aarch64/get-reg-list
-/aarch64/psci_cpu_on_test
+/aarch64/psci_test
 /aarch64/vcpu_width_config
 /aarch64/vgic_init
 /aarch64/vgic_irq
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 681b173aa87c..c2cf4d318296 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -105,7 +105,7 @@ TEST_GEN_PROGS_x86_64 += system_counter_offset_test
 TEST_GEN_PROGS_aarch64 += aarch64/arch_timer
 TEST_GEN_PROGS_aarch64 += aarch64/debug-exceptions
 TEST_GEN_PROGS_aarch64 += aarch64/get-reg-list
-TEST_GEN_PROGS_aarch64 += aarch64/psci_cpu_on_test
+TEST_GEN_PROGS_aarch64 += aarch64/psci_test
 TEST_GEN_PROGS_aarch64 += aarch64/vcpu_width_config
 TEST_GEN_PROGS_aarch64 += aarch64/vgic_init
 TEST_GEN_PROGS_aarch64 += aarch64/vgic_irq
diff --git a/tools/testing/selftests/kvm/aarch64/psci_cpu_on_test.c b/tools/testing/selftests/kvm/aarch64/psci_test.c
similarity index 100%
rename from tools/testing/selftests/kvm/aarch64/psci_cpu_on_test.c
rename to tools/testing/selftests/kvm/aarch64/psci_test.c
-- 
2.36.0.464.gb9c8b46e94-goog

