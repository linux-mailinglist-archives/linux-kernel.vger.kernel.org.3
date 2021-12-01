Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2829E465397
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 18:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351709AbhLARIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 12:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351739AbhLARIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 12:08:18 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B978C061759
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 09:04:35 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id 144-20020a1c0496000000b003305ac0e03aso127504wme.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 09:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=R4aAsZuEycX7jTv8i7SIMGlzcxlZQ+O2BggkYaTuEjA=;
        b=plQ5ysBljc0xG5cfba5Qiw3VOO5L5djBwH2KOMSeq2bRcSiUiqowbYb2+TW5TZ1dcR
         cZWPWJlgzX7jmmLaQ4ByFFTPnDp+JrwbYmQ0pJu3qL0LL5Eo+xr1+5IlSuQo/beLH3qI
         JiGvDzHNZtcTCeCYXNMRt2Eu49Ss2ylezV25kVj0ijXktXiPryN7T1mPUMkDLUYRtoQ9
         g5ziLntuM1OC00Zp1xER7Mdxpwh5cZbTWq+fg+F47gsCCyqUZ4vYXt6mWjWGzETLnuhs
         TFuCujebbXw0EIIYAgEOWZZVUNMrvnHiz1yf1Alt6UryT32jt7vGzOKDYq+Al4/E+S/J
         tosQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=R4aAsZuEycX7jTv8i7SIMGlzcxlZQ+O2BggkYaTuEjA=;
        b=2p36J8ZrxuhrmIbHLJ99sI2fmCe6CbyR79z7+++EBP/lwkdaDciOoAmB9OgGwbeAXR
         TX9msr0sS17k+Wvsail5FkUlmKsHsJSUu7PuStzUdy/RhtDnyDhXg8R/YqLemKiv1uq6
         q/PP43HOctPCwb0J2y7cXXaUniQrFuzzgH2ATsi4mp8uSBy6HqftcTerSmE02+/5XVAa
         znXt9YvwT/scE6SzM3WtXoYgE3TAQ+qm/4oVS+Qe3fGLYG6y/aGZ/qOWYh7KJmkxItPx
         1a0JphBCpJMxf96/zld6BeclZvYy65Gq2Pe1wxQcvWwUdUuBdB//RsfPd3Z9U/xPJU8E
         2h7w==
X-Gm-Message-State: AOAM531tB6oXiHnx1dzgIq5+VBapJy7woTwKecOrKgOdq01gALINhPo4
        JJXWrBeEUKoR6hZiX6hO8GyLCIVRFLlY
X-Google-Smtp-Source: ABdhPJzQigV4hbaNpX4iucPZvGwYvAo/hfN1TJ3QONjwQcFMPn8kkHe0dIUY1NGAIghVVqO5zssHeXhuINPH
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:1cab:1a20:2ef1:ddde])
 (user=qperret job=sendgmr) by 2002:a05:600c:4e02:: with SMTP id
 b2mr8493849wmq.105.1638378273705; Wed, 01 Dec 2021 09:04:33 -0800 (PST)
Date:   Wed,  1 Dec 2021 17:03:59 +0000
In-Reply-To: <20211201170411.1561936-1-qperret@google.com>
Message-Id: <20211201170411.1561936-6-qperret@google.com>
Mime-Version: 1.0
References: <20211201170411.1561936-1-qperret@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v3 05/15] KVM: arm64: Hook up ->page_count() for hypervisor
 stage-1 page-table
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

kvm_pgtable_hyp_unmap() relies on the ->page_count() function callback
being provided by the memory-management operations for the page-table.

Wire up this callback for the hypervisor stage-1 page-table.

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/nvhe/setup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index 875b5174342f..855a19056627 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -257,6 +257,7 @@ void __noreturn __pkvm_init_finalise(void)
 		.virt_to_phys = hyp_virt_to_phys,
 		.get_page = hpool_get_page,
 		.put_page = hpool_put_page,
+		.page_count = hyp_page_count,
 	};
 	pkvm_pgtable.mm_ops = &pkvm_pgtable_mm_ops;
 
-- 
2.34.0.rc2.393.gf8c9666880-goog

