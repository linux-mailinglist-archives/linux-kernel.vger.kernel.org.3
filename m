Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8633D4CDE26
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 21:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiCDUCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 15:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiCDUBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:01:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86F646B2E;
        Fri,  4 Mar 2022 11:56:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28485619E9;
        Fri,  4 Mar 2022 19:40:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD61C340F2;
        Fri,  4 Mar 2022 19:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646422835;
        bh=V/xUq6M73q3LYeXdiBMMn5MzBXJndu+kKCtwjOz8f4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aaCIDPgtTe2RvJyPhQfgm4Tv9rWkGWFHVbh++r5lPmlgva3JxqYPpM/qzayLA8x9i
         g6E1r/R5qXc5VoPbS/yGk9rO15SwdqkeE/es1t/O3MTLv17ionMqKgOcEOvy8yYqNW
         RTO146a2xZeopQ2ZlXMhP8hxLuJbasHcw49zMtBxNubFlQ+2pwu1pEfOPlkuNUCt90
         +kcJ6ZkVECucCt+UlTi3aCnUok9LIzXpXm9o+gjtkkQJQldbFEbcdRsCzHCB53ayPD
         STG1oV8YriDui/QIE8jOSx10fZOyf0SKY/whPGE6pkTHXgyqUvr6wuhD46+cmqGA4+
         9MGlIFWCtUYiQ==
Date:   Fri, 4 Mar 2022 11:40:33 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Denis Kenzior <denkenz@gmail.com>,
        James Morris <jmorris@namei.org>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] KEYS: remove support for asym_tpm keys
Message-ID: <YiJrMWY5rX3WDTTo@sol.localdomain>
References: <20220128195655.45342-1-ebiggers@kernel.org>
 <Ygv/V4e1JHyTNEsT@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ygv/V4e1JHyTNEsT@iki.fi>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 08:30:31PM +0100, Jarkko Sakkinen wrote:
> On Fri, Jan 28, 2022 at 11:56:55AM -0800, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > asym_tpm keys are tied to TPM v1.2, which uses outdated crypto and has
> > been deprecated in favor of TPM v2.0 for over 7 years.  A very quick
> > look at this code also immediately found some memory safety bugs
> > (https://lore.kernel.org/r/20220113235440.90439-2-ebiggers@kernel.org).
> > Note that this code is reachable by unprivileged users.
> > 
> > According to Jarkko (one of the keyrings subsystem maintainers), this
> > code has no practical use cases, and he isn't willing to maintain it
> > (https://lore.kernel.org/r/YfFZPbKkgYJGWu1Q@iki.fi).
> > 
> > Therefore, let's remove it.
> > 
> > Note that this feature didn't have any documentation or tests, so we
> > don't need to worry about removing those.
> > 
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: Denis Kenzior <denkenz@gmail.com>
> > Cc: James Morris <jmorris@namei.org>
> > Cc: Jarkko Sakkinen <jarkko@kernel.org>
> > Cc: Marcel Holtmann <marcel@holtmann.org>
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > ---
> >  crypto/asymmetric_keys/Kconfig      |  21 -
> >  crypto/asymmetric_keys/Makefile     |  12 -
> >  crypto/asymmetric_keys/asym_tpm.c   | 957 ----------------------------
> >  crypto/asymmetric_keys/tpm.asn1     |   5 -
> >  crypto/asymmetric_keys/tpm_parser.c | 102 ---
> >  include/crypto/asym_tpm_subtype.h   |  19 -
> >  6 files changed, 1116 deletions(-)
> >  delete mode 100644 crypto/asymmetric_keys/asym_tpm.c
> >  delete mode 100644 crypto/asymmetric_keys/tpm.asn1
> >  delete mode 100644 crypto/asymmetric_keys/tpm_parser.c
> >  delete mode 100644 include/crypto/asym_tpm_subtype.h
> > 
> > diff --git a/crypto/asymmetric_keys/Kconfig b/crypto/asymmetric_keys/Kconfig
> > index 1f1f004dc7577..460bc5d0a828c 100644
> > --- a/crypto/asymmetric_keys/Kconfig
> > +++ b/crypto/asymmetric_keys/Kconfig
> > @@ -22,18 +22,6 @@ config ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> >  	  appropriate hash algorithms (such as SHA-1) must be available.
> >  	  ENOPKG will be reported if the requisite algorithm is unavailable.
> >  
> > -config ASYMMETRIC_TPM_KEY_SUBTYPE
> > -	tristate "Asymmetric TPM backed private key subtype"
> > -	depends on TCG_TPM
> > -	depends on TRUSTED_KEYS
> > -	select CRYPTO_HMAC
> > -	select CRYPTO_SHA1
> > -	select CRYPTO_HASH_INFO
> > -	help
> > -	  This option provides support for TPM backed private key type handling.
> > -	  Operations such as sign, verify, encrypt, decrypt are performed by
> > -	  the TPM after the private key is loaded.
> > -
> >  config X509_CERTIFICATE_PARSER
> >  	tristate "X.509 certificate parser"
> >  	depends on ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> > @@ -54,15 +42,6 @@ config PKCS8_PRIVATE_KEY_PARSER
> >  	  private key data and provides the ability to instantiate a crypto key
> >  	  from that data.
> >  
> > -config TPM_KEY_PARSER
> > -	tristate "TPM private key parser"
> > -	depends on ASYMMETRIC_TPM_KEY_SUBTYPE
> > -	select ASN1
> > -	help
> > -	  This option provides support for parsing TPM format blobs for
> > -	  private key data and provides the ability to instantiate a crypto key
> > -	  from that data.
> > -
> >  config PKCS7_MESSAGE_PARSER
> >  	tristate "PKCS#7 message parser"
> >  	depends on X509_CERTIFICATE_PARSER
> > diff --git a/crypto/asymmetric_keys/Makefile b/crypto/asymmetric_keys/Makefile
> > index 28b91adba2aed..c38424f55b08d 100644
> > --- a/crypto/asymmetric_keys/Makefile
> > +++ b/crypto/asymmetric_keys/Makefile
> > @@ -11,7 +11,6 @@ asymmetric_keys-y := \
> >  	signature.o
> >  
> >  obj-$(CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE) += public_key.o
> > -obj-$(CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE) += asym_tpm.o
> >  
> >  #
> >  # X.509 Certificate handling
> > @@ -75,14 +74,3 @@ verify_signed_pefile-y := \
> >  
> >  $(obj)/mscode_parser.o: $(obj)/mscode.asn1.h $(obj)/mscode.asn1.h
> >  $(obj)/mscode.asn1.o: $(obj)/mscode.asn1.c $(obj)/mscode.asn1.h
> > -
> > -#
> > -# TPM private key parsing
> > -#
> > -obj-$(CONFIG_TPM_KEY_PARSER) += tpm_key_parser.o
> > -tpm_key_parser-y := \
> > -	tpm.asn1.o \
> > -	tpm_parser.o
> > -
> > -$(obj)/tpm_parser.o: $(obj)/tpm.asn1.h
> > -$(obj)/tpm.asn1.o: $(obj)/tpm.asn1.c $(obj)/tpm.asn1.h
> > diff --git a/crypto/asymmetric_keys/asym_tpm.c b/crypto/asymmetric_keys/asym_tpm.c
> > deleted file mode 100644
> > index 0959613560b9e..0000000000000
> > --- a/crypto/asymmetric_keys/asym_tpm.c
> > +++ /dev/null
> > @@ -1,957 +0,0 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > -#define pr_fmt(fmt) "ASYM-TPM: "fmt
> > -#include <linux/slab.h>
> > -#include <linux/module.h>
> > -#include <linux/export.h>
> > -#include <linux/kernel.h>
> > -#include <linux/seq_file.h>
> > -#include <linux/scatterlist.h>
> > -#include <linux/tpm.h>
> > -#include <linux/tpm_command.h>
> > -#include <crypto/akcipher.h>
> > -#include <crypto/hash.h>
> > -#include <crypto/sha1.h>
> > -#include <asm/unaligned.h>
> > -#include <keys/asymmetric-subtype.h>
> > -#include <keys/trusted_tpm.h>
> > -#include <crypto/asym_tpm_subtype.h>
> > -#include <crypto/public_key.h>
> > -
> > -#define TPM_ORD_FLUSHSPECIFIC	186
> > -#define TPM_ORD_LOADKEY2	65
> > -#define TPM_ORD_UNBIND		30
> > -#define TPM_ORD_SIGN		60
> > -
> > -#define TPM_RT_KEY                      0x00000001
> > -
> > -/*
> > - * Load a TPM key from the blob provided by userspace
> > - */
> > -static int tpm_loadkey2(struct tpm_buf *tb,
> > -			uint32_t keyhandle, unsigned char *keyauth,
> > -			const unsigned char *keyblob, int keybloblen,
> > -			uint32_t *newhandle)
> > -{
> > -	unsigned char nonceodd[TPM_NONCE_SIZE];
> > -	unsigned char enonce[TPM_NONCE_SIZE];
> > -	unsigned char authdata[SHA1_DIGEST_SIZE];
> > -	uint32_t authhandle = 0;
> > -	unsigned char cont = 0;
> > -	uint32_t ordinal;
> > -	int ret;
> > -
> > -	ordinal = htonl(TPM_ORD_LOADKEY2);
> > -
> > -	/* session for loading the key */
> > -	ret = oiap(tb, &authhandle, enonce);
> > -	if (ret < 0) {
> > -		pr_info("oiap failed (%d)\n", ret);
> > -		return ret;
> > -	}
> > -
> > -	/* generate odd nonce */
> > -	ret = tpm_get_random(NULL, nonceodd, TPM_NONCE_SIZE);
> > -	if (ret < 0) {
> > -		pr_info("tpm_get_random failed (%d)\n", ret);
> > -		return ret;
> > -	}
> > -
> > -	/* calculate authorization HMAC value */
> > -	ret = TSS_authhmac(authdata, keyauth, SHA1_DIGEST_SIZE, enonce,
> > -			   nonceodd, cont, sizeof(uint32_t), &ordinal,
> > -			   keybloblen, keyblob, 0, 0);
> > -	if (ret < 0)
> > -		return ret;
> > -
> > -	/* build the request buffer */
> > -	tpm_buf_reset(tb, TPM_TAG_RQU_AUTH1_COMMAND, TPM_ORD_LOADKEY2);
> > -	tpm_buf_append_u32(tb, keyhandle);
> > -	tpm_buf_append(tb, keyblob, keybloblen);
> > -	tpm_buf_append_u32(tb, authhandle);
> > -	tpm_buf_append(tb, nonceodd, TPM_NONCE_SIZE);
> > -	tpm_buf_append_u8(tb, cont);
> > -	tpm_buf_append(tb, authdata, SHA1_DIGEST_SIZE);
> > -
> > -	ret = trusted_tpm_send(tb->data, MAX_BUF_SIZE);
> > -	if (ret < 0) {
> > -		pr_info("authhmac failed (%d)\n", ret);
> > -		return ret;
> > -	}
> > -
> > -	ret = TSS_checkhmac1(tb->data, ordinal, nonceodd, keyauth,
> > -			     SHA1_DIGEST_SIZE, 0, 0);
> > -	if (ret < 0) {
> > -		pr_info("TSS_checkhmac1 failed (%d)\n", ret);
> > -		return ret;
> > -	}
> > -
> > -	*newhandle = LOAD32(tb->data, TPM_DATA_OFFSET);
> > -	return 0;
> > -}
> > -
> > -/*
> > - * Execute the FlushSpecific TPM command
> > - */
> > -static int tpm_flushspecific(struct tpm_buf *tb, uint32_t handle)
> > -{
> > -	tpm_buf_reset(tb, TPM_TAG_RQU_COMMAND, TPM_ORD_FLUSHSPECIFIC);
> > -	tpm_buf_append_u32(tb, handle);
> > -	tpm_buf_append_u32(tb, TPM_RT_KEY);
> > -
> > -	return trusted_tpm_send(tb->data, MAX_BUF_SIZE);
> > -}
> > -
> > -/*
> > - * Decrypt a blob provided by userspace using a specific key handle.
> > - * The handle is a well known handle or previously loaded by e.g. LoadKey2
> > - */
> > -static int tpm_unbind(struct tpm_buf *tb,
> > -			uint32_t keyhandle, unsigned char *keyauth,
> > -			const unsigned char *blob, uint32_t bloblen,
> > -			void *out, uint32_t outlen)
> > -{
> > -	unsigned char nonceodd[TPM_NONCE_SIZE];
> > -	unsigned char enonce[TPM_NONCE_SIZE];
> > -	unsigned char authdata[SHA1_DIGEST_SIZE];
> > -	uint32_t authhandle = 0;
> > -	unsigned char cont = 0;
> > -	uint32_t ordinal;
> > -	uint32_t datalen;
> > -	int ret;
> > -
> > -	ordinal = htonl(TPM_ORD_UNBIND);
> > -	datalen = htonl(bloblen);
> > -
> > -	/* session for loading the key */
> > -	ret = oiap(tb, &authhandle, enonce);
> > -	if (ret < 0) {
> > -		pr_info("oiap failed (%d)\n", ret);
> > -		return ret;
> > -	}
> > -
> > -	/* generate odd nonce */
> > -	ret = tpm_get_random(NULL, nonceodd, TPM_NONCE_SIZE);
> > -	if (ret < 0) {
> > -		pr_info("tpm_get_random failed (%d)\n", ret);
> > -		return ret;
> > -	}
> > -
> > -	/* calculate authorization HMAC value */
> > -	ret = TSS_authhmac(authdata, keyauth, SHA1_DIGEST_SIZE, enonce,
> > -			   nonceodd, cont, sizeof(uint32_t), &ordinal,
> > -			   sizeof(uint32_t), &datalen,
> > -			   bloblen, blob, 0, 0);
> > -	if (ret < 0)
> > -		return ret;
> > -
> > -	/* build the request buffer */
> > -	tpm_buf_reset(tb, TPM_TAG_RQU_AUTH1_COMMAND, TPM_ORD_UNBIND);
> > -	tpm_buf_append_u32(tb, keyhandle);
> > -	tpm_buf_append_u32(tb, bloblen);
> > -	tpm_buf_append(tb, blob, bloblen);
> > -	tpm_buf_append_u32(tb, authhandle);
> > -	tpm_buf_append(tb, nonceodd, TPM_NONCE_SIZE);
> > -	tpm_buf_append_u8(tb, cont);
> > -	tpm_buf_append(tb, authdata, SHA1_DIGEST_SIZE);
> > -
> > -	ret = trusted_tpm_send(tb->data, MAX_BUF_SIZE);
> > -	if (ret < 0) {
> > -		pr_info("authhmac failed (%d)\n", ret);
> > -		return ret;
> > -	}
> > -
> > -	datalen = LOAD32(tb->data, TPM_DATA_OFFSET);
> > -
> > -	ret = TSS_checkhmac1(tb->data, ordinal, nonceodd,
> > -			     keyauth, SHA1_DIGEST_SIZE,
> > -			     sizeof(uint32_t), TPM_DATA_OFFSET,
> > -			     datalen, TPM_DATA_OFFSET + sizeof(uint32_t),
> > -			     0, 0);
> > -	if (ret < 0) {
> > -		pr_info("TSS_checkhmac1 failed (%d)\n", ret);
> > -		return ret;
> > -	}
> > -
> > -	memcpy(out, tb->data + TPM_DATA_OFFSET + sizeof(uint32_t),
> > -	       min(outlen, datalen));
> > -
> > -	return datalen;
> > -}
> > -
> > -/*
> > - * Sign a blob provided by userspace (that has had the hash function applied)
> > - * using a specific key handle.  The handle is assumed to have been previously
> > - * loaded by e.g. LoadKey2.
> > - *
> > - * Note that the key signature scheme of the used key should be set to
> > - * TPM_SS_RSASSAPKCS1v15_DER.  This allows the hashed input to be of any size
> > - * up to key_length_in_bytes - 11 and not be limited to size 20 like the
> > - * TPM_SS_RSASSAPKCS1v15_SHA1 signature scheme.
> > - */
> > -static int tpm_sign(struct tpm_buf *tb,
> > -		    uint32_t keyhandle, unsigned char *keyauth,
> > -		    const unsigned char *blob, uint32_t bloblen,
> > -		    void *out, uint32_t outlen)
> > -{
> > -	unsigned char nonceodd[TPM_NONCE_SIZE];
> > -	unsigned char enonce[TPM_NONCE_SIZE];
> > -	unsigned char authdata[SHA1_DIGEST_SIZE];
> > -	uint32_t authhandle = 0;
> > -	unsigned char cont = 0;
> > -	uint32_t ordinal;
> > -	uint32_t datalen;
> > -	int ret;
> > -
> > -	ordinal = htonl(TPM_ORD_SIGN);
> > -	datalen = htonl(bloblen);
> > -
> > -	/* session for loading the key */
> > -	ret = oiap(tb, &authhandle, enonce);
> > -	if (ret < 0) {
> > -		pr_info("oiap failed (%d)\n", ret);
> > -		return ret;
> > -	}
> > -
> > -	/* generate odd nonce */
> > -	ret = tpm_get_random(NULL, nonceodd, TPM_NONCE_SIZE);
> > -	if (ret < 0) {
> > -		pr_info("tpm_get_random failed (%d)\n", ret);
> > -		return ret;
> > -	}
> > -
> > -	/* calculate authorization HMAC value */
> > -	ret = TSS_authhmac(authdata, keyauth, SHA1_DIGEST_SIZE, enonce,
> > -			   nonceodd, cont, sizeof(uint32_t), &ordinal,
> > -			   sizeof(uint32_t), &datalen,
> > -			   bloblen, blob, 0, 0);
> > -	if (ret < 0)
> > -		return ret;
> > -
> > -	/* build the request buffer */
> > -	tpm_buf_reset(tb, TPM_TAG_RQU_AUTH1_COMMAND, TPM_ORD_SIGN);
> > -	tpm_buf_append_u32(tb, keyhandle);
> > -	tpm_buf_append_u32(tb, bloblen);
> > -	tpm_buf_append(tb, blob, bloblen);
> > -	tpm_buf_append_u32(tb, authhandle);
> > -	tpm_buf_append(tb, nonceodd, TPM_NONCE_SIZE);
> > -	tpm_buf_append_u8(tb, cont);
> > -	tpm_buf_append(tb, authdata, SHA1_DIGEST_SIZE);
> > -
> > -	ret = trusted_tpm_send(tb->data, MAX_BUF_SIZE);
> > -	if (ret < 0) {
> > -		pr_info("authhmac failed (%d)\n", ret);
> > -		return ret;
> > -	}
> > -
> > -	datalen = LOAD32(tb->data, TPM_DATA_OFFSET);
> > -
> > -	ret = TSS_checkhmac1(tb->data, ordinal, nonceodd,
> > -			     keyauth, SHA1_DIGEST_SIZE,
> > -			     sizeof(uint32_t), TPM_DATA_OFFSET,
> > -			     datalen, TPM_DATA_OFFSET + sizeof(uint32_t),
> > -			     0, 0);
> > -	if (ret < 0) {
> > -		pr_info("TSS_checkhmac1 failed (%d)\n", ret);
> > -		return ret;
> > -	}
> > -
> > -	memcpy(out, tb->data + TPM_DATA_OFFSET + sizeof(uint32_t),
> > -	       min(datalen, outlen));
> > -
> > -	return datalen;
> > -}
> > -
> > -/* Room to fit two u32 zeros for algo id and parameters length. */
> > -#define SETKEY_PARAMS_SIZE (sizeof(u32) * 2)
> > -
> > -/*
> > - * Maximum buffer size for the BER/DER encoded public key.  The public key
> > - * is of the form SEQUENCE { INTEGER n, INTEGER e } where n is a maximum 2048
> > - * bit key and e is usually 65537
> > - * The encoding overhead is:
> > - * - max 4 bytes for SEQUENCE
> > - *   - max 4 bytes for INTEGER n type/length
> > - *     - 257 bytes of n
> > - *   - max 2 bytes for INTEGER e type/length
> > - *     - 3 bytes of e
> > - * - 4+4 of zeros for set_pub_key parameters (SETKEY_PARAMS_SIZE)
> > - */
> > -#define PUB_KEY_BUF_SIZE (4 + 4 + 257 + 2 + 3 + SETKEY_PARAMS_SIZE)
> > -
> > -/*
> > - * Provide a part of a description of the key for /proc/keys.
> > - */
> > -static void asym_tpm_describe(const struct key *asymmetric_key,
> > -			      struct seq_file *m)
> > -{
> > -	struct tpm_key *tk = asymmetric_key->payload.data[asym_crypto];
> > -
> > -	if (!tk)
> > -		return;
> > -
> > -	seq_printf(m, "TPM1.2/Blob");
> > -}
> > -
> > -static void asym_tpm_destroy(void *payload0, void *payload3)
> > -{
> > -	struct tpm_key *tk = payload0;
> > -
> > -	if (!tk)
> > -		return;
> > -
> > -	kfree(tk->blob);
> > -	tk->blob_len = 0;
> > -
> > -	kfree(tk);
> > -}
> > -
> > -/* How many bytes will it take to encode the length */
> > -static inline uint32_t definite_length(uint32_t len)
> > -{
> > -	if (len <= 127)
> > -		return 1;
> > -	if (len <= 255)
> > -		return 2;
> > -	return 3;
> > -}
> > -
> > -static inline uint8_t *encode_tag_length(uint8_t *buf, uint8_t tag,
> > -					 uint32_t len)
> > -{
> > -	*buf++ = tag;
> > -
> > -	if (len <= 127) {
> > -		buf[0] = len;
> > -		return buf + 1;
> > -	}
> > -
> > -	if (len <= 255) {
> > -		buf[0] = 0x81;
> > -		buf[1] = len;
> > -		return buf + 2;
> > -	}
> > -
> > -	buf[0] = 0x82;
> > -	put_unaligned_be16(len, buf + 1);
> > -	return buf + 3;
> > -}
> > -
> > -static uint32_t derive_pub_key(const void *pub_key, uint32_t len, uint8_t *buf)
> > -{
> > -	uint8_t *cur = buf;
> > -	uint32_t n_len = definite_length(len) + 1 + len + 1;
> > -	uint32_t e_len = definite_length(3) + 1 + 3;
> > -	uint8_t e[3] = { 0x01, 0x00, 0x01 };
> > -
> > -	/* SEQUENCE */
> > -	cur = encode_tag_length(cur, 0x30, n_len + e_len);
> > -	/* INTEGER n */
> > -	cur = encode_tag_length(cur, 0x02, len + 1);
> > -	cur[0] = 0x00;
> > -	memcpy(cur + 1, pub_key, len);
> > -	cur += len + 1;
> > -	cur = encode_tag_length(cur, 0x02, sizeof(e));
> > -	memcpy(cur, e, sizeof(e));
> > -	cur += sizeof(e);
> > -	/* Zero parameters to satisfy set_pub_key ABI. */
> > -	memzero_explicit(cur, SETKEY_PARAMS_SIZE);
> > -
> > -	return cur - buf;
> > -}
> > -
> > -/*
> > - * Determine the crypto algorithm name.
> > - */
> > -static int determine_akcipher(const char *encoding, const char *hash_algo,
> > -			      char alg_name[CRYPTO_MAX_ALG_NAME])
> > -{
> > -	if (strcmp(encoding, "pkcs1") == 0) {
> > -		if (!hash_algo) {
> > -			strcpy(alg_name, "pkcs1pad(rsa)");
> > -			return 0;
> > -		}
> > -
> > -		if (snprintf(alg_name, CRYPTO_MAX_ALG_NAME, "pkcs1pad(rsa,%s)",
> > -			     hash_algo) >= CRYPTO_MAX_ALG_NAME)
> > -			return -EINVAL;
> > -
> > -		return 0;
> > -	}
> > -
> > -	if (strcmp(encoding, "raw") == 0) {
> > -		strcpy(alg_name, "rsa");
> > -		return 0;
> > -	}
> > -
> > -	return -ENOPKG;
> > -}
> > -
> > -/*
> > - * Query information about a key.
> > - */
> > -static int tpm_key_query(const struct kernel_pkey_params *params,
> > -			 struct kernel_pkey_query *info)
> > -{
> > -	struct tpm_key *tk = params->key->payload.data[asym_crypto];
> > -	int ret;
> > -	char alg_name[CRYPTO_MAX_ALG_NAME];
> > -	struct crypto_akcipher *tfm;
> > -	uint8_t der_pub_key[PUB_KEY_BUF_SIZE];
> > -	uint32_t der_pub_key_len;
> > -	int len;
> > -
> > -	/* TPM only works on private keys, public keys still done in software */
> > -	ret = determine_akcipher(params->encoding, params->hash_algo, alg_name);
> > -	if (ret < 0)
> > -		return ret;
> > -
> > -	tfm = crypto_alloc_akcipher(alg_name, 0, 0);
> > -	if (IS_ERR(tfm))
> > -		return PTR_ERR(tfm);
> > -
> > -	der_pub_key_len = derive_pub_key(tk->pub_key, tk->pub_key_len,
> > -					 der_pub_key);
> > -
> > -	ret = crypto_akcipher_set_pub_key(tfm, der_pub_key, der_pub_key_len);
> > -	if (ret < 0)
> > -		goto error_free_tfm;
> > -
> > -	len = crypto_akcipher_maxsize(tfm);
> > -
> > -	info->key_size = tk->key_len;
> > -	info->max_data_size = tk->key_len / 8;
> > -	info->max_sig_size = len;
> > -	info->max_enc_size = len;
> > -	info->max_dec_size = tk->key_len / 8;
> > -
> > -	info->supported_ops = KEYCTL_SUPPORTS_ENCRYPT |
> > -			      KEYCTL_SUPPORTS_DECRYPT |
> > -			      KEYCTL_SUPPORTS_VERIFY |
> > -			      KEYCTL_SUPPORTS_SIGN;
> > -
> > -	ret = 0;
> > -error_free_tfm:
> > -	crypto_free_akcipher(tfm);
> > -	pr_devel("<==%s() = %d\n", __func__, ret);
> > -	return ret;
> > -}
> > -
> > -/*
> > - * Encryption operation is performed with the public key.  Hence it is done
> > - * in software
> > - */
> > -static int tpm_key_encrypt(struct tpm_key *tk,
> > -			   struct kernel_pkey_params *params,
> > -			   const void *in, void *out)
> > -{
> > -	char alg_name[CRYPTO_MAX_ALG_NAME];
> > -	struct crypto_akcipher *tfm;
> > -	struct akcipher_request *req;
> > -	struct crypto_wait cwait;
> > -	struct scatterlist in_sg, out_sg;
> > -	uint8_t der_pub_key[PUB_KEY_BUF_SIZE];
> > -	uint32_t der_pub_key_len;
> > -	int ret;
> > -
> > -	pr_devel("==>%s()\n", __func__);
> > -
> > -	ret = determine_akcipher(params->encoding, params->hash_algo, alg_name);
> > -	if (ret < 0)
> > -		return ret;
> > -
> > -	tfm = crypto_alloc_akcipher(alg_name, 0, 0);
> > -	if (IS_ERR(tfm))
> > -		return PTR_ERR(tfm);
> > -
> > -	der_pub_key_len = derive_pub_key(tk->pub_key, tk->pub_key_len,
> > -					 der_pub_key);
> > -
> > -	ret = crypto_akcipher_set_pub_key(tfm, der_pub_key, der_pub_key_len);
> > -	if (ret < 0)
> > -		goto error_free_tfm;
> > -
> > -	ret = -ENOMEM;
> > -	req = akcipher_request_alloc(tfm, GFP_KERNEL);
> > -	if (!req)
> > -		goto error_free_tfm;
> > -
> > -	sg_init_one(&in_sg, in, params->in_len);
> > -	sg_init_one(&out_sg, out, params->out_len);
> > -	akcipher_request_set_crypt(req, &in_sg, &out_sg, params->in_len,
> > -				   params->out_len);
> > -	crypto_init_wait(&cwait);
> > -	akcipher_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG |
> > -				      CRYPTO_TFM_REQ_MAY_SLEEP,
> > -				      crypto_req_done, &cwait);
> > -
> > -	ret = crypto_akcipher_encrypt(req);
> > -	ret = crypto_wait_req(ret, &cwait);
> > -
> > -	if (ret == 0)
> > -		ret = req->dst_len;
> > -
> > -	akcipher_request_free(req);
> > -error_free_tfm:
> > -	crypto_free_akcipher(tfm);
> > -	pr_devel("<==%s() = %d\n", __func__, ret);
> > -	return ret;
> > -}
> > -
> > -/*
> > - * Decryption operation is performed with the private key in the TPM.
> > - */
> > -static int tpm_key_decrypt(struct tpm_key *tk,
> > -			   struct kernel_pkey_params *params,
> > -			   const void *in, void *out)
> > -{
> > -	struct tpm_buf tb;
> > -	uint32_t keyhandle;
> > -	uint8_t srkauth[SHA1_DIGEST_SIZE];
> > -	uint8_t keyauth[SHA1_DIGEST_SIZE];
> > -	int r;
> > -
> > -	pr_devel("==>%s()\n", __func__);
> > -
> > -	if (params->hash_algo)
> > -		return -ENOPKG;
> > -
> > -	if (strcmp(params->encoding, "pkcs1"))
> > -		return -ENOPKG;
> > -
> > -	r = tpm_buf_init(&tb, 0, 0);
> > -	if (r)
> > -		return r;
> > -
> > -	/* TODO: Handle a non-all zero SRK authorization */
> > -	memset(srkauth, 0, sizeof(srkauth));
> > -
> > -	r = tpm_loadkey2(&tb, SRKHANDLE, srkauth,
> > -				tk->blob, tk->blob_len, &keyhandle);
> > -	if (r < 0) {
> > -		pr_devel("loadkey2 failed (%d)\n", r);
> > -		goto error;
> > -	}
> > -
> > -	/* TODO: Handle a non-all zero key authorization */
> > -	memset(keyauth, 0, sizeof(keyauth));
> > -
> > -	r = tpm_unbind(&tb, keyhandle, keyauth,
> > -		       in, params->in_len, out, params->out_len);
> > -	if (r < 0)
> > -		pr_devel("tpm_unbind failed (%d)\n", r);
> > -
> > -	if (tpm_flushspecific(&tb, keyhandle) < 0)
> > -		pr_devel("flushspecific failed (%d)\n", r);
> > -
> > -error:
> > -	tpm_buf_destroy(&tb);
> > -	pr_devel("<==%s() = %d\n", __func__, r);
> > -	return r;
> > -}
> > -
> > -/*
> > - * Hash algorithm OIDs plus ASN.1 DER wrappings [RFC4880 sec 5.2.2].
> > - */
> > -static const u8 digest_info_md5[] = {
> > -	0x30, 0x20, 0x30, 0x0c, 0x06, 0x08,
> > -	0x2a, 0x86, 0x48, 0x86, 0xf7, 0x0d, 0x02, 0x05, /* OID */
> > -	0x05, 0x00, 0x04, 0x10
> > -};
> > -
> > -static const u8 digest_info_sha1[] = {
> > -	0x30, 0x21, 0x30, 0x09, 0x06, 0x05,
> > -	0x2b, 0x0e, 0x03, 0x02, 0x1a,
> > -	0x05, 0x00, 0x04, 0x14
> > -};
> > -
> > -static const u8 digest_info_rmd160[] = {
> > -	0x30, 0x21, 0x30, 0x09, 0x06, 0x05,
> > -	0x2b, 0x24, 0x03, 0x02, 0x01,
> > -	0x05, 0x00, 0x04, 0x14
> > -};
> > -
> > -static const u8 digest_info_sha224[] = {
> > -	0x30, 0x2d, 0x30, 0x0d, 0x06, 0x09,
> > -	0x60, 0x86, 0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x04,
> > -	0x05, 0x00, 0x04, 0x1c
> > -};
> > -
> > -static const u8 digest_info_sha256[] = {
> > -	0x30, 0x31, 0x30, 0x0d, 0x06, 0x09,
> > -	0x60, 0x86, 0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x01,
> > -	0x05, 0x00, 0x04, 0x20
> > -};
> > -
> > -static const u8 digest_info_sha384[] = {
> > -	0x30, 0x41, 0x30, 0x0d, 0x06, 0x09,
> > -	0x60, 0x86, 0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x02,
> > -	0x05, 0x00, 0x04, 0x30
> > -};
> > -
> > -static const u8 digest_info_sha512[] = {
> > -	0x30, 0x51, 0x30, 0x0d, 0x06, 0x09,
> > -	0x60, 0x86, 0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x03,
> > -	0x05, 0x00, 0x04, 0x40
> > -};
> > -
> > -static const struct asn1_template {
> > -	const char	*name;
> > -	const u8	*data;
> > -	size_t		size;
> > -} asn1_templates[] = {
> > -#define _(X) { #X, digest_info_##X, sizeof(digest_info_##X) }
> > -	_(md5),
> > -	_(sha1),
> > -	_(rmd160),
> > -	_(sha256),
> > -	_(sha384),
> > -	_(sha512),
> > -	_(sha224),
> > -	{ NULL }
> > -#undef _
> > -};
> > -
> > -static const struct asn1_template *lookup_asn1(const char *name)
> > -{
> > -	const struct asn1_template *p;
> > -
> > -	for (p = asn1_templates; p->name; p++)
> > -		if (strcmp(name, p->name) == 0)
> > -			return p;
> > -	return NULL;
> > -}
> > -
> > -/*
> > - * Sign operation is performed with the private key in the TPM.
> > - */
> > -static int tpm_key_sign(struct tpm_key *tk,
> > -			struct kernel_pkey_params *params,
> > -			const void *in, void *out)
> > -{
> > -	struct tpm_buf tb;
> > -	uint32_t keyhandle;
> > -	uint8_t srkauth[SHA1_DIGEST_SIZE];
> > -	uint8_t keyauth[SHA1_DIGEST_SIZE];
> > -	void *asn1_wrapped = NULL;
> > -	uint32_t in_len = params->in_len;
> > -	int r;
> > -
> > -	pr_devel("==>%s()\n", __func__);
> > -
> > -	if (strcmp(params->encoding, "pkcs1"))
> > -		return -ENOPKG;
> > -
> > -	if (params->hash_algo) {
> > -		const struct asn1_template *asn1 =
> > -						lookup_asn1(params->hash_algo);
> > -
> > -		if (!asn1)
> > -			return -ENOPKG;
> > -
> > -		/* request enough space for the ASN.1 template + input hash */
> > -		asn1_wrapped = kzalloc(in_len + asn1->size, GFP_KERNEL);
> > -		if (!asn1_wrapped)
> > -			return -ENOMEM;
> > -
> > -		/* Copy ASN.1 template, then the input */
> > -		memcpy(asn1_wrapped, asn1->data, asn1->size);
> > -		memcpy(asn1_wrapped + asn1->size, in, in_len);
> > -
> > -		in = asn1_wrapped;
> > -		in_len += asn1->size;
> > -	}
> > -
> > -	if (in_len > tk->key_len / 8 - 11) {
> > -		r = -EOVERFLOW;
> > -		goto error_free_asn1_wrapped;
> > -	}
> > -
> > -	r = tpm_buf_init(&tb, 0, 0);
> > -	if (r)
> > -		goto error_free_asn1_wrapped;
> > -
> > -	/* TODO: Handle a non-all zero SRK authorization */
> > -	memset(srkauth, 0, sizeof(srkauth));
> > -
> > -	r = tpm_loadkey2(&tb, SRKHANDLE, srkauth,
> > -			 tk->blob, tk->blob_len, &keyhandle);
> > -	if (r < 0) {
> > -		pr_devel("loadkey2 failed (%d)\n", r);
> > -		goto error_free_tb;
> > -	}
> > -
> > -	/* TODO: Handle a non-all zero key authorization */
> > -	memset(keyauth, 0, sizeof(keyauth));
> > -
> > -	r = tpm_sign(&tb, keyhandle, keyauth, in, in_len, out, params->out_len);
> > -	if (r < 0)
> > -		pr_devel("tpm_sign failed (%d)\n", r);
> > -
> > -	if (tpm_flushspecific(&tb, keyhandle) < 0)
> > -		pr_devel("flushspecific failed (%d)\n", r);
> > -
> > -error_free_tb:
> > -	tpm_buf_destroy(&tb);
> > -error_free_asn1_wrapped:
> > -	kfree(asn1_wrapped);
> > -	pr_devel("<==%s() = %d\n", __func__, r);
> > -	return r;
> > -}
> > -
> > -/*
> > - * Do encryption, decryption and signing ops.
> > - */
> > -static int tpm_key_eds_op(struct kernel_pkey_params *params,
> > -			  const void *in, void *out)
> > -{
> > -	struct tpm_key *tk = params->key->payload.data[asym_crypto];
> > -	int ret = -EOPNOTSUPP;
> > -
> > -	/* Perform the encryption calculation. */
> > -	switch (params->op) {
> > -	case kernel_pkey_encrypt:
> > -		ret = tpm_key_encrypt(tk, params, in, out);
> > -		break;
> > -	case kernel_pkey_decrypt:
> > -		ret = tpm_key_decrypt(tk, params, in, out);
> > -		break;
> > -	case kernel_pkey_sign:
> > -		ret = tpm_key_sign(tk, params, in, out);
> > -		break;
> > -	default:
> > -		BUG();
> > -	}
> > -
> > -	return ret;
> > -}
> > -
> > -/*
> > - * Verify a signature using a public key.
> > - */
> > -static int tpm_key_verify_signature(const struct key *key,
> > -				    const struct public_key_signature *sig)
> > -{
> > -	const struct tpm_key *tk = key->payload.data[asym_crypto];
> > -	struct crypto_wait cwait;
> > -	struct crypto_akcipher *tfm;
> > -	struct akcipher_request *req;
> > -	struct scatterlist src_sg[2];
> > -	char alg_name[CRYPTO_MAX_ALG_NAME];
> > -	uint8_t der_pub_key[PUB_KEY_BUF_SIZE];
> > -	uint32_t der_pub_key_len;
> > -	int ret;
> > -
> > -	pr_devel("==>%s()\n", __func__);
> > -
> > -	BUG_ON(!tk);
> > -	BUG_ON(!sig);
> > -	BUG_ON(!sig->s);
> > -
> > -	if (!sig->digest)
> > -		return -ENOPKG;
> > -
> > -	ret = determine_akcipher(sig->encoding, sig->hash_algo, alg_name);
> > -	if (ret < 0)
> > -		return ret;
> > -
> > -	tfm = crypto_alloc_akcipher(alg_name, 0, 0);
> > -	if (IS_ERR(tfm))
> > -		return PTR_ERR(tfm);
> > -
> > -	der_pub_key_len = derive_pub_key(tk->pub_key, tk->pub_key_len,
> > -					 der_pub_key);
> > -
> > -	ret = crypto_akcipher_set_pub_key(tfm, der_pub_key, der_pub_key_len);
> > -	if (ret < 0)
> > -		goto error_free_tfm;
> > -
> > -	ret = -ENOMEM;
> > -	req = akcipher_request_alloc(tfm, GFP_KERNEL);
> > -	if (!req)
> > -		goto error_free_tfm;
> > -
> > -	sg_init_table(src_sg, 2);
> > -	sg_set_buf(&src_sg[0], sig->s, sig->s_size);
> > -	sg_set_buf(&src_sg[1], sig->digest, sig->digest_size);
> > -	akcipher_request_set_crypt(req, src_sg, NULL, sig->s_size,
> > -				   sig->digest_size);
> > -	crypto_init_wait(&cwait);
> > -	akcipher_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG |
> > -				      CRYPTO_TFM_REQ_MAY_SLEEP,
> > -				      crypto_req_done, &cwait);
> > -	ret = crypto_wait_req(crypto_akcipher_verify(req), &cwait);
> > -
> > -	akcipher_request_free(req);
> > -error_free_tfm:
> > -	crypto_free_akcipher(tfm);
> > -	pr_devel("<==%s() = %d\n", __func__, ret);
> > -	if (WARN_ON_ONCE(ret > 0))
> > -		ret = -EINVAL;
> > -	return ret;
> > -}
> > -
> > -/*
> > - * Parse enough information out of TPM_KEY structure:
> > - * TPM_STRUCT_VER -> 4 bytes
> > - * TPM_KEY_USAGE -> 2 bytes
> > - * TPM_KEY_FLAGS -> 4 bytes
> > - * TPM_AUTH_DATA_USAGE -> 1 byte
> > - * TPM_KEY_PARMS -> variable
> > - * UINT32 PCRInfoSize -> 4 bytes
> > - * BYTE* -> PCRInfoSize bytes
> > - * TPM_STORE_PUBKEY
> > - * UINT32 encDataSize;
> > - * BYTE* -> encDataSize;
> > - *
> > - * TPM_KEY_PARMS:
> > - * TPM_ALGORITHM_ID -> 4 bytes
> > - * TPM_ENC_SCHEME -> 2 bytes
> > - * TPM_SIG_SCHEME -> 2 bytes
> > - * UINT32 parmSize -> 4 bytes
> > - * BYTE* -> variable
> > - */
> > -static int extract_key_parameters(struct tpm_key *tk)
> > -{
> > -	const void *cur = tk->blob;
> > -	uint32_t len = tk->blob_len;
> > -	const void *pub_key;
> > -	uint32_t sz;
> > -	uint32_t key_len;
> > -
> > -	if (len < 11)
> > -		return -EBADMSG;
> > -
> > -	/* Ensure this is a legacy key */
> > -	if (get_unaligned_be16(cur + 4) != 0x0015)
> > -		return -EBADMSG;
> > -
> > -	/* Skip to TPM_KEY_PARMS */
> > -	cur += 11;
> > -	len -= 11;
> > -
> > -	if (len < 12)
> > -		return -EBADMSG;
> > -
> > -	/* Make sure this is an RSA key */
> > -	if (get_unaligned_be32(cur) != 0x00000001)
> > -		return -EBADMSG;
> > -
> > -	/* Make sure this is TPM_ES_RSAESPKCSv15 encoding scheme */
> > -	if (get_unaligned_be16(cur + 4) != 0x0002)
> > -		return -EBADMSG;
> > -
> > -	/* Make sure this is TPM_SS_RSASSAPKCS1v15_DER signature scheme */
> > -	if (get_unaligned_be16(cur + 6) != 0x0003)
> > -		return -EBADMSG;
> > -
> > -	sz = get_unaligned_be32(cur + 8);
> > -	if (len < sz + 12)
> > -		return -EBADMSG;
> > -
> > -	/* Move to TPM_RSA_KEY_PARMS */
> > -	len -= 12;
> > -	cur += 12;
> > -
> > -	/* Grab the RSA key length */
> > -	key_len = get_unaligned_be32(cur);
> > -
> > -	switch (key_len) {
> > -	case 512:
> > -	case 1024:
> > -	case 1536:
> > -	case 2048:
> > -		break;
> > -	default:
> > -		return -EINVAL;
> > -	}
> > -
> > -	/* Move just past TPM_KEY_PARMS */
> > -	cur += sz;
> > -	len -= sz;
> > -
> > -	if (len < 4)
> > -		return -EBADMSG;
> > -
> > -	sz = get_unaligned_be32(cur);
> > -	if (len < 4 + sz)
> > -		return -EBADMSG;
> > -
> > -	/* Move to TPM_STORE_PUBKEY */
> > -	cur += 4 + sz;
> > -	len -= 4 + sz;
> > -
> > -	/* Grab the size of the public key, it should jive with the key size */
> > -	sz = get_unaligned_be32(cur);
> > -	if (sz > 256)
> > -		return -EINVAL;
> > -
> > -	pub_key = cur + 4;
> > -
> > -	tk->key_len = key_len;
> > -	tk->pub_key = pub_key;
> > -	tk->pub_key_len = sz;
> > -
> > -	return 0;
> > -}
> > -
> > -/* Given the blob, parse it and load it into the TPM */
> > -struct tpm_key *tpm_key_create(const void *blob, uint32_t blob_len)
> > -{
> > -	int r;
> > -	struct tpm_key *tk;
> > -
> > -	r = tpm_is_tpm2(NULL);
> > -	if (r < 0)
> > -		goto error;
> > -
> > -	/* We don't support TPM2 yet */
> > -	if (r > 0) {
> > -		r = -ENODEV;
> > -		goto error;
> > -	}
> > -
> > -	r = -ENOMEM;
> > -	tk = kzalloc(sizeof(struct tpm_key), GFP_KERNEL);
> > -	if (!tk)
> > -		goto error;
> > -
> > -	tk->blob = kmemdup(blob, blob_len, GFP_KERNEL);
> > -	if (!tk->blob)
> > -		goto error_memdup;
> > -
> > -	tk->blob_len = blob_len;
> > -
> > -	r = extract_key_parameters(tk);
> > -	if (r < 0)
> > -		goto error_extract;
> > -
> > -	return tk;
> > -
> > -error_extract:
> > -	kfree(tk->blob);
> > -	tk->blob_len = 0;
> > -error_memdup:
> > -	kfree(tk);
> > -error:
> > -	return ERR_PTR(r);
> > -}
> > -EXPORT_SYMBOL_GPL(tpm_key_create);
> > -
> > -/*
> > - * TPM-based asymmetric key subtype
> > - */
> > -struct asymmetric_key_subtype asym_tpm_subtype = {
> > -	.owner			= THIS_MODULE,
> > -	.name			= "asym_tpm",
> > -	.name_len		= sizeof("asym_tpm") - 1,
> > -	.describe		= asym_tpm_describe,
> > -	.destroy		= asym_tpm_destroy,
> > -	.query			= tpm_key_query,
> > -	.eds_op			= tpm_key_eds_op,
> > -	.verify_signature	= tpm_key_verify_signature,
> > -};
> > -EXPORT_SYMBOL_GPL(asym_tpm_subtype);
> > -
> > -MODULE_DESCRIPTION("TPM based asymmetric key subtype");
> > -MODULE_AUTHOR("Intel Corporation");
> > -MODULE_LICENSE("GPL v2");
> > diff --git a/crypto/asymmetric_keys/tpm.asn1 b/crypto/asymmetric_keys/tpm.asn1
> > deleted file mode 100644
> > index d7f194232f30a..0000000000000
> > --- a/crypto/asymmetric_keys/tpm.asn1
> > +++ /dev/null
> > @@ -1,5 +0,0 @@
> > ---
> > --- Unencryted TPM Blob.  For details of the format, see:
> > --- http://david.woodhou.se/draft-woodhouse-cert-best-practice.html#I-D.mavrogiannopoulos-tpmuri
> > ---
> > -PrivateKeyInfo ::= OCTET STRING ({ tpm_note_key })
> > diff --git a/crypto/asymmetric_keys/tpm_parser.c b/crypto/asymmetric_keys/tpm_parser.c
> > deleted file mode 100644
> > index 96405d8dcd98d..0000000000000
> > --- a/crypto/asymmetric_keys/tpm_parser.c
> > +++ /dev/null
> > @@ -1,102 +0,0 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > -#define pr_fmt(fmt) "TPM-PARSER: "fmt
> > -#include <linux/module.h>
> > -#include <linux/kernel.h>
> > -#include <linux/export.h>
> > -#include <linux/slab.h>
> > -#include <linux/err.h>
> > -#include <keys/asymmetric-subtype.h>
> > -#include <keys/asymmetric-parser.h>
> > -#include <crypto/asym_tpm_subtype.h>
> > -#include "tpm.asn1.h"
> > -
> > -struct tpm_parse_context {
> > -	const void	*blob;
> > -	u32		blob_len;
> > -};
> > -
> > -/*
> > - * Note the key data of the ASN.1 blob.
> > - */
> > -int tpm_note_key(void *context, size_t hdrlen,
> > -		   unsigned char tag,
> > -		   const void *value, size_t vlen)
> > -{
> > -	struct tpm_parse_context *ctx = context;
> > -
> > -	ctx->blob = value;
> > -	ctx->blob_len = vlen;
> > -
> > -	return 0;
> > -}
> > -
> > -/*
> > - * Parse a TPM-encrypted private key blob.
> > - */
> > -static struct tpm_key *tpm_parse(const void *data, size_t datalen)
> > -{
> > -	struct tpm_parse_context ctx;
> > -	long ret;
> > -
> > -	memset(&ctx, 0, sizeof(ctx));
> > -
> > -	/* Attempt to decode the private key */
> > -	ret = asn1_ber_decoder(&tpm_decoder, &ctx, data, datalen);
> > -	if (ret < 0)
> > -		goto error;
> > -
> > -	return tpm_key_create(ctx.blob, ctx.blob_len);
> > -
> > -error:
> > -	return ERR_PTR(ret);
> > -}
> > -/*
> > - * Attempt to parse a data blob for a key as a TPM private key blob.
> > - */
> > -static int tpm_key_preparse(struct key_preparsed_payload *prep)
> > -{
> > -	struct tpm_key *tk;
> > -
> > -	/*
> > -	 * TPM 1.2 keys are max 2048 bits long, so assume the blob is no
> > -	 * more than 4x that
> > -	 */
> > -	if (prep->datalen > 256 * 4)
> > -		return -EMSGSIZE;
> > -
> > -	tk = tpm_parse(prep->data, prep->datalen);
> > -
> > -	if (IS_ERR(tk))
> > -		return PTR_ERR(tk);
> > -
> > -	/* We're pinning the module by being linked against it */
> > -	__module_get(asym_tpm_subtype.owner);
> > -	prep->payload.data[asym_subtype] = &asym_tpm_subtype;
> > -	prep->payload.data[asym_key_ids] = NULL;
> > -	prep->payload.data[asym_crypto] = tk;
> > -	prep->payload.data[asym_auth] = NULL;
> > -	prep->quotalen = 100;
> > -	return 0;
> > -}
> > -
> > -static struct asymmetric_key_parser tpm_key_parser = {
> > -	.owner	= THIS_MODULE,
> > -	.name	= "tpm_parser",
> > -	.parse	= tpm_key_preparse,
> > -};
> > -
> > -static int __init tpm_key_init(void)
> > -{
> > -	return register_asymmetric_key_parser(&tpm_key_parser);
> > -}
> > -
> > -static void __exit tpm_key_exit(void)
> > -{
> > -	unregister_asymmetric_key_parser(&tpm_key_parser);
> > -}
> > -
> > -module_init(tpm_key_init);
> > -module_exit(tpm_key_exit);
> > -
> > -MODULE_DESCRIPTION("TPM private key-blob parser");
> > -MODULE_LICENSE("GPL v2");
> > diff --git a/include/crypto/asym_tpm_subtype.h b/include/crypto/asym_tpm_subtype.h
> > deleted file mode 100644
> > index 48198c36d6b9b..0000000000000
> > --- a/include/crypto/asym_tpm_subtype.h
> > +++ /dev/null
> > @@ -1,19 +0,0 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > -#ifndef _LINUX_ASYM_TPM_SUBTYPE_H
> > -#define _LINUX_ASYM_TPM_SUBTYPE_H
> > -
> > -#include <linux/keyctl.h>
> > -
> > -struct tpm_key {
> > -	void *blob;
> > -	u32 blob_len;
> > -	uint16_t key_len; /* Size in bits of the key */
> > -	const void *pub_key; /* pointer inside blob to the public key bytes */
> > -	uint16_t pub_key_len; /* length of the public key */
> > -};
> > -
> > -struct tpm_key *tpm_key_create(const void *blob, uint32_t blob_len);
> > -
> > -extern struct asymmetric_key_subtype asym_tpm_subtype;
> > -
> > -#endif /* _LINUX_ASYM_TPM_SUBTYPE_H */
> > -- 
> > 2.35.0
> > 
> 
> I'm now getting back to track with kernel. Job transition is the reason for
> this misserable latency.
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> This needs some acks from other people before I can apply the patch but I
> strongly support it.

No one has spoken up and said that they care about this feature.  And everyone
who was involved in adding this feature is Cc'ed.  Naturally, if no one cares
about this feature anymore, a response is not guaranteed.  So I'm not sure what
you're waiting for, exactly.

- Eric
