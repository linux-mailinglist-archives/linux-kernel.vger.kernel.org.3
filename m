Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F074F9E2A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 22:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239471AbiDHUa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 16:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbiDHUaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 16:30:23 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA8F1D97DF
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 13:28:18 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id mw8-20020a17090b4d0800b001c717bb058eso8401151pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 13:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=bZxSyBqJebUSPZ6FFYIz1/hOaAJ4eqoMo84YLPbpDGY=;
        b=KpsoLqgOpyqA2XDJTxIy7nYpMLWH8X9LwqInJIb6m5WTW1f2quad3/1REI4rASKzTn
         wWg8jC+MG3baWyRyouwD4FoUQ3NEuKCljR6gxzCE2DXUKSZQjcFGmdA1C285q0PRl8fj
         //rCiuu2jy3LpXl0aXN4hiro1mFrLi7lQ5dtOQw8UVGLqBkJlYOYpeGaBoA+0JL2uS86
         aVUIIWshxzPHqTAEvhq7SIXhKkKmxZ7xqX95l0kPnp6+A5LMbIQTAZ3lzRB9d0rzgPjs
         uOg2xalP33Br5BYSBYY3mcqHH+9rQeeVirdMwj2okjvqiRjy+R046YRKqHHZLNuN44xl
         rpTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc:content-transfer-encoding;
        bh=bZxSyBqJebUSPZ6FFYIz1/hOaAJ4eqoMo84YLPbpDGY=;
        b=LWmJOnc2Yb2dzc83WuVRQ0KMF4mgp1kIMUGqio9gfzP0bkFg8YkfeQyBgXAFoxw248
         fBsdFEBvBkYdmwmqqydc+ni8UHUKkHRUCB3unTkQEJ9kr1aGAhqVxmeIHw9UVv/121aA
         FB+RKkCNFoINNWTNXekgiiJzemQC2xOk0k85Av1m2BFb+5oJTUXifV1ifiiQ29osv14x
         4TdooZOxq9Ya/PG3rU3eZaAK574pLT0umS2liQYZlHrdK+5QxnXUYwTgzWVD56mvQsJg
         z8lcx5mrGRWAuUL7w2m4Qi/8FMnuNMViS3t7AdefiZKrnweIIn0MRc002G4N6UZNuAY0
         eXXw==
X-Gm-Message-State: AOAM532lbTPPkjazsM+jjW0lFB0fzyi8fxZrV6sQXIV5dIwZacloG793
        UGteg+qKZtN+ikMutikmkoKd9pWhsVQ=
X-Google-Smtp-Source: ABdhPJyd+ETmhbhfzBCcBJCZ0+x53O+4bpTcoPQ7JVlFxhJf08oiDQuRDQU3I0/Gep+ONWV+rXn/xdTtHY8=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:4a82:b0:1c7:8a44:e0c9 with SMTP id
 lp2-20020a17090b4a8200b001c78a44e0c9mr24014559pjb.102.1649449698237; Fri, 08
 Apr 2022 13:28:18 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  8 Apr 2022 20:28:15 +0000
Message-Id: <20220408202815.386932-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH] KVM: VMX: More brown paper bags! NOM NOM NOM
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a missing declaration that got dropped between my inline patch[1] and
what actually got posted[2].

In file included from arch/x86/kvm/mmu/mmu.c:4279:
arch/x86/kvm/mmu/paging_tmpl.h: In function =E2=80=98ept_walk_addr_generic=
=E2=80=99:
arch/x86/kvm/mmu/paging_tmpl.h:496:50: error: =E2=80=98EPT_VIOLATION_RWX_SH=
IFT=E2=80=99 undeclared
 (first use in this function); did you mean =E2=80=98EPT_VIOLATION_RWX_MASK=
=E2=80=99?
  496 |                                                  EPT_VIOLATION_RWX_=
SHIFT;
      |                                                  ^~~~~~~~~~~~~~~~~~=
~~~~~
      |                                                  EPT_VIOLATION_RWX_=
MASK

[1] https://lore.kernel.org/all/Yj0NOQOYEAG+Dz7+@google.com
[2] https://lore.kernel.org/all/20220329030108.97341-3-darcy.sh@antgroup.co=
m

Fixes: 68ca1f59584e ("KVM: x86/mmu: Derive EPT violation RWX bits from EPTE=
 RWX bits")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---

Please squash, thanks!

 arch/x86/include/asm/vmx.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 46bc7072f6a2..6c343c6a1855 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -543,6 +543,7 @@ enum vm_entry_failure_code {
 #define EPT_VIOLATION_ACC_READ_BIT	0
 #define EPT_VIOLATION_ACC_WRITE_BIT	1
 #define EPT_VIOLATION_ACC_INSTR_BIT	2
+#define EPT_VIOLATION_RWX_SHIFT		3
 #define EPT_VIOLATION_GVA_IS_VALID_BIT	7
 #define EPT_VIOLATION_GVA_TRANSLATED_BIT 8
 #define EPT_VIOLATION_ACC_READ		(1 << EPT_VIOLATION_ACC_READ_BIT)

base-commit: 59d9e75d641565603e7c293f4cec182d86db8586
--=20
2.35.1.1178.g4f1659d476-goog

