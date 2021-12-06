Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D22E046A5BE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 20:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348599AbhLFTiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 14:38:04 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4216 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348532AbhLFThx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 14:37:53 -0500
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J7D693Pgrz67NyB;
        Tue,  7 Dec 2021 03:30:09 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 20:34:20 +0100
Received: from [10.47.82.161] (10.47.82.161) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 6 Dec
 2021 19:34:19 +0000
Subject: Re: [PATCH v2 0/3] blk-mq: Optimise blk_mq_queue_tag_busy_iter() for
 shared tags
To:     Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ming.lei@redhat.com>, <kashyap.desai@broadcom.com>, <hare@suse.de>
References: <1638794990-137490-1-git-send-email-john.garry@huawei.com>
 <67feacc8-3da7-90de-cc0c-f8b529f84297@kernel.dk>
From:   John Garry <john.garry@huawei.com>
Message-ID: <544f60f5-a367-a1a0-5a21-9708a7e8d2e1@huawei.com>
Date:   Mon, 6 Dec 2021 19:34:05 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <67feacc8-3da7-90de-cc0c-f8b529f84297@kernel.dk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.82.161]
X-ClientProxiedBy: lhreml721-chm.china.huawei.com (10.201.108.72) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2021 19:07, Jens Axboe wrote:
> On 12/6/21 5:49 AM, John Garry wrote:
>> In [0] Kashyap reports high CPU usage for blk_mq_queue_tag_busy_iter()
>> and callees for shared tags.
>>
>> Indeed blk_mq_queue_tag_busy_iter() would be less optimum for moving to
>> shared tags, but it was not optimum previously.
>>
>> This series optimises by having only a single iter (per regular and resv
>> tags) for the shared tags, instead of an iter per HW queue.
>>
>> [0]https://lore.kernel.org/linux-block/e4e92abbe9d52bcba6b8cc6c91c442cc@mail.gmail.com/

Hi Jens,

> The patch(es) are missing Fixes tags.

The first two patches aren't fixes, but are general dev. As for the 
last, it prob should go as a fix for 5.16, but I was not sure how you 
would feel about that - it's not a trivial change, we're late in the 
cycle, and Kashyap was happy for 5.17 .

Let me know if the last could be accepted as a fix and I'll re-send 
separately with a fixes tag.

Thanks,
John
