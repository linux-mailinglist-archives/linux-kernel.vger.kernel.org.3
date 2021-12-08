Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA01646D6E9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 16:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236029AbhLHP06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 10:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236085AbhLHP0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 10:26:54 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73674C061B38
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 07:23:19 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id j71-20020a1c234a000000b00342f418ae7cso3185260wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 07:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cuQE0YW8UdMGW3rLCo6CNfwjy36MSIxkvZOeV47gVAQ=;
        b=KUpsl8OdrXa2TfNhJOIs3W3KwuQrGlRyqmoXmUyaJ/yuu4HpfU1Kh6qBx0/DO5VGCW
         30J/V6mtYiRAmcRHM+mRVJum30AGeDLlvKOpqxYp+Jet7qFJJ1RdoNIVvktcVDiLDpqZ
         ehHF9n08W/1YSh/QKI1PIfTOx8lNeNdWFZqFuHY4IbZYhDWrHvWxvuQ+m8SLOOOKopWV
         Uch7He8l5dVKPrpUzYaPboYyMT/+vk2ZeR+zmJn7QZvuOWKOuoJdoYS5ptXP4LyB1l/u
         sS5qgHeFSbCTheo3xIpypUgjz9uCkJAgxoYl5uOx5eSw/hZ/dtcTXVGboSUwYK26WUuE
         AqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cuQE0YW8UdMGW3rLCo6CNfwjy36MSIxkvZOeV47gVAQ=;
        b=hA6J1SQ5vQZFBUBTgI6L0UhUuTZ+qIQ5wX9C3keNogVIDCt+JNm3Jjw/Y2HkNXtSkx
         fG9uouhHeFW9RnY/Dq+f9YK/ybQq6VgDaG+1VuxT++oQ0+Fs1t1X2wv8+YzMKq9D/jX1
         eFPYsbEU5z+5yUnHvOMxWTBoBJ/n3krIdzf1EGL/vzr/BQmE0aRbofOd8Gx2G6c4rvjH
         LxnRZiW609/hAnkEU2Km0X4/uby+6aslqxKNSgil3o6D7GK+5jaZW7CNQF8aEOlrdhb7
         I4frjEPebqHi5wywKDCG28uOLJGfXraPo2k3szNDK3fd7OqPr/H9oC6iD2cX7ROZLJ2v
         vyDA==
X-Gm-Message-State: AOAM531lzNtJt6taSFJKEr+9KgcO4pmTeZM+Ixq9wS5QavWP5MCHKBfy
        80z+MnxUqj7T2loST+rFKdr0SJk7L67i
X-Google-Smtp-Source: ABdhPJxGsSBocOeLXiSRK4wTT3nM6evq9+M4+nial4TaliEuNBrySS5ScIR8zMauErKeWzLKuaryRYic2Qfw
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:c718:14b8:982a:57d5])
 (user=qperret job=sendgmr) by 2002:a05:600c:3506:: with SMTP id
 h6mr16840889wmq.122.1638976997976; Wed, 08 Dec 2021 07:23:17 -0800 (PST)
Date:   Wed,  8 Dec 2021 15:22:58 +0000
In-Reply-To: <20211208152300.2478542-1-qperret@google.com>
Message-Id: <20211208152300.2478542-6-qperret@google.com>
Mime-Version: 1.0
References: <20211208152300.2478542-1-qperret@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH 5/6] KVM: arm64: pkvm: Stub io map functions
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that GICv2 is disabled in nVHE protected mode there should be no
other reason for the host to use create_hyp_io_mappings() or
kvm_phys_addr_ioremap(). Add sanity checks to make sure that assumption
remains true looking forward.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/mmu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 326cdfec74a1..605c104eb030 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -407,6 +407,9 @@ int create_hyp_io_mappings(phys_addr_t phys_addr, size_t size,
 	unsigned long addr;
 	int ret;
 
+	if (is_protected_kvm_enabled())
+		return -EPERM;
+
 	*kaddr = ioremap(phys_addr, size);
 	if (!*kaddr)
 		return -ENOMEM;
@@ -650,6 +653,9 @@ int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
 				     KVM_PGTABLE_PROT_R |
 				     (writable ? KVM_PGTABLE_PROT_W : 0);
 
+	if (is_protected_kvm_enabled())
+		return -EPERM;
+
 	size += offset_in_page(guest_ipa);
 	guest_ipa &= PAGE_MASK;
 
-- 
2.34.1.400.ga245620fadb-goog

