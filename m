Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E186571BAB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 15:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233310AbiGLNq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 09:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233280AbiGLNqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 09:46:53 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1B52AE32
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:46:52 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id r1so7281475plo.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i7pZ4PcipKYLrg0ho7Izlf0nD/aZAytT61KCebmsGXA=;
        b=j7EIx30iRF+2HYXv+oTF5XP+Hclxwo8vMAG9yALcmlAzyWtJK91XzrMsj2CeteF0A1
         mBNc+huHbJkp5zItEfuc29jgdyYV+nuMaULb3KVdNHxDiP5Zr6AE1gJutQc5QClX4fqq
         AC/Zlg20TiSEUQk0X6rXnhH3GshANyr8yKxm+MJk1xEM/dNYNFIT5f+39bw9RRiGeaYr
         iFpBWTuISkl0jcP3S9rqcpJWvdP9suHkv41nFnn7TwuDply6hwgyi3JqQJ0USFd6dPK9
         Nel3FNcICqnnSoj5KO3JpsrXnniTQEHQFyNoOD27y3l4w8VqOEJCCG+5c/3qvx6Wo/PI
         SDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i7pZ4PcipKYLrg0ho7Izlf0nD/aZAytT61KCebmsGXA=;
        b=k2/aBJnNRqHYmE6rWfuBQQl7r//t/2PQDJbHrBhnzfFsCwYqCPnU465l5+MLdQjc4P
         FZTeiT7zKrbiTHhyVNmfGCIghiiHk0kCfn3eDgZzNm83s1MpSS+cz6aeeqPBQTKYjaWY
         znUYadKB6gMVO49+tGt9EtZ0Gu5jq6f19NoYBNLYLgyNMVwjTHEOKzZBn8mhHVhs/BhP
         zUXUVm3mQU7+KmTubyelLetrlaHsEbmzPwjEIzkKVxyV0BTILrbg/gsuGNCms9U7gK+l
         K3teGAXCNYvFhgSFYZgXx2RYdKnama0cvo81lvoNJ7Ue4N/lAclJa1q+H9cjSRT+xCtO
         daNA==
X-Gm-Message-State: AJIora+pt6MyNqxm9gx/fxS4WJOR7hVT/Vehu+7qsQ+kBCqvRnqz0r3X
        8/UgTxlNiPli0BIVRwIBjjXF+g==
X-Google-Smtp-Source: AGRyM1tvY17Lh7iUPOBQUQuMP3B7mO9AeKvogeiXgqztU0GtsnRE+TXC9K1pgwLxypsdjFjrEw07ag==
X-Received: by 2002:a17:90b:388e:b0:1f0:3d7f:e620 with SMTP id mu14-20020a17090b388e00b001f03d7fe620mr4617398pjb.31.1657633612049;
        Tue, 12 Jul 2022 06:46:52 -0700 (PDT)
Received: from google.com (55.212.185.35.bc.googleusercontent.com. [35.185.212.55])
        by smtp.gmail.com with ESMTPSA id c38-20020a631c66000000b0041166bf9ca8sm6191311pgm.34.2022.07.12.06.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 06:46:51 -0700 (PDT)
Date:   Tue, 12 Jul 2022 06:46:48 -0700
From:   Zach O'Keefe <zokeefe@google.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [akpm-mm:mm-unstable 284/293] mm/khugepaged.c:2409
 madvise_collapse() warn: possible memory leak of 'cc'
Message-ID: <Ys17SBJRS7XaE6nA@google.com>
References: <202207100715.TBIYQ4fc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202207100715.TBIYQ4fc-lkp@intel.com>
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

On Jul 12 15:35, Dan Carpenter wrote:
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
> 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2388  		     unsigned long start, unsigned long end)
> 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2389  {
> 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2390  	struct collapse_control *cc;
> 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2391  	struct mm_struct *mm = vma->vm_mm;
> 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2392  	unsigned long hstart, hend, addr;
> 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2393  	int thps = 0, last_fail = SCAN_FAIL;
> 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2394  	bool mmap_locked = true;
> 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2395  
> 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2396  	BUG_ON(vma->vm_start > start);
> 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2397  	BUG_ON(vma->vm_end < end);
> 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2398  
> 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2399  	cc = kmalloc(sizeof(*cc), GFP_KERNEL);
> 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2400  	if (!cc)
> 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2401  		return -ENOMEM;
> 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2402  	cc->is_khugepaged = false;
> 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2403  	cc->last_target_node = NUMA_NO_NODE;
> 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2404  
> 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2405  	*prev = vma;
> 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2406  
> 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2407  	/* TODO: Support file/shmem */
> 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2408  	if (!vma->anon_vma || !vma_is_anonymous(vma))
> 9f626ffb1d1c5c Zach O'Keefe 2022-07-06 @2409  		return -EINVAL;
> 
> kfree(cc);?
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
> 

Yikes. Glad this was caught - my apologies here.

Thanks Dan/lkp!
