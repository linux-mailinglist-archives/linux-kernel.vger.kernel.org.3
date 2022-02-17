Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0A14BA1C6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 14:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239929AbiBQNo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 08:44:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241302AbiBQNo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:44:58 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE24D2B0B31
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 05:44:17 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JzwtH0zfSzZdNk;
        Thu, 17 Feb 2022 21:39:51 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Feb 2022 21:44:14 +0800
Subject: Re: [PATCH] mm/mmu_notifiers: use helper function
 mmu_notifier_synchronize()
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220217110948.35477-1-linmiaohe@huawei.com>
 <Yg5OaP+4hclrUcB9@casper.infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <b18c8067-6709-6589-b52a-0e38150fa322@huawei.com>
Date:   Thu, 17 Feb 2022 21:44:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <Yg5OaP+4hclrUcB9@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/2/17 21:32, Matthew Wilcox wrote:
> On Thu, Feb 17, 2022 at 07:09:48PM +0800, Miaohe Lin wrote:
>> Use helper function mmu_notifier_synchronize() to ensure all mmu_notifiers
>> are freed. Minor readability improvement.
> 
> Is it though?
> 
>> @@ -334,15 +334,15 @@ static void mn_hlist_release(struct mmu_notifier_subscriptions *subscriptions,
>>  	srcu_read_unlock(&srcu, id);
>>  
>>  	/*
>> -	 * synchronize_srcu here prevents mmu_notifier_release from returning to
>> -	 * exit_mmap (which would proceed with freeing all pages in the mm)
>> -	 * until the ->release method returns, if it was invoked by
>> -	 * mmu_notifier_unregister.
>> +	 * mmu_notifier_synchronize here prevents mmu_notifier_release from
>> +	 * returning to exit_mmap (which would proceed with freeing all pages
>> +	 * in the mm) until the ->release method returns, if it was invoked
>> +	 * by mmu_notifier_unregister.
>>  	 *
>>  	 * The notifier_subscriptions can't go away from under us because
>>  	 * one mm_count is held by exit_mmap.
>>  	 */
>> -	synchronize_srcu(&srcu);
>> +	mmu_notifier_synchronize();
> 
> We just read_unlocked the &srcu.  Now I have to jump to the definition
> of mmu_notifier_synchronize() to find out that it's now waiting for the
> very same srcu.  I think this abstraction makes the code harder to read,
> not easier.
> 

From this point of view, this helper would disturb the understanding of the code.
Many thanks for pointing this out. Sorry for my mindlessness.

>>  }
>>  
>>  void __mmu_notifier_release(struct mm_struct *mm)
>> @@ -851,7 +851,7 @@ void mmu_notifier_unregister(struct mmu_notifier *subscription,
>>  	 * Wait for any running method to finish, of course including
>>  	 * ->release if it was run by mmu_notifier_release instead of us.
>>  	 */
>> -	synchronize_srcu(&srcu);
>> +	mmu_notifier_synchronize();
> 
> Same here.
> 
> .
> 

