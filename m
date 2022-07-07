Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE16B56A59F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 16:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235869AbiGGOie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 10:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235843AbiGGOi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 10:38:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACC31173
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 07:38:26 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BF64A220FB;
        Thu,  7 Jul 2022 14:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657204704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zCTPElBIBbHfEhCwVPcbaEofLoOOWYIeF1bGmH1hTzM=;
        b=qn/kaBbIWnZ9hB009UcjIiexdJPLs1hcyDXtIAb6aPhepfxNmWNOHxf5ugPtR9eXYCBUPX
        HcUUaVjPuE+QdpE8v2CNAP86Fgc5qjZteuo85nRRC4EQImhUNFy4w2wfyc23rSgR/cgmZ/
        9W/8QR6LT2BfGiXlUhQN937qsp1ghqY=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 565C62C141;
        Thu,  7 Jul 2022 14:38:23 +0000 (UTC)
Date:   Thu, 7 Jul 2022 16:38:20 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Rik van Riel <riel@surriel.com>
Cc:     Chris Down <chris@chrisdown.name>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@fb.com
Subject: Re: [RFC PATCH v2] printk: console: Allow each console to have its
 own loglevel
Message-ID: <Ysbv3HUYJTzRpjeq@alley>
References: <YoeQLxhDeIk4VSmx@chrisdown.name>
 <7c57004c1f9a2580b34ea6708065260ec2706122.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c57004c1f9a2580b34ea6708065260ec2706122.camel@surriel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-05-20 12:06:33, Rik van Riel wrote:
> On Fri, 2022-05-20 at 13:57 +0100, Chris Down wrote:
> > [Once the goals of this patch are generally agreed upon, it can be
> > split
> > out further with more detailed changelogs if desired.]
> > 
> > Consoles can have vastly different latencies and throughputs. For
> > example, writing a message to the serial console can take on the
> > order
> > of tens of milliseconds to get the UART to successfully write a
> > message.
> > While this might be fine for a single, one-off message, this can
> > cause
> > significant application-level stalls in situations where the kernel
> > writes large amounts of information to the console.
> > 
> It's more than just application-level stalls. I have seen
> some cases of the kernel spending so much time logging things
> to serial console that it thinks it locked up, and panics as
> a result of how slow the serial console is.
> 
> Adding insult to injury, because the log level is sytem wide,
> we only see _some_ of the hints of why the kernel started
> spewing like that in the netcons logs.
> 
> If we print all the information, we will have more hosts panic
> because we spent too much time in the serial console code.
> 
> If we print less information, we won't find out some of the
> other things causing issues on systems.
> 
> Having per console log levels will allow us to avoid the
> serial console issues, and gather all the info we need on
> other stuff happening on the system.

The problem is clear. But the big part of the problem is that printk()
tries to show the messages on all consoles immediately.

I wonder how much the per-console loglevel would be needed
when the console handling is offloaded to per-console kthreads, see
https://lore.kernel.org/all/20220421212250.565456-1-john.ogness@linutronix.de/
It causes that printk() should "never" block and each console might
run on its own speed.

It still might be useful from some reasons:

    + Serial consoles might miss messages because the old messages are
      over-written before they reach the console. It might be solved
      by big enough buffer.

    + printk() still tries to show the messages immediately in some
      critical situations, for example, early boot, watchdog warnings,
      suspend, reboot, OOps, panic(). The slow consoles might still
      cause stalls and put the system into its knees.

    + People might need to explicitly disable the kthreads, for
      example, when debugging a situation when kthreads are not
      scheduled.


So, I think that the per-console loglevels might still be useful.
But I wonder if they really will be used in practice. It does
not make sense to add feature that would get obsoleted by
the kthreads.

Note that the per-console kthreads were added into 5.19-rc1.
Unfortunately they were reverted in 5.19-rc4 because there were
some issues that need more work. But we still believe that
they are needed and we could make them working reliably.

Best Regards,
Petr

PS: I am sorry for the late response. I am still snowed under
many tasks. The printk kthreads are complicated and need
a lot of attention. Plus there was a sickness, vacations,
and other tasks.
