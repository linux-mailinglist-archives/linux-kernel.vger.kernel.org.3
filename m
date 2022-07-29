Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B7C58496D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 03:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbiG2BtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 21:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbiG2BtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 21:49:19 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C813D54AF1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 18:49:17 -0700 (PDT)
Received: from fsav115.sakura.ne.jp (fsav115.sakura.ne.jp [27.133.134.242])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 26T1n3Gp068884;
        Fri, 29 Jul 2022 10:49:03 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav115.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp);
 Fri, 29 Jul 2022 10:49:03 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 26T1n2W8068878
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 29 Jul 2022 10:49:03 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <97cbf8a9-d5e1-376f-6a49-3474871ea6b4@I-love.SAKURA.ne.jp>
Date:   Fri, 29 Jul 2022 10:49:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] workqueue: don't skip lockdep wq dependency in
 cancel_work_sync()
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>
References: <21b9c1ac-64b7-7f4b-1e62-bf2f021fffcd@I-love.SAKURA.ne.jp>
 <YuK78Jiy12BJG/Tp@slm.duckdns.org>
 <0ad532b2-df5f-331a-ae7f-21460fc62fe2@I-love.SAKURA.ne.jp>
In-Reply-To: <0ad532b2-df5f-331a-ae7f-21460fc62fe2@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes, why did you think that flagging it as if cancel_work_sync()
was flush_work() is a problem?

Unconditionally recording

  "struct mutex" mutex->lockdep_map => "struct work_struct" work1->lockdep_map
  "struct mutex" mutex->lockdep_map => "struct work_struct" work2->lockdep_map

chains has zero problem.

Unconditionally recording

  "struct mutex" mutex->lockdep_map => "struct workqueue_struct" ordered_wq->lockdep_map

chain when ordered_wq can process only one work item at a time
in order to indicate that the ordered_wq is currently unable to process
other works has zero problem.

The example shown in commit d6e89786bed977f3 ("workqueue: skip lockdep wq
dependency in cancel_work_sync()") is nothing but violation of a rule that
"Do not hold a lock from a work callback function (do not record

  "struct work_struct" work1->lockdep_map => "struct mutex" mutex->lockdep_map
  "struct workqueue_struct" ordered_wq->lockdep_map => "struct mutex" mutex->lockdep_map

chain) if somebody might wait for completion of that callback function with
that lock held (might record

  "struct mutex" mutex->lockdep_map => "struct work_struct" work1->lockdep_map
  "struct mutex" mutex->lockdep_map => "struct workqueue_struct" ordered_wq->lockdep_map

chain)."

Which in-tree ordered workqueue instance is hitting this problem?

