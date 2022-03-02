Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0598F4CA208
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 11:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240962AbiCBKV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 05:21:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbiCBKV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 05:21:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A05590CE5
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 02:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=y0hy6EqXU4vT2NZrGaKXn684V4M9fIimgjn96Bc+BYY=; b=vS3O4lR/jJYBkBajYNAnkD8/AS
        V0GR9O7aJdDsCR+K03vMEkui0C0LusWThpAaEqaGRfTBPi1ThTAWE722Lx/jY8X0fiF078X3L0QJw
        YhSpYkhto0VwjCF4bziUZK7JHjObvczLni6Gotbl0eBeInhCfKgDUYEPHMhVHGaim5/ArfFzRe3z/
        Fa4a5HzxvO2MRSHY7lGZ8q8pczgzQ+L8FcLo5ZFUmgKZYFk6LmSgi+evObPm4t+GjlURvPzes2l9j
        b/Q3SHH3tcurFODBwOn2kHpAvX1QEAYh2SJRE4gALEh5PT/jYbrvOeiO2Pm/cJ9SFgSKaYQqHGu55
        9+a9vtMw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPM5h-00AU6D-Dn; Wed, 02 Mar 2022 10:20:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4E06230018E;
        Wed,  2 Mar 2022 11:20:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 29B6D31C7567A; Wed,  2 Mar 2022 11:20:15 +0100 (CET)
Date:   Wed, 2 Mar 2022 11:20:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 00/39] x86: Kernel IBT
Message-ID: <Yh9E33Eijbio40QP@hirez.programming.kicks-ass.net>
References: <20220224145138.952963315@infradead.org>
 <20220224202602.3gvz5tnxvwb4maod@treble>
 <Yhj1oFcTl2RnghBz@hirez.programming.kicks-ass.net>
 <20220301231022.5jb7rkzgpe7mwwku@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301231022.5jb7rkzgpe7mwwku@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 03:10:22PM -0800, Josh Poimboeuf wrote:
> On Fri, Feb 25, 2022 at 04:28:32PM +0100, Peter Zijlstra wrote:
> > @@ -636,7 +649,10 @@ static __always_inline void setup_cet(st
> >  	if (!ibt_selftest()) {
> >  		pr_err("IBT selftest: Failed!\n");
> >  		setup_clear_cpu_cap(X86_FEATURE_IBT);
> > +		return;
> >  	}
> > +
> > +	pr_info("CET detected: Indirect Branch Tracking enabled\n");
> 
> This is a little excessive on my 192 CPUs :-)
> 
> It also messes with the pr_cont()s in announce_cpu():

Hehe, I just noticed the same when looking at logs trying to figure out
if kexec worked. I'll go fix.
