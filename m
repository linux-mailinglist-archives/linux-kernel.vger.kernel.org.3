Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71B54C306D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235754AbiBXPz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236618AbiBXPz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:55:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3778217C438
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:55:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5A2E61764
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 15:55:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA1E0C340EC;
        Thu, 24 Feb 2022 15:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645718126;
        bh=QqinqAC468TSKHfPVewQtZrGPuE4gy2uDC9DJz44xt4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N40eyeImIMne6IsvOpWskvHDWp/1aSFrqsLQecfhnOdC/G5/IU/UeavX9JBh9mau5
         U49HHzDmkCsiSX1yA4/Tjm1CPaV8Q0DDjnnvV2LUUIM5ssEQhlbEcpFAC2nQU1/yM1
         PQ9plYsKFK7LOPPheOG+RcWz7jFNZPWxUPHp2j60rkRs6OlzQCw6OtjlW0SWOw5oUd
         SIgY1raFUrHwTlokFJ3PSpBxWbkW1T/TYq5eiFtkR8w9trxvNydX//RWr/ghkaqC1T
         hn01CWJh8yu0Qym3jeCul7R1ESY6Vm6u2TaMZST6ZvQnYi//ILROLDYtLAqoLSrl5I
         Z14BSX/QFF6xQ==
Date:   Fri, 25 Feb 2022 00:55:20 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        keescook@chromium.org, samitolvanen@google.com,
        mark.rutland@arm.com, alyssa.milburn@intel.com, mbenes@suse.cz,
        rostedt@goodmis.org, mhiramat@kernel.org,
        alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 12/39] x86/ibt,ftrace: Search for __fentry__ location
Message-Id: <20220225005520.c69be2fbdbd28028361792d9@kernel.org>
In-Reply-To: <20220224151322.714815604@infradead.org>
References: <20220224145138.952963315@infradead.org>
        <20220224151322.714815604@infradead.org>
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

Hi Peter,

On Thu, 24 Feb 2022 15:51:50 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> Have ftrace_location() search the symbol for the __fentry__ location
> when it isn't at func+0 and use this for {,un}register_ftrace_direct().
> 
> This avoids a whole bunch of assumptions about __fentry__ being at
> func+0.
> 
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/trace/ftrace.c |   30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -1578,7 +1578,24 @@ unsigned long ftrace_location_range(unsi
>   */
>  unsigned long ftrace_location(unsigned long ip)
>  {
> -	return ftrace_location_range(ip, ip);
> +	struct dyn_ftrace *rec;
> +	unsigned long offset;
> +	unsigned long size;
> +
> +	rec = lookup_rec(ip, ip);
> +	if (!rec) {
> +		if (!kallsyms_lookup_size_offset(ip, &size, &offset))
> +			goto out;
> +
> +		if (!offset)

Isn't this 'if (offset)' ?

> +			rec = lookup_rec(ip - offset, (ip - offset) + size);
> +	}
> +
> +	if (rec)
> +		return rec->ip;
> +
> +out:
> +	return 0;
>  }

Thank you,

>  
>  /**
> @@ -5110,11 +5127,16 @@ int register_ftrace_direct(unsigned long
>  	struct ftrace_func_entry *entry;
>  	struct ftrace_hash *free_hash = NULL;
>  	struct dyn_ftrace *rec;
> -	int ret = -EBUSY;
> +	int ret = -ENODEV;
>  
>  	mutex_lock(&direct_mutex);
>  
> +	ip = ftrace_location(ip);
> +	if (!ip)
> +		goto out_unlock;
> +
>  	/* See if there's a direct function at @ip already */
> +	ret = -EBUSY;
>  	if (ftrace_find_rec_direct(ip))
>  		goto out_unlock;
>  
> @@ -5222,6 +5244,10 @@ int unregister_ftrace_direct(unsigned lo
>  
>  	mutex_lock(&direct_mutex);
>  
> +	ip = ftrace_location(ip);
> +	if (!ip)
> +		goto out_unlock;
> +
>  	entry = find_direct_entry(&ip, NULL);
>  	if (!entry)
>  		goto out_unlock;
> 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
