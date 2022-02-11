Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7AB4B2E9D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 21:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245499AbiBKUkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 15:40:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234402AbiBKUkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 15:40:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB20CF5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 12:40:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5795862071
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 20:40:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57468C340ED;
        Fri, 11 Feb 2022 20:40:07 +0000 (UTC)
Date:   Fri, 11 Feb 2022 15:40:05 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2] tracing: uninline trace_trigger_soft_disabled()
 partly
Message-ID: <20220211154005.01fd3c24@gandalf.local.home>
In-Reply-To: <69ce0986a52d026d381d612801d978aa4f977460.1644563295.git.christophe.leroy@csgroup.eu>
References: <69ce0986a52d026d381d612801d978aa4f977460.1644563295.git.christophe.leroy@csgroup.eu>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Feb 2022 08:10:18 +0100
Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index 70c069aef02c..dcea51fb60e2 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -699,6 +699,8 @@ event_triggers_post_call(struct trace_event_file *file,
>  
>  bool trace_event_ignore_this_pid(struct trace_event_file *trace_file);
>  
> +bool __trace_trigger_soft_disabled(struct trace_event_file *file);
> +
>  /**
>   * trace_trigger_soft_disabled - do triggers and test if soft disabled
>   * @file: The file pointer of the event to test
> @@ -708,20 +710,20 @@ bool trace_event_ignore_this_pid(struct trace_event_file *trace_file);
>   * triggers that require testing the fields, it will return true,
>   * otherwise false.
>   */
> -static inline bool
> +static __always_inline bool
>  trace_trigger_soft_disabled(struct trace_event_file *file)
>  {
>  	unsigned long eflags = file->flags;
>  
> -	if (!(eflags & EVENT_FILE_FL_TRIGGER_COND)) {
> -		if (eflags & EVENT_FILE_FL_TRIGGER_MODE)
> -			event_triggers_call(file, NULL, NULL, NULL);
> -		if (eflags & EVENT_FILE_FL_SOFT_DISABLED)
> -			return true;
> -		if (eflags & EVENT_FILE_FL_PID_FILTER)
> -			return trace_event_ignore_this_pid(file);
> -	}
> -	return false;
> +	if (likely(!(eflags & (EVENT_FILE_FL_TRIGGER_MODE |
> +			       EVENT_FILE_FL_SOFT_DISABLED |
> +			       EVENT_FILE_FL_PID_FILTER))))
> +		return false;
> +
> +	if (likely(eflags & EVENT_FILE_FL_TRIGGER_COND))
> +		return false;
> +
> +	return __trace_trigger_soft_disabled(file);
>  }
>  
>  #ifdef CONFIG_BPF_EVENTS
> diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
> index d00fee705f9c..55de490e25ca 100644
> --- a/kernel/trace/trace_events_trigger.c
> +++ b/kernel/trace/trace_events_trigger.c
> @@ -84,6 +84,20 @@ event_triggers_call(struct trace_event_file *file,
>  }
>  EXPORT_SYMBOL_GPL(event_triggers_call);
>  
> +bool __trace_trigger_soft_disabled(struct trace_event_file *file)
> +{
> +	unsigned long eflags = file->flags;
> +
> +	if (eflags & EVENT_FILE_FL_TRIGGER_MODE)
> +		event_triggers_call(file, NULL, NULL, NULL);
> +	if (eflags & EVENT_FILE_FL_SOFT_DISABLED)
> +		return true;
> +	if (eflags & EVENT_FILE_FL_PID_FILTER)
> +		return trace_event_ignore_this_pid(file);
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(__trace_trigger_soft_disabled);
> +
>  /**
>   * event_triggers_post_call - Call 'post_triggers' for a trace event
>   * @file: The trace_event_file associated with the event
> -- 


This version looks fine to me. I'll pull it into my queue.

Thanks!

-- Steve
