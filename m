Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28AE4C79D0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 21:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiB1UKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 15:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiB1UKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 15:10:39 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40852888FB
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 12:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LKVWP8B+dI0EaZkytYActdFU39zpsIqLuQva1HVoMGg=; b=V8SES8QyyNE0exxZXZafkkTxrn
        K/0Gadad546pboJjUBuVT60uhMZp4a3+RrZFobLie04dlhnVYwG1MOjbq0AkPpDWWBC98sUMiFpg5
        0hsEJ7bnEKt9FWesLv/AC1o2xSsUtTIy3pT2cRe+c8wOKAD4pi4nUY9zUuCUsKvLXF0ad1c4F/WRJ
        8oW4Niu1+yv+42CuKrw5niLpiYOev0WY7G+ZllnRf1QmWc6lZU2QVLIWeuQUWvrSGIVKBQRtxsSJ1
        iXZ8jdwV5gWHgvzGeV+lba6JnmgC+F4wefqocfL8woQKxgmyF230pRG726UIL8cjZYZwfRSlDtvN3
        OuEuyKjg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOmKt-00DztU-Ub; Mon, 28 Feb 2022 20:09:36 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2ED64986271; Mon, 28 Feb 2022 21:09:34 +0100 (CET)
Date:   Mon, 28 Feb 2022 21:09:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com
Subject: Re: [PATCH 21/29] objtool: Rename --duplicate to --lto
Message-ID: <20220228200934.GF11184@worktop.programming.kicks-ass.net>
References: <20220218164902.008644515@infradead.org>
 <20220218171409.814392411@infradead.org>
 <20220226194209.bvv3t65hhtnwltmk@treble>
 <20220226214802.4chmsrtstlerefmu@treble>
 <YhysYkcfwLr68Job@hirez.programming.kicks-ass.net>
 <20220228183228.splleoatuxxjr5kq@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228183228.splleoatuxxjr5kq@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 10:32:28AM -0800, Josh Poimboeuf wrote:

> Thanks for the explanations.  To summarize, we have:
> 
>   A) legacy mode:
> 
>      translation unit: objtool check [--module]
>      vmlinux.o:        N/A
>      module:           N/A
> 
>   B) CONFIG_VMLINUX_VALIDATION=y && !(CONFIG_X86_KERNEL_IBT=y || CONFIG_LTO=y)
> 
>      translation unit: objtool check [--module]
>      vmlinux:          objtool check --vmlinux --noinstr
>      module:           objtool check --module --noinstr

Not the module thing here; noinstr never leaves the core kernel (for
now; I need me a few compiler features before I can tackle the idle path
issues).

>   C) CONFIG_X86_KERNEL_IBT=y || CONFIG_LTO=y:
> 
>      translation unit: N/A
>      vmlinux:          objtool check --vmlinux --noinstr --lto
>      module:           objtool check --module --noinstr --lto
> 
> Right?

More or less, with the one caveat above.

> I think I get it, but it's mental gymnastics for me to remember how the
> options interact.  It still seems counterintuitive, because whatever
> "objtool check" does to a translation unit, I'd expect "objtool check
> --vmlinux" to do the same things.

I think I agree. It is a bit weird.

> So how about we just get rid of the magical --vmlinux and --lto options
> altogether, and make --noinstr additive, like all the other options?
>
>   A) legacy mode:
>      .o files: objtool check [--module]
>       vmlinux: N/A
>        module: N/A
>
>   B) CONFIG_NOINSTR_VALIDATION=y && !(CONFIG_X86_KERNEL_IBT=y || CONFIG_LTO=y):
>      .o files: objtool check [--module]
>       vmlinux: objtool check --noinstr-only
>        module: objtool check --module --noinstr-only
>
>   C) CONFIG_X86_KERNEL_IBT=y || CONFIG_LTO=y:
>      .o files: N/A
>       vmlinux: objtool check --noinstr
>        module: objtool check --module --noinstr

I like the --noinstr-only thing. But I think I still like a flag to
differentiate between TU/.o file and vmlinux/whole-module invocation.

Anyway, you ok with me cleaning this up later, in a separate series?
