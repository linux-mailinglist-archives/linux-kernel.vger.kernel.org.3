Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CDC4C25EE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 09:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbiBXI1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 03:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbiBXI1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 03:27:39 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBE8114761
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 00:27:09 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7BD3D1F3A1;
        Thu, 24 Feb 2022 08:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645691228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gSTuU8j1qrBHesfm8aUsNphEOTThQkaUDOZ+qeWaRwE=;
        b=m3O/EhMObybgNG7yX7tVQU7By1jzUyt1VbZbeC2hmEzYUGOPTgJhBomaf9376RyINrZZvV
        21IabhVIg/UbUP3HPvQomFHTpckMOCn+Au+pNNHYWTHD8yJFD2muUbZPk2PFHg7c/zMd//
        jlSN8Qk3NWnaihpxM49ZAj1KjFxlGm4=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 31D9AA3B83;
        Thu, 24 Feb 2022 08:27:04 +0000 (UTC)
Date:   Thu, 24 Feb 2022 09:27:04 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 11/13] printk: reimplement console_lock for
 proper kthread support
Message-ID: <YhdBWBxL15j4Bq3h@alley>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-12-john.ogness@linutronix.de>
 <Yg/HWcifuqLsS6cv@alley>
 <87o8333l97.fsf@jogness.linutronix.de>
 <YhTMDOHyXADh665V@alley>
 <87h78pqz2h.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h78pqz2h.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-02-23 18:26:54, John Ogness wrote:
> On 2022-02-22, Petr Mladek <pmladek@suse.com> wrote:
> >> With a mutex there is an owner. When another task tries to lock a
> >> mutex, the scheduler knows which task must be scheduled to resolve
> >> this true lock contention. (There are also other benefits relating to
> >> priority inheritance, but I chose not to mention this.)
> >
> > This sounds interesting. Does scheduler wake up or prioritize
> > mutex owners?
> 
> Sorry, the only example of this is priority inheritance. But for
> non-PREEMPT_RT there is no priority inheritance. The lock would need to
> be an rtmutex for this ability, which probably doesn't make sense for
> printk.

Good to know.

> The v2 commit message will focus on:
> 
> - the motivation for per-console locks is parallel printing
> 
> - explain about how disabling preemption is only necessary for direct
>   printing via printk() because the caller may be holding
>   system-critical and/or timing-sensitive locks (and also to allow the
>   console owner/waiter logic to work correctly)
> 
> - correctly clarifying why the various types
>   (semaphore/mutex/flag/atomic) were chosen to implement the printing
>   sychronization between atomic-direct, non-atomic-direct, and kthreads
>   (and I will explicitly remind the audience that mutex_trylock() cannot
>   be used in atomic context)

Sounds great.

Thanks a lot for the hard work. It is very appreciated.

Best Regards,
Petr
