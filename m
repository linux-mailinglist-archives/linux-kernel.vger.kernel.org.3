Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353F44BD5B1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 07:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344784AbiBUFxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 00:53:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244634AbiBUFxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 00:53:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550B13C4B1;
        Sun, 20 Feb 2022 21:53:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5BB9B80E6F;
        Mon, 21 Feb 2022 05:52:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2841DC340E9;
        Mon, 21 Feb 2022 05:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645422777;
        bh=9DAhotHuTATnhlZOyU50VKNph9zSNNPYqAEZ3QWaBso=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WFPwymL/DqSNXTnpjzADKdvrIZaFy8GIyd+4uhucvrVT24j4T5ZSZ+QgpKPsrvxir
         lxhUlCB/XgHSUeG06OYwgOvGBsVsxSjnu5q3LsZ+BlisDidFeyoc3p3uK26a/YTfD9
         KfkhkTHo7gd4M9UkjrWstGM1lmdQ6J0KKGnyDWjw2yGcgKBjADJYUly6VF3Iij6ud3
         lQ3pdkQBkK8on5lC/4nCyi7/ihaAKgdhoZ3Rr57Hl40mZQrWkysYPCLB7nkfQ2KzUc
         c9bFtnDkcj7MJqtZaG//Rf8dg5UMsqFuLEZRJ5H+No2zgmDVgpKu52YK31R/s29wWG
         2Vthe0wAgQuNA==
Date:   Sun, 20 Feb 2022 21:52:55 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
        herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        Matt Mackall <mpm@selenic.com>, Kalle Valo <kvalo@kernel.org>,
        ath9k-devel@qca.qualcomm.com, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] random: pull add_hwgenerator_randomness() declaration
 into random.h
Message-ID: <YhMot77If2Txl+cL@sol.localdomain>
References: <20220213152522.816777-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220213152522.816777-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 13, 2022 at 04:25:22PM +0100, Jason A. Donenfeld wrote:
> add_hwgenerator_randomness() is a function implemented and documented
> inside of random.c. It is the way that hardware RNGs push data into it.
> Therefore, it should be declared in random.h. Otherwise sparse complains
> with:
> 
> random.c:1137:6: warning: symbol 'add_hwgenerator_randomness' was not declared. Should it be static?
> 
> The alternative would be to include hw_random.h into random.c, but that
> wouldn't really be good for anything except slowing down compile time.
> 
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Matt Mackall <mpm@selenic.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: linux-crypto@vger.kernel.org
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: ath9k-devel@qca.qualcomm.com
> Cc: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/char/hw_random/core.c        | 1 +
>  drivers/net/wireless/ath/ath9k/rng.c | 1 +
>  include/linux/hw_random.h            | 2 --
>  include/linux/random.h               | 2 ++
>  4 files changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
