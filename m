Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6CE4B4F32
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352470AbiBNLqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:46:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353100AbiBNLpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:45:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00567DF6F;
        Mon, 14 Feb 2022 03:43:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9180E6124B;
        Mon, 14 Feb 2022 11:43:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68181C340E9;
        Mon, 14 Feb 2022 11:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644839033;
        bh=ePn6S92XlFEF6di5Me3xAX//sSbXPKpKaKEHPPaXZWk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=cNMvD73Xbp90mIhg2CQOiwf+eUYEzgTQZ9d/TN+PBjh99bWMGWeJwLa7rCFHDM9sg
         LL21ihZ8eSUfcbnX6ipKU13X+mG0QX0eZzkbC57gYjN+p5YzqyLm+KlgLGaPZSVWM8
         60FPyQi5e8fhCzCRubypqNNx6MHKjMGsXGIG3VX2nr7f2QJP6l5n72rwox5th/QASn
         MsV9VyZTPrsJr7yJRXtXaOvWo7/w4JoqN+TTIBw+8+5fD0mt4rq9HCxjlPZvGKL+xA
         moNi5woaFJR8jm4MbwfauVqeV0NkUJlfOsUQk5lC/ARqnrP5VUgJ7OgNQqcfCGqgX4
         PrQJwA3MaQZAw==
From:   Kalle Valo <kvalo@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
        herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        Matt Mackall <mpm@selenic.com>, ath9k-devel@qca.qualcomm.com,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] random: pull add_hwgenerator_randomness() declaration into random.h
References: <20220213152522.816777-1-Jason@zx2c4.com>
Date:   Mon, 14 Feb 2022 13:43:46 +0200
In-Reply-To: <20220213152522.816777-1-Jason@zx2c4.com> (Jason A. Donenfeld's
        message of "Sun, 13 Feb 2022 16:25:22 +0100")
Message-ID: <8735klbrm5.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Jason A. Donenfeld" <Jason@zx2c4.com> writes:

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

For ath9k:

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
