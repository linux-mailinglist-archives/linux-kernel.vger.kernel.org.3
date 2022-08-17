Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC1A596848
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 06:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbiHQErE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 00:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiHQErD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 00:47:03 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44785C349
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 21:47:00 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id E6AB4C1F27
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 04:46:59 +0000 (UTC)
Received: from pdx1-sub0-mail-a305.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 888FFC1A4A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 04:46:59 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1660711619; a=rsa-sha256;
        cv=none;
        b=iMgtFW/aXKgzgfYTooe4lZfgFPOGwmb/g5cmycK+N044xSNGJ3BxecHjZgLg0/EHOCwjeG
        4EK1SfTV0an+l5/JzmIdCQNX9ios3jdf98ygVCcq57vIGyY270/K3AXnvhxxOUJLZ5CGg3
        gQQJhb6QLMGqW9lfydH1sYo3McAUlpyWmB976Nxk5YsgcEbyiSzNTScWSmIdxMNdMd1DdU
        i8yauCz1wKhd2DExZ/X8PyGEP6uk7e7WxlzRwLsegWGwsCUt/lWE3LB1EJS9kxfUa5/h/V
        T/Z1GFCyj5VzHZw09SBzUEIf+Uf7Ns1hXATqekrMSOS/6SpDIfl4htsxajYRGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1660711619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=mroE+KXsWSEmzORe3MDtjQJYsSqbIB+AhsZ+mOVQ1dQ=;
        b=qVF4hc9wBHlxfjIzE223ZIdj8Vnw4wrIqBGekLJIgw0Mw/CcWo3Rt+i0v/+wQipsDvFQGL
        Kx8a6MPosWib8izSrSS5YgYWyemTHzdxu0INDfJk9fPN6sVtW5K0OVWoPxp2sDtwiLvld1
        BFBnchzb+hkIwv1UiB4PyecTthAlCrSa02AErVnnzemM+ov67v+IvxjuuSbd36lMcFEYF6
        K6XffE1hIXkCPq+k3/YZNUq8RfVwOUxYUNNQKj2Hm4R9aaz19YCcRYrBZY4GE753J8JpeZ
        e55fHtJaIVnpoc7bJst2SbbywaM+X2lzwRS3iiiWr+LC1B10lEOp6DXsnd4KXg==
ARC-Authentication-Results: i=1;
        rspamd-79b898d947-59cmw;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Shoe-Interest: 26af97ec75100d53_1660711619815_4134617977
X-MC-Loop-Signature: 1660711619814:1159361956
X-MC-Ingress-Time: 1660711619814
Received: from pdx1-sub0-mail-a305.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.115.45.17 (trex/6.7.1);
        Wed, 17 Aug 2022 04:46:59 +0000
Received: from kmjvbox (unknown [98.42.138.125])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a305.dreamhost.com (Postfix) with ESMTPSA id 4M6wTv1sN6zLr
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 21:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1660711619;
        bh=mroE+KXsWSEmzORe3MDtjQJYsSqbIB+AhsZ+mOVQ1dQ=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=SksjyNnNQiP2sb2Fkga6qaFUEQzyVmtoLipyT12uCbSv1kmtundT6Vwiq6MX8CMaA
         XXhzu2z/S6/w+eUJEm4AjqqNegO+BNirb0AK8W3hOFWXRLxweQikD6YSKPIOk8ZT4v
         b8SmaVt/nZ1SDTD4uscoby5r1bSfMmdal9z7YmPE=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e01ce
        by kmjvbox (DragonFly Mail Agent v0.12);
        Tue, 16 Aug 2022 21:46:56 -0700
Date:   Tue, 16 Aug 2022 21:46:56 -0700
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        David Reaver <me@davidreaver.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Krister Johansen <kjlx@templeofstupid.com>
Subject: Re: [PATCH] tracing/perf: Fix double put of trace event when init
 fails
Message-ID: <20220817044656.GA1941@templeofstupid.com>
References: <20220816192817.43d5e17f@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816192817.43d5e17f@gandalf.local.home>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
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

Thanks again, Steven.  Is this one that you would consider tagging for a
backport to stable at the appropriate time? I believe this one showed up
in 5.15, if it's any help.

-K

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
