Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2193949B805
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 16:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1582685AbiAYPxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 10:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1582407AbiAYPtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 10:49:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3286EC061771;
        Tue, 25 Jan 2022 07:49:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3A0CB818D0;
        Tue, 25 Jan 2022 15:49:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A37C340E5;
        Tue, 25 Jan 2022 15:49:39 +0000 (UTC)
Date:   Tue, 25 Jan 2022 10:49:38 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the kspp tree
Message-ID: <20220125104938.566da04f@gandalf.local.home>
In-Reply-To: <20220125233154.dac280ed36944c0c2fe6f3ac@kernel.org>
References: <20220125145006.677e3709@canb.auug.org.au>
        <202201242230.C54A6BCDFE@keescook>
        <20220125222732.98ce2e445726e773f40e122e@kernel.org>
        <20220125233154.dac280ed36944c0c2fe6f3ac@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2022 23:31:54 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Could you try this patch?
> 
> >From 2982ba01367ec1f746a4f128512436e5325a7f9d Mon Sep 17 00:00:00 2001  
> From: Masami Hiramatsu <mhiramat@kernel.org>
> Date: Tue, 25 Jan 2022 23:19:30 +0900
> Subject: [PATCH] tracing: Avoid -Warray-bounds warning for __rel_loc macro
> 
> Since -Warray-bounds checks the destination size from the
> type of given pointer, __assign_rel_str() macro gets warned
> because it passes the pointer to the 'u32' field instead of
> 'trace_event_raw_*' data structure.
> Pass the data address calculated from the 'trace_event_raw_*'
> instead of 'u32' __rel_loc field.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Kees Cook <keescook@chromium.org>

If this works, I'll add it instead of the one that just turns it off it
__CHECKER__ is defined.

Can you please let me know if it fixes the issue for you. I have a test run
waiting on it.

Thanks,

-- Steve
