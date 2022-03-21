Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883514E1F7E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 05:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245145AbiCUEXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 00:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239857AbiCUEXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 00:23:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E01713D52
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 21:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647836504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QvyzeWrMLOcevBTswhqEkb8FAM3gEDuF897VWUnNA6w=;
        b=iQbPOfZ+VVEQG4wJZ9eFQ0puQCP3ucX8D3VzUk7Q3B6fAD/i1lW62aw3PRgrtyH0OTFhK7
        brXkbQqe4qNnNiV4ndOPDSKl2g/LjgJM5ZP7qha1gJUeTn0iI/k5MTTOq+hnLA15CNNyvp
        xqcdRX+49MOfaZN4xfzslILrGHueCFE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-6DaFMsC2NbKClrPooPyz2w-1; Mon, 21 Mar 2022 00:21:38 -0400
X-MC-Unique: 6DaFMsC2NbKClrPooPyz2w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C2A891066566;
        Mon, 21 Mar 2022 04:21:37 +0000 (UTC)
Received: from localhost (ovpn-12-54.pek2.redhat.com [10.72.12.54])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EBC06141DC29;
        Mon, 21 Mar 2022 04:21:36 +0000 (UTC)
Date:   Mon, 21 Mar 2022 12:21:33 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Coiby Xu <coxu@redhat.com>
Cc:     kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        Dave Young <dyoung@redhat.com>, Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] kexec: clean up arch_kexec_kernel_verify_sig
Message-ID: <Yjf9TbBo5ysjM7Nl@MiWiFi-R3L-srv>
References: <20220318094101.274950-1-coxu@redhat.com>
 <20220318094101.274950-2-coxu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318094101.274950-2-coxu@redhat.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/18/22 at 05:40pm, Coiby Xu wrote:
> Commit 9ec4ecef0af7 ("kexec_file,x86,powerpc: factor out kexec_file_ops
> functions") allows implementing the arch-specific implementation of kernel
> image verification in kexec_file_ops->verify_sig. Currently, there is no

Looking back at the old commit 9ec4ecef0af7, it mistakenly added a
generic arch_kexec_kernel_verify_sig() which is marked as __weak,
and expects any architecture will add a arch specified version if needed. 
In fact those arch specified difference has been removed by wrapping
them into each architecture's own struct kexec_file_ops methods. Means
in the commit, the generic arch_kexec_kernel_verify_sig() is unnecessary
at all.

Now, you clean up that uncessary function with code change.

I think description telling above analysis could be clearer. 

> arch-specific implementation of arch_kexec_kernel_verify_sig. So clean it
> up.
> 
> Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
> Signed-off-by: Coiby Xu <coxu@redhat.com>
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

