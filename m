Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5E958DEC8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 20:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343894AbiHISXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 14:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346352AbiHISVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 14:21:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B3D30F71;
        Tue,  9 Aug 2022 11:07:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 884EFB8191D;
        Tue,  9 Aug 2022 18:07:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF20EC433D7;
        Tue,  9 Aug 2022 18:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660068423;
        bh=mpQMti49pYC6uBbppBC/68xa8KuEYFFq6Y5tSKu+5mk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZadcVQXJ9mw3zLTMpkx8f1L3zlsqF20OvMzoQHigrCCWEy0RaZ3/XCRqLe8ZgSPFu
         K0X1GkXznnvFdqyMHE3a+y+/5BxyFN9Z6oS+O8ZI9D77335EQN1V6cCQYwcLwn55CP
         0LcqDNKId2qi+BY85LS4HTTVke2Tl74g/gvn7eGbJx/woH5axDs844USYZZjggK4uq
         Vq1jf81XApEo6pHWuUuFgMgLYfc0kDFqdbzQj34XRW9UdAuXm9bi1xvwWZeg4OeMcj
         dxyl80lTEhEo52EdRYxbIzHiWfQAcGhapk5nuOyIBg5IE8m6QeUyhva6R31mF5fye4
         h6TmVJb+ZY7Mw==
Date:   Tue, 9 Aug 2022 18:07:01 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Dong Chuanjian <chuanjian@nfschina.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@nfschina.com
Subject: Re: [PATCH] crypto/drbg.c:remove unnecessary (void*) conversions
Message-ID: <YvKiRWzWyATdEwGP@gmail.com>
References: <20220809091452.5264-1-chuanjian@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809091452.5264-1-chuanjian@nfschina.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2022 at 05:14:52PM +0800, Dong Chuanjian wrote:
>  	struct crypto_cipher *tfm =
> -		(struct crypto_cipher *)drbg->priv_data;
> +		drbg->priv_data;

Might as well join this into one line.

>  
>  	crypto_cipher_setkey(tfm, key, (drbg_keylen(drbg)));
>  }
> @@ -1828,7 +1828,7 @@ static int drbg_kcapi_sym(struct drbg_state *drbg, unsigned char *outval,
>  			  const struct drbg_string *in)
>  {
>  	struct crypto_cipher *tfm =
> -		(struct crypto_cipher *)drbg->priv_data;
> +		drbg->priv_data;

Likewise.

- Eric
