Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921F5517BA9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 03:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiECB3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 21:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiECB3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 21:29:10 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114A7DFB3
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 18:25:40 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id p12so28123544lfs.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 18:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=12DhJbkUccsFRkzufYi61LPquO7lkrys8l909zLJMkU=;
        b=xsWQuinaF9UY2JPbckte3C1gC+gOuZH+9m0e0Re6snILcV3hTNvqRezWZgbhNP5oY3
         IsaIbKWgLFhlMCap/f5oQsMY/sivXwFcKjYklWh11BKSJG+VJEJ6RfQ/MIak+1i1VmVe
         sr4lIpstlJy5/qe2YZhd3VCq8bac0td9c5O1C5GgokvCj4nF8iCqyekWXVnxfnxqxyCR
         Noagb8rVvrQWhXiwWzC0KKBNa6mySHKavPia0zu5vKcq1cxaO1vCa0LFD/Kqa3BMUwx2
         3w1Kb4dRk1D14xMlKojLBX7QiwPhR2RuJ2MW7aBhtKVDc47l/vqZ3qfvSOXPySTH2BtO
         FrXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=12DhJbkUccsFRkzufYi61LPquO7lkrys8l909zLJMkU=;
        b=axEL5V7BTEeZmZ9Gja6k7+lphNRCdeZGyVoEMWdKlZPQmHXipYlMwbm35SClTc2ci7
         pPJ/jkkxE+Wtl59xapINkkvPB+BC7wWLfKHJKA+acJ23u/HWDKmiB+PPT6QQsEVS6dKj
         tLbVcWoUhk5W8TIXf5faxY2uFYjdwPPWpwc2OqTCcNOAtuMWzCrxvRsf5RiEMeHSBj8z
         xr6Lx5byVwNoGXkKbmtlX0uTyZJ7VxAPeEBqKia4bWj3M4uKs2YoRotTPLma/v172fnU
         cfY4xKefjFajKjQ6xaRrnAXBWB1E1EeIRO9AF+XniGH/a/1fkQYJ3tkYxuSXUlEJc2iv
         FUMA==
X-Gm-Message-State: AOAM532eS+J2hoXJqsEL3nkAGWk68Z1MWtGrBMP/dr0PKVXvbSoMC0qM
        cHVlqlw/v5fM24khSew2CNio7Q==
X-Google-Smtp-Source: ABdhPJwheyfTGhc9tlqGwF4SkfwUwjiEA01Fj9wW9bRfUMadvazII1MVioy5YvxjmBVQ/o0ykt60jw==
X-Received: by 2002:a19:6f0a:0:b0:472:2ed2:dc with SMTP id k10-20020a196f0a000000b004722ed200dcmr9924608lfc.99.1651541138420;
        Mon, 02 May 2022 18:25:38 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id s9-20020a19ad49000000b0047255d2114fsm833302lfd.126.2022.05.02.18.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 18:25:37 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id C8102104AD8; Tue,  3 May 2022 04:27:21 +0300 (+03)
Date:   Tue, 3 May 2022 04:27:21 +0300
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
Message-ID: <20220503012721.ok7fbvxmnvsr6qny@box.shutemov.name>
References: <20220501183500.2242828-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220501183500.2242828-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <243e918c523320ba3d216cbe22d24fe5ce33f370.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <243e918c523320ba3d216cbe22d24fe5ce33f370.camel@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 02:40:26PM +1200, Kai Huang wrote:
> 
> > +
> > +	/* Get order for Quote buffer page allocation */
> > +	order = get_order(quote_req.len);
> > +
> > +	/*
> > +	 * Allocate buffer to get TD Quote from the VMM.
> > +	 * Size needs to be 4KB aligned (which is already
> > +	 * met in page allocation).
> > +	 */
> > +	tdquote = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
> > +	if (!tdquote) {
> > +		ret = -ENOMEM;
> > +		goto quote_failed;
> > +	}
> 
> You can use alloc_pages_exact().
> 
> > +
> > +	/*
> > +	 * Since this buffer will be shared with the VMM via GetQuote
> > +	 * hypercall, decrypt it.
> > +	 */
> > +	ret = set_memory_decrypted((unsigned long)tdquote, 1UL << order);
> > +	if (ret)
> > +		goto quote_failed;
> 
> 
> Again, Dave and Andi already commented you should use vmap() to avoid breaking
> up the direct-mapping.  Please use vmap() instead.
> 
> https://lore.kernel.org/all/ce0feeec-a949-35f8-3010-b0d69acbbc2e@linux.intel.com/
> 
> Will review the rest later.

I would rather convert it to use DMA API for memory allocation. It will
tap into swiotlb buffer that already converted and there's no need to
touch direct mapping. Both allocation and freeing such memory is cheaper
because of that.

-- 
 Kirill A. Shutemov
