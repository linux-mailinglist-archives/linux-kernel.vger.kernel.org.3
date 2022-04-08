Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A6E4F8F43
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 09:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiDHHNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 03:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiDHHN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 03:13:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD35B209A72
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 00:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649401881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EIdT20lZyuxUif4lmdeJV2YtVVAT8aoGpkU+KSrIRGM=;
        b=aDxf4f0l4kagvWAtoOvj6R5Pwu21cI2UVD/PGyX6UPhfOAPcZ2vA7eyQocMK2fM6rhF6ph
        p5+ZgxJaKu2VdrayS+eYNbCl6GXvwlZfNuoGmxuLpigKII09PgcMe1PJfQJBI0ZoOzkQi8
        9UIxVwCgY0BpkMiGSidgzaOWK7K/5Y0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-571-3p8lm4GcNhaDsIB05JZDhg-1; Fri, 08 Apr 2022 03:11:18 -0400
X-MC-Unique: 3p8lm4GcNhaDsIB05JZDhg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 44251805F68;
        Fri,  8 Apr 2022 07:11:17 +0000 (UTC)
Received: from localhost (ovpn-12-202.pek2.redhat.com [10.72.12.202])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 00E57403179;
        Fri,  8 Apr 2022 07:11:16 +0000 (UTC)
Date:   Fri, 8 Apr 2022 15:11:08 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Michal Suchanek <msuchanek@suse.de>, Coiby Xu <coxu@redhat.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Philipp Rudo <prudo@redhat.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>,
        Dave Young <dyoung@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kexec@lists.infradead.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        stable@kernel.org
Subject: Re: [PATCH 1/4] Fix arm64 kexec forbidding kernels signed with keys
 in the secondary keyring to boot
Message-ID: <Yk/eFBCqBTu4eZf2@MiWiFi-R3L-srv>
References: <cover.1644953683.git.msuchanek@suse.de>
 <83b3583f35c50c609739a8d857d14e8410293373.1644953683.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83b3583f35c50c609739a8d857d14e8410293373.1644953683.git.msuchanek@suse.de>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 02/15/22 at 08:39pm, Michal Suchanek wrote:
> commit d3bfe84129f6 ("certs: Add a secondary system keyring that can be added to dynamically")
> split of .system_keyring into .builtin_trusted_keys and
> .secondary_trusted_keys broke kexec, thereby preventing kernels signed by
> keys which are now in the secondary keyring from being kexec'd.
> 
> Fix this by passing VERIFY_USE_SECONDARY_KEYRING to
> verify_pefile_signature().
> 
> Cherry-picked from
> commit ea93102f3224 ("Fix kexec forbidding kernels signed with keys in the secondary keyring to boot")

This line may need a line feed?

The patch 1~3 looks good to me. Coiby encountered the same issue
on arm64, and has posted a patch series to fix that and there's clean up
and code adjustment.

https://lore.kernel.org/all/20220401013118.348084-1-coxu@redhat.com/T/#u

Hi Coiby,

Maybe you can check this patchset, and consider how to integrate your
patches based on this patch 1~/3?

For this patch itself, ack.

Acked-by: Baoquan He <bhe@redhat.com>

> 
> Fixes: 732b7b93d849 ("arm64: kexec_file: add kernel signature verification support")
> Cc: kexec@lists.infradead.org
> Cc: keyrings@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> Cc: stable@kernel.org
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  arch/arm64/kernel/kexec_image.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
> index 9ec34690e255..1fbf2ee7c005 100644
> --- a/arch/arm64/kernel/kexec_image.c
> +++ b/arch/arm64/kernel/kexec_image.c
> @@ -133,7 +133,8 @@ static void *image_load(struct kimage *image,
>  #ifdef CONFIG_KEXEC_IMAGE_VERIFY_SIG
>  static int image_verify_sig(const char *kernel, unsigned long kernel_len)
>  {
> -	return verify_pefile_signature(kernel, kernel_len, NULL,
> +	return verify_pefile_signature(kernel, kernel_len,
> +				       VERIFY_USE_SECONDARY_KEYRING,
>  				       VERIFYING_KEXEC_PE_SIGNATURE);
>  }
>  #endif
> -- 
> 2.31.1
> 

