Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C065A52EB13
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 13:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348678AbiETLn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 07:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348659AbiETLn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 07:43:56 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0AAD029D
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 04:43:55 -0700 (PDT)
Received: from fsav114.sakura.ne.jp (fsav114.sakura.ne.jp [27.133.134.241])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 24KBhixB020639;
        Fri, 20 May 2022 20:43:44 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav114.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp);
 Fri, 20 May 2022 20:43:44 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 24KBhhDl020635
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 20 May 2022 20:43:44 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <1a1634ac-db0e-a44c-b286-a3aba55ad695@I-love.SAKURA.ne.jp>
Date:   Fri, 20 May 2022 20:43:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v3] workqueue: Wrap flush_workqueue() using a macro
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <a6288570ed3534b0316723061f5604e3871accef.camel@perches.com>
 <6e4ed62e-888b-6e7a-c13d-67656f39ca94@I-love.SAKURA.ne.jp>
 <738afe71-2983-05d5-f0fc-d94efbdf7634@I-love.SAKURA.ne.jp>
 <YnQKNea6KWFaWNis@slm.duckdns.org>
 <a0d6b5e4-b9c8-1a43-570f-4c73b0f6fc0c@I-love.SAKURA.ne.jp>
 <Yn0538VavQPv+/Ws@slm.duckdns.org>
 <7b2fecdb-59ae-2c54-5a5b-774ef7054d1b@I-love.SAKURA.ne.jp>
 <1c1b272b-239c-e1d1-84de-47d02feb911e@I-love.SAKURA.ne.jp>
 <YodK1czmhZtGmJ8E@slm.duckdns.org>
 <5f417d30-34a7-8da1-0ad5-33bd750582c7@I-love.SAKURA.ne.jp>
 <Yod3S8jmle+LYlES@slm.duckdns.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <Yod3S8jmle+LYlES@slm.duckdns.org>
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

On 2022/05/20 20:11, Tejun Heo wrote:
>>> It kinda bothers me that this causes a build failure. It'd be better if we
>>> can trigger #warning instead. I'm not sure whether there'd be a clean way to
>>> do it tho. Maybe just textual matching would provide similar coverage? How
>>> did you test this?
>>
>> This does not cause a build failure, for this wrapping happens only if
>> flush_workqueue() appears between "#define flush_workqueue(wq)" and
>> "#undef flush_workqueue". Only flush_scheduled_work() in include/linux/workqueue.h
>> calls flush_workqueue(system_wq), and flush_scheduled_work() is defined
>> before the "#define flush_workqueue(wq)" is defined.
> 
> What I mean is that if there's a file which didn't get tested or another
> pull request which raced and that thing flushes one of the system_wq's,
> it'll trigger a build error instead of a warning, which is a bit of an
> overkill.

All flush_workqueue(system_*_wq) users are gone in linux-next.git, and this patch
is for preventing new flush_workqueue(system_*_wq) users from coming in.

Therefore, triggering a build error (by sending this patch to linux.git right
before 5.19-rc1 in order to make sure that developers will not use
flush_workqueue(system_*_wq) again) is what this patch is for.

We will also remove flush_scheduled_work() after
all flush_scheduled_work() users are gone.

> 
>> And use of #warning directive breaks building with -Werror option.
> 
> If the user wants to fail build on warnings, sure. That's different from
> kernel failing to build in a way which may require non-trivial changes to
> fix.

How can #warning directive be utilized inside #define or inline function, for
we can't do like

  #define flush_workqueue(wq)						\
  #if wq == "system_wq"                                                \
  #warning Please avoid flushing system_wq.                            \
  #endif                                                               \
  __flush_workqueue(wq)

or

  static inline void flush_workqueue(struct workqueue_struct *wq)
  {
  #if wq == "system_wq"
  #warning Please avoid flushing system_wq.
  #endif
  	__flush_workqueue(wq);
  }

. We can use BUiLD_BUG_ON() but I don't think we can use #warning directive.

> 
>>> Maybe rename the function to __flush_workqueue() instead of undef'ing the
>>> macro?
>>
>> I prefer not adding __ prefix, for flush_workqueue() is meant as a public function.
>> For easier life of kernel message parsers, I don't feel reason to dare to rename.
> 
> You mean the WARN_ON messages? Given how they never trigger, I doubt there's
> much to break. Maybe some kprobe users? But they can survive.

WARN_ON() by passing system-wide workqueues should not happen.
But backtrace of a warning message while inside __flush_workqueue() will be
still possible.

