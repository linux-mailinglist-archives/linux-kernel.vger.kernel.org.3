Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9403851B4B8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 02:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbiEEAf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 20:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbiEEAfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 20:35:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E352CCBA
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 17:31:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06B9F61D16
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 00:31:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5552EC385AA;
        Thu,  5 May 2022 00:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651710705;
        bh=oRbFK0+QsxbpJy+JTSG2ZgoCNqYlye01oWjlbX7I/jA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V2865g5oV4//XcjoBYttq0NKogx8/atdD6piWCnAV3Zb0QD7OT3GVTLztBzd05VOl
         r+sIFfBvStaRCoZCkSYniQ4fQnU7wXXMD2xBCsZWW0ZfaSTcmv+3TiWQgk5fz+p062
         Rqz9XIXKTY5vLXzOz/bQdtduQbaJ9UBRNle/wYvGnt6Iff3gNLdrcWTk5Dg1Kd3NDV
         +Crvx22ktwqGG3fFDqjNgd9jNFKKL+m/3cNhNUEOUPN1lXbUDYw4OqKRQS4Sy2PgJT
         UaSMsJUB7iWg/YD7u4kCv32VXzJ6xuWjDkc2QxBxAEW0wDll5T/zq2DtQLBNiFA/xc
         EHTLwoRx5yIcg==
Date:   Thu, 5 May 2022 09:31:40 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kprobes: Fix build errors with CONFIG_KRETPROBES=n
Message-Id: <20220505093140.9a0500813b8d529442c76933@kernel.org>
In-Reply-To: <CAMo8BfJF_HTZc-PUrK4y5yLEdwWPmpKu2NyzJusjGd1Ste0b3g@mail.gmail.com>
References: <20220502184050.1792743-1-jcmvbkbc@gmail.com>
        <165163539094.74407.3838114721073251225.stgit@devnote2>
        <CAMo8BfJF_HTZc-PUrK4y5yLEdwWPmpKu2NyzJusjGd1Ste0b3g@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 May 2022 10:53:42 -0700
Max Filippov <jcmvbkbc@gmail.com> wrote:

> On Tue, May 3, 2022 at 8:36 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > Max Filippov reported:
> >
> > When building kernel with CONFIG_KRETPROBES=n kernel/kprobes.c
> > compilation fails with the following messages:
> >
> >   kernel/kprobes.c: In function ‘recycle_rp_inst’:
> >   kernel/kprobes.c:1273:32: error: implicit declaration of function
> >                                    ‘get_kretprobe’
> >
> >   kernel/kprobes.c: In function ‘kprobe_flush_task’:
> >   kernel/kprobes.c:1299:35: error: ‘struct task_struct’ has no member
> >                                    named ‘kretprobe_instances’
> >
> > This came from the commit d741bf41d7c7 ("kprobes: Remove
> > kretprobe hash") which introduced get_kretprobe() and
> > kretprobe_instances member in task_struct when CONFIG_KRETPROBES=y,
> > but did not make recycle_rp_inst() and kprobe_flush_task()
> > depending on CONFIG_KRETPORBES.
> >
> > Since those functions are only used for kretprobe, move those
> > functions into #ifdef CONFIG_KRETPROBE area.
> >
> > Reported-by: Max Filippov <jcmvbkbc@gmail.com>
> > Fixes: d741bf41d7c7 ("kprobes: Remove kretprobe hash")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  include/linux/kprobes.h |    2 -
> >  kernel/kprobes.c        |  144 +++++++++++++++++++++++------------------------
> >  2 files changed, 72 insertions(+), 74 deletions(-)
> 
> Tested-by: Max Filippov <jcmvbkbc@gmail.com>

Thank you!

Steve, can you pick this fix?

Thanks,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
