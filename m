Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1419F550224
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 04:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383957AbiFRCts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 22:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbiFRCtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 22:49:47 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216B259BB4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 19:49:47 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LQ0j12rG4zjXyX;
        Sat, 18 Jun 2022 10:48:37 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 18 Jun 2022 10:49:44 +0800
Subject: Re: [PATCH v4 1/4] mm: reduce the rcu lock duration
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Ying Huang <ying.huang@intel.com>, <peterx@redhat.com>,
        <apopple@nvidia.com>, <osalvador@suse.de>,
        <mike.kravetz@oracle.com>, <songmuchun@bytedance.com>,
        <hch@lst.de>, <dhowells@redhat.com>, <cl@linux.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <naoya.horiguchi@nec.com>
References: <20220530113016.16663-1-linmiaohe@huawei.com>
 <20220530113016.16663-2-linmiaohe@huawei.com>
 <bbc060ca6e967790423e0a3ca940d1e700447554.camel@intel.com>
 <b2ddcd64-2779-ede9-3615-ad5bc90a3bc1@huawei.com>
 <87bkvdfzvm.fsf@email.froward.int.ebiederm.org>
 <e10023d7-3d19-1edf-86af-4cb79071b78f@huawei.com>
 <87y1yga1r2.fsf@email.froward.int.ebiederm.org>
 <cb17bad6-dbfa-013c-f879-c1883575f72b@huawei.com>
 <87ilph90dx.fsf@email.froward.int.ebiederm.org>
 <a836d04a-d26b-3eea-3e0e-27af0d2d9651@huawei.com>
 <20220617172316.de2d41877e86be344052b9f5@linux-foundation.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <5abc85bc-fec7-afbf-4ec4-90c1385195d2@huawei.com>
Date:   Sat, 18 Jun 2022 10:49:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220617172316.de2d41877e86be344052b9f5@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/18 8:23, Andrew Morton wrote:
> On Tue, 7 Jun 2022 17:19:53 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
>>>
>>>
>>> If the checks are not made to guarantee they are all checking against
>>> the same mm, the code needs a comment to say that there is a tiny race.
>>> The comment should say we don't care about the tiny race because
>>> the worst that can happen is that a page is migrated to a different
>>> numa node.  And so we don't care.
>>>
>>>
>>
>> I tend to do this one. To make sure, is the below code change what you suggest?
> 
> Eric went quiet.
> 
> As I understand it, any changes arising from this discussion can be
> done as a followup patch.  So I'm planning on moving this 4-patch
> series into the non-rebasing mm-stable branch late next week.

I will send a followup patch when discussion is done. Thanks.

> 
> 
> .
> 

