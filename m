Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3EC463D65
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 19:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245279AbhK3SJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 13:09:20 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:32852 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245263AbhK3SJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 13:09:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1638295556;
    s=strato-dkim-0002; d=chronox.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=NPvG+eOjvkdkJB5pc+hn5Yo+JvbMzkpX+Pef7/b2NGE=;
    b=LEvdjo2DpSz3WqVLBo1yKI0JIwQXlfqmhM/2Wkvo401pGGjRj+F2HDNeGRgEx453ft
    45qr3fKUObjK1lSajjEPUrFOoj3c+1o8aoYZV4R8jNQ3FxB08sG/wtu/83+fWQfZgnqA
    5ToTUNi0te7C/fJi/C/yxy4gkWaW7gunFE3zlaqomkedaEc73BjgGqtKo7D1OpJ2yAuo
    pO2jWpZaYhzI+JCLK9A08cEtMrklg370f+q1Q+wSFN1jBB+GaDnBKcNSDc9wNb8dAXg7
    z877y1WXmlzaqsf0duWkNgLKk91pJpL9W/mLfVsCbzBDLiGwcmfGXzQd7Geh9QPeDBsf
    rKPQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXvdOeuWroQ="
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
    by smtp.strato.de (RZmta 47.34.10 DYNA|AUTH)
    with ESMTPSA id 006230xAUI5uYUR
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 30 Nov 2021 19:05:56 +0100 (CET)
From:   Stephan Mueller <smueller@chronox.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Nicolai Stange <nstange@suse.de>
Cc:     Torsten Duwe <duwe@suse.de>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicolai Stange <nstange@suse.de>
Subject: Re: [PATCH 2/3] crypto: jitter - don't limit ->health_failure check to FIPS mode
Date:   Tue, 30 Nov 2021 19:05:55 +0100
Message-ID: <2423597.MaluLQq8qO@tauon.chronox.de>
In-Reply-To: <20211130141009.6791-3-nstange@suse.de>
References: <20211130141009.6791-1-nstange@suse.de> <20211130141009.6791-3-nstange@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 30. November 2021, 15:10:08 CET schrieb Nicolai Stange:

Hi Nicolai,

> The jitterentropy's Repetition Count Test (RCT) as well as the Adaptive
> Proportion Test (APT) are run unconditionally on any collected samples.
> However, their result, i.e. ->health_failure, will only get checked if
> fips_enabled is set, c.f. the jent_health_failure() wrapper.
> 
> I would argue that a RCT or APT failure indicates that something's
> seriously off and that this should always be reported as an error,
> independently of whether FIPS mode is enabled or not: it should be up to
> callers whether or not and how to handle jitterentropy failures.
> 
> Make jent_health_failure() to unconditionally return ->health_failure,
> independent of whether fips_enabled is set.
> 
> Note that fips_enabled isn't accessed from the jitterentropy code anymore
> now. Remove the linux/fips.h include as well as the jent_fips_enabled()
> wrapper.
> 
> Signed-off-by: Nicolai Stange <nstange@suse.de>

Reviewed-by: Stephan Mueller <smueller@chronox.de>

Thanks
Stephan

> ---
>  crypto/jitterentropy-kcapi.c | 6 ------
>  crypto/jitterentropy.c       | 4 ----
>  crypto/jitterentropy.h       | 1 -
>  3 files changed, 11 deletions(-)
> 
> diff --git a/crypto/jitterentropy-kcapi.c b/crypto/jitterentropy-kcapi.c
> index e8a4165a1874..2d115bec15ae 100644
> --- a/crypto/jitterentropy-kcapi.c
> +++ b/crypto/jitterentropy-kcapi.c
> @@ -40,7 +40,6 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
> -#include <linux/fips.h>
>  #include <linux/time.h>
>  #include <crypto/internal/rng.h>
> 
> @@ -60,11 +59,6 @@ void jent_zfree(void *ptr)
>  	kfree_sensitive(ptr);
>  }
> 
> -int jent_fips_enabled(void)
> -{
> -	return fips_enabled;
> -}
> -
>  void jent_panic(char *s)
>  {
>  	panic("%s", s);
> diff --git a/crypto/jitterentropy.c b/crypto/jitterentropy.c
> index 788d90749715..24e087c3f526 100644
> --- a/crypto/jitterentropy.c
> +++ b/crypto/jitterentropy.c
> @@ -298,10 +298,6 @@ static int jent_stuck(struct rand_data *ec, __u64
> current_delta) */
>  static int jent_health_failure(struct rand_data *ec)
>  {
> -	/* Test is only enabled in FIPS mode */
> -	if (!jent_fips_enabled())
> -		return 0;
> -
>  	return ec->health_failure;
>  }
> 
> diff --git a/crypto/jitterentropy.h b/crypto/jitterentropy.h
> index c83fff32d130..b7397b617ef0 100644
> --- a/crypto/jitterentropy.h
> +++ b/crypto/jitterentropy.h
> @@ -2,7 +2,6 @@
> 
>  extern void *jent_zalloc(unsigned int len);
>  extern void jent_zfree(void *ptr);
> -extern int jent_fips_enabled(void);
>  extern void jent_panic(char *s);
>  extern void jent_memcpy(void *dest, const void *src, unsigned int n);
>  extern void jent_get_nstime(__u64 *out);


Ciao
Stephan


