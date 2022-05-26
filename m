Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732B55352F9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 19:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348512AbiEZRy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 13:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348362AbiEZRyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 13:54:25 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA499EB44
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 10:54:23 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id d125-20020a636883000000b003db5e24db27so1128414pgc.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 10:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Gl1ger3sfcviuQtEjEFpxedsk42UqwPOcwBSPpwDgrU=;
        b=fucrALtULyCr73H7V/AH9SnvOwGVx9HHpm5iyNovmetTQtgREZgxD+4w8eqnV4gfn+
         xftI2cBDekG3YFoRIfxuQyENTWfQMxB498jJ8f4i2yN8pHLiobFxCVR7sHPfb+UuyZOO
         OYJfLUZl+G+EAGlECaHo58kwZGC43X0jlIf03PF9V9gDe2OEUOdwd9I784uTojTJbmIT
         BZNMIIUqlhXjrB2QvB8AocVSl+lnC7LDI/PB0Zp1z3nk6dAR+RyISpDIFdXb+psDbxkN
         MSkCaJjWz4EumHXma4xy7MGPbXR9xII2n7y3KxNBZ0AANV1bJ2OUQBKsjW9JF+q7eRL8
         d/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Gl1ger3sfcviuQtEjEFpxedsk42UqwPOcwBSPpwDgrU=;
        b=MkiVtjUshjeV7Mjz3PgN9n7wqqZMu9vqV5TT/JQ2whTBNxIVAok7MgrezjzI8UTLLv
         4dPC6P1iPxmrHmnsri6Xy9yGVOAIsm4TvQw1/2hH/fNyyVxD43yvtJlaOZvMMraiOptM
         fEtQytmiy5TMsnjMNgHtHqXylb439gfGsTU7gRya211PWvtmfbi5A1p9XDIliRfwj8aO
         RqhsyXDlzk7vI1B/Ib6oh0gXOTdny0gFXiz43IS1sTUJQVKXBV9ydm2ojxN5K1yXY9Ey
         ByiQsUs3BznhLAjHiMGAfI1XJZXleKH3BwnTzletykyqa5Zlz7QqoA5bzpGLwrMdj1gK
         E/OQ==
X-Gm-Message-State: AOAM53253mfRLEOtsYgbXna+Athw8u5lWWH+58JkLVn2dWmDW89WdFmp
        9LxWa6UCLodTl6HNqrbHOarD5GVkKsNe
X-Google-Smtp-Source: ABdhPJwfS8zuFF5ADj/NW82LmsBUkN5yDaJ+k3+6saKpjrVZOvgqnncdg9RnQRuQWYjSi4EU2ni3mLGwusvY
X-Received: from sweer.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:e45])
 (user=bgardon job=sendgmr) by 2002:a17:90b:1bcc:b0:1e0:1c94:ebcf with SMTP id
 oa12-20020a17090b1bcc00b001e01c94ebcfmr3830455pjb.140.1653587663082; Thu, 26
 May 2022 10:54:23 -0700 (PDT)
Date:   Thu, 26 May 2022 17:54:04 +0000
In-Reply-To: <20220526175408.399718-1-bgardon@google.com>
Message-Id: <20220526175408.399718-8-bgardon@google.com>
Mime-Version: 1.0
References: <20220526175408.399718-1-bgardon@google.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [PATCH v8 07/11] KVM: x86: Fix errant brace in KVM capability handling
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
index 7460b9a77d9a..33653a008b28 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4414,10 +4414,10 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
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
2.36.1.124.g0e6072fb45-goog

