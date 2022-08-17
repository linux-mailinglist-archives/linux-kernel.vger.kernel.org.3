Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91968596BF2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 11:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235000AbiHQJQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 05:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234886AbiHQJQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 05:16:07 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248B85B7BE
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 02:16:06 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id e13so16661872edj.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 02:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=aKw/DRCyj/07SyDef6siUO9Vwqh7Raw/IHd1zw4l5Lk=;
        b=lSr3eQVfo1QSHwiAH9hg++xLaAjpbJHTHxJsZORyEKmsn7YFC0M4a6r3OCo1iQbIRi
         MT6BdR7BfL6zYJIZQbRrLWEQmVnqnpduuNlN0RzK6obDYvLQmxoWNOolptqgVh+G4w33
         eWJZKWUMXRcOQJKm5FoUwRCpowOgayWKNDjbYofNenfsiWAo94KZWOhSR0d0s6WsHYsQ
         q2xppuRgnJJtK7BSsE5GwJExfT4g5STprN2wWkjV4U5VBuZar66ZnuY2SUJGxONGV5pm
         AtZoc8ITLlEavsU1ru/C0X4SWRGBMHyTr8cPWAPoXTDnrBBQgUGWBG6L1nBXPnWtS2sI
         ApEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=aKw/DRCyj/07SyDef6siUO9Vwqh7Raw/IHd1zw4l5Lk=;
        b=0P5kWUwFaR8F1tHoojHQzu2OC6/MdA73Bt36WOfMTEhWXcoBLGjZnfWLpW1o5jl+Zb
         vXB7XMsAWbJJV4jOo6qQHaJOd98ehKwNR26kB3Nj3v0XIvQHnzgWyBPDcs5eHnjY0gh7
         mQebR2eMHWCdQ3G6B5zvfbIrNjBd6LPwRpUkee8hKtu5rpuao00+deM+rPKELD+cLufq
         WBeyjylgE+kqOW3GODs6vWUR8Y/oOn6YtIssb/GWiOeqADTYS5vxIyONQV7Ny12VhDWY
         Pw6PWUY9JrsHgnmMgvX/LCPXts/uJuWTieGZ9OMnEKnPIGEMlhpsmXT4r2zuZsnyE1Lc
         O1qA==
X-Gm-Message-State: ACgBeo2zxYye5lHhu6ZFzopKUlBWMh3jFkfRiU9tnosdUYhkJOHrTjeW
        qfO/DGavU1sbNJwo7aA0UXc=
X-Google-Smtp-Source: AA6agR5bdieTfRpoHMDmqVFBdRtFhp3EAfrgZ+NbZcsI0+czg2Z9yQWIEuWd6WRLg0TBKVon3FyrMw==
X-Received: by 2002:a05:6402:350a:b0:43e:9d8:b75 with SMTP id b10-20020a056402350a00b0043e09d80b75mr22998042edd.23.1660727764532;
        Wed, 17 Aug 2022 02:16:04 -0700 (PDT)
Received: from krava ([83.240.61.33])
        by smtp.gmail.com with ESMTPSA id y26-20020a056402171a00b0043577da51f1sm10335851edu.81.2022.08.17.02.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 02:16:04 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 17 Aug 2022 11:16:02 +0200
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        David Reaver <me@davidreaver.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Krister Johansen <kjlx@templeofstupid.com>
Subject: Re: [PATCH] tracing/perf: Fix double put of trace event when init
 fails
Message-ID: <Yvyx0ouTDvsWTox6@krava>
References: <20220816192817.43d5e17f@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816192817.43d5e17f@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 07:28:17PM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> If in perf_trace_event_init(), the perf_trace_event_open() fails, then it
> will call perf_trace_event_unreg() which will not only unregister the perf
> trace event, but will also call the put() function of the tp_event.
> 
> The problem here is that the trace_event_try_get_ref() is called by the
> caller of perf_trace_event_init() and if perf_trace_event_init() returns a
> failure, it will then call trace_event_put(). But since the
> perf_trace_event_unreg() already called the trace_event_put() function, it
> triggers a WARN_ON().
> 
>  WARNING: CPU: 1 PID: 30309 at kernel/trace/trace_dynevent.c:46 trace_event_dyn_put_ref+0x15/0x20
> 
> If perf_trace_event_reg() does not call the trace_event_try_get_ref() then
> the perf_trace_event_unreg() should not be calling trace_event_put(). This
> breaks symmetry and causes bugs like these.
> 
> Pull out the trace_event_put() from perf_trace_event_unreg() and call it
> in the locations that perf_trace_event_unreg() is called. This not only
> fixes this bug, but also brings back the proper symmetry of the reg/unreg
> vs get/put logic.
> 
> Link: https://lore.kernel.org/all/cover.1660347763.git.kjlx@templeofstupid.com/
> 
> Reported-by: Krister Johansen <kjlx@templeofstupid.com>
> Reviewed-by: Krister Johansen <kjlx@templeofstupid.com>
> Tested-by: Krister Johansen <kjlx@templeofstupid.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

LGTM

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  kernel/trace/trace_event_perf.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
> index a114549720d6..61e3a2620fa3 100644
> --- a/kernel/trace/trace_event_perf.c
> +++ b/kernel/trace/trace_event_perf.c
> @@ -157,7 +157,7 @@ static void perf_trace_event_unreg(struct perf_event *p_event)
>  	int i;
>  
>  	if (--tp_event->perf_refcount > 0)
> -		goto out;
> +		return;
>  
>  	tp_event->class->reg(tp_event, TRACE_REG_PERF_UNREGISTER, NULL);
>  
> @@ -176,8 +176,6 @@ static void perf_trace_event_unreg(struct perf_event *p_event)
>  			perf_trace_buf[i] = NULL;
>  		}
>  	}
> -out:
> -	trace_event_put_ref(tp_event);
>  }
>  
>  static int perf_trace_event_open(struct perf_event *p_event)
> @@ -241,6 +239,7 @@ void perf_trace_destroy(struct perf_event *p_event)
>  	mutex_lock(&event_mutex);
>  	perf_trace_event_close(p_event);
>  	perf_trace_event_unreg(p_event);
> +	trace_event_put_ref(p_event->tp_event);
>  	mutex_unlock(&event_mutex);
>  }
>  
> @@ -292,6 +291,7 @@ void perf_kprobe_destroy(struct perf_event *p_event)
>  	mutex_lock(&event_mutex);
>  	perf_trace_event_close(p_event);
>  	perf_trace_event_unreg(p_event);
> +	trace_event_put_ref(p_event->tp_event);
>  	mutex_unlock(&event_mutex);
>  
>  	destroy_local_trace_kprobe(p_event->tp_event);
> @@ -347,6 +347,7 @@ void perf_uprobe_destroy(struct perf_event *p_event)
>  	mutex_lock(&event_mutex);
>  	perf_trace_event_close(p_event);
>  	perf_trace_event_unreg(p_event);
> +	trace_event_put_ref(p_event->tp_event);
>  	mutex_unlock(&event_mutex);
>  	destroy_local_trace_uprobe(p_event->tp_event);
>  }
> -- 
> 2.35.1
> 
