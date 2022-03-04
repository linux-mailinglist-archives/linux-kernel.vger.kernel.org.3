Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8EC34CDFDC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 22:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiCDVqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 16:46:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiCDVqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 16:46:14 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943E622A253
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 13:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=INVGe6QUc3iKgjOQ44WUyIqkXLUctmIITo+hwip/FXA=; b=p6mwanCi8Tl3gV+nqLIPLUADGy
        WjcMFqDvlUMFdGz1p4YqlB+3nI7msLp5hyOkQYAhc8wKb5RkvXxlvhQx73k4wlx35NvWxKbPEb82u
        EIEzt3wdUemXM5lKHWvkpOfpfTs3/aln8zqxTS5zQu/q0RaEkr3h4lYcINUAm/9uGH7F2KCGdjVT/
        pJWqceKK7PzNQPHOugtis3sYqjV2oHrkxNeDAO6NjbuZd1sxJP9YGMng3ngJzpWGqZOa5V9f0hmps
        cuKcjWcnLFKVl5Yym2vbQQaW9RZlyKjooH2YRVmfXZkccWmcMU9BoUY7nVslPhdaZ8wcmWM3zv6Pz
        d/TxyRdA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nQFjM-00FJxs-Fj; Fri, 04 Mar 2022 21:44:57 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 813CC986ACA; Fri,  4 Mar 2022 22:44:54 +0100 (CET)
Date:   Fri, 4 Mar 2022 22:44:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v3 18/39] x86/ibt,ftrace: Make function-graph play nice
Message-ID: <20220304214454.GT11184@worktop.programming.kicks-ass.net>
References: <20220303112321.422525803@infradead.org>
 <20220303112826.044301664@infradead.org>
 <20220304175154.l2otvmqd4r7ozsuy@treble>
 <20220304194853.GN11184@worktop.programming.kicks-ass.net>
 <20220304210334.pmrhhcm5okzcr5cd@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304210334.pmrhhcm5okzcr5cd@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 01:03:34PM -0800, Josh Poimboeuf wrote:
> On Fri, Mar 04, 2022 at 08:48:53PM +0100, Peter Zijlstra wrote:
> > On Fri, Mar 04, 2022 at 09:51:54AM -0800, Josh Poimboeuf wrote:
> > > On Thu, Mar 03, 2022 at 12:23:39PM +0100, Peter Zijlstra wrote:
> > > > +
> > > > +	addq $16, %rsp
> > > > +	ANNOTATE_INTRA_FUNCTION_CALL
> > > > +	call .Ldo_rop
> > > > +	int3
> > > > +.Ldo_rop:
> > > > +	mov %rdi, (%rsp)
> > > > +	UNWIND_HINT_FUNC
> > > > +	RET
> > > 
> > > Why the int3?
> > 
> > Speculation trap :-) Either I'm too paranoid or not paranoid enough; but
> > without it it's just too close to a retpoline and it doesn't feel right.
> 
> Um, it *is* a retpoline :-)
> 
> Can you just use the RETPOLINE macro?  Along with a comment stating why
> it can't just do a JMP_NOSPEC?

There is no RETPOLINE macro; or rather it is completely contained in
lib/retpoline.S and I'd sorta like to keep it that way.

That said, I can stick a comment on.
