Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B914E3752
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 04:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235959AbiCVDPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 23:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235946AbiCVDO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 23:14:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F5E954BD5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 20:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647918810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vKHt9i7mfT3YgAWaqrPaWVsW7oiZVUiyVt+3RKfn+jc=;
        b=XpvENJUVde+DARY5lZB3wOm4Ooq7r3k9ZhbPpq0X774v2FK/3x1JQbyhmupRykPNTl9lkM
        4XKEAEkjhbDBfp4xGlN0NvjDb//vnczeJCrx0nGK21wuGanjK2/doW+HvxcO5bwrMdfGhw
        h3LEDGdcwe1g3bWUUlajDgUSyBwgiOs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-119-MnYR_Qr5OY6_s-dsCS-qjA-1; Mon, 21 Mar 2022 23:13:29 -0400
X-MC-Unique: MnYR_Qr5OY6_s-dsCS-qjA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A812E1C04B46;
        Tue, 22 Mar 2022 03:13:28 +0000 (UTC)
Received: from localhost (ovpn-13-156.pek2.redhat.com [10.72.13.156])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8419B2166B44;
        Tue, 22 Mar 2022 03:13:23 +0000 (UTC)
Date:   Tue, 22 Mar 2022 11:13:20 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Coiby Xu <coxu@redhat.com>
Cc:     kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        Dave Young <dyoung@redhat.com>, Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] kexec: clean up arch_kexec_kernel_verify_sig
Message-ID: <Yjk+0IiTXbTRC6LT@MiWiFi-R3L-srv>
References: <20220318094101.274950-1-coxu@redhat.com>
 <20220318094101.274950-2-coxu@redhat.com>
 <Yjf9TbBo5ysjM7Nl@MiWiFi-R3L-srv>
 <20220322025912.r2ahc2ztx3npt7av@Rk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322025912.r2ahc2ztx3npt7av@Rk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/22/22 at 10:59am, Coiby Xu wrote:
> On Mon, Mar 21, 2022 at 12:21:33PM +0800, Baoquan He wrote:
> > On 03/18/22 at 05:40pm, Coiby Xu wrote:
> > > Commit 9ec4ecef0af7 ("kexec_file,x86,powerpc: factor out kexec_file_ops
> > > functions") allows implementing the arch-specific implementation of kernel
> > > image verification in kexec_file_ops->verify_sig. Currently, there is no
> > 
> > Looking back at the old commit 9ec4ecef0af7, it mistakenly added a
> > generic arch_kexec_kernel_verify_sig() which is marked as __weak,
> > and expects any architecture will add a arch specified version if needed.
> > In fact those arch specified difference has been removed by wrapping
> > them into each architecture's own struct kexec_file_ops methods. Means
> > in the commit, the generic arch_kexec_kernel_verify_sig() is unnecessary
> > at all.
> 
> Thanks for looking at commit 9ec4ecef0af7 for me!
> 
> Although commit 9ec4ecef0af7 added some code in arch_kexec_kernel_verify_sig
> so kexec_file_ops->verify_sig can be called, this commit doesn't add __weak
> arch_kexec_kernel_verify_sig itself. And kexec_file_ops isn't supposed
> to replace arch-specific implementation using __weak considering s390 and x86
> still make use of __weak to implement its own version of
> arch_kexec_apply_relocations_add. How about the commit message as
> follows?

Yes, arch_kexec_apply_relocations_add has its different version on
arches. But arch_kexec_kernel_verify_sig() is different. There's a
specific method for that, ->verify_sig().

struct kexec_file_ops {
        kexec_probe_t *probe;         
        kexec_load_t *load;
        kexec_cleanup_t *cleanup;
#ifdef CONFIG_KEXEC_SIG
        kexec_verify_sig_t *verify_sig;
#endif
};

> 
>   Currently this no arch-specific implementation of
>   arch_kexec_kernel_verify_sig. Even if we want to add an implementation
>   for an architecture in the future, we can simply use "(struct
>   kexec_file_ops*)->verify_sig". So clean it up.

That is also fine. I think it's better to put the above in if we have
checked the old commit. Anyway, please take the sentences which comforts
you more. And there's grammer mistake, please use 'Currently there is
not' to replace.

> > 
> > Now, you clean up that uncessary function with code change.
> > 
> > I think description telling above analysis could be clearer.
> > 
> > > arch-specific implementation of arch_kexec_kernel_verify_sig. So clean it
> > > up.
> > > 
> > > Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
> > > Signed-off-by: Coiby Xu <coxu@redhat.com>
> > > ---
> > >  include/linux/kexec.h |  4 ----
> > >  kernel/kexec_file.c   | 34 +++++++++++++---------------------
> > >  2 files changed, 13 insertions(+), 25 deletions(-)
> > > 
> > > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> > > index 0c994ae37729..755fed183224 100644
> > > --- a/include/linux/kexec.h
> > > +++ b/include/linux/kexec.h
> > > @@ -196,10 +196,6 @@ int arch_kexec_apply_relocations(struct purgatory_info *pi,
> > >  				 const Elf_Shdr *relsec,
> > >  				 const Elf_Shdr *symtab);
> > >  int arch_kimage_file_post_load_cleanup(struct kimage *image);
> > > -#ifdef CONFIG_KEXEC_SIG
> > > -int arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
> > > -				 unsigned long buf_len);
> > > -#endif
> > >  int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf);
> > > 
> > >  extern int kexec_add_buffer(struct kexec_buf *kbuf);
> > > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > > index 8347fc158d2b..3720435807eb 100644
> > > --- a/kernel/kexec_file.c
> > > +++ b/kernel/kexec_file.c
> > > @@ -89,25 +89,6 @@ int __weak arch_kimage_file_post_load_cleanup(struct kimage *image)
> > >  	return kexec_image_post_load_cleanup_default(image);
> > >  }
> > > 
> > > -#ifdef CONFIG_KEXEC_SIG
> > > -static int kexec_image_verify_sig_default(struct kimage *image, void *buf,
> > > -					  unsigned long buf_len)
> > > -{
> > > -	if (!image->fops || !image->fops->verify_sig) {
> > > -		pr_debug("kernel loader does not support signature verification.\n");
> > > -		return -EKEYREJECTED;
> > > -	}
> > > -
> > > -	return image->fops->verify_sig(buf, buf_len);
> > > -}
> > > -
> > > -int __weak arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
> > > -					unsigned long buf_len)
> > > -{
> > > -	return kexec_image_verify_sig_default(image, buf, buf_len);
> > > -}
> > > -#endif
> > > -
> > >  /*
> > >   * arch_kexec_apply_relocations_add - apply relocations of type RELA
> > >   * @pi:		Purgatory to be relocated.
> > > @@ -184,13 +165,24 @@ void kimage_file_post_load_cleanup(struct kimage *image)
> > >  }
> > > 
> > >  #ifdef CONFIG_KEXEC_SIG
> > > +static int kexec_image_verify_sig(struct kimage *image, void *buf,
> > > +		unsigned long buf_len)
> > > +{
> > > +	if (!image->fops || !image->fops->verify_sig) {
> > > +		pr_debug("kernel loader does not support signature verification.\n");
> > > +		return -EKEYREJECTED;
> > > +	}
> > > +
> > > +	return image->fops->verify_sig(buf, buf_len);
> > > +}
> > > +
> > >  static int
> > >  kimage_validate_signature(struct kimage *image)
> > >  {
> > >  	int ret;
> > > 
> > > -	ret = arch_kexec_kernel_verify_sig(image, image->kernel_buf,
> > > -					   image->kernel_buf_len);
> > > +	ret = kexec_image_verify_sig(image, image->kernel_buf,
> > > +			image->kernel_buf_len);
> > >  	if (ret) {
> > > 
> > >  		if (IS_ENABLED(CONFIG_KEXEC_SIG_FORCE)) {
> > > --
> > > 2.34.1
> > > 
> > 
> 
> -- 
> Best regards,
> Coiby
> 

