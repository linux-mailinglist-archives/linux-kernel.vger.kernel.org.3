Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9794C58F7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 03:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiB0CYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 21:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiB0CYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 21:24:16 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2760158809
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 18:23:41 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21R2DZFl024532;
        Sun, 27 Feb 2022 02:23:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=vpsjZ4X53Hc78eiIjlX0CaZjBWcUwxUm1yrRlwCid5c=;
 b=QtcxRFiagfiULIK9rAFImKxC1dt7XM/Ydmadadf3ZBz47cDGVA/Rpqw9m3gsbXWltaAK
 gtAcpp4prbDaKi3cSCRMrmCtnpDFGoYzX/HzsdPD42vnvcWES/XVBTem2g93JbK5zDmL
 cHuyaImUJgdOuVpNrlYOuX+ipIspw5Avf0scbpM0gXLxTFn2YXuVSyi9AA6WI9ZrP94k
 eOG9r+D3w5t0dfWztgjyK1nwkkCvRQ58BSXjcCqJfDdqHS9K7/Uh5gSPUcIbyoFjsCB2
 9PAwhoBfk62rxNPl/3iO6O/S1CpaBEaigUwTzd5SL10PWMrBmZxb5hesqNaEcSIhgY8y 2w== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eg0b18312-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 27 Feb 2022 02:23:05 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21R2DQb2030184;
        Sun, 27 Feb 2022 02:23:02 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 3efbfhuht8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 27 Feb 2022 02:23:02 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21R2MxW443778396
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 27 Feb 2022 02:22:59 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6CD4A4C044;
        Sun, 27 Feb 2022 02:22:59 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12CCF4C046;
        Sun, 27 Feb 2022 02:22:59 +0000 (GMT)
Received: from localhost (unknown [9.171.89.193])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun, 27 Feb 2022 02:22:59 +0000 (GMT)
Date:   Sun, 27 Feb 2022 03:22:57 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Mark Brown <broonie@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v6 00/71] Introducing the Maple Tree
Message-ID: <your-ad-here.call-01645928577-ext-7266@work.hours>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5ibuec98CPmSz-Cp1o9tngQ6Qhf3IFX5
X-Proofpoint-GUID: 5ibuec98CPmSz-Cp1o9tngQ6Qhf3IFX5
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-26_12,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 clxscore=1011 mlxlogscore=999 priorityscore=1501
 malwarescore=0 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202270014
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FROM_FMBLA_NEWDOM,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 02:37:44PM +0000, Liam Howlett wrote:
> The maple tree is an RCU-safe range based B-tree designed to use modern
> processor cache efficiently.  There are a number of places in the kernel
> that a non-overlapping range-based tree would be beneficial, especially
> one with a simple interface.  The first user that is covered in this
> patch set is the vm_area_struct, where three data structures are
> replaced by the maple tree: the augmented rbtree, the vma cache, and the
> linked list of VMAs in the mm_struct.  The long term goal is to reduce
> or remove the mmap_sem contention.
> 
> The tree has a branching factor of 10 for non-leaf nodes and 16 for leaf
> nodes.  With the increased branching factor, it is significantly shorter than
> the rbtree so it has fewer cache misses.  The removal of the linked list
> between subsequent entries also reduces the cache misses and the need to pull
> in the previous and next VMA during many tree alterations.
> 
> This patch is based on v5.17-rc4
> 
> git: https://github.com/oracle/linux-uek/tree/howlett/maple/20220214

Hi Liam,

this patch series completely breaks s390. Besides endianess issue
in maple trees reported here:

https://lore.kernel.org/all/your-ad-here.call-01645924312-ext-0398@work.hours/

and with this endianess issue fixed (fixup from here ^^^) we still get numerous
KASAN reports starting with

[PATCH v6 10/71] mm: Start tracking VMAs with maple tree

mostly looking like this:

 BUG: KASAN: use-after-free in mas_descend_adopt+0x113a/0x1408
 Read of size 8 at addr 00000000b1d4e900 by task cat/610

 CPU: 34 PID: 610 Comm: cat Tainted: G        W         5.17.0-rc4-91313-g592c3b299aad #1
 Hardware name: IBM 3906 M04 704 (LPAR)
 Call Trace:
  [<000000000234647a>] dump_stack_lvl+0xfa/0x150
  [<0000000002328154>] print_address_description.constprop.0+0x64/0x340
  [<00000000008f5ba6>] kasan_report+0x13e/0x1a8
  [<00000000017f0c12>] mas_descend_adopt+0x113a/0x1408
  [<00000000018076ec>] mas_spanning_rebalance.isra.0+0x5164/0x6a20
  [<000000000180a71e>] mas_wr_spanning_store.isra.0+0x476/0xbc8
  [<00000000018189bc>] mas_store_gfp+0xd4/0x188
  [<0000000000827bae>] vma_mt_szero+0x146/0x368
  [<000000000082e990>] __do_munmap+0x340/0xe20
  [<000000000082f580>] __vm_munmap+0x110/0x1e8
  [<000000000082f76e>] __s390x_sys_munmap+0x6e/0x90
  [<000000000010dc6c>] do_syscall+0x22c/0x328
  [<000000000234d3d2>] __do_syscall+0x9a/0xf8
  [<0000000002374ed2>] system_call+0x82/0xb0
 INFO: lockdep is turned off.

 Allocated by task 610:
  kasan_save_stack+0x34/0x58
  __kasan_slab_alloc+0x84/0xa8
  kmem_cache_alloc+0x20c/0x520
  mas_alloc_nodes+0x26a/0x4c8
  mas_split.isra.0+0x2aa/0x1418
  mas_wr_modify+0x3fa/0xd28
  mas_store_gfp+0xd4/0x188
  vma_store+0x17a/0x3d8
  vma_link+0xac/0x798
  mmap_region+0xa5a/0x10b8
  do_mmap+0x7c2/0xa90
  vm_mmap_pgoff+0x186/0x250
  ksys_mmap_pgoff+0x334/0x400
  __s390x_sys_old_mmap+0xf4/0x130
  do_syscall+0x22c/0x328
  __do_syscall+0x9a/0xf8
  system_call+0x82/0xb0
 Freed by task 610:
  kasan_save_stack+0x34/0x58
  kasan_set_track+0x36/0x48
  kasan_set_free_info+0x34/0x58
  ____kasan_slab_free+0x11c/0x188
  __kasan_slab_free+0x24/0x30
  kmem_cache_free_bulk.part.0+0xec/0x538
  mas_destroy+0x2e4/0x710
  mas_store_gfp+0xf4/0x188
  vma_mt_szero+0x146/0x368
  __vma_adjust+0x155a/0x2188
  __split_vma+0x228/0x450
  mprotect_fixup+0x4f2/0x618
  do_mprotect_pkey.constprop.0+0x328/0x600
  __s390x_sys_mprotect+0x8e/0xb8
  do_syscall+0x22c/0x328
  __do_syscall+0x9a/0xf8
  system_call+0x82/0xb0

 The buggy address belongs to the object at 00000000b1d4e900
  which belongs to the cache maple_node of size 256
 The buggy address is located 0 bytes inside of
  256-byte region [00000000b1d4e900, 00000000b1d4ea00)
 The buggy address belongs to the page:
 page:0000400002c75200 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xb1d48
 head:0000400002c75200 order:3 compound_mapcount:0 compound_pincount:0
 flags: 0x3ffff00000010200(slab|head|node=0|zone=1|lastcpupid=0x1ffff)
 raw: 3ffff00000010200 0000400002c91e08 000040000263b608 000000008009ed00
 raw: 0000000000000000 0020004000000000 ffffffff00000001 0000000000000000
 page dumped because: kasan: bad access detected

 Memory state around the buggy address:
  00000000b1d4e800: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  00000000b1d4e880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 >00000000b1d4e900: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                    ^
  00000000b1d4e980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  00000000b1d4ea00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc

with eventual crash.

How come none of s390 architecture maintainers nor s390 mailing list were
on CC for the changes which affect s390 to that magnitude? None of this
has apparently been tested on s390 or any other big endian system. And
a shoulder tap to give it try would be helpful.

Now we are just starting looking at the problems. And until issues
are resolved this patch series has to be dropped from linux-next.
