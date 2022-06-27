Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897A055E0E1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241545AbiF0XTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 19:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240970AbiF0XRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 19:17:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CD6237E9;
        Mon, 27 Jun 2022 16:17:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED4A96152E;
        Mon, 27 Jun 2022 23:17:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 030D9C34115;
        Mon, 27 Jun 2022 23:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656371826;
        bh=xK/0Jo6bbbOr8Su6qSlzhWJlbL3Ou6nGEBskw/gJN6w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gdjqnp7gzy7ZTPEUKfdbOqeFJEN/O/BYL4VEKBpEKVbwjd09UG9BxxKpVsD1KYeCa
         i3dcZwhZNPDgzim3GabS0RB16XMcveEZkNr5pnCUs9UbsZDlHFHSVFwIADz/RuhYO1
         +X6jmug6bGuNwd5qfmumJzvYe7FnpUjEEEC29dYCDyP4/7X6PW7K9ZF4Y7BkA+bUPN
         v9xiPwa0oN9Be40+n8jRhyukCy76ntvcIQx0/8sNERa+6sCQRST9oB8eb6hwAd9TPD
         ccPjBGSWynfhc8fEjPnmY1kiUubF+Dbh6sEYH6iAUD7Fy31aa9BsnUA052Wx1MnwYj
         R9mUu/hA9pOkw==
Date:   Tue, 28 Jun 2022 02:17:02 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Elvira Khabirova <e.khabirova@omp.ru>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2 RESEND] pkcs7: support EC-RDSA/streebog in
 SignerInfo
Message-ID: <Yro6btp1iF4plBk/@kernel.org>
References: <20220627092142.21095-1-tianjia.zhang@linux.alibaba.com>
 <20220627092142.21095-3-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627092142.21095-3-tianjia.zhang@linux.alibaba.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 05:21:42PM +0800, Tianjia Zhang wrote:
> From: Elvira Khabirova <e.khabirova@omp.ru>
> 
> Allow using EC-RDSA/streebog in pkcs7 certificates in a similar way
> to how it's done in the x509 parser.
> 
> This is needed e.g. for loading kernel modules signed with EC-RDSA.
> 
> Signed-off-by: Elvira Khabirova <e.khabirova@omp.ru>
> Reviewed-by: Vitaly Chikunov <vt@altlinux.org>
> Reviewed-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>  crypto/asymmetric_keys/pkcs7_parser.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/crypto/asymmetric_keys/pkcs7_parser.c b/crypto/asymmetric_keys/pkcs7_parser.c
> index 24e2e4a6d842..277482bb1777 100644
> --- a/crypto/asymmetric_keys/pkcs7_parser.c
> +++ b/crypto/asymmetric_keys/pkcs7_parser.c
> @@ -251,6 +251,12 @@ int pkcs7_sig_note_digest_algo(void *context, size_t hdrlen,
>  	case OID_sm3:
>  		ctx->sinfo->sig->hash_algo = "sm3";
>  		break;
> +	case OID_gost2012Digest256:
> +		ctx->sinfo->sig->hash_algo = "streebog256";
> +		break;
> +	case OID_gost2012Digest512:
> +		ctx->sinfo->sig->hash_algo = "streebog512";
> +		break;
>  	default:
>  		printk("Unsupported digest algo: %u\n", ctx->last_oid);
>  		return -ENOPKG;
> @@ -284,6 +290,11 @@ int pkcs7_sig_note_pkey_algo(void *context, size_t hdrlen,
>  		ctx->sinfo->sig->pkey_algo = "sm2";
>  		ctx->sinfo->sig->encoding = "raw";
>  		break;
> +	case OID_gost2012PKey256:
> +	case OID_gost2012PKey512:
> +		ctx->sinfo->sig->pkey_algo = "ecrdsa";
> +		ctx->sinfo->sig->encoding = "raw";
> +		break;
>  	default:
>  		printk("Unsupported pkey algo: %u\n", ctx->last_oid);
>  		return -ENOPKG;
> -- 
> 2.24.3 (Apple Git-128)
> 


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
