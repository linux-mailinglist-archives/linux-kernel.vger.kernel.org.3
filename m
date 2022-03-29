Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F804EA44A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 02:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbiC2Atk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 20:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbiC2Ati (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 20:49:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8BF5DA38;
        Mon, 28 Mar 2022 17:47:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1801561164;
        Tue, 29 Mar 2022 00:47:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD68C340ED;
        Tue, 29 Mar 2022 00:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648514876;
        bh=BKnu8DUA2y+6Kbiw5robtBIkuWg5LXzEkLZAz8RKWxo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=olKHu3jJwMu1BlmQgRIlM1AID3PcI/gjuhiNaHOxNgukc6fPNmGme9LB3lBlujtTK
         lrJ1KO01+soKHHfWhklxZjOdq4T3GMfZnZko3Vey/mFjHQOvY//mTsizVATCMp86u8
         IjajlnDs3K6hBrbVU7wBAQpOXwg/s800C98b4F0OaL1qtPqlRGSpoi/XZBRWta8wqo
         kTi5WKnVvNFX46GXtIiwF+mwOB1R3mDnApleWmLi8AxZ+IXgyg2VAqj6HBQUui2OBl
         8mltIgtFZYyRvjBr8jigFK8Dv2AMzIVS+v7mP6k2hjd4l9JLhcWg4cV/2QVLA19d6L
         Zv+AFC/1+kt7g==
Date:   Tue, 29 Mar 2022 09:47:52 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/user_events: Hold event_mutex during
 dyn_event_add
Message-Id: <20220329094752.d0950054058846197f573349@kernel.org>
In-Reply-To: <20220328223225.1992-1-beaub@linux.microsoft.com>
References: <20220328223225.1992-1-beaub@linux.microsoft.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Mar 2022 15:32:25 -0700
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> Make sure the event_mutex is properly held during dyn_event_add call.
> This is required when adding dynamic events.
> 

Good catch!

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> Reported-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
> ---
>  kernel/trace/trace_events_user.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> index 8b3d241a31c2..61d78d64bdf0 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -1165,11 +1165,11 @@ static int user_event_parse(char *name, char *args, char *flags,
>  #endif
>  
>  	mutex_lock(&event_mutex);
> +
>  	ret = user_event_trace_register(user);
> -	mutex_unlock(&event_mutex);
>  
>  	if (ret)
> -		goto put_user;
> +		goto put_user_lock;
>  
>  	user->index = index;
>  
> @@ -1181,8 +1181,12 @@ static int user_event_parse(char *name, char *args, char *flags,
>  	set_bit(user->index, page_bitmap);
>  	hash_add(register_table, &user->node, key);
>  
> +	mutex_unlock(&event_mutex);
> +
>  	*newuser = user;
>  	return 0;
> +put_user_lock:
> +	mutex_unlock(&event_mutex);
>  put_user:
>  	user_event_destroy_fields(user);
>  	user_event_destroy_validators(user);
> 
> base-commit: c87857e214862a125208a4b1a510839d0c5a1bd4
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
