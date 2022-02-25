Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513BB4C45C9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241055AbiBYNRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241028AbiBYNRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:17:36 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B41AE33BA
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gcLU/vg5cewrZSDPx6TyApuKFbZkoUXSLj0y9z6R8Vs=; b=kNwTCnRyfhWL3uD70G4U8KIVqz
        sY9HFyXny7cGN6e54CjSPbSfbxlEtWUURwNO1LjWDjtBsj8W+qtz0UR/Y8LMiten7EdKb2uH8IHQ4
        RGnpC50hYlMY6cuR3WTbLIrLn5wnVt/Rq35fZsX8xDGCXcsyiyOOOgqUte5rizwFHw0rWlwqxgg10
        ShuhzQFN8R6y4fSTqVKH4N4YW/RnRKSVgtDXaXtRilLwH2IOoOaYjMWBfBqOW3DvBBZ63ZCXk9ilc
        eJxaxestRjhZnZ41qXqPXDr+f7R2YOKDPnhzHk3bdpkOVfGJJRKZW22XZqM/3Uiak1S+RZZC/kZtJ
        JD4WZDbA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNaSe-005nss-GQ; Fri, 25 Feb 2022 13:16:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8426C30081D;
        Fri, 25 Feb 2022 14:16:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4552B235EF288; Fri, 25 Feb 2022 14:16:39 +0100 (CET)
Date:   Fri, 25 Feb 2022 14:16:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 28/39] x86/ibt,xen: Sprinkle the ENDBR
Message-ID: <YhjWt0vCva5Pd4BC@hirez.programming.kicks-ass.net>
References: <20220224145138.952963315@infradead.org>
 <20220224151323.661210297@infradead.org>
 <20220225005440.mvz4jtxwq5ttcu77@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225005440.mvz4jtxwq5ttcu77@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 04:54:40PM -0800, Josh Poimboeuf wrote:
> On Thu, Feb 24, 2022 at 03:52:06PM +0100, Peter Zijlstra wrote:
> > +++ b/arch/x86/xen/xen-head.S
> > @@ -25,8 +25,11 @@
> >  SYM_CODE_START(hypercall_page)
> >  	.rept (PAGE_SIZE / 32)
> >  		UNWIND_HINT_FUNC
> > -		.skip 31, 0x90
> > -		RET
> > +		ANNOTATE_NOENDBR
> > +		/*
> > +		 * Xen will write the hypercall page, and sort out ENDBR.
> > +		 */
> > +		.skip 32, 0xcc
> 
> I seem to remember this UNWIND_HINT_FUNC was only there to silence
> warnings because of the ret.  With the ret gone, maybe the hint can be
> dropped as well.

vmlinux.o: warning: objtool: xen_hypercall_iret()+0x0: stack state mismatch: cfa1=4+8 cfa2=-1+0

and back it goes ;-)
