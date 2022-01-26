Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C36E49D1D6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 19:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244226AbiAZSgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 13:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiAZSgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 13:36:41 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681BBC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 10:36:41 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id k9so612958qvv.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 10:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=gwQJ38KtV0HXsmYJc+K1cECJTZ3g+2Vx7ehA2fokXc0=;
        b=QcWdQlJI68RhXl0oTXAQOXqwPV7EOeuJVrY/beLTxsFBpQZ/nyKXBBMIIRIxp3UZb6
         RE0qIRmmDPvKHGdBBPccD0mrIgW7zATHPRADWCTEb7XaEUGVnBm9GJfhl8LYGahP8bRU
         habISB7anoDtdxvsn9BMFWlNI/HO3zm4p1rtKlge3r3TqmSlDKaEnx/0D1getJ3c1I80
         z0cbTvjVWolLQAkLRBL3tcgH38g6KeNmYOxgMgSytQ4Hklca1ZLKBTHYgpWiWTLjQKh2
         lz0Hk2/F2AzAgIWChOtEJStlib6W2XqYpPkdHK/penKyAh12R+x6E1iZ8reMOKdyS5NP
         BhHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gwQJ38KtV0HXsmYJc+K1cECJTZ3g+2Vx7ehA2fokXc0=;
        b=XMJGImYSlD/xULzUiGI5B7qv7KEl7nI9v+ZzajKvIT6dtDZZ7CMWisajnO9gMUVT2T
         /h/Eskl8k/ZlF1CJtsOac6phnTsPVnkm3GSoA62xFZ0VdtazUr7vrBch632wxBmuOZa6
         tmY9xZ3S4e3IVd62UXElRHzqTagnoJyN25ARLLDEAf3AJTjT7NRSDpGmyy3DOttG0Afh
         O7TbmkOSf/U6ink4hXTn67xnIeMepRJNGurzJI5e6cmeQh9sOnAeVYFZOgjNYy8F+Ej6
         03KlekXYcMnnsmI8x7fWbYgF8b1cUhM6z5KbpUhIT66EjgTvVWMSz2sCk1UxS1SBQfff
         /rtA==
X-Gm-Message-State: AOAM530HXeiXi5rf7t8cQLeLcCBwflQOaxJEkNjPS08VK0hnfORdcFjK
        QSBlmtKLipItKhpIs8hEG2423A==
X-Google-Smtp-Source: ABdhPJzHYYWtkn3tMOAcHosHOkT8eLk8rK3linsKwbJSVMvq/WP3ZiLoTcazMadoRkZvSZnoFSFZPQ==
X-Received: by 2002:a05:6214:2a83:: with SMTP id jr3mr32858qvb.68.1643222200531;
        Wed, 26 Jan 2022 10:36:40 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id h9sm26226qkp.75.2022.01.26.10.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 10:36:40 -0800 (PST)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, rientjes@google.com,
        pjt@google.com, weixugc@google.com, gthelen@google.com,
        mingo@redhat.com, will@kernel.org, rppt@kernel.org,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        aneesh.kumar@linux.ibm.com, jirislaby@kernel.org,
        songmuchun@bytedance.com, qydwhotmail@gmail.com, hughd@google.com,
        ziy@nvidia.com, anshuman.khandual@arm.com
Subject: [PATCH v4 1/4] mm/debug_vm_pgtable: remove pte entry from the page table
Date:   Wed, 26 Jan 2022 18:36:34 +0000
Message-Id: <20220126183637.1840960-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220126183637.1840960-1-pasha.tatashin@soleen.com>
References: <20220126183637.1840960-1-pasha.tatashin@soleen.com>
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
Cc: stable@vger.kernel.org # 5.9+

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Tested-by: Zi Yan <ziy@nvidia.com>
Acked-by: David Rientjes <rientjes@google.com>
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

