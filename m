Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4AA5513779
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 16:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344349AbiD1O6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 10:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235854AbiD1O6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 10:58:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCEE9E9FE
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 07:54:54 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 26AC51F88B;
        Thu, 28 Apr 2022 14:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651157693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Oui+HQWDmS1z2iw8Iqn3J1xquHUwKC8gitMw4oJxH4g=;
        b=bQNeM7h8q0WUlej4Jf2wj7R6YC8nlIOwlFGDsSxXyocm5+zlJszZyO+ov3XhD/O7Yj3Lbl
        MGCTQDDB6t8EBefFQsNbhgLuMcyExZz1xntLXDzzzpUx7fGHAI4tSgGTXofPB28Dvzd1IY
        Sd9SIM8HH2zP/p88mKC7H+EmeE6CXd0=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9D6CD2C141;
        Thu, 28 Apr 2022 14:54:52 +0000 (UTC)
Date:   Thu, 28 Apr 2022 16:54:49 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH printk v5 1/1] printk: extend console_lock for
 per-console locking
Message-ID: <YmqquUrDN2VWnR92@alley>
References: <20220421212250.565456-1-john.ogness@linutronix.de>
 <20220421212250.565456-15-john.ogness@linutronix.de>
 <878rrs6ft7.fsf@jogness.linutronix.de>
 <Ymfgis0EAw0Oxoa5@alley>
 <Ymfwk+X0CHq6ex3s@alley>
 <CGME20220427070833eucas1p27a32ce7c41c0da26f05bd52155f0031c@eucas1p2.samsung.com>
 <2a82eae7-a256-f70c-fd82-4e510750906e@samsung.com>
 <Ymjy3rHRenba7r7R@alley>
 <b6c1a8ac-c691-a84d-d3a1-f99984d32f06@samsung.com>
 <87fslyv6y3.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fslyv6y3.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-04-27 18:21:16, John Ogness wrote:
> Hi Marek,
> 
> On 2022-04-27, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> > Here is the full serial console log:
> >
> > https://pastebin.com/E5CDH88L
> 
> Here are a few ideas from me:
> 
> 3. It looks like the problem happens quite late in the boot process. I
> expect it is due to some userspace process that is running that is
> interacting with printk (either /dev/kmsg or /proc/kmsg) and is causing
> problems.

I did not find an real issue in the code handling /dev/kmsg,
/proc/kmsg, or syslog sycall API. There might be just few
small changes:

    1. There is an increased number of spurious wakeups because
       log_wait is shared between upstream readers and printk kthreads.
       And we newly wake up waiters from both vprintk_emit()
       and __console_unlock() code paths.

       It might affect especially the pooling APIs: kmsg_pool(),
       devkmsg_pool()). They might return 0 more often than before.


    2. 4th patch replaced wake_up_interruptible(&log_wait) with
       wake_up_interruptible_all(&log_wait). As a result, all
       readers are woken at the same time.

       It is perfectly fine because the log buffer is lockless.
       And all readers should be either independent or synchronized
       against each other.


Any of the above changes should not introduce new problems. But
they might make some old problem (race) more visible.

I spent quite some time reviewing the code and testing. But I neither
see any problem nor I am able to reproduce it. Some more clues
from Marek would be needed.

Best Regards,
Petr
