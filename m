Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1EA488ADB
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 18:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236126AbiAIROw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 12:14:52 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:55542 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbiAIROv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 12:14:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B62860A55
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 17:14:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 097F5C36AE3;
        Sun,  9 Jan 2022 17:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641748490;
        bh=3mdUU2H2XgCZ+pdrmPE+3ORCHyq42l7sLmzBCamX8k8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Q285x1TnCBt1BAz+CmgV5mvTvQt3ZunNckOu0CjgksL46LkRtM2RVIwpopgdZO6vz
         WwYUj9lPBKyOPenHgsalWs+md4PCjdq6IVwP4xpapfyqeio8AC+8I83zXD/PjKfL0f
         6T15utBc6uV9E5mFkW2ehgeW291e5cgz6meM/NgljGYZCAya0z+Vs8tDOhT4XpFWr/
         CpsdScKp7Uv+cCFiJ41n5vm0kH87m1bkHg7w2lWk+4libzG+dv1lA3/FFcWmpbWLyt
         hIPvEsJHKd5LEJ6Y4Ay3BrlJkH5oH2JI6Nf4oLV5ZqNxsC+/01O8uhuPGe8PZEyqiR
         psfrxZEeO16bA==
Message-ID: <8909952722ad8c2816fff1d1aebafab17c7b7110.camel@kernel.org>
Subject: Re: [PATCH v5 4/4] tracing: Have existing event_command.parse()
 implementations use helpers
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 09 Jan 2022 11:14:48 -0600
In-Reply-To: <b2c8ad2086362a64853b70fc0aa4c29ce6348544.camel@kernel.org>
References: <cover.1639507505.git.zanussi@kernel.org>
         <f043571a0b7ccc0eb524f87b63c520a460e59baf.1639507505.git.zanussi@kernel.org>
         <20220108195406.0c4f659d@gandalf.local.home>
         <b2c8ad2086362a64853b70fc0aa4c29ce6348544.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-01-08 at 22:23 -0600, Tom Zanussi wrote:
> Hi Steve,
> 
> On Sat, 2022-01-08 at 19:54 -0500, Steven Rostedt wrote:
> > On Tue, 14 Dec 2021 12:57:32 -0600
> > Tom Zanussi <zanussi@kernel.org> wrote:
> > 
> > > index da103826f27e..e6a48e8c79eb 100644
> > > --- a/kernel/trace/trace_events_trigger.c
> > > +++ b/kernel/trace/trace_events_trigger.c
> > > @@ -973,7 +973,7 @@ int event_trigger_register(struct
> > > event_command
> > > *cmd_ops,
> > >   * @file: The trace_event_file associated with the event
> > >   * @glob: The raw string used to register the trigger
> > >   * @cmd: The cmd portion of the string used to register the
> > > trigger
> > > - * @param: The params portion of the string used to register the
> > > trigger
> > > + * @param_and_filter: The param and filter portion of the string
> > > used to register the trigger
> > >   *
> > >   * Common implementation for event command parsing and trigger
> > >   * instantiation.
> > > @@ -986,94 +986,53 @@ int event_trigger_register(struct
> > > event_command *cmd_ops,
> > >  static int
> > >  event_trigger_parse(struct event_command *cmd_ops,
> > >  		    struct trace_event_file *file,
> > > -		    char *glob, char *cmd, char *param)
> > > +		    char *glob, char *cmd, char *param_and_filter)
> > >  {
> > >  	struct event_trigger_data *trigger_data;
> > >  	struct event_trigger_ops *trigger_ops;
> > > -	char *trigger = NULL;
> > > -	char *number;
> > > +	char *param, *filter;
> > > +	bool remove;
> > >  	int ret;
> > >  
> > > -	/* separate the trigger from the filter (t:n [if filter]) */
> > > -	if (param && isdigit(param[0])) {
> > > -		trigger = strsep(&param, " \t");
> > > -		if (param) {
> > > -			param = skip_spaces(param);
> > > -			if (!*param)
> > > -				param = NULL;
> > > -		}
> > > -	}
> > > +	remove = event_trigger_check_remove(glob);
> > >  
> > > -	trigger_ops = cmd_ops->get_trigger_ops(cmd, trigger);
> > 
> > Did you mean to remove the assignment of trigger_ops here?
> 
> Hmm, yeah, that shouldn't have been removed, but...

Actually, it should be removed, because get_trigger_ops() is now called
in event_trigger_alloc() in patch 3/4.  And trigger_ops isn't actually
used by unreg(), so the trigger_ops local can just be removed.  For
that matter, trigger_ops should probably be removed from the
reg()/unreg() callbacks altogether.  Will add a separate pach to do
that.

> 
> > 
> > > +	ret = event_trigger_separate_filter(param_and_filter, &param,
> > > &filter, false);
> > > +	if (ret)
> > > +		return ret;
> > >  
> > >  	ret = -ENOMEM;
> > > -	trigger_data = kzalloc(sizeof(*trigger_data), GFP_KERNEL);
> > > +	trigger_data = event_trigger_alloc(cmd_ops, cmd, param, file);
> > >  	if (!trigger_data)
> > >  		goto out;
> > >  
> > > -	trigger_data->count = -1;
> > > -	trigger_data->ops = trigger_ops;
> > > -	trigger_data->cmd_ops = cmd_ops;
> > > -	trigger_data->private_data = file;
> > > -	INIT_LIST_HEAD(&trigger_data->list);
> > > -	INIT_LIST_HEAD(&trigger_data->named_list);
> > > -
> > > -	if (glob[0] == '!') {
> > > +	if (remove) {
> > >  		cmd_ops->unreg(glob+1, trigger_ops, trigger_data,
> > > file);
> > 
> > It's still used here and below.
> > 
> > I get a warning on this.
> 
> I'm not getting a warning, and remove should have crashed the
> testcases, but I'm not seeing that either.

I'm not getting a warning because of -Wno-maybe-ininitialized.  I had
to build with W=2 to see the warning.

Also, the testcases aren't crashing because trigger_ops is never used
in unreg().

I'll respin and resend later today.

Tom

> 
> Will have to investigate tomorrow..
> 
> Tom
> 
> 
> > 
> > Thanks,
> > 
> > -- Steve
> > 
> > >  		kfree(trigger_data);
> 
> 

