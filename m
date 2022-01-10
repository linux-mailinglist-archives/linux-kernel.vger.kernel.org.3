Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B47E488ECB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 03:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238271AbiAJC6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 21:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbiAJC6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 21:58:18 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F73C06173F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 18:58:17 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id pf13so3566164pjb.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jan 2022 18:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Nmuj7MIDwgoOGJm4MOvfdxvCuI0aP+O+tFfALmcyPb4=;
        b=YZ+4n0lRUb2IfC7UgFP2dWU8p+V4mBPsCfxOTCAAWOqLiilavHPALajesv/61JjV7+
         uns6GCD10Tekn8qNXQbwRIiwd0in9M0zdATwCz7pQp3XmSOGKwUfQCW0LJwZXLNMPNY+
         H9wRa7eqO6tZbQi6u/gR7hry7V+C+ke1ApLtd6TNebB91VxS8RA6xepNk60/7RSliARd
         s/8hIAYkS+sNm2dnKZR0uRYbuI3cBLBINn3NwkYRWoiv0yrWX3DnABfZDuZLMMUCEr17
         lJT6WFYM3lH4cVosVQLYiXmvWloc8pS6MwC7TuBysmxGXm8/glL9NvA15bRvurGq5tEK
         kTrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Nmuj7MIDwgoOGJm4MOvfdxvCuI0aP+O+tFfALmcyPb4=;
        b=vm6LpAGXOuyQFLil2gKFgXdvHSsagPwKIUhZIaMM8P7jITTNrNZ9cG5FiYqfX9mY3P
         Df/ZKxfQyYRyrUbCuP0x4yUnFv6g3zbE6fOUm5H0MWeG5a8LCHFmyTgQm5N3RnF3R9XR
         tkqbEojGKs26nc1UzbWK4rY6VFZOqKug5o2frC1gGwiQKeruaWWr+94UkTMIxhK1jceE
         IJ64YHzbK5nZUhlwwM51YnNhXvs1mIOW0z7fsifMgp3juvgTxgkzxc7zcgL44noYPAVx
         gBq/r5lAHmFvXdiL1UjaXDUD27YCRainADLwYL+oQ00LIckEx5nKsI7sVtmctnnPJ68z
         nSIg==
X-Gm-Message-State: AOAM532t7ax+hy39vpHaEs27YR1GWDvDf899ODDR0MLbMmipIHuCwQjo
        K2PIdaWVQk2JzR6d4IzrOg==
X-Google-Smtp-Source: ABdhPJwvsM8cPqe4BHhM468QXu3qh+n8oYgqc4Jj4+kqYiACaQUOC/nTdWgLu1KoZ51BwM170g+7DA==
X-Received: by 2002:a17:90b:2487:: with SMTP id nt7mr27562379pjb.39.1641783497330;
        Sun, 09 Jan 2022 18:58:17 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id nv2sm7673091pjb.12.2022.01.09.18.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 18:58:16 -0800 (PST)
Date:   Mon, 10 Jan 2022 10:58:10 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 1/3] tracing/filter: degrade addr in filter_pred_string()
 from double pointer to pointer
Message-ID: <Ydugwh5IW+1JYsnE@piliu.users.ipa.redhat.com>
References: <20220107044951.22080-1-kernelfans@gmail.com>
 <20220107044951.22080-2-kernelfans@gmail.com>
 <20220107121842.70c7651b@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107121842.70c7651b@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 12:18:42PM -0500, Steven Rostedt wrote:
> On Fri,  7 Jan 2022 12:49:49 +0800
> Pingfan Liu <kernelfans@gmail.com> wrote:
> 
> > Since FILTER_PTR_STRING has the type of "char *", it is meaningless to
> > convert it to "char **". Hence degrading addr from double pointer to
> > single.
> > 
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > To: linux-kernel@vger.kernel.org
> > ---
> >  kernel/trace/trace_events_filter.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
> > index c9124038b140..264456e1698f 100644
> > --- a/kernel/trace/trace_events_filter.c
> > +++ b/kernel/trace/trace_events_filter.c
> > @@ -670,11 +670,11 @@ static int filter_pred_string(struct filter_pred *pred, void *event)
> >  /* Filter predicate for char * pointers */
> >  static int filter_pred_pchar(struct filter_pred *pred, void *event)
> >  {
> > -	char **addr = (char **)(event + pred->offset);
> > +	char *addr = (char *)(event + pred->offset);
> 
> This doesn't look right. The address of the pointer should be in the event.
> "event" is an address to the content of the event in the kernel ring buffer.
> 
> 	event + pred->offset
> 
> Is then the address of position of the event.
> 
> Let's say we have an event record at 0xffff8000, and the pred->offset is at
> 0x10. And the pointer to the string (in user space) is at 0x70008000.
> 
> 0xffff8000:  <heade>
> 0xffff8010: 0x70008000
> 
> 0x70008000: "user space sting"
> 
> event + pred->offset gives us 0xffff8010
> 
> If we now have that as char *addr, then addr is 0xffff8010
> 
> 
> >  	int cmp, match;
> > -	int len = strlen(*addr) + 1;	/* including tailing '\0' */
> > +	int len = strlen(addr) + 1;	/* including tailing '\0' */
> 
> This would give us the addr = 0xffff8010, which is not where the string
> exists.
> 
> How would this work?
> 
No, it can not work.


Thanks,

	Pingfan
