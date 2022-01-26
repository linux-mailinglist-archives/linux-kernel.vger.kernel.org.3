Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A894B49C713
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 11:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239594AbiAZKGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 05:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239581AbiAZKGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:06:51 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D44C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 02:06:51 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id y17so11569892plg.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 02:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hfkv8xA2MTmD65MJmGmZeGhLuFk88prf6bIKcrAiQzk=;
        b=jsRGPN1UZO9nDlDSnn4Q1zEjZeZJh2DfHs2jyGzUGud2xIq5zEk+032ahEATQij2ce
         crQrdFVK+oKQpEWQ8jp7Pp2/6UZJEZxV4UtMW28dU6hjhsorq8eGs2GORCCHiGSWqI79
         IUCZNNNeqxv7dZq2xsAzYC0uQfdWB6Vv1I3nQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hfkv8xA2MTmD65MJmGmZeGhLuFk88prf6bIKcrAiQzk=;
        b=7po06Rt6oDYIIzknajzyzxxyqGa6bmP21aef6UnSDmooFAUEAorQAFxsiwKoq4XZos
         yQFWQfvrbsV67+UqKsfMsEcnfqq1reATTPN8RVub48mABF0HGYIdy6jCqbakpmkJkmp0
         Sb+M4XtBACyyP796ePNkyWufCQRvv739sSONIPIJuBe4w/7TBd9wky5JjbO5VzaBToOL
         QdaJbixrcezZPn6v83ikCzUMIQhO2Gb+F7egAigc5Q/j9FWi5Pq1/kr6xxPyZt9cR9kr
         Xi+Y/2gRSyxkcCCACHtY5gvqSqBpVcv1kEF0QV/+TMzBgrqXYnIlj2G8yHB6OZD4SfoS
         wi/A==
X-Gm-Message-State: AOAM531/Ct8v9pAIyKkpOkT0DbJnniPIpfQHLN+9f9pWs5g1kJ0Fq8Ce
        mUV17h4BPSNChtLKVbBopx2YCA==
X-Google-Smtp-Source: ABdhPJzVzo6ZzXZLotHX/o3KUt//YbmdoycuWQo3k5bm/DMejMGlBSyRICKzJJczhEacqrVZrO/dLg==
X-Received: by 2002:a17:90a:53:: with SMTP id 19mr7923701pjb.159.1643191610615;
        Wed, 26 Jan 2022 02:06:50 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:7bbc:f635:b767:2a8a])
        by smtp.gmail.com with ESMTPSA id bj7sm2572947pjb.9.2022.01.26.02.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 02:06:49 -0800 (PST)
Date:   Wed, 26 Jan 2022 19:06:44 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] printk: disable optimistic spin during panic
Message-ID: <YfEdNKWI7GqKr9P/@google.com>
References: <20220121190222.572694-1-stephen.s.brennan@oracle.com>
 <20220121190222.572694-3-stephen.s.brennan@oracle.com>
 <YfER7tlXZZpX94c9@google.com>
 <87r18un83x.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r18un83x.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/01/26 10:51), John Ogness wrote:
> > Is there something that prevents panic CPU from NMI hlt CPU which is
> > in console_trylock() under raw_spin_lock_irqsave()?
> >
> >  CPU0				CPU1
> > 				console_trylock_spinnning()
> > 				 console_trylock()
> > 				  down_trylock()
> > 				   raw_spin_lock_irqsave(&sem->lock)
> >
> >  panic()
> >   crash_smp_send_stop()
> >    NMI 			-> 		HALT
> 
> This is a good point. I wonder if console_flush_on_panic() should
> perform a sema_init() before it does console_trylock().

A long time ago there was zap_locks() function in printk, that used
to re-init console semaphore and logbuf spin_lock, but _only_ in case
of printk recursion (which was never reliable)

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/kernel/printk/printk.c?h=v4.9.297#n1557

This has been superseded by printk_safe per-CPU buffers so we removed
that function.

So it could be that may be we want to introduce something similar to
zap_locks() again.

All reasonable serial consoles drivers should take oops_in_progress into
consideration in ->write(), so we probably don't care for console_drivers
spinlocks, etc. but potentially can do a bit better on the printk side.
