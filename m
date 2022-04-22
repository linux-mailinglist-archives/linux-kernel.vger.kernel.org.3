Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C52E50BBCB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449109AbiDVPnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449479AbiDVPln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:41:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247DC5AECC
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 08:38:49 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CF9391F745;
        Fri, 22 Apr 2022 15:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650641927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QWBm9KSaL64G4heSBDY5StN85oWFBXv4LEjPALb3118=;
        b=Pr3jiyHC7XSbaiUzSjGuFFjBeUkubKp5yAodSeHJX8dVABn45GJSEnV8B3CD25gtIAWEWY
        2thQgsVC45m8/e+bXE2tBPhmBntM76EwI8dr4mRd9DdbTGrQPD4uzz0CAyL9FBrYC2+CqA
        aJsURDkmtyYs7bbSfeiHdSuoLSKBa70=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 83B022C141;
        Fri, 22 Apr 2022 15:38:47 +0000 (UTC)
Date:   Fri, 22 Apr 2022 17:38:44 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Nico Pache <npache@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [RFC 3/3] exit: Check for MMF_OOM_SKIP in exit_mmap
Message-ID: <YmLMBDkHmcjf9Nem@dhcp22.suse.cz>
References: <20220421190533.1601879-1-npache@redhat.com>
 <20220421190533.1601879-4-npache@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421190533.1601879-4-npache@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 21-04-22 15:05:33, Nico Pache wrote:
> The MMF_OOM_SKIP bit is used to indicate weather a mm_struct can not be
> invalided or has already been invalided. exit_mmap currently calls
> __oom_reap_task_mm unconditionally despite the fact that the oom reaper
> may have already called this.
> 
> Add a check for the MMF_OOM_SKIP bit being set in exit_mmap to avoid
> unnessary calls to the invalidate code.

Why do we care about this?
 
> A slight race can occur on the MMF_OOM_SKIP bit that will still allow
> this to run twice. My testing has shown an ~66% decrease in double calls
> to _oom_reap_task_mm.
> 
> Fixes: 27ae357fa82b ("mm, oom: fix concurrent munlock and oom reaper unmap, v3")

I do not see this would be fixing anything.

> Cc: David Rientjes <rientjes@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  mm/mmap.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index a2968669fd4e..b867f408dacd 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -3113,7 +3113,8 @@ void exit_mmap(struct mm_struct *mm)
>  	/* mm's last user has gone, and its about to be pulled down */
>  	mmu_notifier_release(mm);
>  
> -	if (unlikely(mm_is_oom_victim(mm))) {
> +	if (unlikely(mm_is_oom_victim(mm)) &&
> +			!test_bit(MMF_OOM_SKIP, &mm->flags)) {
>  		/*
>  		 * Manually reap the mm to free as much memory as possible.
>  		 * Then, as the oom reaper does, set MMF_OOM_SKIP to disregard
> -- 
> 2.35.1

-- 
Michal Hocko
SUSE Labs
