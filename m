Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEF9475D14
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244616AbhLOQMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244608AbhLOQMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:12:54 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E09C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 08:12:53 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id k11-20020adfc70b000000b001a2333d9406so413613wrg.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 08:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MMV17RJGBqBIJSSqtbn1eP7i2KWhmG0Xg4IIILFGbk4=;
        b=TsX1J3w5V1i1HiSUsll+2W48tuChkMnwn+NtSsjIf5wMQ/88zmPZGculZ89WOyPr3y
         j7pfWDg3rD3EXldiIIgv8sTtXjmPWmn51rcw1Ws2CkNWVjJXW5VokmWSB1gwCxhyuMKM
         SUISMwNLFpghQZ4k/mzBK3Bq4d4t3/yH52+nPjJQ7j4y7zkpM0AnUwaMaAceawUvM6GI
         JOi+15VpsBSiAkh94aO7LxLWQaPi2fx8ajh9TuBtNOxv5QBBiWiQdfzxPYloLQh6qbQQ
         DRaNQ4HCuH9Ny/kX7+8XHgzmsXoKhF3r3Loka1NP2RKyZk8zSa4QplVyKQPCLZ64AhNE
         emhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MMV17RJGBqBIJSSqtbn1eP7i2KWhmG0Xg4IIILFGbk4=;
        b=ZcWZ5cBPs4SNmNN0OIFaKyF6bFxCOQvX2RN8hfL57Wx4nQ0i4yyEGYAoSWJ+PQO3rS
         /FxUzze+WQLBIFnmuasd06wCafSR9voC0e1HqO79Do8UTErbUcQ4Y4lgAXNyBRZHRPht
         z/+a8cBFLgHyJOAyPdjSde21lfQNHb1ODm4zJVVIzCHkB8pZYPwuyZnmLgYfbmfXgZUG
         WE5CdCD+05bXawb1UYDriQmbFUuVvDQuseCrV5mewwa93F1SV2hqGuHuktPFn/ffb0G9
         Q/aQIusRiogJcKh+4f48xr1R+d/pk7Jj3EtnGMJtiUVSYYCMCCFKz6p+u5bZnrX70H/D
         4tEw==
X-Gm-Message-State: AOAM531k3ItGVQbFaso+el3JlSEsDtH49pngyYUdrKnM/zUUltwkEZTc
        CL1XPuiG+rV4ecLSAdmSWov+0DOFazkp
X-Google-Smtp-Source: ABdhPJyfCs0Hha3nCPUt4YLDazw5cpbIxT+GVyubvLUpddKOfvogqT7sUw4CAzf8KJFy2IBZwJrNH4Y6lhHT
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:fc03:4f5b:4e9b:3ec1])
 (user=qperret job=sendgmr) by 2002:a5d:650f:: with SMTP id
 x15mr5133650wru.201.1639584772363; Wed, 15 Dec 2021 08:12:52 -0800 (PST)
Date:   Wed, 15 Dec 2021 16:12:21 +0000
In-Reply-To: <20211215161232.1480836-1-qperret@google.com>
Message-Id: <20211215161232.1480836-5-qperret@google.com>
Mime-Version: 1.0
References: <20211215161232.1480836-1-qperret@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v4 04/14] KVM: arm64: Hook up ->page_count() for hypervisor
 stage-1 page-table
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

kvm_pgtable_hyp_unmap() relies on the ->page_count() function callback
being provided by the memory-management operations for the page-table.

Wire up this callback for the hypervisor stage-1 page-table.

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/nvhe/setup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index ab44e004e6d3..27af337f9fea 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -258,6 +258,7 @@ void __noreturn __pkvm_init_finalise(void)
 		.virt_to_phys = hyp_virt_to_phys,
 		.get_page = hpool_get_page,
 		.put_page = hpool_put_page,
+		.page_count = hyp_page_count,
 	};
 	pkvm_pgtable.mm_ops = &pkvm_pgtable_mm_ops;
 
-- 
2.34.1.173.g76aa8bc2d0-goog

