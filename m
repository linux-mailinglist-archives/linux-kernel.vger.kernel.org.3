Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C9E48DF85
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 22:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234812AbiAMVVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 16:21:03 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:37898 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbiAMVVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 16:21:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC95261770
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 21:21:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE38C36AE3;
        Thu, 13 Jan 2022 21:21:00 +0000 (UTC)
Date:   Thu, 13 Jan 2022 16:20:58 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [for-next][PATCH 05/31] tracing: Have existing
 event_command.parse() implementations use helpers
Message-ID: <20220113162058.04731caf@gandalf.local.home>
In-Reply-To: <388b9922-4231-6e34-1305-f0b439d9d07c@kernel.org>
References: <20220111173030.999527342@goodmis.org>
        <20220111173114.155260134@goodmis.org>
        <388b9922-4231-6e34-1305-f0b439d9d07c@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jan 2022 18:03:07 +0100
Daniel Bristot de Oliveira <bristot@kernel.org> wrote:

> I did some debug, and found that the histogram is working. The problem is that,
> to read the histogram I pause it to have consistent data:
> 
> in tools/tracing/rtla/osnoise_hist.c:
> osnoise_read_trace_hist() {
>  [...]
>         tracefs_hist_pause(tool->trace.inst, data->trace_hist);
> 
>         content = tracefs_event_file_read(tool->trace.inst, "osnoise",
>                                           "sample_threshold",
>                                           "hist", NULL);
>  [...]
> }
> 
> and, as far as I got, after this patch, pausing the histogram makes it to clear
> up. If I comment the "tracefs_hist_pause" line, "rtla osnoise hist" start
> working back again.
> 
> Thoughts?

This is all messed up. I'm removing this patch completely.

Tom, can you fix this. The issue is that it's putting too much policy into
the helper functions, which is big no no.

Specifically, we have:

int event_trigger_register(struct event_command *cmd_ops,
			   struct trace_event_file *file,
			   char *glob,
			   char *cmd,
			   char *param,
			   struct event_trigger_data *trigger_data,
			   int *n_registered)
{
	int ret;

	if (n_registered)
		*n_registered = 0;

	ret = cmd_ops->reg(glob, trigger_data, file);
	/*
	 * The above returns on success the # of functions enabled,
	 * but if it didn't find any functions it returns zero.
	 * Consider no functions a failure too.
	 */
	if (!ret) {
		cmd_ops->unreg(glob, trigger_data, file);
		ret = -ENOENT;
	} else if (ret > 0) {
		if (n_registered)
			*n_registered = ret;
		/* Just return zero, not the number of enabled functions */
		ret = 0;
	}

	return ret;
}


And in the case of pause, this *will* have ret = 0 on return. And what
happens is that it removes the trigger completely.

Look at the code in the histogram on the return:

	ret = event_trigger_register(cmd_ops, file, glob, cmd, param, trigger_data, &n_registered);
	if (ret < 0)
		goto out_free;
	if ((ret == 0) && (n_registered == 0)) {
		if (!(attrs->pause || attrs->cont || attrs->clear))
			ret = -ENOENT;
		goto out_free;
	}

It checks for 0 and 0 and only errors if it's not pause, cont, or clear.
Hence, all three are now broken due to this patch.

I will not be adding this to this merge window.

-- Steve
