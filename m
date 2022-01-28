Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B49B049EFFF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 01:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344921AbiA1Axg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 19:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344799AbiA1AxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 19:53:19 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E21C061749
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 16:53:19 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id y3-20020a170902ed4300b0014c958855acso405642plb.20
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 16:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=cCud0Kpa8l1l/qGHOZiBm/VeUVJQYIj1xOVhvfcHUZI=;
        b=brk94DiVtQRsClZuWo0yKIokEP8lGH82FvMbhpJN5DDit+fDkuCuHBxY0LXx3iI6c5
         uIrMmLrii1RBnJaG8EXivkA+zs066u35Iosg+1OvBoBhLV4e/jcVnAymnzp0ChNMFSmK
         kYkPV5isii7QV1UaEi8qYCnf8gWg4KYcGgh0KHqC3kMpvA9DfZWgR1ojDXyO0B1ZNTru
         TaXk6vWZojatURdTmdj5JhX5gNXC8lVMjI0gdhlS97jqAZahfYKqUTFQbY2i0gesZ1fT
         HqZ8nq/nxoRcdfH0nTG/bLpc+8s6Kho33aVCCWWYYi0hNYZBY0apVKvdPFF0kDYYm3kF
         r8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=cCud0Kpa8l1l/qGHOZiBm/VeUVJQYIj1xOVhvfcHUZI=;
        b=qU87mEqwgu/krLIbGPdSPnYOjpoaLf23jck5rLJNTF0u3k2BQOJWCmG6h//SrZ9lgM
         L3UK37LDBQ9moZssu+6B14k2NhXZeSsnHs4+ZbmRJTHhqy4TDKPtYlkJ3lt1HO2NTB/j
         NAB1IzRgm9mupg9rpEBh5saq1rT4EwxkoPMVLyDzLOLUPvlGpVY4MdRKZXj2o4O/3YOF
         sSpLhaKckdpH7q1DJjyoL6HQz7Rq0G41bLwikffvgmP+8Y8myTybJyDw/CS7SpfcXpQ2
         a9VTyCwCdxFsX//m/WPbVl9hRmNV0QKFdZsyhFHDwtuJLcrBEXLp4L/4z49+Rg+/Rew8
         qZCQ==
X-Gm-Message-State: AOAM533TK6hxZMJZszZiL5zoiw+pdP942a+5TAA1/TuPaC6YMbjhogn9
        WN+mwLwwWIylqHfGSYFnZwAeTBr23P0=
X-Google-Smtp-Source: ABdhPJxjDKhytSS1r+DHo41J3pSmCsXa6mfHle7bKxcfeM9uEkj0aoDjmtUMBhT9j+AfC/Vl1q0dJTlVfag=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:ce84:: with SMTP id
 f4mr5575274plg.140.1643331198890; Thu, 27 Jan 2022 16:53:18 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 28 Jan 2022 00:51:49 +0000
In-Reply-To: <20220128005208.4008533-1-seanjc@google.com>
Message-Id: <20220128005208.4008533-4-seanjc@google.com>
Mime-Version: 1.0
References: <20220128005208.4008533-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH 03/22] KVM: x86: Drop export for .tlb_flush_current()
 static_call key
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Like Xu <like.xu.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the export of kvm_x86_tlb_flush_current() as there are no longer
any users outside of common x86 code.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ebab514ec82a..a2821c46dfa4 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -132,7 +132,6 @@ EXPORT_SYMBOL_GPL(kvm_x86_ops);
 #include <asm/kvm-x86-ops.h>
 EXPORT_STATIC_CALL_GPL(kvm_x86_get_cs_db_l_bits);
 EXPORT_STATIC_CALL_GPL(kvm_x86_cache_reg);
-EXPORT_STATIC_CALL_GPL(kvm_x86_tlb_flush_current);
 
 static bool __read_mostly ignore_msrs = 0;
 module_param(ignore_msrs, bool, S_IRUGO | S_IWUSR);
-- 
2.35.0.rc0.227.g00780c9af4-goog

