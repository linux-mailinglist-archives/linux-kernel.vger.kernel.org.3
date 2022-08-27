Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBAD5A3511
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 08:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbiH0GjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 02:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiH0Gi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 02:38:59 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D785C9D2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 23:38:57 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MF6PQ43tnzYcqL;
        Sat, 27 Aug 2022 14:34:34 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 27 Aug 2022 14:38:54 +0800
Subject: Re: [PATCH 03/10] hugetlb: Use LIST_HEAD() to define a list head
To:     Muchun Song <muchun.song@linux.dev>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        <mike.kravetz@oracle.com>, Muchun Song <songmuchun@bytedance.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220826092422.39591-1-linmiaohe@huawei.com>
 <20220826092422.39591-4-linmiaohe@huawei.com>
 <8D011A6F-F557-4519-852C-80BBDE53E630@linux.dev>
 <bb05153c-29a9-b77e-0815-506309da6da0@huawei.com>
 <83DBE074-0B63-4CB2-9BD2-65967977B69C@linux.dev>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <2339d458-8b98-f540-22f1-50b772eef130@huawei.com>
Date:   Sat, 27 Aug 2022 14:38:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <83DBE074-0B63-4CB2-9BD2-65967977B69C@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

On 2022/8/27 10:48, Muchun Song wrote:
> 
> 
>> On Aug 27, 2022, at 10:27, Miaohe Lin <linmiaohe@huawei.com> wrote:
>>
>> On 2022/8/27 9:47, Muchun Song wrote:
>>>
>>>
>>>> On Aug 26, 2022, at 17:24, Miaohe Lin <linmiaohe@huawei.com> wrote:
>>>>
>>>> We can avoid unneeded WRITE_ONCE() overhead by using LIST_HEAD() to define
>>>> a list head.
>>>
>>> IIUC, the overhead doesn’t change. Right?
>>
>> I think the overhead is changed. LIST_HEAD is initialized without using WRITE_ONCE():
> 
> I think there is no special difference with "WRITE_ONCE(var, 0)" vs "var = 0” in

It's not write var to 0 indeed. But there seems are no special difference.

> assembly code. Both code of line will be compiled to a mov or movq instruction.
> I didn’t confirm if the assembly code is different (I tend to think it is similar).
> Just some analysis from me.

I checked the generated code in x86, they're almost same. And in aarch64, there's difference
between one "stp" instruction vs two "str" instruction. So I think you're right. Thanks for
pointing this out. I should tweak the commit log in next version.

Thanks a lot,
Miaohe Lin

