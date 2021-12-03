Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6701D4673AD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 10:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379437AbhLCJL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 04:11:26 -0500
Received: from out1.migadu.com ([91.121.223.63]:40402 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243758AbhLCJLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 04:11:23 -0500
Date:   Fri, 3 Dec 2021 17:07:49 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1638522478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V77KM8Yhr74VAb29G5cK07G1IrqN80qbBuHofto+1HI=;
        b=qZ6Q+T2a96Ovhnl7TPmkQcoYSzqHYwMK8c8BDd9XEXurQpTfNUZuH3APGF1ULJvZxLzB+R
        DO2t7jN5rh/8Rnaw14u1kQ/NCixLGK0uszvvHDQlJux7FrKHd+rstdI8Uk+j5hPoH17u4F
        hCg2PFNiILpTJKQdBfBGjZtBEeXPz90=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Tao Zhou <tao.zhou@linux.dev>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tao Zhou <tao.zhou@linux.dev>, linux-rt-users@vger.kernel.org,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 02/14] rtla: Helper functions for rtla
Message-ID: <YaneZTnR+leNRzNN@geo.homenetwork>
References: <cover.1638182284.git.bristot@kernel.org>
 <8fbb0e5ab5b39ba3c981fc97a3f93471d291cffc.1638182284.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fbb0e5ab5b39ba3c981fc97a3f93471d291cffc.1638182284.git.bristot@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 12:07:40PM +0100,
Daniel Bristot de Oliveira wrote:

> +/*
> + * enable_tracer_by_name - enable a tracer on the given instance
> + */
> +int enable_tracer_by_name(struct tracefs_instance *inst, const char *tracer)
> +{ 
> +	enum tracefs_tracers t;
> +	int retval;
> +
> +	t = TRACEFS_TRACER_CUSTOM;
> +
> +	debug_msg("enabling %s tracer\n", tracer);
> +
> +	retval = tracefs_tracer_set(inst, t, tracer);

The comment of parameters used for tracefs_tracer_set() says:

'
 * tracefs_set_tracer - function to set the tracer
 * @instance: ftrace instance, can be NULL for top tracing instance
 * @tracer: The tracer enum that defines the tracer to be set
 * @t: A tracer name if TRACEFS_TRACER_CUSTOM is passed in for @tracer
'

tracefs_tracer_set(inst, tracer, t); @tracer is enum and @t is tracer
name. this is not important.

> +	if (retval < 0) {
> +		if (errno == ENODEV)
> +			err_msg("tracer %s not found!\n", tracer);
> +
> +		err_msg("failed to enable the tracer %s\n", tracer);
> +		return -1;
> +	}
> +
> +	return 0;
> +}
