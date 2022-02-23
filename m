Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7801F4C0C2B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 06:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238463AbiBWF30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 00:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238478AbiBWF1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 00:27:21 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5536FA00
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 21:25:35 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id w1-20020a05690204e100b006244315a721so15103484ybs.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 21:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cWpgk2PD8ywov80MgvYy738g6oDVkPJMa4mg6Kd57WI=;
        b=EONmeIZhbgQ2Ix8S9q3J8G/HTiRJQe/uAmut/mIfTv5CIy/cqk4x/lLfaofIL6ZsPO
         2DK7UMkGosmFYOPK8XbKYJ2B7I4QKSD7X8xoOad3cTZw5YniQxiy63dmB34fBM3ScXK9
         b4M3PhJD3t0ZCy25IHGFNrU1Wai96D7oCn70Yeg5Az606EQRIrVrKV03yc49SjAoBqEY
         D/bmDYBLa30k0Q0T1/0E+zVvHZ7GWXBtnOemyeM6dCZ+R2nj996pZd5wNPpUZxVxnqxJ
         WaqOqmkCjUVkdvW9sUwO7Bbj6HXZvuS7EIm1omaeZny3PaSOUoJHhQmMblrL8LNsc6wd
         q1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cWpgk2PD8ywov80MgvYy738g6oDVkPJMa4mg6Kd57WI=;
        b=ESNwcdSrhhzBzcM6W3/JrafRFhqX3vAFFQORC5ayZmuSAZcJsDDvmYfu765Us7vUVL
         rmbF2jH3u4QM9lTj7wBIIdpSn/p15J9GxQkOi54ylP4ryK4Jg9WHI4Bs6Q8CS2j6KjnH
         o389/Kb4kJxVEHAr9WG1vZvHuoJkBCScqZPMCvIdipgV/bsLFcqNRfzlj3SZH5tH7PHq
         xPb8BHm0mN6oQc8GoUjaZoDKBAW9u2j0DQQG94iSqSqX7apR2FPWM2vbdyjKDjENaA2R
         ATvw1enppYrHGPuPkyoJ+ylu85IVzZrC0/NY0WERBZuegu01wlRhTCo+UGLK6yj1YnPo
         fsog==
X-Gm-Message-State: AOAM5308wCf0ZPaGpOIAQ7o+N+hT9jBEHFLiTLp4wW50Ta9MRa4GXOEp
        Vy9lOeFfTl6k9wqJLjCLeVxUf5RR0FDvHEVD9BAhgqEivp/VVxaKF2Wi4AZyPBbQLlTL+KOEKqB
        m09ycLQK2y8/yRYQB7rpip6Q4lja1L7IYx5Hm1uZhLLUzWjA3jTmMDYjDe1d4awh0mZrrJfnr
X-Google-Smtp-Source: ABdhPJxkXSiWBnVLfkr470oqcQZfrXanhJKcgx/q87EPE8RXSdLDTEk6wPn7sTX4KYfxfNXBGCkwiM0xCmzr
X-Received: from js-desktop.svl.corp.google.com ([2620:15c:2cd:202:ccbe:5d15:e2e6:322])
 (user=junaids job=sendgmr) by 2002:a25:bf87:0:b0:622:1e66:e7fd with SMTP id
 l7-20020a25bf87000000b006221e66e7fdmr25540509ybk.341.1645593928498; Tue, 22
 Feb 2022 21:25:28 -0800 (PST)
Date:   Tue, 22 Feb 2022 21:22:22 -0800
In-Reply-To: <20220223052223.1202152-1-junaids@google.com>
Message-Id: <20220223052223.1202152-47-junaids@google.com>
Mime-Version: 1.0
References: <20220223052223.1202152-1-junaids@google.com>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [RFC PATCH 46/47] kvm: asi: Do asi_exit() in vcpu_run loop before
 returning to userspace
From:   Junaid Shahid <junaids@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Weisse <oweisse@google.com>, kvm@vger.kernel.org,
        pbonzini@redhat.com, jmattson@google.com, pjt@google.com,
        alexandre.chartre@oracle.com, rppt@linux.ibm.com,
        dave.hansen@linux.intel.com, peterz@infradead.org,
        tglx@linutronix.de, luto@kernel.org, linux-mm@kvack.org
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

From: Ofir Weisse <oweisse@google.com>

For the time being, we switch to the full kernel address space before
returning back to userspace. Once KPTI is also implemented using ASI,
we could potentially also switch to the KPTI address space directly.

Signed-off-by: Ofir Weisse <oweisse@google.com>


---
 arch/x86/kvm/x86.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 680725089a18..294f73e9e71e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10148,13 +10148,17 @@ static int vcpu_run(struct kvm_vcpu *vcpu)
 			srcu_read_unlock(&kvm->srcu, vcpu->srcu_idx);
 			r = xfer_to_guest_mode_handle_work(vcpu);
 			if (r)
-				return r;
+				goto exit;
 			vcpu->srcu_idx = srcu_read_lock(&kvm->srcu);
 		}
 	}
 
 	srcu_read_unlock(&kvm->srcu, vcpu->srcu_idx);
 
+exit:
+        /* TODO(oweisse): trace this exit if we're still within an ASI. */
+        asi_exit();
+
 	return r;
 }
 
-- 
2.35.1.473.g83b2b277ed-goog

