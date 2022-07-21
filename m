Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42BA157C3FA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 07:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbiGUF6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 01:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbiGUF6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 01:58:02 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCCE79EEC
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 22:57:56 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31e62bc916aso6542447b3.19
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 22:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=u41gNE0FUbf7I3uSk1ZkD04WPUp+bNk6nI13lr3U2+M=;
        b=i1tLJHy55BRGUf2MhpeshQfHaz/P1U4sh5WTYlffK6cPwsShsTLAksunpx9WSWUvs5
         0fBONE5OQ8WLDH14mRl37wS68j0C0oAC6uZ1XsgBylepMqzx7WahUDqDnXxVi+WKAQgk
         AGgIzVBp+61lUYk8JBGfQfLraTDIS5jAl16lRQ4X4qh6yJdvw659R1ORQW0392UXcd0h
         6imC0n6wD6C8G8hOnTkHRmVOn7smO1yJg/wy15kFY1cs8By/B9dxEChbyAn0iA8Wy+pe
         gktmUvnnmFtVre61mdH5Uu3H353FeoBmcg7MXZPAV9ovEHqwu/oerxbpmHYhpA/EMRPc
         Xyuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=u41gNE0FUbf7I3uSk1ZkD04WPUp+bNk6nI13lr3U2+M=;
        b=NIqhBNncyvWI3dDvbv2ViSn0PEkX9LXKoqumLJWpQdOWH/qOGNI0NZ2TDK3j5Nkzga
         tx2sDHDtTtsjWbg0eFCL9tWpKll8J3z7+gnqeZ8hdIBPAHE61P13XhIlLr0qBID867F3
         GPsuMIv0HqDb7uQuHy7SV9lpWxMkDNym3UOXh0pxU7R+s3qb13cfURUwza16RVLkcZ1z
         x+xF+vwlkkLDeA9IeuAaze7fEQcXwHE5+eYLG4s/wlZPNRcJH17UcqHHa9Qt74aGFDP4
         /g4JBwEOGEaEwBWUc9L/jWiv6YlxUWdU/qPgVk+v9FeAXOlxykBBH5QZCx8r8Evb1ZDO
         Lr3Q==
X-Gm-Message-State: AJIora9YBA9KifFdLqsaaHHSrGnszZhark5GU/tOAi9t62l2oBRu1FBN
        N5Fe+CXgJNtf/9ewV4ul/785apPy0I7gD0Xa/g==
X-Google-Smtp-Source: AGRyM1uvMhMsMnmREMTDtB8EyA11iiDGNnM5EU/vVjV/cfBEZrOG6zJ3oBHMRQm5wTLQpoQkhzUqzuOm5KQq0n22Og==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:5a87:b61e:76b5:d1e0])
 (user=kaleshsingh job=sendgmr) by 2002:a25:a1a9:0:b0:66f:8387:d3e1 with SMTP
 id a38-20020a25a1a9000000b0066f8387d3e1mr37333703ybi.547.1658383075762; Wed,
 20 Jul 2022 22:57:55 -0700 (PDT)
Date:   Wed, 20 Jul 2022 22:57:20 -0700
In-Reply-To: <20220721055728.718573-1-kaleshsingh@google.com>
Message-Id: <20220721055728.718573-10-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220721055728.718573-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v5 09/17] KVM: arm64: Allocate shared pKVM hyp stacktrace buffers
From:   Kalesh Singh <kaleshsingh@google.com>
To:     maz@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        madvenka@linux.microsoft.com, tabba@google.com
Cc:     will@kernel.org, qperret@google.com, kaleshsingh@google.com,
        james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        andreyknvl@gmail.com, vincenzo.frascino@arm.com,
        mhiramat@kernel.org, ast@kernel.org, drjones@redhat.com,
        wangkefeng.wang@huawei.com, elver@google.com, keirf@google.com,
        yuzenghui@huawei.com, ardb@kernel.org, oupton@google.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, android-mm@google.com,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In protected nVHE mode the host cannot directly access
hypervisor memory, so we will dump the hypervisor stacktrace
to a shared buffer with the host.

The minimum size for the buffer required, assuming the min frame
size of [x29, x30] (2 * sizeof(long)), is half the combined size of
the hypervisor and overflow stacks plus an additional entry to
delimit the end of the stacktrace.

The stacktrace buffers are used later in the seried to dump the
nVHE hypervisor stacktrace when using protected-mode.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Changes in v5:
  - Fix typo in commit text, per Marc

 arch/arm64/include/asm/memory.h      | 8 ++++++++
 arch/arm64/kvm/hyp/nvhe/stacktrace.c | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 0af70d9abede..cab80a9a4086 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -113,6 +113,14 @@
 
 #define OVERFLOW_STACK_SIZE	SZ_4K
 
+/*
+ * With the minimum frame size of [x29, x30], exactly half the combined
+ * sizes of the hyp and overflow stacks is the maximum size needed to
+ * save the unwinded stacktrace; plus an additional entry to delimit the
+ * end.
+ */
+#define NVHE_STACKTRACE_SIZE	((OVERFLOW_STACK_SIZE + PAGE_SIZE) / 2 + sizeof(long))
+
 /*
  * Alignment of kernel segments (e.g. .text, .data).
  *
diff --git a/arch/arm64/kvm/hyp/nvhe/stacktrace.c b/arch/arm64/kvm/hyp/nvhe/stacktrace.c
index a3d5b34e1249..69e65b457f1c 100644
--- a/arch/arm64/kvm/hyp/nvhe/stacktrace.c
+++ b/arch/arm64/kvm/hyp/nvhe/stacktrace.c
@@ -9,3 +9,7 @@
 
 DEFINE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)], overflow_stack)
 	__aligned(16);
+
+#ifdef CONFIG_PROTECTED_NVHE_STACKTRACE
+DEFINE_PER_CPU(unsigned long [NVHE_STACKTRACE_SIZE/sizeof(long)], pkvm_stacktrace);
+#endif /* CONFIG_PROTECTED_NVHE_STACKTRACE */
-- 
2.37.0.170.g444d1eabd0-goog

