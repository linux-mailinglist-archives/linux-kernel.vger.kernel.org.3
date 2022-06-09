Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F455458A6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 01:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238403AbiFIXcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 19:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiFIXcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 19:32:50 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E39DF5E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 16:32:49 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id be31so40332939lfb.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 16:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zZvfHuA/INP0bzqhy6JO1XuTrxVTvY/yQkrfFhyb6RY=;
        b=AO9UirfXTW2usQSjxu5mnE63GJVln7CwTvt984QMHHlVtQ+thTYoPhGoxy2vNlGaTW
         5JlRQRR3o9ghci3LGlhcXfCKmZZBeImW/j9RH3JyGwU6NgrlXTJb7Pd5kqSkAPpeEGvq
         fpFzPg9HvuZZavvXLtjJqucCteVRar2VGekVCknBjxxqxh0OEarqcIWYNOeHdmUWafFK
         SVIv6Byh+3AEtT5bqGoAcgK+zq6KYHvAJYjiMmkrkewvQAasOB60UC4ov7JvFsezBE74
         +Bzkyj6mF1ZkmTGEMCWKKodFQFDUjS04oF4cLOKZHagmzoDoy2b6sy7C4qVjd3zpL8B3
         o5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zZvfHuA/INP0bzqhy6JO1XuTrxVTvY/yQkrfFhyb6RY=;
        b=yW1+wIcYcijWqQD9cIi8X7SNJ2GP/ttKnrLYSOmXKNY6OcBrOR1eBTmCUxdMXgRQa0
         KLAhxOunkfbvx+mYLetkmCyRc1MmEZBYRvS6Ng6AsH2uf8fQQBCNnqaOS/aAgoZ0+KI6
         jBlTXyI+P1gejjnuxOz22yJ6ZGZgrl9FGwshHDq6xee4R8kSlu9AXzC3d3QwELQJoeEi
         cr4g1+j5SVApfJJETUk23EwPxjO1xdtn1sa8IuNOTYX2f6cgXPkGjwdrJsNpRDOscSQT
         UNdS0ejmzKCGhuMYcKyf0PemL6ElytxIO0Qz5aszvciI64zMgE597aRg34+fuxaqHI1V
         KxgA==
X-Gm-Message-State: AOAM533T0oNbwB7Vcwp2w8WUTBBX+6Fw04koGjMExfB/hbgK10Z9ecXH
        LWI0OGT6cC2/j7yYVzj+1KolkJ96Ws213/qpfkwVpg==
X-Google-Smtp-Source: ABdhPJw6HqwRaxvlvHRov+lDQ9sHRbUp445FudsXOBatCxCFe8iOBOODDCxKFv28Gdt0LEzRCIjhyBzekDv4qYM1uwQ=
X-Received: by 2002:a05:6512:11e4:b0:479:5d64:f3a0 with SMTP id
 p4-20020a05651211e400b004795d64f3a0mr10959909lfs.354.1654817567136; Thu, 09
 Jun 2022 16:32:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220606214414.736109-1-shy828301@gmail.com>
In-Reply-To: <20220606214414.736109-1-shy828301@gmail.com>
From:   "Zach O'Keefe" <zokeefe@google.com>
Date:   Thu, 9 Jun 2022 16:32:10 -0700
Message-ID: <CAAa6QmSyv0_dt6OxgdG_wEXkr3D4eUnrpA4F9M3cX68OhYCzjA@mail.gmail.com>
Subject: Re: [mm-unstable v3 PATCH 0/7] Cleanup transhuge_xxx helpers
To:     Yang Shi <shy828301@gmail.com>
Cc:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        willy@infradead.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Jun 6, 2022 at 2:44 PM Yang Shi <shy828301@gmail.com> wrote:
>
>
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

By the way, thanks for doing this work. I know I personally was quite
confused about which vma checking function does what / which I should
be using. I briefly tried sketching out how to do something like this
as well - but the various corner cases where e.g. hugepage_vma_check()
and transparent_hugepage_active() differed got confusing. Thanks for
figuring this all out.

> The transhuge_vma_enabled(), transparent_hugepage_active() and
> __transparent_hugepage_enabled() are killed by this series.
>
> Added transhuge_vma_size_ok() helper to remove some duplicate code.
>
>
> Yang Shi (7):
>       mm: khugepaged: check THP flag in hugepage_vma_check()
>       mm: thp: introduce transhuge_vma_size_ok() helper
>       mm: khugepaged: remove the redundant anon vma check
>       mm: khugepaged: use transhuge_vma_suitable replace open-code
>       mm: thp: kill transparent_hugepage_active()
>       mm: thp: kill __transhuge_page_enabled()
>       mm: khugepaged: reorg some khugepaged helpers
>
>  fs/proc/task_mmu.c         |  2 +-
>  include/linux/huge_mm.h    | 84 ++++++++++++++++++++++++++++------------------------------------------
>  include/linux/khugepaged.h | 21 ++----------------
>  mm/huge_memory.c           | 64 +++++++++++++++++++++++++++++++++++++++++++++--------
>  mm/khugepaged.c            | 78 +++++++++++++++--------------------------------------------------
>  mm/memory.c                |  7 ++++--
>  6 files changed, 114 insertions(+), 142 deletions(-)
>
>
>
