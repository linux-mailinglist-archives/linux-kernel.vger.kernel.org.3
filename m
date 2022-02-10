Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B924B0607
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 07:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbiBJGEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 01:04:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbiBJGEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 01:04:47 -0500
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E991C5;
        Wed,  9 Feb 2022 22:04:47 -0800 (PST)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 2627D201421;
        Thu, 10 Feb 2022 06:04:46 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 8EB9D804B3; Thu, 10 Feb 2022 06:43:42 +0100 (CET)
Date:   Thu, 10 Feb 2022 06:43:42 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH] random: fix locking for crng_init in crng_reseed()
Message-ID: <YgSmDtA2hlrDBmrH@owl.dominikbrodowski.net>
References: <YgQOgqWr0nwqZCh6@owl.dominikbrodowski.net>
 <CAHmME9pZB1fWf2nZNwTHw07hrnxZYYymA0_Dy=jauDt9TbF69A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9pZB1fWf2nZNwTHw07hrnxZYYymA0_Dy=jauDt9TbF69A@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

Am Wed, Feb 09, 2022 at 10:39:17PM +0100 schrieb Jason A. Donenfeld:
> Thanks, applied. I changed complete_init to finalize_init, to match
> our naming scheme from earlier, and I moved
> invalidate_batched_entropy() to outside the lock and after
> crng_init=2, since now it uses atomics, and it should probably be
> ordered after crng_init = 2, so the new batch gets the new entropy.

Doesn't that mean that there is a small window where crng_init == 2, but
get_random_u64/get_random_u32 still returns old data, with potentially
insufficient entropy (as obtained at a time when crng_init was still < 2)?
That's why I moved invalidate_batched_entropy() under the lock.

But with your subsequent patch, it doesn't matter any more.

Thanks,
	Dominik
