Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC10351F2EA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 05:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbiEIDZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 23:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbiEIDYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 23:24:01 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD9795A1E
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 20:20:09 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KxRBL6CHkzXdpY;
        Mon,  9 May 2022 11:15:22 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 9 May 2022 11:20:07 +0800
Subject: Re: [PATCH v2 1/4] mm/migration: reduce the rcu lock duration
To:     "ying.huang@intel.com" <ying.huang@intel.com>,
        <dhowells@redhat.com>, <cl@linux.com>
CC:     <hch@lst.de>, <david@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        <mike.kravetz@oracle.com>, <naoya.horiguchi@nec.com>
References: <20220425132723.34824-1-linmiaohe@huawei.com>
 <20220425132723.34824-2-linmiaohe@huawei.com>
 <d260e8b178defbe4facda3cd8f0b534ec812268a.camel@intel.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <43a1a61e-bffe-b995-0618-f2a02f17ab5a@huawei.com>
Date:   Mon, 9 May 2022 11:20:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <d260e8b178defbe4facda3cd8f0b534ec812268a.camel@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

On 2022/5/6 11:23, ying.huang@intel.com wrote:
> On Mon, 2022-04-25 at 21:27 +0800, Miaohe Lin wrote:
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
>>  mm/migrate.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index b2678279eb43..b779646665fe 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1902,17 +1902,16 @@ static struct mm_struct *find_mm_struct(pid_t pid, nodemask_t *mem_nodes)
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
> Hi, Miaohe,
> 
> Please check the previous discussion and verify whether the original
> reported race condition is stll valid by yourself before resending this
> patch again.  If you find that the original race condition isn't
> possible now, please add the analysis in your change log.
> 

Sorry for late respond. It's a pity that this change is still not verified by the relevant
experts. I will try to give my analysis in my change log instead if the original race condition
is invalid now.

Many thanks!

> Best Regards,
> Huang, Ying
> 
> .
> 

