Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3DE4644D7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 03:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345986AbhLACYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 21:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345957AbhLACY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 21:24:28 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DA6C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 18:21:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6B3A1CE1C91
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 02:21:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E4AC53FC7;
        Wed,  1 Dec 2021 02:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638325264;
        bh=mFH6sIyHA75mLSDgtt90j3Sz8X0d1OlU5XUa9IzV+5c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=k5vZxltVEwUvVG4hc6utquWGrrGdE0JT4PmQMG+ch78C3tDSuzQDiNjJs3kYcYHaU
         DVDqlgYSNWy2zmVYHt+60G+tEbGLhuMfJ7YDX0tlL/HSoFkaIuy0Oe/N47xLPtKyr2
         On088TNYyeZT7xHTdpynZzTzfn4vrlnEty/7rYBpmbbDz0Z3EwMU985Ob4TIFtTJ7X
         q5ae/4jtgFNuEqMK8jUBXkGXuVoSn1ubauPn/wpEjCWNN0P6qIT0ohRoMlmIAF8czi
         l9em36GrPDFkh+i9UkmtDdHeaGJaSNEDOOtk9+kMDt4d10ElAFB49UOREbOjGzucDv
         12e7EMJXg0fEA==
Date:   Wed, 1 Dec 2021 11:21:00 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH] tracing/histograms: String compares should not care
 about signed values
Message-Id: <20211201112100.23d4caafd8319e15073a41ed@kernel.org>
In-Reply-To: <20211130123736.7c3cab27@gandalf.local.home>
References: <20211130123736.7c3cab27@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Nov 2021 12:37:36 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From 95f7262b44dc54fed8007cc3db8b39cbd16999c6 Mon Sep 17 00:00:00 2001
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> Date: Tue, 30 Nov 2021 12:31:23 -0500
> Subject: [PATCH] tracing/histograms: String compares should not care about
>  signed values
> 
> When comparing two strings for the "onmatch" histogram trigger, fields
> that are strings use string comparisons, which do not care about being
> signed or not.
> 
> Do not fail to match two string fields if one is unsigned char array and
> the other is a signed char array.
> 
> Link: https://lore.kernel.org/all/20211129123043.5cfd687a@gandalf.local.home/

Looks good to me.

Review-by: Masami Hiramatsu <mhiramatsu@kernel.org>

Thank you,

> 
> Cc: stable@vgerk.kernel.org
> Cc: Tom Zanussi <zanussi@kernel.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Yafang Shao <laoar.shao@gmail.com>
> Fixes: b05e89ae7cf3b ("tracing: Accept different type for synthetic event fields")
> Reported-by: Sven Schnelle <svens@linux.ibm.com>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_events_hist.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 9555b8e1d1e3..319f9c8ca7e7 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -3757,7 +3757,7 @@ static int check_synth_field(struct synth_event *event,
>  
>  	if (strcmp(field->type, hist_field->type) != 0) {
>  		if (field->size != hist_field->size ||
> -		    field->is_signed != hist_field->is_signed)
> +		    (!field->is_string && field->is_signed != hist_field->is_signed))
>  			return -EINVAL;
>  	}
>  
> -- 
> 2.31.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
