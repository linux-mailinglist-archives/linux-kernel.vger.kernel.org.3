Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A709D5A33D0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 04:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345431AbiH0C16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 22:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbiH0C1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 22:27:51 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D05FD39B8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 19:27:49 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MF0rZ1607z1N7MB;
        Sat, 27 Aug 2022 10:24:14 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 27 Aug 2022 10:27:47 +0800
Subject: Re: [PATCH 03/10] hugetlb: Use LIST_HEAD() to define a list head
To:     Muchun Song <muchun.song@linux.dev>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        <mike.kravetz@oracle.com>, Muchun Song <songmuchun@bytedance.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220826092422.39591-1-linmiaohe@huawei.com>
 <20220826092422.39591-4-linmiaohe@huawei.com>
 <8D011A6F-F557-4519-852C-80BBDE53E630@linux.dev>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <bb05153c-29a9-b77e-0815-506309da6da0@huawei.com>
Date:   Sat, 27 Aug 2022 10:27:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <8D011A6F-F557-4519-852C-80BBDE53E630@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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

On 2022/8/27 9:47, Muchun Song wrote:
> 
> 
>> On Aug 26, 2022, at 17:24, Miaohe Lin <linmiaohe@huawei.com> wrote:
>>
>> We can avoid unneeded WRITE_ONCE() overhead by using LIST_HEAD() to define
>> a list head.
> 
> IIUC, the overhead doesn’t change. Right?

I think the overhead is changed. LIST_HEAD is initialized without using WRITE_ONCE():

#define LIST_HEAD_INIT(name) { &(name), &(name) }

#define LIST_HEAD(name) \
	struct list_head name = LIST_HEAD_INIT(name)

while INIT_LIST_HEAD has:

static inline void INIT_LIST_HEAD(struct list_head *list)
{
	WRITE_ONCE(list->next, list);
	WRITE_ONCE(list->prev, list);
}

Or am I miss something?

> 
> I’m fine with your changes.
> 
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Many thanks for your review and comment. :)

Thanks,
Miaohe Lin

