Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531875738BB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236200AbiGMOYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbiGMOYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:24:19 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8042F390
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 07:24:18 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id g4so10619819pgc.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 07:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iZg4jV9qnfZ0cCGgCJhgdQT0+ATbFFKvPnKzJuPEFBg=;
        b=nIjE3fdScssfGbGhj5AXLnpdMh20vhlpDufc+QPyNHwtFHhXLJzOstGW7gTkD4OQKK
         FHDb8LG8k6W/FGT85Wep9ks6SInwfyFg4fnzpNzAqCLiRROa6MbsPO33ZRwrBINoYfz0
         0Zxj4R5Yg3PsEpET4L15WQOksv1YepAR+SMHXFKsOcBs/VxbHgcs25qlRsS7wWifP3L3
         1CV/mA6TLlEVx+XlsnPeq2B722iio3vXtP2LXnkp7yOUKg+Og39xri7BZTWb0r4Ih4Ak
         KPWewfgTb79s6NsadVNBVzSgKV7AiCsvGnSjoExlEoQjA9y8h6uYz9yj921WELAF58qz
         BZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iZg4jV9qnfZ0cCGgCJhgdQT0+ATbFFKvPnKzJuPEFBg=;
        b=0qt+K2otwU/N+L1q/4jZ4Qyg1zSz+VMyzpVquC8WcRUPnnl2FGu7wPTM+R8obKBc7J
         Yy+HNYwT+k8zrh5eRzX9sCwj2dMMFlRp3l+yY9nTbm7rhUFPIZragnVFB/m0E469efOH
         j18q+ND8+7Ve+gI26XGgKRZOW/AxAooBOLIhwvw3EzZjTEI059FOm1YIGEF7MTSt9JtV
         srPACaE9jbJsjwPFlwtkKa447KCyyfj97fex0Or4jOLfvW3X5yhkS85MWqcx4XB3iapX
         U7ggxi6EziVYYcLLLUHNVnr8y5tZZAugagOyNJvROYllB7eS02/FbPQlXUofDlcgPF+k
         cbVw==
X-Gm-Message-State: AJIora95ZdzJliJ1ib7C665sUFG4gwFlp1vdcCP/AOkyNCroJbH4etGc
        agd+GvLPFBLxyq7ROP141BpN6Q==
X-Google-Smtp-Source: AGRyM1vxsQVbA5kAcWs5mJCADfkSTANLlvfyl4jcgvqjBIWIjnx87Wn/UG9vyvu2JXY/xXEaMW5r1Q==
X-Received: by 2002:aa7:88d0:0:b0:52a:f0ea:1fbb with SMTP id k16-20020aa788d0000000b0052af0ea1fbbmr3400167pff.85.1657722257668;
        Wed, 13 Jul 2022 07:24:17 -0700 (PDT)
Received: from google.com (55.212.185.35.bc.googleusercontent.com. [35.185.212.55])
        by smtp.gmail.com with ESMTPSA id y145-20020a626497000000b00528655cd6a6sm8928260pfb.53.2022.07.13.07.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 07:24:17 -0700 (PDT)
Date:   Wed, 13 Jul 2022 07:24:14 -0700
From:   Zach O'Keefe <zokeefe@google.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [akpm-mm:mm-unstable 284/293] mm/khugepaged.c:2409
 madvise_collapse() warn: possible memory leak of 'cc'
Message-ID: <Ys7Vjt5QXz8XK1LZ@google.com>
References: <202207100715.TBIYQ4fc-lkp@intel.com>
 <CAHbLzkoFjZoX0WFy9YaOO1rEC+=yyytgDimapeTEyuNyMNTHLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkoFjZoX0WFy9YaOO1rEC+=yyytgDimapeTEyuNyMNTHLg@mail.gmail.com>
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

On Jul 12 10:02, Yang Shi wrote:
> On Tue, Jul 12, 2022 at 5:36 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-unstable
> > head:   0e9f775fb0b4adf1a4ef50ea156ead09a0fc5194
> > commit: 9f626ffb1d1c5c26b4a8e0fdffec784a5f773274 [284/293] mm/madvise: introduce MADV_COLLAPSE sync hugepage collapse
> > config: i386-randconfig-m021 (https://download.01.org/0day-ci/archive/20220710/202207100715.TBIYQ4fc-lkp@intel.com/config)
> > compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
> >
> > If you fix the issue, kindly add following tag where applicable
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> >
> > smatch warnings:
> > mm/khugepaged.c:2409 madvise_collapse() warn: possible memory leak of 'cc'
> >
> > vim +/cc +2409 mm/khugepaged.c
> >
> > 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2387  int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,
> > 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2388                 unsigned long start, unsigned long end)
> > 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2389  {
> > 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2390    struct collapse_control *cc;
> > 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2391    struct mm_struct *mm = vma->vm_mm;
> > 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2392    unsigned long hstart, hend, addr;
> > 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2393    int thps = 0, last_fail = SCAN_FAIL;
> > 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2394    bool mmap_locked = true;
> > 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2395
> > 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2396    BUG_ON(vma->vm_start > start);
> > 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2397    BUG_ON(vma->vm_end < end);
> > 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2398
> > 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2399    cc = kmalloc(sizeof(*cc), GFP_KERNEL);
> > 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2400    if (!cc)
> > 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2401            return -ENOMEM;
> > 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2402    cc->is_khugepaged = false;
> > 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2403    cc->last_target_node = NUMA_NO_NODE;
> > 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2404
> > 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2405    *prev = vma;
> > 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2406
> > 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2407    /* TODO: Support file/shmem */
> > 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2408    if (!vma->anon_vma || !vma_is_anonymous(vma))
> > 9f626ffb1d1c5c Zach O'Keefe 2022-07-06 @2409            return -EINVAL;
> 
> It seems better to move the cc kmalloc after the anonymous vma check?
>

Agreed - something I only noticed when fixing this. I've cleaned up some
ordering here, now looks like:

---8<---
	BUG_ON(vma->vm_start > start);
	BUG_ON(vma->vm_end < end);

	*prev = vma;

        /* TODO: Support file/shmem */
        if (!vma->anon_vma || !vma_is_anonymous(vma))
                return -EINVAL;

	if (!hugepage_vma_check(vma, vma->vm_flags, false, false, false))
		return -EINVAL;

	cc = kmalloc(sizeof(*cc), GFP_KERNEL);
	if (!cc)
		return -ENOMEM;
	cc->is_khugepaged = false;
	cc->last_target_node = NUMA_NO_NODE;

	mmgrab(mm);
	lru_add_drain_all();

	hstart = (start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK;
	hend = end & HPAGE_PMD_MASK;

	for (addr = hstart; addr < hend; addr += HPAGE_PMD_SIZE) {
---8<---
out_nolock:
	mmap_assert_locked(mm);
	mmdrop(mm);
	kfree(cc);
---8<---

> >
> > kfree(cc);?
> >
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://01.org/lkp
> >
> >
