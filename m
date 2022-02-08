Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE724ACE89
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 03:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345204AbiBHB7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235393AbiBHB7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 20:59:22 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E030C061355
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 17:59:21 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Jt5kz3VgHzccpd;
        Tue,  8 Feb 2022 09:58:19 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Feb 2022 09:59:18 +0800
Subject: Re: [PATCH] mm/memory_hotplug: fix kfree() of bootmem memory
To:     David Hildenbrand <david@redhat.com>
CC:     <isimatu.yasuaki@jp.fujitsu.com>, <toshi.kani@hp.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220207135618.17231-1-linmiaohe@huawei.com>
 <6d4ab70e-b944-5f7d-e9a3-979ac66c70f7@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <828c9b16-6ff0-abb7-3a16-277d2d60de81@huawei.com>
Date:   Tue, 8 Feb 2022 09:59:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <6d4ab70e-b944-5f7d-e9a3-979ac66c70f7@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:
On 2022/2/7 22:33, David Hildenbrand wrote:
> On 07.02.22 14:56, Miaohe Lin wrote:
>> We can't use kfree() to release the resource as it might come from bootmem.
>> Use release_mem_region() instead.
> 
> How can this happen? release_mem_region() is called either from
> __add_memory() or from add_memory_driver_managed(), where we allocated
> the region via register_memory_resource(). Both functions shouldn't ever
> be called before the buddy is up an running.
> 
> Do you have a backtrace of an actual instance of this issue? Or was this
> identified as possibly broken by code inspection?
> 

This is identified as possibly broken by code inspection. IIUC, alloc_resource
is always used to allocate the resource. It has the below logic:

  if (bootmem_resource_free) {
	res = bootmem_resource_free;
	bootmem_resource_free = res->sibling;
  }

where bootmem_resource_free is used to reusing the resource entries allocated by boot
mem after the system is up:

/*
 * For memory hotplug, there is no way to free resource entries allocated
 * by boot mem after the system is up. So for reusing the resource entry
 * we need to remember the resource.
 */
static struct resource *bootmem_resource_free;

So I think register_memory_resource() can reuse the resource allocated by bootmem.
Or am I miss anything?

Thanks.
