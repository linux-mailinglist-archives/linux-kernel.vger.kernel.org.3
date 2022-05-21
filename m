Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114AB52F74B
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 03:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354279AbiEUBOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 21:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234338AbiEUBOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 21:14:49 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF3B1B12DD
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 18:14:47 -0700 (PDT)
Received: from fsav311.sakura.ne.jp (fsav311.sakura.ne.jp [153.120.85.142])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 24L1EeMB061767;
        Sat, 21 May 2022 10:14:41 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav311.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp);
 Sat, 21 May 2022 10:14:40 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 24L1Ee41061762
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 21 May 2022 10:14:40 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <d05f4745-ba08-61eb-4780-ddfe50d0f1b9@I-love.SAKURA.ne.jp>
Date:   Sat, 21 May 2022 10:14:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v3] workqueue: Wrap flush_workqueue() using a macro
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <738afe71-2983-05d5-f0fc-d94efbdf7634@I-love.SAKURA.ne.jp>
 <YnQKNea6KWFaWNis@slm.duckdns.org>
 <a0d6b5e4-b9c8-1a43-570f-4c73b0f6fc0c@I-love.SAKURA.ne.jp>
 <Yn0538VavQPv+/Ws@slm.duckdns.org>
 <7b2fecdb-59ae-2c54-5a5b-774ef7054d1b@I-love.SAKURA.ne.jp>
 <1c1b272b-239c-e1d1-84de-47d02feb911e@I-love.SAKURA.ne.jp>
 <YodK1czmhZtGmJ8E@slm.duckdns.org>
 <5f417d30-34a7-8da1-0ad5-33bd750582c7@I-love.SAKURA.ne.jp>
 <Yod3S8jmle+LYlES@slm.duckdns.org>
 <1a1634ac-db0e-a44c-b286-a3aba55ad695@I-love.SAKURA.ne.jp>
 <YofLmMTAjNVM+9nQ@slm.duckdns.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <YofLmMTAjNVM+9nQ@slm.duckdns.org>
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

On 2022/05/21 2:10, Tejun Heo wrote:
> On Fri, May 20, 2022 at 08:43:41PM +0900, Tetsuo Handa wrote:
>> All flush_workqueue(system_*_wq) users are gone in linux-next.git, and this patch
>> is for preventing new flush_workqueue(system_*_wq) users from coming in.
> 
> Are we fully sure? Also, there can be other changes in flight which aren't
> covered. It's just not nice in general to intentionally trigger build
> failures without an easy way to remediate it.

Yes, we are fully sure. Subset of this patch is already in linux-next.git without problems.
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20220520&id=5015b3b61696f8f44e7113e5bc14f4a20cbf57ff
There aren't other changes in flight which aren't covered.

I believe that it is safe to replace the commit above with this patch when Linus released
5.18 final (or maybe 5.18-rc8) is released next Sunday. I also believe that it is safe to
send this patch right before Linus releases 5.19-rc1.

I guess that there are several out-of-tree kernel modules which will start
failing with this patch. But they can use

	#undef flush_workqueue

as a temporary workaround (if they can't remediate easily) until we add WARN_ON()
as a run-time check. We will need to wait for several months until we can add
WARN_ON() as a run-time check, for that happens after all flush_scheduled_work()
users are gone.

>> Therefore, triggering a build error (by sending this patch to linux.git right
>> before 5.19-rc1 in order to make sure that developers will not use
>> flush_workqueue(system_*_wq) again) is what this patch is for.
> 
> What I'm trying to say is that, if we can trigger build warnings, that'd be
> a better way to go about it.

Some unlucky users (if any) can workaround this build failure using #undef.
Nothing to bother with how to emit warning messages instead of error messages.

