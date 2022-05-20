Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250DE52E954
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 11:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347899AbiETJvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 05:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348026AbiETJvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 05:51:24 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7614D57179
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 02:51:20 -0700 (PDT)
Received: from fsav412.sakura.ne.jp (fsav412.sakura.ne.jp [133.242.250.111])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 24K9pFeC028974;
        Fri, 20 May 2022 18:51:15 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav412.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp);
 Fri, 20 May 2022 18:51:15 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 24K9pFPN028969
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 20 May 2022 18:51:15 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <5f417d30-34a7-8da1-0ad5-33bd750582c7@I-love.SAKURA.ne.jp>
Date:   Fri, 20 May 2022 18:51:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v3] workqueue: Wrap flush_workqueue() using a macro
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <d34dac10-c12f-8bda-35c4-9cb158781db2@I-love.SAKURA.ne.jp>
 <a6288570ed3534b0316723061f5604e3871accef.camel@perches.com>
 <6e4ed62e-888b-6e7a-c13d-67656f39ca94@I-love.SAKURA.ne.jp>
 <738afe71-2983-05d5-f0fc-d94efbdf7634@I-love.SAKURA.ne.jp>
 <YnQKNea6KWFaWNis@slm.duckdns.org>
 <a0d6b5e4-b9c8-1a43-570f-4c73b0f6fc0c@I-love.SAKURA.ne.jp>
 <Yn0538VavQPv+/Ws@slm.duckdns.org>
 <7b2fecdb-59ae-2c54-5a5b-774ef7054d1b@I-love.SAKURA.ne.jp>
 <1c1b272b-239c-e1d1-84de-47d02feb911e@I-love.SAKURA.ne.jp>
 <YodK1czmhZtGmJ8E@slm.duckdns.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <YodK1czmhZtGmJ8E@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/05/20 17:01, Tejun Heo wrote:
>> +/*
>> + * Detect attempt to flush system-wide workqueues at compile time when possible.
>> + * See https://lkml.kernel.org/r/49925af7-78a8-a3dd-bce6-cfc02e1a9236@I-love.SAKURA.ne.jp for
>> + * reasons and steps for converting system-wide workqueues into local workqueues.
>> + */
>> +#define flush_workqueue(wq)						\
>> +({									\
>> +	BUILD_BUG_ON_MSG(__builtin_constant_p(&(wq) == &system_wq) &&	\
>> +			 &(wq) == &system_wq,				\
>> +			 "Please avoid flushing system_wq.");		\
> 
> It kinda bothers me that this causes a build failure. It'd be better if we
> can trigger #warning instead. I'm not sure whether there'd be a clean way to
> do it tho. Maybe just textual matching would provide similar coverage? How
> did you test this?

This does not cause a build failure, for this wrapping happens only if
flush_workqueue() appears between "#define flush_workqueue(wq)" and
"#undef flush_workqueue". Only flush_scheduled_work() in include/linux/workqueue.h
calls flush_workqueue(system_wq), and flush_scheduled_work() is defined
before the "#define flush_workqueue(wq)" is defined.

And use of #warning directive breaks building with -Werror option.

> 
>>  #endif
>> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
>> index 0d2514b4ff0d..08255c332e4b 100644
>> --- a/kernel/workqueue.c
>> +++ b/kernel/workqueue.c
>> @@ -2794,6 +2794,7 @@ static bool flush_workqueue_prep_pwqs(struct workqueue_struct *wq,
>>   * This function sleeps until all work items which were queued on entry
>>   * have finished execution, but it is not livelocked by new incoming ones.
>>   */
>> +#undef flush_workqueue
>>  void flush_workqueue(struct workqueue_struct *wq)
> 
> Maybe rename the function to __flush_workqueue() instead of undef'ing the
> macro?

I prefer not adding __ prefix, for flush_workqueue() is meant as a public function.
For easier life of kernel message parsers, I don't feel reason to dare to rename.

But if you still prefer renaming, I will change flush_workqueue() as an inline function
in include/linux/workqueue.h which calls __flush_workqueue() in kernel/workqueue.c.

