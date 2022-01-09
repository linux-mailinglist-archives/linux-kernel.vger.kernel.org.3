Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBD2488A21
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 16:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbiAIPQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 10:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiAIPQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 10:16:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86EFC06173F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 07:16:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6397C60E75
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 15:16:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21724C36AED;
        Sun,  9 Jan 2022 15:16:13 +0000 (UTC)
Date:   Sun, 9 Jan 2022 10:16:11 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yuntao Wang <ytcoode@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Remove duplicate warnings
Message-ID: <20220109101611.73da76d9@rorschach.local.home>
In-Reply-To: <20220109134858.306061-1-ytcoode@gmail.com>
References: <20220109134858.306061-1-ytcoode@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  9 Jan 2022 21:48:58 +0800
Yuntao Wang <ytcoode@gmail.com> wrote:

> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 92be9cb1d7d4..d7da46df16c5 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -3462,7 +3462,6 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
>  	entry = trace_create_file("enable", TRACE_MODE_WRITE, d_events,
>  				  tr, &ftrace_tr_enable_fops);
>  	if (!entry) {
> -		pr_warn("Could not create tracefs 'enable' entry\n");
>  		return -ENOMEM;
>  	}

If it is becoming a simple condition then you don't need the braces.

	if (!entry)
		return -ENOMEM;

-- Steve
