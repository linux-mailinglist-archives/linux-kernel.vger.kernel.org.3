Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC03578D9C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 00:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbiGRWi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 18:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbiGRWiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 18:38:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79798246
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:38:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18CA661557
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 22:38:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A27DDC341C0;
        Mon, 18 Jul 2022 22:38:52 +0000 (UTC)
Date:   Mon, 18 Jul 2022 18:38:51 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linyu Yuan <quic_linyyuan@quicinc.com>
Subject: Re: [PATCH] selftests/kprobe: Update test for no event name syntax
 error
Message-ID: <20220718183851.711725e3@gandalf.local.home>
In-Reply-To: <165812790993.1377963.9762767354560397298.stgit@devnote2>
References: <20220718144007.78c5b50f9b123fb80a920054@kernel.org>
        <165812790993.1377963.9762767354560397298.stgit@devnote2>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jul 2022 16:05:10 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> The commit 208003254c32 ("selftests/kprobe: Do not test for GRP/
> without event failures") removed a syntax which is no more cause
> a syntax error (NO_EVENT_NAME error with GRP/).
> However, there are another case (NO_EVENT_NAME error without GRP/)
> which causes a same error. This adds a test for that case.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Queued. Thanks Masami!

-- Steve

> ---
>  .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
> index 7c02509c71d0..9e85d3019ff0 100644
> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
> @@ -21,6 +21,7 @@ check_error 'p:^/bar vfs_read'		# NO_GROUP_NAME
>  check_error 'p:^12345678901234567890123456789012345678901234567890123456789012345/bar vfs_read'	# GROUP_TOO_LONG
>  
>  check_error 'p:^foo.1/bar vfs_read'	# BAD_GROUP_NAME
> +check_error 'p:^ vfs_read'		# NO_EVENT_NAME
>  check_error 'p:foo/^12345678901234567890123456789012345678901234567890123456789012345 vfs_read'	# EVENT_TOO_LONG
>  check_error 'p:foo/^bar.1 vfs_read'	# BAD_EVENT_NAME
>  

