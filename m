Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A70512C7E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 09:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244976AbiD1HT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 03:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244936AbiD1HTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 03:19:23 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EBA972C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 00:16:07 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Kpn051JdrzGpN9;
        Thu, 28 Apr 2022 15:13:25 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Apr 2022 15:16:02 +0800
Subject: Re: [RFC PATCH v1 4/4] mm, memory_hotplug: fix inconsistent
 num_poisoned_pages on memory hotremove
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20220427042841.678351-1-naoya.horiguchi@linux.dev>
 <20220427042841.678351-5-naoya.horiguchi@linux.dev>
 <828cc111-40e8-88ed-bb50-fb185e5f0304@huawei.com>
 <20220428040556.GA3945421@hori.linux.bs1.fc.nec.co.jp>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <4cae9c00-a048-2c0a-9a45-d7abb956fde7@huawei.com>
Date:   Thu, 28 Apr 2022 15:16:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220428040556.GA3945421@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/28 12:05, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Thu, Apr 28, 2022 at 11:20:16AM +0800, Miaohe Lin wrote:
>> On 2022/4/27 12:28, Naoya Horiguchi wrote:
>>> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
>>>
>>> When offlining memory section with hwpoisoned pages, the hwpoisons are
>>> canceled. But num_poisoned_pages is not updated for that event, so the
>>> counter becomes inconsistent.
>>
>> IIUC, this work is already done via clear_hwpoisoned_pages when __remove_pages.
>> Or am I miss something?
> 
> Actually I had the same question when writing this patch, and found that
> __remove_pages() seems to be called from device memory or HMM, but not from

It seems remove_memory (which calls __remove_pages) will be called as .detach callback of
memory_device_handler in drivers/acpi/acpi_memhotplug.c. So the hwpoison info will also be
clear for that memory ?

> offline_pages().  If you mean that we could make offline_pages() call
> clear_hwpoisoned_pages(), that seems possible and I'll consider it.
> 
> But as David and Oscar pointed out for 0/4, removing PageHWPoison flags
> in offlining seems not to be right thing, so I'd like to have some consensus
> on what way to go first.

Agree. We should have some consensus first.

Thanks!

> 
> Thanks,
> Naoya Horiguchi
> 

