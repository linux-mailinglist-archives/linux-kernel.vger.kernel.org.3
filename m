Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96EAF49466B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 05:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358470AbiATEZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 23:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358456AbiATEZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 23:25:18 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0318DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 20:25:18 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id c19so4310928qtx.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 20:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BRQvkyJfLwToXuPc9CF9KmCDMc31zinjyrsWOern8Tg=;
        b=nJDYI+ciV99Z/2F42EEsoomiaC+ya+hPY7wXcTLaV8orJZZj9z3SMp/plXHCWl5cS1
         CjalBl/ubSwiXr07vJolWHPVQsCQxXmvj7C9W4XP4ZKfKKvPlFdnmmyrkA6tSHcWFUwt
         +lqzXkTC/TqMCbCJ30bsNb+vs9/4Jz/LSZsutlbldHGW3bNNjJD/M1DCsO0d9IJvSKg7
         nK5WnQ/nOaERaP9v3ERmIwRCacKEiK0XayC8pzXoHN9cwj8fLscp5sAVzEeciyBkD+F0
         xyYG9r3oxse8h/o6fEtLDgoYwtzVmiUcgRmx41gp5q9hXwb1tUxW4UJn3QOtC5HZwuhg
         prCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BRQvkyJfLwToXuPc9CF9KmCDMc31zinjyrsWOern8Tg=;
        b=AzCCwELAYBm2nHBcDhVZbUTtYfvupM+vPiQPSaSBRe3Rz1TH9RmSBJE76nqiV49QzG
         /dGoGoJqdmU9qXzzO3UAZ3ZUSa95KbVpiQ5X9Rcbgf+0C+njpuqbeq4To20BuDZqeN80
         E4Ugv7cHiX490fotiXRaQa+v84DoEcYSQ8+DXxhn7G1LKa8o/gY0pVGx7eenfoDJe8t2
         pIJb8LEouqqGxictoe+Wyp42XVbOJpNX/rxGWWwrbxjVz2o4Z2W0hg3aA4Aqyy9IaoN1
         rYBsUHPcZArLBTeLHGDZfzHHf73OCDyHU6DDn2zbApXWnPt5mpj05tyNwXXXJCa8xLq+
         +u2g==
X-Gm-Message-State: AOAM532+i69EMEyaVrKM1ElcZJtIo8aI5ihAhIbNTtMw6B5ocfVJicOi
        qQejT4bbSRichnukDwv8tum9yQ==
X-Google-Smtp-Source: ABdhPJwPUQaGDfTZBgEZrsyNqiqF3s5J39OTgoUAisRbJTqg5M+ibUW/EknbldLh2q9bXECqc7BGFA==
X-Received: by 2002:a05:622a:3cd:: with SMTP id k13mr14439260qtx.458.1642652717142;
        Wed, 19 Jan 2022 20:25:17 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id n22sm927228qka.46.2022.01.19.20.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 20:25:16 -0800 (PST)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, rientjes@google.com,
        pjt@google.com, weixugc@google.com, gthelen@google.com,
        mingo@redhat.com, will@kernel.org, rppt@kernel.org,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        aneesh.kumar@linux.ibm.com, jirislaby@kernel.org,
        songmuchun@bytedance.com, qydwhotmail@gmail.com, hughd@google.com,
        ziy@nvidia.com, anshuman.khandual@arm.com
Subject: [PATCH 1/3] mm/debug_vm_pgtable: remove pte entry from the page table
Date:   Thu, 20 Jan 2022 04:25:11 +0000
Message-Id: <20220120042513.1648831-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
In-Reply-To: <20220120042513.1648831-1-pasha.tatashin@soleen.com>
References: <20220120042513.1648831-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pte entry that is used in pte_advanced_tests() is never removed from
the page table at the end of the test.

The issue is detected by page_table_check, to repro compile kernel with
the following configs:

CONFIG_DEBUG_VM_PGTABLE=y
CONFIG_PAGE_TABLE_CHECK=y
CONFIG_PAGE_TABLE_CHECK_ENFORCED=y

During the boot the following BUG is printed:

[    7.483050][    T1] debug_vm_pgtable: [debug_vm_pgtable         ]:
Validating architecture page tabs
[    7.490930][    T1] ------------[ cut here ]------------
[    7.494926][    T1] kernel BUG at mm/page_table_check.c:194!
[    7.499172][    T1] invalid opcode: 0000 [#1] PREEMPT SMP KASAN
[    7.503610][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.16.0+
[    7.508600][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX,
...

The entry should be properly removed from the page table before the page
is released to the free list.

Fixes: a5c3b9ffb0f4 ("mm/debug_vm_pgtable: add tests validating advanced arch page table helpers")

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 mm/debug_vm_pgtable.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index a7ac97c76762..f7c5970f1719 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -171,6 +171,7 @@ static void __init pte_advanced_tests(struct pgtable_debug_args *args)
 	ptep_test_and_clear_young(args->vma, args->vaddr, args->ptep);
 	pte = ptep_get(args->ptep);
 	WARN_ON(pte_young(pte));
+	ptep_get_and_clear_full(args->mm, args->vaddr, args->ptep, 1);
 }
 
 static void __init pte_savedwrite_tests(struct pgtable_debug_args *args)
-- 
2.34.1.703.g22d0c6ccf7-goog

