Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D5C59C0AE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 15:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235183AbiHVNe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 09:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234128AbiHVNey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:34:54 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9052A955
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 06:34:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 43479CE12D2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 13:34:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E66C433D6;
        Mon, 22 Aug 2022 13:34:47 +0000 (UTC)
Date:   Mon, 22 Aug 2022 09:35:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Song Liu <song@kernel.org>
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ftrace: makes ops_references_rec() inline
Message-ID: <20220822093503.40cb4551@gandalf.local.home>
In-Reply-To: <CAPhsuW6gAHPeRF0cqpi0Z4znWbw+rhz3h4yXYOWQ-__zPY7LoA@mail.gmail.com>
References: <87fshpggb7.wl-kuninori.morimoto.gx@renesas.com>
        <CAPhsuW6gAHPeRF0cqpi0Z4znWbw+rhz3h4yXYOWQ-__zPY7LoA@mail.gmail.com>
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

On Mon, 22 Aug 2022 00:28:58 -0700
Song Liu <song@kernel.org> wrote:

> On Sun, Aug 21, 2022 at 7:31 PM Kuninori Morimoto
> <kuninori.morimoto.gx@renesas.com> wrote:
> >
> > commit 53cd885bc5c3e ("ftrace: Allow IPMODIFY and DIRECT ops on the
> > same function") changed ops_references_rec() inline to function,
> > thus we will get below error if .config doesn't have CONFIG_MODULES.
> >
> >   CC      kernel/trace/ftrace.o
> > ${linux}/kernel/trace/ftrace.c:3149:1: error: 'ops_references_rec' \
> > defined but not used [-Werror=unused-function]
> >  3149 | ops_references_rec(struct ftrace_ops *ops, struct dyn_ftrace *rec)
> >       | ^~~~~~~~~~~~~~~~~~
> > cc1: all warnings being treated as errors
> > make[2]: *** [${linux}/scripts/Makefile.build:249: kernel/trace/ftrace.o] error 1
> > make[1]: *** [${linux}/scripts/Makefile.build:466: kernel/trace] error 2
> > make: *** [/opt/disk_cd/morimoto/linux/Makefile:1843: kernel] error 2
> >
> > This patch makes it to inline again, and fixes the issue.
> >
> > Fixes:  53cd885bc5c3e ("ftrace: Allow IPMODIFY and DIRECT ops on the same function")
> > CC: Song Liu <song@kernel.org>
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>  
> 
> Acked-by: Song Liu <song@kernel.org>
> 
> Thanks for the fix!

Wrong fix.

The correct fix is here[1], and because the breakage went through the BPF
tree, I could not apply it. Now that both the BPF and my tree is in Linus's
tree, I can apply it and now will do so.

-- Steve

[1] https://lore.kernel.org/all/20220801084745.1187987-1-wangjingjin1@huawei.com/
