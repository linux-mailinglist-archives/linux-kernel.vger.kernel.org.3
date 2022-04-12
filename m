Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B864FE948
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 22:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbiDLUIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 16:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbiDLUHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 16:07:22 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E68DD7A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 12:59:12 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id r64-20020a1c2b43000000b0038b59eb1940so1358698wmr.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 12:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:cc;
        bh=RrsbXUK/Kg1lBZszfiVUYqQQmOv+SBqm4xpVr9KrDtY=;
        b=lpIaS53ZHrYAuHFgcuP/VAOX3kdik3hdWGO9ws4SpF3a2fUcQlNlu4E/nKtT2JL2kg
         wj2Ef1gsOleUXCf1ZhpDdjlOU7wd+oBRSNGLoKdUVMr/v/uBAFDVtIM1QUvU5vvm/N3S
         gdodnCH3sfERh0Az2dALpAcOMyV5Nto5VIYeCoMCQsqDcbYLWrByI1tKnHsANwWz2hNa
         3Yjbq2QBZ6d+pyj5+NIgiWXtkcypjCFX516dsFnT2Y+EprUp3oIO7O7oGjA4m7unHti3
         Mt9Xag9Vxa8l2NcqYf48PxQxcht/akHpkV4y/epAVGLPPTQG5qSoCXXwYiMqUA8CeTCN
         fnQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:cc;
        bh=RrsbXUK/Kg1lBZszfiVUYqQQmOv+SBqm4xpVr9KrDtY=;
        b=XiUBkTbwqwFUd4ZzgXJOUi8MReeG3dY6KS/+y8Dm6gCzGJGx8Awcc+7IHS2fgsSXti
         5cDERi8cDktMXI0x7FSs9/GyvKR9G5Vqh2N0wEJsuEkdHM50k8zjvFZVmytXD8UGXnpC
         /eMz/Deo2NT6BitWlHp/+lXo12fyKfR6wBkId+vlCo6G/tumbx4xqh5F3i/SxwP+IT7H
         gFpyanCiQKIdaVONw7zLhuVS8kqTDUbEDwMYoyuyLMZ8q57qZITcJ/6SjJFa3muEKOTl
         Uq+ExA2kDK8o3Wm+pNYHf1hI4NXIbNKOJ4JnI1pmU/AKuy8WS2zn7/vsFxw6fr9wsJvs
         hz0A==
X-Gm-Message-State: AOAM531aLDBfEzmGEwtOg4kPIAbYzCFWPAi4Jfa2cVzcE9vGWOVAtPul
        yKxD9u2X1/EwgQY+BGOU2PLUo4e55isV
X-Google-Smtp-Source: ABdhPJxTBgOzizhV2r5BUw38L4VsbWMRuWBwDWbgLZIdgzRzYzISd3bBRk5vGVgNk9zRzMp9pvoWmvMpWp4O
X-Received: from zhanwei.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2da8])
 (user=zhanwei job=sendgmr) by 2002:a1c:2744:0:b0:382:a9b7:1c8a with SMTP id
 n65-20020a1c2744000000b00382a9b71c8amr5299035wmn.187.1649793547162; Tue, 12
 Apr 2022 12:59:07 -0700 (PDT)
Reply-To: Wei Zhang <zhanwei@google.com>
Date:   Tue, 12 Apr 2022 19:58:46 +0000
In-Reply-To: <20220412195846.3692374-1-zhanwei@google.com>
Message-Id: <20220412195846.3692374-3-zhanwei@google.com>
Mime-Version: 1.0
References: <20220412195846.3692374-1-zhanwei@google.com>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH 2/2] KVM: x86: illustrative example for sending guest _stext
 with a hypercall
From:   Wei Zhang <zhanwei@google.com>
Cc:     Wei Zhang <zhanwei@google.com>,
        Suleiman Souhlal <suleiman@google.com>,
        Sangwhan Moon <sxm@google.com>, Ingo Molnar <mingo@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A guest could send its _stext with the newly added hypercall. The
statistics collected afterwards will be correct in the kernel.

Signed-off-by: Wei Zhang <zhanwei@google.com>
---
 arch/x86/kernel/setup.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index c95b9ac5a457..ee8c4fd4efe9 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -24,6 +24,7 @@
 #include <linux/static_call.h>
 #include <linux/swiotlb.h>
 
+#include <uapi/linux/kvm_para.h>
 #include <uapi/linux/mount.h>
 
 #include <xen/xen.h>
@@ -1241,6 +1242,11 @@ void __init setup_arch(char **cmdline_p)
 #endif
 
 	unwind_init();
+
+	/*
+	 * Send the _stext to the host kernel.
+	 */
+	kvm_hypercall1(KVM_HC_GUEST_STEXT, (unsigned long)_stext);
 }
 
 #ifdef CONFIG_X86_32
-- 
2.35.1.1178.g4f1659d476-goog

