Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF655A72B5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 02:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbiHaAhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 20:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbiHaAhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 20:37:00 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D3DAB050
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 17:35:50 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id i191-20020a6387c8000000b0042b44ad723bso6231291pge.19
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 17:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc;
        bh=vs+/VgNPbXQDyp+lFpPyuzFJGuQv6/mfWtb6IRoNofc=;
        b=cvWzuF/pUn7dcLNtyrR5ZfO7DpFQ4TMlPUqGc3ivk0ghfq2DY3XadZH3z7R78K+3e0
         maM0SJLY6f2+4rvRYvaFogaghRu2HpktMrb8ohbADFAO0jaO5fy2+oZ9GaLpL48XPz6q
         uKjZu2+/RlKcBXZhvB+wbKcxzwHv1xJ29PKHH0E+GS/yJ8FzwYKDz9PHxbWVLlokwHJF
         Wp3CyTZqcZNxxeeD13DanuKngWPcc2ljnts6fPhOKvbEJxBt7Qtp13eNoezrBqjs+viX
         q1NeXWzk59DSQ5cLYreO3Qjm8NC/iylmjThcNHEvB5HkcO8VAggD/2ojYHMHfwZfNL+1
         zWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc;
        bh=vs+/VgNPbXQDyp+lFpPyuzFJGuQv6/mfWtb6IRoNofc=;
        b=CRjihmwzg8EYUYizyW1jPkmYkxM3c6CcE2GAwpkla5FPbWcVXI1OibEzDOjksPlz/H
         Hbco0mmmy4ABpk4FXdvJjulVflnBczIVQPf6JNPpzS+GpolnG2zWJtHssG7wH3AC8JEU
         dXp+H5JAcppfb0WTAUGFk8pljkk14ldS/mANCeKT6kzMc8Hs1YOrOR+3egNnXsswRBWD
         aKBSvd7pUOyFRRtW9US5OPqAlj3OTZWAkEmQzEHawIDHpNtrw8cgq+y9svlqlwDAm1Da
         gTpZ4iIGIOQ6othRwTuOYwkQhw7bkKh3oWw0ITQrINX+LS+ag1aWQbrHXG6XZhVczCyu
         Fk0g==
X-Gm-Message-State: ACgBeo23GlokEaWk9G/Tc335/gPk+xAF58DXVX5zgedCd5GUd37QWPuy
        ITo0FtGvjAXdKjQ8tz9PvlJCb0dQ3HU=
X-Google-Smtp-Source: AA6agR5OjPqtHiqPZMJX6QZ8XK4pECvI+wrTckRQpR97VYnRYJQo0TfwPxQCWcEahmapGJAM35xUkVnM5bc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:cb87:b0:1fd:d261:f87c with SMTP id
 a7-20020a17090acb8700b001fdd261f87cmr628971pju.43.1661906123392; Tue, 30 Aug
 2022 17:35:23 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 31 Aug 2022 00:34:55 +0000
In-Reply-To: <20220831003506.4117148-1-seanjc@google.com>
Mime-Version: 1.0
References: <20220831003506.4117148-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220831003506.4117148-9-seanjc@google.com>
Subject: [PATCH 08/19] KVM: SVM: Remove redundant cluster calculation that
 also creates a shadow
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Li RongQing <lirongqing@baidu.com>
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

Drop the redundant "cluster" calculation and its horrific shadowing in
the x2avic logical mode path.  The "cluster" that is declared at an outer
scope is derived using the exact same calculation and has performed the
left-shift.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 14f567550a1e..8c9cad96008e 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -410,10 +410,9 @@ static int avic_kick_target_vcpus_fast(struct kvm *kvm, struct kvm_lapic *source
 			 * For x2APIC logical mode, cannot leverage the index.
 			 * Instead, calculate physical ID from logical ID in ICRH.
 			 */
-			int cluster = (icrh & 0xffff0000) >> 16;
 			int apic = ffs(bitmap) - 1;
 
-			l1_physical_id = (cluster << 4) + apic;
+			l1_physical_id = cluster + apic;
 		}
 	}
 
-- 
2.37.2.672.g94769d06f0-goog

