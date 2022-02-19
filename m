Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831034BC714
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 10:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241771AbiBSJYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 04:24:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiBSJYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 04:24:47 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9874824CCD8
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 01:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xIze7FiaNNWSuC34TPpTOugfizZwVMOBTe/chVGWA6g=; b=Z9uVmAbm6hrPyXn8W18wm4coy+
        b5mnCip+lOnLB5Ja/hXTe+wo7cz2nQpSRqdL4EsXwo2to2oruylNkvWMd8srINAQA+nQb6eAiRQkx
        MgWMj5j/imwWROdTYSzbhtAIzYvgPYcjcu0PQFwqrRoEgA8hlQ/9IuhVdJmVS0X6KfOQpGnXOQ2Ja
        pykHZL19qz6UKzldSmK3elo/Ij83HBI2kxxW8b8EjI2x/AnkJiOX6olguxjl0Bv4wosRV1kTTFjso
        S1DizOHl8Az4OUjQnjZqEus2sb03EzdYOg4TSMWV+thuaIk9FwFLHP1u9lynUmHN4LizbgUj2yczS
        FN6mLg7Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nLLyJ-00B2fx-BX; Sat, 19 Feb 2022 09:24:07 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 90C6598681B; Sat, 19 Feb 2022 10:24:05 +0100 (CET)
Date:   Sat, 19 Feb 2022 10:24:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com
Subject: Re: [PATCH 14/29] x86/ibt: Add IBT feature, MSR and #CP handling
Message-ID: <20220219092405.GF23216@worktop.programming.kicks-ass.net>
References: <20220218164902.008644515@infradead.org>
 <20220218171409.395399333@infradead.org>
 <20220219012155.z24prt3yj25ytacs@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220219012155.z24prt3yj25ytacs@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 05:21:55PM -0800, Josh Poimboeuf wrote:
> On Fri, Feb 18, 2022 at 05:49:16PM +0100, Peter Zijlstra wrote:
> > +DEFINE_IDTENTRY_ERRORCODE(exc_control_protection)
> > +{
> > +	if (!cpu_feature_enabled(X86_FEATURE_IBT)) {
> > +		pr_err("Whaaa?!?!\n");
> > +		return;
> > +	}
> 
> Might want to upgrade that to a proper warning :-)

"Unexpected #CP\n" ?

> > +bool ibt_selftest(void)
> > +{
> > +	ibt_selftest_ok = false;
> > +
> > +	asm (ANNOTATE_NOENDBR
> > +	     "1: lea 2f(%%rip), %%rax\n\t"
> > +	     ANNOTATE_RETPOLINE_SAFE
> > +	     "   jmp *%%rax\n\t"
> > +	     "2: nop\n\t"
> > +
> > +	     /* unsigned ibt_selftest_ip = 2b */
> > +	     ".pushsection .data,\"aw\"\n\t"
> > +	     ".align 8\n\t"
> > +	     ".type ibt_selftest_ip, @object\n\t"
> > +	     ".size ibt_selftest_ip, 8\n\t"
> > +	     "ibt_selftest_ip:\n\t"
> > +	     ".quad 2b\n\t"
> > +	     ".popsection\n\t"
> > +
> > +	     : : : "rax", "memory");
> 
> Can 'ibt_selftest_ip' just be defined in C (with __ro_after_init) and
> passed as an output to the asm doing 'mov $2b, %[ibt_selftest_ip]'?

This seemed simpler... note that it's ran on cpu bringup, so if you do
cpu hotplug it'll end up trying to write to ro memory if you do what you
suggest.
