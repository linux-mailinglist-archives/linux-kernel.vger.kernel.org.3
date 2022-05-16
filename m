Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29ADB527B98
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 03:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239204AbiEPB5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 21:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236803AbiEPB5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 21:57:12 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9376AEE28
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 18:57:10 -0700 (PDT)
Received: from fsav115.sakura.ne.jp (fsav115.sakura.ne.jp [27.133.134.242])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 24G1v2n4002859;
        Mon, 16 May 2022 10:57:02 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav115.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp);
 Mon, 16 May 2022 10:57:02 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 24G1v2ML002856
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 16 May 2022 10:57:02 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <bf5c8a1e-e922-fb78-32b8-a6288e434a3a@I-love.SAKURA.ne.jp>
Date:   Mon, 16 May 2022 10:56:58 +0900
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
 <33772dcb-c5dd-c5e7-30c8-d2397d21b26c@I-love.SAKURA.ne.jp>
 <Yn0H/68tagxaj/ke@google.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <Yn0H/68tagxaj/ke@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/05/12 22:13, Dmitry Torokhov wrote:
> Also as far as I can see the patch was rejected.

Not rejected. I sent
https://lkml.kernel.org/r/7b2fecdb-59ae-2c54-5a5b-774ef7054d1b@I-love.SAKURA.ne.jp
for 5.19.

>> We currently don't have a flag to tell whether the caller is inside module unload
>> path. And even inside module unload path, flushing the system-wide workqueue is
>> problematic under e.g. GFP_NOFS/GFP_NOIO context.
> 
> Sorry, I do not follow here. Are there module unloading code that runs
> as GFP_NOFS/GFP_NOIO?

It is GFP_KERNEL context when module's __exit function is called. But whether
flush_workqueue() is called from restricted context depends on what locks does
the module's __exit function hold.

If request_module() is called from some work function using one of system-wide WQs,
and flush_workqueue() is called on that WQ from module's __exit function, the kernel
might deadlock on module_mutex lock. Making sure that flush_workqueue() is not called
on system-wide WQs is the safer choice.

