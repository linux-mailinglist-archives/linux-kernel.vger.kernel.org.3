Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB34572184
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 19:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbiGLRDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 13:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiGLRDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 13:03:06 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2467DCC00A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 10:03:06 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id s27so8097507pga.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 10:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eu38gMEhlCLDFy6KkUeAsbrjDX67p3SRtgMNjLCMflQ=;
        b=PJWVB/myr/wcbSmiFH8IWsfipFzM8q+DgJJNf26SDblPjf6i9tww20D44Tp6Auxtnx
         Wxa6nEPNfng7lVd8cDSG6W/PhUm8WQaqFYbaYWR6PIZESnkjssgadKSq+fZ5BuCBdmtg
         seE4e6SvrxqHxjhNM0oxPclJRv/tj0B0vlrqAEIds1/uYTkvhiVmSK6LPHjidJutHdWP
         wAgxpdcI2jB/Ke0eJaxrFHTtivzpZXDmErwobM60POTYTewnlbboJRklJN9zzjGz7zu7
         qDwrzxZJbWIoIE/ugSYzPA4eBK61H5Pvuv+YomAy9xNCI8s4GDXU56PmUBOp2jHGugHV
         IIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eu38gMEhlCLDFy6KkUeAsbrjDX67p3SRtgMNjLCMflQ=;
        b=nejp+s5y+GphJKpARPUUN+0snDrN5Y24db6qo97+LYY5t81LF3X06cuT3578ZKBos+
         3onyh9lSQ4q608yJiN8djrP28BTq+ZbJrh2nZgHmyhJFJ1UdUIOtM6zd3jc9GPrlZLr/
         qLcoZVdejRbWfj0GmLAe20zYa58MlMTlfnipsyoWI4Zv9R8Q6ylQAQwnsuV57VOpo0e5
         1TCtWwRwsgt+Q5aeI+TTCQVTvlzbJ2G2aCYY+PsYbCLZlU+ulAr4+tqhsrMnI2u8WLKm
         6CGwzjLgfzrETwjr4nUJuuVbNWyfyzfLUqoM/F/nbZPNizcXzq7Kt3LZZCWAZPE6K9v/
         CSow==
X-Gm-Message-State: AJIora9J5o5R9IeKRrkcE9XhdTncqecF4uw+LfJx2cEGgPyxUoWQymM2
        Qjg4/+3Kj8ofz4DKS0xkyoTah/yJinBbXD1dRVwjlU3ZCUY=
X-Google-Smtp-Source: AGRyM1txobi65oZyr08oYxAWdMJVeMiBiU9GqjYAztqFQDwa+JZ/PqOXEduhDypqtoEZMIz2uoSPlX7LP+O35+uezEw=
X-Received: by 2002:a63:9142:0:b0:412:b171:b6ac with SMTP id
 l63-20020a639142000000b00412b171b6acmr21029214pge.206.1657645385595; Tue, 12
 Jul 2022 10:03:05 -0700 (PDT)
MIME-Version: 1.0
References: <202207100715.TBIYQ4fc-lkp@intel.com>
In-Reply-To: <202207100715.TBIYQ4fc-lkp@intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 12 Jul 2022 10:02:53 -0700
Message-ID: <CAHbLzkoFjZoX0WFy9YaOO1rEC+=yyytgDimapeTEyuNyMNTHLg@mail.gmail.com>
Subject: Re: [akpm-mm:mm-unstable 284/293] mm/khugepaged.c:2409
 madvise_collapse() warn: possible memory leak of 'cc'
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, "Zach O'Keefe" <zokeefe@google.com>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 5:36 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-unstable
> head:   0e9f775fb0b4adf1a4ef50ea156ead09a0fc5194
> commit: 9f626ffb1d1c5c26b4a8e0fdffec784a5f773274 [284/293] mm/madvise: introduce MADV_COLLAPSE sync hugepage collapse
> config: i386-randconfig-m021 (https://download.01.org/0day-ci/archive/20220710/202207100715.TBIYQ4fc-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
>
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> smatch warnings:
> mm/khugepaged.c:2409 madvise_collapse() warn: possible memory leak of 'cc'
>
> vim +/cc +2409 mm/khugepaged.c
>
> 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2387  int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,
> 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2388                 unsigned long start, unsigned long end)
> 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2389  {
> 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2390    struct collapse_control *cc;
> 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2391    struct mm_struct *mm = vma->vm_mm;
> 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2392    unsigned long hstart, hend, addr;
> 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2393    int thps = 0, last_fail = SCAN_FAIL;
> 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2394    bool mmap_locked = true;
> 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2395
> 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2396    BUG_ON(vma->vm_start > start);
> 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2397    BUG_ON(vma->vm_end < end);
> 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2398
> 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2399    cc = kmalloc(sizeof(*cc), GFP_KERNEL);
> 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2400    if (!cc)
> 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2401            return -ENOMEM;
> 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2402    cc->is_khugepaged = false;
> 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2403    cc->last_target_node = NUMA_NO_NODE;
> 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2404
> 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2405    *prev = vma;
> 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2406
> 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2407    /* TODO: Support file/shmem */
> 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2408    if (!vma->anon_vma || !vma_is_anonymous(vma))
> 9f626ffb1d1c5c Zach O'Keefe 2022-07-06 @2409            return -EINVAL;

It seems better to move the cc kmalloc after the anonymous vma check?

>
> kfree(cc);?
>
>
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
>
>
