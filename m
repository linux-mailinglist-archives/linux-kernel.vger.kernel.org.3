Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAB1504AD4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 04:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235797AbiDRCNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 22:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbiDRCNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 22:13:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7AF2E186C2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 19:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650247872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZKaQFNHJPrlVC1wRNehHPLwYyKFIA2KNeeEMoRic3Y0=;
        b=Xlj2GzU7CjOVPUI7cPOSeF8zoCCkUWenn3n0YUitfs+Z9hRIjBQB/WU+IIDboYm+dDd3WL
        xEICbVjdbnFqb4ImlEcMqoN7q7vUWp5fSw0XkVeBP82f+J4Et0KxS+dJH2R8jR546+r3m4
        8PWWVf9mnXI2pLd4qLupBAahUIbnJrg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-303-WDnMna3fO8-lP_vzT6cKaw-1; Sun, 17 Apr 2022 22:11:08 -0400
X-MC-Unique: WDnMna3fO8-lP_vzT6cKaw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6B96929AB3F1;
        Mon, 18 Apr 2022 02:11:07 +0000 (UTC)
Received: from localhost (ovpn-12-21.pek2.redhat.com [10.72.12.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2FB7DC28105;
        Mon, 18 Apr 2022 02:11:06 +0000 (UTC)
Date:   Mon, 18 Apr 2022 10:11:02 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Coiby Xu <coxu@redhat.com>
Cc:     kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        Michal Suchanek <msuchanek@suse.de>,
        Dave Young <dyoung@redhat.com>, Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Mimi Zohar <zohar@linux.ibm.com>, Chun-Yi Lee <jlee@suse.com>,
        Philipp Rudo <prudo@linux.ibm.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, stable@kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        "open list:S390" <linux-s390@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 4/4] kexec, KEYS, s390: Make use of built-in and
 secondary keyring for signature verification
Message-ID: <YlzItpGMPat1BFPq@MiWiFi-R3L-srv>
References: <20220414014344.228523-1-coxu@redhat.com>
 <20220414014344.228523-5-coxu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414014344.228523-5-coxu@redhat.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/14/22 at 09:43am, Coiby Xu wrote:
> From: Michal Suchanek <msuchanek@suse.de>
> 
> commit e23a8020ce4e ("s390/kexec_file: Signature verification prototype")
> adds support for KEXEC_SIG verification with keys from platform keyring
> but the built-in keys and secondary keyring are not used.
> 
> Add support for the built-in keys and secondary keyring as x86 does.
> 
> Fixes: e23a8020ce4e ("s390/kexec_file: Signature verification prototype")

Should Cc stable kernel?

Otherwise, LGTM,

Acked-by: Baoquan He <bhe@redhat.com>

> Cc: Philipp Rudo <prudo@linux.ibm.com>
> Cc: kexec@lists.infradead.org
> Cc: keyrings@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> Cc: stable@kernel.org
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
>  arch/s390/kernel/machine_kexec_file.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
> index 8f43575a4dd3..fc6d5f58debe 100644
> --- a/arch/s390/kernel/machine_kexec_file.c
> +++ b/arch/s390/kernel/machine_kexec_file.c
> @@ -31,6 +31,7 @@ int s390_verify_sig(const char *kernel, unsigned long kernel_len)
>  	const unsigned long marker_len = sizeof(MODULE_SIG_STRING) - 1;
>  	struct module_signature *ms;
>  	unsigned long sig_len;
> +	int ret;
>  
>  	/* Skip signature verification when not secure IPLed. */
>  	if (!ipl_secure_flag)
> @@ -65,11 +66,18 @@ int s390_verify_sig(const char *kernel, unsigned long kernel_len)
>  		return -EBADMSG;
>  	}
>  
> -	return verify_pkcs7_signature(kernel, kernel_len,
> -				      kernel + kernel_len, sig_len,
> -				      VERIFY_USE_PLATFORM_KEYRING,
> -				      VERIFYING_MODULE_SIGNATURE,
> -				      NULL, NULL);
> +	ret = verify_pkcs7_signature(kernel, kernel_len,
> +				     kernel + kernel_len, sig_len,
> +				     VERIFY_USE_SECONDARY_KEYRING,
> +				     VERIFYING_MODULE_SIGNATURE,
> +				     NULL, NULL);
> +	if (ret == -ENOKEY && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING))
> +		ret = verify_pkcs7_signature(kernel, kernel_len,
> +					     kernel + kernel_len, sig_len,
> +					     VERIFY_USE_PLATFORM_KEYRING,
> +					     VERIFYING_MODULE_SIGNATURE,
> +					     NULL, NULL);
> +	return ret;
>  }
>  #endif /* CONFIG_KEXEC_SIG */
>  
> -- 
> 2.34.1
> 
> 

