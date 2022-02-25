Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAFB4C4321
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 12:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239951AbiBYLLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 06:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239946AbiBYLLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 06:11:38 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633FC24FA2D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 03:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5ipedI2GJe9BXgCHhf6X9P+FL8RU27ysrk/OO3JPA2o=; b=PZTOn2zt+0dtYAo9K9q7v0k121
        9RekL3qFgxOylXp/M6JuX79relklHfp3ZIIYlPGW9Iqsp14XdDrcyLeZaMrfb4ecHLnfOhd4VO7ip
        p5zqQ1BK2jNYJvp4qXpkKwSagok9Wu5NUg8OL69eklF5AKcDIMhgoCwLk5Nq3jiVv/FxGaSzt0Wz/
        0cM3AvMLFQXuvSiqYsFiS61rdSvXEfd7TwJI4fSbeKlJswXjQ0PPur1hES73z+0zJSm6sba0/xSgE
        aGWX1ErGAUtnRTeeh/OcCCL9xf3kh42AO3GIfFZlF0SILXhPu6KbVY5rcd2TQH6Em2uMUgM1Oe9jq
        9+bPMn9g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNYUi-00CwMF-Lk; Fri, 25 Feb 2022 11:10:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C73D23001C0;
        Fri, 25 Feb 2022 12:10:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 88CCB2D66F34C; Fri, 25 Feb 2022 12:10:39 +0100 (CET)
Date:   Fri, 25 Feb 2022 12:10:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 18/39] x86/ibt: Add IBT feature, MSR and #CP handling
Message-ID: <Yhi5Lx0Nl1kHimXi@hirez.programming.kicks-ass.net>
References: <20220224145138.952963315@infradead.org>
 <20220224151323.069205370@infradead.org>
 <20220224235516.qdikcfdl7jo35iu6@treble>
 <Yhi0lY8w3E5VKquU@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yhi0lY8w3E5VKquU@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 11:51:01AM +0100, Peter Zijlstra wrote:
> On Thu, Feb 24, 2022 at 03:55:16PM -0800, Josh Poimboeuf wrote:
> > On Thu, Feb 24, 2022 at 03:51:56PM +0100, Peter Zijlstra wrote:
> > > +static __always_inline void setup_cet(struct cpuinfo_x86 *c)
> > > +{
> > > +	u64 msr = CET_ENDBR_EN;
> > > +
> > > +	if (!HAS_KERNEL_IBT ||
> > > +	    !cpu_feature_enabled(X86_FEATURE_IBT))
> > > +		return;
> > 
> > If you add X86_FEATURE_BIT to arch/x86/include/asm/disabled-features.h,
> > the HAS_KERNEL_IBT check becomes redundant.
> 
> Cute.

On second thought; I'm not sure that's desirable. Ideally KVM would
still expose IBT if present on the hardware, even if the host kernel
doesn't use it.

Killing the feature when the host doesn't use it seems unfortunate.
