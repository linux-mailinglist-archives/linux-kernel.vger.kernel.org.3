Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D724531451
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237033AbiEWOY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 10:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237000AbiEWOYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 10:24:55 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFC35932E
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 07:24:54 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id m25so18007849oih.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 07:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4OpdJcTXXlsXGiX1+XWS8FUX7vG0MIs+nKrykIWk69U=;
        b=nFxf6AifF1xWCibSO89FnoHlSuZG9NFqIZqE/C1zN6DwHUzkkIw5bg6YsEfTG3nnFH
         rzPVTb0QJF/8T9GvAHZ65lb9My3m9/P7fMHkWrPapvr4Z3VLSl3j8/gMUCQDI+IcrDN4
         ITPkSPKtfENkGrub7kzYFjG8RmSjXn81BUnrKBCPpDzBD8C91PzqU2PATrUrmOkuU8bb
         3CbcizVhKidnwQzmKdzeDgNKld1erhQQuz9TnoHVCHGMdApEHXF+pZEprxc+JQ110VvV
         cXJWGCQlbHXWc+RoSErtCW7j3fIoWPWBC5kQFRKQ0N6Gcw+e8Y8pKUDEuSSS+thBKaZC
         F6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=4OpdJcTXXlsXGiX1+XWS8FUX7vG0MIs+nKrykIWk69U=;
        b=cKYrwFysCGUUK+fTm6MRxl3kU4eHufg4YHiZi1WMXhw1vgnanRynlWNo6IKQ6zfYaf
         +jWmQWU/J8DiOTs3k6hCLvSfxrl/f4Er60BJDDR3Ch+7wOHvMKs3HJbDZ94F3Es/myU4
         sdmq6t6fYnCXkuHfAFANat6sL0ReBEIGh6cMCip6qBe6FLLrbL69Duo3ANw0YrVZNU6T
         ay5bQu0G7oJq8JfV0DiQd8mkHuNUWn6Sfq64DRbpAg+dnfVE0oKGXPfEWniWBgBoAr6G
         4UGgffkCDF72XajhqYyYXZjXM4X0Z3oe8Pl6TBM2hWrZKDkiYvR5rSaQqxB3Y84OxBvJ
         i4AQ==
X-Gm-Message-State: AOAM532T+X7x8Rp8+0oUpyhGK3onXW7qrd2sV/VBvhjp/KRNaj60xtkG
        xoYUcKu+10b+tFjwK5OvOuQ=
X-Google-Smtp-Source: ABdhPJyojZP5Ppcr09qGrQR2qP1Q7DsMch2dZxIrAqjJBHMyN3+6kkFVi9V7MSDJWHP4JGLwrXCa7w==
X-Received: by 2002:a05:6808:1a01:b0:32b:1edc:9c4d with SMTP id bk1-20020a0568081a0100b0032b1edc9c4dmr4175160oib.279.1653315893783;
        Mon, 23 May 2022 07:24:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b124-20020acab282000000b0032ae369c25esm4149529oif.53.2022.05.23.07.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 07:24:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 23 May 2022 07:24:52 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Peter Collingbourne <pcc@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        vbabka@suse.cz, penberg@kernel.org, roman.gushchin@linux.dev,
        iamjoonsoo.kim@lge.com, rientjes@google.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v5 1/2] printk: stop including cache.h from printk.h
Message-ID: <20220523142452.GA3164183@roeck-us.net>
References: <20220427195820.1716975-1-pcc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427195820.1716975-1-pcc@google.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 12:58:19PM -0700, Peter Collingbourne wrote:
> An inclusion of cache.h in printk.h was added in 2014 in
> commit c28aa1f0a847 ("printk/cache: mark printk_once test variable
> __read_mostly") in order to bring in the definition of __read_mostly. The
> usage of __read_mostly was later removed in commit 3ec25826ae33 ("printk:
> Tie printk_once / printk_deferred_once into .data.once for reset")
> which made the inclusion of cache.h unnecessary, so remove it.
> 
> We have a small amount of code that depended on the inclusion of cache.h
> from printk.h; fix that code to include the appropriate header.
> 
> This fixes a circular inclusion on arm64 (linux/printk.h -> linux/cache.h
> -> asm/cache.h -> linux/kasan-enabled.h -> linux/static_key.h ->
> linux/jump_label.h -> linux/bug.h -> asm/bug.h -> linux/printk.h) that
> would otherwise be introduced by the next patch.
> 
> Build tested using {allyesconfig,defconfig} x {arm64,x86_64}.

But not powerpc:corenet64_smp_defconfig, where it results in lots of
build errors such as

powerpc64-linux-ld: fs/freevxfs/vxfs_fshead.o:(.bss+0x0):
	multiple definition of `____cacheline_aligned';
	fs/freevxfs/vxfs_bmap.o:(.bss+0x0): first defined here

Reverting this patch fixes the problem.

Guenter

---
# bad: [18ecd30af1a8402c162cca1bd58771c0e5be7815] Add linux-next specific files for 20220520
# good: [42226c989789d8da4af1de0c31070c96726d990c] Linux 5.18-rc7
git bisect start 'HEAD' 'v5.18-rc7'
# good: [f9b63740b666dd9887eb0282d21b5f65bb0cadd0] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
git bisect good f9b63740b666dd9887eb0282d21b5f65bb0cadd0
# good: [1f5eb3e76303572f0318e8c50da51c516580aa03] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
git bisect good 1f5eb3e76303572f0318e8c50da51c516580aa03
# good: [4c1d9cc0363691893ef94fa0d798faca013e27d3] Merge branch 'staging-next' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
git bisect good 4c1d9cc0363691893ef94fa0d798faca013e27d3
# good: [a3204ed0fc565fc76901c67dfc8e04c91a5c8ea4] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock.git
git bisect good a3204ed0fc565fc76901c67dfc8e04c91a5c8ea4
# bad: [ca228447682904bc749c0702695681543b5dc709] Merge branch 'mm-nonmm-unstable' into mm-everything
git bisect bad ca228447682904bc749c0702695681543b5dc709
# bad: [c0eeeb02d9df878c71a457008900b650d94bd0d9] selftests/uffd: enable uffd-wp for shmem/hugetlbfs
git bisect bad c0eeeb02d9df878c71a457008900b650d94bd0d9
# good: [0a7a0f6f7f3679c906fc55e3805c1d5e2c566f55] hugetlb: fix wrong use of nr_online_nodes
git bisect good 0a7a0f6f7f3679c906fc55e3805c1d5e2c566f55
# good: [c9fe66560bf2dc7d109754414e309888cb8c9ba9] mm/mprotect: do not flush when not required architecturally
git bisect good c9fe66560bf2dc7d109754414e309888cb8c9ba9
# bad: [97d482f4592fde2322c319f07bc54f3a0d37861c] mm/damon/sysfs: reuse damon_set_regions() for regions setting
git bisect bad 97d482f4592fde2322c319f07bc54f3a0d37861c
# good: [54205e9c5425049aef1bc7a812f890f00b5f79c7] mm: rmap: move the cache flushing to the correct place for hugetlb PMD sharing
git bisect good 54205e9c5425049aef1bc7a812f890f00b5f79c7
# bad: [9994715333515e82865e533250e488496b9742f4] selftest/vm: test that mremap fails on non-existent vma
git bisect bad 9994715333515e82865e533250e488496b9742f4
# bad: [d949a8155d139aa890795b802004a196b7f00598] mm: make minimum slab alignment a runtime property
git bisect bad d949a8155d139aa890795b802004a196b7f00598
# bad: [534aa1dc975ac883ad89110534585a96630802a0] printk: stop including cache.h from printk.h
git bisect bad 534aa1dc975ac883ad89110534585a96630802a0
# good: [dfc7ab57560da385f705b28e2bf50e3b90444a6b] mm: rmap: use flush_cache_range() to flush cache for hugetlb pages
git bisect good dfc7ab57560da385f705b28e2bf50e3b90444a6b
# first bad commit: [534aa1dc975ac883ad89110534585a96630802a0] printk: stop including cache.h from printk.h
