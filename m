Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7615A33D3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 04:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbiH0Cei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 22:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbiH0Cef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 22:34:35 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9ECDA3FF
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 19:34:33 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MF10d0g98zlWHk;
        Sat, 27 Aug 2022 10:31:13 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 27 Aug 2022 10:34:30 +0800
Subject: Re: [PATCH 10/10] hugetlb: make hugetlb selects SYSFS if !SYSCTL
To:     Muchun Song <muchun.song@linux.dev>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220826092422.39591-1-linmiaohe@huawei.com>
 <20220826092422.39591-11-linmiaohe@huawei.com>
 <1BAFF85D-F7F5-4DD1-ABEF-2FF621DE34E8@linux.dev>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <7040e50b-fe4c-4d1d-fd8d-94c29b6e1668@huawei.com>
Date:   Sat, 27 Aug 2022 10:34:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <1BAFF85D-F7F5-4DD1-ABEF-2FF621DE34E8@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

On 2022/8/27 9:59, Muchun Song wrote:
> 
> 
>> On Aug 26, 2022, at 17:24, Miaohe Lin <linmiaohe@huawei.com> wrote:
>>
>> If CONFIG_SYSFS and CONFIG_SYSCTL are both undefined, hugetlb doesn't work
>> now as there's no way to set max huge pages. Make sure at least one of the
>> above configs is defined to make hugetlb works as expected.
> 
> Right. I think the majority of the people are usually use /proc knob to
> reserve HugeTLB pages than /sys fs. So I suggest to add a “depends on SYSCTL”
> item. What’s your thoughts?

It seems some functions, e.g. demotion, is exported via SYSFS instead of SYSCTL.
So maybe "depends on SYSFS || SYSCTL", i.e.

	depends on (X86 || IA64 || SPARC64 || ARCH_SUPPORTS_HUGETLBFS || BROKEN) && (SYSFS || SYSCTL)

will be more suitable?

Thanks,
Miaohe Lin

