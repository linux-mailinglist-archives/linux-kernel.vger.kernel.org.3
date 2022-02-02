Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5434A695D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 01:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243582AbiBBAuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 19:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243598AbiBBAuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 19:50:07 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77932C06173D
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 16:50:07 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id t1-20020a6564c1000000b002e7f31cf59fso11297243pgv.14
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 16:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=3/7OuVceBn0EleUU7nySvspzg5VyH7dxhNHRLM/3NIE=;
        b=EtaUGeB0crakORjKPe7ruh7EgNS85rRKIo1vZQSAgHFcEudyPUz4RuiIq+KtjJYiZR
         1OqL25OxkYDNrCXKWKLz2YOtA4ckbOSJ3+YP4TfziGxQnMIEELSoi06HE/9CeAUSLKXU
         kSy5TvR9DjgowQ6RUPus4vXm0kcKZIN0W/4GBqjk0cAptuQUniCap/nPA6FskhIFtUeQ
         TTChArhpBpKfLOJe2aEt4MAxjHdkfSWQ++Di3jyS/VRH2ieCQD9GR20lU+klsKYnE5iY
         Fk4wRG/2OAgDLpvQ3U/NmazfqzqkzoGGPPqm8cy9lzbAKtPwG/yzEg1DGV4eFnlG7ZaS
         qHGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=3/7OuVceBn0EleUU7nySvspzg5VyH7dxhNHRLM/3NIE=;
        b=FYg29m1IbEuqyY7zdTiOtx5c4LHEMzo2S3VQ0d4H/DZyo2n+S9SgNjNivtWVqn9FO5
         zVmt4QstQQMWxRoKviVkmpY2oFWKmNhHc8WKMtGIhNbGbntPrRTsVPlhbvTUNITtKp2t
         gcfCd/L2fJZHeVeuHW5sWxYN27Lsgl28+mx/28AzOMZ8+nHW1fHVzIK5sgTmBky5kPDX
         4XQwhdRS06BPnnKSw94Z273mRX8XXBm0zollXv8k0RlbSWERunx53BdudtIx7GIDlgZC
         g77uj3QNHZ77Q7S9fVCAhBQ10vaM3cEoPGPXo1vhPr4Z+PYoOk+STWL7toU5aK6h7bNU
         OOag==
X-Gm-Message-State: AOAM530eSPhCtRj8lqvH9gFQzuPEgaZLK8NwBScqsZyh6gcm16D/BpTs
        x8BpaVrComKaPYo/XDZB6kqouXW4QYg=
X-Google-Smtp-Source: ABdhPJxaOUM0XxNVSnap4U+XQvTqFWJQ1EEDHMwv7ezGfJzzItoGIpIVtAqpcjtk78QdP1E/SRU2o8215xU=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:b212:: with SMTP id
 t18mr13193260plr.80.1643763007012; Tue, 01 Feb 2022 16:50:07 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  2 Feb 2022 00:49:45 +0000
In-Reply-To: <20220202004945.2540433-1-seanjc@google.com>
Message-Id: <20220202004945.2540433-6-seanjc@google.com>
Mime-Version: 1.0
References: <20220202004945.2540433-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: [PATCH v2 5/5] KVM: x86: Bail to userspace if emulation of atomic
 user access faults
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Tadeusz Struk <tadeusz.struk@linaro.org>,
        syzbot+6cde2282daa792c49ab8@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exit to userspace when emulating an atomic guest access if the CMPXCHG on
the userspace address faults.  Emulating the access as a write and thus
likely treating it as emulated MMIO is wrong, as KVM has already
confirmed there is a valid, writable memslot.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c9cac3100f77..24e0981816c0 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7217,7 +7217,7 @@ static int emulator_cmpxchg_emulated(struct x86_emulate_ctxt *ctxt,
 	}
 
 	if (r < 0)
-		goto emul_write;
+		return X86EMUL_UNHANDLEABLE;
 	if (r)
 		return X86EMUL_CMPXCHG_FAILED;
 
-- 
2.35.0.rc2.247.g8bbb082509-goog

