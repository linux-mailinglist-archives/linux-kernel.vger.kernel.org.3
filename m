Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56AC5064D6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 08:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348988AbiDSGum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 02:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbiDSGuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 02:50:40 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CED331516
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 23:47:58 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KjDlm4ctyzCrKY;
        Tue, 19 Apr 2022 14:43:32 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Apr 2022 14:47:56 +0800
Subject: Re: [PATCH 09/12] mm: compaction: avoid possible NULL pointer
 dereference in kcompactd_cpu_online
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <vbabka@suse.cz>, <pintu@codeaurora.org>,
        <charante@codeaurora.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
References: <20220418141253.24298-1-linmiaohe@huawei.com>
 <20220418141253.24298-10-linmiaohe@huawei.com>
 <20220418205531.2e4ed0f72e0e537ef55c6468@linux-foundation.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <df57934c-0738-208b-d423-59032185f858@huawei.com>
Date:   Tue, 19 Apr 2022 14:47:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220418205531.2e4ed0f72e0e537ef55c6468@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/19 11:55, Andrew Morton wrote:
> Please cc David H on memhotplug stuff.

I'm relying on the scripts/get_maintainer.pl to take me the right people now.
Will take care of it. Many thanks for your remind!

> 
> On Mon, 18 Apr 2022 22:12:50 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
>> It's possible that kcompactd_run could fail to run kcompactd for a hot
>> added node and leave pgdat->kcompactd as NULL. So pgdat->kcompactd should
>> be checked here to avoid possible NULL pointer dereference.
>>
>> ..
>>
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -3052,7 +3052,8 @@ static int kcompactd_cpu_online(unsigned int cpu)
>>  
>>  		if (cpumask_any_and(cpu_online_mask, mask) < nr_cpu_ids)
>>  			/* One of our CPUs online: restore mask */
>> -			set_cpus_allowed_ptr(pgdat->kcompactd, mask);
>> +			if (pgdat->kcompactd)
>> +				set_cpus_allowed_ptr(pgdat->kcompactd, mask);
>>  	}
>>  	return 0;
>>  }
> 
> Why not fail to bring the node online if kcompactd_run() failed?

kcompactd_run() is allowed to fail since it's introduced via commit 698b1b30642 ("mm, compaction: introduce kcompactd").

> 
> Also, should we panic the system if kcompactd_run() failed in
> kcompactd_init()?

So I think this might not be a critical issue. We could live with it anyway.
And in fact, CONFIG_COMPACTION is even not enabled in some systems.

Thanks!

> 
> .
> 

