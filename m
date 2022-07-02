Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1DE563F20
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 10:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbiGBIhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 04:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiGBIhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 04:37:52 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D088C15A35;
        Sat,  2 Jul 2022 01:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656751071; x=1688287071;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DH4Bi4qdHliCN1t/CXq1vLQ2vdTfAQLLxpxzajn4oq0=;
  b=O5n9jNGuWQE7CU/V6vhWDmKgHNtAB9LtAeZRnc8TN5osHl5iRP8enMus
   hHA7fUn6eHVYbcbYazY5G6dGao+Zg7x3MylBSWke2lf28fQ2MVB9STMrc
   dqSqMYAhbtYnZ/xU2X64yJNQIvLtusBUelWHr6xIfXjl1faXkjplrTpB+
   NEcMHyEtzzJvBXpTT7w6kOvyBiszFHxjV+2DzfQQkMZhtjfw/0nliMl0x
   RYzoC1c189S3TdABsj0YTzNNZxvoLn5+6b5TvsxHX86q9QYWSnE6Aox/D
   3nXuJTOd5s0l0cpBvDtiDZ5fS8L9H24PAkLxGOQs3oK1tUGYCySpe9uot
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10395"; a="263206932"
X-IronPort-AV: E=Sophos;i="5.92,239,1650956400"; 
   d="scan'208";a="263206932"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 01:37:51 -0700
X-IronPort-AV: E=Sophos;i="5.92,239,1650956400"; 
   d="scan'208";a="659657132"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314) ([10.237.222.76])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 01:37:49 -0700
Date:   Sat, 2 Jul 2022 09:37:42 +0100
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     Ignat Korchagin <ignat@cloudflare.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com, Eric Biggers <ebiggers@kernel.org>,
        Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>
Subject: Re: [PATCH] crypto: testmgr - populate RSA CRT parameters in RSA
 test vectors
Message-ID: <YsAD1rHPsG8OG36x@silpixa00400314>
References: <20220630140506.904-1-ignat@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630140506.904-1-ignat@cloudflare.com>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 03:05:06PM +0100, Ignat Korchagin wrote:
> In f145d411a67e ("crypto: rsa - implement Chinese Remainder Theorem for faster
> private key operations") we have started to use the additional primes and
> coefficients for RSA private key operations. However, these additional
> parameters are not present (defined as 0 integers) in the RSA test vectors.
> 
> Some parameters were borrowed from OpenSSL, so I was able to find the source.
> I could not find the public source for 1 vector though, so had to recover the
> parameters by implementing Appendix C from [1].
> 
> [1]: https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-56Br1.pdf
> 
> Fixes: f145d411a67e ("crypto: rsa - implement Chinese Remainder Theorem for faster private key operations")
> Reported-by: Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>
> Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
> ---
>  crypto/testmgr.h | 121 +++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 100 insertions(+), 21 deletions(-)
> 
> diff --git a/crypto/testmgr.h b/crypto/testmgr.h
> index 8e2dce86dd48..7d503b4e1e41 100644
> --- a/crypto/testmgr.h
> +++ b/crypto/testmgr.h
> @@ -185,7 +185,7 @@ static const struct akcipher_testvec rsa_tv_template[] = {
>  	{
>  #ifndef CONFIG_CRYPTO_FIPS
>  	.key =
> -	"\x30\x81\x9A" /* sequence of 154 bytes */
> +	"\x30\x82\x01\x38" /* sequence of 312 bytes */
>  	"\x02\x01\x00" /* version - integer of 1 byte */
>  	"\x02\x41" /* modulus - integer of 65 bytes */
>  	"\x00\xAA\x36\xAB\xCE\x88\xAC\xFD\xFF\x55\x52\x3C\x7F\xC4\x52\x3F"
> @@ -199,23 +199,36 @@ static const struct akcipher_testvec rsa_tv_template[] = {
>  	"\xC2\xCD\x2D\xFF\x43\x40\x98\xCD\x20\xD8\xA1\x38\xD0\x90\xBF\x64"
>  	"\x79\x7C\x3F\xA7\xA2\xCD\xCB\x3C\xD1\xE0\xBD\xBA\x26\x54\xB4\xF9"
>  	"\xDF\x8E\x8A\xE5\x9D\x73\x3D\x9F\x33\xB3\x01\x62\x4A\xFD\x1D\x51"
> -	"\x02\x01\x00" /* prime1 - integer of 1 byte */
> -	"\x02\x01\x00" /* prime2 - integer of 1 byte */
> -	"\x02\x01\x00" /* exponent1 - integer of 1 byte */
> -	"\x02\x01\x00" /* exponent2 - integer of 1 byte */
> -	"\x02\x01\x00", /* coefficient - integer of 1 byte */
> +	"\x02\x21" /* prime1 - integer of 33 bytes */
> +	"\x00\xD8\x40\xB4\x16\x66\xB4\x2E\x92\xEA\x0D\xA3\xB4\x32\x04\xB5"
> +    "\xCF\xCE\x33\x52\x52\x4D\x04\x16\xA5\xA4\x41\xE7\x00\xAF\x46\x12"
> +    "\x0D"
Spaces should be replaced with tabs.
Checkpatch reports 1 error and 27 warnings.

Regards,

-- 
Giovanni
