Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038CC4C0FDD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 11:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239492AbiBWKKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 05:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiBWKKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 05:10:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC8D7461F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 02:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=43MTtx2ShEnwQ7emyxLNBwyvgk9UUmRrYt+AL3G2X3E=; b=MAwO5843UynMmVq6pOdzRwrKdU
        ymw8E6nboUNVzgqZc1GEWRxJzQHrAanRsnmIifeTKDlo6LvQzpukWnDoQu3HPkMFCbyP+MdZGImhj
        g/bQXCP4Hm1y2YqySe/QRMuA4QaUMbuUGC7vLxhC0nJYc+KyEF5aU8jeW5Wc4zqVZ5Zh9BS0ldJJ1
        4L4/deCAjYcYWUv66dT3qvr2mcs8E8BoNYEPwOyTXqWhOoIMl1A+Y2PS9cjp9mL7EOkTaw+CmvGAC
        TKnukLY+xR1LEdG4AohOkRbODzHuH1HhIbdZ3rqp+KjzqERS8oDKhXG6AEmDidpD86oYeNXV6UetF
        1cEtAnzw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMoag-003eMZ-RE; Wed, 23 Feb 2022 10:09:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BEFB7300296;
        Wed, 23 Feb 2022 11:09:44 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9C1C02B3A226E; Wed, 23 Feb 2022 11:09:44 +0100 (CET)
Date:   Wed, 23 Feb 2022 11:09:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 04/29] x86/livepatch: Validate __fentry__ location
Message-ID: <YhYH6FMNh8pMws6Z@hirez.programming.kicks-ass.net>
References: <20220218164902.008644515@infradead.org>
 <20220218171408.808810436@infradead.org>
 <20220218210831.u2ugtfr7gxllk4cs@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218210831.u2ugtfr7gxllk4cs@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 01:08:31PM -0800, Josh Poimboeuf wrote:
> On Fri, Feb 18, 2022 at 05:49:06PM +0100, Peter Zijlstra wrote:
> > Currently livepatch assumes __fentry__ lives at func+0, which is most
> > likely untrue with IBT on. Override the weak klp_get_ftrace_location()
> > function with an arch specific version that's IBT aware.
> > 
> > Also make the weak fallback verify the location is an actual ftrace
> > location as a sanity check.
> > 
> > Suggested-by: Miroslav Benes <mbenes@suse.cz>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  arch/x86/include/asm/livepatch.h |    9 +++++++++
> >  kernel/livepatch/patch.c         |    2 +-
> >  2 files changed, 10 insertions(+), 1 deletion(-)
> > 
> > --- a/arch/x86/include/asm/livepatch.h
> > +++ b/arch/x86/include/asm/livepatch.h
> > @@ -17,4 +17,13 @@ static inline void klp_arch_set_pc(struc
> >  	ftrace_instruction_pointer_set(fregs, ip);
> >  }
> >  
> > +#define klp_get_ftrace_location klp_get_ftrace_location
> > +static inline unsigned long klp_get_ftrace_location(unsigned long faddr)
> > +{
> > +	unsigned long addr = ftrace_location(faddr);
> > +	if (!addr && IS_ENABLED(CONFIG_X86_IBT))
> > +		addr = ftrace_location(faddr + 4);
> > +	return addr;
> 
> I'm kind of surprised this logic doesn't exist in ftrace itself.  Is
> livepatch really the only user that needs to find the fentry for a given
> function?
> 
> I had to do a double take for the ftrace_location() semantics, as I
> originally assumed that's what it did, based on its name and signature.
> 
> Instead it apparently functions like a bool but returns its argument on
> success.
> 
> Though the function comment tells a different story:
> 
> /**
>  * ftrace_location - return true if the ip giving is a traced location
> 
> So it's all kinds of confusing...

Yes.. so yesterday, when making function-graph tracing not explode, I
ran into a similar issue. Steve suggested something along the lines of
.... this.

(modified from his actual suggestion to also cover this case)

Let me go try this...

--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1578,7 +1578,23 @@ unsigned long ftrace_location_range(unsi
  */
 unsigned long ftrace_location(unsigned long ip)
 {
-	return ftrace_location_range(ip, ip);
+	struct dyn_ftrace *rec;
+	unsigned long offset;
+	unsigned long size;
+
+	rec = lookup_rec(ip, ip);
+	if (!rec) {
+		if (!kallsyms_lookup(ip, &size, &offset, NULL, NULL))
+			goto out;
+
+		rec = lookup_rec(ip - offset, (ip - offset) + size);
+	}
+
+	if (rec)
+		return rec->ip;
+
+out:
+	return 0;
 }
 
 /**
@@ -5110,11 +5126,16 @@ int register_ftrace_direct(unsigned long
 	struct ftrace_func_entry *entry;
 	struct ftrace_hash *free_hash = NULL;
 	struct dyn_ftrace *rec;
-	int ret = -EBUSY;
+	int ret = -ENODEV;
 
 	mutex_lock(&direct_mutex);
 
+	ip = ftrace_location(ip);
+	if (!ip)
+		goto out_unlock;
+
 	/* See if there's a direct function at @ip already */
+	ret = -EBUSY;
 	if (ftrace_find_rec_direct(ip))
 		goto out_unlock;
 
@@ -5222,6 +5243,10 @@ int unregister_ftrace_direct(unsigned lo
 
 	mutex_lock(&direct_mutex);
 
+	ip = ftrace_location(ip);
+	if (!ip)
+		goto out_unlock;
+
 	entry = find_direct_entry(&ip, NULL);
 	if (!entry)
 		goto out_unlock;
