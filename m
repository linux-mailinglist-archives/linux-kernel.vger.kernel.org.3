Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123C95004BE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 05:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239732AbiDNDrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 23:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239721AbiDNDrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 23:47:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DFAE51837C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 20:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649907874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F/7nsyfN7H5ACQ+zSWR0K+E/gZY5zUURltEbwSfGD8k=;
        b=F0F7dfoGJXS+uKhNjKkqz1ggcmunKyIXLwPPGYl4F06UW/32dBY1WgqIUhulRatZ+dWV1j
        j7KxYvwx80GjWuE2JW7Znf9GE7Sm/ySxkaZix3tzzVE3cNMoHJUJo/HV7hMCdNcB6uufEU
        Mg9ZdKV4ddtAyyPMZ7zaEbJbhNlE1bE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-465--xuNO6O9NkSDKaMnxP_J_w-1; Wed, 13 Apr 2022 23:44:30 -0400
X-MC-Unique: -xuNO6O9NkSDKaMnxP_J_w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 54F3F80005D;
        Thu, 14 Apr 2022 03:44:30 +0000 (UTC)
Received: from localhost (ovpn-13-186.pek2.redhat.com [10.72.13.186])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9556E57E688;
        Thu, 14 Apr 2022 03:44:29 +0000 (UTC)
Date:   Thu, 14 Apr 2022 11:44:25 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Coiby Xu <coxu@redhat.com>
Cc:     kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        Michal Suchanek <msuchanek@suse.de>,
        Dave Young <dyoung@redhat.com>, Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Mimi Zohar <zohar@linux.ibm.com>, Chun-Yi Lee <jlee@suse.com>,
        stable@kernel.org, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 1/4] kexec: clean up arch_kexec_kernel_verify_sig
Message-ID: <YleYmZAAnF5aOan3@MiWiFi-R3L-srv>
References: <20220414014344.228523-1-coxu@redhat.com>
 <20220414014344.228523-2-coxu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414014344.228523-2-coxu@redhat.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/14/22 at 09:43am, Coiby Xu wrote:
> Currently there is no arch-specific implementation of
> arch_kexec_kernel_verify_sig. Even if we want to add an implementation
> for an architecture in the future, we can simply use "(struct
> kexec_file_ops*)->verify_sig". So clean it up.
> 
> Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
> Cc: stable@kernel.org

It should be not worth noticing stable kernel that a clean up patch need
be back ported.

Otherwise this looks good to me,

Acked-by: Baoquan He <bhe@redhat.com>

> Reviewed-by: Michal Suchanek <msuchanek@suse.de>
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
>  include/linux/kexec.h |  4 ----
>  kernel/kexec_file.c   | 34 +++++++++++++---------------------
>  2 files changed, 13 insertions(+), 25 deletions(-)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 58d1b58a971e..413235c6c797 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -202,10 +202,6 @@ int arch_kexec_apply_relocations(struct purgatory_info *pi,
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

