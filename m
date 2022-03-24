Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4DA54E63EA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 14:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350347AbiCXNQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 09:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbiCXNQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 09:16:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA385D5D9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 06:14:32 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id AA57F210FD;
        Thu, 24 Mar 2022 13:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648127671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VNnFxSS83AKZ6mnxU8f26Q342BEjDVtjsTkx4noK0Kw=;
        b=CXiEmbSksC8S0uFG7nfe5goyrnD7vsPUiuu+18xeZ6CQa1oo1MTpp+Bc/iPPAM4YHeED16
        46aPCruoGBseREY4lOBxtBj6YPCbLipsOT+mDGkwuaVQVLyUg/vYxa1xAh//JWQxhbwipl
        A++vMknOYm4oUJfX2eoeKM4g89TFxHE=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 721A1A3B89;
        Thu, 24 Mar 2022 13:14:31 +0000 (UTC)
Date:   Thu, 24 Mar 2022 14:14:30 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     akpm@linux-foundation.org, minchan@kernel.org, surenb@google.com,
        vbabka@suse.cz, rientjes@google.com, nadav.amit@gmail.com,
        edgararriaga@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: madvise: return exact bytes advised with
 process_madvise under error
Message-ID: <Yjxutr35QLGhjJ57@dhcp22.suse.cz>
References: <cover.1648046642.git.quic_charante@quicinc.com>
 <0fa1bdb5009e898189f339610b90ecca16f243f4.1648046642.git.quic_charante@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fa1bdb5009e898189f339610b90ecca16f243f4.1648046642.git.quic_charante@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 23-03-22 20:54:10, Charan Teja Kalla wrote:
> From: Charan Teja Reddy <quic_charante@quicinc.com>
> 
> The commit 5bd009c7c9a9 ("mm: madvise: return correct bytes advised with
> process_madvise") fixes the issue to return number of bytes that are
> successfully advised before hitting error with iovec elements
> processing. But, when the user passed unmapped ranges in iovec, the
> syscall ignores these holes and continues processing and returns ENOMEM
> in the end, which is same as madvise semantic. This is a problem for
> vector processing where user may want to know how many bytes were
> exactly processed in a iovec element to make better decissions in the
> user space. As in ENOMEM case, we processed all bytes in a iovec element
> but still returned error which will confuse the user whether it is
> failed or succeeded to advise.

Do you have any specific example where the initial semantic is really
problematic or is this mostly a theoretical problem you have found when
reading the code?


> As an example, consider below ranges were passed by the user in struct
> iovec: iovec1(ranges: vma1), iovec2(ranges: vma2 -- vma3 -- hole) and
> iovec3(ranges: vma4). In the current implementation, it fully advise
> iovec1 and iovec2 but just returns number of processed bytes as iovec1
> range. Then user may repeat the processing of iovec2, which is already
> processed, which then returns with ENOMEM. Then user may want to skip
> iovec2 and starts processing from iovec3. Here because of wrong return
> processed bytes, iovec2 is processed twice.

I think you should be much more specific why this is actually a problem.
This would surely be less optimal but is this a correctness issue?

[...]
> +	vma = find_vma_prev(mm, start, &prev);
> +	if (vma && start > vma->vm_start)
> +		prev = vma;
> +
> +	blk_start_plug(&plug);
> +	for (;;) {
> +		/*
> +		 * It it hits a unmapped address range in the [start, end),
> +		 * stop processing and return ENOMEM.
> +		 */
> +		if (!vma || start < vma->vm_start) {
> +			error = -ENOMEM;
> +			goto out;
> +		}
> +
> +		tmp = vma->vm_end;
> +		if (end < tmp)
> +			tmp = end;
> +
> +		error = madvise_vma_behavior(vma, &prev, start, tmp, behavior);
> +		if (error)
> +			goto out;
> +		tmp_bytes_advised += tmp - start;
> +		start = tmp;
> +		if (prev && start < prev->vm_end)
> +			start = prev->vm_end;
> +		if (start >= end)
> +			goto out;
> +		if (prev)
> +			vma = prev->vm_next;
> +		else
> +			vma = find_vma(mm, start);
> +	}
> +out:
> +	/*
> +	 * partial_bytes_advised may contain non-zero bytes indicating
> +	 * the number of bytes advised before failure. Holds zero incase
> +	 * of success.
> +	 */
> +	*partial_bytes_advised = error ? tmp_bytes_advised : 0;

Although this looks like a fix I am not sure it is future proof.
madvise_vma_behavior doesn't report which part of the range has been
really processed. I do not think that currently supported madvise modes
for process_madvise support an early break out with return to the
userspace (madvise_cold_or_pageout_pte_range bails on fatal signals for
example) but this can change in the future and then you are back to
"imprecise" return value problem. Yes, this is a theoretical problem
but so it sounds the problem you are trying to fix IMHO. I think it
would be better to live with imprecise return values reporting rather
than aiming for perfection which would be fragile and add a future
maintenance burden.

On the other hand if there are _real_ workloads which suffer from the
existing semantic then sure the above seems to be an appropriate fix
AFAICS.
-- 
Michal Hocko
SUSE Labs
