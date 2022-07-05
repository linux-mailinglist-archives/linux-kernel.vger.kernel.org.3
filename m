Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F45567074
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbiGEOKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiGEOJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:09:57 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F5A17E08
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 07:01:44 -0700 (PDT)
Received: from fsav413.sakura.ne.jp (fsav413.sakura.ne.jp [133.242.250.112])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 265E1g2f088566;
        Tue, 5 Jul 2022 23:01:42 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav413.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp);
 Tue, 05 Jul 2022 23:01:42 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 265E1gfg088563
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 5 Jul 2022 23:01:42 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <5665ccb2-b92b-9e1f-8bb5-a950986450ec@I-love.SAKURA.ne.jp>
Date:   Tue, 5 Jul 2022 23:01:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] char: misc: make misc_open() and misc_register() killable
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
References: <000000000000d9ff3a05bb37069e@google.com>
 <72e74af9-f1b6-e383-a2c3-6ee8a0aea5e0@I-love.SAKURA.ne.jp>
 <YsKW6VvWqvcMRBSl@kroah.com>
 <100f445e-9fa8-4f37-76aa-8359f0008c59@I-love.SAKURA.ne.jp>
 <YsLIepAXeBKT0AF/@kroah.com>
 <01a93294-e323-b9ca-7e95-a33d4b89dc47@I-love.SAKURA.ne.jp>
 <YsL5pUuydMWJ9dSQ@kroah.com>
 <617f64e3-74c8-f98b-3430-bd476867e483@I-love.SAKURA.ne.jp>
In-Reply-To: <617f64e3-74c8-f98b-3430-bd476867e483@I-love.SAKURA.ne.jp>
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

On 2022/07/05 14:21, Tetsuo Handa wrote:
> Possible locations where snapshot_open() might sleep with system_transition_mutex held are
> pm_notifier_call_chain_robust()/wait_for_device_probe()/create_basic_memory_bitmaps().
> But I think we can exclude pm_notifier_call_chain_robust() because lockdep does not report
> that that process is holding "struct blocking_notifier_head"->rwsem. I suspect that
> that process is sleeping at wait_for_device_probe(), for it waits for probe operations.
> 
> ----------------------------------------
> void wait_for_device_probe(void)
> {
> 	/* wait for the deferred probe workqueue to finish */
> 	flush_work(&deferred_probe_work);
> 
> 	/* wait for the known devices to complete their probing */
> 	wait_event(probe_waitqueue, atomic_read(&probe_count) == 0);
> 	async_synchronize_full();
> }
> ----------------------------------------

syzbot confirmed that snapshot_open() is unable to proceed due to
atomic_read(&probe_count) == 2 for 145 seconds.

----------------------------------------
[   86.794300][ T4209] Held system_transition_mutex.
[   86.821486][ T4209] Calling wait_for_device_probe()
[   86.841374][ T4209] Calling flush_work(&deferred_probe_work)
[   86.867398][ T4209] Calling wait_event(probe_waitqueue)
[   87.966188][ T4209] Calling probe_count=2
(...snipped...)
[  233.554473][ T4209] Calling probe_count=2
[  234.444800][   T28] INFO: task syz-executor.4:4146 blocked for more than 143 seconds.
----------------------------------------

Apart from whether we should fuzz snapshot code or not,
there seems to be a bug that causes wait_for_device_probe() to hung.

On 2022/07/05 22:44, syzbot wrote:
> Tested on:
> 
> commit:         c1084b6c Merge tag 'soc-fixes-5.19-2' of git://git.ker..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=156cc410080000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=66f70cacb0085db4
> dashboard link: https://syzkaller.appspot.com/bug?extid=358c9ab4c93da7b7238c
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=11ae4834080000
