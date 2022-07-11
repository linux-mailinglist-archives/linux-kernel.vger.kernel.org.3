Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4B5570DB9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 00:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbiGKW6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 18:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbiGKW57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 18:57:59 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CED680514
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 15:57:59 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id k21-20020aa78215000000b005283ff3d0c3so1409373pfi.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 15:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=NI191zpZ15P9h09/ueg1sIeWgoPkCYp08nvGyArfGco=;
        b=GQ0ndjo72A8Ia1b/67wS9QnGvQn7ar/J3TPY1hn0q/aOslGNnJUPK0P8kpKCzLAaxp
         nzG0AVN5Zs4FwYakth25DRiFXcluhbfSTSDPUl4ZjTdGFYd6KyAHakZ7bw5XDsUbTXGL
         7gLuN6EBq1SwdNwcBj1PpYUNUsdP2OAfnY/b0hQyuFaZhEiFXLP1buT2+e/4bWJRh1ZI
         z/Kh9Q7Vb+Fep1k/rEqi1Xv+vmyuA+d+PjTCsYWgJvdI2QDpqi3zaZFx28PNXv5gt7yb
         O3/GFJzUuNFlkoCkYjfVXiWX882LsDgAPqDJr/Z9q7RN2SGpYkXPu/jW71cvknPuhRlw
         fPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=NI191zpZ15P9h09/ueg1sIeWgoPkCYp08nvGyArfGco=;
        b=giRPhD0JQO2j5N7/cRYT8DIDjJA5dSt4l2fKSwrzA+aidPTxUBqR8tDJ7nz/tjKFtK
         pv7Yvnxcne3JKvPKKgAjps//oVX0zlC+GCYl3bv1EM5f95M6HV8O9/bfYqy/Z/si6T96
         dmJ/BnfZtCeKTk5XTmLdRf+sxecLmr2Q1SOVh3vFiHicD7iNLXsbw/z1/GIfuLfMQUf8
         X9IO9IRKh9VTBPEe701X+SAAAxcXuAaI8Bz12dN0Hft5WYFI1BaYKKS3hB0JPB/o3acY
         MWUmvkwMTzk090e65RnpFOCDtbOxioTSg5tJ6fiwApiKt193I0/63xS+NIUMDWB/lUmx
         d+cg==
X-Gm-Message-State: AJIora8wPzqMUvvV4aTi4gs4ZCAtyQDxtTwH/ble75xgpUJCKJyVvIbX
        Lqm0l+qh/6rhtIg6frcF54+LoZDcwPc=
X-Google-Smtp-Source: AGRyM1uFU8Jn8jGDdf820D6EVQK+nemvu4HswGOWuMQxzURAFMH+88teTf4FufFegpoRz58bAS4cTTVMJ1o=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2481:b0:52a:d50e:e75e with SMTP id
 c1-20020a056a00248100b0052ad50ee75emr5880165pfv.43.1657580278580; Mon, 11 Jul
 2022 15:57:58 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Mon, 11 Jul 2022 22:57:52 +0000
In-Reply-To: <20220711225753.1073989-1-seanjc@google.com>
Message-Id: <20220711225753.1073989-3-seanjc@google.com>
Mime-Version: 1.0
References: <20220711225753.1073989-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.0.144.g8ac04bfd2-goog
Subject: [PATCH 2/3] KVM: selftests: Provide valid inputs for MONITOR/MWAIT regs
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yuan Yao <yuan.yao@linux.intel.com>
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

Provide valid inputs for RAX, RCX, and RDX when testing whether or not
KVM injects a #UD on MONITOR/MWAIT.  SVM has a virtualization hole and
checks for _all_ faults before checking for intercepts, e.g. MONITOR with
an unsupported RCX will #GP before KVM gets a chance to intercept and
emulate.

Fixes: 2325d4dd7321 ("KVM: selftests: Add MONITOR/MWAIT quirk test")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/x86_64/monitor_mwait_test.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/monitor_mwait_test.c b/tools/testing/selftests/kvm/x86_64/monitor_mwait_test.c
index f5c09cb528ae..6a4ebcdfa374 100644
--- a/tools/testing/selftests/kvm/x86_64/monitor_mwait_test.c
+++ b/tools/testing/selftests/kvm/x86_64/monitor_mwait_test.c
@@ -28,13 +28,17 @@ static void guest_monitor_wait(int testcase)
 
 	GUEST_SYNC(testcase);
 
-	vector = kvm_asm_safe("monitor");
+	/*
+	 * Arbitrarily MONITOR this function, SVM performs fault checks before
+	 * intercept checks, so the inputs for MONITOR and MWAIT must be valid.
+	 */
+	vector = kvm_asm_safe("monitor", "a"(guest_monitor_wait), "c"(0), "d"(0));
 	if (fault_wanted)
 		GUEST_ASSERT_2(vector == UD_VECTOR, testcase, vector);
 	else
 		GUEST_ASSERT_2(!vector, testcase, vector);
 
-	vector = kvm_asm_safe("mwait");
+	vector = kvm_asm_safe("mwait", "a"(guest_monitor_wait), "c"(0), "d"(0));
 	if (fault_wanted)
 		GUEST_ASSERT_2(vector == UD_VECTOR, testcase, vector);
 	else
-- 
2.37.0.144.g8ac04bfd2-goog

