Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07966465387
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 18:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351692AbhLARHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 12:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238178AbhLARHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 12:07:44 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A29BC061748
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 09:04:23 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id y141-20020a1c7d93000000b0033c2ae3583fso12561730wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 09:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5u4bcd8p5lWhOh9Twmw6ckk6rlz/H+k7Di86Nv+W7y0=;
        b=c2jCqyYJWi6j0q+TdDuz84phld5+VtSpY4m7fhUMjwZLascGKc4969abcgbluEB/Ze
         h/sY9sRt4zD8i/w/dPj//QCFbZ71q4VJxjSfwZNtAByXbmjpRHJ+yOLVXEcfb6s9kZIH
         NnaaFE1z0Ehl4VNNXPMVWuvl102KADwuQxFHzKv2d2JeQSOYpIVIs1BlfbuuZmb857DQ
         r30VAksuJc/Cbj3iGu3aZe7i20L+ENRdWzTjRz5xtASwajdp145hE153kJaS7HGrgjxj
         8SIhH82RSlvwXFa2KohYPvS1mvjQCVQPZ51hqOt61AfOjEwOtzTvnuVJWbZIxCVcSEw1
         GHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5u4bcd8p5lWhOh9Twmw6ckk6rlz/H+k7Di86Nv+W7y0=;
        b=xzf+ynkVHAxP5KnZvPyaGW9u2ycmadXTYFCjPZjyNm6ItkYrArHz/CzxNgkfu4cz1H
         KCKKTRLXqbwhlxXGBPMgqNanXB/FZEknpXfc2KSgLCXEXuSlI+WP+5klbxJHDcAzqe6N
         ncWl3M4v+cT9YM0KwIjVFKcPvIbwKta42mGmNre3WePJmoAeadaYXYYFlMPAEMRGUbgb
         27gEeBuM7pyBIDB6pMq3+XYZpU6g+MMkCMSTLqAZXLWpRAqrss+Yeciu7+DB7UDqMZZ6
         2dTAKU7OZLuZiBX6sQWYyPFvgy0b/GZcgFIz10A6GCXHf/u6Ljy4OqrN4XXs5SKgII9b
         oYQg==
X-Gm-Message-State: AOAM530xq9CxheIzD4t9hwTtwI0spk+nU3fW7Yf//RKNJKAjqjli1v8E
        Caxk1LtG8T3RZPSV9Zq+VrTq3i+5509t
X-Google-Smtp-Source: ABdhPJz8KqUSlppvt5PWeoeu8pXK06/96X8A4lVCiTuTfHGPzga9ENc8lxXkM7E2YtzgjN+WEGl+8JdtGsxP
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:1cab:1a20:2ef1:ddde])
 (user=qperret job=sendgmr) by 2002:a05:6000:23a:: with SMTP id
 l26mr8091897wrz.215.1638378261551; Wed, 01 Dec 2021 09:04:21 -0800 (PST)
Date:   Wed,  1 Dec 2021 17:03:56 +0000
In-Reply-To: <20211201170411.1561936-1-qperret@google.com>
Message-Id: <20211201170411.1561936-3-qperret@google.com>
Mime-Version: 1.0
References: <20211201170411.1561936-1-qperret@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v3 02/15] KVM: arm64: Provide {get,put}_page() stubs for early
 hyp allocator
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

In nVHE protected mode, the EL2 code uses a temporary allocator during
boot while re-creating its stage-1 page-table. Unfortunately, the
hyp_vmmemap is not ready to use at this stage, so refcounting pages
is not possible. That is not currently a problem because hyp stage-1
mappings are never removed, which implies refcounting of page-table
pages is unnecessary.

In preparation for allowing hypervisor stage-1 mappings to be removed,
provide stub implementations for {get,put}_page() in the early allocator.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/nvhe/early_alloc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/early_alloc.c b/arch/arm64/kvm/hyp/nvhe/early_alloc.c
index 1306c430ab87..00de04153cc6 100644
--- a/arch/arm64/kvm/hyp/nvhe/early_alloc.c
+++ b/arch/arm64/kvm/hyp/nvhe/early_alloc.c
@@ -43,6 +43,9 @@ void *hyp_early_alloc_page(void *arg)
 	return hyp_early_alloc_contig(1);
 }
 
+static void hyp_early_alloc_get_page(void *addr) { }
+static void hyp_early_alloc_put_page(void *addr) { }
+
 void hyp_early_alloc_init(void *virt, unsigned long size)
 {
 	base = cur = (unsigned long)virt;
@@ -51,4 +54,6 @@ void hyp_early_alloc_init(void *virt, unsigned long size)
 	hyp_early_alloc_mm_ops.zalloc_page = hyp_early_alloc_page;
 	hyp_early_alloc_mm_ops.phys_to_virt = hyp_phys_to_virt;
 	hyp_early_alloc_mm_ops.virt_to_phys = hyp_virt_to_phys;
+	hyp_early_alloc_mm_ops.get_page = hyp_early_alloc_get_page;
+	hyp_early_alloc_mm_ops.put_page = hyp_early_alloc_put_page;
 }
-- 
2.34.0.rc2.393.gf8c9666880-goog

