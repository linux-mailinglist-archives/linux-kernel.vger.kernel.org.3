Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D089535828
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 06:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbiE0EAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 00:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiE0EA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 00:00:29 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8731FE27A8
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 21:00:18 -0700 (PDT)
X-UUID: 79e3affc5e114130ab9ecb68ccd392f1-20220527
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:e09e3188-6b5e-49a8-95e0-5fa1163c27c4,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:26,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:26
X-CID-INFO: VERSION:1.1.5,REQID:e09e3188-6b5e-49a8-95e0-5fa1163c27c4,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:26,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:26
X-CID-META: VersionHash:2a19b09,CLOUDID:44f86fb8-3c45-407b-8f66-25095432a27a,C
        OID:IGNORED,Recheck:0,SF:28|100|17|19|48|101,TC:nil,Content:0,EDM:-3,IP:ni
        l,URL:1,File:nil,QS:0,BEC:nil
X-UUID: 79e3affc5e114130ab9ecb68ccd392f1-20220527
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yee.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 945844797; Fri, 27 May 2022 12:00:12 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 27 May 2022 12:00:07 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Fri, 27 May 2022 12:00:07 +0800
Message-ID: <bff77f3044c0a4a400e0aa2d92fbd1de45a23473.camel@mediatek.com>
Subject: Re: [PATCH] mm: kmemleak: take a full lowmem check in
 kmemleak_*_phys()
From:   Yee Lee <yee.lee@mediatek.com>
To:     Patrick Wang <patrick.wang.shcn@gmail.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <catalin.marinas@arm.com>, <akpm@linux-foundation.org>,
        <sunny.kuo@mediatek.com>, <chinwen.chang@mediatek.com>
Date:   Fri, 27 May 2022 12:00:07 +0800
In-Reply-To: <20220413122925.33856-1-patrick.wang.shcn@gmail.com>
References: <20220413122925.33856-1-patrick.wang.shcn@gmail.com>
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

In arm64, some false leaks happen since memblock allocates memory 
eariler than that the pfn boundary (max_low_pfn/min_low_pfn) is
initialized. I would relax the checking condidtion when the boundary
is not ready. 

Please refer to the patch: https://lkml.org/lkml/2022/5/26/971
   
Not sure this work for the other archs like RISCV and for your
situation. Please help to review it.  

On Wed, 2022-04-13 at 20:29 +0800, Patrick Wang wrote:
> The kmemleak_*_phys() apis do not check the address for lowmem's min
> boundary, while the caller may pass an address below lowmem, which
> will trigger an oops:
> 
> # echo scan > /sys/kernel/debug/kmemleak
> [   54.888353] Unable to handle kernel paging request at virtual
> address ff5fffffffe00000
> [   54.888932] Oops [#1]
> [   54.889102] Modules linked in:
> [   54.889326] CPU: 2 PID: 134 Comm: bash Not tainted 5.18.0-rc1-
> next-20220407 #33
> [   54.889620] Hardware name: riscv-virtio,qemu (DT)
> [   54.889901] epc : scan_block+0x74/0x15c
> [   54.890215]  ra : scan_block+0x72/0x15c
> [   54.890390] epc : ffffffff801e5806 ra : ffffffff801e5804 sp :
> ff200000104abc30
> [   54.890607]  gp : ffffffff815cd4e8 tp : ff60000004cfa340 t0 :
> 0000000000000200
> [   54.890835]  t1 : 00aaaaaac23954cc t2 : 00000000000003ff s0 :
> ff200000104abc90
> [   54.891024]  s1 : ffffffff81b0ff28 a0 : 0000000000000000 a1 :
> ff5fffffffe01000
> [   54.891201]  a2 : ffffffff81b0ff28 a3 : 0000000000000002 a4 :
> 0000000000000001
> [   54.891377]  a5 : 0000000000000000 a6 : ff200000104abd7c a7 :
> 0000000000000005
> [   54.891552]  s2 : ff5fffffffe00ff9 s3 : ffffffff815cd998 s4 :
> ffffffff815d0e90
> [   54.891727]  s5 : ffffffff81b0ff28 s6 : 0000000000000020 s7 :
> ffffffff815d0eb0
> [   54.891903]  s8 : ffffffffffffffff s9 : ff5fffffffe00000 s10:
> ff5fffffffe01000
> [   54.892078]  s11: 0000000000000022 t3 : 00ffffffaa17db4c t4 :
> 000000000000000f
> [   54.892271]  t5 : 0000000000000001 t6 : 0000000000000000
> [   54.892408] status: 0000000000000100 badaddr: ff5fffffffe00000
> cause: 000000000000000d
> [   54.892643] [<ffffffff801e5a1c>] scan_gray_list+0x12e/0x1a6
> [   54.892824] [<ffffffff801e5d3e>] kmemleak_scan+0x2aa/0x57e
> [   54.892961] [<ffffffff801e633c>] kmemleak_write+0x32a/0x40c
> [   54.893096] [<ffffffff803915ac>] full_proxy_write+0x56/0x82
> [   54.893235] [<ffffffff801ef456>] vfs_write+0xa6/0x2a6
> [   54.893362] [<ffffffff801ef880>] ksys_write+0x6c/0xe2
> [   54.893487] [<ffffffff801ef918>] sys_write+0x22/0x2a
> [   54.893609] [<ffffffff8000397c>] ret_from_syscall+0x0/0x2
> [   54.894183] ---[ end trace 0000000000000000 ]---
> 
> So check the address for lowmem's min boundary.
> 
> Signed-off-by: Patrick Wang <patrick.wang.shcn@gmail.com>
> ---
>  mm/kmemleak.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index acd7cbb82..a182f5dda 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -1132,7 +1132,7 @@ EXPORT_SYMBOL(kmemleak_no_scan);
>  void __ref kmemleak_alloc_phys(phys_addr_t phys, size_t size, int
> min_count,
>  			       gfp_t gfp)
>  {
> -	if (!IS_ENABLED(CONFIG_HIGHMEM) || PHYS_PFN(phys) <
> max_low_pfn)
> +	if (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) <
> max_low_pfn)
>  		kmemleak_alloc(__va(phys), size, min_count, gfp);
>  }
>  EXPORT_SYMBOL(kmemleak_alloc_phys);
> @@ -1146,7 +1146,7 @@ EXPORT_SYMBOL(kmemleak_alloc_phys);
>   */
>  void __ref kmemleak_free_part_phys(phys_addr_t phys, size_t size)
>  {
> -	if (!IS_ENABLED(CONFIG_HIGHMEM) || PHYS_PFN(phys) <
> max_low_pfn)
> +	if (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) <
> max_low_pfn)
>  		kmemleak_free_part(__va(phys), size);
>  }
>  EXPORT_SYMBOL(kmemleak_free_part_phys);
> @@ -1158,7 +1158,7 @@ EXPORT_SYMBOL(kmemleak_free_part_phys);
>   */
>  void __ref kmemleak_not_leak_phys(phys_addr_t phys)
>  {
> -	if (!IS_ENABLED(CONFIG_HIGHMEM) || PHYS_PFN(phys) <
> max_low_pfn)
> +	if (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) <
> max_low_pfn)
>  		kmemleak_not_leak(__va(phys));
>  }
>  EXPORT_SYMBOL(kmemleak_not_leak_phys);
> @@ -1170,7 +1170,7 @@ EXPORT_SYMBOL(kmemleak_not_leak_phys);
>   */
>  void __ref kmemleak_ignore_phys(phys_addr_t phys)
>  {
> -	if (!IS_ENABLED(CONFIG_HIGHMEM) || PHYS_PFN(phys) <
> max_low_pfn)
> +	if (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) <
> max_low_pfn)
>  		kmemleak_ignore(__va(phys));
>  }
>  EXPORT_SYMBOL(kmemleak_ignore_phys);

