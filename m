Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501704C534F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 03:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiBZCLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 21:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiBZCLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 21:11:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13E62A260
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 18:10:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4D0461E20
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 02:10:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 331B6C340E7;
        Sat, 26 Feb 2022 02:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645841446;
        bh=AV3sdxBqak7FnOl47IK+1riBgeHHcDfaa81rdgxXet8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QJrYoMWTq9PvTTpdPhVH+P9sQw3r/djy8+OBcJAeB6Uz+whB/SCwsb4yhhS10qt5t
         WxlbXMtzKEUTh2thtZ0BO8uaHwEP7ImyNOqEShnTtQGfpeu6MaMGmyT6++HrOs01ZG
         Qjnq1tL9R3hAnqCJRNNXbwlDOu2tqHHQ3L8kzUjehU6xkxo5lKrg8+n8CLIAEVT9wt
         wYR4tMJFaRxEOvpbe2THcE9fvtRmGmmCPYaXwB1hcsszErqtREimEDpm/NzX0Og6Em
         4jmNpZDyjJlp9dMKepaEZKJNw3KLDMLKpInt7dZ5MNiffyA6D00NwtEgV3mqbkBn94
         InDFYB8ZReqcw==
Date:   Sat, 26 Feb 2022 11:10:40 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        keescook@chromium.org, samitolvanen@google.com,
        mark.rutland@arm.com, alyssa.milburn@intel.com, mbenes@suse.cz,
        rostedt@goodmis.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 15/39] x86/ibt,kprobes: Fix more +0 assumptions
Message-Id: <20220226111040.49b6b82a6c0caebee8c6d552@kernel.org>
In-Reply-To: <Yhj4myrr0X6USU3+@hirez.programming.kicks-ass.net>
References: <20220224145138.952963315@infradead.org>
        <20220224151322.892372059@infradead.org>
        <20220225103215.77080de0b3edd0fa2839b8fa@kernel.org>
        <YhizfwoddLwWWl2J@hirez.programming.kicks-ass.net>
        <20220225224249.cbabe82e530758cdb28e65e9@kernel.org>
        <Yhj4myrr0X6USU3+@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Feb 2022 16:41:15 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Feb 25, 2022 at 10:42:49PM +0900, Masami Hiramatsu wrote:
> 
> > OK, this sounds like kp->addr should be "call fentry" if there is ENDBR.
> > 
> > > 
> > > This patch takes the approach that sym+0 means __fentry__, irrespective
> > > of where it might actually live. I *think* that's more or less
> > > consistent with what other architectures do; specifically see
> > > arch/powerpc/kernel/kprobes.c:kprobe_lookup_name(). I'm not quite sure
> > > what ARM64 does when it has BTI on (which is then very similar to what
> > > we have here).
> > 
> > Yeah, I know the powerpc does such thing, but I think that is not what
> > user expected. I actually would like to fix that, because in powerpc
> > and other non-x86 case (without BTI/IBT), the instructions on sym+0 is
> > actually executed.
> > 
> > > 
> > > What do you think makes most sense here?
> > 
> > Are there any way to distinguish the "preparing instructions" (part of
> > calling mcount) and this kind of trap instruction online[1]? If possible,
> > I would like to skip such traps, but put the probe on preparing
> > instructions.
> 
> None that exist, but we could easily create one. See also my email here:
> 
>   https://lkml.kernel.org/r/Yhj1oFcTl2RnghBz@hirez.programming.kicks-ass.net
> 
> That skip_endbr() function is basically what you're looking for; it just
> needs a better name and a Power/ARM64 implementation to get what you
> want, right?

Great! that's what I need. I think is_endbr() is also useful :)

> The alternative 'hack' I've been contemplating is (ab)using
> INT_MIN/INT_MAX offset for __fentry__ and __fexit__ points (that latter
> is something we'll probably have to grow when CET-SHSTK or backward-edge
> CFI gets to be done, because then ROP tricks as used by function-graph
> and kretprobes are out the window).
> 
> That way sym+[0..size) is still a valid reference to the actual
> instruction in the symbol, but sym+INT_MIN will hard map to __fentry__
> while sym+INT_MAX will get us __fexit__.

Interesting, is that done by another series?
Maybe I have to check that change for kprobe jump optimization.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
