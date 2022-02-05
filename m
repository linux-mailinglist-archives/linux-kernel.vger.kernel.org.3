Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966EF4AA928
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 14:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379997AbiBENcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 08:32:43 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:41024 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351590AbiBENcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 08:32:42 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 37D98201420;
        Sat,  5 Feb 2022 13:32:40 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id EC34E80A34; Sat,  5 Feb 2022 14:32:31 +0100 (CET)
Date:   Sat, 5 Feb 2022 14:32:31 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 1/2] random: fix locking in crng_fast_load()
Message-ID: <Yf58b+olLdLN2j/z@owl.dominikbrodowski.net>
References: <20220205103458.133386-1-linux@dominikbrodowski.net>
 <20220205103458.133386-2-linux@dominikbrodowski.net>
 <CAHmME9rsDkn=qRacYbZFjni5FF6G2dn+KOELr-agPhmH7ved0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9rsDkn=qRacYbZFjni5FF6G2dn+KOELr-agPhmH7ved0g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

Am Sat, Feb 05, 2022 at 02:17:15PM +0100 schrieb Jason A. Donenfeld:
> Does this introduce a lock nesting inversion situation?
> 
> With your patch, crng_fast_load() now does:
> 
>     lock(primary_crng)
>     invalidate_batched_entropy()
>         lock(batch_lock)
>         unlock(batch_lock)
>     unlock(primary_crng)
> 
> While get_random_{u32,u64}() does:
> 
>     lock(batch_lock)
>     extract_crng()
>        lock(primary_crng)
>        unlock(primary_crng)
>     unlock(batch_lock)
> 
> Is this correct? If so, we might have to defer this patch until after
> <https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git/commit/?id=2dfab1b1>
> or something like it lands, which attempts to get rid of the batched
> entropy lock.
> 
> If that analysis seems right to you, I could pull this patch into that
> development branch for poking and prodding.

Right, this makes sense -- I already "read" invalidate_batched_entropy() as
being just a call to atomic_inc().

Thanks,
	Dominik
