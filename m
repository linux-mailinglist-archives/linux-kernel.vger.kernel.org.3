Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0DA651A45A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352712AbiEDPqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352690AbiEDPp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:45:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6F14551E
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 08:42:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A81661CD7
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 15:42:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B4B8C385A5;
        Wed,  4 May 2022 15:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651678939;
        bh=rskwEFdpilIG2nL3FAfN32P0yaiAWDS1OUSeNHtqptc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=INtG+fMGb7nn1Zj75PcWGN3kXjFhwsGSfawFI+DwWjW2NeRy0kdcyKCtT90EhYi3B
         ZyTKpnr0E59HrA8b83hNrvDllVJx9BLX5xfrRjTUCyskQHWrYCTMyryHtpXfs37vxr
         daRw34ELX8rL2Yt8Lz54q6y3LBb+30wfxFt6wDufDeQfmlO0wJ7R7ffhdSNF4jtYwu
         1lGPe4X4uX69ztu6K5w7ZVAg1SWLoGVywMXqPrinyJNmAIUd+MWOKy8JeJaNDlz50A
         q/WmfFfoYY2qzgq/lmMZ5V86egwfdvU5YOFgsXwNY/ZwQBO51XtWpcvpHnDOzLlAbp
         FAWDj+RaQaZqw==
Date:   Thu, 5 May 2022 00:42:14 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] objtool: Fix STACK_FRAME_NON_STANDARD reloc type
Message-Id: <20220505004214.1e4e69f5ded3b591112851a0@kernel.org>
In-Reply-To: <20220502175921.oruktb6dleabvdyx@treble>
References: <20220429092024.GT2731@worktop.programming.kicks-ass.net>
        <YmvTbN966XmLSZk+@hirez.programming.kicks-ass.net>
        <20220429225636.6qm2orq4uwnl33ii@treble>
        <Ym0hAA66vijBo7iF@hirez.programming.kicks-ass.net>
        <20220502175921.oruktb6dleabvdyx@treble>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 May 2022 10:59:21 -0700
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> On Sat, Apr 30, 2022 at 01:44:00PM +0200, Peter Zijlstra wrote:
> > > > I also don't see any kprobe/optprobe hooks in unwind.h, so what happens
> > > > if we hit an optprobe?
> > > 
> > > Same as for any other generated code, the unwinder will try to fall back
> > > to frame pointers, and if that doesn't work, the unwind stops.
> > > 
> > > That commit didn't change anything since it was already not being
> > > directly executed anyway, but rather used to generate code on the fly.

Ah, OK. So ORC will not work on the dynamically generated trampoline code.
Can we generate ORC information entry dynamically?
(E.g. copying ORC data from the original code)

> > > 
> > > And before that commit it was being ignored by ORC anyway, thanks to
> > > STACK_FRAME_NON_STANDARD.  Which can now be removed since this code is
> > > now data and objtool will no longer try to understand it.
> > 
> > Right; but I suppose I'm wondering if we should fix this. It seems a
> > rather sub-optimal state of affairs.
> 
> Masami recently fixed some kprobes ORC issues but I don't know if this
> one was fixed.

I've fixed the kretprobe ORC unwinder issue. I need to check the optprobe
case too.

> 
> As to the whether it's worth fixing, I dunno.  There are trade offs.
> 
> Depends on how common the stack trace is -- I'm guessing not very, since
> I've never seen a bug report -- and how important it is to get to full
> ORC coverage.  If our goal is full coverage, we'd need a way for
> generated code to add/remove ORC entries.

Agreed, if I can copy the ORC entries for the original code to the entries
for generated code, I can fix it.

Thank you,


> 
> -- 
> Josh
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
