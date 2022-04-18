Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73810504ADA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 04:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235807AbiDRCRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 22:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235800AbiDRCRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 22:17:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B97DE186C7
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 19:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650248080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CjUVOfmdq+w5waJLzW1hPEzdp8hwxycbwFM39B4Hvjg=;
        b=gHsBgQm14vrCnZ+uf1M1S3oyeekYG4Cw4K5sd3FTgOrGP7+rxdkARquepDLBXk1RtmTBRt
        sPEQ3wmbtY2ZUD8sXs+wu0Mm/0RsKFBc+G37ztm8B4fcQmTK3eNdn3axU8CPbIdjpMsIgR
        1+H0ypOOwk1GV0p/vZCt14VF32ok7CY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-248-ajl70rPPO7a1dQbxSqxrVg-1; Sun, 17 Apr 2022 22:14:37 -0400
X-MC-Unique: ajl70rPPO7a1dQbxSqxrVg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6A5B8811E76;
        Mon, 18 Apr 2022 02:14:36 +0000 (UTC)
Received: from localhost (ovpn-12-21.pek2.redhat.com [10.72.12.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 933871454547;
        Mon, 18 Apr 2022 02:14:35 +0000 (UTC)
Date:   Mon, 18 Apr 2022 10:14:31 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Coiby Xu <coxu@redhat.com>
Cc:     kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        Michal Suchanek <msuchanek@suse.de>,
        Dave Young <dyoung@redhat.com>, Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Mimi Zohar <zohar@linux.ibm.com>, Chun-Yi Lee <jlee@suse.com>,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        stable@kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 3/4] arm64: kexec_file: use more system keyrings to
 verify kernel image signature
Message-ID: <YlzJh8SE8pV1Et+O@MiWiFi-R3L-srv>
References: <20220414014344.228523-1-coxu@redhat.com>
 <20220414014344.228523-4-coxu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414014344.228523-4-coxu@redhat.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/14/22 at 09:43am, Coiby Xu wrote:
> Currently, a problem faced by arm64 is if a kernel image is signed by a
> MOK key, loading it via the kexec_file_load() system call would be
> rejected with the error "Lockdown: kexec: kexec of unsigned images is
> restricted; see man kernel_lockdown.7".
> 
> This happens because image_verify_sig uses only the primary keyring that
> contains only kernel built-in keys to verify the kexec image.
> 
> This patch allows to verify arm64 kernel image signature using not only
> .builtin_trusted_keys but also .platform and .secondary_trusted_keys
> keyring.
> 
> Fixes: 732b7b93d849 ("arm64: kexec_file: add kernel signature verification support")

Cc stable?

Otherwise, LGTM,

Acked-by: Baoquan He <bhe@redhat.com>

> Cc: kexec@lists.infradead.org
> Cc: keyrings@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> Cc: stable@kernel.org
> Co-developed-by: Michal Suchanek <msuchanek@suse.de>
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> Acked-by: Will Deacon <will@kernel.org>
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
>  arch/arm64/kernel/kexec_image.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
> index 9ec34690e255..5ed6a585f21f 100644
> --- a/arch/arm64/kernel/kexec_image.c
> +++ b/arch/arm64/kernel/kexec_image.c
> @@ -14,7 +14,6 @@
>  #include <linux/kexec.h>
>  #include <linux/pe.h>
>  #include <linux/string.h>
> -#include <linux/verification.h>
>  #include <asm/byteorder.h>
>  #include <asm/cpufeature.h>
>  #include <asm/image.h>
> @@ -130,18 +129,10 @@ static void *image_load(struct kimage *image,
>  	return NULL;
>  }
>  
> -#ifdef CONFIG_KEXEC_IMAGE_VERIFY_SIG
> -static int image_verify_sig(const char *kernel, unsigned long kernel_len)
> -{
> -	return verify_pefile_signature(kernel, kernel_len, NULL,
> -				       VERIFYING_KEXEC_PE_SIGNATURE);
> -}
> -#endif
> -
>  const struct kexec_file_ops kexec_image_ops = {
>  	.probe = image_probe,
>  	.load = image_load,
>  #ifdef CONFIG_KEXEC_IMAGE_VERIFY_SIG
> -	.verify_sig = image_verify_sig,
> +	.verify_sig = kexec_kernel_verify_pe_sig,
>  #endif
>  };
> -- 
> 2.34.1
> 
> 

