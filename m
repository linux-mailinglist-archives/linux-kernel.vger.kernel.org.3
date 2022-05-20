Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0BA52F64C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 01:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237843AbiETXlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 19:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbiETXlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 19:41:08 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CAA1E3E2
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 16:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653090066; x=1684626066;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RXc+ONkFyVVtEjPAyk2CpuG/lsV8gZbDITKeLwGX1u8=;
  b=ywjlBwUgjd66YvzkxGiFX/9htrw9Bsw1mWNwiSHklpjzG3AAH+CDy8PV
   ww1Y+mBtj+mlYZTRMPSjkRX3xYzixJRHNiKZ5XybI0KUNVgumawW+mKgs
   v5cX8BtxEiMaRWhsXaoC88YVaUTaaZorTTuOe7LkUFSzPymT361NAP/zv
   U=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 20 May 2022 16:41:05 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 16:41:05 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 20 May 2022 16:41:04 -0700
Received: from qian (10.80.80.8) by nalasex01a.na.qualcomm.com (10.47.209.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 20 May
 2022 16:41:02 -0700
Date:   Fri, 20 May 2022 19:41:00 -0400
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
Message-ID: <YognDJT8C/o1Mt+y@qian>
References: <A1956578-A851-4BF3-BD57-12571244DB5E@nvidia.com>
 <20220428123308.GA71@qian>
 <0E75B247-8150-48A3-83AE-56C586030006@nvidia.com>
 <YoavU/+NfQIzQiDF@qian>
 <F6598450-EFE0-4EA9-912B-A727DE1F8185@nvidia.com>
 <Yod71OhUa3VWWPCG@qian>
 <48D48FDC-B8DD-41C9-B56A-EBD7314883AB@nvidia.com>
 <A03D6267-5945-4A6A-9C55-5F3DDDB35CC2@nvidia.com>
 <Yofu5wUgov+2eVCE@qian>
 <C1636974-A315-4E0A-81C2-845878429920@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <C1636974-A315-4E0A-81C2-845878429920@nvidia.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 05:56:52PM -0400, Zi Yan wrote:
> Do you have the page information like refcount, map count, mapping, index, and
> page flags? That would be more helpful. Thanks.

page:fffffc200c7f8000 refcount:393 mapcount:1 mapping:0000000000000000 index:0xffffbb800 pfn:0x8039fe00
head:fffffc200c7f8000 order:9 compound_mapcount:0 compound_pincount:0
memcg:ffff40026005a000
anon flags: 0xbfffc000009001c(uptodate|dirty|lru|head|swapbacked|node=0|zone=2|lastcpupid=0xffff)
raw: 0bfffc000009001c fffffc2007b74048 fffffc2009c087c8 ffff08038dab9189
raw: 0000000ffffbb800 0000000000000000 0000018900000000 ffff40026005a000

> I cannot reproduce it locally after hundreds of iterations of flip_mem.py on my
> x86_64 VM and bare metal.
> 
> What ARM machine are you using? I wonder if I am able to get one locally.

Ampere Altra.
