Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5BD4C4235
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 11:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239456AbiBYKZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 05:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbiBYKZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 05:25:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0C21DDFD7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 02:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HnnMVWtbTd/SIAdg2NuHnARmzN5yACli763zGjn5X+o=; b=cbMnRAl0zd/ZS47ZcZk5SUe1Gu
        FD3t+QWmGDhkAdWrxixISbMlDya7dk3H6iuwE1LR9SdXDPO7BOuY7MzTfQYZzK6bDXhHZURsNEQjr
        tOsDf4eSMHiC1jNu6a574WuwbdTCtW82snf3wwnONIs+ijYHAWL0jIPFuwfHzoALouKD9tMdsMli7
        Bsr9lbyOK8aLdwW6xl2lNPFhioIaoJAUbi1qtDkwUbs4sVzfdDAmai89dSk90XXOdANslBftIReLN
        Jzohtebc6SMIyQlM4iYUr7t+xn0XZwyQ98GeElpn0o5vkG/vr/ziSFnDpWUxN3/VRs8bjRt6Lzsw/
        A28o9H4Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNXm8-005gu5-O7; Fri, 25 Feb 2022 10:24:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5B7A23001C0;
        Fri, 25 Feb 2022 11:24:36 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 45D3F2D66C436; Fri, 25 Feb 2022 11:24:36 +0100 (CET)
Date:   Fri, 25 Feb 2022 11:24:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 11/39] x86/ibt,kvm: Add ENDBR to fastops
Message-ID: <YhiuZJpwq/bMZYgn@hirez.programming.kicks-ass.net>
References: <20220224145138.952963315@infradead.org>
 <20220224151322.656194153@infradead.org>
 <202202241651.B5FB7DBE@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202202241651.B5FB7DBE@keescook>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 04:54:04PM -0800, Kees Cook wrote:
> On Thu, Feb 24, 2022 at 03:51:49PM +0100, Peter Zijlstra wrote:
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  arch/x86/kvm/emulate.c |    6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > --- a/arch/x86/kvm/emulate.c
> > +++ b/arch/x86/kvm/emulate.c
> > @@ -189,7 +189,7 @@
> >  #define X16(x...) X8(x), X8(x)
> >  
> >  #define NR_FASTOP (ilog2(sizeof(ulong)) + 1)
> > -#define FASTOP_SIZE 8
> > +#define FASTOP_SIZE (8 * (1 + HAS_KERNEL_IBT))
> 
> Err, is this right? FASTOP_SIZE is used both as a size and an alignment.
> But the ENDBR instruction is 4 bytes? Commit log maybe needed to
> describe this.

Note how that comes out as 8*1 or 8*2, iow 8 or 16. Does that clarify?
That is, 8+4 being 12 is ovbiuosly a fail for alignment.
