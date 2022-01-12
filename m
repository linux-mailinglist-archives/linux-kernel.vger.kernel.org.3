Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3265848CC3E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 20:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345559AbiALTql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 14:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344913AbiALTnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 14:43:39 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21103C061759
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 11:43:37 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id br17so11838596lfb.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 11:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HWx7ejiUd6c11eHL/2LW4rxQ9jG3blTr/paj//+W3GA=;
        b=FXbhuy+QL6aQ+AoiJhfsAUjxL9AQtZNPH1/MjYiUg+Nx4vLGl/8M3mFWKS9FnfvuGD
         3yyer0YkC/HwBnY+KtCefbdzX/JuU/13Qi+4vSmRZPZom99Utfn2yDm917kaPpi2hSRI
         6/D6rlwaZv2TsttUB6JlVVKCSawSE+uVUgr/1vjRAqOsD1NEsxNfjSLJfy7xjwX8UNHw
         2Feexa8N6Jzklhn18KjxUIxXY74qWOWd7tvy2tu8esYcDnyBvPQyTMezT8R+mepS6mYY
         dNENprpfkaZkRJpBQXv7R3h3KhOA36hQnTqAiYgikUy9dDds9b/U+jm8tMTb1HURd1Le
         jEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HWx7ejiUd6c11eHL/2LW4rxQ9jG3blTr/paj//+W3GA=;
        b=CQKwKcY0lmF18WEaT2qL1DQSXGgqpoJfgP0Ua822mXz7zhvHQ31pX0PQ1ZNat8+KtQ
         a9DYX+JRL0hyOYKYgUspycd+Pc6H2Ky/SJ3FMSV59a+ZrDDNN3V1pixnhCYIiwD33+8K
         hSHSxbVQRUnsU+wTzIxfp4rWVd0Vzh3IISD6oFnCRYOXyeHUGYqBWdhoN7QUepuVghDN
         ow+gi8jNy0voW/IsJSNonVGGq+9M+oU1N1hMqPOXbCvFqIO0I59x/oUmY1pXHk4qvgD/
         01wXOW0CTxzyS5cOOvldqlvlbOyZad5YJmo/oiIw+QdJMDt9mL1N4WYzbDeqlOffywIL
         BSoA==
X-Gm-Message-State: AOAM5321pUeat7U29xb1nbkhJ09x78VcV147pOM09p80efvpiWEEvmfs
        L1MFRXcIrHv0l0/QiyC5gJhbYw==
X-Google-Smtp-Source: ABdhPJzS4Xf5WDj+CW236gyVeYs5tYSyEAdbNEh2R2wQCw8aCu2hEsekTBRphxyuWPJWkJiJSpH7Gg==
X-Received: by 2002:a19:5514:: with SMTP id n20mr878945lfe.178.1642016615543;
        Wed, 12 Jan 2022 11:43:35 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id g4sm74056lfu.137.2022.01.12.11.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 11:43:34 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 08C82103A6D; Wed, 12 Jan 2022 22:43:58 +0300 (+03)
Date:   Wed, 12 Jan 2022 22:43:58 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 6/7] x86/mm: Provide helpers for unaccepted memory
Message-ID: <20220112194358.u5akdxqrzvfepcq4@box.shutemov.name>
References: <20220111113314.27173-1-kirill.shutemov@linux.intel.com>
 <20220111113314.27173-7-kirill.shutemov@linux.intel.com>
 <a234c061-4497-3613-d47f-80071cc0e5d4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a234c061-4497-3613-d47f-80071cc0e5d4@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 12:01:56PM -0800, Dave Hansen wrote:
> On 1/11/22 03:33, Kirill A. Shutemov wrote:
> > Core-mm requires few helpers to support unaccepted memory:
> > 
> >   - accept_memory() checks the range of addresses against the bitmap and
> >     accept memory if needed;
> > 
> >   - maybe_set_page_offline() checks the bitmap and marks a page with
> >     PageOffline() if memory acceptance required on the first
> >     allocation of the page.
> > 
> >   - accept_and_clear_page_offline() accepts memory for the page and clears
> >     PageOffline().
> > 
> ...
> > +void accept_memory(phys_addr_t start, phys_addr_t end)
> > +{
> > +	unsigned long flags;
> > +	if (!boot_params.unaccepted_memory)
> > +		return;
> > +
> > +	spin_lock_irqsave(&unaccepted_memory_lock, flags);
> > +	__accept_memory(start, end);
> > +	spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
> > +}
> 
> Not a big deal, but please cc me on all the patches in the series.  This is
> called from the core mm patches which I wasn't cc'd on.
> 
> This also isn't obvious, but this introduces a new, global lock into the
> fast path of the page allocator and holds it for extended periods of time.
> It won't be taken any more once all memory is accepted, but you can sure bet
> that it will be noticeable until that happens.
> 
> *PLEASE* document this.  It needs changelog and probably code comments.

Okay, will do.

-- 
 Kirill A. Shutemov
