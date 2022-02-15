Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8684B6790
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 10:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235886AbiBOJ3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 04:29:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbiBOJ3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 04:29:30 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A429AD95
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 01:29:21 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BCF5F210DC;
        Tue, 15 Feb 2022 09:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644917359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UzRpW6DJHMnpjwHPs/15Wf/rAVBcnK/SJVX9MTS6Lh4=;
        b=uXoQSKkfHApgFRRXf/ioxkFz5u0MgARq5UhhtB9XNulowoDsL677WGD01DV5SzqOe8Uini
        QHDwJcwjgovhha1+JgX9FOdIDAZCObXpIa/mpDePofV6+RbGHaR7bgU7T1pQBhuUVcMVNI
        VeXfm2tzphJ0HmPIrRhfU4PbuoNk2P4=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8589BA3B83;
        Tue, 15 Feb 2022 09:29:19 +0000 (UTC)
Date:   Tue, 15 Feb 2022 10:29:19 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH printk v1 01/13] printk: rename cpulock functions
Message-ID: <Ygtyb4WFVlv/earX@alley>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-2-john.ogness@linutronix.de>
 <YgZaMkUU5Ve2GV9D@alley>
 <Ygn7ZFnFL4QiQHRg@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ygn7ZFnFL4QiQHRg@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-02-14 15:49:08, Sergey Senozhatsky wrote:
> On (22/02/11 13:44), Petr Mladek wrote:
> > On Mon 2022-02-07 20:49:11, John Ogness wrote:
> > > Since the printk cpulock is CPU-reentrant and since it is used
> > > in all contexts, its usage must be carefully considered and
> > > most likely will require programming locklessly. To avoid
> > > mistaking the printk cpulock as a typical lock, rename it to
> > > cpu_sync. The main functions then become:
> > > 
> > >     printk_cpu_sync_get_irqsave(flags);
> > >     printk_cpu_sync_put_irqrestore(flags);
> > 
> > It is possible that I will understand the motivation later when
> > reading the entire patchset. But my initial reaction is confusion ;-)
> > 
> > From mo POV, it is a lock. It tries to get exclusive access and
> > has to wait until the current owner releases it.
> 
> printk has been using enter/exit naming for a while now (starting with
> nmi enter/exit, then printk_safe enter/exit and soon direct enter/exit);
> so may be we can follow suit here and use printk_cpu_sync_enter() and
> printk_cpu_sync_exit()?

Interesting idea.

Honestly, I do not like it much. The existing enter/exit API is not
blocking but "cpu_sync" API is.

This patch is about how to make it more obvious that this
API has to be used carefully. I see the following main risks when
using this API:

     + it might cause deadlocks, especially in panic

     + it is supposed to be tail lock (no other locks allowed in this
       context)

     + it is re-entrant

     + it does not prevent parallel (nested) access on the same CPU


"get/put" are more acceptable for me. They create at lest some feeling
that it tries to get something and it might take some time. Even
thought many "get/put" APIs are not blocking.

BTW: The API disables IRQ. So the nested access is limited to two
levels: normal/IRQ and nested NMI contexts.

Best Regards,
Petr
