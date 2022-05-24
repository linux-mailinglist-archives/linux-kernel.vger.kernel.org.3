Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E02532F55
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 18:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239774AbiEXQ7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 12:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239789AbiEXQ7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 12:59:24 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFA07C179
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 09:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653411560; x=1684947560;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G8zqKzbAC43VBmVdOb+NPWZaQn7ZOrqgIiOJCocAtuM=;
  b=QNPOxklweYtOQRoMk/zHqQUropfckaz3MuVuWe/CH1SJqwPNOj0KfZMN
   hjKk1sYxO50q/RELxJ2/qEJLE9C/qHAt8N768cUHfD85hCcEGrX2sxnhL
   yzI2qPpC9bj5+o2Y3b1Vum8CooopOky0zqxMBODAWW7VI5wgv3sw1WWem
   w=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 24 May 2022 09:59:19 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 09:59:19 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 24 May 2022 09:59:19 -0700
Received: from qian (10.80.80.8) by nalasex01a.na.qualcomm.com (10.47.209.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 24 May
 2022 09:59:17 -0700
Date:   Tue, 24 May 2022 12:59:15 -0400
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
Message-ID: <Yo0O4+tutrBd2fpB@qian>
References: <0E75B247-8150-48A3-83AE-56C586030006@nvidia.com>
 <YoavU/+NfQIzQiDF@qian>
 <F6598450-EFE0-4EA9-912B-A727DE1F8185@nvidia.com>
 <Yod71OhUa3VWWPCG@qian>
 <48D48FDC-B8DD-41C9-B56A-EBD7314883AB@nvidia.com>
 <A03D6267-5945-4A6A-9C55-5F3DDDB35CC2@nvidia.com>
 <Yofu5wUgov+2eVCE@qian>
 <C1636974-A315-4E0A-81C2-845878429920@nvidia.com>
 <YognDJT8C/o1Mt+y@qian>
 <FB2C38FF-1AF3-4A8D-94C0-AE5014E5592E@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <FB2C38FF-1AF3-4A8D-94C0-AE5014E5592E@nvidia.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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

On Sun, May 22, 2022 at 12:54:04PM -0400, Zi Yan wrote:
> Can you try the patch below on top of linux-next to see if it fixes the infinite loop issue?
> Thanks.
> 
> 1. split_free_page() change is irrelevant but to make the code more robust.
> 2. using set_migratetype_isolate() in isolate_single_pageblock() is to properly mark the pageblock
> MIGRATE_ISOLATE.
> 3. setting to-be-migrated page's pageblock to MIGRATE_ISOLATE is to avoid a possible race
> that another thread might take the free page after migration.
> 4. off-by-one fix and no retry if free page is not found after migration like I added before.

Cool. I'll be running it this week and report back next week.
