Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CB34FCCFB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 05:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344331AbiDLDX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 23:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344448AbiDLDXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 23:23:54 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A37F33354
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 20:21:34 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KcrVz70JBzBsBC;
        Tue, 12 Apr 2022 11:17:15 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Apr 2022 11:21:31 +0800
Subject: Re: [PATCH 1/4] mm/migration: reduce the rcu lock duration
To:     "ying.huang@intel.com" <ying.huang@intel.com>,
        <akpm@linux-foundation.org>
CC:     <mike.kravetz@oracle.com>, <shy828301@gmail.com>,
        <willy@infradead.org>, <ziy@nvidia.com>, <minchan@kernel.org>,
        <apopple@nvidia.com>, <dave.hansen@linux.intel.com>,
        <o451686892@gmail.com>, <jhubbard@nvidia.com>, <peterx@redhat.com>,
        <naoya.horiguchi@nec.com>, <mhocko@suse.com>, <riel@redhat.com>,
        <osalvador@suse.de>, <david@redhat.com>, <sfr@canb.auug.org.au>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220409073846.22286-1-linmiaohe@huawei.com>
 <20220409073846.22286-2-linmiaohe@huawei.com>
 <557be6cc7ecdee357391df3fe94e5573f9e1746d.camel@intel.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <34f3aff7-0111-a8d6-a559-92bf6d0bd62a@huawei.com>
Date:   Tue, 12 Apr 2022 11:21:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <557be6cc7ecdee357391df3fe94e5573f9e1746d.camel@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/12 10:07, ying.huang@intel.com wrote:
> On Sat, 2022-04-09 at 15:38 +0800, Miaohe Lin wrote:
>> rcu_read_lock is required by grabbing the task refcount but it's not
>> needed for ptrace_may_access. So we could release the rcu lock after
>> task refcount is successfully grabbed to reduce the rcu holding time.
>>
>> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/migrate.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index a3d8c2be2631..d8aae6c75990 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1907,17 +1907,16 @@ static struct mm_struct *find_mm_struct(pid_t pid, nodemask_t *mem_nodes)
>>  		return ERR_PTR(-ESRCH);
>>  	}
>>  	get_task_struct(task);
>> +	rcu_read_unlock();
>>  
>>
>>  	/*
>>  	 * Check if this process has the right to modify the specified
>>  	 * process. Use the regular "ptrace_may_access()" checks.
>>  	 */
>>  	if (!ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS)) {
>> -		rcu_read_unlock();
>>  		mm = ERR_PTR(-EPERM);
>>  		goto out;
>>  	}
>> -	rcu_read_unlock();
>>  
>>
>>  	mm = ERR_PTR(security_task_movememory(task));
>>  	if (IS_ERR(mm))
> 
> Why do you ignore our discussion for the previous version?
> 
> https://lore.kernel.org/linux-mm/8735ju7as9.fsf@yhuang6-desk2.ccr.corp.intel.com/
> 

Sorry for confusing. I remember this patch is pending for verify. The reason I post this series is that
I want to move the other patches in this series forward while this patch is still pending for verify.

Thanks.

> Best Regards,
> Huang, Ying
> 
> 
> .
> 

