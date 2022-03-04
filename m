Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE884CDEF8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 22:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiCDUjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 15:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiCDUju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:39:50 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96B9221BA0
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 12:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mmFxld3sjSIIAlSRRdyYZzWzINkREaUw7efviHCHhbc=; b=GjFOIodAiTDkMMuGxA71i5bxJh
        T5ttLY3DMU7/N6cZga9IHZQJo5/umMjWI7l6mBDxzHaqif+OCj1w1Uj3ygxyIYXVME9yA/YaPEbA1
        km+5wWur3Kljart08+Du8rHjk5ZLFEkgNA57qsWvz+CzQSOMoFt0yb3hkkyHf99PIQvQzEP5CzEmT
        j6kyhSCHuG8hbOiy+/H8UbGtGgCIuqYVBLjcfBU1NJG/Wlr4AycavaVKCFBa23QPIyzOJMw30aQDt
        F68L3MunFxS5C1mGkUVEb7T/zQZBgsSM/SClATDwHpUC+V/wrnBtBY3qpAXTz4xdq8UZHknM2o+RM
        EJWfnyzw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nQEhE-00D0K1-1R; Fri, 04 Mar 2022 20:38:40 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id A1C2498624E; Fri,  4 Mar 2022 21:38:39 +0100 (CET)
Date:   Fri, 4 Mar 2022 21:38:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v3 22/39] x86/ibt: Add IBT feature, MSR and #CP handling
Message-ID: <20220304203839.GQ11184@worktop.programming.kicks-ass.net>
References: <20220303112321.422525803@infradead.org>
 <20220303112826.299051388@infradead.org>
 <20220304175733.zoik2fqpizygnlq7@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304175733.zoik2fqpizygnlq7@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 09:57:33AM -0800, Josh Poimboeuf wrote:
> On Thu, Mar 03, 2022 at 12:23:43PM +0100, Peter Zijlstra wrote:
> > +bool ibt_selftest(void)
> > +{
> > +	unsigned long ret;
> > +
> > +	asm ("	lea ibt_selftest_ip(%%rip), %%rax\n\t"
> > +	     ANNOTATE_RETPOLINE_SAFE
> > +	     "	jmp *%%rax\n\t"
> > +	     ASM_REACHABLE
> > +	     ANNOTATE_NOENDBR
> > +	     "ibt_selftest_ip: nop\n\t"
> 
> Maybe pedantic, but I find the annotations to be less surprising if they
> come after the label:
> 
> 	"ibt_selftest_ip:\n\t"
> 	ASM_REACHABLE
> 	ANNOTATE_NOENDBR
> 	"nop\n\t"

Done.
