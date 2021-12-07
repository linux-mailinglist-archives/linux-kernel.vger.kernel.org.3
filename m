Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4BCE46C070
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 17:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239510AbhLGQOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 11:14:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39714 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239431AbhLGQOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 11:14:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638893470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Onz5Twi1yBYsmurLPM8Oy6J1rZ5yDH44DYmuLT6gN40=;
        b=XtY+L/CmDsNlBB1VlPgYOtHXCCoDZXSC0EwGy/ngGfAqVMEH4b4zZddV+AJ6ld8udVkVHK
        Vn0QMVlWhRw4D9jtDILWeQFixKzq+/lPsJ5pgP4f/w88IfSCo7xdVNfxT1gvcm8+ARH5o6
        oc3hPdWsS5/jnfgnCIrlw5BmhxW/m9s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-524-FPUfGenlPk2WNeICvGOZDQ-1; Tue, 07 Dec 2021 11:11:07 -0500
X-MC-Unique: FPUfGenlPk2WNeICvGOZDQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BBFD31023F53;
        Tue,  7 Dec 2021 16:11:03 +0000 (UTC)
Received: from rhtmp (unknown [10.39.192.202])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BF2305DF4B;
        Tue,  7 Dec 2021 16:10:36 +0000 (UTC)
Date:   Tue, 7 Dec 2021 17:10:34 +0100
From:   Philipp Rudo <prudo@redhat.com>
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     keyrings@vger.kernel.org, kexec@lists.infradead.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nayna <nayna@linux.vnet.ibm.com>, Rob Herring <robh@kernel.org>,
        linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org,
        Frank van der Linden <fllinden@amazon.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Daniel Axtens <dja@axtens.net>, buendgen@de.ibm.com,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 6/6] module: Move duplicate mod_check_sig users code
 to mod_parse_sig
Message-ID: <20211207171034.0b782d82@rhtmp>
In-Reply-To: <d464e1f45d21a29cbbe828dea412206cdc94866b.1637862358.git.msuchanek@suse.de>
References: <cover.1637862358.git.msuchanek@suse.de>
        <d464e1f45d21a29cbbe828dea412206cdc94866b.1637862358.git.msuchanek@suse.de>
Organization: Red Hat inc.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On Thu, 25 Nov 2021 19:02:44 +0100
Michal Suchanek <msuchanek@suse.de> wrote:

> Multiple users of mod_check_sig check for the marker, then call
> mod_check_sig, extract signature length, and remove the signature.
> 
> Put this code in one place together with mod_check_sig.
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  include/linux/module_signature.h    |  1 +
>  kernel/module_signature.c           | 56 ++++++++++++++++++++++++++++-
>  kernel/module_signing.c             | 26 +++-----------
>  security/integrity/ima/ima_modsig.c | 22 ++----------
>  4 files changed, 63 insertions(+), 42 deletions(-)
> 
> diff --git a/include/linux/module_signature.h b/include/linux/module_signature.h
> index 7eb4b00381ac..1343879b72b3 100644
> --- a/include/linux/module_signature.h
> +++ b/include/linux/module_signature.h
> @@ -42,5 +42,6 @@ struct module_signature {
>  
>  int mod_check_sig(const struct module_signature *ms, size_t file_len,
>  		  const char *name);
> +int mod_parse_sig(const void *data, size_t *len, size_t *sig_len, const char *name);
>  
>  #endif /* _LINUX_MODULE_SIGNATURE_H */
> diff --git a/kernel/module_signature.c b/kernel/module_signature.c
> index 00132d12487c..784b40575ee4 100644
> --- a/kernel/module_signature.c
> +++ b/kernel/module_signature.c
> @@ -8,14 +8,36 @@
>  
>  #include <linux/errno.h>
>  #include <linux/printk.h>
> +#include <linux/string.h>
>  #include <linux/module_signature.h>
>  #include <asm/byteorder.h>
>  
> +/**
> + * mod_check_sig_marker - check that the given data has signature marker at the end
> + *
> + * @data:	Data with appended signature
> + * @len:	Length of data. Signature marker length is subtracted on success.
> + */
> +static inline int mod_check_sig_marker(const void *data, size_t *len)

I personally don't like it when a function has a "check" in it's name
as it doesn't describe what the function is checking for. For me
mod_has_sig_marker is much more precise. I would use that instead.

Thanks
Philipp

> +{
> +	const unsigned long markerlen = sizeof(MODULE_SIG_STRING) - 1;
> +
> +	if (markerlen > *len)
> +		return -ENODATA;
> +
> +	if (memcmp(data + *len - markerlen, MODULE_SIG_STRING,
> +		   markerlen))
> +		return -ENODATA;
> +
> +	*len -= markerlen;
> +	return 0;
> +}
> +
>  /**
>   * mod_check_sig - check that the given signature is sane
>   *
>   * @ms:		Signature to check.
> - * @file_len:	Size of the file to which @ms is appended.
> + * @file_len:	Size of the file to which @ms is appended (without the marker).
>   * @name:	What is being checked. Used for error messages.
>   */
>  int mod_check_sig(const struct module_signature *ms, size_t file_len,
> @@ -44,3 +66,35 @@ int mod_check_sig(const struct module_signature *ms, size_t file_len,
>  
>  	return 0;
>  }
> +
> +/**
> + * mod_parse_sig - check that the given signature is sane and determine signature length
> + *
> + * @data:	Data with appended signature.
> + * @len:	Length of data. Signature and marker length is subtracted on success.
> + * @sig_len:	Length of signature. Filled on success.
> + * @name:	What is being checked. Used for error messages.
> + */
> +int mod_parse_sig(const void *data, size_t *len, size_t *sig_len, const char *name)
> +{
> +	const struct module_signature *sig;
> +	int rc;
> +
> +	rc = mod_check_sig_marker(data, len);
> +	if (rc)
> +		return rc;
> +
> +	if (*len < sizeof(*sig))
> +		return -ENODATA;
> +
> +	sig = (const struct module_signature *)(data + (*len - sizeof(*sig)));
> +
> +	rc = mod_check_sig(sig, *len, name);
> +	if (rc)
> +		return rc;
> +
> +	*sig_len = be32_to_cpu(sig->sig_len);
> +	*len -= *sig_len + sizeof(*sig);
> +
> +	return 0;
> +}
> diff --git a/kernel/module_signing.c b/kernel/module_signing.c
> index cef72a6f6b5d..02bbca90f467 100644
> --- a/kernel/module_signing.c
> +++ b/kernel/module_signing.c
> @@ -25,35 +25,17 @@ int verify_appended_signature(const void *data, size_t *len,
>  			      struct key *trusted_keys,
>  			      enum key_being_used_for purpose)
>  {
> -	const unsigned long markerlen = sizeof(MODULE_SIG_STRING) - 1;
>  	struct module_signature ms;
> -	size_t sig_len, modlen = *len;
> +	size_t sig_len;
>  	int ret;
>  
> -	pr_devel("==>%s %s(,%zu)\n", __func__, key_being_used_for[purpose], modlen);  
> +	pr_devel("==>%s %s(,%zu)\n", __func__, key_being_used_for[purpose], *len);
>  
> -	if (markerlen > modlen)
> -		return -ENODATA;
> -
> -	if (memcmp(data + modlen - markerlen, MODULE_SIG_STRING,
> -		   markerlen))
> -		return -ENODATA;
> -	modlen -= markerlen;
> -
> -	if (modlen <= sizeof(ms))
> -		return -EBADMSG;
> -
> -	memcpy(&ms, data + (modlen - sizeof(ms)), sizeof(ms));
> -
> -	ret = mod_check_sig(&ms, modlen, key_being_used_for[purpose]);
> +	ret = mod_parse_sig(data, len, &sig_len, key_being_used_for[purpose]);
>  	if (ret)
>  		return ret;
>  
> -	sig_len = be32_to_cpu(ms.sig_len);
> -	modlen -= sig_len + sizeof(ms);
> -	*len = modlen;
> -
> -	return verify_pkcs7_signature(data, modlen, data + modlen, sig_len,
> +	return verify_pkcs7_signature(data, *len, data + *len, sig_len,
>  				      trusted_keys,
>  				      purpose,
>  				      NULL, NULL);
> diff --git a/security/integrity/ima/ima_modsig.c b/security/integrity/ima/ima_modsig.c
> index fb25723c65bc..46917eb37fd8 100644
> --- a/security/integrity/ima/ima_modsig.c
> +++ b/security/integrity/ima/ima_modsig.c
> @@ -37,33 +37,17 @@ struct modsig {
>   *
>   * Return: 0 on success, error code otherwise.
>   */
> -int ima_read_modsig(enum ima_hooks func, const void *buf, loff_t buf_len,
> +int ima_read_modsig(enum ima_hooks func, const void *buf, loff_t len,
>  		    struct modsig **modsig)
>  {
> -	const size_t marker_len = strlen(MODULE_SIG_STRING);
> -	const struct module_signature *sig;
>  	struct modsig *hdr;
> -	size_t sig_len;
> -	const void *p;
> +	size_t sig_len, buf_len = len;
>  	int rc;
>  
> -	if (buf_len <= marker_len + sizeof(*sig))
> -		return -ENOENT;
> -
> -	p = buf + buf_len - marker_len;
> -	if (memcmp(p, MODULE_SIG_STRING, marker_len))
> -		return -ENOENT;
> -
> -	buf_len -= marker_len;
> -	sig = (const struct module_signature *)(p - sizeof(*sig));
> -
> -	rc = mod_check_sig(sig, buf_len, func_tokens[func]);
> +	rc = mod_parse_sig(buf, &buf_len, &sig_len, func_tokens[func]);
>  	if (rc)
>  		return rc;
>  
> -	sig_len = be32_to_cpu(sig->sig_len);
> -	buf_len -= sig_len + sizeof(*sig);
> -
>  	/* Allocate sig_len additional bytes to hold the raw PKCS#7 data. */
>  	hdr = kzalloc(sizeof(*hdr) + sig_len, GFP_KERNEL);
>  	if (!hdr)

