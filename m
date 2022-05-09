Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB54751F2E8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 05:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbiEIDZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 23:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbiEIDSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 23:18:25 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92E783B37
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 20:14:32 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KxR681W45zGpPt;
        Mon,  9 May 2022 11:11:44 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 9 May 2022 11:14:30 +0800
Subject: Re: [PATCH v2 1/4] mm/migration: reduce the rcu lock duration
To:     David Hildenbrand <david@redhat.com>
CC:     <ying.huang@intel.com>, <hch@lst.de>, <dhowells@redhat.com>,
        <cl@linux.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        <mike.kravetz@oracle.com>, <naoya.horiguchi@nec.com>
References: <20220425132723.34824-1-linmiaohe@huawei.com>
 <20220425132723.34824-2-linmiaohe@huawei.com>
 <eeda05fb-b0bb-3e1d-37e0-0021dd72e144@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <3cf42a6e-c13d-341d-00a0-876a61794273@huawei.com>
Date:   Mon, 9 May 2022 11:14:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <eeda05fb-b0bb-3e1d-37e0-0021dd72e144@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/29 17:54, David Hildenbrand wrote:
> On 25.04.22 15:27, Miaohe Lin wrote:
>> rcu_read_lock is required by grabbing the task refcount but it's not
>> needed for ptrace_may_access. So we could release the rcu lock after
>> task refcount is successfully grabbed to reduce the rcu holding time.
>>
>> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> Cc: Huang Ying <ying.huang@intel.com>
>> Cc: David Howells <dhowells@redhat.com>
>> Cc: Christoph Lameter <cl@linux.com>
>> ---
>>  mm/migrate.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index b2678279eb43..b779646665fe 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1902,17 +1902,16 @@ static struct mm_struct *find_mm_struct(pid_t pid, nodemask_t *mem_nodes)
>>  		return ERR_PTR(-ESRCH);
>>  	}
>>  	get_task_struct(task);
>> +	rcu_read_unlock();
>>  
>>  	/*
>>  	 * Check if this process has the right to modify the specified
>>  	 * process. Use the regular "ptrace_may_access()" checks.
>>  	 */
>>  	if (!ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS)) {
>> -		rcu_read_unlock();
>>  		mm = ERR_PTR(-EPERM);
>>  		goto out;
>>  	}
>> -	rcu_read_unlock();
>>  
>>  	mm = ERR_PTR(security_task_movememory(task));
>>  	if (IS_ERR(mm))
> 
> Similar pattern in:
> 
> mm/mempolicy.c:kernel_migrate_pages()
> kernel/futex/syscalls.c:get_robust_list()
> kernel/nsproxy.c:validate_nsset()
> 
> Exception:
> 
> sched/core_sched.c:sched_core_share_pid()
> 
> 
> Should we unify -- i.e., adjust the remaining 3 as well?
> 

Sorry for late respond. I think it's fine to do all of this together. But this patch is indeed
under verifying now. I will try to do that after verified. Thanks!
