Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133DD4F8D6F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbiDHDdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 23:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbiDHDdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 23:33:11 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C558B33223D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 20:31:07 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KZP0F2bY6z1HBT5;
        Fri,  8 Apr 2022 11:30:37 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 8 Apr 2022 11:31:05 +0800
Subject: Re: [PATCH v7] mm/hwpoison: fix race between hugetlb free/demotion
 and memory_failure_hugetlb()
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20220407112929.1344748-1-naoya.horiguchi@linux.dev>
 <4b5ad6c3-99a0-b04f-21ad-8ade46984c76@huawei.com>
 <20220408015610.GA3061012@hori.linux.bs1.fc.nec.co.jp>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <e928b6a2-2bb4-82dc-1508-5b293ecb7539@huawei.com>
Date:   Fri, 8 Apr 2022 11:31:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220408015610.GA3061012@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/8 9:56, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Thu, Apr 07, 2022 at 09:38:26PM +0800, Miaohe Lin wrote:
>> On 2022/4/7 19:29, Naoya Horiguchi wrote:
> ...
>>> +int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
>>> +{
>>> +	struct page *page = pfn_to_page(pfn);
>>> +	struct page *head = compound_head(page);
>>> +	int ret = 2;	/* fallback to normal page handling */
>>> +	bool count_increased = false;
>>> +
>>> +	if (!PageHeadHuge(head))
>>> +		goto out;
>>> +
>>> +	if (flags & MF_COUNT_INCREASED) {
>>> +		ret = 1;
>>> +		count_increased = true;
>>> +	} else if (HPageFreed(head) || HPageMigratable(head)) {
>>> +		ret = get_page_unless_zero(head);
>>> +		if (ret)
>>> +			count_increased = true;
>>> +	} else {
>>> +		ret = -EBUSY;
>>> +		goto out;
>>> +	}
>>> +
>>> +	if (hwpoison_filter(page)) {
>>> +		ret = -EOPNOTSUPP;
>>> +		goto out;
>>> +	}
>>
>> Now hwpoison_filter is done without lock_page + unlock_page. Is this ok or
>> lock_page + unlock_page pair is indeed required?
> 
> Hmm, we had better call hwpoison_filter in page lock for hugepages.
> I'll move this too, thank you.
> 
>>> +
>>> +	if (TestSetPageHWPoison(head)) {
>>> +		ret = -EHWPOISON;
>>> +		goto out;
>>> +	}
>>
>> Without this patch, page refcnt is not decremented if MF_COUNT_INCREASED is set in flags
>> when PageHWPoison is already set. So I think this patch also fixes that issue. Thanks!
> 
> Good point, I even didn't notice that. And the issue still seems to exist
> for normal page's cases.  Maybe encountering "already hwpoisoned" case from
> madvise_inject_error() is rare but could happen when the first call failed
> to contain the error (which is still accessible from the calling process).

Oh, I missed normal page's issue. :) Will you fix this issue kindly or am I supposed
to fix it?

Many thanks.

> 
...
