Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFC6462D35
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 07:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238876AbhK3HBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 02:01:37 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:60497 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232051AbhK3HBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 02:01:36 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=zhangliguang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UyrFgnZ_1638255494;
Received: from 30.225.24.15(mailfrom:zhangliguang@linux.alibaba.com fp:SMTPD_---0UyrFgnZ_1638255494)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 30 Nov 2021 14:58:15 +0800
Message-ID: <59c28c51-5d73-398d-3e8d-3fb6bac89671@linux.alibaba.com>
Date:   Tue, 30 Nov 2021 14:58:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] nvme: duplicate NQNs check if devices needed
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211129111854.44006-1-zhangliguang@linux.alibaba.com>
 <20211129163406.GA3582042@dhcp-10-100-145-180.wdc.com>
 <5f1be6d6-fa0d-8084-ccf1-7a3af6506046@linux.alibaba.com>
 <20211130064054.GB10268@lst.de>
From:   luanshi <zhangliguang@linux.alibaba.com>
In-Reply-To: <20211130064054.GB10268@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

在 2021/11/30 14:40, Christoph Hellwig 写道:
> On Tue, Nov 30, 2021 at 01:04:55PM +0800, luanshi wrote:
>> Hi Keith,
>>
>> 在 2021/11/30 0:34, Keith Busch 写道:
>>> On Mon, Nov 29, 2021 at 07:18:54PM +0800, Liguang Zhang wrote:
>>>> @@ -2587,6 +2587,9 @@ static struct nvme_subsystem *__nvme_find_get_subsystem(const char *subsysnqn)
>>>>      	lockdep_assert_held(&nvme_subsystems_lock);
>>>>    +	if (strncmp(subsysnqn, "nqn.", 4))
>>>> +		return NULL;
>>> This seems like an arbitrary way to decide not to check for duplicates.
>>> Shouldn't we just add the NVME_QUIRK_IGNORE_DEV_SUBNQN quirk for the
>>> broken controllers?
>> Yeah, add the NVME_QUIRK_IGNORE_DEV_SUBNQN quirk is a way to resolve the
>> problem. I do not
>>
>> have enough controller in my hand, I don't make sure all the controller are
>> covered. And there are some
> What does this broken device report in the subnqn field?
In function nvme_init_subnqn, i add some printk info,

#git diff drivers/nvme/host/core.c
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e1e574ecf031..d043f4506c37 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2708,6 +2708,7 @@ static void nvme_init_subnqn(struct nvme_subsystem 
*subsys, struct nvme_ctrl *ct

         if(!(ctrl->quirks & NVME_QUIRK_IGNORE_DEV_SUBNQN)) {
                 nqnlen = strnlen(id->subnqn, NVMF_NQN_SIZE);
+             printk("%s: nqnlen=%d, subnqn=%s\n", __func__, nqnlen, 
id->subnqn);
                 if (nqnlen > 0 && nqnlen < NVMF_NQN_SIZE) {
                         strlcpy(subsys->subnqn, id->subnqn, NVMF_NQN_SIZE);
                         return;

I found that:

nqnlen is 1, subnqn filed is filled by space.

nvme_init_subnqn: nqnlen=1 subnqn=


Thanks,

Liguang

