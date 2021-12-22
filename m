Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7DB47CCEA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 07:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242711AbhLVGTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 01:19:08 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58060 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239194AbhLVGTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 01:19:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C612617ED;
        Wed, 22 Dec 2021 06:19:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEDA7C36AE5;
        Wed, 22 Dec 2021 06:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640153945;
        bh=65f6JNJUvwYkpc7/Bin5Gcj202L1+CT+xBwLwJGAbXc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PGlZ2GwwSJl/Dr2EeNqSqe+zGnsnKAstgz1tLTTDp0whbXSKNQ30p71BSIP7kCIex
         7+j90Qt/wOXWdjWFuxzJfHP1/xzklikvbpIKLzhtQqFBBQ5wrLGP6nGBhxtD7nVtcU
         NUxkTsulcIt1jK1Js19Ttmjg/wLFNbIs4Byem9OYlRVLnyAEYznAhYy5wR3yYF7KZY
         OR40Fn5EbPTRfjhHw6lWWq6d1V2cltaN9lT9XyzgD+qUmPzJorQHzCQ3l+2KNR1/P/
         yK5HgEWBNKJV8wKDw3PAbR6bZV968QJLjnNx1WoVtSDklxE3iGuKVqi2hyNZ7VYWEm
         +myg1SCempc7g==
Date:   Wed, 22 Dec 2021 15:19:02 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     rostedt@goodmis.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 03/12] user_events: Handle matching arguments from
 dyn_events
Message-Id: <20211222151902.f932b280d09cc8bce9304b30@kernel.org>
In-Reply-To: <20211216173511.10390-4-beaub@linux.microsoft.com>
References: <20211216173511.10390-1-beaub@linux.microsoft.com>
        <20211216173511.10390-4-beaub@linux.microsoft.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2021 09:35:02 -0800
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> Ensures that when dynamic events requests a match with arguments that
> they match what is in the user_event.
> 

Looks good to me.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
> ---
>  kernel/trace/trace_events_user.c | 77 +++++++++++++++++++++++++++++++-
>  1 file changed, 76 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> index 67a92fe04ee4..9859e62b9838 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -39,6 +39,7 @@
>  #define MAX_EVENT_DESC 512
>  #define EVENT_NAME(user_event) ((user_event)->tracepoint.name)
>  #define MAX_FIELD_ARRAY_SIZE 1024
> +#define MAX_FIELD_ARG_NAME 256
>  
>  static char *register_page_data;
>  
> @@ -694,13 +695,87 @@ static int user_event_free(struct dyn_event *ev)
>  	return destroy_user_event(user);
>  }
>  
> +static bool user_field_match(struct ftrace_event_field *field, int argc,
> +			     const char **argv, int *iout)
> +{
> +	char *field_name, *arg_name;
> +	int len, pos, i = *iout;
> +	bool colon = false, match = false;
> +
> +	if (i >= argc)
> +		return false;
> +
> +	len = MAX_FIELD_ARG_NAME;
> +	field_name = kmalloc(len, GFP_KERNEL);
> +	arg_name = kmalloc(len, GFP_KERNEL);
> +
> +	if (!arg_name || !field_name)
> +		goto out;
> +
> +	pos = 0;
> +
> +	for (; i < argc; ++i) {
> +		if (i != *iout)
> +			pos += snprintf(arg_name + pos, len - pos, " ");
> +
> +		pos += snprintf(arg_name + pos, len - pos, argv[i]);
> +
> +		if (strchr(argv[i], ';')) {
> +			++i;
> +			colon = true;
> +			break;
> +		}
> +	}
> +
> +	pos = 0;
> +
> +	pos += snprintf(field_name + pos, len - pos, field->type);
> +	pos += snprintf(field_name + pos, len - pos, " ");
> +	pos += snprintf(field_name + pos, len - pos, field->name);
> +
> +	if (colon)
> +		pos += snprintf(field_name + pos, len - pos, ";");
> +
> +	*iout = i;
> +
> +	match = strcmp(arg_name, field_name) == 0;
> +out:
> +	kfree(arg_name);
> +	kfree(field_name);
> +
> +	return match;
> +}
> +
> +static bool user_fields_match(struct user_event *user, int argc,
> +			      const char **argv)
> +{
> +	struct ftrace_event_field *field, *next;
> +	struct list_head *head = &user->fields;
> +	int i = 0;
> +
> +	list_for_each_entry_safe_reverse(field, next, head, link)
> +		if (!user_field_match(field, argc, argv, &i))
> +			return false;
> +
> +	if (i != argc)
> +		return false;
> +
> +	return true;
> +}
> +
>  static bool user_event_match(const char *system, const char *event,
>  			     int argc, const char **argv, struct dyn_event *ev)
>  {
>  	struct user_event *user = container_of(ev, struct user_event, devent);
> +	bool match;
>  
> -	return strcmp(EVENT_NAME(user), event) == 0 &&
> +	match = strcmp(EVENT_NAME(user), event) == 0 &&
>  		(!system || strcmp(system, USER_EVENTS_SYSTEM) == 0);
> +
> +	if (match && argc > 0)
> +		match = user_fields_match(user, argc, argv);
> +
> +	return match;
>  }
>  
>  static struct dyn_event_operations user_event_dops = {
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
