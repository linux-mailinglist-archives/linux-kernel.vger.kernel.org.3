Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAE053EB10
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236900AbiFFM0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 08:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236893AbiFFM0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 08:26:14 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162492A3BBD
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 05:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654518374; x=1686054374;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1r4i7S693eNGdvCLoo3S36nunc2SGIhjZFlXs94KVRg=;
  b=sdAwZoKDSFcS1w5o+9XRppLlcUToTnT/zHdsLArT0ewH+zci8PoWCK7W
   K9U6vcyCfUW0o75YDxOEBH2OtUT8bOKuoCptUaGnpImqWXIfdSpCMNMED
   hzJ+PXe66wXVzdZPT7WHME9pVvd6S6kyeoeByaSY8hAefJVIfNluD/mkP
   4=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 06 Jun 2022 05:26:13 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 05:26:13 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 6 Jun 2022 05:26:13 -0700
Received: from qian (10.80.80.8) by nalasex01a.na.qualcomm.com (10.47.209.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 6 Jun 2022
 05:26:12 -0700
Date:   Mon, 6 Jun 2022 08:26:10 -0400
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Liam Howlett <liam.howlett@oracle.com>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v9 08/69] mm: start tracking VMAs with maple tree
Message-ID: <Yp3yYmNJ5dd8g8Ur@qian>
References: <20220504010716.661115-1-Liam.Howlett@oracle.com>
 <20220504010716.661115-10-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220504010716.661115-10-Liam.Howlett@oracle.com>
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

On Wed, May 04, 2022 at 01:07:52AM +0000, Liam Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> Start tracking the VMAs with the new maple tree structure in parallel with
> the rb_tree.  Add debug and trace events for maple tree operations and
> duplicate the rb_tree that is created on forks into the maple tree.
> 
> The maple tree is added to the mm_struct including the mm_init struct,
> added support in required mm/mmap functions, added tracking in kernel/fork
> for process forking, and used to find the unmapped_area and checked
> against what the rbtree finds.
> 
> This also moves the mmap_lock() in exit_mmap() since the oom reaper call
> does walk the VMAs.  Otherwise lockdep will be unhappy if oom happens.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
...
> @@ -842,6 +969,12 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
>  again:
>  	vma_adjust_trans_huge(orig_vma, start, end, adjust_next);
>  
> +	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
> +		if (exporter && exporter->anon_vma)
> +			unlink_anon_vmas(importer);
> +		return -ENOMEM;
> +	}
> +
>  	if (file) {
>  		mapping = file->f_mapping;
>  		root = &mapping->i_mmap;

Running a syscall fuzzer for a while could still trigger some memory leak reports.

unreferenced object 0xffff4021439c6100 (size 256):
  comm "trinity-c32", pid 1329067, jiffies 4301918356 (age 231692.944s)
  hex dump (first 32 bytes):
    00 61 9c 43 21 40 ff ff 1c b1 65 1d 02 40 ff ff  .a.C!@....e..@..
    ff 2f 42 97 ff ff 00 00 ff 2f 43 97 ff ff 00 00  ./B....../C.....
  backtrace:
    [<ffffd4be60434e28>] slab_post_alloc_hook+0x98/0xf0
    [<ffffd4be6043a2e0>] kmem_cache_alloc_bulk+0x26c/0x4ac
    [<ffffd4be60d549c8>] mas_alloc_nodes+0x1e8/0x500
    [<ffffd4be60d7cc68>] mas_preallocate+0xc8/0x210
    [<ffffd4be603607a0>] __vma_adjust+0x27c/0x1290
    __vma_adjust at mm/mmap.c:762
    [<ffffd4be60361b0c>] vma_merge+0x358/0x650
    [<ffffd4be60370e20>] mprotect_fixup+0x160/0x530
    [<ffffd4be60371544>] do_mprotect_pkey.constprop.0+0x354/0x710
    [<ffffd4be60371978>] __arm64_sys_mprotect+0x78/0x130
    [<ffffd4be5fc43a24>] invoke_syscall+0x74/0x260
    [<ffffd4be5fc43db8>] el0_svc_common.constprop.0+0x1a8/0x260
    [<ffffd4be5fc43f1c>] do_el0_svc+0xac/0xe0
    [<ffffd4be62d68144>] el0_svc+0x84/0x1c0
    [<ffffd4be62d687dc>] el0t_64_sync_handler+0xbc/0x140
    [<ffffd4be5fc12548>] el0t_64_sync+0x18c/0x190
