Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6DF4D7986
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 03:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236021AbiCNC4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 22:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbiCNC4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 22:56:10 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1A63DDE9;
        Sun, 13 Mar 2022 19:55:01 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1nTarG-0003F1-Bd; Mon, 14 Mar 2022 13:54:55 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Mon, 14 Mar 2022 14:54:54 +1200
Date:   Mon, 14 Mar 2022 14:54:54 +1200
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Brian Masney <bmasney@redhat.com>
Cc:     bjorn.andersson@linaro.org, davem@davemloft.net,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: qcom-rng: ensure buffer for generate is
 completely filled
Message-ID: <Yi6ufj2a2FGDPcQb@gondor.apana.org.au>
References: <20220310232459.749638-1-bmasney@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220310232459.749638-1-bmasney@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 06:24:59PM -0500, Brian Masney wrote:
> The generate function in struct rng_alg expects that the destination
> buffer is completely filled if the function returns 0. qcom_rng_read()
> can run into a situation where the buffer is partially filled with
> randomness and the remaining part of the buffer is zeroed since
> qcom_rng_generate() doesn't check the return value. This issue can
> be reproduced by running the following from libkcapi:
> 
>     kcapi-rng -b 9000000 > OUTFILE
> 
> The generated OUTFILE will have three huge sections that contain all
> zeros, and this is caused by the code where the test
> 'val & PRNG_STATUS_DATA_AVAIL' fails.
> 
> Let's fix this issue by ensuring that qcom_rng_read() always returns
> with a full buffer if the function returns success. Let's also have
> qcom_rng_generate() return the correct value.
> 
> Here's some statistics from the ent project
> (https://www.fourmilab.ch/random/) that shows information about the
> quality of the generated numbers:
> 
>     $ ent -c qcom-random-before
>     Value Char Occurrences Fraction
>       0           606748   0.067416
>       1            33104   0.003678
>       2            33001   0.003667
>     ...
>     253   �        32883   0.003654
>     254   �        33035   0.003671
>     255   �        33239   0.003693
> 
>     Total:       9000000   1.000000
> 
>     Entropy = 7.811590 bits per byte.
> 
>     Optimum compression would reduce the size
>     of this 9000000 byte file by 2 percent.
> 
>     Chi square distribution for 9000000 samples is 9329962.81, and
>     randomly would exceed this value less than 0.01 percent of the
>     times.
> 
>     Arithmetic mean value of data bytes is 119.3731 (127.5 = random).
>     Monte Carlo value for Pi is 3.197293333 (error 1.77 percent).
>     Serial correlation coefficient is 0.159130 (totally uncorrelated =
>     0.0).
> 
> Without this patch, the results of the chi-square test is 0.01%, and
> the numbers are certainly not random according to ent's project page.
> The results improve with this patch:
> 
>     $ ent -c qcom-random-after
>     Value Char Occurrences Fraction
>       0            35432   0.003937
>       1            35127   0.003903
>       2            35424   0.003936
>     ...
>     253   �        35201   0.003911
>     254   �        34835   0.003871
>     255   �        35368   0.003930
> 
>     Total:       9000000   1.000000
> 
>     Entropy = 7.999979 bits per byte.
> 
>     Optimum compression would reduce the size
>     of this 9000000 byte file by 0 percent.
> 
>     Chi square distribution for 9000000 samples is 258.77, and randomly
>     would exceed this value 42.24 percent of the times.
> 
>     Arithmetic mean value of data bytes is 127.5006 (127.5 = random).
>     Monte Carlo value for Pi is 3.141277333 (error 0.01 percent).
>     Serial correlation coefficient is 0.000468 (totally uncorrelated =
>     0.0).
> 
> This change was tested on a Nexus 5 phone (msm8974 SoC).
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> Fixes: ceec5f5b5988 ("crypto: qcom-rng - Add Qcom prng driver")
> Cc: stable@vger.kernel.org # 4.19+
> ---
>  drivers/crypto/qcom-rng.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
