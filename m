Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF7E48E000
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 22:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236301AbiAMV6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 16:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbiAMV6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 16:58:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225FEC061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 13:58:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0AB2B822C8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 21:58:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38428C36AE3;
        Thu, 13 Jan 2022 21:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642111118;
        bh=fvJjT8tvooCZLW7hRAzPYYagFNBEQaCwtqOS9vG6ws0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=oC3ZFWniDyymw+N0lNIzQdymKVopt1ZZiuKg/Wj5elYyhcbQoQJipwWzfa3nNevhw
         +5hZYDxkcWMziawX+pq3fY/HEd5wx0VTfgymHjLSow87oUMB3thHpGwb+wOIoMwt5B
         KPbka/Spvnjgz6CINZOxl0fS49bHxOR0GpbGfAT+frBRP0D5HpEI4hhjCgQRWzHrjK
         fVeReaM1KZnYUodRsgp0FOlJbMZjDO9eGTOwjDlGaYPwpqn5bOCBPOed3Z+xxnnYEw
         0uyBUQ2aizYHGAXSZPgJWg3sPaici4itMCxaPm8iQE0b2XbF2/7EWuy8uQ4xmPkwBb
         US1nLq1hdqlvw==
Message-ID: <6cd817c8de439d62741aef3cb2c0914801f0f962.camel@kernel.org>
Subject: Re: [for-next][PATCH 05/31] tracing: Have existing
 event_command.parse() implementations use helpers
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Date:   Thu, 13 Jan 2022 15:58:36 -0600
In-Reply-To: <20220113162058.04731caf@gandalf.local.home>
References: <20220111173030.999527342@goodmis.org>
         <20220111173114.155260134@goodmis.org>
         <388b9922-4231-6e34-1305-f0b439d9d07c@kernel.org>
         <20220113162058.04731caf@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Thu, 2022-01-13 at 16:20 -0500, Steven Rostedt wrote:
> On Thu, 13 Jan 2022 18:03:07 +0100
> Daniel Bristot de Oliveira <bristot@kernel.org> wrote:
> 
> > I did some debug, and found that the histogram is working. The
> > problem is that,
> > to read the histogram I pause it to have consistent data:
> > 
> > in tools/tracing/rtla/osnoise_hist.c:
> > osnoise_read_trace_hist() {
> >  [...]
> >         tracefs_hist_pause(tool->trace.inst, data->trace_hist);
> > 
> >         content = tracefs_event_file_read(tool->trace.inst,
> > "osnoise",
> >                                           "sample_threshold",
> >                                           "hist", NULL);
> >  [...]
> > }
> > 
> > and, as far as I got, after this patch, pausing the histogram makes
> > it to clear
> > up. If I comment the "tracefs_hist_pause" line, "rtla osnoise hist"
> > start
> > working back again.
> > 
> > Thoughts?
> 
> This is all messed up. I'm removing this patch completely.
> 
> Tom, can you fix this. The issue is that it's putting too much policy
> into
> the helper functions, which is big no no.
> 
> Specifically, we have:
> 
> int event_trigger_register(struct event_command *cmd_ops,
> 			   struct trace_event_file *file,
> 			   char *glob,
> 			   char *cmd,
> 			   char *param,
> 			   struct event_trigger_data *trigger_data,
> 			   int *n_registered)
> {
> 	int ret;
> 
> 	if (n_registered)
> 		*n_registered = 0;
> 
> 	ret = cmd_ops->reg(glob, trigger_data, file);
> 	/*
> 	 * The above returns on success the # of functions enabled,
> 	 * but if it didn't find any functions it returns zero.
> 	 * Consider no functions a failure too.
> 	 */
> 	if (!ret) {
> 		cmd_ops->unreg(glob, trigger_data, file);
> 		ret = -ENOENT;
> 	} else if (ret > 0) {
> 		if (n_registered)
> 			*n_registered = ret;
> 		/* Just return zero, not the number of enabled
> functions */
> 		ret = 0;
> 	}
> 
> 	return ret;
> }
> 
> 
> And in the case of pause, this *will* have ret = 0 on return. And
> what
> happens is that it removes the trigger completely.
> 
> Look at the code in the histogram on the return:
> 
> 	ret = event_trigger_register(cmd_ops, file, glob, cmd, param,
> trigger_data, &n_registered);
> 	if (ret < 0)
> 		goto out_free;
> 	if ((ret == 0) && (n_registered == 0)) {
> 		if (!(attrs->pause || attrs->cont || attrs->clear))
> 			ret = -ENOENT;
> 		goto out_free;
> 	}
> 
> It checks for 0 and 0 and only errors if it's not pause, cont, or
> clear.
> Hence, all three are now broken due to this patch.
> 
> I will not be adding this to this merge window.

Yes, you're right, event_trigger_register() is trying to do a little
too much, and shouldn't be doing the unreg().

Thanks for finding and figuring that out.  I'll fix this and send a new
version after the merge window.

Tom

> 
> -- Steve

