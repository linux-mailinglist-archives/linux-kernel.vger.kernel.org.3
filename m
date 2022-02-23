Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A17A4C1E6E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 23:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243732AbiBWW1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 17:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbiBWW1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 17:27:12 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393F62AC41
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 14:26:43 -0800 (PST)
Received: from fsav113.sakura.ne.jp (fsav113.sakura.ne.jp [27.133.134.240])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 21NMQVeP085775;
        Thu, 24 Feb 2022 07:26:31 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav113.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp);
 Thu, 24 Feb 2022 07:26:31 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 21NMQUMj085771
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 24 Feb 2022 07:26:30 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <9a883d72-ea7d-1936-93e6-5c2a290509d4@I-love.SAKURA.ne.jp>
Date:   Thu, 24 Feb 2022 07:26:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] workqueue: Use private WQ for schedule_on_each_cpu() API
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, kernel test robot <oliver.sang@intel.com>
References: <20220221083358.GC835@xsang-OptiPlex-9020>
 <3a20c799-c18e-dd3a-3161-fee6bca1491e@I-love.SAKURA.ne.jp>
 <YhUdjip4VSWe4zDO@slm.duckdns.org>
 <16a33a65-3c67-ef66-ccc8-9c4fffb0ae5a@I-love.SAKURA.ne.jp>
 <YhaoDiJ8MUOhRmp6@slm.duckdns.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <YhaoDiJ8MUOhRmp6@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/02/24 6:33, Tejun Heo wrote:
> On Wed, Feb 23, 2022 at 09:57:27AM +0900, Tetsuo Handa wrote:
>> On 2022/02/23 2:29, Tejun Heo wrote:
>>> On Mon, Feb 21, 2022 at 07:38:09PM +0900, Tetsuo Handa wrote:
>>>> Since schedule_on_each_cpu() calls schedule_work_on() and flush_work(),
>>>> we should avoid using system_wq in order to avoid unexpected locking
>>>> dependency.
>>>
>>> I don't get it. schedule_on_each_cpu() is flushing each work item and thus
>>> shouldn't need its own flushing domain. What's this change for?
>>
>> A kernel test robot tested "[PATCH v2] workqueue: Warn flush attempt using
>> system-wide workqueues" on 5.16.0-06523-g29bd199e4e73 and hit a lockdep
>> warning ( https://lkml.kernel.org/r/20220221083358.GC835@xsang-OptiPlex-9020 ).
>>
>> Although the circular locking dependency itself needs to be handled by
>> lockless console printing support, we won't be able to apply
>> "[PATCH v2] workqueue: Warn flush attempt using system-wide workqueues"
>> if schedule_on_each_cpu() continues using system-wide workqueues.
> 
> The patch seems pretty wrong. What's problematic is system workqueue flushes
> (which flushes the entire workqueue), not work item flushes.

Why? My understanding is that

  flushing a workqueue waits for completion of all work items in that workqueue

  flushing a work item waits for for completion of that work item using
  a workqueue specified as of queue_work()

and

  if a work item in some workqueue is blocked by other work in that workqueue
  (e.g. max_active limit, work items on that workqueue and locks they need),
  it has a risk of deadlock

. Then, how can flushing a work item using system-wide workqueues be free of deadlock risk?
Isn't it just "unlikely to deadlock" rather than "impossible to deadlock"?

