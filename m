Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11AA54ABA6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 10:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238722AbiFNITe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 04:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235690AbiFNITa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 04:19:30 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6133D403D4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 01:19:29 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LMhBM067Pz1K9SW;
        Tue, 14 Jun 2022 16:17:31 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 14 Jun 2022 16:19:26 +0800
Subject: Re: [PATCH v4 1/2] mm/memory-failure: introduce "hwpoisoned-pages"
 entry
To:     David Hildenbrand <david@redhat.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        zhenwei pi <pizhenwei@bytedance.com>
References: <20220614043830.99607-1-pizhenwei@bytedance.com>
 <20220614043830.99607-2-pizhenwei@bytedance.com>
 <20220614070934.GA1627546@hori.linux.bs1.fc.nec.co.jp>
 <66c43dac-32ac-5801-c76c-01607d68e38b@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <c436f65d-d219-d2a5-0275-462b3a10879e@huawei.com>
Date:   Tue, 14 Jun 2022 16:19:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <66c43dac-32ac-5801-c76c-01607d68e38b@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/14 15:13, David Hildenbrand wrote:
> 	   &hwpoisoned_pages);
>>
>> I'm not sure how useful this interface from userspace (controlling test process
>> with this?).  Do we really need to expose this to userspace? 
>>
>>
>> TBH I feel that another approach like below is more desirable:
>>
>>   - define a new flag in "enum mf_flags" (for example named MF_SW_SIMULATED),
>>   - set the flag when calling memory_failure() from the three callers
>>     mentioned above,
>>   - define a global variable (typed bool) in mm/memory_failure.c_to show that
>>     the system has experienced a real hardware memory error events.
>>   - once memory_failure() is called without MF_SW_SIMULATED, the new global
>>     bool variable is set, and afterward unpoison_memory always fails with
>>     -EOPNOTSUPP.
> 
> Exactly what I had in mind.

This approach should be more straightforward. ;)

> 

