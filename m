Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16B9524BA9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 13:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353137AbiELLca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 07:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbiELLc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 07:32:28 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF8F69CCB
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 04:32:27 -0700 (PDT)
Received: from fsav119.sakura.ne.jp (fsav119.sakura.ne.jp [27.133.134.246])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 24CBWBHs087089;
        Thu, 12 May 2022 20:32:11 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav119.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp);
 Thu, 12 May 2022 20:32:11 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 24CBWAoq087076
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 12 May 2022 20:32:11 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <33772dcb-c5dd-c5e7-30c8-d2397d21b26c@I-love.SAKURA.ne.jp>
Date:   Thu, 12 May 2022 20:32:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v3 (repost)] workqueue: Warn flushing of kernel-global
 workqueues
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>
References: <2efd5461-fccd-f1d9-7138-0a6767cbf5fe@I-love.SAKURA.ne.jp>
 <CAHk-=wgiCVcF4vJCOcg1hDw9PMT6zNSgt-pPuZL8ihWEcVv3eg@mail.gmail.com>
 <e4203c4f-9c3d-6e33-06e8-052676cc5af1@I-love.SAKURA.ne.jp>
 <YjivtdkpY+reW0Gt@slm.duckdns.org> <YnzjrnnP622mad1y@google.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <YnzjrnnP622mad1y@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/05/12 19:38, Dmitry Torokhov wrote:
> Hi Tejun,
> 
> On Mon, Mar 21, 2022 at 07:02:45AM -1000, Tejun Heo wrote:
>> I'm willing to bet that the majority of the use cases can be converted to
>> use flush_work() and that'd be the preference. We need a separate workqueue
>> iff the flush requrement is complex (e.g. there are multiple dynamic work
>> items in flight which need to be flushed together) or the work items needs
>> some special attributes (such as MEM_RECLAIM or HIGHPRI) which don't apply
>> to the system_wq users in the first place.
> 
> This means that now the code has to keep track of all work items that it
> allocated, instead of being able "fire and forget" works (when dealing
> with extremely infrequent events) and rely on flush_workqueue() to
> cleanup.

Yes. Moreover, a patch to catch and refuse at compile time was proposed at
https://lkml.kernel.org/r/738afe71-2983-05d5-f0fc-d94efbdf7634@I-love.SAKURA.ne.jp .

>          That flush typically happens in module unload path, and I
> wonder if the restriction on flush_workqueue() could be relaxed to allow
> calling it on unload.

A patch for drivers/input/mouse/psmouse-smbus.c is waiting for your response at
https://lkml.kernel.org/r/25e2b787-cb2c-fb0d-d62c-6577ad1cd9df@I-love.SAKURA.ne.jp .
Like many modules, flush_workqueue() happens on only module unload in your case.

We currently don't have a flag to tell whether the caller is inside module unload
path. And even inside module unload path, flushing the system-wide workqueue is
problematic under e.g. GFP_NOFS/GFP_NOIO context. Therefore, I don't think that
the caller is inside module unload path as a good exception.

Removing flush_scheduled_work() is for proactively avoiding new problems like
https://lkml.kernel.org/r/385ce718-f965-4005-56b6-34922c4533b8@I-love.SAKURA.ne.jp
and https://lkml.kernel.org/r/20220225112405.355599-10-Jerome.Pouiller@silabs.com .

Using local WQ also helps for documentation purpose.
This change makes clear where the work's dependency is.
Please grep the linux-next.git tree. Some have been already converted.

Any chance you have too many out-of-tree modules to convert?

