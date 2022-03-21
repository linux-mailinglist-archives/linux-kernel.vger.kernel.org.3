Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9A34E2343
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 10:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345863AbiCUJ0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 05:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345757AbiCUJ0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:26:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B85F5E151
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 02:25:05 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 184421F37C;
        Mon, 21 Mar 2022 09:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647854704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=96Bv5aE8PEDXaSGILYsP0oGMBpkf8E19n9UPqtaGhf4=;
        b=TGa08Icyse5ulErUKT8NFKM+p66QbjQEqgQxwvMzfMpDCS/2EEBcyxzdPFTgiljsRhQ6TV
        /c/DBmAUlhRaqfkymCVTb9cAECpSrnFoPPIoANuXl+XwvrwT7eEdyTo+fZZT4Iye6Tznn3
        Jz8B6eFq7T9xX3VAOszflAaUGdo7tjk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647854704;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=96Bv5aE8PEDXaSGILYsP0oGMBpkf8E19n9UPqtaGhf4=;
        b=mVmI29Mpp3hGzjFT8RY3go45dcii+E3rtP6pXpuYu+HycgyZq38V+E7jYvqMc37b41drD+
        0sIl14R1xNmaFrAA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BCF05A3B87;
        Mon, 21 Mar 2022 09:25:03 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3F9ABA0610; Mon, 21 Mar 2022 10:25:03 +0100 (CET)
Date:   Mon, 21 Mar 2022 10:25:03 +0100
From:   Jan Kara <jack@suse.cz>
To:     Bixuan Cui <cuibixuan@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, yi.zhang@huawei.com, jack@suse.cz
Subject: Re: [PATCH -next] jbd2: use the correct print format
Message-ID: <20220321092503.liyi6eqrar52cc5n@quack3.lan>
References: <1647619000-17758-1-git-send-email-cuibixuan@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1647619000-17758-1-git-send-email-cuibixuan@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 18-03-22 23:56:40, Bixuan Cui wrote:
> The print format error was found when using ftrace event:
>     <...>-1406 [000] .... 23599442.895823: jbd2_end_commit: dev 252,8 transaction -1866216965 sync 0 head -1866217368
>     <...>-1406 [000] .... 23599442.896299: jbd2_start_commit: dev 252,8 transaction -1866216964 sync 0
> 
> Print transaction and head with the unsigned format "%u" instead.
> 
> Fixes: 879c5e6b7cb4 ('jbd2: convert instrumentation from markers to tracepoints')
> Signed-off-by: Bixuan Cui <cuibixuan@linux.alibaba.com>

Makes sense. Thanks for the fix. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/trace/events/jbd2.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/trace/events/jbd2.h b/include/trace/events/jbd2.h
> index a4dfe005983d..5be1aa1691fb 100644
> --- a/include/trace/events/jbd2.h
> +++ b/include/trace/events/jbd2.h
> @@ -40,7 +40,7 @@ DECLARE_EVENT_CLASS(jbd2_commit,
>  	TP_STRUCT__entry(
>  		__field(	dev_t,	dev			)
>  		__field(	char,	sync_commit		  )
> -		__field(	int,	transaction		  )
> +		__field(	tid_t,	transaction		  )
>  	),
>  
>  	TP_fast_assign(
> @@ -49,7 +49,7 @@ DECLARE_EVENT_CLASS(jbd2_commit,
>  		__entry->transaction	= commit_transaction->t_tid;
>  	),
>  
> -	TP_printk("dev %d,%d transaction %d sync %d",
> +	TP_printk("dev %d,%d transaction %u sync %d",
>  		  MAJOR(__entry->dev), MINOR(__entry->dev),
>  		  __entry->transaction, __entry->sync_commit)
>  );
> @@ -97,8 +97,8 @@ TRACE_EVENT(jbd2_end_commit,
>  	TP_STRUCT__entry(
>  		__field(	dev_t,	dev			)
>  		__field(	char,	sync_commit		  )
> -		__field(	int,	transaction		  )
> -		__field(	int,	head		  	  )
> +		__field(	tid_t,	transaction		  )
> +		__field(	tid_t,	head		  	  )
>  	),
>  
>  	TP_fast_assign(
> @@ -108,7 +108,7 @@ TRACE_EVENT(jbd2_end_commit,
>  		__entry->head		= journal->j_tail_sequence;
>  	),
>  
> -	TP_printk("dev %d,%d transaction %d sync %d head %d",
> +	TP_printk("dev %d,%d transaction %u sync %d head %u",
>  		  MAJOR(__entry->dev), MINOR(__entry->dev),
>  		  __entry->transaction, __entry->sync_commit, __entry->head)
>  );
> -- 
> 2.19.1.6.gb485710b
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
