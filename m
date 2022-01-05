Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A432D485914
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 20:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243482AbiAETWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 14:22:12 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38872 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243475AbiAETWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 14:22:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B5BB618CB
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 19:22:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA61EC36AE9;
        Wed,  5 Jan 2022 19:22:09 +0000 (UTC)
Date:   Wed, 5 Jan 2022 14:22:08 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Xiangyang Zhang <xyz.sun.ok@gmail.com>
Cc:     mingo@redhat.com, Masami Hiramatsu <mhiramat@kernel.org>,
        oleg@redhat.com, namhyung.kim@lge.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/kprobes: 'nmissed' not showed correctly for
 kretprobe
Message-ID: <20220105142208.1dbc20cc@gandalf.local.home>
In-Reply-To: <20220105141556.12fb2ceb@gandalf.local.home>
References: <20211211150032.7568-1-xyz.sun.ok@gmail.com>
        <20220105141556.12fb2ceb@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resending again, this time with Masami's working email address.

On Wed, 5 Jan 2022 14:15:56 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 11 Dec 2021 23:00:32 +0800
> Xiangyang Zhang <xyz.sun.ok@gmail.com> wrote:
> 
> > The 'nmissed' column of the 'kprobe_profile' file for kretprobe is
> > always zero, because 'nmissed' for kretprobe is maintained in
> > 'tk->rp.nmissed' but not in 'tk->rp.kp.nmissed'
> > 
> > Fixes: c31ffb3ff633 ("tracing/kprobes: Factor out struct trace_probe")
> > Signed-off-by: Xiangyang Zhang <xyz.sun.ok@gmail.com>
> > ---
> >  kernel/trace/trace_kprobe.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > index d10c01948e68..2b9de6826e94 100644
> > --- a/kernel/trace/trace_kprobe.c
> > +++ b/kernel/trace/trace_kprobe.c
> > @@ -1175,15 +1175,17 @@ static int probes_profile_seq_show(struct seq_file *m, void *v)
> >  {
> >  	struct dyn_event *ev = v;
> >  	struct trace_kprobe *tk;
> > +	unsigned long nmissed = 0;  
> 
> No need to initialize this to zero, the first use is an assignment.
> 
> >  
> >  	if (!is_trace_kprobe(ev))
> >  		return 0;
> >  
> >  	tk = to_trace_kprobe(ev);
> > +	nmissed = tk->rp.handler ? tk->rp.nmissed : tk->rp.kp.nmissed;
> >  	seq_printf(m, "  %-44s %15lu %15lu\n",
> >  		   trace_probe_name(&tk->tp),
> >  		   trace_kprobe_nhit(tk),
> > -		   tk->rp.kp.nmissed);
> > +		   nmissed);  
> 
> Masami, what's your thoughts on this patch?
> 
> -- Steve
> 
> >  
> >  	return 0;
> >  }  
> 

