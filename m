Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993F751396C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 18:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349579AbiD1QNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 12:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbiD1QNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 12:13:07 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C034A3E0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 09:09:52 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-e2fa360f6dso5625489fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 09:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nT3t1w9TRCQTEHgFchj44IQlb1iT4EUgGpNoU9tkFsY=;
        b=gA7bjoCxWh92i/S1XF1eE2xn7QiKAkHhFHKC43aWKcdA7yJ14+7dncrlZhI9vRwUtl
         YLGV3y+wPDFF0sEqS5Cgc+enP8aoQiEjLPJjxtl3Y24SUc7qkk49DVu0/eOkKfmI/9gw
         C+2BgS5naRu3SyMowsXtMoq9pcj6EfDXWlvq2vG4g9FP8oiIKH3pKZPqCXTgW02KHwIj
         ZIMSTHHal5Wv0FGwumWUpnCfiR8FXVo49X2A/juFdw+e7XwNNmxppSxiCX349+WFviEh
         hgUNacOjrrUsyDGWLqjyfzKSvC2YUqPnJbB2zzwsRdQ0Rm70wcFwy9obpXs1zerbYO70
         /jcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=nT3t1w9TRCQTEHgFchj44IQlb1iT4EUgGpNoU9tkFsY=;
        b=4TXvTCJrNk10JlVKyiVrGqA+rtrB6KmcNWmqqG0e0N1aeS8uy7ipWN6TM57zW5x+3d
         Kcc3JAIa5pw1cNuaxNC9V99RCDAlby8wBpIxfd78rk187EmPaTN56FO+RaunnjdtqysU
         KM2zm4uGa+lDPXQDv10ZltYC0tJlHJS6IzQK734orB3Zi05U74iLjUEts2tSvyp0X3FW
         Nc2erco+VcCTxmLK3L2XqOhfzFgSbi50Pk7vpri7qtToSpNSPTwzHSBQiQJfRU8TP7Au
         bNa7gAvySrUz9oGMl6oXkoj/xm9h+WE3qWJYeDSEVviYke2i2q2BhVCsYuLc4Ptdhf5T
         21pg==
X-Gm-Message-State: AOAM531xFs0kQ8Pv5xWxHziTgqNX/+1MXnJajLJyOWFwLSt2LvCC2R2p
        yQ27R2S6MTrXs+cFgB48D9g=
X-Google-Smtp-Source: ABdhPJy4QuxfXKo3x2RKwtWbQ7/VCsg7jnPYGdn94JBDr1/7gNQeWoBmW9i0Vii2BO1jjuiYtJxzGQ==
X-Received: by 2002:a05:6870:e9a0:b0:e6:9d2:ff42 with SMTP id r32-20020a056870e9a000b000e609d2ff42mr14411601oao.7.1651162191312;
        Thu, 28 Apr 2022 09:09:51 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bt30-20020a0568201a9e00b0035ea84682b9sm181981oob.45.2022.04.28.09.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 09:09:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 28 Apr 2022 09:09:49 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v8 23/70] mm/mmap: change do_brk_flags() to expand
 existing VMA and add do_brk_munmap()
Message-ID: <20220428160949.GA2923383@roeck-us.net>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
 <20220426150616.3937571-24-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426150616.3937571-24-Liam.Howlett@oracle.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 03:06:35PM +0000, Liam Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> Avoid allocating a new VMA when it a vma modification can occur.  When a
> brk() can expand or contract a VMA, then the single store operation will
> only modify one index of the maple tree instead of causing a node to split
> or coalesce.  This avoids unnecessary allocations/frees of maple tree
> nodes and VMAs.
> 
> Move some limit & flag verifications out of the do_brk_flags() function to
> use only relevant checks in the code path of bkr() and vm_brk_flags().
> 
> Set the vma to check if it can expand in vm_brk_flags() if extra criteria
> are met.
> 
> Drop userfaultfd from do_brk_flags() path and only use it in
> vm_brk_flags() path since that is the only place a munmap will happen.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

This patch results in boot failures on alpha. Trying to revert it results
in conflicts, so I was unable to cross-check. Bisect log attached. The failure
is silent - boot simply stalls after "random: crng init done", so attaching
a boot log doesn't add value.

Guenter

---
# bad: [bdc61aad77faf67187525028f1f355eff3849f22] Add linux-next specific files for 20220428
# good: [af2d861d4cd2a4da5137f795ee3509e6f944a25b] Linux 5.18-rc4
git bisect start 'HEAD' 'v5.18-rc4'
# good: [a6ffa4aa7e81a54632f3370f4c93fce603160192] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
git bisect good a6ffa4aa7e81a54632f3370f4c93fce603160192
# good: [cd63f17e3bb63006f9f88bf7f5947b8e1601bcd9] Merge branch 'edac-for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git
git bisect good cd63f17e3bb63006f9f88bf7f5947b8e1601bcd9
# good: [cee7bbed3e5cc089b5c364ac8ad4a186c2a28bb6] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git
git bisect good cee7bbed3e5cc089b5c364ac8ad4a186c2a28bb6
# good: [d5a23156ea99f10b584221893a6a7d6f6554cde8] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git
git bisect good d5a23156ea99f10b584221893a6a7d6f6554cde8
# good: [2f1fde90d983bc404503100c9c4bbbf1e191bcf4] selftests: cgroup: fix alloc_anon_noexit() instantly freeing memory
git bisect good 2f1fde90d983bc404503100c9c4bbbf1e191bcf4
# good: [fca1db6ff251278c532231552e840c7dc36dfa76] Merge branch 'bitmap-for-next' of https://github.com/norov/linux.git
git bisect good fca1db6ff251278c532231552e840c7dc36dfa76
# bad: [40b39116fe8e6fb66e3166ea40138eec506dfd91] perf: use VMA iterator
git bisect bad 40b39116fe8e6fb66e3166ea40138eec506dfd91
# good: [3f2187cf9b93a58343dd01273afdab9df04b0ca3] proc: remove VMA rbtree use from nommu
git bisect good 3f2187cf9b93a58343dd01273afdab9df04b0ca3
# bad: [7dbf1873ad5953d8cf732d5fd5a94c1b95c022b0] parisc: remove mmap linked list from cache handling
git bisect bad 7dbf1873ad5953d8cf732d5fd5a94c1b95c022b0
# bad: [c6e0b59766907a73be6cb77683f3ba60d0115495] mm/mmap: use advanced maple tree API for mmap_region()
git bisect bad c6e0b59766907a73be6cb77683f3ba60d0115495
# good: [f461d9862fdab8e6aea51094e7286f3ec1b25402] mm: optimize find_exact_vma() to use vma_lookup()
git bisect good f461d9862fdab8e6aea51094e7286f3ec1b25402
# bad: [c19a5ccbcbc6fe2c422fd85b22b40abed96c6f6b] mm/mmap: change do_brk_flags() to expand existing VMA and add do_brk_munmap()
git bisect bad c19a5ccbcbc6fe2c422fd85b22b40abed96c6f6b
# good: [993adc76c4d7afb40133be90333b5303b02115b6] mm/khugepaged: optimize collapse_pte_mapped_thp() by using vma_lookup()
git bisect good 993adc76c4d7afb40133be90333b5303b02115b6
# first bad commit: [c19a5ccbcbc6fe2c422fd85b22b40abed96c6f6b] mm/mmap: change do_brk_flags() to expand existing VMA and add do_brk_munmap()
