Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F18564C5C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 06:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbiGDEKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 00:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbiGDEKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 00:10:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DAB8FE70
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 21:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656907810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h/0n1xOQTRIgIgYXZqhUj+TjOAOlOYVv8CHk8AaHFQ8=;
        b=FV+ipU0snw9PcGTT+eq7WizjEWZnaA8Npg6TZ62dDFty/XHRDTX+GF5TPZx/eXcRBkK93h
        OGL7hFSoLd32WBFh1H8uvNf/a5pqVkV11GnmBQ/TrwBz/Q+UzL8z7OeJs1rO2Js9I4GJe7
        BAVMWrOD128OTgc98/qeuKV/hFBYbKU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-AOVq9mvUMfiybYxGbi8RjQ-1; Mon, 04 Jul 2022 00:10:06 -0400
X-MC-Unique: AOVq9mvUMfiybYxGbi8RjQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EA548101A588;
        Mon,  4 Jul 2022 04:10:05 +0000 (UTC)
Received: from localhost (ovpn-13-121.pek2.redhat.com [10.72.13.121])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AC62218EA8;
        Mon,  4 Jul 2022 04:10:04 +0000 (UTC)
Date:   Mon, 4 Jul 2022 12:10:00 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, coxu@redhat.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH 1/2] kexec_file: Drop weak attribute from functions
Message-ID: <YsJoGKribMH77HBQ@MiWiFi-R3L-srv>
References: <cover.1656659357.git.naveen.n.rao@linux.vnet.ibm.com>
 <2cd7ca1fe4d6bb6ca38e3283c717878388ed6788.1656659357.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cd7ca1fe4d6bb6ca38e3283c717878388ed6788.1656659357.git.naveen.n.rao@linux.vnet.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/22 at 01:04pm, Naveen N. Rao wrote:
> Drop __weak attribute from functions in kexec_file.c:
> - arch_kexec_kernel_image_probe()
> - arch_kimage_file_post_load_cleanup()
> - arch_kexec_kernel_image_load()
> - arch_kexec_locate_mem_hole()
> - arch_kexec_kernel_verify_sig()
> 
> arch_kexec_kernel_image_load() calls into kexec_image_load_default(), so
> drop the static attribute for the latter.
> 
> arch_kexec_kernel_verify_sig() is not overridden by any architecture, so
> drop the __weak attribute.

The dropping of arch_kexec_kernel_verify_sig() conflicts with patch 1 of
anotherpatchset, and the other patches in the patchset depends on the
patch 1.

[PATCH v9 0/4] unify the keyrings of arm64 and s390 with x86 to verify kexec'ed kernel signature

Hi, Naveen, Coiby, 

Please negotiate how to solve the conflict.

Thanks
Baoquan

> 
> Suggested-by: Eric Biederman <ebiederm@xmission.com>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  arch/arm64/include/asm/kexec.h   |  4 ++-
>  arch/powerpc/include/asm/kexec.h |  9 +++++++
>  arch/s390/include/asm/kexec.h    |  3 +++
>  arch/x86/include/asm/kexec.h     |  6 +++++
>  include/linux/kexec.h            | 44 +++++++++++++++++++++++++++-----
>  kernel/kexec_file.c              | 35 ++-----------------------
>  6 files changed, 61 insertions(+), 40 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
> index 9839bfc163d714..78d272b26ebd11 100644
> --- a/arch/arm64/include/asm/kexec.h
> +++ b/arch/arm64/include/asm/kexec.h
> @@ -115,7 +115,9 @@ extern const struct kexec_file_ops kexec_image_ops;
>  
>  struct kimage;
>  
> -extern int arch_kimage_file_post_load_cleanup(struct kimage *image);
> +int arch_kimage_file_post_load_cleanup(struct kimage *image);
> +#define arch_kimage_file_post_load_cleanup arch_kimage_file_post_load_cleanup
> +
>  extern int load_other_segments(struct kimage *image,
>  		unsigned long kernel_load_addr, unsigned long kernel_size,
>  		char *initrd, unsigned long initrd_len,
> diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
> index 2aefe14e144229..1e5e9b6ec78d9d 100644
> --- a/arch/powerpc/include/asm/kexec.h
> +++ b/arch/powerpc/include/asm/kexec.h
> @@ -120,6 +120,15 @@ int setup_purgatory(struct kimage *image, const void *slave_code,
>  #ifdef CONFIG_PPC64
>  struct kexec_buf;
>  
> +int arch_kexec_kernel_image_probe(struct kimage *image, void *buf, unsigned long buf_len);
> +#define arch_kexec_kernel_image_probe arch_kexec_kernel_image_probe
> +
> +int arch_kimage_file_post_load_cleanup(struct kimage *image);
> +#define arch_kimage_file_post_load_cleanup arch_kimage_file_post_load_cleanup
> +
> +int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf);
> +#define arch_kexec_locate_mem_hole arch_kexec_locate_mem_hole
> +
>  int load_crashdump_segments_ppc64(struct kimage *image,
>  				  struct kexec_buf *kbuf);
>  int setup_purgatory_ppc64(struct kimage *image, const void *slave_code,
> diff --git a/arch/s390/include/asm/kexec.h b/arch/s390/include/asm/kexec.h
> index 649ecdcc873453..8886aadc11a3a6 100644
> --- a/arch/s390/include/asm/kexec.h
> +++ b/arch/s390/include/asm/kexec.h
> @@ -92,5 +92,8 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
>  				     const Elf_Shdr *relsec,
>  				     const Elf_Shdr *symtab);
>  #define arch_kexec_apply_relocations_add arch_kexec_apply_relocations_add
> +
> +int arch_kimage_file_post_load_cleanup(struct kimage *image);
> +#define arch_kimage_file_post_load_cleanup arch_kimage_file_post_load_cleanup
>  #endif
>  #endif /*_S390_KEXEC_H */
> diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
> index 6ad8d946cd3ebf..5ec359c1b50cb3 100644
> --- a/arch/x86/include/asm/kexec.h
> +++ b/arch/x86/include/asm/kexec.h
> @@ -193,6 +193,12 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
>  				     const Elf_Shdr *relsec,
>  				     const Elf_Shdr *symtab);
>  #define arch_kexec_apply_relocations_add arch_kexec_apply_relocations_add
> +
> +void *arch_kexec_kernel_image_load(struct kimage *image);
> +#define arch_kexec_kernel_image_load arch_kexec_kernel_image_load
> +
> +int arch_kimage_file_post_load_cleanup(struct kimage *image);
> +#define arch_kimage_file_post_load_cleanup arch_kimage_file_post_load_cleanup
>  #endif
>  #endif
>  
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index ce6536f1d26997..5e0bc3f9eac3e9 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -188,21 +188,53 @@ int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
>  				   void *buf, unsigned int size,
>  				   bool get_value);
>  void *kexec_purgatory_get_symbol_addr(struct kimage *image, const char *name);
> +void *kexec_image_load_default(struct kimage *image);
> +
> +#ifndef arch_kexec_kernel_image_probe
> +static inline int
> +arch_kexec_kernel_image_probe(struct kimage *image, void *buf, unsigned long buf_len)
> +{
> +	return kexec_image_probe_default(image, buf, buf_len);
> +}
> +#endif
> +
> +#ifndef arch_kimage_file_post_load_cleanup
> +static inline int arch_kimage_file_post_load_cleanup(struct kimage *image)
> +{
> +	return kexec_image_post_load_cleanup_default(image);
> +}
> +#endif
> +
> +#ifndef arch_kexec_kernel_image_load
> +static inline void *arch_kexec_kernel_image_load(struct kimage *image)
> +{
> +	return kexec_image_load_default(image);
> +}
> +#endif
>  
> -/* Architectures may override the below functions */
> -int arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
> -				  unsigned long buf_len);
> -void *arch_kexec_kernel_image_load(struct kimage *image);
> -int arch_kimage_file_post_load_cleanup(struct kimage *image);
>  #ifdef CONFIG_KEXEC_SIG
>  int arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
>  				 unsigned long buf_len);
>  #endif
> -int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf);
>  
>  extern int kexec_add_buffer(struct kexec_buf *kbuf);
>  int kexec_locate_mem_hole(struct kexec_buf *kbuf);
>  
> +#ifndef arch_kexec_locate_mem_hole
> +/**
> + * arch_kexec_locate_mem_hole - Find free memory to place the segments.
> + * @kbuf:                       Parameters for the memory search.
> + *
> + * On success, kbuf->mem will have the start address of the memory region found.
> + *
> + * Return: 0 on success, negative errno on error.
> + */
> +static inline int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf)
> +{
> +	return kexec_locate_mem_hole(kbuf);
> +}
> +#endif
> +
>  /* Alignment required for elf header segment */
>  #define ELF_CORE_HEADER_ALIGN   4096
>  
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 9b2839775c837b..66e4ce29fc6961 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -56,14 +56,7 @@ int kexec_image_probe_default(struct kimage *image, void *buf,
>  	return ret;
>  }
>  
> -/* Architectures can provide this probe function */
> -int __weak arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
> -					 unsigned long buf_len)
> -{
> -	return kexec_image_probe_default(image, buf, buf_len);
> -}
> -
> -static void *kexec_image_load_default(struct kimage *image)
> +void *kexec_image_load_default(struct kimage *image)
>  {
>  	if (!image->fops || !image->fops->load)
>  		return ERR_PTR(-ENOEXEC);
> @@ -74,11 +67,6 @@ static void *kexec_image_load_default(struct kimage *image)
>  				 image->cmdline_buf_len);
>  }
>  
> -void * __weak arch_kexec_kernel_image_load(struct kimage *image)
> -{
> -	return kexec_image_load_default(image);
> -}
> -
>  int kexec_image_post_load_cleanup_default(struct kimage *image)
>  {
>  	if (!image->fops || !image->fops->cleanup)
> @@ -87,11 +75,6 @@ int kexec_image_post_load_cleanup_default(struct kimage *image)
>  	return image->fops->cleanup(image->image_loader_data);
>  }
>  
> -int __weak arch_kimage_file_post_load_cleanup(struct kimage *image)
> -{
> -	return kexec_image_post_load_cleanup_default(image);
> -}
> -
>  #ifdef CONFIG_KEXEC_SIG
>  static int kexec_image_verify_sig_default(struct kimage *image, void *buf,
>  					  unsigned long buf_len)
> @@ -104,8 +87,7 @@ static int kexec_image_verify_sig_default(struct kimage *image, void *buf,
>  	return image->fops->verify_sig(buf, buf_len);
>  }
>  
> -int __weak arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
> -					unsigned long buf_len)
> +int arch_kexec_kernel_verify_sig(struct kimage *image, void *buf, unsigned long buf_len)
>  {
>  	return kexec_image_verify_sig_default(image, buf, buf_len);
>  }
> @@ -616,19 +598,6 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
>  	return ret == 1 ? 0 : -EADDRNOTAVAIL;
>  }
>  
> -/**
> - * arch_kexec_locate_mem_hole - Find free memory to place the segments.
> - * @kbuf:                       Parameters for the memory search.
> - *
> - * On success, kbuf->mem will have the start address of the memory region found.
> - *
> - * Return: 0 on success, negative errno on error.
> - */
> -int __weak arch_kexec_locate_mem_hole(struct kexec_buf *kbuf)
> -{
> -	return kexec_locate_mem_hole(kbuf);
> -}
> -
>  /**
>   * kexec_add_buffer - place a buffer in a kexec segment
>   * @kbuf:	Buffer contents and memory parameters.
> -- 
> 2.36.1
> 

