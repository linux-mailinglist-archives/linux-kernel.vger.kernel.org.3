Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA32258489C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 01:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbiG1XSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 19:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiG1XSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 19:18:47 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81217393A
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 16:18:46 -0700 (PDT)
Received: from fsav113.sakura.ne.jp (fsav113.sakura.ne.jp [27.133.134.240])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 26SNIY6G031260;
        Fri, 29 Jul 2022 08:18:34 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav113.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp);
 Fri, 29 Jul 2022 08:18:34 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 26SNIY7Q031253
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 29 Jul 2022 08:18:34 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <0ad532b2-df5f-331a-ae7f-21460fc62fe2@I-love.SAKURA.ne.jp>
Date:   Fri, 29 Jul 2022 08:18:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] workqueue: don't skip lockdep wq dependency in
 cancel_work_sync()
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <21b9c1ac-64b7-7f4b-1e62-bf2f021fffcd@I-love.SAKURA.ne.jp>
 <YuK78Jiy12BJG/Tp@slm.duckdns.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <YuK78Jiy12BJG/Tp@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/07/29 1:40, Tejun Heo wrote:
> Tetsuo, you gotta explain why this is okay w.r.t. the spurious warnings that
> the above commit addressed. You can't just state that there are cases which
> are missed and then revert it.

There are four commits related to this change.

  commit 87915adc3f0acdf03c776df42e308e5a155c19af
  Author: Johannes Berg <johannes.berg@intel.com>
  Date:   Wed Aug 22 11:49:04 2018 +0200

      workqueue: re-add lockdep dependencies for flushing

  commit d6e89786bed977f37f55ffca11e563f6d2b1e3b5
  Author: Johannes Berg <johannes.berg@intel.com>
  Date:   Wed Aug 22 11:49:03 2018 +0200

      workqueue: skip lockdep wq dependency in cancel_work_sync()

  commit fd1a5b04dfb899f84ddeb8acdaea6b98283df1e5
  Author: Byungchul Park <byungchul.park@lge.com>
  Date:   Wed Oct 25 17:56:04 2017 +0900

      workqueue: Remove now redundant lock acquisitions wrt. workqueue flushes

  commit 0976dfc1d0cd80a4e9dfaf87bd8744612bde475a
  Author: Stephen Boyd <sboyd@codeaurora.org>
  Date:   Fri Apr 20 17:28:50 2012 -0700

      workqueue: Catch more locking problems with flush_work()

. Commit 87915adc3f0acdf0 ("workqueue: re-add lockdep dependencies for
flushing") saying

    These were removed after cross-release partially caught these
    problems, but now cross-release was reverted anyway. IMHO the
    removal was erroneous anyway though, since lockdep should be
    able to catch potential problems, not just actual ones, and
    cross-release would only have caught the problem when actually
    invoking wait_for_completion().

is the answer, commit 0976dfc1d0cd80a4 ("workqueue: Catch more locking
problems with flush_work()") saying

    Add a lockdep hint by acquiring and releasing the work item
    lockdep_map in flush_work() so that we always catch this
    potential deadlock scenario.

is what this patch restores.
