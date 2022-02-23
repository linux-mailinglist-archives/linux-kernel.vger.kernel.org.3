Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD024C067E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 01:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236409AbiBWA6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 19:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236088AbiBWA6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 19:58:13 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886CFDF03
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 16:57:45 -0800 (PST)
Received: from fsav311.sakura.ne.jp (fsav311.sakura.ne.jp [153.120.85.142])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 21N0vS39054900;
        Wed, 23 Feb 2022 09:57:28 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav311.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp);
 Wed, 23 Feb 2022 09:57:28 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 21N0vSuY054897
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 23 Feb 2022 09:57:28 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <16a33a65-3c67-ef66-ccc8-9c4fffb0ae5a@I-love.SAKURA.ne.jp>
Date:   Wed, 23 Feb 2022 09:57:27 +0900
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
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <YhUdjip4VSWe4zDO@slm.duckdns.org>
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

On 2022/02/23 2:29, Tejun Heo wrote:
> On Mon, Feb 21, 2022 at 07:38:09PM +0900, Tetsuo Handa wrote:
>> Since schedule_on_each_cpu() calls schedule_work_on() and flush_work(),
>> we should avoid using system_wq in order to avoid unexpected locking
>> dependency.
> 
> I don't get it. schedule_on_each_cpu() is flushing each work item and thus
> shouldn't need its own flushing domain. What's this change for?

A kernel test robot tested "[PATCH v2] workqueue: Warn flush attempt using
system-wide workqueues" on 5.16.0-06523-g29bd199e4e73 and hit a lockdep
warning ( https://lkml.kernel.org/r/20220221083358.GC835@xsang-OptiPlex-9020 ).

Although the circular locking dependency itself needs to be handled by
lockless console printing support, we won't be able to apply
"[PATCH v2] workqueue: Warn flush attempt using system-wide workqueues"
if schedule_on_each_cpu() continues using system-wide workqueues.

