Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250BB5422D2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbiFHF1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 01:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbiFHF0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 01:26:50 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D555A1912EE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 19:46:12 -0700 (PDT)
X-UUID: 69da6bb4290e464fb48a30e429573fb0-20220608
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:f0791bd9-c4fe-44be-bb6a-13edab8da308,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:51
X-CID-INFO: VERSION:1.1.5,REQID:f0791bd9-c4fe-44be-bb6a-13edab8da308,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:51
X-CID-META: VersionHash:2a19b09,CLOUDID:1d6a05e5-2ba2-4dc1-b6c5-11feb6c769e0,C
        OID:8b8c977f2a46,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:0,BEC:nil
X-UUID: 69da6bb4290e464fb48a30e429573fb0-20220608
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1553078410; Wed, 08 Jun 2022 10:46:08 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 8 Jun 2022 10:46:07 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Wed, 8 Jun 2022 10:46:07 +0800
Message-ID: <c423c281f6739b7d847e2375c65ec2a4cf839d01.camel@mediatek.com>
Subject: Re: [PATCH v2 0/4] mm: kmemleak: store objects allocated with
 physical address separately and check when scan
From:   Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
To:     Patrick Wang <patrick.wang.shcn@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yee Lee =?UTF-8?Q?=28=E6=9D=8E=E5=BB=BA=E8=AA=BC=29?= 
        <Yee.Lee@mediatek.com>, <kuan-ying.lee@mediatek.com>
Date:   Wed, 8 Jun 2022 10:46:07 +0800
In-Reply-To: <20220603035415.1243913-1-patrick.wang.shcn@gmail.com>
References: <20220603035415.1243913-1-patrick.wang.shcn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-06-03 at 11:54 +0800, Patrick Wang wrote:
> The kmemleak_*_phys() interface uses "min_low_pfn" and
> "max_low_pfn" to check address. But on some architectures,
> kmemleak_*_phys() is called before those two variables
> initialized. The following steps will be taken:
> 
> 1) Add OBJECT_PHYS flag and rbtree for the objects allocated
>    with physical address
> 2) Store physical address in objects if allocated with OBJECT_PHYS
> 3) Check the boundary when scan instead of in kmemleak_*_phys()
> 
> This patch set will solve:
> https://lore.kernel.org/r/20220527032504.30341-1-yee.lee@mediatek.com
> 
https://lore.kernel.org/r/9dd08bb5-f39e-53d8-f88d-bec598a08c93@gmail.com

Hi Patrick,

If this patchset fix the above issue, I think we need to add
the below fixes tag.

Fixes: 23c2d497de21 ("mm: kmemleak: take a full lowmem check in
kmemleak_*_phys()")

Thanks.

> 
> v1: 
> https://lore.kernel.org/r/20220531150823.1004101-1-patrick.wang.shcn@gmail.com
> 
> v1->v2:
>  - add rbtree for the objects allocated with physical address
>  - store physical address in objects if allocated with OBJECT_PHYS
>  - check the upper object boundary as well and avoid duplicate check
> 
> Patrick Wang (4):
>   mm: kmemleak: add OBJECT_PHYS flag for objects allocated with
> physical
>     address
>   mm: kmemleak: add rbtree for objects allocated with physical
> address
>   mm: kmemleak: handle address stored in object based on its type
>   mm: kmemleak: kmemleak_*_phys() set address type and check PA when
>     scan
> 
>  mm/kmemleak.c | 193 ++++++++++++++++++++++++++++++++--------------
> ----
>  1 file changed, 123 insertions(+), 70 deletions(-)
> 
> -- 
> 2.25.1
> 
> 

