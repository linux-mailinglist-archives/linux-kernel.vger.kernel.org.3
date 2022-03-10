Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6404D3E81
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 01:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239068AbiCJBAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 20:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbiCJBAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 20:00:13 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A65011B5D3
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 16:59:13 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id e2so3447829pls.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 16:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NQaSIZIxO5KOdOicjkb1cFrwib5bGbIpCqk65gAppCI=;
        b=VS2xx8r9PIGwCLa64CuDfWCjlfdzMZcrNjPDuGSm77clH/PVMaEZN2pFx9+sRO7bqW
         NT6d5L8XGp5XpSuR6KuMouThtrdyDHbkITw+k9eisuQJylQgdSTzNjL6hXN+HdOsOAiQ
         cpFH7NrpzwaP8f7q7dqp322hrR0wM5RwN+VGHbpilCz8ADGA8IPs2ZX55ZR+0G7xPGsC
         CSwwKUf//3X1p7hREN0WgucPZ5yZc7YRbwvGPR1udtiTEZJao3XE/m/Hn1NBh7rCglRm
         fbhq4iAW9AUvr0m7gEOlYSgkuwWgsA4XYTxNaspmnJFzTOItrpijpGdy7OsrHpvYytSU
         Da9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NQaSIZIxO5KOdOicjkb1cFrwib5bGbIpCqk65gAppCI=;
        b=hX5ATv3pmNHvgCmyPcMChr+wPttzqu+VuAseowg09rEqZAs+9qZQ0BEZFdSAUiu9/u
         9l2YpxlJDYQGtRt7ioW2uE0ZW6ZurzhN99X1KDD2WT2w0IIGl95A8F3mUvDAPWN4FRLE
         d+avDD0LPpWvDuIx9UeE+eTWiC5Ma5E0xy8Vrifws9F2K9B3v0L3LcGPopoYqKbxmZVj
         TUxJU59poIV26Cf6kcDNfpapmMV+8YCmHf31dKOO+VZO2HWxp+vRPR0lfaPlhDKOEuHX
         omJLPslTbg6KVpsu2gAa9JeX63o7wMnhrJgQ8zCkFdbBufJT47QAi4ECABD6QhnCns6q
         wQ5Q==
X-Gm-Message-State: AOAM532o+60EyTFT+yd7LpMIqdoY7p2cThZ7WST6PCktw6DML5KtC73V
        GlbccOWqzKxE1AfN2TVP/2jonpLjF5zHuFS5/anmtHKJnVERXQ==
X-Google-Smtp-Source: ABdhPJw96a/Eq6dU3OeebKd8y0NUTDNVyL9MKec/ynBgpi4ejJZav6ILrpB7Vds7D2x6nUx/OKPBrD3KR+tlbTRAg84=
X-Received: by 2002:a17:902:7296:b0:14b:4bc6:e81 with SMTP id
 d22-20020a170902729600b0014b4bc60e81mr2486890pll.132.1646873952956; Wed, 09
 Mar 2022 16:59:12 -0800 (PST)
MIME-Version: 1.0
References: <20220302082718.32268-1-songmuchun@bytedance.com> <20220302082718.32268-6-songmuchun@bytedance.com>
In-Reply-To: <20220302082718.32268-6-songmuchun@bytedance.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 9 Mar 2022 16:59:02 -0800
Message-ID: <CAPcyv4hsMWe1AreVVhGJD-St3FGtGBMeA-BX7XbA_kVX97tw4Q@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] dax: fix missing writeprotect the pte entry
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Hugh Dickins <hughd@google.com>, xiyuyang19@fudan.edu.cn,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, duanxiongchun@bytedance.com,
        Muchun Song <smuchun@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 2, 2022 at 12:30 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> Currently dax_mapping_entry_mkclean() fails to clean and write protect
> the pte entry within a DAX PMD entry during an *sync operation. This
> can result in data loss in the following sequence:
>
>   1) process A mmap write to DAX PMD, dirtying PMD radix tree entry and
>      making the pmd entry dirty and writeable.
>   2) process B mmap with the @offset (e.g. 4K) and @length (e.g. 4K)
>      write to the same file, dirtying PMD radix tree entry (already
>      done in 1)) and making the pte entry dirty and writeable.
>   3) fsync, flushing out PMD data and cleaning the radix tree entry. We
>      currently fail to mark the pte entry as clean and write protected
>      since the vma of process B is not covered in dax_entry_mkclean().
>   4) process B writes to the pte. These don't cause any page faults since
>      the pte entry is dirty and writeable. The radix tree entry remains
>      clean.
>   5) fsync, which fails to flush the dirty PMD data because the radix tree
>      entry was clean.
>   6) crash - dirty data that should have been fsync'd as part of 5) could
>      still have been in the processor cache, and is lost.

Excellent description.

>
> Just to use pfn_mkclean_range() to clean the pfns to fix this issue.

So the original motivation for CONFIG_FS_DAX_LIMITED was for archs
that do not have spare PTE bits to indicate pmd_devmap(). So this fix
can only work in the CONFIG_FS_DAX_LIMITED=n case and in that case it
seems you can use the current page_mkclean_one(), right? So perhaps
the fix is to skip patch 3, keep patch 4 and make this patch use
page_mkclean_one() along with this:

diff --git a/fs/Kconfig b/fs/Kconfig
index 7a2b11c0b803..42108adb7a78 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -83,6 +83,7 @@ config FS_DAX_PMD
        depends on FS_DAX
        depends on ZONE_DEVICE
        depends on TRANSPARENT_HUGEPAGE
+       depends on !FS_DAX_LIMITED

 # Selected by DAX drivers that do not expect filesystem DAX to support
 # get_user_pages() of DAX mappings. I.e. "limited" indicates no support

...to preclude the pmd conflict in that case?
