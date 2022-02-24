Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347434C2E7D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 15:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235490AbiBXOeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 09:34:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234775AbiBXOeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 09:34:15 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19A31637F7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 06:33:45 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7D58A2170C;
        Thu, 24 Feb 2022 14:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645713224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZYPeVKALkpzTcxeDHSPKHl3ouv2OXHzIcU99Wn4FqEE=;
        b=Cw6YjhKu8m89zCWkFi0lEEBT2Wze3QHi96fuJf0DPr33md7zsQOxRExOlIcooI9VVbjRdY
        CLxSYw9GnN3J+vVIvXzMFL7SxzaNfZWgcKk1YU74A80zG4O0+jbfM/7Zf4YvdldoYRk5f9
        e19tvFQl3S04GoiLUdY7K39qzAiTwDA=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 21EB4A3B83;
        Thu, 24 Feb 2022 14:33:44 +0000 (UTC)
Date:   Thu, 24 Feb 2022 15:33:42 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-kernel@vger.kernel.org, bhe@redhat.com,
        akpm@linux-foundation.org, anton@enomsg.org, ccross@android.com,
        dyoung@redhat.com, feng.tang@intel.com, john.ogness@linutronix.de,
        keescook@chromium.org, kernel@gpiccoli.net,
        kexec@lists.infradead.org, rostedt@goodmis.org,
        tony.luck@intel.com, vgoyal@redhat.com
Subject: Re: [PATCH V6] panic: Move panic_print before kmsg dumpers
Message-ID: <YheXRmmWr619Qxin@alley>
References: <20220214141308.841525-1-gpiccoli@igalia.com>
 <YhRFNKtxSE8Xrbfw@google.com>
 <7e15bc6a-ceae-aa3a-0a86-18d24181b0ed@igalia.com>
 <YhWNhzacAVDuFtwB@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhWNhzacAVDuFtwB@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-02-23 01:27:35, Sergey Senozhatsky wrote:
> On (22/02/22 11:10), Guilherme G. Piccoli wrote:
> > On 21/02/2022 23:06, Sergey Senozhatsky wrote:
> > > On (22/02/14 11:13), Guilherme G. Piccoli wrote:
> > > [...]
> > > By additional panic_print messages you mean that panic_print_sys_info()
> > > will print everything (except PANIC_PRINT_ALL_PRINTK_MSG) twice?
> > > 
> > > Do we really need to dump everything twice? show_mem(), show_state(),
> > > ftrace_dump(DUMP_ALL). That's quite a bit of extra data.
> > > 
> > 
> > Oh no, we don't print everything twice, that'd be insane heh
> 
> My bad! I did not spot the `return` at the end of the new branch.
> 
> +       if (console_flush) {
> +               if (panic_print & PANIC_PRINT_ALL_PRINTK_MSG)
> +                       console_flush_on_panic(CONSOLE_REPLAY_ALL);
> +               return;
> +       }
> 
> Hmm. Yeah, well, that's a bit of a tricky interface now
> 
> 	panic()
> 		// everything (if corresponding bits set), no console flush
> 		panic_print_sys_info(false)
> 		...
> 		// console flush only if corresponding bit set
> 		panic_print_sys_info(true)

I agree that self-explaining names are always better than true/false.
It is pity that replay the log is handled in panic_print at all.

I sometimes hide these tricks into wrappers. We could rename:

    panic_printk_sys_info() -> panic_print_handler()

and add wrappers:

void panic_print_sys_info()
{
	panic_printk_handler(false);
}

void panic_print_log_replay()
{
	panic_printk_handler(true);
}

Or just split panic_printk_sys_info() into these two functions.

> If everyone is fine then OK.
> 
> But I _personally_ would look into changing this to something like this:
> 
> 	#define EARLY_PANIC_MASK (PANIC_PRINT_FOO | PANIC_PRINT_BAR | ...)
> 	#define LATE_PANIC_MASK (PANIC_PRINT_ALL_PRINTK_MSG)

These lists cause merge and backporting conflicts. I vote to avoid
this approach ;-)


> 	panic()
> 		panic_print_sys_info(panic_print & EARLY_PANIC_MASK)
> 		...
> 		panic_print_sys_info(panic_print & LATE_PANIC_MASK)

That said, I could live with the patch as is. I leave the decision
to Andrew. Feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
