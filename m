Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC454A502B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 21:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378863AbiAaUc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 15:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiAaUcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 15:32:55 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486B8C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 12:32:55 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id b22so13183715qkk.12
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 12:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+b2VDnizluGVh9+la/y+t/dAo3W53LzEqz2Kl5SWq3M=;
        b=YngBIjjb/nHQSRa+qiaFZjTH9m/x8VBAIf2kGQ32pwNNBHyLxbRoo3ZxdB+I+6Oroe
         8As6fNzzko3D/+CepuYqaHnseC9dE4lJZHAKbOeGxwlM3VV2+NEqYRGq7EZKMx/KFChK
         FWgvvuxmkldI3pOZosmJ7ktVltjev2UMC+qOgyGSEj/dvYjxGHoenQrLZTuXY+MqxtQH
         G6VqMbiuCYFjJS9Xi9jOPxvLuRc1K4fTP7k8ursBzujYyJxREZFkqCIw5YzvxtROhWa+
         AMQF60zVFOrek/a1GrwkxGd6/H7mpiu0H/vGg0l1ymArsRf8Oa0L8c5Ja5h7C2lnZ8RV
         I4Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+b2VDnizluGVh9+la/y+t/dAo3W53LzEqz2Kl5SWq3M=;
        b=w7aauq+O6+Q7UdyyewXTnN85LTkpfvpWclm0XejKIRkIZg/SFhgWd8obc0DTrr2XTE
         n9cowKR6OdTAD5Pxcdz4aI5YL5WVkJFYYL7eBSAPRrsniXnxSpkWvf6QBtH9g1URe56S
         MHWgLrmat2oy9ZQ8QiAZbX0mKshl1fQxBmvv1HKpb2WjgmN+rLtOIaQy5xkxF2r03Z7v
         wal21JOl56+V59cRjDnVl8/ymWImb5WvCtaAZkA51pIjW9vIyA28GEVtcSiCD1xjKNy5
         B2hCALUH590qT2Zw17+LNhy9goto/hPeZL/Vp0BHWvpX7vd/bExaE9aGud41K702RXUd
         1aOg==
X-Gm-Message-State: AOAM530ejJar9TGmfcJZAcdsjFpOjCi5c3pxkrH21SOEt0YOqGyBFp0S
        gmX4SJs/7WtJ2AFJviqzFtn5FQ==
X-Google-Smtp-Source: ABdhPJzfANMgqiVqJGB+ggntyJhpzn27PcIgePLyPDDStslF+pnhqRXRQJMP/Ar96PUQKuG6r8ktmQ==
X-Received: by 2002:a37:aa08:: with SMTP id t8mr14647255qke.773.1643661174408;
        Mon, 31 Jan 2022 12:32:54 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id j14sm5349661qko.10.2022.01.31.12.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 12:32:53 -0800 (PST)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, rientjes@google.com,
        pjt@google.com, weixugc@google.com, gthelen@google.com,
        mingo@redhat.com, will@kernel.org, rppt@kernel.org,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        aneesh.kumar@linux.ibm.com, jirislaby@kernel.org,
        songmuchun@bytedance.com, qydwhotmail@gmail.com, hughd@google.com,
        ziy@nvidia.com, anshuman.khandual@arm.com
Subject: [PATCH v5 1/4] mm/debug_vm_pgtable: remove pte entry from the page table
Date:   Mon, 31 Jan 2022 20:32:46 +0000
Message-Id: <20220131203249.2832273-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
In-Reply-To: <20220131203249.2832273-1-pasha.tatashin@soleen.com>
References: <20220131203249.2832273-1-pasha.tatashin@soleen.com>
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
2.35.0.rc2.247.g8bbb082509-goog

