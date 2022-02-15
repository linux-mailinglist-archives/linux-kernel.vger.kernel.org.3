Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49DAA4B67A5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 10:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235899AbiBOJcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 04:32:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235916AbiBOJcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 04:32:32 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F236AA007
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 01:32:22 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2CE86210DC;
        Tue, 15 Feb 2022 09:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644917541; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KYdGeFsANOtOABOCKg2n5btFGKH4PKRKWZczmP67Y4c=;
        b=Fre+2KMos1Xt+rzKEa0yiIruHha9K585218YxzHlAprj3wPnd0UmAjNDO0DHnOvj8I85EA
        8qWBQ1+65aI05croPjluXpbDyoll3bC7Hs4+mQpwSmwWUif6BvnvediTZJTFwLVB7+EflY
        v+3muQf3MguEBQ5s+V4KTIjsqnksXqU=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 148E0A3B85;
        Tue, 15 Feb 2022 09:32:21 +0000 (UTC)
Date:   Tue, 15 Feb 2022 10:32:20 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH printk v1 01/13] printk: rename cpulock functions
Message-ID: <YgtzJPa7XJ5Ozdhf@alley>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-2-john.ogness@linutronix.de>
 <YgZaMkUU5Ve2GV9D@alley>
 <87fsopcvnj.fsf@jogness.linutronix.de>
 <20220211155727.49ab86f5@gandalf.local.home>
 <YgbPcAHgC1FLRXdR@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgbPcAHgC1FLRXdR@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-02-11 22:04:48, Peter Zijlstra wrote:
> On Fri, Feb 11, 2022 at 03:57:27PM -0500, Steven Rostedt wrote:
> > On Fri, 11 Feb 2022 15:48:08 +0106
> > John Ogness <john.ogness@linutronix.de> wrote:
> > 
> > > It is because (as in the example above), taking this "lock" does not
> > > provide synchronization to data. It is only synchronizing between
> > > CPUs. It was Steven's suggestion to call the thing a cpu_sync object and
> > > nobody in the RT Track seemed to disagree.
> > 
> > I love causing trouble ;-)
> > 
> > Actually, it wasn't just my suggestion. IIRC, I believe Peter Zijlstra was
> > against calling it a lock (Peter, you can use lore to see the context here).
> 
> All I remember is that it was in a room and I was late, I can't even
> remember what City we were all in at the time. Was this Lisbon?
> 
> Anyway, as Steve said, it isn't really a strict exclusion thing, it only
> avoids the most egregious inter-cpu interleaving. I'm down with
> goldi-locks, something has to have that name :-)

You troublemakers :-)

OK, I know, I am the troublemaker here.

Best Regards,
Petr
