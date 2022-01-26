Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943B649C397
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 07:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235567AbiAZG1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 01:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiAZG1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 01:27:02 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E729BC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 22:27:01 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id r59so4513643pjg.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 22:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=4zyPGEnkuHJKifjf7+q3y5kxxUsYi5MCYiNkS7tD/sM=;
        b=FBhdu+gTKZSogAg+WMvwpo84x38k8zLZaxsI7tpU0GlGGqqvYHZ/fDGbO0PBh0moYP
         CJgAmJVhMkZwpHUnVVB8FlGraoUPX6OJ+UpbBR05Q0RvT1ROxpTWzmujYaggmwMZFGrG
         7hoL5w87cfcVNIHMpnkl1uyKNdZqr167GVY6gXe/saZZ6OQuTfF4P73ux9A2oVjal05c
         yGv8IwtZcoY7R50fuieOQxLMlvaKRUuJlR+IJG48cx5MpIZorxLPKAXG4o20cYOAJHsY
         NT4ZVCYfHVF5uWp8BqlGHuV+wyRlAFBqJXGnOlcgkuAsIJjRf1rn4VSI6BUQIZVS1JBy
         neWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=4zyPGEnkuHJKifjf7+q3y5kxxUsYi5MCYiNkS7tD/sM=;
        b=BqGyZLLNYylcW14mY1SeIPVjpA50jXn4c2fn3jFPySDT24Q01bt8QyYT9rYAb+H9Dr
         /11ynEn2SiMR6tPHEAo9Scl6VFrwqT5KgLZnGmvh8pqcmm8W1ZeYuyM03pfxE4ApIj6R
         32/7KbxhboftYtIs1ROl6qqwz1CFP+Q6uPmmsRdfGF9CndjsTyq1UKFoLAS8mf2O0kzm
         jkEeti0/W6yP3GKpXS6ehib9hKOTUseDWS/VxXsRMPzsoBfB87D+RAG83Q/OgRHqgJUS
         xVWNhojMrJnjHm50XF2FIX3wSGQnEyBo7cJomyPzD68GHH9f9XIFN8rh4OhJL/XVzc0u
         GMhQ==
X-Gm-Message-State: AOAM531+00w4XQFO2pqKfUrKqJkOThcCV+8VCI0ZCoDQcRSCKrixxMa1
        kQIKqu5Qhu30phOnMhAyR/J1VEjHPyW8rg==
X-Google-Smtp-Source: ABdhPJxxp35pbgBAgHKQA7nywFgaXe21YovBNcc5sbpsGwd2ZRExSp78ioecdrSZPUsjrJ8pmQtQfg==
X-Received: by 2002:a17:90a:d913:: with SMTP id c19mr7269284pjv.72.1643178421144;
        Tue, 25 Jan 2022 22:27:01 -0800 (PST)
Received: from [2620:15c:29:204:6f7a:fc02:d37c:a8b0] ([2620:15c:29:204:6f7a:fc02:d37c:a8b0])
        by smtp.gmail.com with ESMTPSA id f6sm904718pfv.48.2022.01.25.22.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 22:27:00 -0800 (PST)
Date:   Tue, 25 Jan 2022 22:26:59 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, pjt@google.com, weixugc@google.com,
        gthelen@google.com, mingo@redhat.com, will@kernel.org,
        rppt@kernel.org, dave.hansen@linux.intel.com, hpa@zytor.com,
        aneesh.kumar@linux.ibm.com, jirislaby@kernel.org,
        songmuchun@bytedance.com, qydwhotmail@gmail.com, hughd@google.com,
        ziy@nvidia.com, anshuman.khandual@arm.com
Subject: Re: [PATCH v3 1/4] mm/debug_vm_pgtable: remove pte entry from the
 page table
In-Reply-To: <20220126060514.1574935-2-pasha.tatashin@soleen.com>
Message-ID: <6e7a364-f252-9622-38c0-d0b7541f87a4@google.com>
References: <20220126060514.1574935-1-pasha.tatashin@soleen.com> <20220126060514.1574935-2-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2022, Pasha Tatashin wrote:

> The pte entry that is used in pte_advanced_tests() is never removed from
> the page table at the end of the test.
> 
> The issue is detected by page_table_check, to repro compile kernel with
> the following configs:
> 
> CONFIG_DEBUG_VM_PGTABLE=y
> CONFIG_PAGE_TABLE_CHECK=y
> CONFIG_PAGE_TABLE_CHECK_ENFORCED=y
> 
> During the boot the following BUG is printed:
> 
> [    2.262821] debug_vm_pgtable: [debug_vm_pgtable         ]: Validating
>                architecture page table helpers
> [    2.276826] ------------[ cut here ]------------
> [    2.280426] kernel BUG at mm/page_table_check.c:162!
> [    2.284118] invalid opcode: 0000 [#1] PREEMPT SMP PTI
> [    2.287787] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
>                5.16.0-11413-g2c271fe77d52 #3
> [    2.293226] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>                BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org
>                04/01/2014
> ...
> 
> The entry should be properly removed from the page table before the page
> is released to the free list.
> 
> Fixes: a5c3b9ffb0f4 ("mm/debug_vm_pgtable: add tests validating advanced arch page table helpers")
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Tested-by: Zi Yan <ziy@nvidia.com>

Acked-by: David Rientjes <rientjes@google.com>

I think we also likely want:

Cc: stable@vger.kernel.org # 5.9+
