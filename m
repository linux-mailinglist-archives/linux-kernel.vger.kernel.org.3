Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7974954A6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 20:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377412AbiATTM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 14:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236860AbiATTMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 14:12:55 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026AEC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 11:12:55 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id 15so7778734qvp.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 11:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ljRHzu8EIti/rwgbKsna6fOCiQbES3TZ5TTYfFv0egw=;
        b=FyNEAIm/3bE5CybyyukETOQ/BQa7EhXGoW8WaHTc5aG9OMBkNDJ0v0IxBNUDBn7JcJ
         qY/Fi2S4h5MYwXg4pELzsxmpyzOLEYq5cf2kR4ObXgaUcpEEl2M/8hR0/838NFa4RUSh
         WMTlEm+f/O2OesyO8SbAkTVyfRj1k0LXXgkfmAv2CLxhI/SCnWhAEE+c+pi15uDOQIs3
         ANyEOssIBASnEYRn3/chz8M8SCXLBshno7oN6a78RV+aHElzwXJ6zmpR+KJIcE4XkWl9
         egN5vg3Y9WPN//dCaL2OGEjhy1+Jc4eFmdmfTmJlVB7og/sM0WoHgVXCEne2nAaG44EU
         S1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ljRHzu8EIti/rwgbKsna6fOCiQbES3TZ5TTYfFv0egw=;
        b=drcYsaWogEGBzQBcHLIVfLjK0swGaLNYYy8We1laey86PSsVkZo1u6wxoN8RVfJoWv
         vuwc/PC5mgKcQP3HWthOdiXhTq1Mc4VbaCJH44EGJeADU1PL883jCpe68qVl+QjAOAA5
         R2EosrQempJGIPN5qfTQaj0uU3xI/eFqXYE0VqUtNpdyRYm7vMvqGZ4yRKQ6nuSptWW9
         y48zaGoE5I3TOFt2YsMPW9uSTgcRzvzSAY7HihBdM0g9ztdyvrHEl2zmQRUFGWzU3Ayd
         jVw00X8kj6Uab/l1OgWWoiiVRlz5E1zFQ9UB7rXid4J6yRFEM2JI1DJRXne6JQ5d2RnH
         /7xA==
X-Gm-Message-State: AOAM53145LAWvEQwqEGke14tilw4ZUmOf88uJQFpKxxJ+1TRwopvnShQ
        opo/M8jeiRnEE3BC08SYMuuKAw==
X-Google-Smtp-Source: ABdhPJy2i251uJu/EMC4DLi9WRnxHlaT88/Fup2DjBtaR+0+svTyX1C9lcQd1dHZttx5/jijgXaJNg==
X-Received: by 2002:a05:6214:20a4:: with SMTP id 4mr384015qvd.7.1642705974062;
        Thu, 20 Jan 2022 11:12:54 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id w1sm1822509qko.40.2022.01.20.11.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 11:12:53 -0800 (PST)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, rientjes@google.com,
        pjt@google.com, weixugc@google.com, gthelen@google.com,
        mingo@redhat.com, will@kernel.org, rppt@kernel.org,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        aneesh.kumar@linux.ibm.com, jirislaby@kernel.org,
        songmuchun@bytedance.com, qydwhotmail@gmail.com, hughd@google.com,
        ziy@nvidia.com, anshuman.khandual@arm.com
Subject: [PATCH v2 1/3] mm/debug_vm_pgtable: remove pte entry from the page table
Date:   Thu, 20 Jan 2022 19:12:48 +0000
Message-Id: <20220120191250.2671557-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
In-Reply-To: <20220120191250.2671557-1-pasha.tatashin@soleen.com>
References: <20220120191250.2671557-1-pasha.tatashin@soleen.com>
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
Reviewed-by: Zi Yan <ziy@nvidia.com>
Tested-by: Zi Yan <ziy@nvidia.com>
---
 mm/debug_vm_pgtable.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index a7ac97c76762..db2abd9e415b 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -171,6 +171,8 @@ static void __init pte_advanced_tests(struct pgtable_debug_args *args)
 	ptep_test_and_clear_young(args->vma, args->vaddr, args->ptep);
 	pte = ptep_get(args->ptep);
 	WARN_ON(pte_young(pte));
+
+	ptep_get_and_clear_full(args->mm, args->vaddr, args->ptep, 1);
 }
 
 static void __init pte_savedwrite_tests(struct pgtable_debug_args *args)
-- 
2.34.1.703.g22d0c6ccf7-goog

