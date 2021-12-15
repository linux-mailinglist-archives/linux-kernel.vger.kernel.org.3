Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735D74755ED
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 11:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236677AbhLOKMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 05:12:43 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:44670 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbhLOKMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 05:12:42 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 276E521106;
        Wed, 15 Dec 2021 10:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639563161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+m11QBU81Zd70kDcW78Gw2InB8DF1Mzu3b5xIo+K/Ng=;
        b=f9tOBGKkty1CLcmfOjNG5XntBeTQo5veDIzZ3HAqlEzrWpPAa0TelIuIDkrYz5LO4wP0iV
        3c1J+IJyO9cCnmP+58lihp7T2qkCgf/ewMq2sqDOzYJI+dVHDIV30yImgPcMlWAZNZw/L8
        7pgKG+3pR5KXzv/7pLkrlezdNA8zNSw=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D0EF2A3B83;
        Wed, 15 Dec 2021 10:12:40 +0000 (UTC)
Date:   Wed, 15 Dec 2021 11:12:40 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dennis Zhou <dennis@kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Oscar Salvador <osalvador@suse.de>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux-foundation.org>
Subject: Re: [PATCH v2 2/4] mm: handle uninitialized numa nodes gracefully
Message-ID: <Ybm/mMY1XaM0VebV@dhcp22.suse.cz>
References: <20211214100732.26335-3-mhocko@kernel.org>
 <202112151219.xAI8NaQR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202112151219.xAI8NaQR-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 15-12-21 12:47:16, kernel test robot wrote:
> Hi Michal,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on hnaz-mm/master]
> 
> url:    https://github.com/0day-ci/linux/commits/Michal-Hocko/mm-memory_hotplug-make-arch_alloc_nodedata-independent-on-CONFIG_MEMORY_HOTPLUG/20211214-190817
> base:   https://github.com/hnaz/linux-mm master
> config: ia64-defconfig (https://download.01.org/0day-ci/archive/20211215/202112151219.xAI8NaQR-lkp@intel.com/config)
> compiler: ia64-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/65c560a3ac2561750c1dc71213f042e660b9bbc0
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Michal-Hocko/mm-memory_hotplug-make-arch_alloc_nodedata-independent-on-CONFIG_MEMORY_HOTPLUG/20211214-190817
>         git checkout 65c560a3ac2561750c1dc71213f042e660b9bbc0
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
> 
> >> WARNING: modpost: vmlinux.o(.text+0x566a2): Section mismatch in reference from the function arch_alloc_nodedata() to the function .init.text:memblock_alloc_try_nid()
> The function arch_alloc_nodedata() references
> the function __init memblock_alloc_try_nid().
> This is often because arch_alloc_nodedata lacks a __init
> annotation or the annotation of memblock_alloc_try_nid is wrong.

Thanks for the report. This should do the trick. I will fold it into the
patch.

diff --git a/arch/ia64/mm/discontig.c b/arch/ia64/mm/discontig.c
index b4c46925792f..dd0cf4834eaa 100644
--- a/arch/ia64/mm/discontig.c
+++ b/arch/ia64/mm/discontig.c
@@ -608,7 +608,7 @@ void __init paging_init(void)
 	zero_page_memmap_ptr = virt_to_page(ia64_imva(empty_zero_page));
 }
 
-pg_data_t *arch_alloc_nodedata(int nid)
+pg_data_t * __init arch_alloc_nodedata(int nid)
 {
 	unsigned long size = compute_pernodesize(nid);
 
-- 
Michal Hocko
SUSE Labs
