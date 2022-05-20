Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCD952EACE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 13:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348538AbiETLbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 07:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348556AbiETLbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 07:31:05 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A81815AB0B
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 04:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653046233; x=1684582233;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ek3Un87zV6kEiotbIl4DIu9SOlYA+IdCTrS8AmQff18=;
  b=sR8ge11dDrrWfpJm+AM2uGpLePaBD879mq8mtGNJHYNgNFO37uO93nsh
   Jk3Jxl/3+/jaDNwjdIIJNEzOdVLqvIAAj5SdxU+WlfjZNdExtxZJUN+gk
   HiZ2XBvALjsUYwPJPUE9u+W4VrDHyDEbVPpMfg0xGA0mJ/T4XqGehWXh4
   M=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 20 May 2022 04:30:32 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 04:30:32 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 20 May 2022 04:30:32 -0700
Received: from qian (10.80.80.8) by nalasex01a.na.qualcomm.com (10.47.209.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 20 May
 2022 04:30:30 -0700
Date:   Fri, 20 May 2022 07:30:28 -0400
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
Message-ID: <Yod71OhUa3VWWPCG@qian>
References: <B621B4DD-5D11-4F0E-AFF5-F8684AE37E57@nvidia.com>
 <20220426210801.GA1038@qian>
 <2B9844C8-6D35-41E2-ACB2-9854E7A9C29F@nvidia.com>
 <20220427132720.GC71@qian>
 <1D88AE1B-4DFC-400F-A054-662E3824C9AF@nvidia.com>
 <A1956578-A851-4BF3-BD57-12571244DB5E@nvidia.com>
 <20220428123308.GA71@qian>
 <0E75B247-8150-48A3-83AE-56C586030006@nvidia.com>
 <YoavU/+NfQIzQiDF@qian>
 <F6598450-EFE0-4EA9-912B-A727DE1F8185@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <F6598450-EFE0-4EA9-912B-A727DE1F8185@nvidia.com>
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

On Thu, May 19, 2022 at 05:35:15PM -0400, Zi Yan wrote:
> Do you have a complete reproducer? From your printout, it is clear that a 512-page compound
> page caused the infinite loop, because the page was not migrated and the code kept
> retrying. But __alloc_contig_migrate_range() is supposed to return non-zero to tell the
> code the page cannot be migrated and the code will goto failed without retrying. It will be
> great you can share what exactly has run after boot, so that I can reproduce locally to
> identify what makes __alloc_contig_migrate_range() return 0 without migrating the page.

The reproducer is just to run the same script I shared with you previously
multiple times instead. It is still quite reproducible here as it usually
happens within a hour.

$ for i in `seq 1 100`; do ./flip_mem.py; done

> Can you also try the patch below to see if it fixes the infinite loop?
> 
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index b3f074d1682e..abde1877bbcb 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -417,10 +417,9 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, gfp_t gfp_flags,
>                                 order = 0;
>                                 outer_pfn = pfn;
>                                 while (!PageBuddy(pfn_to_page(outer_pfn))) {
> -                                       if (++order >= MAX_ORDER) {
> -                                               outer_pfn = pfn;
> -                                               break;
> -                                       }
> +                                       /* abort if the free page cannot be found */
> +                                       if (++order >= MAX_ORDER)
> +                                               goto failed;
>                                         outer_pfn &= ~0UL << order;
>                                 }
>                                 pfn = outer_pfn;
> 

Can you explain a bit how this patch is the right thing to do here? I am a
little bit worry about shooting into the dark. Otherwise, I'll be running
the off-by-one part over the weekend to see if that helps.
