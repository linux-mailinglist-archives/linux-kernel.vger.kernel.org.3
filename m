Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E14D5955B0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 10:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbiHPI5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 04:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiHPI4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 04:56:11 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B68653028
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 00:04:11 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M6MVp1Pd5zkWQm;
        Tue, 16 Aug 2022 15:00:50 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 16 Aug 2022 15:04:09 +0800
Received: from [10.174.178.120] (10.174.178.120) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 16 Aug 2022 15:04:09 +0800
Message-ID: <b7468bcc-4b75-1190-5eae-9796d35b048c@huawei.com>
Date:   Tue, 16 Aug 2022 15:04:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
From:   mawupeng <mawupeng1@huawei.com>
Subject: Re: [PATCH stable 4.14,4.19 1/1] mm: Fix page counter mismatch in
 shmem_mfill_atomic_pte
To:     <gregkh@linuxfoundation.org>
CC:     <mawupeng1@huawei.com>, <rppt@linux.vnet.ibm.com>,
        <hughd@google.com>, <aarcange@redhat.com>, <hannes@cmpxchg.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <wangkefeng.wang@huawei.com>, <willy@infradead.org>
References: <20220802013251.3022141-1-mawupeng1@huawei.com>
 <09129cd3-7363-3079-bd57-dde9c73684f1@huawei.com>
 <YvsruBZBP+KpEBdb@kroah.com>
Content-Language: en-US
In-Reply-To: <YvsruBZBP+KpEBdb@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.120]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/8/16 13:31, Greg KH wrote:
> On Tue, Aug 16, 2022 at 11:27:08AM +0800, mawupeng wrote:
>> Cc Greg
> 
> Cc Greg for what?  I have no context here at all as to what you want me
> to do..

We found a bug related to memory cgroup counter in stable 4.14/4.19.
shmem_mfill_atomic_pte() wrongly called mem_cgroup_cancel_charge() in "success"
path, it should mem_cgroup_uncharge() to dec memory counter instead.
mem_cgroup_cancel_charge() should only be used if this transaction is
unsuccessful and mem_cgroup_uncharge() is used to do this if this transaction
succeed.

Commit 3fea5a499d57 ("mm: memcontrol: convert page cache to a new mem_cgroup_charge() API")
in v5.8-rc1 change is charge/uncharge/cancel logic so don't have this
problem.

This counter will underflow to negative maximum value and trigger oom to kill all
process include sshd and leave system unaccessible.

The reason cc you is that we want to merge this bugfix into stable 4.14/4.19.

The error call trace:
------------[ cut here ]------------
WARNING: CPU: 0 PID: 17127 at mm/page_counter.c:62 page_counter_cancel+0x57/0x90
RIP: 0010:page_counter_cancel+0x57/0x90
Call Trace:
  page_counter_uncharge+0x33/0x60
  uncharge_batch+0xb5/0x5f0
  mem_cgroup_uncharge_list+0x102/0x170
  release_pages+0x814/0xcc0
  tlb_flush_mmu_free+0xa9/0x140
  arch_tlb_finish_mmu+0xa4/0x140
  tlb_finish_mmu+0x90/0xf0
  exit_mmap+0x264/0x4b0

> 
> totally confused,
> 
> greg k-h
