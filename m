Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D8B51CCBF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 01:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386790AbiEEXdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 19:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241255AbiEEXdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 19:33:15 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F46960A99
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 16:29:34 -0700 (PDT)
Received: from fsav115.sakura.ne.jp (fsav115.sakura.ne.jp [27.133.134.242])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 245NTAcP068515;
        Fri, 6 May 2022 08:29:10 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav115.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp);
 Fri, 06 May 2022 08:29:09 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 245NT9sU068510
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 6 May 2022 08:29:09 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <a0d6b5e4-b9c8-1a43-570f-4c73b0f6fc0c@I-love.SAKURA.ne.jp>
Date:   Fri, 6 May 2022 08:29:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] checkpatch: warn about flushing system-wide workqueues
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
References: <d34dac10-c12f-8bda-35c4-9cb158781db2@I-love.SAKURA.ne.jp>
 <a6288570ed3534b0316723061f5604e3871accef.camel@perches.com>
 <6e4ed62e-888b-6e7a-c13d-67656f39ca94@I-love.SAKURA.ne.jp>
 <738afe71-2983-05d5-f0fc-d94efbdf7634@I-love.SAKURA.ne.jp>
 <YnQKNea6KWFaWNis@slm.duckdns.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <YnQKNea6KWFaWNis@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/05/06 2:32, Tejun Heo wrote:
> Given that we'll need runtime check anyway, why not resurrect the original
> runtime warning but exempt flush_schedule_work() if that's the only thing
> remaining right now (using a special flag or whatever)?

Yes, we will also need runtime check for robustness, for we can't catch usage
like

	struct workqueue_struct *my_wq = alloc_workqueue();
	if (!my_wq)
		my_wq = system_long_wq;
	flush_workqueue(my_wq);

using compile time checks.

I found that it is not easy to trigger flush_workqueue() paths. For example,
several modules are using flush_workqueue() only upon module unloading.
Therefore, I'm trying to catch obvious flush_workqueue() paths at compile
time when possible.

>                                                         If we're sure that
> we aren't triggering it spuriously, we can ask Andrew to take the warning
> patch into -mm so that it floats on top of everything else and gets pulled
> into the trunk during the coming merge window.

OK, the coming merge window means 5.19.

The original runtime checking will be used anyway. Is "workqueue: Wrap
flush_workqueue() using a macro" OK for you as a compile time check?

