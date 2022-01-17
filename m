Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E04490BB4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 16:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240631AbiAQPp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 10:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237294AbiAQPpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 10:45:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D17BC061574;
        Mon, 17 Jan 2022 07:45:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFF0060F7B;
        Mon, 17 Jan 2022 15:45:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC600C36AE3;
        Mon, 17 Jan 2022 15:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642434322;
        bh=ZrsHLueOI+ttsq7qOy493FWcJzFDmy0BsQ72HyHD/gA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hO6wtFRisfgotJCwemuEgtiwPAW7Mtv1YbEx0ghbAjbDpgBOWZX5gefE9EfHrHyrW
         JdETd19FBTWgm6vh7J8L26mw+8X/FB0du27cz4htWdR0XibQMQ72Wn2nAH+x0wrGpq
         y7gSe27/5UqJHCesqrMTsm69hUxOyexRCsBwDhr7oc4tg5SjGcNmvaCjc7QfL5CcNh
         ZyHJw6th714Bg+N598nzm3Kiy8qUOE1pf+gvGyfnUU0UtlPhlcrdBSv+bNpG4Y1vNV
         y1efdGB0fvAQRxUnEzBpKlWiRXcT2ZfxYZvazrySBgAFTu8PMsME0oCcS2brJin1o3
         xqbjlTOlSV/7g==
Date:   Tue, 18 Jan 2022 00:45:17 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     rostedt@goodmis.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 01/12] user_events: Add minimal support for
 trace_event into ftrace
Message-Id: <20220118004517.b9dda3d98d6c5d6233ac8886@kernel.org>
In-Reply-To: <20220111172602.2513-2-beaub@linux.microsoft.com>
References: <20220111172602.2513-1-beaub@linux.microsoft.com>
        <20220111172602.2513-2-beaub@linux.microsoft.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Beau,

On Tue, 11 Jan 2022 09:25:51 -0800
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> +static int user_event_show(struct seq_file *m, struct dyn_event *ev)
> +{
> +	struct user_event *user = container_of(ev, struct user_event, devent);
> +	struct ftrace_event_field *field, *next;
> +	struct list_head *head;
> +	int depth = 0;
> +
> +	seq_printf(m, "%s%s", USER_EVENTS_PREFIX, EVENT_NAME(user));
> +
> +	head = trace_get_fields(&user->call);
> +
> +	list_for_each_entry_safe_reverse(field, next, head, link) {
> +		if (depth == 0)
> +			seq_puts(m, " ");
> +		else
> +			seq_puts(m, "; ");
> +		seq_printf(m, "%s %s", field->type, field->name);
> +		depth++;
> +	}
> +
> +	seq_puts(m, "\n");
> +
> +	return 0;
> +}

Let me confirm just one point. Your syntax supports

[__data_loc|__rel_loc] [unsigned] TYPE[\[LEN\]] NAME

or

struct TYPE NAME SIZE

for the fields, right? In that case, above seq_printf() seems not enough.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
