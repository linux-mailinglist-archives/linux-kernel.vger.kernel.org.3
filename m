Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB49049D27B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 20:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbiAZT0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 14:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbiAZT0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 14:26:11 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88553C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 11:26:11 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id g9-20020a17090a67c900b001b4f1d71e4fso576206pjm.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 11:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=FVYHc2+BFBni6BKS9KzbZHsth+59VjQdJh4ifViuJgU=;
        b=mod3qenkSqfRqSY3ZEMtFoM6tvXmaDwLD363+n8GjuMDUYd0uJQVFw2qsKhxjHy/tq
         yMF49nGy+Y3OAy5PGHZ3ZBVSFMgQdGGO29IhUtDFsASlRjyBLC/tzkvpmBckhXDFQIjD
         hRdXnIvdv+3lTTTND8ZBV1rznplZiVNaV61xYJIxtF8RkoXz8VFCGU6A+YiO5Kor6pJd
         haTklqK9vuYnMOEjZx1H27hGr6T293qJ11qgSOHBxnc9vcvz2PYtQvSThT15TkKDwxgg
         s2HhOaHN2TKqXCtV687QrfCPgDOsvxzo5EfT6xqL+ZHl4YAvOm1b87KWyRI7xeQ2NBIX
         gdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=FVYHc2+BFBni6BKS9KzbZHsth+59VjQdJh4ifViuJgU=;
        b=LSZSc4aDbgLaA/cjkDvVGtgMFdCPM2V45My5ep+mKBVqr9JYsSert8oZvDOxgyfeZz
         XO3plOlJjisrIf5LGjI3IBkeCpMi1KE0rpOGOp78Vj6mkNGQXeBeqrIk5E14Hpdv2TrK
         iT80ORmTtRDlxDKWW4rqJD/F5KWYVLMfV2BPj3SJ7m+SOwJZooBNN821I6i2+k9ehQ4Y
         bH+gS9ZUosXmXyORpL/pSBDzF5PsDTbdjDG1Fx3w3idnezsgQscKYv4GIWGyw7SBQz3s
         eKkAP0MN1Jq7nnDZO5jWZb6g1vBUd96eYatU4ca/4Zhmm4H1YHpm+qELawogTATIfYHA
         mQyg==
X-Gm-Message-State: AOAM531NQEk7iEsNfmnpSSNKLtrz34lzLE4ku/Ml/C+le/g8jHxA62CD
        EqSUSWsOpMZdx6dBjS9e7t+TGg==
X-Google-Smtp-Source: ABdhPJwzi/oqq3KEtgTD8w0cfXbUW9DYcBt6wHefVZe2VJHleRDmpI9yKwxF/T++uqSUiNy6IolADQ==
X-Received: by 2002:a17:902:eb52:: with SMTP id i18mr56786pli.143.1643225170654;
        Wed, 26 Jan 2022 11:26:10 -0800 (PST)
Received: from [2620:15c:29:204:925c:a455:6d75:1ac8] ([2620:15c:29:204:925c:a455:6d75:1ac8])
        by smtp.gmail.com with ESMTPSA id 13sm2776911pfm.161.2022.01.26.11.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 11:26:10 -0800 (PST)
Date:   Wed, 26 Jan 2022 11:26:09 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, pjt@google.com, weixugc@google.com,
        gthelen@google.com, mingo@redhat.com, will@kernel.org,
        rppt@kernel.org, dave.hansen@linux.intel.com, hpa@zytor.com,
        aneesh.kumar@linux.ibm.com, jirislaby@kernel.org,
        songmuchun@bytedance.com, qydwhotmail@gmail.com, hughd@google.com,
        ziy@nvidia.com, anshuman.khandual@arm.com
Subject: Re: [PATCH v4 4/4] mm/page_table_check: check entries at pmd
 levels
In-Reply-To: <20220126183637.1840960-5-pasha.tatashin@soleen.com>
Message-ID: <cc0ccee-df97-48ea-9a3e-4027c0e11e9d@google.com>
References: <20220126183637.1840960-1-pasha.tatashin@soleen.com> <20220126183637.1840960-5-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2022, Pasha Tatashin wrote:

> syzbot detected a case where the page table counters were not properly
> updated.
> 
> syzkaller login:  ------------[ cut here ]------------
> kernel BUG at mm/page_table_check.c:162!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 3099 Comm: pasha Not tainted 5.16.0+ #48
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO4
> RIP: 0010:__page_table_check_zero+0x159/0x1a0
> Code: 7d 3a b2 ff 45 39 f5 74 2a e8 43 38 b2 ff 4d 85 e4 01
> RSP: 0018:ffff888010667418 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000
> RDX: ffff88800cea8680 RSI: ffffffff81becaf9 RDI: 0000000003
> RBP: ffff888010667450 R08: 0000000000000001 R09: 0000000000
> R10: ffffffff81becaab R11: 0000000000000001 R12: ffff888008
> R13: 0000000000000001 R14: 0000000000000200 R15: dffffc0000
> FS:  0000000000000000(0000) GS:ffff888035e00000(0000) knlG0
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffd875cad00 CR3: 00000000094ce000 CR4: 0000000000
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000
> Call Trace:
>  <TASK>
>  free_pcp_prepare+0x3be/0xaa0
>  free_unref_page+0x1c/0x650
>  ? trace_hardirqs_on+0x6a/0x1d0
>  free_compound_page+0xec/0x130
>  free_transhuge_page+0x1be/0x260
>  __put_compound_page+0x90/0xd0
>  release_pages+0x54c/0x1060
>  ? filemap_remove_folio+0x161/0x210
>  ? lock_downgrade+0x720/0x720
>  ? __put_page+0x150/0x150
>  ? filemap_free_folio+0x164/0x350
>  __pagevec_release+0x7c/0x110
>  shmem_undo_range+0x85e/0x1250
> ...
> 
> The repro involved having a huge page that is split due to uprobe event
> temporarily replacing one of the pages in the huge page. Later the huge
> page was combined again, but the counters were off, as the PTE level
> was not properly updated.
> 
> Make sure that when PMD is cleared and prior to freeing the level the
> PTEs are updated.
> 
> Fixes: df4e817b7108 ("mm: page table check")
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Acked-by: David Rientjes <rientjes@google.com>
