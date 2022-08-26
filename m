Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5945A306B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 22:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344911AbiHZUXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 16:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbiHZUXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 16:23:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AEEC88A1;
        Fri, 26 Aug 2022 13:23:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97635B83114;
        Fri, 26 Aug 2022 20:23:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E74FDC433D6;
        Fri, 26 Aug 2022 20:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661545388;
        bh=7cCDjYToph++Z/ONuGisoLePKjQz5vPpNaRrGjuFxao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EmkGQofJICdXtAwYKaBLKXrvOrsaFzzle1UCo1WanL/8NWbeQlEur23/S9KadZC3c
         oeXJn3xoNIvUur9FFx5vPZgKMNUM+IVC3tYxG86ejlTNhQkpMIDHiq6qjrmFNSsWhT
         HBRczUOefGKJxiY45U/tnYmZm116gjfeQ5cLiWvsucdA0Ya0PGCdSo/5szlcRDAXtY
         ZVbP9xr/DM2i/Dlcn/oi6K20htE2igPDRDfasgUZ5cqXejPBJiEu9vVyYy3HkEeadJ
         nMCjpoWdXQ5W68V/sKZm0MXOJjJSKF/sOkI2yJ/k7/UPL5p1NYfmE7F0thfZx7p7zt
         4wVgd5bNjdWkQ==
Date:   Fri, 26 Aug 2022 23:23:00 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Ben Boeckel <me@benboeckel.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Malte Gell <malte.gell@gmx.de>,
        Varad Gautam <varad.gautam@suse.com>,
        Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Lee, Chun-Yi" <jlee@suse.com>
Subject: Re: [PATCH v9,1/4] X.509: Add CodeSigning extended key usage parsing
Message-ID: <YwkrpLPyU0huPduE@kernel.org>
References: <20220825142314.8406-1-jlee@suse.com>
 <20220825142314.8406-2-jlee@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825142314.8406-2-jlee@suse.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 10:23:11PM +0800, Lee, Chun-Yi wrote:
> This patch adds the logic for parsing the CodeSign extended key usage

It's *not* a patch once it is applied.

And isn't the identifier actually "codeSign", not "CodeSign"? Please,
format identifier correctly in order not to cause confusion.

So, how I would rewrite the first sentence, would be:

  Add the logic for parsing codeSign extended key usage field, as
  described in RFC2459, section "4.2.1.13  Extended key usage
  field.

E.g. it took me 15 minutes to review the commit message alone
because I could not remember the RFC number off top of my head.

> extension in X.509. The parsing result will be set to the
> ext_key_usage
> flag which is carried by public key. It can be used in the PKCS#7
> verification.
> 
> Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
> ---
>  crypto/asymmetric_keys/x509_cert_parser.c | 25 +++++++++++++++++++++++
>  include/crypto/public_key.h               |  1 +
>  include/linux/oid_registry.h              |  5 +++++
>  3 files changed, 31 insertions(+)
> 
> diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
> index 2899ed80bb18..1f67e0adef65 100644
> --- a/crypto/asymmetric_keys/x509_cert_parser.c
> +++ b/crypto/asymmetric_keys/x509_cert_parser.c
> @@ -554,6 +554,8 @@ int x509_process_extension(void *context, size_t hdrlen,
>  	struct x509_parse_context *ctx = context;
>  	struct asymmetric_key_id *kid;
>  	const unsigned char *v = value;
> +	int i = 0;
> +	enum OID oid;

I'd reorder the declarations (suggestion).

>  
>  	pr_debug("Extension: %u\n", ctx->last_oid);
>  
> @@ -583,6 +585,29 @@ int x509_process_extension(void *context, size_t hdrlen,
>  		return 0;
>  	}
>  
> +	if (ctx->last_oid == OID_extKeyUsage) {
> +		if (vlen < 2 ||
> +		    v[0] != ((ASN1_UNIV << 6) | ASN1_CONS_BIT | ASN1_SEQ) ||
> +		    v[1] != vlen - 2)
> +			return -EBADMSG;
> +		i += 2;
> +
> +		while (i < vlen) {
> +			/* A 10 bytes EKU OID Octet blob =
> +			 * ASN1_OID + size byte + 8 bytes OID */
> +			if ((i + 10) > vlen || v[i] != ASN1_OID || v[i + 1] != 8)
> +				return -EBADMSG;
> +
> +			oid = look_up_OID(v + i + 2, v[i + 1]);
> +			if (oid == OID_codeSigning) {
> +				ctx->cert->pub->ext_key_usage |= EKU_codeSigning;
> +			}
> +			i += 10;
> +		}
> +		pr_debug("extKeyUsage: %d\n", ctx->cert->pub->ext_key_usage);
> +		return 0;
> +	}
> +
>  	return 0;
>  }
>  
> diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
> index 68f7aa2a7e55..72c0fcc39d0f 100644
> --- a/include/crypto/public_key.h
> +++ b/include/crypto/public_key.h
> @@ -28,6 +28,7 @@ struct public_key {
>  	bool key_is_private;
>  	const char *id_type;
>  	const char *pkey_algo;
> +	unsigned int ext_key_usage : 9;      /* Extended Key Usage (9-bit) */
>  };
>  
>  extern void public_key_free(struct public_key *key);
> diff --git a/include/linux/oid_registry.h b/include/linux/oid_registry.h
> index 0f4a8903922a..460135c2d918 100644
> --- a/include/linux/oid_registry.h
> +++ b/include/linux/oid_registry.h
> @@ -140,9 +140,14 @@ enum OID {
>  	OID_TPMImportableKey,		/* 2.23.133.10.1.4 */
>  	OID_TPMSealedData,		/* 2.23.133.10.1.5 */
>  
> +	/* Extended key purpose OIDs [RFC 5280] */
> +	OID_codeSigning,		/* 1.3.6.1.5.5.7.3.3 */
> +
>  	OID__NR
>  };
>  
> +#define EKU_codeSigning	(1 << 2)
> +
>  extern enum OID look_up_OID(const void *data, size_t datasize);
>  extern int parse_OID(const void *data, size_t datasize, enum OID *oid);
>  extern int sprint_oid(const void *, size_t, char *, size_t);
> -- 
> 2.26.2
> 

BR, Jarkko
