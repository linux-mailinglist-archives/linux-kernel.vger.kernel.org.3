Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008AB54DE84
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 11:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiFPJ6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 05:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiFPJ6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 05:58:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313935C747;
        Thu, 16 Jun 2022 02:58:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2174B821FA;
        Thu, 16 Jun 2022 09:58:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC47DC34114;
        Thu, 16 Jun 2022 09:58:11 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="e22D2Nza"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1655373490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A8wHUW6+lx0TotEUX80qw22Z2PKe8UOVD5KveXmC6E4=;
        b=e22D2NzaeN+jEpEjTXpC3YlklM9ZYPqYEFK1tH7AkmtsIMAF4gwWmB7p+RN4iDFUf0HQ5K
        Ej9Hmrc8/c9uVYfcMRQdVE3gtJzzo/VFHZWHqYIDGRiTt3MTN+P3Dc9stT/xmOv2HNGsoR
        x2eRRwCpZBUpzQAklqM+5pqMD+hL3iA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 082b6ac6 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 16 Jun 2022 09:58:09 +0000 (UTC)
Date:   Thu, 16 Jun 2022 11:58:04 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Sandy Harris <sandyinchina@gmail.com>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Ted Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] random Remove setting of chacha state to constant values.
Message-ID: <Yqr+rFeixFuHzyHD@zx2c4.com>
References: <CACXcFmmw8bzSr-pmTauMS7a=036eW0=1KLdwAD1MOB_fY-7VRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACXcFmmw8bzSr-pmTauMS7a=036eW0=1KLdwAD1MOB_fY-7VRg@mail.gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sandy,

On Thu, Jun 16, 2022 at 01:18:23PM +0800, Sandy Harris wrote:
> Setting parts of the state to known constants is needed in
> some Chacha applications to ensure that blocks can be processed
> in parallel and that when needed (e.g. when encrypting disk
> blocks) the algorithm can jump to an arbitrary part of the
> output stream. In an RNG these are not required, and setting
> the constants wastes cycles.
> 
> If (as we hope) the enemy does not know the state, then
> this is more secure since it makes the chacha outputs
> depend on more unknown bits.
> 
> If they can peek at the state or infer parts of it from
> outputs, knowable values cannot possibly be worse than
> known ones. This at least prevents them from using
> pre-computed tables based on the known constants.
> 
> Signed-off-by: Sandy Harris <sandyinchina@gmail.com>
> ---
>  drivers/char/random.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 655e327d425e..6df9e656a157 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -249,9 +249,7 @@ static void crng_fast_key_erasure(u8 key[CHACHA_KEY_SIZE],
> 
>      BUG_ON(random_data_len > 32);
> 
> -    chacha_init_consts(chacha_state);
>      memcpy(&chacha_state[4], key, CHACHA_KEY_SIZE);
> -    memset(&chacha_state[12], 0, sizeof(u32) * 4);
>      chacha20_block(chacha_state, first_block);
> 
>      memcpy(key, first_block, CHACHA_KEY_SIZE);

Hard NACK here, sorry. You proposed removing the constants used with
BLAKE2s, also, and Eric and I told you the same then:

https://lore.kernel.org/all/YfLtrrB+140KkiN0@sol.localdomain/
https://lore.kernel.org/all/CAHmME9pyj-ejZn8KpVKqhELYB=-5bVYTeNhLk4SZOnBM1zeidA@mail.gmail.com/

Same sort of justification here. ChaCha is a permutation that requires
those constants.

Jason
