Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0D5447120C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 06:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbhLKF4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 00:56:08 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:57710 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229711AbhLKF4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 00:56:07 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1mvvMV-0004z1-NT; Sat, 11 Dec 2021 16:56:00 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 11 Dec 2021 16:55:59 +1100
Date:   Sat, 11 Dec 2021 16:55:59 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Nicolai Stange <nstange@suse.de>
Cc:     Stephan =?iso-8859-1?Q?M=FCller?= <smueller@chronox.de>,
        "David S. Miller" <davem@davemloft.net>,
        Torsten Duwe <duwe@suse.de>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] crypto: jitterentropy - bound collection loop
Message-ID: <20211211055559.GC6841@gondor.apana.org.au>
References: <20211130141009.6791-1-nstange@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130141009.6791-1-nstange@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 03:10:06PM +0100, Nicolai Stange wrote:
> Hi,
> 
> the sampling loop in jent_gen_entropy() can potentially run indefinitely
> w/o making any forward progress, namely if only stuck samples are taken
> for whatever reason.
> 
> There's a straight-forward way to make the entropy collection more robust,
> namely to terminate the loop and report an error if this happens. This
> patchset here implements that.
> 
> Applies to herbert/cryptodev-2.6.git master.
> 
> Thanks!
> 
> Nicolai
> 
> Nicolai Stange (3):
>   crypto: drbg - ignore jitterentropy errors if not in FIPS mode
>   crypto: jitter - don't limit ->health_failure check to FIPS mode
>   crypto: jitter - quit sample collection loop upon RCT failure
> 
>  crypto/drbg.c                | 7 +++++--
>  crypto/jitterentropy-kcapi.c | 6 ------
>  crypto/jitterentropy.c       | 6 +-----
>  crypto/jitterentropy.h       | 1 -
>  4 files changed, 6 insertions(+), 14 deletions(-)
> 
> -- 
> 2.26.2

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
