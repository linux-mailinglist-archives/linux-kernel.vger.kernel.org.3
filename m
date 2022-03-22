Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46EAE4E3947
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 08:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237169AbiCVHB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 03:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237151AbiCVHBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 03:01:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 679C1D9B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 00:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647932425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wcf2SYtc4GFd9+9KclXmq9oA4rCndyWVsVQSDgBqSmo=;
        b=ZLvq0jmjGRKFUfHxhRGQFh4N00u6wYYEU6N/ADoLDX6C1yz7Y4Q8fxKSHJbM+4qRz1xmFs
        kyrD0ThujxgT3gJOfVrX+5h+OaKcralARg7wKQRPTxToFZTvPlkIwlANp25ZSaoj8qNyN9
        sTiuh5g10PG7RTYMK3w6c4gCVRta2Qw=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-675-XeYkEANfNPyDq5quqaNh9A-1; Tue, 22 Mar 2022 03:00:24 -0400
X-MC-Unique: XeYkEANfNPyDq5quqaNh9A-1
Received: by mail-pj1-f69.google.com with SMTP id om8-20020a17090b3a8800b001c68e7ccd5fso1266080pjb.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 00:00:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wcf2SYtc4GFd9+9KclXmq9oA4rCndyWVsVQSDgBqSmo=;
        b=k63aYY6KXOqIljJoQuvA9p/ADHuK486z6kZ3s1VTm9A7p8E+EwLTEG5ZAmRuVPCmsQ
         jHzbGzM7BTGKQFj9G4CJ2kYk1CWiOBopwKmZifV7x/Z+kZsDVZw0E0HG7AlvkAETYiXY
         BDCIEdBDhm6y563aiLl9TjR2uT6gfJg6MeyA97mJq/Jdd1YU7eSQdM9kL9Bfl7sNo1FZ
         ZEkoGnyBIW6Od/nOHuExhkYQ4fFZuo1TOn1j+1KXom3IXq8TNUwckmfz1vDufOlTZbif
         86mQ+MTggGGD0M3mAhFYk8HVz9GosGnyG/nEsh1dGe7fizGy36XzXzPrb3XAQvA3vjcS
         98Qw==
X-Gm-Message-State: AOAM530XuLia2AGMYAhth7kKSLxcMiqUjIMdIwBs3ftFbHyBH+xiTdIc
        KT2yFraR350CWein4B4ozn9/ki8EqpTDdAYbbrLdNCRsV/CXb3DipiI4J1QvkpQZhrr3enIezea
        7808/Mwe3vyCe2y59xwkiIMg7
X-Received: by 2002:a63:614:0:b0:383:c70e:8613 with SMTP id 20-20020a630614000000b00383c70e8613mr1785662pgg.85.1647932422431;
        Tue, 22 Mar 2022 00:00:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxDLAJGdDx1DX9QdGgd64bEDHVrgInDmENiGDd/21zUmQiwkY+OpHCg755hm6FNPYsJQG4L+g==
X-Received: by 2002:a63:614:0:b0:383:c70e:8613 with SMTP id 20-20020a630614000000b00383c70e8613mr1785643pgg.85.1647932422091;
        Tue, 22 Mar 2022 00:00:22 -0700 (PDT)
Received: from localhost ([240e:3a1:2e5:800:f995:6136:f760:a3d0])
        by smtp.gmail.com with ESMTPSA id b20-20020a17090a991400b001befe07ae5csm1533696pjp.22.2022.03.22.00.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 00:00:21 -0700 (PDT)
Date:   Tue, 22 Mar 2022 14:57:59 +0800
From:   Coiby Xu <coxu@redhat.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        Dave Young <dyoung@redhat.com>, Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] kexec: clean up arch_kexec_kernel_verify_sig
Message-ID: <20220322065759.2v4o3qekkc3tjroy@Rk>
References: <20220318094101.274950-1-coxu@redhat.com>
 <20220318094101.274950-2-coxu@redhat.com>
 <Yjf9TbBo5ysjM7Nl@MiWiFi-R3L-srv>
 <20220322025912.r2ahc2ztx3npt7av@Rk>
 <Yjk+0IiTXbTRC6LT@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Yjk+0IiTXbTRC6LT@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 11:13:20AM +0800, Baoquan He wrote:
>On 03/22/22 at 10:59am, Coiby Xu wrote:
>> On Mon, Mar 21, 2022 at 12:21:33PM +0800, Baoquan He wrote:
>> > On 03/18/22 at 05:40pm, Coiby Xu wrote:
>> > > Commit 9ec4ecef0af7 ("kexec_file,x86,powerpc: factor out kexec_file_ops
>> > > functions") allows implementing the arch-specific implementation of kernel
>> > > image verification in kexec_file_ops->verify_sig. Currently, there is no
>> >
>> > Looking back at the old commit 9ec4ecef0af7, it mistakenly added a
>> > generic arch_kexec_kernel_verify_sig() which is marked as __weak,
>> > and expects any architecture will add a arch specified version if needed.
>> > In fact those arch specified difference has been removed by wrapping
>> > them into each architecture's own struct kexec_file_ops methods. Means
>> > in the commit, the generic arch_kexec_kernel_verify_sig() is unnecessary
>> > at all.
>>
>> Thanks for looking at commit 9ec4ecef0af7 for me!
>>
>> Although commit 9ec4ecef0af7 added some code in arch_kexec_kernel_verify_sig
>> so kexec_file_ops->verify_sig can be called, this commit doesn't add __weak
>> arch_kexec_kernel_verify_sig itself. And kexec_file_ops isn't supposed
>> to replace arch-specific implementation using __weak considering s390 and x86
>> still make use of __weak to implement its own version of
>> arch_kexec_apply_relocations_add. How about the commit message as
>> follows?
>
>Yes, arch_kexec_apply_relocations_add has its different version on
>arches. But arch_kexec_kernel_verify_sig() is different. There's a
>specific method for that, ->verify_sig().
>
>struct kexec_file_ops {
>        kexec_probe_t *probe;
>        kexec_load_t *load;
>        kexec_cleanup_t *cleanup;
>#ifdef CONFIG_KEXEC_SIG
>        kexec_verify_sig_t *verify_sig;
>#endif
>};
>

Thanks for the explanation! This example of arch_kexec_apply_relocations_add
is indeed not good and don't illustrate my point. My point is we can't say
commit 9ec4ecef0af7 made a mistake since it's not this commit that
introduced "__weak arch_kexec_kernel_verify_sig" and I don't think its
motivation was to replace __weak with kexec_file_ops. Currently we still
have "__weak arch_kimage_file_post_load_cleanup" and kexec_file_ops->cleanup.

>>
>>   Currently this no arch-specific implementation of
>>   arch_kexec_kernel_verify_sig. Even if we want to add an implementation
>>   for an architecture in the future, we can simply use "(struct
>>   kexec_file_ops*)->verify_sig". So clean it up.
>
>That is also fine. I think it's better to put the above in if we have
>checked the old commit. Anyway, please take the sentences which comforts
>you more. And there's grammer mistake, please use 'Currently there is
>not' to replace.

Thanks for catching the mistake!

>
>> >
>> > Now, you clean up that uncessary function with code change.
>> >
>> > I think description telling above analysis could be clearer.
>> >
>> > > arch-specific implementation of arch_kexec_kernel_verify_sig. So clean it
>> > > up.
>> > >
>> > > Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
>> > > Signed-off-by: Coiby Xu <coxu@redhat.com>
>> > > ---
>> > >  include/linux/kexec.h |  4 ----
>> > >  kernel/kexec_file.c   | 34 +++++++++++++---------------------
>> > >  2 files changed, 13 insertions(+), 25 deletions(-)
>> > >
>> > > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> > > index 0c994ae37729..755fed183224 100644
>> > > --- a/include/linux/kexec.h
>> > > +++ b/include/linux/kexec.h
>> > > @@ -196,10 +196,6 @@ int arch_kexec_apply_relocations(struct purgatory_info *pi,
>> > >  				 const Elf_Shdr *relsec,
>> > >  				 const Elf_Shdr *symtab);
>> > >  int arch_kimage_file_post_load_cleanup(struct kimage *image);
>> > > -#ifdef CONFIG_KEXEC_SIG
>> > > -int arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
>> > > -				 unsigned long buf_len);
>> > > -#endif
>> > >  int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf);
>> > >
>> > >  extern int kexec_add_buffer(struct kexec_buf *kbuf);
>> > > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>> > > index 8347fc158d2b..3720435807eb 100644
>> > > --- a/kernel/kexec_file.c
>> > > +++ b/kernel/kexec_file.c
>> > > @@ -89,25 +89,6 @@ int __weak arch_kimage_file_post_load_cleanup(struct kimage *image)
>> > >  	return kexec_image_post_load_cleanup_default(image);
>> > >  }
>> > >
>> > > -#ifdef CONFIG_KEXEC_SIG
>> > > -static int kexec_image_verify_sig_default(struct kimage *image, void *buf,
>> > > -					  unsigned long buf_len)
>> > > -{
>> > > -	if (!image->fops || !image->fops->verify_sig) {
>> > > -		pr_debug("kernel loader does not support signature verification.\n");
>> > > -		return -EKEYREJECTED;
>> > > -	}
>> > > -
>> > > -	return image->fops->verify_sig(buf, buf_len);
>> > > -}
>> > > -
>> > > -int __weak arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
>> > > -					unsigned long buf_len)
>> > > -{
>> > > -	return kexec_image_verify_sig_default(image, buf, buf_len);
>> > > -}
>> > > -#endif
>> > > -
>> > >  /*
>> > >   * arch_kexec_apply_relocations_add - apply relocations of type RELA
>> > >   * @pi:		Purgatory to be relocated.
>> > > @@ -184,13 +165,24 @@ void kimage_file_post_load_cleanup(struct kimage *image)
>> > >  }
>> > >
>> > >  #ifdef CONFIG_KEXEC_SIG
>> > > +static int kexec_image_verify_sig(struct kimage *image, void *buf,
>> > > +		unsigned long buf_len)
>> > > +{
>> > > +	if (!image->fops || !image->fops->verify_sig) {
>> > > +		pr_debug("kernel loader does not support signature verification.\n");
>> > > +		return -EKEYREJECTED;
>> > > +	}
>> > > +
>> > > +	return image->fops->verify_sig(buf, buf_len);
>> > > +}
>> > > +
>> > >  static int
>> > >  kimage_validate_signature(struct kimage *image)
>> > >  {
>> > >  	int ret;
>> > >
>> > > -	ret = arch_kexec_kernel_verify_sig(image, image->kernel_buf,
>> > > -					   image->kernel_buf_len);
>> > > +	ret = kexec_image_verify_sig(image, image->kernel_buf,
>> > > +			image->kernel_buf_len);
>> > >  	if (ret) {
>> > >
>> > >  		if (IS_ENABLED(CONFIG_KEXEC_SIG_FORCE)) {
>> > > --
>> > > 2.34.1
>> > >
>> >
>>
>> --
>> Best regards,
>> Coiby
>>
>

-- 
Best regards,
Coiby

