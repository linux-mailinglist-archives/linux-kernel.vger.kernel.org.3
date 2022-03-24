Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D2F4E63A1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 13:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350284AbiCXMtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 08:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348082AbiCXMtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 08:49:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BAF1706B
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 05:48:08 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 104721F38D;
        Thu, 24 Mar 2022 12:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648126087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RZFZbU8/BFv8cQIZC+9vsb4XWhGG+bKWjfDosNjQ5xE=;
        b=B6AJ0IGRXT4l/HplX0DZi1h/a99xZIqgEuavpgdJQfQo0n/inB474mBZ8vzkII5UttqMta
        adtTv0jhTWLl+sMiBsvr8lpkbwXe7BFD8SEV4Nnwy7AKeiaJNDV0PZSvwwFOF6RgUyQipk
        lCUPEvWu3RcArO4osrmzrZCb5b58qbE=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C9A1EA3B89;
        Thu, 24 Mar 2022 12:48:06 +0000 (UTC)
Date:   Thu, 24 Mar 2022 13:48:05 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     akpm@linux-foundation.org, minchan@kernel.org, surenb@google.com,
        vbabka@suse.cz, rientjes@google.com, nadav.amit@gmail.com,
        edgararriaga@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Revert "mm: madvise: skip unmapped vma holes passed
 to process_madvise"
Message-ID: <Yjxoha4PLlKjEayl@dhcp22.suse.cz>
References: <cover.1648046642.git.quic_charante@quicinc.com>
 <e73da1304a88b6a8a11907045117cccf4c2b8374.1648046642.git.quic_charante@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e73da1304a88b6a8a11907045117cccf4c2b8374.1648046642.git.quic_charante@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 23-03-22 20:54:09, Charan Teja Kalla wrote:
> This reverts commit 08095d6310a7 ("mm: madvise: skip unmapped vma holes
> passed to process_madvise") as process_madvise() fails to return exact
> processed bytes at other cases too. As an example: if the
> process_madvise() hits mlocked pages after processing some initial bytes
> passed in [start, end), it just returns EINVAL though some bytes are
> processed. Thus making an exception only for ENOMEM is partially fixing
> the problem of returning the proper advised bytes.
> 
> Thus revert this patch and return proper bytes advised, if there any,
> for all the error types in the following patch.

I do agree with the revert. I am not sure the above really is a proper
justification though. 08095d6310a7 was changing one (arguably) dubious
semantic by another one without a proper justification and wider
consensus which I would expect from a patch which changes an existing
semantic. Not to mention it being marked for stable tree.

But let's not nit pick on that now. Let's send this revert ASAP and use
some more time to discuss the semantic and whether any change is really
required.

> Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/madvise.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 39b712f..0d8fd17 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1433,16 +1433,9 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
>  
>  	while (iov_iter_count(&iter)) {
>  		iovec = iov_iter_iovec(&iter);
> -		/*
> -		 * do_madvise returns ENOMEM if unmapped holes are present
> -		 * in the passed VMA. process_madvise() is expected to skip
> -		 * unmapped holes passed to it in the 'struct iovec' list
> -		 * and not fail because of them. Thus treat -ENOMEM return
> -		 * from do_madvise as valid and continue processing.
> -		 */
>  		ret = do_madvise(mm, (unsigned long)iovec.iov_base,
>  					iovec.iov_len, behavior);
> -		if (ret < 0 && ret != -ENOMEM)
> +		if (ret < 0)
>  			break;
>  		iov_iter_advance(&iter, iovec.iov_len);
>  	}
> -- 
> 2.7.4

-- 
Michal Hocko
SUSE Labs
