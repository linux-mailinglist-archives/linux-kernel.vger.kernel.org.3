Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263854DC5FE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 13:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbiCQMrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 08:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbiCQMq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 08:46:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A6DEF111DD8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 05:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647521141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VBBuRe1MzVMSa5tl85JWrPgpG0AsZAv8LA7ACqhOxW8=;
        b=B+pNlGsP7v0mhHNFSFf/RREGIVItS2orlAbxgwC/BqLW0Nb12oK3Xi/cM6WR09HFAHx8Ea
        EijWoEQ95KxhbBb+KDotOlWalAzBM4IxOdp1SxSAqgfpY8Lu2XdPZmzv4eIauBXqJPf/U0
        x3Eij+6bf0d+VOz1gj6N5/T5R0LL8yI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-LSns4lGNMQquxhPprBInwg-1; Thu, 17 Mar 2022 08:45:40 -0400
X-MC-Unique: LSns4lGNMQquxhPprBInwg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 11AD81C0150E;
        Thu, 17 Mar 2022 12:45:40 +0000 (UTC)
Received: from localhost (ovpn-13-216.pek2.redhat.com [10.72.13.216])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4AB72C15D57;
        Thu, 17 Mar 2022 12:45:38 +0000 (UTC)
Date:   Thu, 17 Mar 2022 20:45:35 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Coiby Xu <coiby.xu@gmail.com>
Cc:     kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        Dave Young <dyoung@redhat.com>, Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Coiby Xu <coxu@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH v3 1/3] kexec: clean up
 arch_kexec_kernel_verify_sig
Message-ID: <YjMtb7u3/sAWG0/7@MiWiFi-R3L-srv>
References: <20220304020341.85583-1-coiby.xu@gmail.com>
 <20220304020341.85583-2-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304020341.85583-2-coiby.xu@gmail.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/22 at 10:03am, Coiby Xu wrote:
> From: Coiby Xu <coxu@redhat.com>
> 
> commit 9ec4ecef0af7790551109283ca039a7c52de343c ("kexec_file,x86,
> powerpc: factor out kexec_file_ops functions" allows implementing
> the arch-specific implementation of kernel image verification
> in kexec_file_ops->verify_sig. Currently, there is no arch-specific
> implementation of arch_kexec_kernel_verify_sig. So clean it up.

This is a nice cleanup, while the log may need to be improved. You
should run ./scripts/checkpatch.pl on your patch before sending out.
When we refer to a commit in log, please refer to
Documentation/process/submitting-patches.rst.

> 
> Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
> ---
>  include/linux/kexec.h |  4 ----
>  kernel/kexec_file.c   | 34 +++++++++++++---------------------
>  2 files changed, 13 insertions(+), 25 deletions(-)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 0c994ae37729..755fed183224 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -196,10 +196,6 @@ int arch_kexec_apply_relocations(struct purgatory_info *pi,
>  				 const Elf_Shdr *relsec,
>  				 const Elf_Shdr *symtab);
>  int arch_kimage_file_post_load_cleanup(struct kimage *image);
> -#ifdef CONFIG_KEXEC_SIG
> -int arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
> -				 unsigned long buf_len);
> -#endif
>  int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf);
>  
>  extern int kexec_add_buffer(struct kexec_buf *kbuf);
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 8347fc158d2b..3720435807eb 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -89,25 +89,6 @@ int __weak arch_kimage_file_post_load_cleanup(struct kimage *image)
>  	return kexec_image_post_load_cleanup_default(image);
>  }
>  
> -#ifdef CONFIG_KEXEC_SIG
> -static int kexec_image_verify_sig_default(struct kimage *image, void *buf,
> -					  unsigned long buf_len)
> -{
> -	if (!image->fops || !image->fops->verify_sig) {
> -		pr_debug("kernel loader does not support signature verification.\n");
> -		return -EKEYREJECTED;
> -	}
> -
> -	return image->fops->verify_sig(buf, buf_len);
> -}
> -
> -int __weak arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
> -					unsigned long buf_len)
> -{
> -	return kexec_image_verify_sig_default(image, buf, buf_len);
> -}
> -#endif
> -
>  /*
>   * arch_kexec_apply_relocations_add - apply relocations of type RELA
>   * @pi:		Purgatory to be relocated.
> @@ -184,13 +165,24 @@ void kimage_file_post_load_cleanup(struct kimage *image)
>  }
>  
>  #ifdef CONFIG_KEXEC_SIG
> +static int kexec_image_verify_sig(struct kimage *image, void *buf,
> +		unsigned long buf_len)
> +{
> +	if (!image->fops || !image->fops->verify_sig) {
> +		pr_debug("kernel loader does not support signature verification.\n");
> +		return -EKEYREJECTED;
> +	}
> +
> +	return image->fops->verify_sig(buf, buf_len);
> +}
> +
>  static int
>  kimage_validate_signature(struct kimage *image)
>  {
>  	int ret;
>  
> -	ret = arch_kexec_kernel_verify_sig(image, image->kernel_buf,
> -					   image->kernel_buf_len);
> +	ret = kexec_image_verify_sig(image, image->kernel_buf,
> +			image->kernel_buf_len);
>  	if (ret) {
>  
>  		if (IS_ENABLED(CONFIG_KEXEC_SIG_FORCE)) {
> -- 
> 2.34.1
> 

