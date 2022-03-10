Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F184D4F93
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 17:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244281AbiCJQrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 11:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244132AbiCJQr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 11:47:29 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2901986FA
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 08:46:17 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id x6-20020a1709029a4600b0014efe26b04fso2952739plv.21
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 08:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6/GjUUfRe2TednvAxOrIHMT0ZcA0ouG3TTihxHdaCW0=;
        b=Ci9RymXtUyaxSqLze1CsiykAC+coEyY7bha7vdnz2IIfbsq+NipcxCu5E/6SKCYP8P
         AZWfyT5rXjCdQA1Gc4bceeNSCG3fmAHG5yIaY6IZRZjo4kFmN0YpfdldarRV/GfHnuBu
         S6vSmARKH46PTiE2z01E5t/V2c3KvFKPvZOphqNi9lLlORngKiLyJmhydv2dYqkYeqtA
         1c/QNL7R77dPvsGRnw1KCbfnc/kg1T0Dxlq2eZnnBoYWzQ1Jma9qeKXqm9VBmtJC6bEA
         JuLGJJoLaYlYhGieelYs4IiVe8BaquDMzGy0TH0xQKbMAD3FEy/HRFuNfprA6v5y0zjf
         MNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6/GjUUfRe2TednvAxOrIHMT0ZcA0ouG3TTihxHdaCW0=;
        b=m5nuvUzvqDVkJFDsiheSfgnpEaCC7isMwXxcGcMrHw6eHfw0zdMSFvV0il4E7BCjNo
         MIVHUDIOH+mFRpSkYblbYFX33vsMfl1ShC6nBd7fULpLr0CoJpv29qYNak+QPK65pWEo
         RU+kZ0cfw6xeOwftf27rFJS5p/RBtPlEVaPCa4Y6eK0Ci8nY6FLVrQ7jp2d2T4sSJ0+t
         GX+0LZevXG6lzHEEKgJK1OjXw2IEcTnDT1nEa+qIrRmSY1H3u4Z7gxpTMQYI1Pv7YiJw
         93i+wmNtgGov6flhr5dgrJDcWd8svt3dnyQVCr1x0WDRUmeZAEjQcpo5TkFVjMvp0Mnn
         LxFg==
X-Gm-Message-State: AOAM532rs9T78uVPOlIoMvedFESGjOoUqwLnxlVzacOgEfzGmaRFQjlG
        YXzmbdzePBML8XVFqojkL9iknYzyBe5WR/tCtnZNTd3u+BWPhROPoVXrboJgM8yyr4uY4o0gvcN
        xFhhOloj2uO3EeTfuYy+GBvclnYSwVA+vGc/ZQKDSniJzBLISTzbBguvpaAlqwuLDpt4nMLZM
X-Google-Smtp-Source: ABdhPJzwNz0xJOQ5UQ4Rax3VSodtAuXU0L+axkICu24kh0fHPhU/xTF0kOdXzALpDVGWwJbMh3I+GHUH8LsJ
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:2d58:733f:1853:8e86])
 (user=bgardon job=sendgmr) by 2002:aa7:8889:0:b0:4f7:7283:e378 with SMTP id
 z9-20020aa78889000000b004f77283e378mr4535906pfe.36.1646930776770; Thu, 10 Mar
 2022 08:46:16 -0800 (PST)
Date:   Thu, 10 Mar 2022 08:45:30 -0800
In-Reply-To: <20220310164532.1821490-1-bgardon@google.com>
Message-Id: <20220310164532.1821490-12-bgardon@google.com>
Mime-Version: 1.0
References: <20220310164532.1821490-1-bgardon@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH 11/13] KVM: x86: Fix errant brace in KVM capability handling
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The braces around the KVM_CAP_XSAVE2 block also surround the
KVM_CAP_PMU_CAPABILITY block, likely the result of a merge issue. Simply
move the curly brace back to where it belongs.

Fixes: ba7bb663f5547 ("KVM: x86: Provide per VM capability for disabling PMU virtualization")
Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 73df90a6932b..74351cbb9b5b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4352,10 +4352,10 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		if (r < sizeof(struct kvm_xsave))
 			r = sizeof(struct kvm_xsave);
 		break;
+	}
 	case KVM_CAP_PMU_CAPABILITY:
 		r = enable_pmu ? KVM_CAP_PMU_VALID_MASK : 0;
 		break;
-	}
 	case KVM_CAP_DISABLE_QUIRKS2:
 		r = KVM_X86_VALID_QUIRKS;
 		break;
-- 
2.35.1.616.g0bdcbb4464-goog

