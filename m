Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47DCB475D11
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhLOQMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235195AbhLOQMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:12:41 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46041C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 08:12:41 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id b1-20020a5d6341000000b001901ddd352eso6077575wrw.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 08:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fvU+rTfQGDk/gMHRwZZK2xJ4BmIbr82Ki0zdjrAMtH4=;
        b=AxcI0U50LP9UI1+U6aOTK66BaZ96AYCpHcns6c3HEWlsvGT1zuytPudhyifTcoMOiq
         DPjRsJ8EPAtn3WqwwehTKtW49jhvWcmbWpMjuhj4lChFaY+4eHGWGF+msFaGFQDcpey5
         Owg7nJu4brk8wWyQ/BEFnhUQ90S3+rhrmvsZKXEpRU+8ZMgJwh95rH+r4vl2LygP2nhg
         m6201P1jNhZDkNAPtqCCFxk+w1/E3EDmIKqw397DawYopi8bxuv0nQi7GzuYgxrsQBHL
         zyS7w8OBi4L761ZlPheYjDM/ecN8KlHjek8Q1doEoaGdBdB1ImjjD3szz4rf60dtzjbX
         X0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fvU+rTfQGDk/gMHRwZZK2xJ4BmIbr82Ki0zdjrAMtH4=;
        b=NkRCXM6dvhaJXO4YJ5eOCRdzdRmGDMnRTrEPJrMjtztSdmFSg1fYTqDQkhLsbMnc/D
         HfZ9QJDPvL28MYEsu0C1U9G5jxB2mcqE4J11EZ6c0tmd+X0p9lfm+FLzYkxi4Ncl2yaB
         BPIdWfSLs1osb1+UkxXrHJG1yyHHOkj41Nt1eSVnIfbgVRSWeKsx16DkVCV3N5UakYT0
         0KyddLqSSht6YuSyFk30opZTlLm/1CshLH8yw0An0SkkLBgHvCa9dPR9xiABDIRk/0JL
         4IZn5sGcSYGyhEoCtynaJ0GgUs5t+0KsS07mOh/VIuAvyvrkwFbkmKNyhyDwGeVx64Xm
         hkkA==
X-Gm-Message-State: AOAM533zxEbVXsBCK3WkidBM4AhuyMbrnoeu5BYw8zfSq1WB5O5pwN6q
        PyMuX/6ISAZR0Tc3W8JE9UVcCVNIlkwu
X-Google-Smtp-Source: ABdhPJz9PeDSGMeEeP45N6lCRrahlctgvXx61iiSgCOtuaYTTEOCxJ3rRff8XyoyZ6cRaw8FkQLTvH91J/YB
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:fc03:4f5b:4e9b:3ec1])
 (user=qperret job=sendgmr) by 2002:a05:600c:4104:: with SMTP id
 j4mr535325wmi.178.1639584759689; Wed, 15 Dec 2021 08:12:39 -0800 (PST)
Date:   Wed, 15 Dec 2021 16:12:18 +0000
In-Reply-To: <20211215161232.1480836-1-qperret@google.com>
Message-Id: <20211215161232.1480836-2-qperret@google.com>
Mime-Version: 1.0
References: <20211215161232.1480836-1-qperret@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v4 01/14] KVM: arm64: Provide {get,put}_page() stubs for early
 hyp allocator
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

In nVHE protected mode, the EL2 code uses a temporary allocator during
boot while re-creating its stage-1 page-table. Unfortunately, the
hyp_vmmemap is not ready to use at this stage, so refcounting pages
is not possible. That is not currently a problem because hyp stage-1
mappings are never removed, which implies refcounting of page-table
pages is unnecessary.

In preparation for allowing hypervisor stage-1 mappings to be removed,
provide stub implementations for {get,put}_page() in the early allocator.

Acked-by: Will Deacon <will@kernel.org>
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
2.34.1.173.g76aa8bc2d0-goog

