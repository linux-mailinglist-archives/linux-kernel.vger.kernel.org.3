Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9084562F8F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 11:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiGAJLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 05:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiGAJLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 05:11:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5653135F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 02:11:49 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 21EFB1FE71;
        Fri,  1 Jul 2022 09:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1656666708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z9s5FZeGET+deD7tCKqILkii9H9D1VtEzg8q219OLSw=;
        b=nT+HI+YXYni9Me1HwvrCBLE/lPG10RTfHFDQLwvB/Uc5AhhJcN0jU/rX7wRqWGH1kCKX6J
        biDVePL2Tvh+h/084zUbOOyt8GGcBQ4y8iQ2SLczQG890XnQ+jFF2IlhXqHJmS1xyk4Lct
        +yzJeqz2H6CHzjuJcLklDVJUA3BHhiQ=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EFC772C141;
        Fri,  1 Jul 2022 09:11:46 +0000 (UTC)
Date:   Fri, 1 Jul 2022 11:11:46 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     cgel.zte@gmail.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, vbabka@suse.cz, minchan@kernel.org,
        oleksandr@redhat.com, xu xin <xu.xin16@zte.com.cn>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH linux-next] mm/madvise: allow KSM hints for
 process_madvise
Message-ID: <Yr66Uhcv+XAPYPwj@dhcp22.suse.cz>
References: <20220701084323.1261361-1-xu.xin16@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701084323.1261361-1-xu.xin16@zte.com.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc Jann]

On Fri 01-07-22 08:43:23, cgel.zte@gmail.com wrote:
> From: xu xin <xu.xin16@zte.com.cn>
> 
> The benefits of doing this are obvious because using madvise in user code
> is the only current way to enable KSM, which is inconvenient for those
> compiled app without marking MERGEABLE wanting to enable KSM.

I would rephrase:
"
KSM functionality is currently available only to processes which are
using MADV_MERGEABLE directly. This is limiting because there are
usecases which will benefit from enabling KSM on a remote process. One
example would be an application which cannot be modified (e.g. because
it is only distributed as a binary). MORE EXAMPLES WOULD BE REALLY
BENEFICIAL.
"

> Since we already have the syscall of process_madvise(), then reusing the
> interface to allow external KSM hints is more acceptable [1].
> 
> Although this patch was released by Oleksandr Natalenko, but it was
> unfortunately terminated without any conclusions because there was debate
> on whether it should use signal_pending() to check the target task besides
> the task of current() when calling unmerge_ksm_pages of other task [2].

I am not sure this is particularly interesting. I do not remember
details of that discussion but checking signal_pending on a different
task is rarely the right thing to do. In this case the check is meant to
allow bailing out from the operation so that the caller could be
terminated for example.

> I think it's unneeded to check the target task. For example, when we set
> the klob /sys/kernel/mm/ksm/run from 1 to 2,
> unmerge_and_remove_all_rmap_items() doesn't use signal_pending() to check
> all other target tasks either.
> 
> I hope this patch can get attention again.

One thing that the changelog is missing and it is quite important IMHO
is the permission model. As we have discussed in previous incarnations
of the remote KSM functionality that KSM has some security implications.
It would be really great to refer to that in the changelog for the
future reference (http://lkml.kernel.org/r/CAG48ez0riS60zcA9CC9rUDV=kLS0326Rr23OKv1_RHaTkOOj7A@mail.gmail.com)

So this implementation requires PTRACE_MODE_READ_FSCREDS and
CAP_SYS_NICE so the remote process would need to be allowed to
introspect the address space. This is the same constrain applied to the
remote momory reclaim. Is this sufficient?

I would say yes because to some degree KSM mergning can have very
similar effect to memory reclaim from the side channel POV. But it
should be really documented in the changelog so that it is clear that
this has been a deliberate decision and thought through.

Other than that this looks like the most reasonable approach to me.

> [1] https://lore.kernel.org/lkml/YoOrdh85+AqJH8w1@dhcp22.suse.cz/
> [2] https://lore.kernel.org/lkml/2a66abd8-4103-f11b-06d1-07762667eee6@suse.cz/
> 
> Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> ---
>  mm/madvise.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 851fa4e134bc..df915531ad9f 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1173,6 +1173,10 @@ process_madvise_behavior_valid(int behavior)
>  	case MADV_COLD:
>  	case MADV_PAGEOUT:
>  	case MADV_WILLNEED:
> +#ifdef CONFIG_KSM
> +	case MADV_MERGEABLE:
> +	case MADV_UNMERGEABLE:
> +#endif
>  		return true;
>  	default:
>  		return false;
> -- 
> 2.25.1

-- 
Michal Hocko
SUSE Labs
