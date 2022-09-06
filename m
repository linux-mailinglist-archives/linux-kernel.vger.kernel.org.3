Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6BE5ADCE9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 03:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbiIFBdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 21:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiIFBdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 21:33:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB5062AB0
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 18:33:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 157A2611A0
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 01:33:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF4EC433D6;
        Tue,  6 Sep 2022 01:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662428013;
        bh=DtF1wf6XJDOZ0PaJabdgE+Z19vLPh70/tI4A10YHHrw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eA1c9FFIc0MHo3CTUpfhZM2cELQjDTkhgnMm0N8flI5l9KHXUc3vaI/hlHjgrrkRa
         pBM1DztamFxF5ffMHkPhHhGxYj+IUEcUOWeaykQdvXDg3DXZ+RQ9m+6xsDXezIDtox
         mUEjZPM9/BO6Ortfeeycq2XSM0vCbmV+oNjAXok8ZHE1AUP1/ea5jDH5rSAOvUQ8im
         NklwI92QKSURPmP4tbr3PixCo5EKIClyPKDU0UH0d2/28kXBcNZ/fM4YGIFQkMvKYB
         7CHIj7sF1Y7TsH+ANUebkTG1CCqVq7FdV6uu6alJoTbvuNNndigJCt8+zBJg2w9kgX
         kX1tma0G5TaQg==
Date:   Tue, 6 Sep 2022 10:33:29 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Borislav Petkov <bp@suse.de>, Josh Poimboeuf <jpoimboe@kernel.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: CONFIG_RETHUNK int3 filling prevents kprobes in function body
Message-Id: <20220906103329.a2e79b1763bad299c0e1f11e@kernel.org>
In-Reply-To: <YxYbPTmN1TCp4En5@hirez.programming.kicks-ass.net>
References: <20220904230713.a461f8fe85329663226c755f@kernel.org>
        <YxYRHHuTHjzgCuE8@hirez.programming.kicks-ass.net>
        <YxYbPTmN1TCp4En5@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Sep 2022 17:52:29 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Sep 05, 2022 at 05:09:16PM +0200, Peter Zijlstra wrote:
> 
> > > This is because kprobes decodes function body to ensure the probed address
> > > is an instruction boundary, and if it finds the 0xcc (int3), it stops
> > > decoding and reject probing because the int3 is usually used for a
> > > software breakpoint and is replacing some other instruction. Without
> > > recovering the instruction, it can not continue decoding safely.
> > 
> > I can't follow this logic. Decoding the single byte int3 instruction is
> > trivial. If you want a sanity check, follow the branches you found while
> > decoding the instruction starting at +0.
> 
> Specifically, kprobe is the only one scribbling random [*] instructions
> with int3 in kernel text, so if kprobes doesn't know about the int3, it
> must be padding.

No, kgdb is also handles int3 for its breakpoint. Of course we can
ignore it or ask kgdb to expose the API to decode it.

> 
> [*] there's also static_call, jump_label and ftrace that use
> text_poke_bp() to scribble instructions but those are well known
> locations.

Yeah, but it is a temporal use, so user can try it again.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
