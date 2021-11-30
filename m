Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28CCC463D67
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 19:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245272AbhK3SKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 13:10:40 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.82]:32207 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbhK3SKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 13:10:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1638295634;
    s=strato-dkim-0002; d=chronox.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=ZvaC1y/j6CwcsSjy1YZ95Q0CuoBTzAH2EOIX6pu57/Q=;
    b=YNsILJjWjKhKWgjoumCr7Xyl/zmSjjCc0gyfyzey+qE9Sa6knJClGm6oz0Ri9Xy/Bp
    rKh32BKT/d6OnxeXuUeeaGGfmAaGRuaIjGOPIiwJ+7XAsEJq1QhnBzc/VN8stzzbOUE0
    RUZL+oajJlQ30KIl2rAbqzmuCXzTHuEb4+bMX+BIm+wL9SkOEXzfL/KUs7DTPB08/UsU
    A6aEG9GNzHj0kCwAMYtNp1AW8ZBpBIJhUAJ90TKlEIRM02K99Kex6iyRIj+xyBpu5JmO
    alIfFTj6BN1mVxwbh5TbuH6kKJJCbC5Xq7+7YS4Pjfe23qsWFhKyemqlEhsYuFvDEx2T
    uBAw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXvdOeuWroQ="
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
    by smtp.strato.de (RZmta 47.34.10 DYNA|AUTH)
    with ESMTPSA id 006230xAUI7EYUf
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 30 Nov 2021 19:07:14 +0100 (CET)
From:   Stephan Mueller <smueller@chronox.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Nicolai Stange <nstange@suse.de>
Cc:     Torsten Duwe <duwe@suse.de>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicolai Stange <nstange@suse.de>
Subject: Re: [PATCH 3/3] crypto: jitter - quit sample collection loop upon RCT failure
Date:   Tue, 30 Nov 2021 19:07:13 +0100
Message-ID: <4130352.XCsR1xZqcM@tauon.chronox.de>
In-Reply-To: <20211130141009.6791-4-nstange@suse.de>
References: <20211130141009.6791-1-nstange@suse.de> <20211130141009.6791-4-nstange@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 30. November 2021, 15:10:09 CET schrieb Nicolai Stange:

Hi Nicolai,

> The jitterentropy collection loop in jent_gen_entropy() can in principle
> run indefinitely without making any progress if it only receives stuck
> measurements as determined by jent_stuck(). After 31 consecutive stuck
> samples, the Repetition Count Test (RCT) would fail anyway and the
> jitterentropy RNG instances moved into ->health_failure == 1 state.
> jent_gen_entropy()'s caller, jent_read_entropy() would then check for
> this ->health_failure condition and return an error if found set. It
> follows that there's absolutely no point in continuing the collection loop
> in jent_gen_entropy() once the RCT has failed.
> 
> Make the jitterentropy collection loop more robust by terminating it upon
> jent_health_failure() so that it won't continue to run indefinitely without
> making any progress.
> 
> Signed-off-by: Nicolai Stange <nstange@suse.de>

Reviewed-by: Stephan Mueller <smueller@chronox.de>

Thanks
Stephan

> ---
>  crypto/jitterentropy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/crypto/jitterentropy.c b/crypto/jitterentropy.c
> index 24e087c3f526..8f5283f28ed3 100644
> --- a/crypto/jitterentropy.c
> +++ b/crypto/jitterentropy.c
> @@ -547,7 +547,7 @@ static void jent_gen_entropy(struct rand_data *ec)
>  	/* priming of the ->prev_time value */
>  	jent_measure_jitter(ec);
> 
> -	while (1) {
> +	while (!jent_health_failure(ec)) {
>  		/* If a stuck measurement is received, repeat measurement */
>  		if (jent_measure_jitter(ec))
>  			continue;


Ciao
Stephan


