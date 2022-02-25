Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C95E4C4495
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 13:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240634AbiBYM0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 07:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233526AbiBYMZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 07:25:58 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD8A214FAB
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 04:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wetlx8pI0yKHATB9ESKSriqsWC7CsRn5Xc7bxZta4Aw=; b=i77s9a6G8TM0KLbmJEc9D98PFB
        z6kCJPCvfM4pTyk8TiOhyVyVWRothwMQB2PLT4uoPbrBag+aVohqxXu7+jqojpAA/MBSb6Y9uLP2g
        kn/H9ZLS4hL1u78BTThg/WDilrlfD4iXHgsp6tvfEddBYEId6TG171m5hax2RO8lX+vB/d5bl3yPn
        rNLR7y2aK0GsKRdkQU8LgesZbX7iGLCtMGl2cTQcAq4YuR8jtHM5r17Xg1HfvrGWZD+cslDZUqnTG
        z7Kf2cEIBRzWkrkMfyomCWU1ScDezcKOQMU5Vu5v7cy5Yp0p8Dk2JBY3Ut2rGsWK9GuJyQAhr37R4
        R9kGsjng==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNZef-00CxRJ-D4; Fri, 25 Feb 2022 12:25:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2AEE3300067;
        Fri, 25 Feb 2022 13:24:58 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D45052D6F91B2; Fri, 25 Feb 2022 13:24:58 +0100 (CET)
Date:   Fri, 25 Feb 2022 13:24:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 16/39] x86/bpf: Add ENDBR instructions to prologue and
 trampoline
Message-ID: <YhjKmgIMmx+0Rt19@hirez.programming.kicks-ass.net>
References: <20220224145138.952963315@infradead.org>
 <20220224151322.950111925@infradead.org>
 <20220224233731.7hdwbszv5c6fgx4y@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224233731.7hdwbszv5c6fgx4y@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 03:37:31PM -0800, Josh Poimboeuf wrote:

> > @@ -2028,10 +2052,11 @@ int arch_prepare_bpf_trampoline(struct b
> >  		/* skip patched call instruction and point orig_call to actual
> >  		 * body of the kernel function.
> >  		 */
> > -		orig_call += X86_PATCH_SIZE;
> > +		orig_call += X86_PATCH_SIZE + 4*HAS_KERNEL_IBT;
> 
> All the "4*HAS_KERNEL_IBT" everywhere is cute, but you might as well
> just have IBT_ENDBR_SIZE (here and in other patches).

So there's two forms of this, only one has the 4 included:

  (x * (1 + HAS_KERNEL_IBT))
  (x + 4*HAS_KERNEL_IBT)

If I include the 4, then the first form would become something like:

  (x * (1 + !!IBT_ENDBR_SIZE))

that ok?
