Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52DFE4C55B2
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 12:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbiBZLtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 06:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiBZLty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 06:49:54 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3011A26372D
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 03:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UlDCQiGwaD/6NgzvxKMYssO1Vg316rUDPKnel4O4TSg=; b=ieGeELfFyjZfFKdVB17t3WXAr+
        m+NwaZ7B9F2M7YCySM5WyucRLGiTsTcfLwZMWnEpkfffA2zm9TkoG0Yn0ohQ1gVFx88pD/RZO/skt
        Jse63zSp3ik4iZ/1rx1eZqJS86bmfqWZA+XilgKbxxn5S70qBdfn5X0PvHUu+f1OZAbOYN3+ChdB/
        HzEEnB2pEIyipDFlQ6YQgZLxNWx42V6Jq1K9ax8DHDRfup/9c9wV/YYwWo8X1T2hxi5ok3zqGE+7T
        Rsl06GgQq5XVkDzCyubaeRfJND7B9tRSDVo5XgIpoNBdlRq3hIMHnTj28RSpjeRzfMRt5NuaaKAgq
        4vzZSxcA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNvZB-00DCsT-5v; Sat, 26 Feb 2022 11:48:49 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 633C1986AEC; Sat, 26 Feb 2022 12:48:47 +0100 (CET)
Date:   Sat, 26 Feb 2022 12:48:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        keescook@chromium.org, samitolvanen@google.com,
        mark.rutland@arm.com, alyssa.milburn@intel.com, mbenes@suse.cz,
        rostedt@goodmis.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 15/39] x86/ibt,kprobes: Fix more +0 assumptions
Message-ID: <20220226114847.GB11184@worktop.programming.kicks-ass.net>
References: <20220224145138.952963315@infradead.org>
 <20220224151322.892372059@infradead.org>
 <20220225103215.77080de0b3edd0fa2839b8fa@kernel.org>
 <YhizfwoddLwWWl2J@hirez.programming.kicks-ass.net>
 <20220225224249.cbabe82e530758cdb28e65e9@kernel.org>
 <Yhj4myrr0X6USU3+@hirez.programming.kicks-ass.net>
 <20220226111040.49b6b82a6c0caebee8c6d552@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220226111040.49b6b82a6c0caebee8c6d552@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 26, 2022 at 11:10:40AM +0900, Masami Hiramatsu wrote:

> > The alternative 'hack' I've been contemplating is (ab)using
> > INT_MIN/INT_MAX offset for __fentry__ and __fexit__ points (that latter
> > is something we'll probably have to grow when CET-SHSTK or backward-edge
> > CFI gets to be done, because then ROP tricks as used by function-graph
> > and kretprobes are out the window).
> > 
> > That way sym+[0..size) is still a valid reference to the actual
> > instruction in the symbol, but sym+INT_MIN will hard map to __fentry__
> > while sym+INT_MAX will get us __fexit__.
> 
> Interesting, is that done by another series?

Not yet, that was just a crazy idea I had ;-)
