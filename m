Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C26249C3E0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 07:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237090AbiAZGzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 01:55:21 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:36944 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236928AbiAZGzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 01:55:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643180120; x=1674716120;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EqXP9cz1qHKX9mThQRNdlnUoq955hewu6EA8xxjf0zA=;
  b=UwHX7P3+aXbVSronUWFkdb39Cmm55gCKE45sEm6dmkNBT4H4o1rgjkR3
   5Ym+NhBeveeJ3uGdp2SVdQd8gAK5c3+rPTfX34dUtqACVKVozey+FDMGS
   j+0bT88X8DbK2uOJHHlCZjW6JL5Ch7hPb+SleU1W0i/Z/fQgqs5EBPNDY
   A=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 25 Jan 2022 22:55:20 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 22:55:20 -0800
Received: from [10.216.16.118] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.47.97.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Tue, 25 Jan
 2022 22:55:17 -0800
Message-ID: <e5fb98ca-70f0-4b30-deb3-103e6a9915c4@quicinc.com>
Date:   Wed, 26 Jan 2022 12:25:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] printk: ringbuffer: Improve prb_next_seq() performance
Content-Language: en-US
To:     John Ogness <john.ogness@linutronix.de>,
        <linux-kernel@vger.kernel.org>
CC:     <pmladek@suse.com>, <senozhatsky@chromium.org>,
        <rostedt@goodmis.org>
References: <1642770388-17327-1-git-send-email-quic_mojha@quicinc.com>
 <87tudxfafq.fsf@jogness.linutronix.de>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <87tudxfafq.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.47.97.222)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks John for the review.

@petr : does it looks fine from your side ?


Regards,
-Mukesh

On 1/21/2022 7:38 PM, John Ogness wrote:
> Hi Mukesh,
>
> Thanks for pushing this. I think it got lost somewhere. I have a couple
> very minor non-functional change requests.
>
> On 2022-01-21, Mukesh Ojha <quic_mojha@quicinc.com> wrote:
>> From: Petr Mladek <pmladek@suse.com>
>>
>> prb_next_seq() always iterates from the first known sequence number.
>> In the worst case, it might loop 8k times for 256kB buffer,
>> 15k times for 512kB buffer, and 64k times for 2MB buffer.
>>
>> It was reported that pooling and reading using syslog interface
>                         ^^^^^^^ polling
>
>> might occupy 50% of CPU.
>>
>> Speedup the search by storing @id of the last finalized descriptor.
>>
>> The loop is still needed because the @id is stored and read in the best
>> effort way. An atomic variable is used to keep the @id consistent.
>> But the stores and reads are not serialized against each other.
>> The descriptor could get reused in the meantime. The related sequence
>> number will be used only when it is still valid.
>>
>> An invalid value should be read _only_ when there is a flood of messages
>> and the ringbuffer is rapidly reused. The performance is the least
>> problem in this case.
>>
>> Link: https://lore.kernel.org/lkml/YXlddJxLh77DKfIO@alley/T/#m43062e8b2a17f8dbc8c6ccdb8851fb0dbaabbb14
>> Reported-by: Chunlei Wang <chunlei.wang@mediatek.com>
>> Signed-off-by: Petr Mladek <pmladek@suse.com>
>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>> ---
>> Changes against v2:
>>    Added the hunk suggested by John
>>
>> Changes against v1:
>>    Read @seq by the last finalized @id directly in prb_next_seq() (John)
>>
>>   kernel/printk/printk_ringbuffer.c | 48 +++++++++++++++++++++++++++++++++++----
>>   kernel/printk/printk_ringbuffer.h |  2 ++
>>   2 files changed, 46 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
>> index 8a7b736..297bc18 100644
>> --- a/kernel/printk/printk_ringbuffer.c
>> +++ b/kernel/printk/printk_ringbuffer.c
>> @@ -2005,8 +2014,38 @@ u64 prb_first_valid_seq(struct printk_ringbuffer *rb)
>>    */
>>   u64 prb_next_seq(struct printk_ringbuffer *rb)
>>   {
>> -	u64 seq = 0;
>> +	struct prb_desc_ring *desc_ring = &rb->desc_ring;
>> +	enum desc_state d_state;
>> +	unsigned long id;
>> +	u64 seq;
>> +
>> +	/* Check if the cached @id still points to a valid @seq. */
>> +	id = atomic_long_read(&desc_ring->last_finalized_id);
>> +	d_state = desc_read(desc_ring, id, NULL, &seq, NULL);
>>   
>> +	if (d_state == desc_finalized || d_state == desc_reusable) {
>> +		/*
>> +		 * Begin searching after the last finalized record.
>> +		 * (On 0, the search must begin at 0 because of hack#2
>> +		 * of the bootstrapping phase it is not known if a
>> +		 * record at index 0 exists.)
>> +		*/
>                 ^^^ whitespace
>                 
>> +		if (seq != 0)
>> +			seq++;
>> +	} else {
>> +		/*
>> +		 * The information about the last finalized sequence number
>> +		 * has gone. It should happen only when there is a flood of
>> +		 * new messages and the ringbuffer is rapidly recycled.
>> +		 * Give up and start from the beginning.
>> +		 */
>> +		seq = 0;
>> +	}
>> +
>> +	/*
>> +	 * The information about the last finalized @seq might be inaccurate.
>> +	 * Search forward to find the current one.
>> +	 */
> It is fine to add this comment. But then the following comment should be
> removed. It is redundant.
>
>>   	/* Search forward from the oldest descriptor. */
>>   	while (_prb_read_valid(rb, &seq, NULL, NULL))
>>   		seq++;
> Petr can probably just make the changes when committing. I am not
> requesting a v4.
>
> @Petr: Feel free to add:
>
> Reviewed-by: John Ogness <john.ogness@linutronix.de>
