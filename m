Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C994BBF0E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 19:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238981AbiBRSJm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 18 Feb 2022 13:09:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238838AbiBRSJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 13:09:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FD727F2A6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 10:09:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BEFA62034
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 18:09:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09EB6C340E9;
        Fri, 18 Feb 2022 18:09:21 +0000 (UTC)
Date:   Fri, 18 Feb 2022 13:09:20 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jakub =?UTF-8?B?TWF0xJtuYQ==?= <matenajakub@gmail.com>
Cc:     linux-mm@kvack.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, vbabka@suse.cz, mhocko@kernel.org,
        mgorman@techsingularity.net, willy@infradead.org,
        liam.howlett@oracle.com, hughd@google.com, kirill@shutemov.name,
        riel@surriel.com, peterz@infradead.org
Subject: Re: [RFC PATCH 4/4] [PATCH 4/4] mm: add tracing for VMA merges
Message-ID: <20220218130920.5902d967@gandalf.local.home>
In-Reply-To: <20220218122019.130274-5-matenajakub@gmail.com>
References: <20220218122019.130274-1-matenajakub@gmail.com>
        <20220218122019.130274-5-matenajakub@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Feb 2022 13:20:19 +0100
Jakub Matěna <matenajakub@gmail.com> wrote:

> diff --git a/include/trace/events/mmap.h b/include/trace/events/mmap.h
> index 4661f7ba07c0..9f6439e2ed2d 100644
> --- a/include/trace/events/mmap.h
> +++ b/include/trace/events/mmap.h
> @@ -6,6 +6,7 @@
>  #define _TRACE_MMAP_H
>  
>  #include <linux/tracepoint.h>
> +#include <../mm/internal.h>
>  
>  TRACE_EVENT(vm_unmapped_area,
>  
> @@ -42,6 +43,60 @@ TRACE_EVENT(vm_unmapped_area,
>  		__entry->low_limit, __entry->high_limit, __entry->align_mask,
>  		__entry->align_offset)
>  );
> +
> +TRACE_EVENT(vm_av_merge,
> +
> +	TP_PROTO(int merged, enum vma_merge_res merge_prev, enum vma_merge_res merge_next, enum vma_merge_res merge_both),
> +
> +	TP_ARGS(merged, merge_prev, merge_next, merge_both),
> +
> +	TP_STRUCT__entry(
> +		__field(int,			merged)
> +		__field(enum vma_merge_res,	predecessor_different_av)
> +		__field(enum vma_merge_res,	successor_different_av)
> +		__field(enum vma_merge_res,	predecessor_with_successor_different_av)
> +		__field(int,			diff_count)
> +		__field(int,			failed_count)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->merged = merged == 0;
> +		__entry->predecessor_different_av = merge_prev;
> +		__entry->successor_different_av = merge_next;
> +		__entry->predecessor_with_successor_different_av = merge_both;
> +		__entry->diff_count = (merge_prev == AV_MERGE_DIFFERENT)
> +		+ (merge_next == AV_MERGE_DIFFERENT) + (merge_both == AV_MERGE_DIFFERENT);
> +		__entry->failed_count = (merge_prev == AV_MERGE_FAILED)
> +		+ (merge_next == AV_MERGE_FAILED) + (merge_both == AV_MERGE_FAILED);

Please indent the above better. That is:

		__entry->diff_count = (merge_prev == AV_MERGE_DIFFERENT)
				+ (merge_next == AV_MERGE_DIFFERENT)
				+ (merge_both == AV_MERGE_DIFFERENT);


> +	),
> +
> +	TP_printk("merged=%d predecessor=%d successor=%d predecessor_with_successor=%d diff_count=%d failed_count=%d\n",
> +		__entry->merged,
> +		__entry->predecessor_different_av, __entry->successor_different_av,
> +		__entry->predecessor_with_successor_different_av,
> +		__entry->diff_count, __entry->failed_count)

To make the above easier to read for humans, you could have at the start:

#define AV_MERGE_TYPES		\
	EM(MERGE_FAILED),	\
	EM(AV_MERGE_FAILED)	\
	EM(MERGE_OK)		\
	EMe(AV_MERGE_DIFFERENT)

#define EM(a)	TRACE_DEFINE_ENUM(a);
#define EMe(a)	TRACE_DEFINE_ENUM(a);

AV_MERGE_TYPES

#undef EM
#undef EMe

#define EM(a) 	{a, #a},
#define EMe(a)	{a, #a}

Then:

	TP_printk("merged=%d predecessor=%s successor=%s predecessor_with_successor=%s diff_count=%d failed_count=%d",

(note, no "\n", get rid of that)

		__entry->merged,
		__print_symbolic(predecessor_different_av, AV_MERGE_TYPES),
		__print_symbolic(successor_different_av, AV_MERGE_TYPES),
		__print_symbolic(predecessor_with_successor_different_av, AV_MERGE_TYPES),
		__entry->diff_count, __entry->failed_count)

Then the output will show strings instead of meaningless numbers.

-- Steve


> +
> +);
> +
> +TRACE_EVENT(vm_pgoff_merge,
> +
> +	TP_PROTO(struct vm_area_struct *vma, bool anon_pgoff_updated),
> +
> +	TP_ARGS(vma, anon_pgoff_updated),
> +
> +	TP_STRUCT__entry(
> +		__field(bool,	faulted)
> +		__field(bool,	updated)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->faulted = vma->anon_vma;
> +		__entry->updated = anon_pgoff_updated;
> +	),
> +
> +	TP_printk("faulted=%d updated=%d\n",
> +		__entry->faulted, __entry->updated)
> +);
>  #endif
>  
>  /* This part must be outside protection */
