Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086BC517C03
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 04:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiECCq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 22:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiECCq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 22:46:58 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EED2BF7
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 19:43:26 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 4so20464079ljw.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 19:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zgySb+HNzFUk3joIalOimdZxHHYJ+yOrTw0pqy0QEKw=;
        b=w00uq15BcCMbJuIEj6FD6PtqAaONE+0eHFNJh0ro0+b/YYhypcmevcvcvG8pBxnhOD
         t/dlkXtbwwzl9Q8rUQHx5FWamQTD9/QfeaTlcW5XXE2HwZXpP4uHAjjZei3K5ie95kEB
         0ICztYEbUyqGnKCZJG6M0bDj5vGHuGXev2XNQyjrY2MU4GHbLS2rqRW35rMt0dOqHkpN
         sfCYmk+ssnNSgCVR41QfSyjaRSgH402QX8smYe7ovXkaD9LkPx0EC2HderiIMAZ5Yqhv
         mBQIYs47JNuPPMStuk2aUpJhEPb7UtUh25Cj5P9SVpkiB9Pi4AJPzkOdq/+UTVZcc6dx
         SYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zgySb+HNzFUk3joIalOimdZxHHYJ+yOrTw0pqy0QEKw=;
        b=sMUZVh7QARqaPak+6xYhueXQ+8YZ/I+0JflaGsnduLQWlGMC9+niQ6Mysx7TFIgp8l
         T2RpiPQWmSQeq1/FMpA6Bu9G3bLSSbOcuo2i9dklY6voLpClTXbX0yme/wAcm3xWMJcw
         kvl4myivd8pVy1zGnXCbiXXKU2o/SUfr0qkgE7mhnTln4as/R8tgnUF+vtdj0njVQv7v
         9Dz/T6yH2qQ8VbJLd3KV3nVfMzJojjF4YGogEeARfEtNCayySoGqRYIP1veFUm6aecEp
         xX7Gwwds+o6pfpPjUvzETJA0XKm5xpSynMXJnVmUtuoAPoDCz8Z2fIrWYNIOSNCswyn/
         /R1w==
X-Gm-Message-State: AOAM530uaeByaAK0cWBldphlQ1wf7O7CWMVWWIj/cXDq4700DHPu9mlg
        +nHz3/m/k2cha4440DBaQ0V2Mw==
X-Google-Smtp-Source: ABdhPJw7nlXUOwYqzzU6RtaTb8GCzoFxBjEy9idSHscdEw/POs1dZFwo1xibp5GkKDMHMyjQ1wqe5Q==
X-Received: by 2002:a2e:8648:0:b0:24f:33f9:93b with SMTP id i8-20020a2e8648000000b0024f33f9093bmr8840058ljj.502.1651545804684;
        Mon, 02 May 2022 19:43:24 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id d20-20020ac241d4000000b0047255d211aasm840443lfi.217.2022.05.02.19.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 19:43:24 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 7BFFD104AD8; Tue,  3 May 2022 05:45:08 +0300 (+03)
Date:   Tue, 3 May 2022 05:45:08 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Kai Huang <kai.huang@intel.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] x86/tdx: Add Quote generation support
Message-ID: <20220503024508.qjh4nfygfstb3ls3@box.shutemov.name>
References: <20220501183500.2242828-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220501183500.2242828-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <243e918c523320ba3d216cbe22d24fe5ce33f370.camel@intel.com>
 <20220503012721.ok7fbvxmnvsr6qny@box.shutemov.name>
 <4cf22a0799cc13fa6f09ffbf0e5d83ed7eeb32ad.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cf22a0799cc13fa6f09ffbf0e5d83ed7eeb32ad.camel@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2022 at 02:18:10PM +1200, Kai Huang wrote:
> On Tue, 2022-05-03 at 04:27 +0300, Kirill A. Shutemov wrote:
> > On Mon, May 02, 2022 at 02:40:26PM +1200, Kai Huang wrote:
> > > 
> > > > +
> > > > +	/* Get order for Quote buffer page allocation */
> > > > +	order = get_order(quote_req.len);
> > > > +
> > > > +	/*
> > > > +	 * Allocate buffer to get TD Quote from the VMM.
> > > > +	 * Size needs to be 4KB aligned (which is already
> > > > +	 * met in page allocation).
> > > > +	 */
> > > > +	tdquote = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
> > > > +	if (!tdquote) {
> > > > +		ret = -ENOMEM;
> > > > +		goto quote_failed;
> > > > +	}
> > > 
> > > You can use alloc_pages_exact().
> > > 
> > > > +
> > > > +	/*
> > > > +	 * Since this buffer will be shared with the VMM via GetQuote
> > > > +	 * hypercall, decrypt it.
> > > > +	 */
> > > > +	ret = set_memory_decrypted((unsigned long)tdquote, 1UL << order);
> > > > +	if (ret)
> > > > +		goto quote_failed;
> > > 
> > > 
> > > Again, Dave and Andi already commented you should use vmap() to avoid breaking
> > > up the direct-mapping.  Please use vmap() instead.
> > > 
> > > https://lore.kernel.org/all/ce0feeec-a949-35f8-3010-b0d69acbbc2e@linux.intel.com/
> > > 
> > > Will review the rest later.
> > 
> > I would rather convert it to use DMA API for memory allocation. It will
> > tap into swiotlb buffer that already converted and there's no need to
> > touch direct mapping. Both allocation and freeing such memory is cheaper
> > because of that.
> > 
> 
> Does each DMA allocation and free internally do the actual private/shared
> conversion?  Or the swiotlb is converted at the beginning at boot and DMA
> allocation will always get the shared buffer automatically?

It can remap as fallback, but usually it allocates from the pool.

> The problem of using DMA API is it will need to bring additional code to use
> platform device, which isn't necessary.

Heh? DMA is in the kernel anyway. Or do you mean some cost from the header
for the compilation unit? That's strange argument. Kernel provides
infrastructure for a reason.

> Using vmap() we can still (almost) avoid private/shared conversion at IOCTL time
> by allocating a default size buffer (which is large enough to cover 99% cases,
> etc) at driver initialization time:
> 
> https://lore.kernel.org/lkml/20220422233418.1203092-2-sathyanarayanan.kuppuswamy@linux.intel.com/T/#maf7e5f6894548972c5de71f607199a79645856ff

I don't see a reason to invent ad-hoc solution if there's an establised
API for the task.

-- 
 Kirill A. Shutemov
