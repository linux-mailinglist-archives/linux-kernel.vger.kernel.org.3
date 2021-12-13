Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B324723CA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 10:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbhLMJ2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 04:28:17 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33454 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbhLMJ2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 04:28:16 -0500
Date:   Mon, 13 Dec 2021 10:28:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639387695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1tmZMJUzTTKRiNxPJe2nsVt0FnhdgbREgoT1ZPRJKvg=;
        b=4to1FsmlATDOQcpHT6gosJuOZDfFLZtfnMJTmw28AcyVFWk4rF62rID2oNkMe20HKcg/bk
        sqPD9fQvO6XhmS3EujkU1rLfBcu/lEZ0jGYXhXuthJbRVu0mrb/6ZegpghJC7nDi4QhE59
        u4ErEJj/3ReY8NXMewHZAgLdO1jj40JvaHJpuBTUvTMnbSlNklBRyNO6t6cvO7Ux/M0RnH
        B+RhGOs9VJrLwtDPRhFppNrUlAnWTV7uGrILIOcN6EZcOmiXMG77c2PrsUYH1z8CVTqAcV
        /dUCNzzqT0LO7Z3JeH8TzJ3cTKNZO6Ku2f1ILYRVGBPItVoCbee3k3J/t04KEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639387695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1tmZMJUzTTKRiNxPJe2nsVt0FnhdgbREgoT1ZPRJKvg=;
        b=7H3Xww9BiCAbhlUSDdPMXXxjBYbVao3q7VqSeRdB5Lj5DLeVYzxBL21bV61srJG3TH7nSI
        kzWLlgUjl5KlPCDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] tracing: Account bottom half disabled sections.
Message-ID: <YbcSLmrm0HmCJzvJ@linutronix.de>
References: <YbO5H+H3dwLoIVka@linutronix.de>
 <20211210203240.43a8e7eb@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211210203240.43a8e7eb@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-10 20:32:40 [-0500], Steven Rostedt wrote:
> > @@ -4226,7 +4228,7 @@ static void print_func_help_header_irq(struct array_buffer *buf, struct seq_file
> >  
> >  	seq_printf(m, "#                            %.*s  _-----=> irqs-off\n", prec, space);
> >  	seq_printf(m, "#                            %.*s / _----=> need-resched\n", prec, space);
> > -	seq_printf(m, "#                            %.*s| / _---=> hardirq/softirq\n", prec, space);
> > +	seq_printf(m, "#                            %.*s| / _---=> hardirq/softirq/BH-disabled\n", prec, space);
> 
> So I went to update the documentation on this, and realized that this is
> wrong. Really, we want this in the irqs-off section probably.
> 
> Note, the above is to show we are running in a hardirq or softirq context.
> But BH-disabled does not match that. Should this be with irqs-off being:
> 
>  d - irqs are disabled
>  b - BH is disabled?
>  D - irqs and BH is disabled?

We are not in hardirq/softirq/nmi but have simply BH disabled.
Makes sense.

> -- Steve

Sebastian
