Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9EB46EA3E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 15:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238854AbhLIOqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 09:46:54 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4239 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233886AbhLIOqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 09:46:53 -0500
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J8xVt5szMz67sxC;
        Thu,  9 Dec 2021 22:39:02 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Thu, 9 Dec 2021 15:43:17 +0100
Received: from [10.47.91.245] (10.47.91.245) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Thu, 9 Dec
 2021 14:43:17 +0000
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v2] blk-mq: Fix blk_mq_tagset_busy_iter() for shared tags
To:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hare@suse.de>, <ming.lei@redhat.com>, <linux-scsi@vger.kernel.org>
References: <1634550083-202815-1-git-send-email-john.garry@huawei.com>
 <163482611742.37241.15630114014516067630.b4-ty@kernel.dk>
 <0b928f7dbc2f3244afe8a475b547157f@mail.gmail.com>
Message-ID: <3389cd7b-2934-8e82-b09a-a4fdb0f00ea3@huawei.com>
Date:   Thu, 9 Dec 2021 14:42:55 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <0b928f7dbc2f3244afe8a475b547157f@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.91.245]
X-ClientProxiedBy: lhreml724-chm.china.huawei.com (10.201.108.75) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2021 13:52, Kashyap Desai wrote:
> + scsi mailing list
> 
>> On Mon, 18 Oct 2021 17:41:23 +0800, John Garry wrote:
>>> Since it is now possible for a tagset to share a single set of tags,
>>> the iter function should not re-iter the tags for the count of #hw
>>> queues in that case. Rather it should just iter once.
> John - Recently we found issue of error hander thread never kicked off and
> this patch fix the issue.
> Without this patch, scsi error hander will not find correct host_busy
> counter.
> 
> Take one simple case. There is one IO outstanding and that is getting
> timedout.
> Now SML wants to wake up EH thread only if, below condition met
> "scsi_host_busy(shost) == shost->host_failed"
> 
> Without this patch, shared host tag enabled meagaraid_sas driver will find
> host_busy = actual outstanding * nr_hw_queues.
> Error handler thread will never be kicked-off.
> 
> This patch is mandatory for fixing shared host tag feature and require to be
> part of stable kernel.
> 
> Do you need more data for posting to stable kernel ?

To be clear, are you saying that you see the issue which patch "blk-mq: 
Fix blk_mq_tagset_busy_iter() for shared tags" fixes before v5.16-rc?

This patch (now commit 0994c64eb415) and the commit which it is supposed 
to fix, e155b0c238b2, will only be in v5.16, so I don't see anything 
which is needed in stable.

Thanks,
John
