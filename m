Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646414B7332
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239472AbiBOPAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 10:00:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239385AbiBOO7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:59:50 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CA0DFA8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:59:39 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0F8311F382;
        Tue, 15 Feb 2022 14:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644937178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MrGnJrAMCFPmLc65vlRdt3pXviCilvLZaB4FGAskoQA=;
        b=s7bRVkZCZkaMjew3RsH07f3hJ1tqZRLCECOuJC73PrVN8Z734MBzJLtQaj6Vh6zlA0gXaZ
        oRLL1XJhmgsQH7ntw/71HkQSiQOgu6qmnEgfkvxGeJ5jgfiQjHKaJ/4aqJ+Mg+YsWVlS7Y
        ZWpMnw5WDjWXV+yoThar8f7KMQtJ2Mc=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B35BDA3BA1;
        Tue, 15 Feb 2022 14:59:37 +0000 (UTC)
Date:   Tue, 15 Feb 2022 15:59:35 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v1 05/13] printk: call boot_delay_msec() in
 printk_delay()
Message-ID: <Ygu/1/Y+vTNhulUX@alley>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-6-john.ogness@linutronix.de>
 <YgtBGx8FD/AA23Qk@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgtBGx8FD/AA23Qk@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-02-15 14:58:51, Sergey Senozhatsky wrote:
> On (22/02/07 20:49), John Ogness wrote:
> > boot_delay_msec() is always called immediately before printk_delay()
> > so just call it from within printk_delay().
> > 
> > Signed-off-by: John Ogness <john.ogness@linutronix.de>
> 
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> 
> > -static inline void printk_delay(void)
> > +static inline void printk_delay(int level)
> >  {
> > +	boot_delay_msec(level);
> > +
> >  	if (unlikely(printk_delay_msec)) {
> >  		int m = printk_delay_msec;
> >  
> > @@ -2224,8 +2226,7 @@ asmlinkage int vprintk_emit(int facility, int level,
> >  		in_sched = true;
> >  	}
> >  
> > -	boot_delay_msec(level);
> > -	printk_delay();
> > +	printk_delay(level);
> 
> As a side note, I wonder why do boot_delay_msec() and printk_delay()
> touch only NMI watchdog. Shouldn't they also touch softlockup, WQ,
> RCU, etc. watchdogs?

It seems that touch_nmi_watchdog() actually calls touch_softlockup_watchdog()
that calls wq_watchdog_touch().

Best Regards,
Petr
