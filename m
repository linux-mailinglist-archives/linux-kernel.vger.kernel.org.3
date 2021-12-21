Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14CB847C2A5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 16:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239207AbhLUPTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 10:19:48 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4314 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239157AbhLUPTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:19:47 -0500
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JJKl45Wzpz6H8S1;
        Tue, 21 Dec 2021 23:15:12 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 21 Dec 2021 16:19:44 +0100
Received: from [10.195.32.222] (10.195.32.222) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 21 Dec 2021 15:19:44 +0000
Subject: Re: [PATCH RFT] blk-mq: optimize queue tag busy iter for shared_tags
To:     Kashyap Desai <kashyap.desai@broadcom.com>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ming.lei@redhat.com>,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>
References: <20211221123157.14052-1-kashyap.desai@broadcom.com>
 <e9174a89-b3a4-d737-c5a9-ff3969053479@huawei.com>
 <7028630054e9cd0e8c84670a27c2b164@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <e7288bcd-cc4d-8f57-a0c8-eadd53732177@huawei.com>
Date:   Tue, 21 Dec 2021 15:19:43 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <7028630054e9cd0e8c84670a27c2b164@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.32.222]
X-ClientProxiedBy: lhreml750-chm.china.huawei.com (10.201.108.200) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kashyap,

> This is for current/5.17. This patch is meaningfully only on top of [1].
> 
> [1] " blk-mq: Use shared tags for shared sbitmap support" Commit -
> e155b0c238b20f0a866f4334d292656665836c8a
> 

But your change seems effectively the same as in 
https://lore.kernel.org/all/1638794990-137490-4-git-send-email-john.garry@huawei.com/, 
which is now merged in Jens' 5.17 queue:

https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-5.17/block&id=fea9f92f1748083cb82049ed503be30c3d3a9b69

> While doing additional testing for [1], I noticed some performance issue.
> Along with the performance issue, I noticed CPU lockup as well. Lockup
> trace -
> 
> _raw_spin_lock_irqsave+0x42/0x50
>   blk_mq_find_and_get_req+0x20/0xa0
>   bt_iter+0x2d/0x80
>   blk_mq_queue_tag_busy_iter+0x1aa/0x2f0
>   ? blk_mq_complete_request+0x30/0x30
>   ? blk_mq_complete_request+0x30/0x30
>   ? __schedule+0x360/0x850
>   blk_mq_timeout_work+0x5e/0x120
>   process_one_work+0x1a8/0x380
>   worker_thread+0x30/0x380
>   ? wq_calc_node_cpumask.isra.30+0x100/0x100
>   kthread+0x167/0x190
>   ? set_kthread_struct+0x40/0x40
>   ret_from_fork+0x22/0x30
> 
> It is a generic performance issue if driver use " shost->host_tagset = 1".
> In fact, I found that [1] is useful to fix performance issue and provided
> this additional patch.
> 
> I changed my setup to have 64 scsi_devices (earlier I just kept 16 or 24
> drives, so did not noticed this issue). Performance/cpu lockup issue is not
> due to [1].
> More number of scsi device, hardware context per host and high queue depth
> will increase the chances of lockup and performance drop.
> 
> Do you think, it is good to have changes in 5.16 + stable ?
> I don't know if this  patch will create any side effect. Can you review and
> let me know your feedback. ?
> 

Can you test my merged change again for this scenario?

I will also note that I mentioned previously that 
blk_mq_queue_tag_busy_iter() was not optimum for shared sbitmap, i.e. 
before shared tags, but no one said performance was bad for shared sbitmap.

Thanks,
John
