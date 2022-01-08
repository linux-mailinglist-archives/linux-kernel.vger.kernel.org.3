Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9E0488148
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 05:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbiAHEL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 23:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiAHEL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 23:11:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE49C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 20:11:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB604B82627
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jan 2022 04:11:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D97C36AE0;
        Sat,  8 Jan 2022 04:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641615083;
        bh=bvv7IG6N5bla8LAh3U7RUkbm19iWwxkuYVm+JG2rdTU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PS7hv/vpxpVZpJ5xTPm409/sjhvOHUwsqfsVjZd3Fb54rg/Nh+xxRqUHrSFbVDTOx
         CTIXg3ODTZz/HDrpVP9X1bFuNMJiieqjj98eu0kqeFGws/si7k9zbXHnndZBr0re6G
         CUmuRp+2TQqFRvllLz4d3iqJJvP5jWgmUOFeZAEdoQvEbEQBG04++LSWVmdjsO8lQU
         Yy+cW/5QZ3CVwBhHT7LHUudgWYxLL3euAgemgZyWPIxFnjHF8wVaPGAZeQWi9tg6rx
         1tnUJs4ytTgQ8LfCm9jeuR35bEiNK9NvQ7IxCOCFBum3jJuiBeH5iSWbeU6gDqJmMD
         eD2sQTEQt3/rg==
Date:   Sat, 8 Jan 2022 13:11:18 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Xiangyang Zhang <xyz.sun.ok@gmail.com>
Cc:     rostedt@goodmis.org, mingo@redhat.com, mhiramat@kernel.org,
        oleg@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing/kprobes: 'nmissed' not showed correctly for
 kretprobe
Message-Id: <20220108131118.ed2d82a8a51ed1562676077c@kernel.org>
In-Reply-To: <20220107150242.5019-1-xyz.sun.ok@gmail.com>
References: <20220107150242.5019-1-xyz.sun.ok@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  7 Jan 2022 23:02:42 +0800
Xiangyang Zhang <xyz.sun.ok@gmail.com> wrote:

> The 'nmissed' column of the 'kprobe_profile' file for kretprobe is
> not showed correctly, kretprobe can be skipped by two reasons,
> shortage of kretprobe_instance which is counted by tk->rp.nmissed,
> and kprobe itself is missed by some reason, so to show the sum.
> 

Thanks! This looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

> Fixes: 4a846b443b4e ("tracing/kprobes: Cleanup kprobe tracer code")
> Signed-off-by: Xiangyang Zhang <xyz.sun.ok@gmail.com>
> ---
>  kernel/trace/trace_kprobe.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index f8c26ee72de3..3d85323278ed 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -1170,15 +1170,18 @@ static int probes_profile_seq_show(struct seq_file *m, void *v)
>  {
>  	struct dyn_event *ev = v;
>  	struct trace_kprobe *tk;
> +	unsigned long nmissed;
>  
>  	if (!is_trace_kprobe(ev))
>  		return 0;
>  
>  	tk = to_trace_kprobe(ev);
> +	nmissed = trace_kprobe_is_return(tk) ?
> +		tk->rp.kp.nmissed + tk->rp.nmissed : tk->rp.kp.nmissed;
>  	seq_printf(m, "  %-44s %15lu %15lu\n",
>  		   trace_probe_name(&tk->tp),
>  		   trace_kprobe_nhit(tk),
> -		   tk->rp.kp.nmissed);
> +		   nmissed);
>  
>  	return 0;
>  }
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
