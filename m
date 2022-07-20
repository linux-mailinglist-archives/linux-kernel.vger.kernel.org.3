Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895A057B38B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 11:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235962AbiGTJMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 05:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiGTJM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 05:12:29 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D3A31202
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 02:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RoaZ9Vlk8y3ejRYTWUwxQrUIfXURJvoIFzXHdORTuF0=; b=DAXi3MTZ4gm3Wng6IvEhFMp+x/
        mOJ92wiGzXW8cnt7YGvFw+cMeWh0boaeVOFiDQzAI2nGI0RVR+A/81bMJRmyb6MdyK61aNpiPx7z7
        gTOl4divuK7rGwNEmR6v9IJggomkCG+FUkSKV49VTkMkt/eLjXxo0/rr5TS/m/4rMBq7cZl1o7Ivw
        /ZDnuVEvJfCgXRVmfNxqCtD7XYhLEV+GXdpTEEUS2f1N8ATSWs3Csrl0ETTH8SfbjOPwvNAJGHXnN
        GCruGuPZeP1bHQs4Xq8dwOdk0qmDWB5f3BZy+zo2cIPHE4MZpoSIFIzDrfQ1Zhet5JwPCqj9LL7pG
        kZrEneiw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oE5kT-005HyU-Pd; Wed, 20 Jul 2022 09:12:06 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 405289803A0; Wed, 20 Jul 2022 11:12:04 +0200 (CEST)
Date:   Wed, 20 Jul 2022 11:12:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     linux-kernel@vger.kernel.org, keescook@chromium.org,
        hjl.tools@gmail.com, andrew.cooper3@citrix.com,
        mark.rutland@arm.com, will@kernel.org, ndesaulniers@google.com,
        x86@kernel.org, Ankur Arora <ankur.a.arora@oracle.com>,
        joao@overdrivepizza.com
Subject: Re: [RFC][PATCH] x86,nospec: Simplify {JMP,CALL}_NOSPEC
Message-ID: <YtfG5NYAgfTzboid@worktop.programming.kicks-ass.net>
References: <20211204134338.760603010@infradead.org>
 <20211204134908.140103474@infradead.org>
 <9011132e-d78b-8bec-10cb-2b3d77a4e1fc@maciej.szmigiero.name>
 <Ytcguqp+/aTiOcnN@worktop.programming.kicks-ass.net>
 <YtcjEEpfvYmvHjmE@worktop.programming.kicks-ass.net>
 <32be2ea4-b60b-fbca-10c2-8c06f5bc135b@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32be2ea4-b60b-fbca-10c2-8c06f5bc135b@maciej.szmigiero.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 02:01:39AM +0200, Maciej S. Szmigiero wrote:
> > Obviously I meant: apply_retpolines() ...
> 
> Will apply_retpolines() actually patch in that trailing int3 in
> the X86_FEATURE_RETPOLINE_LFENCE case?
> 
> Looking at its code it uses just ordinary NOPs as fill:
> > 	/*
> > 	 * For RETPOLINE_LFENCE: prepend the indirect CALL/JMP with an LFENCE.
> > 	 */
> > 	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE_LFENCE)) {
> > 		bytes[i++] = 0x0f;
> > 		bytes[i++] = 0xae;
> > 		bytes[i++] = 0xe8; /* LFENCE */
> > 	}
> > 
> > 	ret = emit_indirect(op, reg, bytes + i);
> > 	if (ret < 0)
> > 		return ret;
> > 	i += ret;
> > 
> > 	for (; i < insn->length;)
> > 		bytes[i++] = BYTES_NOP1;

There is no space for int3 in that case. You get 3 bytes for LFENCE and
{2,3} bytes for 'jmp *%reg', which fully consumes the {5,6} bytes
available.

There will be no nops added.

But this is what all regular retpolines get to look like.

The plan was; and that's still pending, to get the INT3 from the AMD BTC
mitigation that adds INT3 after regular JMPs but those compiler patches
still need to happen I think.

