Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4833B59105B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 13:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235923AbiHLLvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 07:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238328AbiHLLuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 07:50:39 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E992BC1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 04:50:36 -0700 (PDT)
Received: from fsav315.sakura.ne.jp (fsav315.sakura.ne.jp [153.120.85.146])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 27CBoYAR007767;
        Fri, 12 Aug 2022 20:50:34 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav315.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp);
 Fri, 12 Aug 2022 20:50:34 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 27CBoYAP007762
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 12 Aug 2022 20:50:34 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <62860a46-f6c0-9735-c76f-162a294720a2@I-love.SAKURA.ne.jp>
Date:   Fri, 12 Aug 2022 20:50:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] locking/lockdep: add debug_show_all_lock_holders()
Content-Language: en-US
To:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ben Dooks <ben.dooks@sifive.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        John Ogness <john.ogness@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <82af40cc-bf85-2b53-b8f9-dfc12e66a781@I-love.SAKURA.ne.jp>
 <60867fd6-f6c1-cdd3-d355-073d26588d0e@redhat.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <60867fd6-f6c1-cdd3-d355-073d26588d0e@redhat.com>
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

On 2022/08/11 20:32, Tetsuo Handa wrote:
> I wish that lockdep continues tracking locks even after something went
> wrong (i.e. debug_locks remains 1), for recently I sometimes encounter
> problems that disable lockdep during boot stage.
>
> It would be noisy to report possibility of e.g. circular locking dependency
> every time due to keeping debug_locks enabled. But tracking locks even
> after something went wrong will help debug_show_all_lock_holders() to
> survive problems during boot stage.

I forgot to write. I'm not expecting lockdep to report the same problem forever.
Reporting possibility of each problem pattern (e.g. circular locking dependency)
up to once, by using cmpxchg() inside reporting functions that call printk(),
would be enough.

I'm expecting lockdep to continue working without calling printk() even after
one of problem patterns (e.g. circular locking dependency) was printk()ed, so that
debug_show_all_locks()/debug_show_all_lock_holders() can call printk() when needed.

>
> Changing debug_locks behavior is a future patch. For now, this patch alone
> will help debugging Greg's usb.git#usb-testing tree which is generating
> many "INFO: task hung in" reports.
>



On 2022/08/12 4:00, Waiman Long wrote:
> 
> BTW, this function will produce much more verbose output. Typically how many line
> of debug outputs are going to be dumped to the console by calling this function?

Regarding amount of output, I can't estimate lines printed because it depends on how
many threads are holding locks. Thus, here are some examples obtained by this patch.

  https://syzkaller.appspot.com/text?tag=CrashReport&x=17c78aba080000
  https://syzkaller.appspot.com/text?tag=CrashReport&x=13219e6b080000
  https://syzkaller.appspot.com/text?tag=CrashReport&x=166c402d080000
  https://syzkaller.appspot.com/text?tag=CrashReport&x=15c6ff73080000

We can introduce flags like panic_printk variable in kernel/panic.c if amount of
output (or latency by output) turns out to be a problem.

I guess that the most significant switch would be console_verbose() in
check_hung_task() which forces synchronous output (causing latency problem
if there are many lines to output). If printk() messages are not printed to
consoles, latency by debug_show_all_lock_holders() will be negligible.

