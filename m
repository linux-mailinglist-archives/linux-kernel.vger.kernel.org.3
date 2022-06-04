Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286D853D46E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 03:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350472AbiFDBZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 21:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350295AbiFDBXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 21:23:09 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E30D2E090
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 18:22:14 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id lk16-20020a17090b33d000b001e68a9ac3a1so3460543pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 18:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=Or9oZigrlqmog/yA1fZLlOqMIX7r2SC754YtuTj7pwE=;
        b=TePavb7uMhS7u9l5A/7K5usYxLzh0hNGrwjp1dzSiUJ/o6s2t7aHGWeI1BUaq8blbd
         ETh+obtLZ8N87UBWog4wGYhdyKzT6XEGYJTQBJShdU2aGvGOeUyL8os5tEBk1sAoJZZD
         F2iV7qFJSbwFM6VR/B+TUrGLu5AWvlt8LocMh70ZbH9wK8UwXxaucev6kS//x4g0s3vG
         zL1N6ChYD8hQEGtU+cNfoKzWJy+GBHNgSEmBcxy49asC/DXkRzIgtk3AZXacXnS1ILpW
         l9fIfXdH5udx/YQFU8XQdBd/yi9P64yYdPI+I7hRBaDg7oA8UG9Aoy/77vBZaUSPEwnc
         PCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=Or9oZigrlqmog/yA1fZLlOqMIX7r2SC754YtuTj7pwE=;
        b=y6oIwGHHUx5zZUgS9D23RENSvXsSSd57lAJbrO+3yltDeMBxhWxZ5tR6JDJKXV2Gpn
         SXDoi82akxPOdHPjWJc0pThavffsROJgMsaKuM+Oipvm7jchTXwJP7MX6xvgWHtK3fDL
         wuQ6o/LqhWP4bv7MdHUS7peE+2IL4i5FT5zf9ZqPKDbXXY73+FKP5j5pv4VtDUjkpL6c
         ti0Zs3eHEQe1DexkNRJewZO22cWznn4NpBW5DEoTltgLeoEreTCmGsW+8be1HNGjTYJr
         B1DtG5A+cWWZ3FNfoldMtxgDfrE8882B9lnXt9snbeCFdJpo1mqALSS80BJfRD7LpAPA
         WBFA==
X-Gm-Message-State: AOAM531hF1X4y/dEDGAR4y22lH27CXKk5HDSbE4Y+z1EZyNcwuC2JpN5
        A9M5uH8NYrQYKoYoBAZlc/EwAWJFzBE=
X-Google-Smtp-Source: ABdhPJxy1slOBG+i324d2rxO7aa0HIIwMDM/x5I1K9FxYS05V3hXvz9Jq9UVyb+l8/30ynoIuwoVqAGIQcI=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1e01:b0:1e3:1f4c:dd71 with SMTP id
 pg1-20020a17090b1e0100b001e31f4cdd71mr13860248pjb.168.1654305724515; Fri, 03
 Jun 2022 18:22:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat,  4 Jun 2022 01:20:52 +0000
In-Reply-To: <20220604012058.1972195-1-seanjc@google.com>
Message-Id: <20220604012058.1972195-37-seanjc@google.com>
Mime-Version: 1.0
References: <20220604012058.1972195-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH 36/42] KVM: selftests: Rename kvm_get_supported_cpuid_index()
 to __..._entry()
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
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

Rename kvm_get_supported_cpuid_index() to __kvm_get_supported_cpuid_entry()
to better show its relationship to kvm_get_supported_cpuid_entry(), and
because the helper returns a CPUID entry, not the index of an entry.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/x86_64/processor.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index db724670c895..b47291347a5d 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -697,15 +697,15 @@ static inline void vcpu_clear_cpuid_feature(struct kvm_vcpu *vcpu,
 	vcpu_set_or_clear_cpuid_feature(vcpu, feature, false);
 }
 
-static inline const struct kvm_cpuid_entry2 *kvm_get_supported_cpuid_index(uint32_t function,
-									   uint32_t index)
+static inline const struct kvm_cpuid_entry2 *__kvm_get_supported_cpuid_entry(uint32_t function,
+									     uint32_t index)
 {
 	return get_cpuid_entry(kvm_get_supported_cpuid(), function, index);
 }
 
 static inline const struct kvm_cpuid_entry2 *kvm_get_supported_cpuid_entry(uint32_t function)
 {
-	return kvm_get_supported_cpuid_index(function, 0);
+	return __kvm_get_supported_cpuid_entry(function, 0);
 }
 
 uint64_t vcpu_get_msr(struct kvm_vcpu *vcpu, uint64_t msr_index);
-- 
2.36.1.255.ge46751e96f-goog

