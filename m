Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E914B4E234D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 10:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345887AbiCUJ1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 05:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244434AbiCUJ1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:27:20 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264604F479
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 02:25:55 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KMTdy4r50z9srY;
        Mon, 21 Mar 2022 17:21:58 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Mar 2022 17:25:52 +0800
Subject: Re: [PATCH] mm/mempolicy: fix potential mpol_new leak in
 shared_policy_replace
To:     Michal Hocko <mhocko@suse.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        <kosaki.motohiro@jp.fujitsu.com>, <mgorman@suse.de>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220311093624.39546-1-linmiaohe@huawei.com>
 <Yi9w7TCYbj+OLGXJ@dhcp22.suse.cz>
 <26577566-ae1e-801c-8c64-89c2c89a487d@huawei.com>
 <YjCwYpTbGzAj9kmg@dhcp22.suse.cz>
 <24b2a9ef-eea0-09bd-6842-121d8436e56a@huawei.com>
 <YjG0PsF25wpAEOY3@dhcp22.suse.cz>
 <6ebebfd6-6356-e956-4fbc-0abaa58308ff@huawei.com>
 <YjL5Y6ZrZ2eLnnTv@dhcp22.suse.cz>
 <207bbd69-6678-5120-3760-e2bcd9803a14@huawei.com>
 <36b0ea44-39ab-bc52-1ae5-eca2cf832900@huawei.com>
 <Yjg+hVuJBPGhkfeJ@dhcp22.suse.cz>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <0d306244-748e-9774-8578-525073770a3f@huawei.com>
Date:   Mon, 21 Mar 2022 17:25:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <Yjg+hVuJBPGhkfeJ@dhcp22.suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

On 2022/3/21 16:59, Michal Hocko wrote:
> On Sat 19-03-22 18:42:33, Miaohe Lin wrote:
> [...]
>> This would be triggered easily with below code snippet in my virtual machine:
>>
>> 	shmid = shmget((key_t)5566, 1024 * PAGE_SIZE, 0666|IPC_CREAT);
>> 	shm = shmat(shmid, 0, 0);
>> 	loop {
>> 		mbind(shm, 1024 * PAGE_SIZE, MPOL_LOCAL, mask, maxnode, 0);
>> 		mbind(shm + 128 * PAGE_SIZE, 128 * PAGE_SIZE, MPOL_DEFAULT, mask, maxnode, 0);
>> 	}
>>
>> If there're many process doing the above work, mpol_new will be leaked easily.
>> So should I resend this patch with Cc stable? But it seems I'am not supposed
>> to make this decision and the maintainer will take care of this?
> 
> I would just add
> Fixes: 42288fe366c4 ("mm: mempolicy: Convert shared_policy mutex to spinlock")
> Cc: stable # 3.8
> 
> And also add your above reproducer snippet added to the original changelog.
> This would be more then enough to conclude the importance.

Will do. Many thanks for your patience and suggestion!

> 
> Thank you for working hard on this!

Thanks. :)

> 

