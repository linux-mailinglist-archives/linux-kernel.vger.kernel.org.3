Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9041F521436
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240955AbiEJLyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235005AbiEJLye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:54:34 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B2726C4D6
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 04:50:38 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id iq10so15680495pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 04:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mmuW88WgZV9+fZNJabDzsnK7aFDoJVdbS9AW+G9qV58=;
        b=POMGLdtRO5N+iPukUjeIb86hhrsrXVU/CT4e7ZA+elPTZp/Or/8RqRYku9FBmtrZRt
         WCUE9z8PPrqj8a1vchOWbcBLO2yFelIIdo1mAi8stjcFsb0PjBq6iGnk6K6L6jg4x9bg
         G1qzRuEymGuJZOXgvzGiydQOIroskPV1Ahw6yTvgtk+Tm/2o7weReumWqWquoPWfuv0x
         wEwkA7ZcOnDtrdtWlJoPYUk6BZCI/nkxl1HQnWk0IVQkPSbbC7lY4VRG8orEjeoijs7g
         mtxKBKel5urYk748o7cXJtsGhHYKzJPQhbGKIkHEa1mX/gspQNHiXlBZ9MizD79EDb6A
         Q7Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mmuW88WgZV9+fZNJabDzsnK7aFDoJVdbS9AW+G9qV58=;
        b=rj6JeJufxVsEziTkfvHIbpMa+oEk8m+2knl+NoRTTTsvlP9mTfknDA7KzmasweqVPP
         8ITp88josa9TmIbsXHNU9+d8qJi5oT21B6PR29JqL+79CWx2PQmGNnURimM7/jU/IdvD
         Sr4vO2pWPqRUa+74O7W+Rz1nkf28QeNJhd2lIrS5dF8hNJMseE1LrMJCPfL0grlYuX6R
         sVYdSjsjQAmIkc5s06uPr0xWUbqmow1GSnDNqWHnSdE29cFDvuZSj9VEorcHXedI5uNJ
         E2M8o/CQOL+2USIt9sJ5JcTk93KbjK0Waps0bbYCceeCb8Q/8Aay9abQ4AJF2Jm83giq
         LVkw==
X-Gm-Message-State: AOAM532V2DVDQJQf8P9zSztiT31/F7FZOdMoLfuMjFdeKGKCIdXgb43W
        /fSnnoQzWyRm+4W5Qnjfqn8=
X-Google-Smtp-Source: ABdhPJzNCzJ5RkULDKP7UvyWW0jsnhuTMsdy/RJYUKYTN8r322DAkITG2to8yEJt0NwdIsPQxJh6Ag==
X-Received: by 2002:a17:90a:5b09:b0:1cd:b3d3:a3f3 with SMTP id o9-20020a17090a5b0900b001cdb3d3a3f3mr23286982pji.9.1652183437537;
        Tue, 10 May 2022 04:50:37 -0700 (PDT)
Received: from hyeyoo ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id x13-20020aa78f0d000000b0050dc762819csm10480840pfr.118.2022.05.10.04.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 04:50:37 -0700 (PDT)
Date:   Tue, 10 May 2022 20:50:29 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "Tianyu.Lan@microsoft.com" <Tianyu.Lan@microsoft.com>,
        "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>
Subject: Re: [PATCH] x86/mm/cpa: set PAGE_KERNEL in __set_pages_p()
Message-ID: <YnpRhT68kwaMBEHF@hyeyoo>
References: <20220506051940.156952-1-42.hyeyoo@gmail.com>
 <2cd129af8d66fc4bffcb124a3675bffbf1becd85.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cd129af8d66fc4bffcb124a3675bffbf1becd85.camel@intel.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 12:47:11AM +0000, Edgecombe, Rick P wrote:
> On Fri, 2022-05-06 at 14:19 +0900, Hyeonggon Yoo wrote:
> > __set_pages_np() not only clears _PAGE_PRESENT and _PAGE_RW, but also
> > clears _PAGE_GLOBAL to avoid confusing _PAGE_GLOBAL as _PAGE_PROTNONE
> > when the PTE is not present.
> > 
> > Common usage for __set_pages_p() is to call it after
> > __set_pages_np().
> > Therefore calling __set_pages_p() after __set_pages_np() clears
> > _PAGE_GLOBAL, making it unable to globally shared in TLB.
> > 
> > As they are called by set_direct_map_{invalid,default}_noflush(),
> > pages in direct map cannot be globally shared in TLB after being used
> > by
> > vmalloc, secretmem, and hibernation.
> > 
> > So set PAGE_KERNEL isntead of __pgprot(_PAGE_PRESENT | _PAGE_RW) in
> > __set_pages_p().
> 
> Nice find. I think we can't always set PAGE_KERNEL also because of the
> PTI code. It sometimes wants the direct map to be non global.
>

Thanks for review!

IIUC __pgprot_mask() already clears _PAGE_GLOBAL from PAGE_KERNEL
when PTI is used.

#define __pgprot_mask(x)        __pgprot((x) & __default_kernel_pte_mask)
#define PAGE_KERNEL             __pgprot_mask(__PAGE_KERNEL | _ENC)

But yeah, it seems PAGE_KERNEL is too much for this.

> Maybe something like this?
> (_PAGE_PRESENT | _PAGE_RW | _PAGE_GLOBAL) & __default_kernel_pte_mask
>

What about __pgprot_mask(_PAGE_PRESENT | _PAGE_RW | _PAGE_GLOBAL)?

> That would add back in a little of the "default global" behavior that
> was removed in d1440b2, but I think it should be ok because it is
> limited to the direct map. 

> Otherwise, I wonder if the existing global
> clearing logic is really needed.

I think it's still needed. pte_present() returning true due to _PAGE_PROTNONE
after __set_pages_np() simply doesn't make sense. No?

-- 
Thanks,
Hyeonggon
