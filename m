Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA9D54EDC8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 01:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379329AbiFPXIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 19:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379313AbiFPXIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 19:08:45 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2C95DE63
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 16:08:44 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so3063936pjl.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 16:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PlzEVLgbgcNLoTiedFQlmIfcdcTRlowz3FKTRI9/iaI=;
        b=Yensil1fzqL+EyeQnMb+J4phzUgdOKoa9OBX3qhyruae87Oqvy31GYKJa67G2if2Z+
         oU7Zmkk8KzIkgffk1I4FE8mRnznmr/o2+qSvyPf4BXotVkTB4hF4bAna/jLVE7oJ0GhB
         lDzqaUAO5grP69Yqpox0+IuoUij8Ru6dIttEthhIsk3sEO3kQZQw6vEwlWdiEriuUVLn
         qcDLoiuzuFTmRGjTYlgGHk6NF71VdFJLiUeu8xyHEpUSx2ej75t6CUoNGKzQHespZYcq
         bBMAAVykBkJO/D3IYstzDwRHpK2bH7D9y6ihtehIvIjzF6mgkYcwRklLfXV3gTaF1tVa
         x3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PlzEVLgbgcNLoTiedFQlmIfcdcTRlowz3FKTRI9/iaI=;
        b=vl4iaPHOTUockN1J4VbbiWDs6QJParNPaLmgWp+NtDdAOo5wCxMfjEIRCeNpLKJfSM
         ggOyCB8svkn/re/7IEeKb1HAipnRT+I6JEzRE5A/7AJ2lhYJoBXv0oU4ZBxPV48MWkDA
         YlCKpSUETC7Lx/yYKCYqJuMuOPxo/UK8tb4RHgp5FxuoCdUy7UjXjAnLmrn0Ew2A7H95
         0dkBOSfjmYrSqpMO02/PRp8lbeWxLap4pSTXuVc7jK/LXRCbOV/VE82bMf19oKg4rwQk
         PBgtQLKdwD7AP/TnuAF68pdJxQCWWddo7GDHM1FCg0oeu4/6buC3dMv/kuzOxAh0d2B6
         LYGQ==
X-Gm-Message-State: AJIora9jjqaWOlpSzps8Tg/RmfwMWnufcReLkhRjkzk6fqPh4H/pirVZ
        bPhG9k5f5jDqORp/fuSeTV7oOw==
X-Google-Smtp-Source: AGRyM1vpupA4NZl6KGgvrWJFG7O3PRT2VHndwct1OqxiBBgAU4F0aTk0eCZ8/MSi1FsE5VJQToEFCg==
X-Received: by 2002:a17:902:d102:b0:167:4f35:9580 with SMTP id w2-20020a170902d10200b001674f359580mr6849416plw.38.1655420923542;
        Thu, 16 Jun 2022 16:08:43 -0700 (PDT)
Received: from google.com (55.212.185.35.bc.googleusercontent.com. [35.185.212.55])
        by smtp.gmail.com with ESMTPSA id ay10-20020a1709028b8a00b0016191b843e2sm2126575plb.235.2022.06.16.16.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 16:08:42 -0700 (PDT)
Date:   Thu, 16 Jun 2022 16:08:39 -0700
From:   Zach O'Keefe <zokeefe@google.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        willy@infradead.org, linmiaohe@huawei.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [mm-unstable v5 PATCH 0/7] Cleanup transhuge_xxx helpers
Message-ID: <Yqu392qcUSp1imEi@google.com>
References: <20220616174840.1202070-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616174840.1202070-1-shy828301@gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Jun 10:48, Yang Shi wrote:
> 
> v5: * Removed transparent_hugepage_active() for !THP, per Zach.
>       Patch 4/7 and 5/7 were updated accordingly.
>     * Collected review tags.
> v4: * Consolidated the transhuge_vma_size_ok() helper proposed in the
>       earlier versions into transhuge_vma_suitable(), per Zach.
>     * Fixed the regression introduced by patch 3/7, per Zach and Miaohe.
>     * Reworded the comment for transhuge_vma_suitable(), per Zach.
>     * Removed khugepaged_enter() per Miaohe.
>     * More comments for hugepage_vma_check(), per Zach.
>     * Squashed patch 4/7 (mm: khugepaged: use transhuge_vma_suitable replace open-code)
>       in the earlier version into patch 2/7 of this version.
>     * Minor correction to the doc about THPeligible (patch 7/7), so the
>       total number of patches is kept 7. 
> v3: * Fixed the comment from Willy
> v2: * Rebased to the latest mm-unstable
>     * Fixed potential regression for smaps's THPeligible
> 
> This series is the follow-up of the discussion about cleaning up transhuge_xxx
> helpers at https://lore.kernel.org/linux-mm/627a71f8-e879-69a5-ceb3-fc8d29d2f7f1@suse.cz/.
> 
> THP has a bunch of helpers that do VMA sanity check for different paths, they
> do the similar checks for the most callsites and have a lot duplicate codes.
> And it is confusing what helpers should be used at what conditions.
> 
> This series reorganized and cleaned up the code so that we could consolidate
> all the checks into hugepage_vma_check().
> 
> The transhuge_vma_enabled(), transparent_hugepage_active() and
> __transparent_hugepage_enabled() are killed by this series.
> 
> 
> Yang Shi (7):
>       mm: khugepaged: check THP flag in hugepage_vma_check()
>       mm: thp: consolidate vma size check to transhuge_vma_suitable
>       mm: khugepaged: better comments for anon vma check in hugepage_vma_revalidate
>       mm: thp: kill transparent_hugepage_active()
>       mm: thp: kill __transhuge_page_enabled()
>       mm: khugepaged: reorg some khugepaged helpers
>       doc: proc: fix the description to THPeligible
> 
>  Documentation/filesystems/proc.rst |  4 ++-
>  fs/proc/task_mmu.c                 |  2 +-
>  include/linux/huge_mm.h            | 80 +++++++++++++++++++----------------------------------------
>  include/linux/khugepaged.h         | 30 ----------------------
>  mm/huge_memory.c                   | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++--------
>  mm/khugepaged.c                    | 84 +++++++++++++++++++-------------------------------------------
>  mm/memory.c                        |  7 ++++--
>  7 files changed, 130 insertions(+), 158 deletions(-)
> 

Series LGTM. Thanks for these cleanups, Yang!

Best,
Zach
