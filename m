Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F354E6B97
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 01:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357061AbiCYAuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 20:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239525AbiCYAuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 20:50:13 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D0A32078
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 17:48:40 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id b15so5236075pfm.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 17:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zXg1tMAdUsVaG4xJrsonGJrizcZB7/gpq0IZD0yXp2k=;
        b=fLf/em7TAEh+cdSfAJWuyiN8zD51JBfJx1WtWctYXyqvD4bcoqm1/PX4PIz6HrCgsp
         Jp/DTCtyY1FTMrxoo34hAUWT/dgLcHUnotyhsaw1CjJX3u9v2EbPNHNdZvtqTh+W5f5P
         p9iMyD7u9jA2BaY1gPZsu+r5m49+XaCaM92QwG3k94H0bZTZ1We0z1erLFFuyEL67BKm
         RMV6H06VPmnhOa0Uu496iT0rtERL+MddmvacYMDr/8vRu+EBWEoznZaZuUKesDVIshcO
         HNCQfRer40lrqDFDScfXz2IC6IBMwAUw/15T6t4gQGLxSCF7vMa4ynN0qq9Yd85nJCiD
         gx/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=zXg1tMAdUsVaG4xJrsonGJrizcZB7/gpq0IZD0yXp2k=;
        b=wrKK5lP+oE8DpuYpd/NQFYDITlIDoCHRnVli2Dv9fjXUKchiS2YyOuLi+bYcm03Kke
         R54MRfHM9OeKflcb1eyX8NsISZObJtR2GQOtGvIfSjkum7z1ldb+pACbn3DlQZoEDzTP
         L0DHfSGksi6zdHbRzE4tROSfB+RbCjffP8XOrBA1mP8QhloZCZz3xzchfMyUiw8Nedc+
         mNWqW0R2uLLdCCMj3Fiw1qi4XHL1YUNRcs94wtWF8N7Nf6UVLvpiFLgIL7bw8Tbsg2vn
         dlEAUEDVkU3NWrTFa3KSwvmzly02Fggs2tbfBQJEaGrrUo15/+597xExXF5ZFWIhxnlx
         JFog==
X-Gm-Message-State: AOAM531Ex7EX3PFK8+1ygmXEBVx7SooxWla+Bjvhq5NOcGayio/qbFUv
        sVyu5cdFCW6F0NC+ZkjqBy4=
X-Google-Smtp-Source: ABdhPJwY8Z8ZqFk2AKMFsNrz3gPdRDcQyu8GHVLdtB+flm261sH6gxGd7Ptp4FyTxdI4YajjDiNkFQ==
X-Received: by 2002:a05:6a00:3486:b0:4fa:bb7e:b4c7 with SMTP id cp6-20020a056a00348600b004fabb7eb4c7mr7559822pfb.4.1648169319673;
        Thu, 24 Mar 2022 17:48:39 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:a488:edc:4d69:56d3])
        by smtp.gmail.com with ESMTPSA id b14-20020a056a000cce00b004fabc39519esm4987158pfv.5.2022.03.24.17.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 17:48:39 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 24 Mar 2022 17:48:37 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org,
        surenb@google.com, vbabka@suse.cz, rientjes@google.com,
        nadav.amit@gmail.com, edgararriaga@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH 2/2] mm: madvise: return exact bytes advised with
 process_madvise under error
Message-ID: <Yj0RZU4JMXb0acCj@google.com>
References: <cover.1648046642.git.quic_charante@quicinc.com>
 <0fa1bdb5009e898189f339610b90ecca16f243f4.1648046642.git.quic_charante@quicinc.com>
 <Yjxutr35QLGhjJ57@dhcp22.suse.cz>
 <602dcc82-519b-bafd-19e6-b373abe572d4@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <602dcc82-519b-bafd-19e6-b373abe572d4@quicinc.com>
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

On Thu, Mar 24, 2022 at 09:15:57PM +0530, Charan Teja Kalla wrote:
> Thanks Michal for the inputs.
> 
> On 3/24/2022 6:44 PM, Michal Hocko wrote:
> > On Wed 23-03-22 20:54:10, Charan Teja Kalla wrote:
> >> From: Charan Teja Reddy <quic_charante@quicinc.com>
> >>
> >> The commit 5bd009c7c9a9 ("mm: madvise: return correct bytes advised with
> >> process_madvise") fixes the issue to return number of bytes that are
> >> successfully advised before hitting error with iovec elements
> >> processing. But, when the user passed unmapped ranges in iovec, the
> >> syscall ignores these holes and continues processing and returns ENOMEM
> >> in the end, which is same as madvise semantic. This is a problem for
> >> vector processing where user may want to know how many bytes were
> >> exactly processed in a iovec element to make better decissions in the
> >> user space. As in ENOMEM case, we processed all bytes in a iovec element
> >> but still returned error which will confuse the user whether it is
> >> failed or succeeded to advise.
> > Do you have any specific example where the initial semantic is really
> > problematic or is this mostly a theoretical problem you have found when
> > reading the code?
> > 
> > 
> >> As an example, consider below ranges were passed by the user in struct
> >> iovec: iovec1(ranges: vma1), iovec2(ranges: vma2 -- vma3 -- hole) and
> >> iovec3(ranges: vma4). In the current implementation, it fully advise
> >> iovec1 and iovec2 but just returns number of processed bytes as iovec1
> >> range. Then user may repeat the processing of iovec2, which is already
> >> processed, which then returns with ENOMEM. Then user may want to skip
> >> iovec2 and starts processing from iovec3. Here because of wrong return
> >> processed bytes, iovec2 is processed twice.
> > I think you should be much more specific why this is actually a problem.
> > This would surely be less optimal but is this a correctness issue?
> > 
> 
> Yes, this is a problem found when reading the code, but IMO we can
> easily expect an invalid vma/hole in the passed range because we are
> operating on other process VMA. More than solving the problem of being
> less optimal, this can be looked in the direction of helping the user to
> take better policy decisions with this syscall. And, not better policy
> decisions from user is just being sub optimal(i.e. issuing the syscall
> again on the processed range) with this syscall.
> 
> Having said that, at present I don't have any reports/unit test showing
> the existing semantic is really a problematic.
> 
> > [...]
> >> +	vma = find_vma_prev(mm, start, &prev);
> >> +	if (vma && start > vma->vm_start)
> >> +		prev = vma;
> >> +
> >> +	blk_start_plug(&plug);
> >> +	for (;;) {
> >> +		/*
> >> +		 * It it hits a unmapped address range in the [start, end),
> >> +		 * stop processing and return ENOMEM.
> >> +		 */
> >> +		if (!vma || start < vma->vm_start) {
> >> +			error = -ENOMEM;
> >> +			goto out;
> >> +		}
> >> +
> >> +		tmp = vma->vm_end;
> >> +		if (end < tmp)
> >> +			tmp = end;
> >> +
> >> +		error = madvise_vma_behavior(vma, &prev, start, tmp, behavior);
> >> +		if (error)
> >> +			goto out;
> >> +		tmp_bytes_advised += tmp - start;
> >> +		start = tmp;
> >> +		if (prev && start < prev->vm_end)
> >> +			start = prev->vm_end;
> >> +		if (start >= end)
> >> +			goto out;
> >> +		if (prev)
> >> +			vma = prev->vm_next;
> >> +		else
> >> +			vma = find_vma(mm, start);
> >> +	}
> >> +out:
> >> +	/*
> >> +	 * partial_bytes_advised may contain non-zero bytes indicating
> >> +	 * the number of bytes advised before failure. Holds zero incase
> >> +	 * of success.
> >> +	 */
> >> +	*partial_bytes_advised = error ? tmp_bytes_advised : 0;
> > Although this looks like a fix I am not sure it is future proof.
> > madvise_vma_behavior doesn't report which part of the range has been
> > really processed. I do not think that currently supported madvise modes
> > for process_madvise support an early break out with return to the
> > userspace (madvise_cold_or_pageout_pte_range bails on fatal signals for
> > example) but this can change in the future and then you are back to
> > "imprecise" return value problem. Yes, this is a theoretical problem
> 
> Agree here with the "imprecise" return value problem with processing a
> VMA range. Yes when it is decided to return proper processed value from
> madvise_vma_behavior(), this code too may need the maintenance.
> 
> > but so it sounds the problem you are trying to fix IMHO. I think it
> > would be better to live with imprecise return values reporting rather
> > than aiming for perfection which would be fragile and add a future
> > maintenance burden.
> >
> Hmm. Should atleast this imprecise return values be documented in man
> page or in madvise.c file?

I don't think we need to document it in man page. madvice.c would be
enough, IMHO.
