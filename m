Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6BCB5975D5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 20:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240478AbiHQSkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 14:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237097AbiHQSkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 14:40:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0AA9C2F4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 11:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660761603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vFVqNNb0hcNnzpCN6Usam55O8PiDZUdmPvKKh6BjScw=;
        b=ametmHFviIV+zIh6WiZyN4izbfsC5eBxN+4DVuL6npqBB/o8UQYNkNDiphoNaWcMGcQTKp
        J0ixKsBMUIWdEBFCCqk4GqtjWRxGdyXgtWSUcCZEXTanqK44ccg5IJj2Pt3aHapEscY9z5
        DZyyIVaW53OE704sTbSACTIj9NwcVX8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-85-bDEmC7gINjWRDI63-3uyew-1; Wed, 17 Aug 2022 14:40:02 -0400
X-MC-Unique: bDEmC7gINjWRDI63-3uyew-1
Received: by mail-qv1-f69.google.com with SMTP id o16-20020a0cecd0000000b0049656c32564so2228132qvq.19
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 11:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=vFVqNNb0hcNnzpCN6Usam55O8PiDZUdmPvKKh6BjScw=;
        b=vLaZXK+PaLGcv5lpXzZbMHUu0KGhVswhwMNkxDseAYoWh8zGhyPhmFZHXEjH2GdoVy
         549zwKzsW4vS5+7kSuG1zIagBX1LgclakDQOYDgbkK7hY7mRBSW7ff1+Yfr5I9vZlxUQ
         Cf7AoOPryoPOW6+b4RJopGGxumtHgTHRIkn2ejFMP1GVgW91PYBhnTCadjFZVAn8sCX2
         eOV2qr3Deav7OrpATTWBVHn8j3lt0C2CREaqrxOshgxD/pjGzUjLbNhtZuAmaDrkqbRN
         KtpFgDZqnin4p0F7PlsvauKQO3K6F3cga5geitsPAhlvg/HSQTfhD1LUssy4eMF1nzMS
         ObGg==
X-Gm-Message-State: ACgBeo0iv2Vzlr748VZRacLsJOy6FyKD5F04bG3jOGMMpVT6YF4kKKXt
        +0QlOV3IKzpkmvbZoxx/lX+4B261x7pTVCjhyPUsMXcrhvBJz662F4Z6wMgHfbKJ35o1fZSutPD
        TIATrF15Vj/8u8Be9nEOIS6AC
X-Received: by 2002:a05:620a:244d:b0:6b2:538f:ffda with SMTP id h13-20020a05620a244d00b006b2538fffdamr19403185qkn.218.1660761601568;
        Wed, 17 Aug 2022 11:40:01 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7QZCIq/LkhZu/7gJ28ZdNfz4GfEx4k6PFRys0DC5W3FPAtzpSOPoW806jLp7Gro+1d2zowoA==
X-Received: by 2002:a05:620a:244d:b0:6b2:538f:ffda with SMTP id h13-20020a05620a244d00b006b2538fffdamr19403167qkn.218.1660761601238;
        Wed, 17 Aug 2022 11:40:01 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id c3-20020a05620a268300b006b58d8f6181sm15028256qkp.72.2022.08.17.11.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 11:40:00 -0700 (PDT)
Date:   Wed, 17 Aug 2022 14:39:58 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH] s390: fix double free of GS and RI CBs on fork() failure
Message-ID: <Yv01/i4KFdgmCpsD@bfoster>
References: <20220816155407.537372-1-bfoster@redhat.com>
 <20220817130906.0ce40da1@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817130906.0ce40da1@thinkpad>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 01:09:06PM +0200, Gerald Schaefer wrote:
> On Tue, 16 Aug 2022 11:54:07 -0400
> Brian Foster <bfoster@redhat.com> wrote:
> 
> > The pointers for guarded storage and runtime instrumentation control
> > blocks are stored in the thread_struct of the associated task. These
> > pointers are initially copied on fork() via arch_dup_task_struct()
> > and then cleared via copy_thread() before fork() returns. If fork()
> > happens to fail after the initial task dup and before copy_thread(),
> > the newly allocated task and associated thread_struct memory are
> > freed via free_task() -> arch_release_task_struct(). This results in
> > a double free of the guarded storage and runtime info structs
> > because the fields in the failed task still refer to memory
> > associated with the source task.
> > 
> > This problem can manifest as a BUG_ON() in set_freepointer() (with
> > CONFIG_SLAB_FREELIST_HARDENED enabled) or KASAN splat (if enabled)
> > when running trinity syscall fuzz tests on s390x. To avoid this
> > problem, clear the associated pointer fields in
> > arch_dup_task_struct() immediately after the new task is copied.
> > Note that the RI flag is still cleared in copy_thread() because it
> > resides in thread stack memory and that is where stack info is
> > copied.
> > 
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > ---
> > 
> > Hi all,
> > 
> > Note that I'm not subscribed to the list so please CC on reply. Further,
> > I'm not terribly familiar with these associated features and so have not
> > run any kind of functional testing here. My testing was purely around
> > producing/preventing the double free issue. Any thoughts, reviews or
> > further testing is appreciated. Thanks.
> > 
> > Brian
> > 
> >  arch/s390/kernel/process.c | 22 ++++++++++++++++------
> >  1 file changed, 16 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
> > index 89949b9f3cf8..d5119e039d85 100644
> > --- a/arch/s390/kernel/process.c
> > +++ b/arch/s390/kernel/process.c
> > @@ -91,6 +91,18 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
> >  
> >  	memcpy(dst, src, arch_task_struct_size);
> >  	dst->thread.fpu.regs = dst->thread.fpu.fprs;
> > +
> > +	/*
> > +	 * Don't transfer over the runtime instrumentation or the guarded
> > +	 * storage control block pointers. These fields are cleared here instead
> > +	 * of in copy_thread() to avoid premature freeing of associated memory
> > +	 * on fork() failure. Wait to clear the RI flag because ->stack still
> > +	 * refers to the source thread.
> > +	 */
> > +	dst->thread.ri_cb = NULL;
> > +	dst->thread.gs_cb = NULL;
> > +	dst->thread.gs_bc_cb = NULL;
> > +
> >  	return 0;
> >  }
> >  
> > @@ -150,13 +162,11 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
> >  	frame->childregs.flags = 0;
> >  	if (new_stackp)
> >  		frame->childregs.gprs[15] = new_stackp;
> > -
> > -	/* Don't copy runtime instrumentation info */
> > -	p->thread.ri_cb = NULL;
> > +	/*
> > +	 * Clear the runtime instrumentation flag after the above childregs
> > +	 * copy. The CB pointer was already cleared in arch_dup_task_struct().
> > +	 */
> >  	frame->childregs.psw.mask &= ~PSW_MASK_RI;
> > -	/* Don't copy guarded storage control block */
> > -	p->thread.gs_cb = NULL;
> > -	p->thread.gs_bc_cb = NULL;
> >  
> >  	/* Set a new TLS ?  */
> >  	if (clone_flags & CLONE_SETTLS) {
> 
> Thanks Brian, nice catch! Looks good to me. For completeness, we should
> add stable / Fixes tags, like this:
> 
> Fixes: 8d9047f8b967c ("s390/runtime instrumentation: simplify task exit handling")
> Fixes: 7b83c6297d2fc ("s390/guarded storage: simplify task exit handling")
> Cc: <stable@vger.kernel.org> # 4.15
> 
> Not 100% sure about the Fixes tags, Heiko should also have a look when
> he returns next week.
> 
> Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> 

Hi Gerald,

Sounds good, thanks for the review. I'll wait a bit so Heiko has a
chance to take a look and then follow up with the tag updates and any
other necessary changes..

Brian

