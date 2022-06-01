Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67B2539D5A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 08:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349896AbiFAGp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 02:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347079AbiFAGp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 02:45:26 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3145195A3A
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 23:45:25 -0700 (PDT)
Received: from [10.180.13.187] (unknown [10.180.13.187])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxT0_yCpdiYT0LAA--.3609S3;
        Wed, 01 Jun 2022 14:45:06 +0800 (CST)
Subject: Re: [PATCH v1] sched: there is no need to call switch_mm_irqs_off
 when sched between two user thread.
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
References: <1653998201-10230-1-git-send-email-wangming01@loongson.cn>
 <YpYqOC9Wx84oC2z5@hirez.programming.kicks-ass.net>
From:   Ming Wang <wangming01@loongson.cn>
Message-ID: <a89053c6-ee36-e5a6-3c8f-c1cb64f54d93@loongson.cn>
Date:   Wed, 1 Jun 2022 14:45:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <YpYqOC9Wx84oC2z5@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf9DxT0_yCpdiYT0LAA--.3609S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KryxJF4xAry7Kw45JrWUurg_yoW8Jw1kp3
        yDJFy7GFnrua4jkay3Xwn5uryruws0gF47GFn0kFZ3JF98Kwn5Kr1rX3W3uFyIvr4fKrWa
        vr40v34IqFyUCaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBmb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x0
        82IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXw
        Av7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4II
        rI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21lc2xSY4AK6svPMxAIw2
        8IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
        x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrw
        CI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI
        42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I
        8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7F1vUUUUU
X-CM-SenderInfo: 5zdqwzxlqjiio6or00hjvr0hdfq/
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/5/31 下午10:46, Peter Zijlstra wrote:
> On Tue, May 31, 2022 at 07:56:41PM +0800, Ming Wang wrote:
>> When condition (prev->active_mm == next->mm && !prev->mm) is met,
>> the situation is as follows:
>>
>> user thread -> user thread
>>
>> There is not need switch_mm when sched between two user thread.
>> Because they share the mm_struct. This can provide better
>> performance when testing UnixBench.
>>
>> Signed-off-by: Ming Wang <wangming01@loongson.cn>
>> ---
>>   kernel/sched/core.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 696c649..9d7f6fb 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -5099,7 +5099,8 @@ asmlinkage __visible void schedule_tail(struct task_struct *prev)
>>   		 * case 'prev->active_mm == next->mm' through
>>   		 * finish_task_switch()'s mmdrop().
>>   		 */
>> -		switch_mm_irqs_off(prev->active_mm, next->mm, next);
>> +		if ((prev->active_mm != next->mm) || (!prev->mm))
>> +			switch_mm_irqs_off(prev->active_mm, next->mm, next);
> I think this needs to be inside switch_mm(). Architectures are free to
> play silly games with what the current active mm is (and iirc x86
> actually does this).
ok, thanks! And I will do it in architecture code.

