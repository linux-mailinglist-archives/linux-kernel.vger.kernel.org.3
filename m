Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387CD4CB4DD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 03:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbiCCC2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 21:28:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbiCCC2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 21:28:01 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A79C0D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 18:27:17 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4K8FGF4CJxzdZRs;
        Thu,  3 Mar 2022 10:25:57 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 3 Mar 2022 10:27:14 +0800
Subject: Re: [PATCH 6/9] mm/z3fold: move decrement of pool->pages_nr into
 __release_z3fold_page()
To:     Vitaly Wool <vitaly.wool@konsulko.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        David Laight <David.Laight@aculab.com>
References: <20220219092533.12596-1-linmiaohe@huawei.com>
 <20220219092533.12596-7-linmiaohe@huawei.com>
 <dba43259e1fe4e36a0bdbe97efaaca2f@AcuMS.aculab.com>
 <baeab92c-d966-2dc2-d952-c7f3faf2a229@huawei.com>
 <03647389a32045f38ec18b090548a26d@AcuMS.aculab.com>
 <CAM4kBBLoaESLRr28kZ901e-nikDbnQnUu9h47OsA2phxp-pvuA@mail.gmail.com>
 <bd5c8187c4034016a22977c9ca54c1b0@AcuMS.aculab.com>
 <CAM4kBB+oHqn=AAqKrxgN=e7iyRiZs0HDx8J585Vugf4kyWfF5Q@mail.gmail.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <7fab39f6-1a65-9577-4ddf-f3e984474844@huawei.com>
Date:   Thu, 3 Mar 2022 10:27:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAM4kBB+oHqn=AAqKrxgN=e7iyRiZs0HDx8J585Vugf4kyWfF5Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

On 2022/3/2 18:19, Vitaly Wool wrote:
> On Wed, Mar 2, 2022 at 10:12 AM David Laight <David.Laight@aculab.com> wrote:
>>
>>>> Atomic operations aren't magic.
>>>> Atomic operations are (at best) one slow locked bus cycle.
>>>> Acquiring a lock is the same.
>>>> Releasing a lock might be cheaper, but is probably a locked bus cycle.
>>>>
>>>> So if you use state_lock to protect pages_nr then you lose an atomic
>>>> operation for the decrement and gain one (for the unlock) in the increment.
>>>> That is even or maybe a slight gain.
>>>> OTOH a 64bit atomic is a PITA on some 32bit systems.
>>>> (In fact any atomic is a PITA on sparc32.)
>>>
>>> It's actually *stale_lock* and it's very misleading to use it for this.
>>> I would actually like to keep atomics but I have no problem with
>>> making it 32-bit for 32-bit systems. Would that work for you guys?
>>
>> It would be better to rename the lock.
> 
> No it would not because that lock is protecting the list of entries
> that could not be immediately freed.
> 

Or could we use pool->lock to do this ?

> ~Vitaly

Vitaly, is the patch itself worth a Reviewed-by tag and go to the mm-tree ? Could this
enhance discussed here be sent as another separate patch or am I supposed to make this
change into the current patch?

Many thanks for comment.

> .
> 

