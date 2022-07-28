Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05CFA583EC7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 14:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238453AbiG1M0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 08:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238173AbiG1M0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 08:26:17 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510FE52FE4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 05:26:17 -0700 (PDT)
Received: from fsav111.sakura.ne.jp (fsav111.sakura.ne.jp [27.133.134.238])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 26SCPrv4091076;
        Thu, 28 Jul 2022 21:25:53 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav111.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp);
 Thu, 28 Jul 2022 21:25:53 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 26SCPr5O091072
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 28 Jul 2022 21:25:53 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <49e04fb8-e8fe-17d3-0b5f-e8d255010936@I-love.SAKURA.ne.jp>
Date:   Thu, 28 Jul 2022 21:25:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [syzbot] INFO: task hung in hci_dev_close_sync
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        Tejun Heo <tj@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+c56f6371c48cad0420f9@syzkaller.appspotmail.com>
References: <20220504044800.4966-1-hdanton@sina.com>
 <a58edafc-0a60-2eee-4058-8d69e5f1310b@I-love.SAKURA.ne.jp>
 <05280c37163d08ff2d00d71c5454baf651867bd3.camel@sipsolutions.net>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <05280c37163d08ff2d00d71c5454baf651867bd3.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/05/04 18:24, Johannes Berg wrote:
> On Wed, 2022-05-04 at 05:12 +0000, Tetsuo Handa wrote:
>>
>> This seems to be a question regarding commit 87915adc3f0acdf0 ("workqueue: re-add lockdep dependencies for flushing").
>>>
>>> syzbot should have been able to catch cancel_work_sync() in work context
>>> by checking lockdep_map in __flush_work() for both flush and cancel.
>>>
>>> Hillf
>>>
>>> --- y/kernel/workqueue.c
>>> +++ x/kernel/workqueue.c
>>> @@ -3075,10 +3075,10 @@ static bool __flush_work(struct work_str
>>>       if (WARN_ON(!work->func))
>>>               return false;
>>>
>>> -     if (!from_cancel) {
>>> +     //if (!from_cancel) {
>>>
> 
> I think this is explained in commit d6e89786bed9 ("workqueue: skip
> lockdep wq dependency in cancel_work_sync()")

I couldn't agree on that reasoning, and I sent
https://lkml.kernel.org/r/21b9c1ac-64b7-7f4b-1e62-bf2f021fffcd@I-love.SAKURA.ne.jp .
