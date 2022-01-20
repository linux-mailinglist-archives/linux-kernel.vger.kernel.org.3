Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A68A4953D9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 19:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243318AbiATSDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 13:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236454AbiATSDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 13:03:49 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB60C061574;
        Thu, 20 Jan 2022 10:03:48 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id a7so5807488plh.1;
        Thu, 20 Jan 2022 10:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hBdSBn0aY8P5b7CcUgLLwj8ITEo8ulwTDyDNKsj3JU4=;
        b=a8aewc0V/Mxa2wZG0otBO8Z8iDIGHB/+3V8bw2mJ2XqPnqJ++PYfOnsG42TIZAwmqc
         YyV98avkWwkZDb6Iaz+XVg7VcoZ7PbAysz/vC05oTQ3r01xOWu1hfo/cJMdXdA88EeD7
         kilKiQyJczONi7FpcV9v7l58pXiQBuOvjs5cXgXH7mpNn1FZNAxGRQ4vxUxByCgmG/zT
         +p8VWIM+3swreGU1vQe79490Ru1O3NR1TCvWyoBZ77JTZQLf1ObcHdLln06qRp5C8DMt
         5q4UT5Y2+l5dS6l6zT03ArlGHFXfK4jMFqhsYuexjlTWK0VeM6NGovoJx0g63VzbD++Q
         7SaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hBdSBn0aY8P5b7CcUgLLwj8ITEo8ulwTDyDNKsj3JU4=;
        b=PBqZzLc7EFx3lpnMBaMQagnwj8ohDq7fLLPoUJm2TnWoe3eqq5uaVA+GBSsVnTRrRl
         HsCkw/nY3gqM2/WBPiQ5nyxKdNjs1J7vuJL83OTYnNqKTYFIxHodt9DNr77SUSvCWzIP
         cX50q98zeHyxeA9Ve3j6Qy8HM+JlaFLf5qYQwQB2xRe9h3r+gHbspthbjX74clDiFrBe
         ukYXav6qB34IGFgPwh3ZbUKKAREPtxR7x5I7vxI3HyFPvB14Fstza1MiXizYg6dCx5at
         8W/U5Av2d/txxFse44sEPRkY1eugdiz3AN9pd/KIt8BcPZg1SyBJpHLxdu2AmNyEPk9U
         KP3Q==
X-Gm-Message-State: AOAM531qsIzFW3wfgArg+UDCjl5Qo5ngEK+t+n7ZESkb4xHCez5gcqv4
        lfcOULq73RRn5OB4LF5HFPI=
X-Google-Smtp-Source: ABdhPJzV4sADT3tD7ij7Xb6ez768vZE0npHBW1XWFtG1IZst812poZLDRzFTqJm2siEIPk7w+lZi1g==
X-Received: by 2002:a17:90a:4305:: with SMTP id q5mr12283473pjg.222.1642701827779;
        Thu, 20 Jan 2022 10:03:47 -0800 (PST)
Received: from smtpclient.apple ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id w10sm3589790pfn.153.2022.01.20.10.03.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jan 2022 10:03:47 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [RFC][PATCH v2 1/5] mm: Avoid unmapping pinned pages
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20220120160822.666778608@infradead.org>
Date:   Thu, 20 Jan 2022 10:03:44 -0800
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        Steven Rostedt <rostedt@goodmis.org>, bsegall@google.com,
        Mel Gorman <mgorman@suse.de>, bristot@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        X86 ML <x86@kernel.org>, pjt@google.com, posk@google.com,
        avagin@google.com, Jann Horn <jannh@google.com>,
        tdelisle@uwaterloo.ca, mark.rutland@arm.com, posk@posk.io
Content-Transfer-Encoding: 7bit
Message-Id: <E63F4045-E624-47FE-A417-5D2FF7923179@gmail.com>
References: <20220120155517.066795336@infradead.org>
 <20220120160822.666778608@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 20, 2022, at 7:55 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> Add a guarantee for Anon pages that pin_user_page*() ensures the
> user-mapping of these pages stay preserved. In order to ensure this
> all rmap users have been audited:
> 
> vmscan:	already fails eviction due to page_maybe_dma_pinned()
> 
> migrate:	migration will fail on pinned pages due to
> 		expected_page_refs() not matching, however that is
> 		*after* try_to_migrate() has already destroyed the
> 		user mapping of these pages. Add an early exit for
> 		this case.
> 
> numa-balance:	as per the above, pinned pages cannot be migrated,
> 		however numa balancing scanning will happily PROT_NONE
> 		them to get usage information on these pages. Avoid
> 		this for pinned pages.
> 
> None of the other rmap users (damon,page-idle,mlock,..) unmap the
> page, they mostly just muck about with reference,dirty flags etc.
> 
> This same guarantee cannot be provided for Shared (file) pages due to
> dirty page tracking.
> 
> 

[ snip ]

> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -106,6 +106,12 @@ static unsigned long change_pte_range(st
> 					continue;
> 
> 				/*
> +				 * Can't migrate pinned pages, avoid touching them.
> +				 */
> +				if (page_maybe_dma_pinned(page))
> +					continue;
> +
> +				/*
> 

I have a similar problem with userfaultfd changing protection for
DMA-pinned pages. For userfaultfd it is important to know how many
pages were actually modified.

I am working on a vectored UFFDIO_WRITEPROTECTV that aborts once
a pinned page is encountered, but also returns the number of pages
that were properly protected. I still need to do some work to
send patches for that as it requires further changes (to return
the number of pages that were handled).

But for the matter of your patch, is it possible to make this
test generic (not migration specific) and rely on a new flag in
cp_flags? I can of course make this change later if you prefer it
this way.

