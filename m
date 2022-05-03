Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4414F518086
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 11:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbiECJGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 05:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbiECJGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 05:06:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8A71BE93
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 02:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5O6c3B2G4ATQzt41JF7cPhxmcMJAP+1Vhq3o1ro6XSU=; b=OAYZvaR+RB2+gD4X5imWkyutxy
        FWa/zLn4b2dByDtc6T5JUVfmxjfUbhwLKj4vN2E3AU6QZF7s4Tvloe4APuHIUsiOOnOiVOLHlwRvl
        o7SOy5mNE5lTDtZWhmvEOQnqxS2qTEZiiqWnzxEhbZ5H7bVhldeS9Si8SatCH/daPCqp+cUVORMEz
        kxpUPLtxHr5W9+dbnFxbL4Ucmgl/igBGrdfbv616G+r+uM/FYympu+VQWSCCFWzgNMEXYnf49TGSb
        tuRIf/KVLy5eJqNJuNJVtVX1/FV+xYu8Dw+Tf561WiA9+qX71nHHkJ2m4yVhLRr8kLpcN7RipKiRB
        em5cYHuA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nloR2-00FWwt-8Y; Tue, 03 May 2022 09:03:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DB1A73005E5;
        Tue,  3 May 2022 11:03:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C47C120288CED; Tue,  3 May 2022 11:03:05 +0200 (CEST)
Date:   Tue, 3 May 2022 11:03:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [patch 3/3] x86/fpu: Make FPU protection more robust
Message-ID: <YnDvye07/jRMBiPx@hirez.programming.kicks-ass.net>
References: <20220501192740.203963477@linutronix.de>
 <20220501193102.704267030@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220501193102.704267030@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 01, 2022 at 09:31:47PM +0200, Thomas Gleixner wrote:
> +void fpregs_lock(void)
> +{
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> +		local_bh_disable();
> +	else
> +		preempt_disable();
> +
> +	WARN_ON_ONCE(this_cpu_read(fpu_in_use));
> +	this_cpu_write(fpu_in_use, true);

	barrier();
> +}
> +EXPORT_SYMBOL_GPL(fpregs_lock);

> +void fpregs_unlock(void)
> +{
	barrier();

> +	WARN_ON_ONCE(!this_cpu_read(fpu_in_use));
> +	this_cpu_write(fpu_in_use, false);
> +
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> +		local_bh_enable();
> +	else
> +		preempt_enable();
> +}
> +EXPORT_SYMBOL_GPL(fpregs_unlock);

I think this isn't currently a problem because a function call is a C
sequence point, but 'funnily' C doesn't preserve sequence points when
inlining so LTO can actually break this without barrier() on.
