Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6BF580C38
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 09:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237854AbiGZHOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 03:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiGZHOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 03:14:21 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D724F2A969
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:14:19 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LsSkk2dXNz1M8K5;
        Tue, 26 Jul 2022 15:11:26 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Jul 2022 15:14:17 +0800
Subject: Re: [bug report] mm/hugetlb: possible data leak with huge pmd sharing
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>
References: <025b3ea6-4b26-f091-5464-0eef5aac7719@huawei.com>
 <Yt7iVRaDGuIx8LVE@monkey>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <2ec4cd05-5b3a-cd5c-7785-5a7236804bef@huawei.com>
Date:   Tue, 26 Jul 2022 15:14:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <Yt7iVRaDGuIx8LVE@monkey>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/26 2:35, Mike Kravetz wrote:
> On 07/25/22 17:07, Miaohe Lin wrote:
>> Hi all:
>>     When I investigate the mm/hugetlb code, I found there's a possible data leak issue
>> with huge pmd sharing. Thank about the below scene:
>>
>>     1. Process A and process B shares huge pmd page.(vm_flags: VM_MAYSHARE but !VM_SHARED)
> 
> Thanks,
> 
> I often get confused about the setting of VM_MAYSHARE and VM_SHARED.  When
> you throw in the possibility of shared and anonymous, then I struggle a bit
> more.  At one time did an audit to get the meaning clear in my mind, but still
> struggle with the meanings.
> 
> Is it possible to have VM_MAYSHARE and !VM_SHARED on a hugetlb vma?  I only
> took a quick look and could not find a way for this to happen.  But, I> could have easily missed something.

Thanks for your reply. It's possible to have VM_MAYSHARE and !VM_SHARED on a hugetlb vma
with below code snippet:

...
    fd = open("/root/huge/hugepagefile", O_CREAT | O_RDONLY, 0755);
    if (fd < 0) {
            perror("Open failed");
            exit(1);
    }

    addr = mmap(0, 32UL*1024*1024, PROT_READ, MAP_SHARED, fd, 0);
...

cat /proc/<pid>/smaps:

400000000000-400002000000 r--s 00000000 00:2f 153780886                  /root/huge/hugepagefile
Size:              32768 kB
KernelPageSize:     2048 kB
MMUPageSize:        2048 kB
...
VmFlags: rd mr me ms de ht

/* sh: VM_SHARED, mw: VM_MAYWRITE, ms:VM_MAYSHARE */

So vm_flags is VM_MAYSHARE but !VM_SHARED.

But in this case, it's readonly. So the above scene won't happen. Sorry for make noise.

> 

Thanks for your comment again. :)

