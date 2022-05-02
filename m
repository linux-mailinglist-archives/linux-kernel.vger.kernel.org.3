Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCEFA51701D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 15:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385216AbiEBNVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 09:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385204AbiEBNVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 09:21:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69B5FD3F
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 06:17:37 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 70DAA1F388;
        Mon,  2 May 2022 13:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651497456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iKHp6HnhHDWvm6k4RMfwy16wpKWbSYU7Y8KyP4lIRmM=;
        b=iHlzlpqaBiIzj1Rd8rzo/nB+kiMLE4SCjLnY+bqL8EuJ1hdoSKJn2e1xiivU2AONmJZ36L
        wIUdJd96SiFCfQpDmMuKcThBG05A3ehCFRtMgwmnm3IwBkRK41sOhlfBSz17EyuS+zXOCx
        7ZLI/xQ2HmWTYkvqtaXG0MXJ9kSMvrE=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1CDC82C141;
        Mon,  2 May 2022 13:17:35 +0000 (UTC)
Date:   Mon, 2 May 2022 15:17:32 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH printk v5 1/1] printk: extend console_lock for
 per-console locking
Message-ID: <Ym/Z7PYPqvWPEjuL@alley>
References: <Ymfgis0EAw0Oxoa5@alley>
 <Ymfwk+X0CHq6ex3s@alley>
 <CGME20220427070833eucas1p27a32ce7c41c0da26f05bd52155f0031c@eucas1p2.samsung.com>
 <2a82eae7-a256-f70c-fd82-4e510750906e@samsung.com>
 <Ymjy3rHRenba7r7R@alley>
 <b6c1a8ac-c691-a84d-d3a1-f99984d32f06@samsung.com>
 <87fslyv6y3.fsf@jogness.linutronix.de>
 <51dfc4a0-f6cf-092f-109f-a04eeb240655@samsung.com>
 <87k0b6blz2.fsf@jogness.linutronix.de>
 <32bba8f8-dec7-78aa-f2e5-f62928412eda@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32bba8f8-dec7-78aa-f2e5-f62928412eda@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-05-02 11:19:07, Marek Szyprowski wrote:
> Hi John,
> 
> On 30.04.2022 18:00, John Ogness wrote:
> > On 2022-04-29, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> >> The same issue happens if I boot with init=/bin/bash
> > Very interesting. Since you are seeing all the output up until you try
> > doing something, I guess receiving UART data is triggering the issue.
> 
> Right, this is how it looks like.
> 
> >> I found something really interesting. When lockup happens, I'm still
> >> able to log via ssh and trigger any magic sysrq action via
> >> /proc/sysrq-trigger.
> > If you boot the system and directly login via ssh (without sending any
> > data via serial), can you trigger printk output on the UART? For
> > example, with:
> >
> >      echo hello > /dev/kmsg
> >
> > (You might need to increase your loglevel to see it.)
> 
> Data written to /dev/kmsg and all kernel logs were always displayed 
> correctly. Also data written directly to /dev/ttyAML0 is displayed 
> properly on the console. The latter doesn't however trigger the input 
> related activity.
> 
> It looks that the data read from the uart is delivered only if other 
> activity happens on the kernel console. If I type 'reboot' and press 
> enter, nothing happens immediately. If I type 'date >/dev/ttyAML0' via 
> ssh then, I only see the date printed on the console. However if I type 
> 'date >/dev/kmsg', the the date is printed and reboot happens.

This is really interesting.

'date >/dev/kmsg' should be handled like a normal printk().
It should get pushed to the console using printk kthread,
that calls call_console_driver() that calls con->write()
callback. In our case, it should be meson_serial_console_write().

I am not sure if meson_serial_console_write() is used also
when writing via /dev/ttyAML0.

> 
> >> It turned out that the UART console is somehow blocked, but it
> >> receives and buffers all the input. For example after issuing "echo
> >>   >/proc/sysrq-trigger" from the ssh console, the UART console has been
> >> updated and I see the magic sysrq banner and then all the commands I
> >> blindly typed in the UART console! However this doesn't unblock the
> >> console.
> > sysrq falls back to direct printing. This would imply that the kthread
> > printer is somehow unable to print.
> >
> >> Here is the output of 't' magic sys request:
> >>
> >> https://protect2.fireeye.com/v1/url?k=8649f24d-e73258c4-86487902-74fe48600034-a2ca6bb18361467d&q=1&e=1bc4226f-a422-42b9-95e8-128845b8609f&u=https%3A%2F%2Fpastebin.com%2FfjbRuy4f
> > It looks like the call trace for the printing kthread (pr/ttyAML0) is
> > corrupt.
> 
> Right, good catch. For comparison, here is a 't' sysrq result from the 
> 'working' serial console (next-20220429), which happens usually 1 of 4 
> boots:
> 
> https://pastebin.com/mp8zGFbW

Strange. The backtrace is weird here too:

[   50.514509] task:pr/ttyAML0      state:R  running task     stack:    0 pid:   65 ppid:     2 flags:0x00000008
[   50.514540] Call trace:
[   50.514548]  __switch_to+0xe8/0x160
[   50.514561]  meson_serial_console+0x78/0x118

There should be kthread() and printk_kthread_func() on the stack.

Hmm,  meson_serial_console+0x78/0x118 is weird on its own.
meson_serial_console is the name of the structure. I would
expect a name of the .write callback, like
meson_serial_console_write()

Best Regards,
Petr
