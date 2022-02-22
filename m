Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F1D4BFB89
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 16:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbiBVPCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 10:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbiBVPCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:02:00 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1270E14EF74
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 07:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3m8N/pbSaW7IFq5Zg9KAiVLIQW/cSc9Z6gH3HL38bvM=; b=pruQPWEnrDH6n+wMF9FJQxB0ek
        zMnZf/+56aZavVGp2P8XWHAiMmLe72015warxfujwagX3xTjBsLvUJXFB7V/rJe2rlQALbXw+ejOo
        IXU4I07/dAThjMCiYbIs21318EH3wODNh5MUSli6/cNqlLaKa/oNtyMtnE4Uapp0K9PNSk62jhgnJ
        6dIE6Q0ENpeTYssHMzqD/9BxqCax/xajmz1KKthAruzmw3K8FCaOls9QrXeFolAGSvWAc3Fo4z59W
        bAMc/U3B3T1C4+lq55IvRtp+s9wdkgyrh2heX6jqJcYVxORzf1P7C8XpcYAVrl92g1mP2NLP9A2ng
        3dQ4Z5UQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMWeK-00ByR4-I2; Tue, 22 Feb 2022 15:00:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 62B553001C0;
        Tue, 22 Feb 2022 16:00:18 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2BED722149159; Tue, 22 Feb 2022 16:00:18 +0100 (CET)
Date:   Tue, 22 Feb 2022 16:00:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com
Subject: Re: [PATCH 16/29] x86/bugs: Disable Retpoline when IBT
Message-ID: <YhT6gthym/jCUME4@hirez.programming.kicks-ass.net>
References: <20220218164902.008644515@infradead.org>
 <20220218171409.520731494@infradead.org>
 <20220219021530.hq6po7uexc4w36qo@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220219021530.hq6po7uexc4w36qo@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 06:15:30PM -0800, Josh Poimboeuf wrote:

> This code is confusing, not helped by the fact that the existing code
> already looks like spaghetti.

I'd say that's an insult to spaghetti.

> Assuming IBT systems also have eIBRS (right?), I don't think the above
> SPECTRE_V2_CMD_{FORCE,AUTO} cases would be possible.

Virt FTW.. if I don't handle it, some idiot will create a virtual
machine that doesn't expose eIBRS but does do IBT just to spite me.

> AFAICT, if execution reached the retpoline_generic label, the user
> specified either RETPOLINE or RETPOLINE_GENERIC.

Only RETPOLINE_GENERIC;

> I'm not sure it makes sense to put RETPOLINE in the "silent" list.  If
> the user boots an Intel system with spectre_v2=retpoline on the cmdline,
> they're probably expecting a traditional retpoline and should be warned
> if that changes, especially if it's a "demotion".

too friggin bad as to expectations; retpoline == auto. Not saying that
makes sense, just saying that's what it does.

> In that case the switch statement isn't even needed.  It can instead
> just unconditinoally print the warning.
> 
> 
> Also, why "demote" retpoline to LFENCE rather than attempting to
> "promote" it to eIBRS?  Maybe there's a good reason but it probably at
> least deserves some mention in the commit log.

The current code will never select retpoline if eibrs is available.


The alternative is doing this in apply_retpolines(), but that might be
even more nasty.
