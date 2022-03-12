Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2B54D710B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 22:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbiCLVka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 16:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiCLVk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 16:40:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F77BF7468;
        Sat, 12 Mar 2022 13:39:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ADB38B80B06;
        Sat, 12 Mar 2022 21:39:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 109B1C340EB;
        Sat, 12 Mar 2022 21:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647121157;
        bh=nPUhEhml+PJkRdcl8Fz3Qoc64pioCFs//SBmVg2UE/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V3oSyQgx9tmCb7JILolRXSVCOfS3a1lhGrzHsxhke8iSd75z5jq6wO+wCz1bsu+pN
         AbhbjAgIhQkfibYARIlV+veSJckwAt+HRUzf0fkAeQz9oKeAcE1ESN3dC4ZkYJQDAx
         s4rjBeeqew6ogexjU6I6hFhbuNenUGg6a1Cl+F69vPmuDNMdZe2GFlFiVOBM27uDSC
         ZRkYDM6QpuZRzOhZQAmr6do1dMl0W37FGQ5jQV3K966fnid/ll5+Uy5qRWlDmX8HYG
         RzRiC+UmrNimAc9cw28l45rLLvxBrhe70hCsmkX8AUrwKd+qpwR6AT74+95z73ydG1
         /9pHp9zZAp99Q==
Date:   Sat, 12 Mar 2022 13:39:15 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Subject: Re: [PATCH v2] random: use SipHash as interrupt entropy accumulator
Message-ID: <Yi0TA1r81AXh7nP/@sol.localdomain>
References: <20220306165123.71024-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220306165123.71024-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 06, 2022 at 09:51:23AM -0700, Jason A. Donenfeld wrote:
> 
> For this, we make use of SipHash-1-x on 64-bit and HalfSipHash-1-x on
> 32-bit, which are already in use in the kernel and achieve the same
> performance as the function they replace. It would be nice to do two
> rounds, but we don't exactly have the CPU budget handy for that, and one
> round alone is already sufficient.
> 

I'm a bit confused by the argument here.  It's not SipHash-1-x that's used
elsewhere in the kernel, but rather SipHash-2-4.  HalfSipHash-1-3 is used too,
but the documentation (Documentation/security/siphash.rst) is very explicit that
HalfSipHash-1-3 must only ever be used as a hashtable key function.

It sounds like you're not actually claiming cryptographic security here, and
this is probably better than the homebrew ARX that was there before.  But there
are definitely some contradictions in your explanation.

>  struct fast_pool {
> -	union {
> -		u32 pool32[4];
> -		u64 pool64[2];
> -	};
>  	struct work_struct mix;
> +	unsigned long pool[4];
>  	unsigned long last;
>  	unsigned int count;
>  	u16 reg_idx;
>  };

Increasing the size of the pool partially breaks mix_interrupt_randomness()
which does:

static void mix_interrupt_randomness(struct work_struct *work)
{
        struct fast_pool *fast_pool = container_of(work, struct fast_pool, mix);
        u8 pool[16];

	[...]

        /*
         * Copy the pool to the stack so that the mixer always has a
         * consistent view, before we reenable irqs again.
         */
        memcpy(pool, fast_pool->pool, sizeof(pool));

	[...]

So on 64-bit platforms it now throws away half of the pool.

It should use 'u8 pool[sizeof(fast_pool->pool)]' to avoid hardcoding a size.

- Eric
