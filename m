Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F2752DED6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 22:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244927AbiESU6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 16:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244902AbiESU6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 16:58:02 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B41EC3D1
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 13:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652993880; x=1684529880;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u0Oy9BNZh8dXJmknsxZwwxQLExu6lgBD77SlAD1vJO8=;
  b=vxdx+VWy9SsfWcHsctIt+ru159asf4YzuE0XWKWB09c0G8tgCvCsxrH5
   WWR0xFhHqpk1FVy6DzEXz+u/TD87Y9xr8lbenOpEwSe5+wQR4kMFG2jrc
   RwvwWmrzk+VZFGny0DIk+zGVbRoLpNVKRnV37LVFzmKU+/tyXJpkJiaez
   o=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 19 May 2022 13:57:59 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 13:57:59 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 19 May 2022 13:57:59 -0700
Received: from qian (10.80.80.8) by nalasex01a.na.qualcomm.com (10.47.209.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 19 May
 2022 13:57:57 -0700
Date:   Thu, 19 May 2022 16:57:55 -0400
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
Message-ID: <YoavU/+NfQIzQiDF@qian>
References: <20220425143118.2850746-1-zi.yan@sent.com>
 <20220426201855.GA1014@qian>
 <B621B4DD-5D11-4F0E-AFF5-F8684AE37E57@nvidia.com>
 <20220426210801.GA1038@qian>
 <2B9844C8-6D35-41E2-ACB2-9854E7A9C29F@nvidia.com>
 <20220427132720.GC71@qian>
 <1D88AE1B-4DFC-400F-A054-662E3824C9AF@nvidia.com>
 <A1956578-A851-4BF3-BD57-12571244DB5E@nvidia.com>
 <20220428123308.GA71@qian>
 <0E75B247-8150-48A3-83AE-56C586030006@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0E75B247-8150-48A3-83AE-56C586030006@nvidia.com>
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

On Thu, Apr 28, 2022 at 08:39:06AM -0400, Zi Yan wrote:
> How about the one attached? I can apply it to next-20220428. Let me know
> if you are using a different branch. Thanks.

Zi, it turns out that the endless loop in isolate_single_pageblock() can
still be reproduced on today's linux-next tree by running the reproducer a
few times. With this debug patch applied, it keeps printing the same
values.

--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -399,6 +399,8 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, gfp_t gfp_flags,
                                };
                                INIT_LIST_HEAD(&cc.migratepages);

+                               printk_ratelimited("KK stucked pfn=%lu head_pfn=%lu nr_pages=%lu boundary_pfn=%lu\n", pfn, head_pfn, nr_pages, boundary_pfn);
                                ret = __alloc_contig_migrate_range(&cc, head_pfn,
                                                        head_pfn + nr_pages);

 isolate_single_pageblock: 179 callbacks suppressed
 KK stucked pfn=2151120384 head_pfn=2151120384 nr_pages=512 boundary_pfn=2151120896
 KK stucked pfn=2151120384 head_pfn=2151120384 nr_pages=512 boundary_pfn=2151120896
 KK stucked pfn=2151120384 head_pfn=2151120384 nr_pages=512 boundary_pfn=2151120896
 KK stucked pfn=2151120384 head_pfn=2151120384 nr_pages=512 boundary_pfn=2151120896
 KK stucked pfn=2151120384 head_pfn=2151120384 nr_pages=512 boundary_pfn=2151120896
 KK stucked pfn=2151120384 head_pfn=2151120384 nr_pages=512 boundary_pfn=2151120896
 KK stucked pfn=2151120384 head_pfn=2151120384 nr_pages=512 boundary_pfn=2151120896
 KK stucked pfn=2151120384 head_pfn=2151120384 nr_pages=512 boundary_pfn=2151120896
 KK stucked pfn=2151120384 head_pfn=2151120384 nr_pages=512 boundary_pfn=2151120896
 KK stucked pfn=2151120384 head_pfn=2151120384 nr_pages=512 boundary_pfn=2151120896
