Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD49518C6C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 20:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238162AbiECSfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 14:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241404AbiECSel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 14:34:41 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DED23F314
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 11:31:00 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 64-20020a630843000000b0039d909676d5so8775264pgi.16
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 11:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xswzH/Bbil9zpaQ4laTDHIN9myBOysbLUHFynw5y6xc=;
        b=VqB8rjIXOtLuE0VJ1xycczkIMarEZrfY/e2JGoH2Rr2NV7qkzB4ygYQtZr51hgCro0
         UGK5tMHuWbqeFVCKG/vgmz1a/HoJlUfbCJGD65QT1tShrCWEujpNC4z0AkI+x9aMpJUC
         TXeioZyUTKy1Lpr9mIieayddzozTsUDqTMwjVJGPXQ0LZY8Bd5q3KZYJKCCPtfTTRXO4
         UwHixsWHz8cDtdu+2SrYbok7/fH/FSjmwYMuR4LKa7uCnULL81IJOZog7zxTrO1dWxPX
         I8iXtPhLI39wezrY3pudK0kh83BIXP/tzpOBWlEdLegxtBjgpOzOvcDIWwYI84pd+r+c
         Dfuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xswzH/Bbil9zpaQ4laTDHIN9myBOysbLUHFynw5y6xc=;
        b=iHHDu+vCnT3VGTKXz3nUukq47iG6OPKCTx1UaJZl177gXS6ITLE6Jhl99hOXlp4IgU
         5gGsMITkN7KcdJSWx2CVyvxJJudbGpniyTWTcT+T+VhDR8YK/fAY89F+Myw7Eid/z+wl
         Ns/NeOsIrf4Jb5BCiw3peHiBuDv93sC2C6nW1LEzC2Fl8uadRfUy0yX5O4VwXzRFdCBm
         UX8llP3umxaT/0akuJRlZHNz5bjR3dfNznL4xWq25XR4rtYa14/ga4T9RiIXHNKWWMoo
         Cu6QcDeEX7lk89lcJPfFPqfB7ykCOePOMwPSPQBdvZI2sMsd34I0emR7gH0HytZulItm
         USQA==
X-Gm-Message-State: AOAM531r+RY93N/fcUeBNaP/7RsV+Mrbrw5yndNKuqYln1jMYoc0UuNR
        NKa4DKaJu6ti0fFirXymyi4eoRyjdX0H4TRE24i1OSJt9RWtVP0czqKcb3s+TIYvvF+eY8uimRS
        +KmSc6DCJu5y6IQB4LLAtWA9O7QqT/pRfH7cKnpAwGeSbYTBoAyaQOd2RIrzhYfUKLmuOdpHW
X-Google-Smtp-Source: ABdhPJyZ4iLDny5B9TJHOLEZRFr/+K04g9w9/rCRKqe1027R7q4Lcz3kfqmAjEjnxIIB82jFNN5gGg/+6Q3A
X-Received: from sweer.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:e45])
 (user=bgardon job=sendgmr) by 2002:a17:90a:fa06:b0:1d7:765d:111b with SMTP id
 cm6-20020a17090afa0600b001d7765d111bmr6080511pjb.185.1651602659687; Tue, 03
 May 2022 11:30:59 -0700 (PDT)
Date:   Tue,  3 May 2022 18:30:41 +0000
In-Reply-To: <20220503183045.978509-1-bgardon@google.com>
Message-Id: <20220503183045.978509-8-bgardon@google.com>
Mime-Version: 1.0
References: <20220503183045.978509-1-bgardon@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v7 07/11] KVM: x86: Fix errant brace in KVM capability handling
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

Reviewed-by: David Matlack <dmatlack@google.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 8ee8c91fa762..5ba9c7c8140a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4382,10 +4382,10 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
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
2.36.0.464.gb9c8b46e94-goog

