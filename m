Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425D44BD479
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 05:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbiBUDyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 22:54:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiBUDyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 22:54:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB503DA42
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 19:53:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F13961161
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 03:53:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4091C340E9;
        Mon, 21 Feb 2022 03:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645415637;
        bh=rFoO9TluWOBv4ZLfX+kVM+rYoeTTCflh3GPYtSyWTcs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jKwiIlW0qkMHhC42gT6MRNyua2a4TzJYbJgYVKm18TJ2qUx7C3JT6it/qZb216Zkx
         5las5SSdY0ov1e/GSJB5QzmBwhCR0xVPRX8Jp+oZQwskudDkVXNYC5I0NnE82IedC0
         FJ1AUdWkldMqb/YB3HNZ41oeTBLLlnOARgsAepr5plc4RnQtqW8Glv7KNyne1MX7/7
         X9cgHUsHtwOfAbGtKWr1S3WX7VHUe9+eZHBkk4HrKlpvdvGoJnU3PFSouMGtP7Qt3M
         R9OMx+LuHHD1kpw0yRigYl5J1I5ewTjyKKBTFgcqv98/5G2p3A2Gq24fJgb23xDxv+
         wmO8aX9zArqJg==
Date:   Sun, 20 Feb 2022 19:53:56 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2] random: make more consistent use of integer types
Message-ID: <YhMM1C7n4ipZcQE3@sol.localdomain>
References: <20220209135211.557032-1-Jason@zx2c4.com>
 <20220209180507.646941-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209180507.646941-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This looks good in general, but a few comments below.

On Wed, Feb 09, 2022 at 07:05:07PM +0100, Jason A. Donenfeld wrote:
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Reviewed-by: Jann Horn <jannh@google.com>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> -static void _mix_pool_bytes(const void *in, int nbytes)
> +static void _mix_pool_bytes(const void *in, size_t nbytes)
>  {
>  	blake2s_update(&input_pool.hash, in, nbytes);
>  }
>  
> -static void mix_pool_bytes(const void *in, int nbytes)
> +static void mix_pool_bytes(const void *in, size_t nbytes)

The committed version of this patch removes the __mix_pool_bytes() function as
well, and it's not clear how it is related to the rest of the patch.  Perhaps
that part belongs in the patch that removes all the tracepoints?

> -static size_t crng_fast_load(const u8 *cp, size_t len)
> +static size_t crng_fast_load(const void *cp, size_t len)
>  {
>  	unsigned long flags;
> -	u8 *p;
> +	u8 *src = (u8 *)cp;

This should use 'const u8 *'.

>  int __init rand_initialize(void)
>  {
> -	int i;
> +	size_t i;
>  	ktime_t now = ktime_get_real();

This introduces an assumption that BLAKE2S_BLOCK_SIZE % sizeof(unsigned long) ==
0.  That happens to always be true, but it would be better to either not change
this, or rewrite the loop to 'i = 0; i < BLAKE2S_BLOCK_SIZE; i += sizeof(rv)'

- Eric
