Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA7D49C371
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 07:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234783AbiAZGFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 01:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234641AbiAZGFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 01:05:19 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4056C061744
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 22:05:18 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id e20so19854030qvu.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 22:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=aWNRX9QsBPHLZOFVrwNXiWXc+ZQSkTRboCbVzmJISWM=;
        b=LlMcMekRBawFA/p+rIOXAZAiAa1k3SdlK7Hkpzh6hMhMDHMLaRQKA8ML9fwHV6llAJ
         Bdxeiz9HYmUpAchr0GfAWwJBjAWkCI7hp2dT6wD+ckNBhnwWq6ACHfH7aUSgQdr2rkI6
         mpHA6t/nLQ+gI7EEx382Dl6maFaESiD2TqeWZhSl0Wp5MWF7QFaUj2Mq/Xv0SxWLoibg
         4/IQbSGz3QzAafFPlJu6lx2YmPs8ClFWtFFBtMKmssnPMca5EWGQVPAvZhtySQ4pIdN/
         28UuDSoc27Z6S7UpTlIDARr3keJuGWON+9QTLfGn8icD8SJS61b3RMeKZK/dfDT8mLNu
         9KFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aWNRX9QsBPHLZOFVrwNXiWXc+ZQSkTRboCbVzmJISWM=;
        b=sZ/qPIujAe/C3wXJ4knTb8z1DZYZpWQR/ozmBAzzBohks3vlHMjj9Nd1AIePFaGgCK
         GRy9o/PFjti5vpa3aBPg2Zkd7+LI1s1S+g3XQ5w5cgmYU/tnl799E3xdNEyq5dXqwcFN
         lcYktp+pbWpvsn+lgEv4adfRk44uqFIrbN0dytprSZs3OtDAyWTS/6YYAgTfOclw8jj2
         /OE7yGNukrp18cnzylVnpi9M4HR4HwEC5o+Pv0bSjkEL/ab0ymjJVjM/vtj4Ua6Pizqy
         mX0PsWjcVZZLCwPtSxOfL/bTtFhhvIVZ9Q18kTbsomekG5VrtD0GwY2OkcJm5oHE/Mbh
         QJAg==
X-Gm-Message-State: AOAM530V8+NvGbvojvB31UC3A8xUr6vE8gUz0pt/ty21TEoQ+26MbiZh
        f113gIyHgdU61R/KxbsEpSFv8A==
X-Google-Smtp-Source: ABdhPJwVByTrnm101Bf8YAmr4+nFjtChqbu8bu6/f6QCYcLdWej0+Cltb2+DvquGjJnoBQkLcKwHiA==
X-Received: by 2002:a05:6214:1cca:: with SMTP id g10mr22397753qvd.36.1643177118106;
        Tue, 25 Jan 2022 22:05:18 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id o19sm9856699qta.40.2022.01.25.22.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 22:05:17 -0800 (PST)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, rientjes@google.com,
        pjt@google.com, weixugc@google.com, gthelen@google.com,
        mingo@redhat.com, will@kernel.org, rppt@kernel.org,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        aneesh.kumar@linux.ibm.com, jirislaby@kernel.org,
        songmuchun@bytedance.com, qydwhotmail@gmail.com, hughd@google.com,
        ziy@nvidia.com, anshuman.khandual@arm.com
Subject: [PATCH v3 1/4] mm/debug_vm_pgtable: remove pte entry from the page table
Date:   Wed, 26 Jan 2022 06:05:11 +0000
Message-Id: <20220126060514.1574935-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220126060514.1574935-1-pasha.tatashin@soleen.com>
References: <20220126060514.1574935-1-pasha.tatashin@soleen.com>
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

[    2.262821] debug_vm_pgtable: [debug_vm_pgtable         ]: Validating
               architecture page table helpers
[    2.276826] ------------[ cut here ]------------
[    2.280426] kernel BUG at mm/page_table_check.c:162!
[    2.284118] invalid opcode: 0000 [#1] PREEMPT SMP PTI
[    2.287787] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
               5.16.0-11413-g2c271fe77d52 #3
[    2.293226] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
               BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org
               04/01/2014
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
2.35.0.rc0.227.g00780c9af4-goog

