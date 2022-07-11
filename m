Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418FC56D77B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiGKINl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiGKINg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:13:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02478CEC;
        Mon, 11 Jul 2022 01:13:33 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D1B231FF65;
        Mon, 11 Jul 2022 08:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657527211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VQUw23aTCjy0cvtNneUfRztB67PX87lDLscgOZWi84I=;
        b=Ws2DrVlXEH8eFgIxeTfRNC2I1misR7uVQxC2lI0qa2f3ZtPEJKAqWb6KpPuRYc722UVy/X
        dXvP0Erla4brqVEENxq5wPhFrTS31chA6Ed722BCR90yPhmKaFoyhvd32eRzQaKxMslMB1
        G3o/x1962Dmz9jKKfTlDKMrI2pNyfMg=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7D3F82C141;
        Mon, 11 Jul 2022 08:13:31 +0000 (UTC)
Date:   Mon, 11 Jul 2022 10:13:27 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        todd.e.brandt@linux.intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: PNP0501 serial driver takes almost 2 seconds to suspend/resume
 (printk issue)
Message-ID: <Ysvbp8vz7R9hDNqx@alley>
References: <12fb98fe27e23e3f74a139e5e8eb83a97a343372.camel@linux.intel.com>
 <51b9e2cc3baf61a604bd239b736ec2d12f1f6695.camel@linux.intel.com>
 <87czegxccb.fsf@jogness.linutronix.de>
 <045ebee30af2b80aaeace1dab18ecd113e3f17c7.camel@linux.intel.com>
 <87tu7qvx1q.fsf@jogness.linutronix.de>
 <CAHp75VfyzMNMO2NRwXwSjAmQqBbdRG3+SzyFDG+90dmvmg1xLQ@mail.gmail.com>
 <87o7xwbuoy.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7xwbuoy.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2022-07-10 22:10:45, John Ogness wrote:
> On 2022-07-10, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> >> Looking at freeze-5.19.0-rc1-bad.html, at 3431.221039 we see that
> >> suspend_console() was called. The additional 1-second delay you are
> >> referring to would be 3432.436187, where serial is
> >> suspended. pr_flush() would have been satisfied when the message at
> >> 3431.221039 was printed. So the question is, why is there still
> >> printing going on?
> >
> > It might be no_console_suspend hack. Are you, btw, aware of this ugly
> > hack in the kernel?
> 
> I am aware of it. There are some cases where it actually works. But it
> is not being used here. The boot args are:
> 
> BOOT_IMAGE=/boot/vmlinuz-5.19.0-rc1+ root=UUID=1dfec046-baf6-4f38-8b5e-a8f438a48038 ro rw quiet console=ttyS0,115200 console=tty0 i915.enable_psr=1 initcall_debug log_buf_len=32M quiet splash console=tty0 console=ttyS0,115200n8 vt.handoff=7
> 
> I am curious if Todd sees this problem with 5.19-rc4 or later (the
> kthread printers were removed).

We removed the kthreads but not pr_flush(). The commit
3b604ca81202eea2a91 ("printk: add pr_flush()") is still there.

It seems that __pr_flush() does not check whether all consoles
are suspended. In this case the progress is not possible and
it has to wait the entire timeout.

Best Regards,
Petr
