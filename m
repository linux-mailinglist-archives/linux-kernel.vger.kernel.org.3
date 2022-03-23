Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0864F4E5925
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 20:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344265AbiCWTbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 15:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245596AbiCWTbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 15:31:17 -0400
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A15131372
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 12:29:45 -0700 (PDT)
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 0DCF8201406;
        Wed, 23 Mar 2022 19:29:43 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 5645280138; Wed, 23 Mar 2022 20:24:49 +0100 (CET)
Date:   Wed, 23 Mar 2022 20:24:49 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] random: re-add removed comment about
 get_random_{u32,u64} reseeding
Message-ID: <Yjt0AX8st/gE00CM@owl.dominikbrodowski.net>
References: <20220323042336.148775-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323042336.148775-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Tue, Mar 22, 2022 at 10:23:36PM -0600 schrieb Jason A. Donenfeld:
> The comment about get_random_{u32,u64}() not invoking reseeding got
> added in an unrelated commit, that then was recently reverted. So this
> adds that little comment snippet back.
> 
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/char/random.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 1d7aac2a9600..82e37d7dd9f1 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -226,7 +226,7 @@ static void _warn_unseeded_randomness(const char *func_name, void *caller, void
>   * into the given buffer or as a return value. This is equivalent to
>   * a read from /dev/urandom. The integer family of functions may be
>   * higher performance for one-off random integers, because they do a
> - * bit of buffering.
> + * bit of buffering and do not invoke reseeding.
>   *
>   *********************************************************************/

Actually, that seems wrong, as all these functions may call
_get_random_bytes(), which may invoke crng_make_state(), which
may invoke crng_reseed(). And it might be worthwhile to clarify
that it's only get_random_bytes() that does not do the bit of
buffering.

Thanks,
	Dominik
