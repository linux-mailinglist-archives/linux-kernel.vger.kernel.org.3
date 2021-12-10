Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E7746F95F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 03:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236071AbhLJCyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 21:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhLJCyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 21:54:23 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DDEC061746;
        Thu,  9 Dec 2021 18:50:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D2C25CE2990;
        Fri, 10 Dec 2021 02:50:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDFBCC004DD;
        Fri, 10 Dec 2021 02:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639104645;
        bh=p1MVXm5rcwcPGjiBQBmXfjmi70oSih/kX9P4dxQZmUY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eNZMWb6KMET0ifhBX9KsXgI5K8EQXrVL/dj5K0sUcw4ObwCwBd4LM66BeeUJFxumk
         vP3pGSfle5UfyEG76lWsayVDqpQmtD/LXm2rgjo56Z5G+sXOdDIzKFfWhpVuDG3ZlX
         sjheyt3kiVxPMTu5qrrWb0ceo5nO2DZskSwjb3vaKQS+O/QeebKI36zOg2fbmf+Ns4
         pgC4Z6EkSJheI4ojbyqj9viQeeQ/JagmDELCi2gYgfxxMP37fhyM0+rICy1FlJOvrN
         H6UzC8jjyoYXl6HfGENXsfMvRqlUUaLx4NcZH985kRbY11qiuMcJy0YQO01KJcIVaL
         otQdsX7yXhmBg==
Date:   Fri, 10 Dec 2021 11:50:41 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     rostedt@goodmis.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 03/13] user_events: Add print_fmt generation support
 for basic types
Message-Id: <20211210115041.02aeb300333639cc12ffef56@kernel.org>
In-Reply-To: <20211209223210.1818-4-beaub@linux.microsoft.com>
References: <20211209223210.1818-1-beaub@linux.microsoft.com>
        <20211209223210.1818-4-beaub@linux.microsoft.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  9 Dec 2021 14:32:00 -0800
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> Addes print_fmt format generation for basic types that are supported for
> user processes. Only supports sizes that are the same on 32 and 64 bit.
> 

This looks good to me.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
> ---
>  kernel/trace/trace_events_user.c | 107 ++++++++++++++++++++++++++++++-
>  1 file changed, 105 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> index 1d96d1c85147..bd8ac46fddb1 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -357,6 +357,106 @@ static int user_event_parse_fields(struct user_event *user, char *args)
>  
>  static struct trace_event_fields user_event_fields_array[1];
>  
> +static const char *user_field_format(const char *type)
> +{
> +	if (strcmp(type, "s64") == 0)
> +		return "%lld";
> +	if (strcmp(type, "u64") == 0)
> +		return "%llu";
> +	if (strcmp(type, "s32") == 0)
> +		return "%d";
> +	if (strcmp(type, "u32") == 0)
> +		return "%u";
> +	if (strcmp(type, "int") == 0)
> +		return "%d";
> +	if (strcmp(type, "unsigned int") == 0)
> +		return "%u";
> +	if (strcmp(type, "s16") == 0)
> +		return "%d";
> +	if (strcmp(type, "u16") == 0)
> +		return "%u";
> +	if (strcmp(type, "short") == 0)
> +		return "%d";
> +	if (strcmp(type, "unsigned short") == 0)
> +		return "%u";
> +	if (strcmp(type, "s8") == 0)
> +		return "%d";
> +	if (strcmp(type, "u8") == 0)
> +		return "%u";
> +	if (strcmp(type, "char") == 0)
> +		return "%d";
> +	if (strcmp(type, "unsigned char") == 0)
> +		return "%u";
> +	if (strstr(type, "char[") != 0)
> +		return "%s";
> +
> +	/* Unknown, likely struct, allowed treat as 64-bit */
> +	return "%llu";
> +}
> +
> +static bool user_field_is_dyn_string(const char *type)
> +{
> +	if (str_has_prefix(type, "__data_loc ") ||
> +	    str_has_prefix(type, "__rel_loc "))
> +		if (strstr(type, "char[") != 0)
> +			return true;
> +
> +	return false;
> +}
> +
> +#define LEN_OR_ZERO (len ? len - pos : 0)
> +static int user_event_set_print_fmt(struct user_event *user, char *buf, int len)
> +{
> +	struct ftrace_event_field *field, *next;
> +	struct list_head *head = &user->fields;
> +	int pos = 0, depth = 0;
> +
> +	pos += snprintf(buf + pos, LEN_OR_ZERO, "\"");
> +
> +	list_for_each_entry_safe_reverse(field, next, head, link) {
> +		if (depth != 0)
> +			pos += snprintf(buf + pos, LEN_OR_ZERO, " ");
> +
> +		pos += snprintf(buf + pos, LEN_OR_ZERO, "%s=%s",
> +				field->name, user_field_format(field->type));
> +
> +		depth++;
> +	}
> +
> +	pos += snprintf(buf + pos, LEN_OR_ZERO, "\"");
> +
> +	list_for_each_entry_safe_reverse(field, next, head, link) {
> +		if (user_field_is_dyn_string(field->type))
> +			pos += snprintf(buf + pos, LEN_OR_ZERO,
> +					", __get_str(%s)", field->name);
> +		else
> +			pos += snprintf(buf + pos, LEN_OR_ZERO,
> +					", REC->%s", field->name);
> +	}
> +
> +	return pos + 1;
> +}
> +#undef LEN_OR_ZERO
> +
> +static int user_event_create_print_fmt(struct user_event *user)
> +{
> +	char *print_fmt;
> +	int len;
> +
> +	len = user_event_set_print_fmt(user, NULL, 0);
> +
> +	print_fmt = kmalloc(len, GFP_KERNEL);
> +
> +	if (!print_fmt)
> +		return -ENOMEM;
> +
> +	user_event_set_print_fmt(user, print_fmt, len);
> +
> +	user->call.print_fmt = print_fmt;
> +
> +	return 0;
> +}
> +
>  static enum print_line_t user_event_print_trace(struct trace_iterator *iter,
>  						int flags,
>  						struct trace_event *event)
> @@ -390,6 +490,7 @@ static int destroy_user_event(struct user_event *user)
>  	clear_bit(user->index, page_bitmap);
>  	hash_del(&user->node);
>  
> +	kfree(user->call.print_fmt);
>  	kfree(EVENT_NAME(user));
>  	kfree(user);
>  
> @@ -669,8 +770,10 @@ static int user_event_parse(char *name, char *args, char *flags,
>  	if (ret)
>  		goto put_user;
>  
> -	/* Minimal print format */
> -	user->call.print_fmt = "\"\"";
> +	ret = user_event_create_print_fmt(user);
> +
> +	if (ret)
> +		goto put_user;
>  
>  	user->call.data = user;
>  	user->call.class = &user->class;
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
