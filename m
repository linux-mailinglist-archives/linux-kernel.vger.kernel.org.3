Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90181580E11
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 09:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238558AbiGZHlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 03:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238548AbiGZHiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 03:38:46 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409E66447
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:38:35 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31e89d6bea7so101354437b3.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=4z4Kz5jKP4bI+UOP9DxU3eg2/YP+oU3Smm0rFqPcsng=;
        b=Z1P1ClfItoh79aQ1b/7uN6+YG8sXdaRGbHmm2Km3lpRCBNERxYfC45wuUnV22xDrKr
         C7P7sOnzNuqntBLF3F+6jM28iGWBmjuZh/onAiogWA6nkl+pQMh/hkru3m8yOoDZtCiz
         YUeV/q7yT+eI6gJO0z3Jk1qzCMVZ8PnFyCNSgqN/dWdmju6ronRybvKXvcqMM82Etntz
         YLHXZQ84XUWvCivtFflxyQq6fJhEpglvw3cFqVdjfvpGM1UsagOmmxxMaKcMmpN6dr59
         S8axA/CrLXVHIAUBmzb2I9dpWg+mkbpuBU7UpOLEQXfqv2pHnmn4tY3D3DSea9NPICrl
         o61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=4z4Kz5jKP4bI+UOP9DxU3eg2/YP+oU3Smm0rFqPcsng=;
        b=P6KaGw1ZWc6LlwHX6Op9KToj/3B+EWm+IXvxlHmkjO6ZnP1boatCzxXMYeDaIQL92R
         RAYAbLrvrWkex7GiMSOI8u3d92iBNBB1p9QwEQO4wJTuInvNvsgL4n8hMPN1hweBE5HZ
         JDw6RcWCJHKPtRolm6Ju4ev5Fer7XJqhRwtraF3E4aR0tYKi0QdhHqQ1IBpUV/g3mk5o
         F80JhvRgC6HC4yR8WHgSKU8EAiPClj04cmsr4k5+bPiZm8KBrbRedWdNokur6a9JxD1X
         rVok/eiFvEADmaRagrF6vEyjiPWtfEW8WunoKKeiBsh1mTU9iJzD6tzQc6Wkx4NOz4a2
         RPTw==
X-Gm-Message-State: AJIora/MKPQSTrzETNV9tE6Ecoy+cwg3r0oaROFGfgol/amvwlH3RePh
        FKiKPZp/vJAwZHijNTI7QwE8yoxn3YBChmdziQ==
X-Google-Smtp-Source: AGRyM1s+nZYFqneaUWZhKYAd3zQF7L0Cwai3ur8Rv5PlGmwq+xCSduNXnxJSHkCKOQUTBjw9Sv3BBmCbw3HEDJGUpA==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:4f77:3b64:736a:394e])
 (user=kaleshsingh job=sendgmr) by 2002:a81:1e49:0:b0:31e:5b13:a187 with SMTP
 id e70-20020a811e49000000b0031e5b13a187mr13741284ywe.129.1658821114535; Tue,
 26 Jul 2022 00:38:34 -0700 (PDT)
Date:   Tue, 26 Jul 2022 00:37:49 -0700
In-Reply-To: <20220726073750.3219117-1-kaleshsingh@google.com>
Message-Id: <20220726073750.3219117-17-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220726073750.3219117-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v6 16/17] KVM: arm64: Implement protected nVHE hyp stack unwinder
From:   Kalesh Singh <kaleshsingh@google.com>
To:     maz@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        madvenka@linux.microsoft.com, tabba@google.com,
        oliver.upton@linux.dev
Cc:     will@kernel.org, qperret@google.com, kaleshsingh@google.com,
        james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        andreyknvl@gmail.com, vincenzo.frascino@arm.com,
        mhiramat@kernel.org, ast@kernel.org, wangkefeng.wang@huawei.com,
        elver@google.com, keirf@google.com, yuzenghui@huawei.com,
        ardb@kernel.org, oupton@google.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, android-mm@google.com,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implements the common framework necessary for unwind() to work in
the protected nVHE context:
   - on_accessible_stack()
   - on_overflow_stack()
   - unwind_next()

Protected nVHE unwind() is used to unwind and save the hyp stack
addresses to the shared stacktrace buffer. The host reads the
entries in this buffer, symbolizes and dumps the stacktrace (later
patch in the series).

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Fuad Tabba <tabba@google.com>
---

Changes in v6:
  - Add Fuad=E2=80=99s Reviewed-by and Tested-by tags

 arch/arm64/include/asm/stacktrace/nvhe.h | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/stacktrace/nvhe.h b/arch/arm64/include/=
asm/stacktrace/nvhe.h
index 2ce59c058806..600dbc2220b6 100644
--- a/arch/arm64/include/asm/stacktrace/nvhe.h
+++ b/arch/arm64/include/asm/stacktrace/nvhe.h
@@ -64,18 +64,27 @@ static inline bool on_accessible_stack(const struct tas=
k_struct *tsk,
 static inline bool on_overflow_stack(unsigned long sp, unsigned long size,
 				     struct stack_info *info)
 {
-	return false;
+	unsigned long low =3D (unsigned long)this_cpu_ptr(overflow_stack);
+	unsigned long high =3D low + OVERFLOW_STACK_SIZE;
+
+	return on_stack(sp, size, low, high, STACK_TYPE_OVERFLOW, info);
 }
=20
 static inline bool on_hyp_stack(unsigned long sp, unsigned long size,
 				struct stack_info *info)
 {
-	return false;
+	struct kvm_nvhe_init_params *params =3D this_cpu_ptr(&kvm_init_params);
+	unsigned long high =3D params->stack_hyp_va;
+	unsigned long low =3D high - PAGE_SIZE;
+
+	return on_stack(sp, size, low, high, STACK_TYPE_HYP, info);
 }
=20
 static inline int notrace unwind_next(struct unwind_state *state)
 {
-	return 0;
+	struct stack_info info;
+
+	return unwind_next_common(state, &info, NULL);
 }
 NOKPROBE_SYMBOL(unwind_next);
 #endif	/* CONFIG_PROTECTED_NVHE_STACKTRACE */
--=20
2.37.1.359.gd136c6c3e2-goog

