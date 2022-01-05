Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A9A485BB1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 23:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245059AbiAEWcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 17:32:13 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:59192 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245052AbiAEWcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 17:32:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E158C617D5
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 22:32:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC3ECC36AE9;
        Wed,  5 Jan 2022 22:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641421927;
        bh=+hYP4qVyGmZPt9bki7UAz8cSVMAh+3SjozPNm642HKw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l+MVf6K8Z4MXXkVnKZNEub6x3DUBtnm7J6tklbFgkkYzo+BRGV3gvdZ32SUY7SD8L
         UMC1gWaa58INQXUjTvq2CucV4ifRJFeREoGi03T3TmWZPaU+ZfZWsJZGNnKCluYEuH
         3HzT5u1k6M8H1cxxqzBl6Ed91QvC///cbN+pTxinaUBVNXtX+zBoUU6U1x7fRrEVVc
         7+a0dgL2j6LSRq4Jdaf/+AHo2GpntNbxEK+txiX2F/UjrDmlG5nV7N74WOlauJQsmR
         B3txBkK/tgnm4bOTFBvJ+20jejol/bya0fBs1zsmTKJOPVKhVZFukZJyAaTjqX+5CW
         IRiiqto9UB3nQ==
Date:   Thu, 6 Jan 2022 07:32:03 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Xiangyang Zhang <xyz.sun.ok@gmail.com>, mingo@redhat.com,
        Masami Hiramatsu <mhiramat@kernel.org>, oleg@redhat.com,
        namhyung.kim@lge.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/kprobes: 'nmissed' not showed correctly for
 kretprobe
Message-Id: <20220106073203.123c4f7e38cc07eccd02aa9b@kernel.org>
In-Reply-To: <20220105142208.1dbc20cc@gandalf.local.home>
References: <20211211150032.7568-1-xyz.sun.ok@gmail.com>
        <20220105141556.12fb2ceb@gandalf.local.home>
        <20220105142208.1dbc20cc@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jan 2022 14:22:08 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Resending again, this time with Masami's working email address.
> 
> On Wed, 5 Jan 2022 14:15:56 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Sat, 11 Dec 2021 23:00:32 +0800
> > Xiangyang Zhang <xyz.sun.ok@gmail.com> wrote:
> > 
> > > The 'nmissed' column of the 'kprobe_profile' file for kretprobe is
> > > always zero, because 'nmissed' for kretprobe is maintained in
> > > 'tk->rp.nmissed' but not in 'tk->rp.kp.nmissed'
> > > 
> > > Fixes: c31ffb3ff633 ("tracing/kprobes: Factor out struct trace_probe")
> > > Signed-off-by: Xiangyang Zhang <xyz.sun.ok@gmail.com>
> > > ---
> > >  kernel/trace/trace_kprobe.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > > index d10c01948e68..2b9de6826e94 100644
> > > --- a/kernel/trace/trace_kprobe.c
> > > +++ b/kernel/trace/trace_kprobe.c
> > > @@ -1175,15 +1175,17 @@ static int probes_profile_seq_show(struct seq_file *m, void *v)
> > >  {
> > >  	struct dyn_event *ev = v;
> > >  	struct trace_kprobe *tk;
> > > +	unsigned long nmissed = 0;  
> > 
> > No need to initialize this to zero, the first use is an assignment.
> > 
> > >  
> > >  	if (!is_trace_kprobe(ev))
> > >  		return 0;
> > >  
> > >  	tk = to_trace_kprobe(ev);
> > > +	nmissed = tk->rp.handler ? tk->rp.nmissed : tk->rp.kp.nmissed;
> > >  	seq_printf(m, "  %-44s %15lu %15lu\n",
> > >  		   trace_probe_name(&tk->tp),
> > >  		   trace_kprobe_nhit(tk),
> > > -		   tk->rp.kp.nmissed);
> > > +		   nmissed);  
> > 
> > Masami, what's your thoughts on this patch?

OK, this is a good catch :), but there are 2 issues.

1. kretprobe can be skipped by 2 reasons, shortage of kretprobe_instance which
is counted by rp.nmissed, and kprobe itself is missed by some reason (this
can be happen if KPROBE_EVENTS_ON_NOTRACE=n. Thus, better solution is to show
'tk->rp.nmissed + tk->rp.kp.nmissed'.

2. the commit c31ffb3ff633 is not actual commit which introduce this issue.
  this was introduced by 4a846b443b4e ("tracing/kprobes: Cleanup kprobe tracer code.")

'git blame' tells you the commit which changes that line, but that can be just
a refactoring (renaming). I recommend you to search the correct one by 'git log -p'.

Thank you,

> > 
> > -- Steve
> > 
> > >  
> > >  	return 0;
> > >  }  
> > 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
