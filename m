Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7125A1286
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 15:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241887AbiHYNls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 09:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241688AbiHYNln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 09:41:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDD7ABF21
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 06:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661434899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tB9lZlEpaTpauWX08ilgdGkVQfIwbOMu2sfyE552IJk=;
        b=g+nsqiwefLzEPyPNAAMEOYxIMkmKtUtvG2Bc542nFAdicLWX1uOq0IzVxIBwUmjcVH6dH5
        YbUldD+ee1YL1eFHN2QIef8a4WzGyD5RHeL7uTCvBddP8/6KowTTc9nE2drdiXrRS95Q3e
        WHMRYMlnXO/+BLopuYCrQTVut11xfYo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-9-w1r1YX8QMCOMmCZwGaRoOg-1; Thu, 25 Aug 2022 09:41:38 -0400
X-MC-Unique: w1r1YX8QMCOMmCZwGaRoOg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 23EB01C01B42;
        Thu, 25 Aug 2022 13:41:38 +0000 (UTC)
Received: from localhost (unknown [10.22.33.213])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 68DB21415117;
        Thu, 25 Aug 2022 13:41:37 +0000 (UTC)
Date:   Thu, 25 Aug 2022 10:41:36 -0300
From:   "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Anand Je Saipureddy <s.anandje1@gmail.com>,
        Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        cminyard@mvista.com, psiddaiah@mvista.com
Subject: Re: [PATCH] ftrace: Fix improper usage of __trace_stack() function.
Message-ID: <Ywd8EABDyMywfp7C@uudg.org>
References: <20220723064943.16532-1-s.anandje1@gmail.com>
 <YuooucgDVO0uDPS/@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuooucgDVO0uDPS/@linutronix.de>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 09:50:17AM +0200, Sebastian Andrzej Siewior wrote:
> On 2022-07-23 12:19:43 [+0530], Anand Je Saipureddy wrote:
> > In kernel/trace/trace_events_trigger.c --> stacktrace_trigger() -->
> > __trace_stack() is not defined as per the function definition.
> > 
> > With commit edbaaa13a660
> > ("tracing: Merge irqflags + preemt counter, add RT bits")
> > the irqflags(flags) and preemption counter(preempt_count()) are
> > now should be evaluated early by tracing_gen_ctx().
> > 
> > This patch replaces the irqflags and preemption counter
> > with tracing_gen_ctx().
> > 
> > Fixes: 5e8446e3820c ("tracing: Dump stacktrace trigger to the corresponding instance")
> > Signed-off-by: Anand Je Saipureddy <s.anandje1@gmail.com>
> > Reviewed-by: Corey Minyard <cminyard@mvista.com>
> 
> Please use [PATCH RT v5.10] in the future.
> Luis, could you please pick it up?

Added to the list.

And thank you for spotting this change, I missed that in my earlier sweep.

Luis
 
> > ---
> >  kernel/trace/trace_events_trigger.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
> > index 75fef9fcfd0f..3c6229f16e81 100644
> > --- a/kernel/trace/trace_events_trigger.c
> > +++ b/kernel/trace/trace_events_trigger.c
> > @@ -1220,12 +1220,10 @@ stacktrace_trigger(struct event_trigger_data *data, void *rec,
> >  		   struct ring_buffer_event *event)
> >  {
> >  	struct trace_event_file *file = data->private_data;
> > -	unsigned long flags;
> >  
> > -	if (file) {
> > -		local_save_flags(flags);
> > -		__trace_stack(file->tr, STACK_SKIP, preempt_count());
> > -	} else
> > +	if (file)
> > +		__trace_stack(file->tr, tracing_gen_ctx(), STACK_SKIP);
> > +	else
> >  		trace_dump_stack(STACK_SKIP);
> >  }
> >  
> 
> Sebastian
> 
---end quoted text---

