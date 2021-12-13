Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2F4473047
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 16:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239805AbhLMPSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 10:18:35 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35492 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhLMPSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 10:18:34 -0500
Date:   Mon, 13 Dec 2021 16:18:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639408713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TX3eom1lYu6OGAOAK4JwRKmKt4IK3B4TvEl+DOVnKvY=;
        b=HbZY+MJSlii1p6qKOMoVqFD0r/0td+E5fgfrUk6LhiBPsNzaPEDMZjhykpqRsPHBv0ELwh
        TtjXaIpTN4hW9NbvM5sFRhNrz58Qq6er6Y16SWLLApv5xF61+j7t5Wyy0pDesePEM8g60Z
        O44s9Qrq5HeWN6VljDRSo34lo0VvShOuUT1ayZ36ioC6jwMnHMJPLQwt40BCS+32U7rimf
        9CmPPpylOOmiW7DRYOy/qcq4rMZtYe0N5vCjjLzXjrp+NF8xfvqisI5KqL59fJl/zvCQT+
        PjhBViFKu0DAmay3yDmEGz/Md7CXDCSa873PCcJi52sKbhxvTif/Rp8dBFTEaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639408713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TX3eom1lYu6OGAOAK4JwRKmKt4IK3B4TvEl+DOVnKvY=;
        b=/8lZGa6C0D875LYPVLKG+pgaJcQV4ZXgEJ1vSr9puVws13ACX8kNyiQRWI4/Y2uJ32uHPZ
        kO40C+EmXo14T7CA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        tglx@linutronix.de
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 0/8] kernel/fork: Move thread stack free otu of the
 scheduler path.
Message-ID: <YbdkSLFdBL/xeRbA@linutronix.de>
References: <20211118143452.136421-1-bigeasy@linutronix.de>
 <20211118143850.ygpp7xetpz3pt2nj@linutronix.de>
 <20211203162211.qvcnvbj4cdsa5g3a@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211203162211.qvcnvbj4cdsa5g3a@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-03 17:22:13 [+0100], To linux-kernel@vger.kernel.org wrote:
> On 2021-11-18 15:38:50 [+0100], To linux-kernel@vger.kernel.org wrote:
> > + tglx.
> > 
> > It starts at
> >    https://lore.kernel.org/all/20211118143452.136421-1-bigeasy@linutronix.de/
> > 
> > On 2021-11-18 15:34:44 [+0100], To linux-kernel@vger.kernel.org wrote:
> > > 
> > > This is a follup-up on the patch
> > >     sched: Delay task stack freeing on RT 
> > >     https://lkml.kernel.org/r/20210928122411.593486363@linutronix.de
> > > 
> > > It addresses the review feedback:
> > > - Decouple stack accounting from its free invocation. The accounting
> > >   happens in do_exit(), the final free call happens later.
> > > 
> > > - Add put_task_stack_sched() to finish_task_switch(). Here the VMAP
> > >   stack is cached only. If it fails, or in the !VMAP case then the final
> > >   free happens in delayed_put_task_struct(). This is also an oportunity
> > >   to cache the stack.
> 
> ping ;)

ping.

Sebastian
