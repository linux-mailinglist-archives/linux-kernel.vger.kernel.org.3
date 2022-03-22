Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB334E3920
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 07:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237095AbiCVGq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 02:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237100AbiCVGqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 02:46:24 -0400
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835FA5575C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 23:44:57 -0700 (PDT)
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id D895420140A;
        Tue, 22 Mar 2022 06:44:53 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 5538E80631; Tue, 22 Mar 2022 07:44:47 +0100 (CET)
Date:   Tue, 22 Mar 2022 07:44:47 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] random: skip fast_init if hwrng provides large chunk of
 entropy
Message-ID: <YjlwXxVWg1GNUR5J@owl.dominikbrodowski.net>
References: <20220322005256.3787-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322005256.3787-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mon, Mar 21, 2022 at 06:52:56PM -0600 schrieb Jason A. Donenfeld:
> At boot time, EFI calls add_bootloader_randomness(), which in turn calls
> add_hwgenerator_randomness(). Currently add_hwgenerator_randomness()
> feeds the first 64 bytes of randomness to the "fast init"
> non-crypto-grade phase. But if add_hwgenerator_randomness() gets called
> with more than POOL_MIN_BITS of entropy, there's no point in passing it
> off to the "fast init" stage, since that's enough entropy to bootstrap
> the real RNG.

Well, so far, we need 64 bytes input to the fast init stage, and then
further 32 bytes of randomness to proceed to full init, and we used to mix
the former into the latter, which provided for some sort of extra margin.
But as we don't seem to do that any more (mixing some of base_crng back into
the input_pool), that exercise may have become pointless.

However, it's noteworthy that then CONFIG_RANDOM_TRUST_BOOTLOADER really
means trusting it to possibly being the only source for the first generation
of base_crng. In the past, EFI-provided randnomness never was sufficient to
progress crng_init to 2.

Therefore, I am a bit torn about this patch.

Thanks,
	Dominik


NB: As POOL_MIN_BITS equals POOL_BITS, there's some room for cleanup. For
example, entropy_count cannot become larger than POOL_MIN_BITS in
credit_entropy_bits(), AFAICS.
