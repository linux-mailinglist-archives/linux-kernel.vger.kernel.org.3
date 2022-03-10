Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A464D4FC5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 17:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235121AbiCJQxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 11:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244327AbiCJQxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 11:53:01 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8033198D30
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 08:51:57 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id 9so5385229pll.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 08:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y6eO8XbobmJwk07KyUQcG8ew/bFwEAqu4InZOavV7ZM=;
        b=YTkLBhADqm9amv8PHrviGDK7uKbDAZgW7pTRiKrarMaKDkgVtNpIIN+9hNVp4Ef3qI
         3w8N8HgC43l507NznwsW5B3iVpzhTE+71LKzCdVPMk0OUcTgdrWfYg31w9PWfxTgc3Vv
         QDGxj6g6cf9/tGJQbvLczxTLlCPUEuuKI8PxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y6eO8XbobmJwk07KyUQcG8ew/bFwEAqu4InZOavV7ZM=;
        b=v0YnPQwxGYEfSwP2rviIxQwOMXLujHXGu3B1zIvQfxPygbRJxMPFMAFBX+XWeCnTN4
         nsc5qpGa9RH8y4m0z2T8H4EceK96Zel3CYzJJKpMsfYIOh+5JdVZ+BCyGzqXbb7lf4oD
         VXKD/yrQ0+wR38pkssZOmKmcM0ZfFSxqU7zTNdjbOYP91Eoyvkc2HA8a2Qmoq9VB3DVF
         fkWewSBk2Ola6oQAYzxPyl8a9BEkqPlGLaN+Uzn6MgjZawQCn18sHtiS2vhBd+zrl0wJ
         y5KXGIhY77Qhz9r6qvI1Zo+dCN87RRCpAk1uWDUISoUU3VE5YeKQRbph38dxXFm/KkGw
         CCFw==
X-Gm-Message-State: AOAM530JVFQcMM4hzpaV+dUKzocw8GMyoq7RZRLa2IHWCR/8B7DiSrXT
        KbcEApUsawoWLLdg4ejT9IprSg==
X-Google-Smtp-Source: ABdhPJwbpPcd4SwVPizlO9aynJTzqL0J0dIIdt2zDjb56noFAp2YlrMV9nMDaEqeoxUa/R1A7MI0gA==
X-Received: by 2002:a17:902:7e4d:b0:14f:e295:5a41 with SMTP id a13-20020a1709027e4d00b0014fe2955a41mr5872399pln.27.1646931117342;
        Thu, 10 Mar 2022 08:51:57 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id lb4-20020a17090b4a4400b001b9b20eabc4sm7078816pjb.5.2022.03.10.08.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 08:51:56 -0800 (PST)
Date:   Thu, 10 Mar 2022 08:51:56 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, Adam Langley <agl@google.com>,
        linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH v2 1/1] sign-file: Do not attempt to use the ENGINE_* API
 if it's not available
Message-ID: <202203100851.C00D9AB73@keescook>
References: <20211005161833.1522737-1-lee.jones@linaro.org>
 <Yicwb+Ceiu8JjVIS@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yicwb+Ceiu8JjVIS@google.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 10:31:11AM +0000, Lee Jones wrote:
> OpenSSL's ENGINE API is deprecated in OpenSSL v3.0.
>
> Use OPENSSL_NO_ENGINE to ensure the ENGINE API is only used if it is
> present.  This will safeguard against compile errors when using SSL
> implementations which lack support for this deprecated API.

On Fedora rawhide, I'm still seeing a bunch of warnings:

scripts/sign-file.c: In function 'display_openssl_errors':
scripts/sign-file.c:89:9: warning: 'ERR_get_error_line' is deprecated: Since OpenSSL 3.0 [-Wdeprecat
ed-declarations]
   89 |         while ((e = ERR_get_error_line(&file, &line))) {
      |         ^~~~~
In file included from scripts/sign-file.c:29:
/usr/include/openssl/err.h:411:15: note: declared here
  411 | unsigned long ERR_get_error_line(const char **file, int *line);
      |               ^~~~~~~~~~~~~~~~~~
scripts/sign-file.c: In function 'drain_openssl_errors':
scripts/sign-file.c:102:9: warning: 'ERR_get_error_line' is deprecated: Since OpenSSL 3.0 [-Wdepreca
ted-declarations]
  102 |         while (ERR_get_error_line(&file, &line)) {}
      |         ^~~~~
/usr/include/openssl/err.h:411:15: note: declared here
  411 | unsigned long ERR_get_error_line(const char **file, int *line);
      |               ^~~~~~~~~~~~~~~~~~
...


>
> Cc: David Howells <dhowells@redhat.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Eric Biggers <ebiggers@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: keyrings@vger.kernel.org
> Co-developed-by: Adam Langley <agl@google.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
> v2: Clear up subject and patch description to avoid confusion
>
> scripts/sign-file.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/scripts/sign-file.c b/scripts/sign-file.c
> index fbd34b8e8f578..fa3fa59db6669 100644
> --- a/scripts/sign-file.c
> +++ b/scripts/sign-file.c
> @@ -135,7 +135,9 @@ static int pem_pw_cb(char *buf, int len, int w, void *v)
>  static EVP_PKEY *read_private_key(const char *private_key_name)
>  {
>  	EVP_PKEY *private_key;
> +	BIO *b;
>
> +#ifndef OPENSSL_NO_ENGINE
>  	if (!strncmp(private_key_name, "pkcs11:", 7)) {
>  		ENGINE *e;
>
> @@ -153,17 +155,16 @@ static EVP_PKEY *read_private_key(const char *private_key_name)
>  		private_key = ENGINE_load_private_key(e, private_key_name,
>  						      NULL, NULL);
>  		ERR(!private_key, "%s", private_key_name);
> -	} else {
> -		BIO *b;
> -
> -		b = BIO_new_file(private_key_name, "rb");
> -		ERR(!b, "%s", private_key_name);
> -		private_key = PEM_read_bio_PrivateKey(b, NULL, pem_pw_cb,
> -						      NULL);
> -		ERR(!private_key, "%s", private_key_name);
> -		BIO_free(b);
> +		return private_key;
>  	}
> +#endif
>
> +	b = BIO_new_file(private_key_name, "rb");
> +	ERR(!b, "%s", private_key_name);
> +	private_key = PEM_read_bio_PrivateKey(b, NULL, pem_pw_cb,
> +					      NULL);
> +	ERR(!private_key, "%s", private_key_name);
> +	BIO_free(b);
>  	return private_key;
>  }

--
Kees Cook
