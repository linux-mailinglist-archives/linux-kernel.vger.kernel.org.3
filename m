Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7495E53566D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 01:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349494AbiEZXgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 19:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbiEZXga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 19:36:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E319C2FA
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 16:36:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58E2061CB7
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 23:36:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8533C385A9;
        Thu, 26 May 2022 23:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653608186;
        bh=klsdFk9eac0TsOU4zNOYAgskpHBllHxFCdqZUq8Rn6Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PET+VFJ4To0WucHH2v2NEnZ6+cOrg8RTkZeExKq1lu8N1nf4qDtqJC3l5HuS5AcY4
         WvqNtEtifk4mDrKOfr9gSWqVx0PdgnuENGArfqkws0+gVfI0rTKpz7VNrsToSZ2r2j
         S9t7R67L7/MufCDP6mOJJzI4vh3CXKyTV9eSv34BjOYACzr5J2aaNo5YT89QI6Abra
         k5zF5uDsukbaAvrdBt2p1Crh+RiR6t2lYybJlp+pBqKgVi5zGMTze3fLQyd/XA/Tgt
         AjtJGx3+ZjaoZq5nafAJG+S4tOLcVDHfbDkbQ12obyGAvzdyzAyE2eC4+AWtklsk6s
         Tvo4jVsfJJEsQ==
Date:   Fri, 27 May 2022 08:36:22 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Linyu Yuan <quic_linyyuan@quicinc.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH 1/2] tracing/probes: auto generate events name when
 create a group of events
Message-Id: <20220527083622.62b9d724a71383a9d75a6e29@kernel.org>
In-Reply-To: <b29dc02f-2319-b9d4-84fe-9342a7e4fb4a@quicinc.com>
References: <1651397651-30454-1-git-send-email-quic_linyyuan@quicinc.com>
        <1651397651-30454-2-git-send-email-quic_linyyuan@quicinc.com>
        <20220524183159.21bac428@gandalf.local.home>
        <b29dc02f-2319-b9d4-84fe-9342a7e4fb4a@quicinc.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linyu,

On Wed, 25 May 2022 09:33:57 +0800
Linyu Yuan <quic_linyyuan@quicinc.com> wrote:

> 
> On 5/25/2022 6:31 AM, Steven Rostedt wrote:
> > [ Adding Masami (kprobe maintainer) and Tom (dynamic event maintainer) ]
> >
> > On Sun, 1 May 2022 17:34:10 +0800
> > Linyu Yuan <quic_linyyuan@quicinc.com> wrote:
> >
> >> change traceprobe_parse_event_name() and return GRP/EVENT types,
> >> TP_ENAME_GROUP_EVENT means user input GRP/EVENT format,
> >> TP_ENAME_EVENT means user only input EVENT format,
> >> TP_ENAME_GROUP means user only input GRP/ format,
> >>
> >> it allow no event name input when create a group of events,
> >> and will auto generate event name according second argument.
> > Sorry, but I can't understand the above. Can you reword it, and perhaps
> > include an example of what this patch does.
> 
> thanks, will try to update after Masai and Tom comment
> 
> >
> > After reading the code, I guess you are trying to make it so that you can
> > leave out the event name and only have the group name, if you add the slash.
> >
> >   echo 'p:group/  schedule' > kprobe_events
> >
> > And that will create a kprobe "schedule" event under the "group" system?
> 
> that's right

Hmm, it is an interesting idea :)
Please update the patch description, and avoid explaining internal
implementation details. Those flag explanation should be commented
in the code.
(And Cc to me.)

Thank you,

> 
> >
> > Also, for some reason, patch 2 of the series never came to me. But it is in
> > my LKML folder :-/
> >
> >> Signed-off-by: Linyu Yuan <quic_linyyuan@quicinc.com>
> >> ---
> >>   Documentation/trace/kprobetrace.rst  |  8 ++++----
> >>   Documentation/trace/uprobetracer.rst |  8 ++++----
> >>   kernel/trace/trace_dynevent.c        |  2 +-
> >>   kernel/trace/trace_eprobe.c          | 19 +++++++++++--------
> >>   kernel/trace/trace_kprobe.c          | 18 +++++++++++-------
> >>   kernel/trace/trace_probe.c           |  9 ++++++++-
> >>   kernel/trace/trace_probe.h           |  4 ++++
> >>   kernel/trace/trace_uprobe.c          | 14 +++++++++-----
> >>   8 files changed, 52 insertions(+), 30 deletions(-)
> >>
> >> diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
> >> index b175d88..4274cc6 100644
> >> --- a/Documentation/trace/kprobetrace.rst
> >> +++ b/Documentation/trace/kprobetrace.rst
> >> @@ -28,10 +28,10 @@ Synopsis of kprobe_events
> >>   -------------------------
> >>   ::
> >>   
> >> -  p[:[GRP/]EVENT] [MOD:]SYM[+offs]|MEMADDR [FETCHARGS]	: Set a probe
> >> -  r[MAXACTIVE][:[GRP/]EVENT] [MOD:]SYM[+0] [FETCHARGS]	: Set a return probe
> >> -  p:[GRP/]EVENT] [MOD:]SYM[+0]%return [FETCHARGS]	: Set a return probe
> >> -  -:[GRP/]EVENT						: Clear a probe
> >> +  p[:[GRP/][EVENT]] [MOD:]SYM[+offs]|MEMADDR [FETCHARGS]	: Set a probe
> >> +  r[MAXACTIVE][:[GRP/][EVENT]] [MOD:]SYM[+0] [FETCHARGS]	: Set a return probe
> >> +  p[:[GRP/][EVENT]] [MOD:]SYM[+0]%return [FETCHARGS]	: Set a return probe
> >> +  -:[GRP/][EVENT]						: Clear a probe
> >>   
> >>    GRP		: Group name. If omitted, use "kprobes" for it.
> >>    EVENT		: Event name. If omitted, the event name is generated
> >> diff --git a/Documentation/trace/uprobetracer.rst b/Documentation/trace/uprobetracer.rst
> >> index a8e5938..3a1797d7 100644
> >> --- a/Documentation/trace/uprobetracer.rst
> >> +++ b/Documentation/trace/uprobetracer.rst
> >> @@ -26,10 +26,10 @@ Synopsis of uprobe_tracer
> >>   -------------------------
> >>   ::
> >>   
> >> -  p[:[GRP/]EVENT] PATH:OFFSET [FETCHARGS] : Set a uprobe
> >> -  r[:[GRP/]EVENT] PATH:OFFSET [FETCHARGS] : Set a return uprobe (uretprobe)
> >> -  p[:[GRP/]EVENT] PATH:OFFSET%return [FETCHARGS] : Set a return uprobe (uretprobe)
> >> -  -:[GRP/]EVENT                           : Clear uprobe or uretprobe event
> >> +  p[:[GRP/][EVENT]] PATH:OFFSET [FETCHARGS] : Set a uprobe
> >> +  r[:[GRP/][EVENT]] PATH:OFFSET [FETCHARGS] : Set a return uprobe (uretprobe)
> >> +  p[:[GRP/][EVENT]] PATH:OFFSET%return [FETCHARGS] : Set a return uprobe (uretprobe)
> >> +  -:[GRP/][EVENT]                           : Clear uprobe or uretprobe event
> >>   
> >>     GRP           : Group name. If omitted, "uprobes" is the default value.
> >>     EVENT         : Event name. If omitted, the event name is generated based
> >> diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
> >> index e34e8182..033248d 100644
> >> --- a/kernel/trace/trace_dynevent.c
> >> +++ b/kernel/trace/trace_dynevent.c
> >> @@ -101,7 +101,7 @@ int dyn_event_release(const char *raw_command, struct dyn_event_operations *type
> >>   		event = p + 1;
> >>   		*p = '\0';
> >>   	}
> >> -	if (event[0] == '\0') {
> >> +	if (!system && event[0] == '\0') {
> >>   		ret = -EINVAL;
> >>   		goto out;
> >>   	}
> >> diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
> >> index 7d44785..b16e067 100644
> >> --- a/kernel/trace/trace_eprobe.c
> >> +++ b/kernel/trace/trace_eprobe.c
> >> @@ -125,6 +125,7 @@ static bool eprobe_dyn_event_match(const char *system, const char *event,
> >>   	 * We match the following:
> >>   	 *  event only			- match all eprobes with event name
> >>   	 *  system and event only	- match all system/event probes
> >> +	 *  system only			- match all system probes
> >>   	 *
> >>   	 * The below has the above satisfied with more arguments:
> >>   	 *
> >> @@ -143,7 +144,7 @@ static bool eprobe_dyn_event_match(const char *system, const char *event,
> >>   		return false;
> >>   
> >>   	/* Must match the event name */
> >> -	if (strcmp(trace_probe_name(&ep->tp), event) != 0)
> >> +	if (event[0] != '\0' && strcmp(trace_probe_name(&ep->tp), event) != 0)
> >>   		return false;
> >>   
> >>   	/* No arguments match all */
> >> @@ -848,7 +849,7 @@ static int __trace_eprobe_create(int argc, const char *argv[])
> >>   {
> >>   	/*
> >>   	 * Argument syntax:
> >> -	 *      e[:[GRP/]ENAME] SYSTEM.EVENT [FETCHARGS]
> >> +	 *      e[:[GRP/][ENAME]] SYSTEM.EVENT [FETCHARGS]
> >>   	 * Fetch args:
> >>   	 *  <name>=$<field>[:TYPE]
> >>   	 */
> >> @@ -858,6 +859,7 @@ static int __trace_eprobe_create(int argc, const char *argv[])
> >>   	struct trace_eprobe *ep = NULL;
> >>   	char buf1[MAX_EVENT_NAME_LEN];
> >>   	char buf2[MAX_EVENT_NAME_LEN];
> >> +	char grp_buf[MAX_EVENT_NAME_LEN];
> >>   	int ret = 0;
> >>   	int i;
> >>   
> >> @@ -866,14 +868,16 @@ static int __trace_eprobe_create(int argc, const char *argv[])
> >>   
> >>   	trace_probe_log_init("event_probe", argc, argv);
> >>   
> >> +	ret = TP_ENAME_EMPTTY;
> > EMPTY is spelled wrong.
> 
> 
> sorry, will wait comment from  maintainer of V1,  will fix it in V2 if 
> V1 is not reject.
> 
> 
> >>   	event = strchr(&argv[0][1], ':');
> >>   	if (event) {
> >>   		event++;
> >> -		ret = traceprobe_parse_event_name(&event, &group, buf1,
> >> +		ret = traceprobe_parse_event_name(&event, &group, grp_buf,
> >>   						  event - argv[0]);
> >> -		if (ret)
> >> +		if (ret < 0)
> >>   			goto parse_error;
> >> -	} else {
> >> +	}
> > add space.
> 
> sure, thanks.
> 
> >
> >> +	if (ret == TP_ENAME_EMPTTY || ret == TP_ENAME_GROUP) {
> >>   		strscpy(buf1, argv[1], MAX_EVENT_NAME_LEN);
> >>   		sanitize_event_name(buf1);
> >>   		event = buf1;
> > I'd like to see Masami's and Tom's comments on this one.
> >
> > -- Steve
> >
> >> @@ -882,9 +886,8 @@ static int __trace_eprobe_create(int argc, const char *argv[])
> >>   		goto parse_error;
> >>   
> >>   	sys_event = argv[1];
> >> -	ret = traceprobe_parse_event_name(&sys_event, &sys_name, buf2,
> >> -					  sys_event - argv[1]);
> >> -	if (ret || !sys_name)
> >> +	ret = traceprobe_parse_event_name(&sys_event, &sys_name, buf2, 0);
> >> +	if (ret != TP_ENAME_GROUP_EVENT)
> >>   		goto parse_error;
> >>   	if (!is_good_name(sys_event) || !is_good_name(sys_name))
> >>   		goto parse_error;
> >> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> >> index 47cebef..2cd8ef9 100644
> >> --- a/kernel/trace/trace_kprobe.c
> >> +++ b/kernel/trace/trace_kprobe.c
> >> @@ -163,7 +163,8 @@ static bool trace_kprobe_match(const char *system, const char *event,
> >>   {
> >>   	struct trace_kprobe *tk = to_trace_kprobe(ev);
> >>   
> >> -	return strcmp(trace_probe_name(&tk->tp), event) == 0 &&
> >> +	return (event[0] == '\0' ||
> >> +		strcmp(trace_probe_name(&tk->tp), event) == 0) &&
> >>   	    (!system || strcmp(trace_probe_group_name(&tk->tp), system) == 0) &&
> >>   	    trace_kprobe_match_command_head(tk, argc, argv);
> >>   }
> >> @@ -708,11 +709,11 @@ static int __trace_kprobe_create(int argc, const char *argv[])
> >>   	/*
> >>   	 * Argument syntax:
> >>   	 *  - Add kprobe:
> >> -	 *      p[:[GRP/]EVENT] [MOD:]KSYM[+OFFS]|KADDR [FETCHARGS]
> >> +	 *      p[:[GRP/][EVENT]] [MOD:]KSYM[+OFFS]|KADDR [FETCHARGS]
> >>   	 *  - Add kretprobe:
> >> -	 *      r[MAXACTIVE][:[GRP/]EVENT] [MOD:]KSYM[+0] [FETCHARGS]
> >> +	 *      r[MAXACTIVE][:[GRP/][EVENT]] [MOD:]KSYM[+0] [FETCHARGS]
> >>   	 *    Or
> >> -	 *      p:[GRP/]EVENT] [MOD:]KSYM[+0]%return [FETCHARGS]
> >> +	 *      p[:[GRP/][EVENT]] [MOD:]KSYM[+0]%return [FETCHARGS]
> >>   	 *
> >>   	 * Fetch args:
> >>   	 *  $retval	: fetch return value
> >> @@ -739,6 +740,7 @@ static int __trace_kprobe_create(int argc, const char *argv[])
> >>   	long offset = 0;
> >>   	void *addr = NULL;
> >>   	char buf[MAX_EVENT_NAME_LEN];
> >> +	char grp_buf[MAX_EVENT_NAME_LEN];
> >>   	unsigned int flags = TPARG_FL_KERNEL;
> >>   
> >>   	switch (argv[0][0]) {
> >> @@ -832,12 +834,14 @@ static int __trace_kprobe_create(int argc, const char *argv[])
> >>   	}
> >>   
> >>   	trace_probe_log_set_index(0);
> >> +	ret = TP_ENAME_EMPTTY;
> >>   	if (event) {
> >> -		ret = traceprobe_parse_event_name(&event, &group, buf,
> >> +		ret = traceprobe_parse_event_name(&event, &group, grp_buf,
> >>   						  event - argv[0]);
> >> -		if (ret)
> >> +		if (ret < 0)
> >>   			goto parse_error;
> >> -	} else {
> >> +	}
> >> +	if (ret == TP_ENAME_EMPTTY || ret == TP_ENAME_GROUP) {
> >>   		/* Make a new event name */
> >>   		if (symbol)
> >>   			snprintf(buf, MAX_EVENT_NAME_LEN, "%c_%s_%ld",
> >> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> >> index 80863c6..7fd50ab 100644
> >> --- a/kernel/trace/trace_probe.c
> >> +++ b/kernel/trace/trace_probe.c
> >> @@ -257,6 +257,9 @@ int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
> >>   	}
> >>   	len = strlen(event);
> >>   	if (len == 0) {
> >> +		if (slash)
> >> +			return TP_ENAME_GROUP;
> >> +
> >>   		trace_probe_log_err(offset, NO_EVENT_NAME);
> >>   		return -EINVAL;
> >>   	} else if (len > MAX_EVENT_NAME_LEN) {
> >> @@ -267,7 +270,11 @@ int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
> >>   		trace_probe_log_err(offset, BAD_EVENT_NAME);
> >>   		return -EINVAL;
> >>   	}
> >> -	return 0;
> >> +
> >> +	if (slash)
> >> +		return TP_ENAME_GROUP_EVENT;
> >> +
> >> +	return TP_ENAME_EVENT;
> >>   }
> >>   
> >>   #define PARAM_MAX_STACK (THREAD_SIZE / sizeof(unsigned long))
> >> diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> >> index 92cc149..d726769 100644
> >> --- a/kernel/trace/trace_probe.h
> >> +++ b/kernel/trace/trace_probe.h
> >> @@ -364,6 +364,10 @@ extern void traceprobe_free_probe_arg(struct probe_arg *arg);
> >>   extern int traceprobe_split_symbol_offset(char *symbol, long *offset);
> >>   int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
> >>   				char *buf, int offset);
> >> +#define TP_ENAME_GROUP_EVENT	0
> >> +#define TP_ENAME_EVENT		1
> >> +#define TP_ENAME_GROUP		2
> >> +#define TP_ENAME_EMPTTY		3
> >>   
> >>   enum probe_print_type {
> >>   	PROBE_PRINT_NORMAL,
> >> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> >> index 9711589..a935c08 100644
> >> --- a/kernel/trace/trace_uprobe.c
> >> +++ b/kernel/trace/trace_uprobe.c
> >> @@ -312,7 +312,8 @@ static bool trace_uprobe_match(const char *system, const char *event,
> >>   {
> >>   	struct trace_uprobe *tu = to_trace_uprobe(ev);
> >>   
> >> -	return strcmp(trace_probe_name(&tu->tp), event) == 0 &&
> >> +	return (event[0] == '\0' ||
> >> +		strcmp(trace_probe_name(&tu->tp), event) == 0) &&
> >>   	   (!system || strcmp(trace_probe_group_name(&tu->tp), system) == 0) &&
> >>   	   trace_uprobe_match_command_head(tu, argc, argv);
> >>   }
> >> @@ -532,7 +533,7 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
> >>   
> >>   /*
> >>    * Argument syntax:
> >> - *  - Add uprobe: p|r[:[GRP/]EVENT] PATH:OFFSET[%return][(REF)] [FETCHARGS]
> >> + *  - Add uprobe: p|r[:[GRP/][EVENT]] PATH:OFFSET[%return][(REF)] [FETCHARGS]
> >>    */
> >>   static int __trace_uprobe_create(int argc, const char **argv)
> >>   {
> >> @@ -540,6 +541,7 @@ static int __trace_uprobe_create(int argc, const char **argv)
> >>   	const char *event = NULL, *group = UPROBE_EVENT_SYSTEM;
> >>   	char *arg, *filename, *rctr, *rctr_end, *tmp;
> >>   	char buf[MAX_EVENT_NAME_LEN];
> >> +	char grp_buf[MAX_EVENT_NAME_LEN];
> >>   	enum probe_print_type ptype;
> >>   	struct path path;
> >>   	unsigned long offset, ref_ctr_offset;
> >> @@ -644,12 +646,14 @@ static int __trace_uprobe_create(int argc, const char **argv)
> >>   
> >>   	/* setup a probe */
> >>   	trace_probe_log_set_index(0);
> >> +	ret = TP_ENAME_EMPTTY;
> >>   	if (event) {
> >> -		ret = traceprobe_parse_event_name(&event, &group, buf,
> >> +		ret = traceprobe_parse_event_name(&event, &group, grp_buf,
> >>   						  event - argv[0]);
> >> -		if (ret)
> >> +		if (ret < 0)
> >>   			goto fail_address_parse;
> >> -	} else {
> >> +	}
> >> +	if (ret == TP_ENAME_EMPTTY || ret == TP_ENAME_GROUP) {
> >>   		char *tail;
> >>   		char *ptr;
> >>   


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
