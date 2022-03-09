Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7889F4D35F3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236671AbiCIRBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 12:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235892AbiCIRBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 12:01:02 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F44E10612C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 08:48:02 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id kx6-20020a17090b228600b001bf859159bfso5831695pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 08:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SfXNkkolcMJPwDp63yf81XujFSDo95hIeJu326GhdWQ=;
        b=RC0q0OcBEQu9ASG61IkTDmrNlwYTQDX300E7BWFYleWgmnmkyhz/MpJGbJULr1sh07
         9Ha7BXxmneFsYSP/mR/gV+L9lXhtm9WOQ8XtVPRPS+epm3qPdqRu1qbKGILDHxpRoRva
         crxiZpmDWDgq6+3UJvjFhWpK9OH7Ke4mGcFVxy0a579gwCrc7Ifd6GL/9vwBc6YruqVI
         baQzqQvGyS+P7IMYrYdhP0owXMy++OQkmxh/ky24V6gXXG2rXEFjXfFI7QbZjevVxjDb
         g+Qm0N1Mr4u43+neLiKGsu5OBbaUc7VlR02k86o6kDWu41wxAQq2T4O10m5O+JOkt31P
         Aolw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=SfXNkkolcMJPwDp63yf81XujFSDo95hIeJu326GhdWQ=;
        b=2Ej021RsPpjFXTiC9SFWSN+QPnl2TEpOs/f4V6cNt5/etAk4LWpdKRdFp90uKMtsja
         5ARvFqHuuW9yVp0PLmu/iztsx4s4UJ0ZKdU/9KJ6TwfDZZ67ffCDtI6GCVJP1TNIYzxq
         olSgMpEFXYtwjSOHJ/5XnWHchDgmwFrLkT4e2Gci06xwPaDBf67GnooySkklYILH6z4I
         CuliQgSR3sjD+sXZ731FKp5xHpMXp6IhJYUHcO/7KQ1YA2gzJ0W9yR/PuJ2dfn3pZ+W3
         avMWPdH30M7AXR0Uk8dqmjBuYF5qJxH48No649p/ue9jJ7fKxi15jWbrV6Mu8DM5hm1J
         M8vw==
X-Gm-Message-State: AOAM533UoDIcZsNPURpXqn7bC90LIG57Gag+rjpdrIuCOnlvZ3K737sX
        /DjtYHj5qKvqVLRyuTVw/gW14YpCyZY=
X-Google-Smtp-Source: ABdhPJwrS2OvbPW4zE7Gt+E9g6pb4AjJcfenCjjwXCZjVXEQ/MT81h7EtQe22hOGM83go1+bt0AMbg==
X-Received: by 2002:a17:902:7b8d:b0:14f:1aca:d95e with SMTP id w13-20020a1709027b8d00b0014f1acad95emr556596pll.122.1646844481703;
        Wed, 09 Mar 2022 08:48:01 -0800 (PST)
Received: from google.com ([2620:15c:211:201:aee3:831e:b1d0:905f])
        by smtp.gmail.com with ESMTPSA id b10-20020a056a000cca00b004f6f6dd8287sm3807826pfv.18.2022.03.09.08.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 08:48:01 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 9 Mar 2022 08:47:59 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     akpm@linux-foundation.org, yuehaibing@huawei.com,
        sfr@canb.auug.org.au, rientjes@google.com, edgararriaga@google.com,
        mhocko@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: madvise: return correct bytes advised with
 process_madvise
Message-ID: <YijaP7cC6Sclxc29@google.com>
References: <1646803679-11433-1-git-send-email-quic_charante@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646803679-11433-1-git-send-email-quic_charante@quicinc.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 10:57:59AM +0530, Charan Teja Kalla wrote:
> The process_madvise() system call returns error even after processing
> some VMA's passed in the 'struct iovec' vector list which leaves the
> user confused to know where to restart the advise next. It is also
> against this syscall man page[1] documentation where it mentions that
> "return value may be less than the total number of requested bytes, if
> an error occurred after some iovec elements were already processed.".
> 
> Consider a user passed 10 VMA's in the 'struct iovec' vector list of
> which 9 are processed but one. Then it just returns the error caused on
> that failed VMA despite the first 9 VMA's processed, leaving the user
> confused about on which VMA it is failed. Returning the number of bytes
> processed here can help the user to know which VMA it is failed on and
> thus can retry/skip the advise on that VMA.
> 
> [1]https://man7.org/linux/man-pages/man2/process_madvise.2.html.
> 
> Fixes: ecb8ac8b1f14("mm/madvise: introduce process_madvise() syscall: an external memory hinting API"
> Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
> ---
>  mm/madvise.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 38d0f51..d3b49b3 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1426,15 +1426,21 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
>  
>  	while (iov_iter_count(&iter)) {
>  		iovec = iov_iter_iovec(&iter);
> +		/*
> +		 * Even when [start, end) passed to do_madvise covers
> +		 * some unmapped addresses, it continues processing with
> +		 * returning ENOMEM at the end. Thus consider the range
> +		 * as processed when do_madvise() returns ENOMEM.
> +		 * This makes process_madvise() never returns ENOMEM.
> +		 */

Looks like that this patch has two things. first, returns processed
bytes instead of error in case of error. Second, keep working on
rest vmas on -ENOMEM due to unmapped hole.

First thing totally makes sense to me(that's exactly I wanted to
do but somehow missed) so it should go stable tree. However,
second stuff might be arguble so it would be great if you split
the patch.

>  		ret = do_madvise(mm, (unsigned long)iovec.iov_base,
>  					iovec.iov_len, behavior);
> -		if (ret < 0)
> +		if (ret < 0 && ret != -ENOMEM)
>  			break;
>  		iov_iter_advance(&iter, iovec.iov_len);
>  	}
>  
> -	if (ret == 0)
> -		ret = total_len - iov_iter_count(&iter);
> +	ret = (total_len - iov_iter_count(&iter)) ? : ret;
>  
>  release_mm:
>  	mmput(mm);
> -- 
> 2.7.4
> 
