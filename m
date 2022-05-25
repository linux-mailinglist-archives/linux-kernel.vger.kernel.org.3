Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83C6533EBF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236678AbiEYOHZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 25 May 2022 10:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245661AbiEYOF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 10:05:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79609CCAC
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 07:05:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 539826190D
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 14:05:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F9D1C385B8;
        Wed, 25 May 2022 14:05:28 +0000 (UTC)
Date:   Wed, 25 May 2022 10:05:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jakub =?UTF-8?B?TWF0xJtuYQ==?= <matenajakub@gmail.com>
Cc:     linux-mm@kvack.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, vbabka@suse.cz, mhocko@kernel.org,
        mgorman@techsingularity.net, willy@infradead.org,
        liam.howlett@oracle.com, hughd@google.com, kirill@shutemov.name,
        riel@surriel.com, peterz@infradead.org, david@redhat.com
Subject: Re: [RFC PATCH v3 6/6] [PATCH 6/6] mm: add tracing for VMA merges
Message-ID: <20220525100526.2a7a0eb7@gandalf.local.home>
In-Reply-To: <20220516125405.1675-7-matenajakub@gmail.com>
References: <20220516125405.1675-1-matenajakub@gmail.com>
        <20220516125405.1675-7-matenajakub@gmail.com>
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

On Mon, 16 May 2022 14:54:05 +0200
Jakub Matěna <matenajakub@gmail.com> wrote:

> +	TP_fast_assign(
> +		__entry->merged = merged == 0;
> +		__entry->predecessor_different_av = merge_prev;
> +		__entry->successor_different_av = merge_next;
> +		__entry->predecessor_with_successor_different_av = merge_both;


> +		__entry->same_count = (merge_prev == AV_MERGE_SAME) +
> +			(merge_next == AV_MERGE_SAME) +
> +			(merge_both == AV_MERGE_SAME);
> +		__entry->diff_count = (merge_prev == AV_MERGE_DIFFERENT) +
> +			(merge_next == AV_MERGE_DIFFERENT) +
> +			(merge_both == AV_MERGE_DIFFERENT);
> +		__entry->failed_count = (merge_prev == AV_MERGE_FAILED) +
> +			(merge_next == AV_MERGE_FAILED) +
> +			(merge_both == AV_MERGE_FAILED);

The above looks like it can be moved into the TP_printk(), as you have the
merge_prev, next and both saved already. Why waste more ring buffer space
and execution time for information that can be derived at the time of
reading the trace event?

-- Steve


> +	),
> +
> +	TP_printk("merged=%d predecessor=%s successor=%s predecessor_with_successor=%s same_count=%d diff_count=%d failed_count=%d",
> +		__entry->merged,
> +		__print_symbolic(__entry->predecessor_different_av, AV_MERGE_TYPES),
> +		__print_symbolic(__entry->successor_different_av, AV_MERGE_TYPES),
> +		__print_symbolic(__entry->predecessor_with_successor_different_av, AV_MERGE_TYPES),
> +		__entry->same_count, __entry->diff_count, __entry->failed_count)
> +
> +);
> +
