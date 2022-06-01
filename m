Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559FA539B93
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 05:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349318AbiFADV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 23:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345948AbiFADV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 23:21:28 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08188B0A7
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 20:21:26 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LCZBp0nJzz1K95m;
        Wed,  1 Jun 2022 11:19:46 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 1 Jun 2022 11:21:24 +0800
Subject: Re: [PATCH v4 1/4] mm: reduce the rcu lock duration
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>,
        <peterx@redhat.com>, <apopple@nvidia.com>, <ying.huang@intel.com>,
        <osalvador@suse.de>, <mike.kravetz@oracle.com>,
        <songmuchun@bytedance.com>, <hch@lst.de>, <dhowells@redhat.com>,
        <cl@linux.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220530113016.16663-1-linmiaohe@huawei.com>
 <20220530113016.16663-2-linmiaohe@huawei.com>
 <YpYQ937N8Daad6u/@casper.infradead.org>
 <YpYSjw/T8jTGr7e8@casper.infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <f621877f-d181-21ab-d2a4-1765f248c45f@huawei.com>
Date:   Wed, 1 Jun 2022 11:21:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YpYSjw/T8jTGr7e8@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/31 21:05, Matthew Wilcox wrote:
> On Tue, May 31, 2022 at 01:58:31PM +0100, Matthew Wilcox wrote:
>> On Mon, May 30, 2022 at 07:30:13PM +0800, Miaohe Lin wrote:
>>> Commit 3268c63eded4 ("mm: fix move/migrate_pages() race on task struct")
>>> extends the period of the rcu_read_lock until after the permissions checks
>>> are done to prevent the task pointed to from changing from under us. But
>>> the task_struct refcount is also taken at that time, the reference to task
>>> is guaranteed to be stable. So it's unnecessary to extend the period of
>>> the rcu_read_lock. Release the rcu lock after task refcount is successfully
>>> grabbed to reduce the rcu holding time.
>>
>> But why bother?  You know the RCU read lock isn't a "real" lock, right?
> 
> Looking over this code some more, I think this may harm performance.
> ptrace_may_access() itself takes the rcu_read_lock().  So we currently
> have:
> 
> rcu_read_lock()
> rcu_read_lock();
> rcu_read_unlock();
> rcu_read_unlock();

More precisely, we currently have:

rcu_read_lock()
task_lock()
rcu_read_lock();
rcu_read_unlock();
task_unlock()
rcu_read_unlock();

> 
> In at least one RCU configuration, rcu_read_lock() maps to
> preempt_disable().  Nested preempt_disable() just bump a counter, while
> that counter reaching zero incurs some actual work.  So nested
> rcu_read_lock() can be better than sequential lock/unlock/lock/unlock.

In this case, I agree with you.
But when task_lock is heavily contented, it might take a long time. So in this
case, I think it's better to do the sequential rcu_lock+unlock to avoid long
rcu lock duration. Or am I miss something?

> 
> This needs far better justification.

Thanks!

> 
> .
> 

