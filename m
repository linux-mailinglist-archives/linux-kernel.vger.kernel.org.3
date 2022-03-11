Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02D74D65E3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 17:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242130AbiCKQS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 11:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242453AbiCKQSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 11:18:55 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DD152B3B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 08:17:50 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 41C4221106;
        Fri, 11 Mar 2022 16:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647015469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jWFsVvk40kTyOQpxwDT1Cwu6zAN3OKKxIrIexeKkwe4=;
        b=P1zJwaZDXCzBY/PKxzfUT6Hn5rVHQu7TnEIYInBDJ7AAcUVX9D0wBpkj+LWJAfpckpv4rC
        zdpgec81lYggvZtNIUDaqXxr+01QpMw3lp5Xt3NjIPkuGute8TNopkO4bsS6blfwByltOu
        QA2MYQAi6na8LBf344UIPoJ8h4aEaGU=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E9794A3B83;
        Fri, 11 Mar 2022 16:17:48 +0000 (UTC)
Date:   Fri, 11 Mar 2022 17:17:48 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 11/13] printk: reimplement console_lock for
 proper kthread support
Message-ID: <Yit2LN1nCaiUo5y4@alley>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-12-john.ogness@linutronix.de>
 <YhYKP/UuSKENGwfj@alley>
 <87tuc7xma0.fsf@jogness.linutronix.de>
 <YioMcSe0P0Z7ksiW@alley>
 <87wnh14wp9.fsf@jogness.linutronix.de>
 <Yisj2PEtjZfHMe6N@alley>
 <87czisbotz.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87czisbotz.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-03-11 14:34:40, John Ogness wrote:
> On 2022-03-11, Petr Mladek <pmladek@suse.com> wrote:
> > But it does not help when the lock was taken
> > via console_trylock() from printk(). It might mean that
> > the forward progress might not be guaranteed in the direct mode
> > (early boot, panic, ...).
> 
> How is the console_trylock() case different from current mainline now?
> As I mentioned above, the kthreads can block console_trylock(), but so
> can a console_lock() currently in mainline.

CPU0			CPU1			CPU2

printk()
  // direct mode allowed
  console_trylock()
  console_unlock()
    console_flush_all()

			printk_direct_enter()

      allows_direct_printing() -> false;
      break;

      __console_unlock()
        wakeup_klogd()

						// woken printk_khread
						console_thread_printing_enter()

			printk_direct_exit()

      console_trylock()
        atomic_tryblock()
	  //fails because thread active

   return;

			printk_direct_enter()

						console_thread_printing_exit()

						// sleep because
						atomic_read(&printk_direct) is not
						zero

Result: nobody prints

Note: The thread will actually not sleep because printk_should_wake()
      does not check atomic_read(&printk_direct).

      But it is a bug. Active thread should check it and allow
      entering direct mode.


Note2: Even when one printk thread flushes the messages. There might
       be other thread that will never get scheduled a nobody would
       printk the messages on the related console.


This is the race that I see with console_trylock(). IMHO, if we solve
this race then we do not need console_trylock_sched().

Well, I might be wrong. It is Friday evening. I still do not have
the entire picture. I probably should have waited for Monday.

I am sure that I misunderstood several things, including wait_event()
API or CON_DIRECT flag. But the above race looks real. And it somehow
supports my feeling about that there are some races that can't be
solved by console_trylock_sched().

Best Regards,
Petr
