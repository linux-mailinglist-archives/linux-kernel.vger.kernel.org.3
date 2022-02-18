Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E384BB04E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 04:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiBRDlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 22:41:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiBRDlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 22:41:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6722910FFA
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 19:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645155686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hArr4mJlPZnwAWrYBTIVC2/1c3VQ46oZ6y6rsQQSe+k=;
        b=e2PDR2R23RT312eTFtcxpKYXtW1Om/lr4MO29SvFRa7+VrCqJ7+Ruu1oTu5UZfYnnNCXUw
        bEeQrgsGfe91zksgEXS+HFoBspvVhuxpIPGJsjXVWAYz/AfF0WLOvunDWb22dULTojyDtJ
        Y61y9bHncYGTgm8R5YCcWpsevY2nkK8=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-WW-JRKYQNxyl1A7It435vg-1; Thu, 17 Feb 2022 22:41:25 -0500
X-MC-Unique: WW-JRKYQNxyl1A7It435vg-1
Received: by mail-oi1-f200.google.com with SMTP id o4-20020aca5a04000000b002d3a5cc05b9so909917oib.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 19:41:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hArr4mJlPZnwAWrYBTIVC2/1c3VQ46oZ6y6rsQQSe+k=;
        b=Gu52sT0coMtRv+IM7o8AFCyiBrtVWjr7swVV+iQkk43o43qMQiRY95GCahQtBkvA/G
         eMA+pDYGqWjQa8sCFQFjoU6dh0viXVXD71tI4ePHRibcVnmXIoSFPIRX31OD+jvPu+04
         Jw2zJGc95U3APNtQ8AVrXh4rVKV2LQeJfKsQ2JFb339IRhjj4r/4w6EFUHykkmxXHHrU
         qGuojvNCbf5jnH2mO6mj8UHILMjF+5ddIbt9lZgI+K35qBDg3AhiciAGd53t6ypbFbZd
         5AF6rLBMvYc40BTH+vZJB7wg9EXAFLm6yZe5+04QRb3NWQtxy4CmK6YWXQV0i7ztcz5L
         c8XA==
X-Gm-Message-State: AOAM530ESbPWFAxeJWVKYh6usiDdgVVZvRqBvcLEeZAKXuevqEa8PeUX
        9aybXUrbRc3qlk+VT3PdZpCzqudTeLR4A51yzfvLOlVIX8xMBodqtyLao5/SqUb7ay6W+5fqn4t
        /6G0IHzBWHBxzYosN0MTjqF7j
X-Received: by 2002:a9d:2c8:0:b0:59e:bea0:a9f4 with SMTP id 66-20020a9d02c8000000b0059ebea0a9f4mr1930282otl.221.1645155684415;
        Thu, 17 Feb 2022 19:41:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz0+GdnkfLgkCWNJkBfsRH9CCeWqV4vimJP6tkia4RuKX0EWc/0JV/P6rzXwl8ah+7NPZFpXw==
X-Received: by 2002:a9d:2c8:0:b0:59e:bea0:a9f4 with SMTP id 66-20020a9d02c8000000b0059ebea0a9f4mr1930266otl.221.1645155684208;
        Thu, 17 Feb 2022 19:41:24 -0800 (PST)
Received: from localhost.localdomain ([2804:431:c7f1:c12c:38a3:24a6:f679:3afd])
        by smtp.gmail.com with ESMTPSA id 189sm694698ooi.9.2022.02.17.19.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 19:41:23 -0800 (PST)
From:   Leonardo Bras <leobras@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Leonardo Bras <leobras@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH v1 1/1] x86/kvm: Fix compilation warning in non-x86_64 builds
Date:   Fri, 18 Feb 2022 00:41:00 -0300
Message-Id: <20220218034100.115702-1-leobras@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On non-x86_64 builds, the helper gtod_is_based_on_tsc() is defined but
never used, which results in an warning with -Wunused-function, and
becomes an error if -Werror is present.

Add #ifdef so gtod_is_based_on_tsc() is only defined in x86_64 builds.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 arch/x86/kvm/x86.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ca0fae020961..b389517aa6ed 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2363,10 +2363,12 @@ static u64 compute_guest_tsc(struct kvm_vcpu *vcpu, s64 kernel_ns)
 	return tsc;
 }
 
+#ifdef CONFIG_X86_64
 static inline int gtod_is_based_on_tsc(int mode)
 {
 	return mode == VDSO_CLOCKMODE_TSC || mode == VDSO_CLOCKMODE_HVCLOCK;
 }
+#endif
 
 static void kvm_track_tsc_matching(struct kvm_vcpu *vcpu)
 {
-- 
2.35.1

