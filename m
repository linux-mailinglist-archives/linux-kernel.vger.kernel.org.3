Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A004B095A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 10:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238431AbiBJJWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 04:22:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235335AbiBJJWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 04:22:05 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67980F1C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 01:22:07 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 20A2E21115;
        Thu, 10 Feb 2022 09:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644484926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dASyFwKr2xiaR0nvQCK6HgwyeDwxFBBe//zBNc7fFyw=;
        b=NncAtze7jYeP3VtbjAI8A8uDHQ+oyiUzTzl3LWhSaBojK6w3C1WLr5d1DUBtlv2LLlvpxH
        2V5zdkGS3OPQYhe97+zsBinOopaO/1HbMvcyOs4dZjB2pKJ/ObS1ssRlExJ9OhmGeeOq00
        d1jXjnADDRBGjQOFUdOP3cGMJuddsZY=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B1B21A3B84;
        Thu, 10 Feb 2022 09:22:05 +0000 (UTC)
Date:   Thu, 10 Feb 2022 10:22:05 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH v4 0/4] printk: reduce deadlocks during panic
Message-ID: <YgTZPQEay6T/nhu6@alley>
References: <20220202171821.179394-1-stephen.s.brennan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202171821.179394-1-stephen.s.brennan@oracle.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-02-02 09:18:17, Stephen Brennan wrote:
> When a caller writes heavily to the kernel log (e.g. writing to
> /dev/kmsg in a loop) while another panics, there's currently a high
> likelihood of a deadlock (see patch 2 for the full description of this
> deadlock).
> 
> The principle fix is to disable the optimistic spin once panic_cpu is
> set, so the panic CPU doesn't spin waiting for a halted CPU to hand over
> the console_sem.
> 
> However, this exposed us to a livelock situation, where the panic CPU
> holds the console_sem, and another CPU could fill up the log buffer
> faster than the consoles could drain it, preventing the panic from
> progressing and halting the other CPUs. To avoid this, patch 3 adds a
> mechanism to suppress printk (from non-panic-CPU) during panic, if we
> reach a threshold of dropped messages.
> 
> A major goal with all of these patches is to try to decrease the
> likelihood that another CPU is holding the console_sem when we halt it
> in panic(). This reduces the odds of needing to break locks and
> potentially encountering further deadlocks with the console drivers.
> 
> To test, I use the following script, kmsg_panic.sh:
> 
>     #!/bin/bash
>     date
>     # 991 chars (based on log buffer size):
>     chars="$(printf 'a%.0s' {1..991})"
>     while :; do
>         echo $chars > /dev/kmsg
>     done &
>     echo c > /proc/sysrq-trigger &
>     date
>     exit
> 
> I defined a hang as any time the system did not reboot to a login prompt
> on the serial console within 60 seconds. Here are the statistics on
> hangs using this script, before and after the patch.
> 
> before:  776 hangs / 1484 trials - 52.3%
> after :    0 hangs /  15k trials -  0.0%
> 
> Stephen Brennan (4):
>   printk: Add panic_in_progress helper
>   printk: disable optimistic spin during panic
>   printk: Avoid livelock with heavy printk during panic
>   printk: Drop console_sem during panic
> 
>  kernel/printk/printk.c | 55 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 54 insertions(+), 1 deletion(-)

For the entire patchset:

Reviewed-by: Petr Mladek <pmladek@suse.com>

It looks ready for linux-next from my POV. I am going to push it early
next week unless anyone complains in the meantime.

Best Regards,
Petr Mladek
