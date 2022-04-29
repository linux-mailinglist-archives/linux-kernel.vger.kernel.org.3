Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9552515032
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378764AbiD2QGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378762AbiD2QGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:06:42 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9095E72E0F;
        Fri, 29 Apr 2022 09:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651248204; x=1682784204;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sSK/o9FhKlUdMjW2NdP5Bg7dQkRtO4bEr5mQPkXPNXs=;
  b=tP5uiMhaIEVwDhNNk++kQsCk2nBi9S34OJdiD03ws7NkRWf4Znij5z/u
   W3EhPQXpcoybhPU/fBorMt33oYchbgJJpicbuc0SuTN53fqTJ1gPa+Qep
   nOys+pnbPvmBquqxxpVrtYdc81gkakqZ3wZm1+CLrBSuguCn8NAT4T7cy
   4=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 29 Apr 2022 09:03:24 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 09:03:23 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 29 Apr 2022 09:03:22 -0700
Received: from qian (10.80.80.8) by nalasex01a.na.qualcomm.com (10.47.209.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 29 Apr
 2022 09:03:19 -0700
Date:   Fri, 29 Apr 2022 12:03:17 -0400
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
CC:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        <lkft-triage@lists.linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>, "Zi Yan" <ziy@nvidia.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David Hildenbrand" <david@redhat.com>,
        Eric Ren <renzhengeek@gmail.com>,
        "kernel test robot" <lkp@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Mike Rapoport" <rppt@linux.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        "Oscar Salvador" <osalvador@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Chen Wandun <chenwandun@huawei.com>, NeilBrown <neilb@suse.de>,
        <joao.m.martins@oracle.com>, <mawupeng1@huawei.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Song Liu <song@kernel.org>
Subject: Re: [next] mm: libhugetlbfs: WARNING: at mm/page_alloc.c:5368
 __alloc_pages
Message-ID: <20220429160317.GA71@qian>
References: <CA+G9fYveMF-NU-rvrsbaora2g2QWxrkF7AWViuDrJyN9mNScJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CA+G9fYveMF-NU-rvrsbaora2g2QWxrkF7AWViuDrJyN9mNScJg@mail.gmail.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 04:50:25PM +0530, Naresh Kamboju wrote:
> Following kernel warning notices on Linux next-20220427 till date next-20220429
> on qemu_arm64 and arm64 devices.
> 
> While testing libhugetlbfs test suite and ltp mm and hugetlb.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Test log:
> ----------
> truncate_above_4GB (2M: 64): PASS
> brk_near_huge (2M: 64): brk_near_huge: malloc.c:2401: sysmalloc:
> Assertion `(old_top == initial_top (av) && old_size == 0) ||
> ((unsigned long) (old_size) >= MINSIZE && prev_inuse (old_top) &&
> ((unsigned long) old_end & (pagesize - 1)) == 0)' failed.
> [   15.685019] audit: type=1701 audit(1651222753.772:25):
> auid=4294967295 uid=0 gid=0 ses=4294967295 pid=454
> comm=\"brk_near_huge\"
> exe=\"/usr/lib/libhugetlbfs/tests/obj64/brk_near_huge\" sig=6 res=1
> [   15.685629] ------------[ cut here ]------------
> [   15.685631] WARNING: CPU: 2 PID: 454 at mm/page_alloc.c:5368

Naresh, I am having difficult to reproduce this reliablely. If you have
spare cycles, do you mind reverting those to see if you can still
reproduce? I can't seems to find other recent commits more suspicious
than that series.

37e73e3b0a9d drivers: virtio_mem: use pageblock size as the minimum virtio_mem size.
d2b9cd2acb2b mm: cma: use pageblock_order as the single alignment
7f125582227e mm: page_isolation: enable arbitrary range page isolation.
fb009b307b21 mm: make alloc_contig_range work at pageblock granularity
7c7e18d510f4 mm: page_isolation: check specified range for unmovable pages
6a242a94b883 mm: page_isolation: move has_unmovable_pages() to mm/page_isolation.c

$ git revert --no-edit e389355485b7..37e73e3b0a9d
