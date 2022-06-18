Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF2D5501BF
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 03:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383496AbiFRBtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 21:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236052AbiFRBtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 21:49:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB7766CA6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 18:49:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D23AEB82C0B
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 01:49:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC361C3411B;
        Sat, 18 Jun 2022 01:49:43 +0000 (UTC)
Date:   Fri, 17 Jun 2022 21:49:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linyu Yuan <quic_linyyuan@quicinc.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/3] tracing: eprobe: remove duplicate is_good_name()
 operation
Message-ID: <20220617214942.1dbfb55b@gandalf.local.home>
In-Reply-To: <1655168698-19898-2-git-send-email-quic_linyyuan@quicinc.com>
References: <1655168698-19898-1-git-send-email-quic_linyyuan@quicinc.com>
        <1655168698-19898-2-git-send-email-quic_linyyuan@quicinc.com>
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

On Tue, 14 Jun 2022 09:04:56 +0800
Linyu Yuan <quic_linyyuan@quicinc.com> wrote:

> traceprobe_parse_event_name() already validate group and event name,
> there is no need to call is_good_name() after it.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Linyu Yuan <quic_linyyuan@quicinc.com>
> ---
> v2: drop v1 change as it is NACK.
>     add it to remove duplicate is_good_name().
> v3: move it as first patch.
> v4: no change
> v5: add Acked-by tag
> 
>  kernel/trace/trace_eprobe.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
> index 7d44785..17d64e3 100644
> --- a/kernel/trace/trace_eprobe.c
> +++ b/kernel/trace/trace_eprobe.c
> @@ -878,16 +878,12 @@ static int __trace_eprobe_create(int argc, const char *argv[])
>  		sanitize_event_name(buf1);
>  		event = buf1;
>  	}
> -	if (!is_good_name(event) || !is_good_name(group))
> -		goto parse_error;
>  

Tom replied that the above may be an issue. You ignored his response.

-- Steve


>  	sys_event = argv[1];
>  	ret = traceprobe_parse_event_name(&sys_event, &sys_name, buf2,
>  					  sys_event - argv[1]);
>  	if (ret || !sys_name)
>  		goto parse_error;
> -	if (!is_good_name(sys_event) || !is_good_name(sys_name))
> -		goto parse_error;
>  
>  	mutex_lock(&event_mutex);
>  	event_call = find_and_get_event(sys_name, sys_event);

