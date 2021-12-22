Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9A647CA43
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 01:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbhLVAah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 19:30:37 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34388 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhLVAag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 19:30:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0E12B81A3E;
        Wed, 22 Dec 2021 00:30:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA12C36AE8;
        Wed, 22 Dec 2021 00:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640133034;
        bh=siEz4Odgo34We7Rr54J5KTPPI/uHxWxvBw43IYjr3BI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lpePbb5l6Hf0iqfW3+i0CDv939M7uofBeLmX1QZVun9D6rBftXjOKVhsTQ3+O/zUJ
         S+0V7jsygoCLoyjaxOiY7iEoEbYWNT/QVM5j3Go1200GaHeUwtgNALR+YqZOZijN0i
         O9bFbUuWFyDeW8jBUddC1c2/hQC3D/8cDSXSzuNQ9x/mzqHkCjx2I/zDDeGILpEkp/
         kcnhmV92mqvAOPN8O2qDQ51O+N7ns5zxZNIAXm8bympJ5U8Sb/pk/T67ICkoshmwDP
         kOTBT0rby9B5hvsYvehqOChvBDnbTq6u1QNMjwuqNfSOzG8zzxGLQGEmFm3UOrHIQG
         wTVWLWce0MNBg==
Date:   Wed, 22 Dec 2021 09:30:30 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     rostedt@goodmis.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 02/12] user_events: Add print_fmt generation support
 for basic types
Message-Id: <20211222093030.ea1f358f05a965c435592539@kernel.org>
In-Reply-To: <20211216173511.10390-3-beaub@linux.microsoft.com>
References: <20211216173511.10390-1-beaub@linux.microsoft.com>
        <20211216173511.10390-3-beaub@linux.microsoft.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2021 09:35:01 -0800
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> Addes print_fmt format generation for basic types that are supported for
> user processes. Only supports sizes that are the same on 32 and 64 bit.

Is the last sentence for user_events itself, or only limiting the
print_fmt but user_events supports it?

The code looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> 
> Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
> ---
>  kernel/trace/trace_events_user.c | 115 ++++++++++++++++++++++++++++++-
>  1 file changed, 113 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> index 0a1b6496b9c3..67a92fe04ee4 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -358,6 +358,114 @@ static int user_event_parse_fields(struct user_event *user, char *args)
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
> +static bool user_field_is_dyn_string(const char *type, const char **str_func)
> +{
> +	if (str_has_prefix(type, "__data_loc ")) {
> +		*str_func = "__get_str";
> +		goto check;
> +	}
> +
> +	if (str_has_prefix(type, "__rel_loc ")) {
> +		*str_func = "__get_rel_str";
> +		goto check;
> +	}
> +
> +	return false;
> +check:
> +	return strstr(type, "char") != 0;
> +}
> +
> +#define LEN_OR_ZERO (len ? len - pos : 0)
> +static int user_event_set_print_fmt(struct user_event *user, char *buf, int len)
> +{
> +	struct ftrace_event_field *field, *next;
> +	struct list_head *head = &user->fields;
> +	int pos = 0, depth = 0;
> +	const char *str_func;
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
> +		if (user_field_is_dyn_string(field->type, &str_func))
> +			pos += snprintf(buf + pos, LEN_OR_ZERO,
> +					", %s(%s)", str_func, field->name);
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
> @@ -391,6 +499,7 @@ static int destroy_user_event(struct user_event *user)
>  	clear_bit(user->index, page_bitmap);
>  	hash_del(&user->node);
>  
> +	kfree(user->call.print_fmt);
>  	kfree(EVENT_NAME(user));
>  	kfree(user);
>  
> @@ -663,8 +772,10 @@ static int user_event_parse(char *name, char *args, char *flags,
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
