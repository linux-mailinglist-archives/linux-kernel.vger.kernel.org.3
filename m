Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA11A472ACB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 12:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbhLMLAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 06:00:31 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:38674 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232241AbhLMLAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 06:00:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1639393224; x=1670929224;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gzss5ggOeeq/OBTTQzRZMuUpptdOePpN3z+NEITLHvo=;
  b=nD6ESMKnHoaYJi8gUTzKWg090g1Yxx04knbqGxl1FoVNbrt4JP2ywggw
   BCBUcZ8eopwK1JMYIlDDyqBLrq5FbIsGURxAGRArwUONU/rdJjzJR/RJ1
   lnKNkfsw2z1rtaGC7JcfD5csVlmICJqRhsMnXLnZ0H2dktcNbJ7ET+swp
   QAgFvWLmweyzMhP8If2s4oWX54076g2LZrxALTGyeYP1eTUeDtvkKSDWd
   vrmI0aLCukKZzG1m9wCPuVMrEcrMtFzt8fyTjls2IomU87KEzjfLFM+pW
   ImskLKsyoLeOFa537ELtQGWJErQhlCX8oEts1uUoc2fdAZYdAXhmdBk9K
   g==;
X-IronPort-AV: E=Sophos;i="5.88,202,1635199200"; 
   d="scan'208";a="21008247"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 13 Dec 2021 12:00:22 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 13 Dec 2021 12:00:22 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 13 Dec 2021 12:00:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1639393222; x=1670929222;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gzss5ggOeeq/OBTTQzRZMuUpptdOePpN3z+NEITLHvo=;
  b=b0Q5XW99GgZJqXtc0fyvuAVr52NMqiNrB32GCPSaAHvs7Y4zavW6jB9a
   w5OBRMx79FgooJGuJ5titmYoFebejzLcjZ6fI6JiHkE0z7HQOvUaGWR1L
   u9j5zz0r85duml1T9Lle2/LbSF0YAURTUlHWX+zjVgCvu5F3NW0tHrbLj
   dA2kWHQNMtF5ISfQg+PevUzE7mv+2eYyOxWK214+ZpfVCq10kM2Ytm39P
   GCBkV3FTF3VSgNB0bR/aZuxRi5/L/v+IcRqILNeRfwNF/3IvkvRJMG/km
   /44PK2UwjcGe7nZQ0QNb2St+y6QU7fYhenLiKc/58vX1awzckg3qbv+aI
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,202,1635199200"; 
   d="scan'208";a="21008246"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 13 Dec 2021 12:00:22 +0100
Received: from schifferm-ubuntu (SCHIFFERM-M2.tq-net.de [10.121.201.15])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id BF722280065;
        Mon, 13 Dec 2021 12:00:21 +0100 (CET)
Message-ID: <b9283c8a4b3b04c7ee9f525208cbb32d798d4439.camel@ew.tq-group.com>
Subject: Re: [PATCH v4 5/5] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     kernel@pengutronix.de, David Gstir <david@sigma-star.at>,
        Tim Harvey <tharvey@gateworks.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Horia =?UTF-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Udit Agarwal <udit.agarwal@nxp.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        Richard Weinberger <richard@nod.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Date:   Mon, 13 Dec 2021 12:00:19 +0100
In-Reply-To: <a0f1d14af8ac8bae16dd29ad1073f7143ba28f26.1633946449.git-series.a.fatoum@pengutronix.de>
References: <cover.8f40b6d1b93adc80aed2cac29a134f7a7fb5ee98.1633946449.git-series.a.fatoum@pengutronix.de>
         <a0f1d14af8ac8bae16dd29ad1073f7143ba28f26.1633946449.git-series.a.fatoum@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-10-11 at 12:02 +0200, Ahmad Fatoum wrote:
> The Cryptographic Acceleration and Assurance Module (CAAM) is an IP
> core
> built into many newer i.MX and QorIQ SoCs by NXP.
> 
> The CAAM does crypto acceleration, hardware number generation and
> has a blob mechanism for encapsulation/decapsulation of sensitive
> material.
> 
> This blob mechanism depends on a device specific random 256-bit One
> Time
> Programmable Master Key that is fused in each SoC at manufacturing
> time. This key is unreadable and can only be used by the CAAM for AES
> encryption/decryption of user data.
> 
> This makes it a suitable backend (source) for kernel trusted keys.
> 
> Previous commits generalized trusted keys to support multiple
> backends
> and added an API to access the CAAM blob mechanism. Based on these,
> provide the necessary glue to use the CAAM for trusted keys.
> 
> Reviewed-by: David Gstir <david@sigma-star.at>
> Tested-By: Tim Harvey <tharvey@gateworks.com>
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>


Tested-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>


It is unfortunate that this implementation is incompatible with the
"secure keys" feature found in linux-imx, as that would allow upgrading
from linux-imx to mainline kernels in the future without losing access
to keys. I did not follow the discussion of previous versions of this
patch series, but I assume there is some reason why this code is not
aligned with the linux-imx implementation?

Should the kernel emit some kind of warning if CAAM-based trusted keys
are used, but the SoC has not been "closed" (if there is a nice way to
detect that)? As the CAAM is using a common example key instead of the
fused master key when HAB/secure boot are disabled, the kernel would
basically be lying about the keys being trusted in this case.


> ---
> To: Jonathan Corbet <corbet@lwn.net>
> To: David Howells <dhowells@redhat.com>
> To: Jarkko Sakkinen <jarkko@kernel.org>
> To: James Bottomley <jejb@linux.ibm.com>
> To: Mimi Zohar <zohar@linux.ibm.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: "Horia Geantă" <horia.geanta@nxp.com>
> Cc: Aymen Sghaier <aymen.sghaier@nxp.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Udit Agarwal <udit.agarwal@nxp.com>
> Cc: Eric Biggers <ebiggers@kernel.org>
> Cc: Jan Luebbe <j.luebbe@pengutronix.de>
> Cc: David Gstir <david@sigma-star.at>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Franck LENORMAND <franck.lenormand@nxp.com>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: keyrings@vger.kernel.org
> Cc: linux-crypto@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
> Cc: linux-integrity@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> ---
>  Documentation/admin-guide/kernel-parameters.txt   |  1 +-
>  Documentation/security/keys/trusted-encrypted.rst | 42 ++++++++-
>  MAINTAINERS                                       |  9 ++-
>  include/keys/trusted_caam.h                       | 11 ++-
>  security/keys/trusted-keys/Kconfig                | 11 +-
>  security/keys/trusted-keys/Makefile               |  2 +-
>  security/keys/trusted-keys/trusted_caam.c         | 74
> ++++++++++++++++-
>  security/keys/trusted-keys/trusted_core.c         |  6 +-
>  8 files changed, 152 insertions(+), 4 deletions(-)
>  create mode 100644 include/keys/trusted_caam.h
>  create mode 100644 security/keys/trusted-keys/trusted_caam.c
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt
> b/Documentation/admin-guide/kernel-parameters.txt
> index d5969452f063..0ed1165e0f55 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5767,6 +5767,7 @@
>  			sources:
>  			- "tpm"
>  			- "tee"
> +			- "caam"
>  			If not specified then it defaults to iterating
> through
>  			the trust source list starting with TPM and
> assigns the
>  			first trust source as a backend which is
> initialized
> diff --git a/Documentation/security/keys/trusted-encrypted.rst
> b/Documentation/security/keys/trusted-encrypted.rst
> index 1d4b4b8f12f0..ad66573ca6fd 100644
> --- a/Documentation/security/keys/trusted-encrypted.rst
> +++ b/Documentation/security/keys/trusted-encrypted.rst
> @@ -35,6 +35,13 @@ safe.
>           Rooted to Hardware Unique Key (HUK) which is generally
> burnt in on-chip
>           fuses and is accessible to TEE only.
>  
> +     (3) CAAM (Cryptographic Acceleration and Assurance Module: IP
> on NXP SoCs)
> +
> +         When High Assurance Boot (HAB) is enabled and the CAAM is
> in secure
> +         mode, trust is rooted to the OTPMK, a never-disclosed 256-
> bit key
> +         randomly generated and fused into each SoC at manufacturing
> time.
> +         Otherwise, a common fixed test key is used instead.
> +
>    *  Execution isolation
>  
>       (1) TPM
> @@ -46,6 +53,10 @@ safe.
>           Customizable set of operations running in isolated
> execution
>           environment verified via Secure/Trusted boot process.
>  
> +     (3) CAAM
> +
> +         Fixed set of operations running in isolated execution
> environment.
> +
>    * Optional binding to platform integrity state
>  
>       (1) TPM
> @@ -63,6 +74,11 @@ safe.
>           Relies on Secure/Trusted boot process for platform
> integrity. It can
>           be extended with TEE based measured boot process.
>  
> +     (3) CAAM
> +
> +         Relies on the High Assurance Boot (HAB) mechanism of NXP
> SoCs
> +         for platform integrity.
> +
>    *  Interfaces and APIs
>  
>       (1) TPM
> @@ -74,10 +90,13 @@ safe.
>           TEEs have well-documented, standardized client interface
> and APIs. For
>           more details refer to ``Documentation/staging/tee.rst``.
>  
> +     (3) CAAM
> +
> +         Interface is specific to silicon vendor.
>  
>    *  Threat model
>  
> -     The strength and appropriateness of a particular TPM or TEE for
> a given
> +     The strength and appropriateness of a particular trust source
> for a given
>       purpose must be assessed when using them to protect security-
> relevant data.
>  
>  
> @@ -104,8 +123,14 @@ selected trust source:
>       from platform specific hardware RNG or a software based Fortuna
> CSPRNG
>       which can be seeded via multiple entropy sources.
>  
> +  *  CAAM: Kernel RNG
> +
> +     The normal kernel random number generator is used. To seed it
> from the
> +     CAAM HWRNG, enable CRYPTO_DEV_FSL_CAAM_RNG_API and ensure the
> device
> +     can be probed.
> +
>  Optionally, users may specify ``trusted.kernel_rng=1`` on the kernel
> -command-line to override the used RNG with the kernel's random
> number pool.
> +command-line to force use of the kernel's random number pool.
>  
>  Encrypted Keys
>  --------------
> @@ -192,6 +217,19 @@ Usage::
>  specific to TEE device implementation.  The key length for new keys
> is always
>  in bytes. Trusted Keys can be 32 - 128 bytes (256 - 1024 bits).
>  
> +Trusted Keys usage: CAAM
> +------------------------
> +
> +Usage::
> +
> +    keyctl add trusted name "new keylen" ring
> +    keyctl add trusted name "load hex_blob" ring
> +    keyctl print keyid
> +
> +"keyctl print" returns an ASCII hex copy of the sealed key, which is
> in format
> +specific to CAAM device implementation.  The key length for new keys
> is always
> +in bytes. Trusted Keys can be 32 - 128 bytes (256 - 1024 bits).
> +
>  Encrypted Keys usage
>  --------------------
>  
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a4a0c2baaf27..2c6514759222 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10364,6 +10364,15 @@ S:	Supported
>  F:	include/keys/trusted_tee.h
>  F:	security/keys/trusted-keys/trusted_tee.c
>  
> +KEYS-TRUSTED-CAAM
> +M:	Ahmad Fatoum <a.fatoum@pengutronix.de>
> +R:	Pengutronix Kernel Team <kernel@pengutronix.de>
> +L:	linux-integrity@vger.kernel.org
> +L:	keyrings@vger.kernel.org
> +S:	Supported
> +F:	include/keys/trusted_caam.h
> +F:	security/keys/trusted-keys/trusted_caam.c
> +
>  KEYS/KEYRINGS
>  M:	David Howells <dhowells@redhat.com>
>  M:	Jarkko Sakkinen <jarkko@kernel.org>
> diff --git a/include/keys/trusted_caam.h
> b/include/keys/trusted_caam.h
> new file mode 100644
> index 000000000000..2fba0996b0b0
> --- /dev/null
> +++ b/include/keys/trusted_caam.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2021 Pengutronix, Ahmad Fatoum <
> kernel@pengutronix.de>
> + */
> +
> +#ifndef __CAAM_TRUSTED_KEY_H
> +#define __CAAM_TRUSTED_KEY_H
> +
> +extern struct trusted_key_ops caam_trusted_key_ops;
> +
> +#endif
> diff --git a/security/keys/trusted-keys/Kconfig
> b/security/keys/trusted-keys/Kconfig
> index fc4abd581abb..dbfdd8536468 100644
> --- a/security/keys/trusted-keys/Kconfig
> +++ b/security/keys/trusted-keys/Kconfig
> @@ -24,6 +24,15 @@ config TRUSTED_KEYS_TEE
>  	  Enable use of the Trusted Execution Environment (TEE) as
> trusted
>  	  key backend.
>  
> -if !TRUSTED_KEYS_TPM && !TRUSTED_KEYS_TEE
> +config TRUSTED_KEYS_CAAM
> +	bool "CAAM-based trusted keys"
> +	depends on CRYPTO_DEV_FSL_CAAM_JR >= TRUSTED_KEYS
> +	select CRYPTO_DEV_FSL_CAAM_BLOB_GEN
> +	default y
> +	help
> +	  Enable use of NXP's Cryptographic Accelerator and Assurance
> Module
> +	  (CAAM) as trusted key backend.
> +
> +if !TRUSTED_KEYS_TPM && !TRUSTED_KEYS_TEE && !TRUSTED_KEYS_CAAM
>  comment "No trust source selected!"
>  endif
> diff --git a/security/keys/trusted-keys/Makefile
> b/security/keys/trusted-keys/Makefile
> index 2e2371eae4d5..735aa0bc08ef 100644
> --- a/security/keys/trusted-keys/Makefile
> +++ b/security/keys/trusted-keys/Makefile
> @@ -12,3 +12,5 @@ trusted-$(CONFIG_TRUSTED_KEYS_TPM) +=
> trusted_tpm2.o
>  trusted-$(CONFIG_TRUSTED_KEYS_TPM) += tpm2key.asn1.o
>  
>  trusted-$(CONFIG_TRUSTED_KEYS_TEE) += trusted_tee.o
> +
> +trusted-$(CONFIG_TRUSTED_KEYS_CAAM) += trusted_caam.o
> diff --git a/security/keys/trusted-keys/trusted_caam.c
> b/security/keys/trusted-keys/trusted_caam.c
> new file mode 100644
> index 000000000000..01adfd18adda
> --- /dev/null
> +++ b/security/keys/trusted-keys/trusted_caam.c
> @@ -0,0 +1,74 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2021 Pengutronix, Ahmad Fatoum <
> kernel@pengutronix.de>
> + */
> +
> +#include <keys/trusted_caam.h>
> +#include <keys/trusted-type.h>
> +#include <linux/build_bug.h>
> +#include <linux/key-type.h>
> +#include <soc/fsl/caam-blob.h>
> +
> +static struct caam_blob_priv *blobifier;
> +
> +#define KEYMOD "kernel:trusted"
> +
> +static_assert(MAX_KEY_SIZE + CAAM_BLOB_OVERHEAD <=
> CAAM_BLOB_MAX_LEN);
> +static_assert(MAX_BLOB_SIZE <= CAAM_BLOB_MAX_LEN);
> +
> +static int trusted_caam_seal(struct trusted_key_payload *p, char
> *datablob)
> +{
> +	int length = p->key_len + CAAM_BLOB_OVERHEAD;
> +	int ret;
> +
> +	ret = caam_encap_blob(blobifier, KEYMOD, p->key, p->blob,
> length);
> +	if (ret)
> +		return ret;
> +
> +	p->blob_len = length;
> +	return 0;
> +}
> +
> +static int trusted_caam_unseal(struct trusted_key_payload *p, char
> *datablob)
> +{
> +	int length = p->blob_len;
> +	int ret;
> +
> +	ret = caam_decap_blob(blobifier, KEYMOD, p->blob, p->key,
> length);
> +	if (ret)
> +		return ret;
> +
> +	p->key_len = length - CAAM_BLOB_OVERHEAD;
> +	return 0;
> +}
> +
> +static int trusted_caam_init(void)
> +{
> +	int ret;
> +
> +	blobifier = caam_blob_gen_init();
> +	if (IS_ERR(blobifier)) {
> +		pr_err("Job Ring Device allocation for transform
> failed\n");
> +		return PTR_ERR(blobifier);
> +	}
> +
> +	ret = register_key_type(&key_type_trusted);
> +	if (ret)
> +		caam_blob_gen_exit(blobifier);
> +
> +	return ret;
> +}
> +
> +static void trusted_caam_exit(void)
> +{
> +	unregister_key_type(&key_type_trusted);
> +	caam_blob_gen_exit(blobifier);
> +}
> +
> +struct trusted_key_ops caam_trusted_key_ops = {
> +	.migratable = 0, /* non-migratable */
> +	.init = trusted_caam_init,
> +	.seal = trusted_caam_seal,
> +	.unseal = trusted_caam_unseal,
> +	.exit = trusted_caam_exit,
> +};
> diff --git a/security/keys/trusted-keys/trusted_core.c
> b/security/keys/trusted-keys/trusted_core.c
> index d2b7626cde8b..305e44651180 100644
> --- a/security/keys/trusted-keys/trusted_core.c
> +++ b/security/keys/trusted-keys/trusted_core.c
> @@ -9,6 +9,7 @@
>  #include <keys/user-type.h>
>  #include <keys/trusted-type.h>
>  #include <keys/trusted_tee.h>
> +#include <keys/trusted_caam.h>
>  #include <keys/trusted_tpm.h>
>  #include <linux/capability.h>
>  #include <linux/err.h>
> @@ -29,7 +30,7 @@ MODULE_PARM_DESC(kernel_rng, "Generate key material
> from kernel RNG");
>  
>  static char *trusted_key_source;
>  module_param_named(source, trusted_key_source, charp, 0);
> -MODULE_PARM_DESC(source, "Select trusted keys source (tpm or tee)");
> +MODULE_PARM_DESC(source, "Select trusted keys source (tpm, tee or
> caam)");
>  
>  static const struct trusted_key_source trusted_key_sources[] = {
>  #if defined(CONFIG_TRUSTED_KEYS_TPM)
> @@ -38,6 +39,9 @@ static const struct trusted_key_source
> trusted_key_sources[] = {
>  #if defined(CONFIG_TRUSTED_KEYS_TEE)
>  	{ "tee", &trusted_key_tee_ops },
>  #endif
> +#if defined(CONFIG_TRUSTED_KEYS_CAAM)
> +	{ "caam", &caam_trusted_key_ops },
> +#endif
>  };
>  
>  DEFINE_STATIC_CALL_NULL(trusted_key_init,
> *trusted_key_sources[0].ops->init);

