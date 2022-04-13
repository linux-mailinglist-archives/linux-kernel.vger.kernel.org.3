Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978204FF287
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 10:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbiDMIsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 04:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234311AbiDMIr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 04:47:56 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CBA13CCE
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 01:45:35 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KdbhX6y4vzFpqt;
        Wed, 13 Apr 2022 16:43:08 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Apr 2022 16:45:31 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2375.24; Wed, 13 Apr 2022 16:45:30 +0800
Message-ID: <b6920f9f-4a0d-ec51-9f88-9fb3012a05d1@huawei.com>
Date:   Wed, 13 Apr 2022 16:45:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v3 3/4] hugetlb: Fix return value of __setup handlers
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>,
        "liupeng (DM)" <liupeng256@huawei.com>
CC:     <mike.kravetz@oracle.com>, <david@redhat.com>,
        <akpm@linux-foundation.org>, <yaozhenguo1@gmail.com>,
        <baolin.wang@linux.alibaba.com>, <liuyuntao10@huawei.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220413032915.251254-1-liupeng256@huawei.com>
 <20220413032915.251254-4-liupeng256@huawei.com>
 <YlaCA6kqjN5nYNSH@FVFYT0MHHV2J.usts.net>
 <5bbf45e7-1d92-f543-5cfc-bc0141999d46@huawei.com>
 <YlaIFL8TCRfiFFgR@FVFYT0MHHV2J.usts.net>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <YlaIFL8TCRfiFFgR@FVFYT0MHHV2J.usts.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggeme701-chm.china.huawei.com (10.1.199.97) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/4/13 16:21, Muchun Song wrote:
> On Wed, Apr 13, 2022 at 04:16:11PM +0800, liupeng (DM) wrote:
>> On 2022/4/13 15:55, Muchun Song wrote:
>>> On Wed, Apr 13, 2022 at 03:29:14AM +0000, Peng Liu wrote:
>>>> When __setup() return '0', using invalid option values causes the
>>>> entire kernel boot option string to be reported as Unknown. Hugetlb
>>>> calls __setup() and will return '0' when set invalid parameter
>>>> string.
>>>>
>>>> The following phenomenon is observed:
>>>>    cmdline:
>>>>     hugepagesz=1Y hugepages=1
>>>>    dmesg:
>>>>     HugeTLB: unsupported hugepagesz=1Y
>>>>     HugeTLB: hugepages=1 does not follow a valid hugepagesz, ignoring
>>>>     Unknown kernel command line parameters "hugepagesz=1Y hugepages=1"
>>>>
>>>> Since hugetlb will print warning/error information before return for
>>>> invalid parameter string, just use return '1' to avoid print again.
>>>>
>>> Can't return -EINVAL? It is weird to return 1 on failure.
>>>
>>> Thanks.
>>>
>>> .
>> Not against "return -EINVAL", but consistent with:
>> 1d02b444b8d1 ("tracing: Fix return value of __setup handlers")
> I think it is better not return 1.  I don't think it's a good habit we
> should follow.
/*
  * NOTE: __setup functions return values:
  * @fn returns 1 (or non-zero) if the option argument is "handled"
  * and returns 0 if the option argument is "not handled".
  */
#define __setup(str, fn)               \
        __setup_param(str, fn, fn, 0)


1 or -EINVAL should ok, and  most __setup return 1 for know ;)

> Thanks.
>
> Thanks.
>
> .
