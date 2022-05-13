Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFFB6525B95
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 08:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377364AbiEMG1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 02:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377313AbiEMG0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 02:26:25 -0400
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E669F275E4;
        Thu, 12 May 2022 23:26:21 -0700 (PDT)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id F418B20140E;
        Fri, 13 May 2022 06:26:05 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 73159809A1; Fri, 13 May 2022 08:22:36 +0200 (CEST)
Date:   Fri, 13 May 2022 08:22:36 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v3] random: use first 128 bits of input as fast init
Message-ID: <Yn35LG3pz9BNsSS3@owl.dominikbrodowski.net>
References: <20220503131204.571547-1-Jason@zx2c4.com>
 <20220504111644.284927-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504111644.284927-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Wed, May 04, 2022 at 01:16:44PM +0200 schrieb Jason A. Donenfeld:
> Before, the first 64 bytes of input, regardless of how entropic it was,
> would be used to mutate the crng base key directly, and none of those
> bytes would be credited as having entropy. Then 256 bits of credited
> input would be accumulated, and only then would the rng transition from
> the earlier "fast init" phase into being actually initialized.
> 
> The thinking was that by mixing and matching fast init and real init, an
> attacker who compromised the fast init state, considered easy to do
> given how little entropy might be in those first 64 bytes, would then be
> able to bruteforce bits from the actual initialization. By keeping these
> separate, bruteforcing became impossible.
> 
> However, by not crediting potentially creditable bits from those first 64
> bytes of input, we delay initialization, and actually make the problem
> worse, because it means the user is drawing worse random numbers for a
> longer period of time.
> 
> Instead, we can take the first 128 bits as fast init, and allow them to
> be credited, and then hold off on the next 128 bits until they've
> accumulated. This is still a wide enough margin to prevent bruteforcing
> the rng state, while still initializing much faster.
> 
> Then, rather than trying to piecemeal inject into the base crng key at
> various points, instead just extract from the pool when we need it, for
> the crng_init==0 phase. Performance may even be better for the various
> inputs here, since there are likely more calls to mix_pool_bytes() then
> there are to get_random_bytes() during this phase of system execution.

Have you evaluated this closer, also for systems where it takes ages to
reach crng_init = 1? And might it make sense to only call extract_entropy()
if there has been new input between two calls to get_random_bytes()?

Thanks,
	Dominik
