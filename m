Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A8052F3DC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 21:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351317AbiETTlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 15:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbiETTle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 15:41:34 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6272F2AE0C
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 12:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653075692; x=1684611692;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BLnF/D+lG7XoVC8hcx1ysY8qeCVaYpT4bQrbRzkwbzk=;
  b=aK6icuj/93/Icp91gQzV0Xr2xgtdCIy9kCnqUZty7r1e2UlNtN2gHKOf
   71lVEmjxV7D5DxDzMDWcI2rcrgFP0x3FgePhIoe1weBRGEPs0zkMs+jaJ
   CrQkOWaTClxD1x0U/LVLjTud7BU86p3X8A3dFbvXHlYrzoVAyulFWHmIJ
   8=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 20 May 2022 12:41:32 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 12:41:31 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 20 May 2022 12:41:30 -0700
Received: from qian (10.80.80.8) by nalasex01a.na.qualcomm.com (10.47.209.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 20 May
 2022 12:41:29 -0700
Date:   Fri, 20 May 2022 15:41:27 -0400
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Zi Yan <ziy@nvidia.com>
CC:     David Hildenbrand <david@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Oscar Salvador" <osalvador@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v11 0/6] Use pageblock_order for cma and
 alloc_contig_range alignment.
Message-ID: <Yofu5wUgov+2eVCE@qian>
References: <20220427132720.GC71@qian>
 <1D88AE1B-4DFC-400F-A054-662E3824C9AF@nvidia.com>
 <A1956578-A851-4BF3-BD57-12571244DB5E@nvidia.com>
 <20220428123308.GA71@qian>
 <0E75B247-8150-48A3-83AE-56C586030006@nvidia.com>
 <YoavU/+NfQIzQiDF@qian>
 <F6598450-EFE0-4EA9-912B-A727DE1F8185@nvidia.com>
 <Yod71OhUa3VWWPCG@qian>
 <48D48FDC-B8DD-41C9-B56A-EBD7314883AB@nvidia.com>
 <A03D6267-5945-4A6A-9C55-5F3DDDB35CC2@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <A03D6267-5945-4A6A-9C55-5F3DDDB35CC2@nvidia.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 10:13:51AM -0400, Zi Yan wrote:
> Also, do you mind providing the page dump of the 512-page compound page? I would like
> to know what page caused the issue.

 page last allocated via order 9, migratetype Movable, gfp_mask 0x3c24ca(GFP_TRANSHUGE|__GFP_THISNODE), pid 831, tgid 831 (khugepaged), ts 3899865924520, free_ts 3821953009040
  post_alloc_hook
  get_page_from_freelist
  __alloc_pages
  khugepaged_alloc_page
  collapse_huge_page
  khugepaged_scan_pmd
  khugepaged_scan_mm_slot
  khugepaged
  kthread
  ret_from_fork
 page last free stack trace:
  free_pcp_prepare
  free_unref_page
  free_compound_page
  free_transhuge_page
  __put_compound_page
  release_pages
  free_pages_and_swap_cache
  tlb_batch_pages_flush
  tlb_finish_mmu
  exit_mmap
  __mmput
  mmput
  exit_mm
  do_exit
  do_group_exit
  __arm64_sys_exit_group
