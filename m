Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2464FB6D5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344095AbiDKJDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344111AbiDKJD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:03:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9636F3EF19
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 02:01:14 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2F4B3212C6;
        Mon, 11 Apr 2022 09:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649667673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ef++WggLHlX1bHpZMjXUg51/FpXHmXDjFyOrv5jvrlE=;
        b=KD6/xdCJHkao4n2yDEBXJ7kFf8L7VaQacrPjDU5LgP3+K0xuZcXEhJ1WrdhIM2mf4nSKVE
        3Jr0LVdH6iwhSxqAZq53VB94dPefFaWcRUFb9TPndaAXwZtZTpvYz9MhfyWFyi5nXWGxgA
        lN67SOBCS/aI99M5d3oE7sBex7McA1U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649667673;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ef++WggLHlX1bHpZMjXUg51/FpXHmXDjFyOrv5jvrlE=;
        b=6pShjjnfG+hqFeZr+xcgMAKVB7lVl25uubcW+JeUzvhxkw/aDcZKvNdCjP47C0BcXkRuZL
        56AeWJlfTtYP3GBQ==
Received: from kunlun.suse.cz (unknown [10.100.128.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 077BAA3B95;
        Mon, 11 Apr 2022 09:01:13 +0000 (UTC)
Date:   Mon, 11 Apr 2022 11:01:11 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Coiby Xu <coxu@redhat.com>
Cc:     kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/3] kexec: clean up arch_kexec_kernel_verify_sig
Message-ID: <20220411090111.GB163591@kunlun.suse.cz>
References: <20220401013118.348084-1-coxu@redhat.com>
 <20220401013118.348084-2-coxu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401013118.348084-2-coxu@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022 at 09:31:16AM +0800, Coiby Xu wrote:
> Currently there is no arch-specific implementation of
> arch_kexec_kernel_verify_sig. Even if we want to add an implementation
> for an architecture in the future, we can simply use "(struct
> kexec_file_ops*)->verify_sig". So clean it up.
Reviewed-by: Michal Suchanek <msuchanek@suse.de>
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
