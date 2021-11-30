Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B184462BE7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 06:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbhK3FIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 00:08:17 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:45403 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231882AbhK3FIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 00:08:16 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=zhangliguang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UyqOnfv_1638248693;
Received: from 30.225.24.15(mailfrom:zhangliguang@linux.alibaba.com fp:SMTPD_---0UyqOnfv_1638248693)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 30 Nov 2021 13:04:54 +0800
Message-ID: <5f1be6d6-fa0d-8084-ccf1-7a3af6506046@linux.alibaba.com>
Date:   Tue, 30 Nov 2021 13:04:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] nvme: duplicate NQNs check if devices needed
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211129111854.44006-1-zhangliguang@linux.alibaba.com>
 <20211129163406.GA3582042@dhcp-10-100-145-180.wdc.com>
From:   luanshi <zhangliguang@linux.alibaba.com>
In-Reply-To: <20211129163406.GA3582042@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keith,

在 2021/11/30 0:34, Keith Busch 写道:
> On Mon, Nov 29, 2021 at 07:18:54PM +0800, Liguang Zhang wrote:
>> @@ -2587,6 +2587,9 @@ static struct nvme_subsystem *__nvme_find_get_subsystem(const char *subsysnqn)
>>   
>>   	lockdep_assert_held(&nvme_subsystems_lock);
>>   
>> +	if (strncmp(subsysnqn, "nqn.", 4))
>> +		return NULL;
> This seems like an arbitrary way to decide not to check for duplicates.
> Shouldn't we just add the NVME_QUIRK_IGNORE_DEV_SUBNQN quirk for the
> broken controllers?

Yeah, add the NVME_QUIRK_IGNORE_DEV_SUBNQN quirk is a way to resolve the 
problem. I do not

have enough controller in my hand, I don't make sure all the controller 
are covered. And there are some

Weird devices from partners are not registered in pci id table:

https://pci-ids.ucw.cz/

"nqn." prefix is a required naming, so i used this way.


Thanks,

Liguang

