Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4625A544A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 21:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiH2TGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 15:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiH2TGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 15:06:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D5C7A774;
        Mon, 29 Aug 2022 12:06:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EE7761367;
        Mon, 29 Aug 2022 19:06:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6CCBC433C1;
        Mon, 29 Aug 2022 19:06:04 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="QC1+uecv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1661799963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=twauLnP4jhuZFYkzgdwWPK5ISesn2VyXRMhrLPjnTC4=;
        b=QC1+uecvx+Bqwmsmmt3IoasaRmXX5drKwqo9ZxwPmfTys/vloq3aJIePJ7Z8NF3OqSmfFh
        VPtLCKcu6uSbc+5hkAFY7zQ7e7sxlDGQdUeMRGNiGIiVzOnFXDMqdfyNOZqFVLL2/xe3yU
        1AAreUSHekO9UNKdbdYTiG54rc+Jnr8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b40d274c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 29 Aug 2022 19:06:02 +0000 (UTC)
Date:   Mon, 29 Aug 2022 15:05:59 -0400
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Adam Langley <agl@google.com>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: Should Linux set the new constant-time mode CPU flags?
Message-ID: <Yw0OF89auWTh12Xd@zx2c4.com>
References: <YwgCrqutxmX0W72r@gmail.com>
 <Ywzr2d52ixYXUDWR@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ywzr2d52ixYXUDWR@zx2c4.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 12:39:53PM -0400, Jason A. Donenfeld wrote:
> In terms of granularity, I saw other folks suggesting making it per-task
> (so, presumably, a prctl() knob), and others mentioning doing it just
> for kernel crypto. For the latter, I guess the crypto API could set it
> inside of its abstractions, and the various lib/crypto APIs could set it
> at invocation time. I wonder, though, what's the cost of
> enabling/disabling it? Would we in fact need a kind of lazy-deferred
> disabling, like we have with kernel_fpu_end()? I also wonder what
> crypto-adjacent code might wind up being missed if we're going function
> by function. Like, obviously we'd set this for crypto_memneq, but what
> about potential unprotected `==` of ID numbers that could leak some info
> in various protocols? What other subtle nearby code should we be
> thinking about, that relies on constant time logic but isn't neatly
> folded inside a crypto_do_something() function?

Another random note on this: I would hope that setting that MSR
represents a speculation barrier or general instruction stream barrier,
so that you can't do something naughty with the scheduler to toggle it
rapidly and measure crypto timings somehow.
