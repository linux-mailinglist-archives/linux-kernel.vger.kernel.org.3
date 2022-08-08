Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2312358C1E0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 04:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234795AbiHHCvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 22:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbiHHCvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 22:51:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FA52BE0
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 19:51:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 253A060DD3
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 02:51:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A2CC433C1;
        Mon,  8 Aug 2022 02:51:12 +0000 (UTC)
Date:   Sun, 7 Aug 2022 22:51:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, pmladek@suse.com,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v5 31/32] tracing: Convert to printbuf
Message-ID: <20220807225113.6a74b481@gandalf.local.home>
In-Reply-To: <20220808024128.3219082-32-willy@infradead.org>
References: <20220808024128.3219082-1-willy@infradead.org>
        <20220808024128.3219082-32-willy@infradead.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  8 Aug 2022 03:41:27 +0100
"Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:

>  
> @@ -9826,20 +9821,8 @@ static struct notifier_block trace_die_notifier = {
>  void
>  trace_printk_seq(struct trace_seq *s)
>  {
> -	/* Probably should print a warning here. */
> -	if (s->seq.len >= TRACE_MAX_PRINT)
> -		s->seq.len = TRACE_MAX_PRINT;
> -
> -	/*
> -	 * More paranoid code. Although the buffer size is set to
> -	 * PAGE_SIZE, and TRACE_MAX_PRINT is 1000, this is just
> -	 * an extra layer of protection.
> -	 */
> -	if (WARN_ON_ONCE(s->seq.len >= s->seq.size))
> -		s->seq.len = s->seq.size - 1;
> -
>  	/* should be zero ended, but we are paranoid. */
> -	s->buffer[s->seq.len] = 0;
> +	printbuf_nul_terminate(&s->seq);
>  
>  	printk(KERN_TRACE "%s", s->buffer);
>  
> diff --g

Please remove the two tracing patches and the deletion of the seq_buf from
the series.

Thank you.

-- Steve
