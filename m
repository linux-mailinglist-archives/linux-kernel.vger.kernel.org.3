Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA0CA475D19
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244619AbhLOQNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244609AbhLOQNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:13:11 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FD1C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 08:13:10 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id v62-20020a1cac41000000b0033719a1a714so12785441wme.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 08:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8rgSQfxqCRM7uaw93tRPVu2i1VyDlU+SgH6AjdwelFg=;
        b=oL/4mToqyjfnEM6iyT67/BqZZr2PNLhiYQmR5ckr4IxYAMm3DJ8qXK8tH50bG1H1m/
         vRkewaRsNmYjaDXv7YrXRz5/gziGd7MhVs8Mhinsx5SvjCflWGkam/TtMjX3Z++skB00
         mruR2m7aZDYO9w3PkO3k2QmQKHrfBeUsyKS4zwIOQ7k491fnzDsEEcIJ12VpQB8r32sY
         JygdFvcfEU4MjPLHsd4oSD1/xBooRBb9m7s7Tt5nyCGm3S7W3rsmxZr5xl6Dw832HU1d
         ZS1OMoGsa1TLOGXwEo3GKHhFA9Q7xYLD1FNoNEikntrurFNYroaXlmDvYvmz+Br7YqwS
         9OVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8rgSQfxqCRM7uaw93tRPVu2i1VyDlU+SgH6AjdwelFg=;
        b=ivf8H4liblrp+h7hCs9iVTckcu2VdNc3e8jWYL7WG7I5h0gXYamO159KPba2SW9LTH
         gCLT+DiGSlqXtrih42ToSLGmfzGhH0wXwrX++4GjhH1CiMKfiPQQZRgQW+Bp/LW+DArE
         5DGdnn/B3+/V2+fXYVsebC0wE1TPDjwXCqZzz8Pbg+rl8nWKDw/aSI5Hdc/waD0z8Sn4
         KsPzj/9YkadamZG9QO+SA/eUtYe+AkFfZ2jX+4GIbimfIgDB94z9T4AmSKDkhtNDywH3
         gs2fN99JsfZhD9Shv5kwyvTF3/KIA3B0DNlVMgWOd0Q/OGhJ/taZ9rjjyDhUc1LMR8Z6
         Fgvg==
X-Gm-Message-State: AOAM532lYF9LvF8AtSGq4bVsgbc93TTl/ErhBoNEm+QS1wncKP78qHTf
        tnLV8u3RypqxBxsZjefjlG2GEmPc4cNy
X-Google-Smtp-Source: ABdhPJxXvEycf99ECGUzXgk4Cq7sONC0HLtF5x7Y6YaPQ6+CwNHwdN/fgrDRTjcwDTjmSjH4G+ePR4js0bD1
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:fc03:4f5b:4e9b:3ec1])
 (user=qperret job=sendgmr) by 2002:a05:6000:168e:: with SMTP id
 y14mr4991297wrd.331.1639584789556; Wed, 15 Dec 2021 08:13:09 -0800 (PST)
Date:   Wed, 15 Dec 2021 16:12:25 +0000
In-Reply-To: <20211215161232.1480836-1-qperret@google.com>
Message-Id: <20211215161232.1480836-9-qperret@google.com>
Mime-Version: 1.0
References: <20211215161232.1480836-1-qperret@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v4 08/14] KVM: arm64: Extend pkvm_page_state enumeration to
 handle absent pages
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     qperret@google.com, qwandor@google.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will@kernel.org>

Explicitly name the combination of SW0 | SW1 as reserved in the pte and
introduce a new PKVM_NOPAGE meta-state which, although not directly
stored in the software bits of the pte, can be used to represent an
entry for which there is no underlying page. This is distinct from an
invalid pte, as stage-2 identity mappings for the host are created
lazily and so an invalid pte there is the same as a valid mapping for
the purposes of ownership information.

This state will be used for permission checking during page transitions
in later patches.

Reviewed-by: Andrew Walbran <qwandor@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index b58c910babaf..56445586c755 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -24,6 +24,11 @@ enum pkvm_page_state {
 	PKVM_PAGE_OWNED			= 0ULL,
 	PKVM_PAGE_SHARED_OWNED		= KVM_PGTABLE_PROT_SW0,
 	PKVM_PAGE_SHARED_BORROWED	= KVM_PGTABLE_PROT_SW1,
+	__PKVM_PAGE_RESERVED		= KVM_PGTABLE_PROT_SW0 |
+					  KVM_PGTABLE_PROT_SW1,
+
+	/* Meta-states which aren't encoded directly in the PTE's SW bits */
+	PKVM_NOPAGE,
 };
 
 #define PKVM_PAGE_STATE_PROT_MASK	(KVM_PGTABLE_PROT_SW0 | KVM_PGTABLE_PROT_SW1)
-- 
2.34.1.173.g76aa8bc2d0-goog

