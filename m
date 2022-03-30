Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB394EB7E4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 03:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241674AbiC3Bhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 21:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbiC3Bh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 21:37:29 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAE9B1ABE;
        Tue, 29 Mar 2022 18:35:45 -0700 (PDT)
Received: from kwepemi100014.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KSpsT5J6nzcbKx;
        Wed, 30 Mar 2022 09:35:25 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100014.china.huawei.com (7.221.188.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 30 Mar 2022 09:35:42 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 30 Mar 2022 09:35:42 +0800
Subject: Re: [PATCH -next RFC 2/6] block: refactor to split bio thoroughly
To:     Jens Axboe <axboe@kernel.dk>, <andriy.shevchenko@linux.intel.com>,
        <john.garry@huawei.com>, <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20220329094048.2107094-1-yukuai3@huawei.com>
 <20220329094048.2107094-3-yukuai3@huawei.com>
 <2b37ce73-83dd-e572-9578-7bb045f1040b@kernel.dk>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <81bc3675-ddc6-1742-40e5-a1022dba68ca@huawei.com>
Date:   Wed, 30 Mar 2022 09:35:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2b37ce73-83dd-e572-9578-7bb045f1040b@kernel.dk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600009.china.huawei.com (7.193.23.164)
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

On 2022/03/29 20:46, Jens Axboe wrote:
> On 3/29/22 3:40 AM, Yu Kuai wrote:
>> Currently, the splited bio is handled first, and then continue to split
>> the original bio. This patch tries to split the original bio thoroughly,
>> so that it can be known in advance how many tags will be needed.
> 
> This makes the bio almost 10% bigger in size, which is NOT something
> that is just done casually and without strong reasoning.
Hi,

Thanks for taking time on this patchset, It's right this way is not
appropriate.
> 
> So please provide that, your commit message is completely missing
> justification for why this change is useful or necessary. A good
> commit always explains WHY the change needs to be made, yours is
> simply stating WHAT is being done. The latter can be gleaned from
> the code change anyway.
> 
Thanks for the guidance, I'll pay attemtion to that carefully in future.

For this patch, what I want to do is to gain information about how many
tags will be needed for the big io before getting the first tag, and use
that information to optimize wake up path. The problem in this patch is
that adding two feilds in bio is a bad move.

I was thinking that for segment split, I can get the information by
caculating bio segments / queue max segments.

Thanks,
Kuai

