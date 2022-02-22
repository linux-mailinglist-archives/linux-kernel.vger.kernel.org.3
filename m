Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0DC4BF365
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 09:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiBVIUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 03:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiBVIU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 03:20:29 -0500
X-Greylist: delayed 444 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Feb 2022 00:20:03 PST
Received: from mail.avm.de (mail.avm.de [IPv6:2001:bf0:244:244::120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941CE154D35;
        Tue, 22 Feb 2022 00:20:03 -0800 (PST)
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
        by mail.avm.de (Postfix) with ESMTPS;
        Tue, 22 Feb 2022 09:12:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1645517554; bh=KEa0HEq9elkheo1S0XRmlXqPLxqZBVn71+sq+tx/6i8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DGmzZT9iqagkTOPUypiFfi15ZqAp9bYEBZij8jLMfhmg6tiiCU0BwZUCKQcki5DJN
         2iB6113ZsYrFj4in4EBwsS+xGQGdVInTbEsWMkh60rIhnDEUCLCLpG7S0bZ1/DJrd5
         If32mPKQGoK17+Q8sQ5AKIFVX2VBqH1s8NJUW05Y=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
        by mail-auth.avm.de (Postfix) with ESMTPSA id 99984804A2;
        Tue, 22 Feb 2022 09:12:34 +0100 (CET)
Date:   Tue, 22 Feb 2022 09:12:33 +0100
From:   Nicolas Schier <n.schier@avm.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] certs: simplify empty certs creation in
 certs/Makefile
Message-ID: <YhSa8bOW7sOd1cp0@buildd.core.avm.de>
References: <20220218044634.169520-1-masahiroy@kernel.org>
 <20220218044634.169520-2-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220218044634.169520-2-masahiroy@kernel.org>
X-purgate-ID: 149429::1645517554-00000620-B1D4181E/0/0
X-purgate-type: clean
X-purgate-size: 2668
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 01:46:34PM +0900, Masahiro Yamada wrote:
> To create an empty cert file, we need to pass "" to the extract-cert
> tool, which is common for all the three call-sites of cmd_exract_certs.

Missing a 't' in 'cmd_exract_certs'.

Reviewed-by: Nicolas Schier <n.schier@avm.de>

> 
> Factor out the logic into extract-cert-in.
> 
> One exceptional case is PKCS#11 case, where we override extract-cert-in
> with the URI.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  certs/Makefile | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/certs/Makefile b/certs/Makefile
> index 68c1d7b9a388..d8443cfb1c40 100644
> --- a/certs/Makefile
> +++ b/certs/Makefile
> @@ -13,12 +13,13 @@ obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist_nohashes.o
>  endif
>  
>  quiet_cmd_extract_certs  = CERT    $@
> -      cmd_extract_certs  = $(obj)/extract-cert $(2) $@
> +      cmd_extract_certs  = $(obj)/extract-cert $(extract-cert-in) $@
> +extract-cert-in = $(or $(filter-out $(obj)/extract-cert, $(real-prereqs)),"")
>  
>  $(obj)/system_certificates.o: $(obj)/x509_certificate_list
>  
>  $(obj)/x509_certificate_list: $(CONFIG_SYSTEM_TRUSTED_KEYS) $(obj)/extract-cert FORCE
> -	$(call if_changed,extract_certs,$(if $(CONFIG_SYSTEM_TRUSTED_KEYS),$<,""))
> +	$(call if_changed,extract_certs)
>  
>  targets += x509_certificate_list
>  
> @@ -52,22 +53,22 @@ $(obj)/x509.genkey:
>  
>  endif # CONFIG_MODULE_SIG_KEY
>  
> -# If CONFIG_MODULE_SIG_KEY isn't a PKCS#11 URI, depend on it
> -ifneq ($(filter-out pkcs11:%, $(CONFIG_MODULE_SIG_KEY)),)
> -X509_DEP := $(CONFIG_MODULE_SIG_KEY)
> -endif
> -
>  $(obj)/system_certificates.o: $(obj)/signing_key.x509
>  
> -$(obj)/signing_key.x509: $(X509_DEP) $(obj)/extract-cert FORCE
> -	$(call if_changed,extract_certs,$(if $(CONFIG_MODULE_SIG_KEY),$(if $(X509_DEP),$<,$(CONFIG_MODULE_SIG_KEY)),""))
> +PKCS11_URI := $(filter pkcs11:%, $(CONFIG_MODULE_SIG_KEY))
> +ifdef PKCS11_URI
> +$(obj)/signing_key.x509: extract-cert-in := $(PKCS11_URI)
> +endif
> +
> +$(obj)/signing_key.x509: $(filter-out $(PKCS11_URI),$(CONFIG_MODULE_SIG_KEY)) $(obj)/extract-cert FORCE
> +	$(call if_changed,extract_certs)
>  
>  targets += signing_key.x509
>  
>  $(obj)/revocation_certificates.o: $(obj)/x509_revocation_list
>  
>  $(obj)/x509_revocation_list: $(CONFIG_SYSTEM_REVOCATION_KEYS) $(obj)/extract-cert FORCE
> -	$(call if_changed,extract_certs,$(if $(CONFIG_SYSTEM_REVOCATION_KEYS),$<,""))
> +	$(call if_changed,extract_certs)
>  
>  targets += x509_revocation_list
>  
> -- 
> 2.32.0
> 
