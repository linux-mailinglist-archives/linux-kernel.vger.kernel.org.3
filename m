Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6D15284B8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 14:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243620AbiEPMyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 08:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243416AbiEPMxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 08:53:25 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9127538BD0;
        Mon, 16 May 2022 05:53:24 -0700 (PDT)
Received: from kwepemi100016.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4L1zZP5tqvzCspx;
        Mon, 16 May 2022 20:48:29 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100016.china.huawei.com (7.221.188.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 16 May 2022 20:53:22 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 16 May 2022 20:53:22 +0800
Subject: Re: [PROBLEM] nbd requests become stuck when devices watched by
 inotify emit udev uevent changes
To:     Josef Bacik <josef@toxicpanda.com>
CC:     Matthew Ruffell <matthew.ruffell@canonical.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        nbd <nbd@other.debian.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
References: <20220422054224.19527-1-matthew.ruffell@canonical.com>
 <CAEzrpqe=LD3DQcEeLXmmFuq7cX_dAQ6DOCuJYWBoZWKKTmoTzA@mail.gmail.com>
 <CAKAwkKt3yMOOW3NXcE91WkGr+8xj050CYP2pLoQVHt_2wXq=-w@mail.gmail.com>
 <CAKAwkKvfFn18RjupuqGpx4QeAiMYKSq7QUTd3wEL=pkZ+BENpQ@mail.gmail.com>
 <Yn5Zf6lONff1AoOA@localhost.localdomain>
 <6efae367-12fa-1a58-7438-1b39dc0d6ef8@huawei.com>
 <YoJA8C2XtXY27qJ1@localhost.localdomain>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <e0718adf-fe2a-5f1d-a880-bac72cabfe42@huawei.com>
Date:   Mon, 16 May 2022 20:53:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YoJA8C2XtXY27qJ1@localhost.localdomain>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022/05/16 20:17, Josef Bacik 写道:

>> Hi, Josef
>>
>> This seems to try to fix the same problem that I described here:
>>
>> nbd: fix io hung while disconnecting device
>> https://lists.debian.org/nbd/2022/04/msg00207.html
>>
>> There are still some io that are stuck, which means the devcie is
>> probably still opened. Thus nbd_config_put() can't reach here.
>> I'm afraid this patch can't fix the io hung.
>>
>> Matthew, can you try a test with this patch together with my patch below
>> to comfirm my thought?
>>
>> nbd: don't clear 'NBD_CMD_INFLIGHT' flag if request is not completed
>> https://lists.debian.org/nbd/2022/04/msg00212.html.
>>
> 
> Re-submit this one, but fix it so we just test the bit to see if we need to skip
> it, and change it so we only CLEAR when we're sure we're going to complete the
> request.  Thanks,

Ok, thanks for your advice. I'll send a new version.

BTW, do you have any suggestions on other patches of the patchset?

https://lore.kernel.org/all/20220426130746.885140-1-yukuai3@huawei.com/

Thanks,
Kuai
> 
> Josef
> .
> 
