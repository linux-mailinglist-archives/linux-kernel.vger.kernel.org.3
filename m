Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4DE48616C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 09:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236649AbiAFI0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 03:26:23 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:40304 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236625AbiAFI0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 03:26:21 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 31CE1210E0;
        Thu,  6 Jan 2022 08:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641457580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TaS15hKNImv77BLTo2w18nJ0SBPyj1jpl2iJCZPWpys=;
        b=gV/Mmv1/1LFSm9fEvRKVXNVbXiCC+Pv2pf1YUkFM2f+kZ4GO/mFoAnQg3+s/4n0lCOZ4ha
        Hv5Rlt20LnWaUuEG2eB8j074D4IxmLi+mcYdtb6wHd+lINk6Rb5oupwz6aLvuH7KZUa0wU
        2Q3H1rD+7OEwWFLfoBdDyHkYeoDyVRg=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E6B42A3B81;
        Thu,  6 Jan 2022 08:26:19 +0000 (UTC)
Date:   Thu, 6 Jan 2022 09:26:18 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] mm, oom: OOM sysrq should always kill a process
Message-ID: <Ydanqi1u7OKh56r4@dhcp22.suse.cz>
References: <20220105175115.605074-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105175115.605074-1-jannh@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 05-01-22 18:51:15, Jann Horn wrote:
> The OOM kill sysrq (alt+sysrq+F) should allow the user to kill the
> process with the highest OOM badness with a single execution.
> 
> However, at the moment, the OOM kill can bail out if an OOM notifier
> (e.g. the i915 one) says that it reclaimed a tiny amount of memory
> from somewhere. That's probably not what the user wants.
> 
> As documented in struct oom_control, order == -1 means the oom kill is
> required by sysrq. So check for that, and if it's true, don't bail out
> no matter what the OOM notifiers say.

I agree that it is suboptimal to disable sysrq+f because of notfiers
because the OOM invocation is not a direct result of the OOM situation
but rather an admin will. We already kill a new task even if an oom
victim is still pending.

> Signed-off-by: Jann Horn <jannh@google.com>

with a minor update as below
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/oom_kill.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 1ddabefcfb5a..dc645cbc6e0d 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -1051,13 +1051,14 @@ EXPORT_SYMBOL_GPL(unregister_oom_notifier);
>  bool out_of_memory(struct oom_control *oc)
>  {
>  	unsigned long freed = 0;
> +	bool sysrq_forced = oc->order == -1;
>  
>  	if (oom_killer_disabled)
>  		return false;
>  
>  	if (!is_memcg_oom(oc)) {
>  		blocking_notifier_call_chain(&oom_notify_list, 0, &freed);
> -		if (freed > 0)
> +		if (freed > 0 && !sysrq_forced)
>  			/* Got some memory back in the last second. */
>  			return true;
>  	}

is_sysrq_oom(oc) is a more appropriate way to check this.

> 
> base-commit: c9e6606c7fe92b50a02ce51dda82586ebdf99b48
> -- 
> 2.34.1.448.ga2b2bfdf31-goog

-- 
Michal Hocko
SUSE Labs
