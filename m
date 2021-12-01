Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417FB46539B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 18:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351731AbhLARJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 12:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351696AbhLARIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 12:08:31 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538CCC0613DD
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 09:04:51 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id q17-20020adfcd91000000b0017bcb12ad4fso4466739wrj.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 09:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gP7Fa7oF1mk2VL/C80BdOcZ11ucSfvyvrK5tI2TJOao=;
        b=YIFEpSMiiphVp00kT4SqQiVFlCZjWeW7pHUFlPbzlz6LipVw2aWy7Rd6tb3JUzJM+3
         QKIISnMlREKuRhzWfT+DUQt86OHAlAejeH8a+q5aOiFs7nF9U2+bewCuES5TKaRshu2s
         qH0lsFmh+oO1cw1jDqXHNIc8iZWQ2FkeeVNPRVURvz8RBrMKrSNdu28aFetakrGmqP//
         ult2AtCbkCkC9p4XjEbc6jcacWZURDLmr7Iv9xCzICqAYxduRH8LXhXBrpLmELev6Puf
         5SG+5mVlcaSiNM5tx0UO0lC2C2y3/Zrd77xHXrAIHeEj5kfiRwqdzDjzXaSZxaueQr4u
         SamA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gP7Fa7oF1mk2VL/C80BdOcZ11ucSfvyvrK5tI2TJOao=;
        b=vbqsiHCegJs2yhf+eqV/3g27+zZtmuJvjUogUnPNAFRAQrypgAwliwASifReM3hk85
         h0C3b1nkjPizq38SPZGVFDK5EqLKPmYzR+WP83JxzvoffPAAqbz+EPs8vYU14fUHPgGq
         0/J1g245dq1+AtoBCKrkEY8eVIYTYDT8uwBqvFFFudMgEHiCZrjEGzmdswOcU+0h+rWr
         xXN3VWRjN+2GqrJeenFc6Xfz0nXNg+6zVm/2KhbXuZPDdnkjO3YyLJQ77XJZT8gwRLwW
         wWXcts9A5ZNJPTsYNq6GzbYFuFMnC0eVKDY+au2QBUR3GN4DEi/kBWeforof5m3auXXl
         6m/A==
X-Gm-Message-State: AOAM533wkfnAgKUUqEg3Q/Y+MyhIamN1FHlNgLiIKljj5pwSpkizmlK0
        t1bExrgcd3rZD1lZpGns1awyjUwwdxyr
X-Google-Smtp-Source: ABdhPJxYTjRVBjX0Rb9ACwgvUv8SYqRjTELJGdvUGk2ZT9j9VAZxKEYlzDVuho8VN54x8a7VK7k6aXTc82QW
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:1cab:1a20:2ef1:ddde])
 (user=qperret job=sendgmr) by 2002:a05:600c:354f:: with SMTP id
 i15mr8597282wmq.59.1638378289941; Wed, 01 Dec 2021 09:04:49 -0800 (PST)
Date:   Wed,  1 Dec 2021 17:04:03 +0000
In-Reply-To: <20211201170411.1561936-1-qperret@google.com>
Message-Id: <20211201170411.1561936-10-qperret@google.com>
Mime-Version: 1.0
References: <20211201170411.1561936-1-qperret@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v3 09/15] KVM: arm64: Extend pkvm_page_state enumeration to
 handle absent pages
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
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
2.34.0.rc2.393.gf8c9666880-goog

