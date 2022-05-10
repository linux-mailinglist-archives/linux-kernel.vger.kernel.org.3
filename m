Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F7452147D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241419AbiEJMBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 08:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241386AbiEJMB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 08:01:27 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B571BD712
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 04:57:25 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id x88so4129741pjj.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 04:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7BPZlTHByJ08KrdS7jJrTlTcZYxY/HRw1sFuvcsMJtw=;
        b=UWWC5Jv7k0umTf2srlPlhKqOfgbSx2z3RAvdCLw1KpRk70G1E1NwqiERUB5vm6Nub0
         IvGhBPQr6FLjS9oai5za6N6rr3X7UHR1/ad2Z/wzGonTf0Bw7Q+xjBs4oNd3Z35HpVFW
         QKJHRxUaJl8Gj6S4WXsHHZIRRcSRLbbjZtcyXNbOcg2dyL2vI90PXu0hWLEItjoZt0hd
         FJv+uFSCA7ontfeayjE1CXX6tu+/p1LvcPIM+w3A/Clnz7dd6JoWiRKTWrTAJMH4YNhZ
         oGkB/Rqs9Vy1hsd6tQFnk9jdxgYoKfte3Sd1xt9Z1OVudrKzT7+2iedhF6aWyW6NkrTU
         RuhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7BPZlTHByJ08KrdS7jJrTlTcZYxY/HRw1sFuvcsMJtw=;
        b=fo4Wt33F4oXFdweRoQB7STJii2H8r+zXirUg8YFcB2e5kCNXCvpiG5NdlKX3oXPMqN
         tNvJt8WrzXACAtmWzOrSlwNL687OHXYu3dIGUA1DYsFXpmB/oVcbaLZGIMA4d6qSZ/1S
         MKt1y2G4It+09w+5R8nfdSL0iHlgHoc6/zIyZ/jyM8CEtaj9sfW6LGwjfDMh/Zfm+J//
         9l1RlD0e45cbmca6S+Xb6P4yPFJ18YiLcAgDyFwUiiv5YSIiNdY8plYMgrtZF6OsthtY
         sN1jfey69JbKEW2fo1lrVivqBL0WLsX0AGpP5V12kTC8lo87fgkC6Cy7FvbIFkZLc2QT
         pqtA==
X-Gm-Message-State: AOAM531wkS//Sc7tmCz+HqzYcskWfgPyZcJWh3BkismaBpyHWO1ys+n6
        CO8WbYkzzulhST0h963p/A8=
X-Google-Smtp-Source: ABdhPJzK1VkiphXc+HoTD+GpWQ0/A8btsdOK09KMv+Sxa9B1hdkP6x/ieyK4QCaW4Hm5lBorBuKrXQ==
X-Received: by 2002:a17:90b:4b83:b0:1dc:5073:b704 with SMTP id lr3-20020a17090b4b8300b001dc5073b704mr23201301pjb.94.1652183844892;
        Tue, 10 May 2022 04:57:24 -0700 (PDT)
Received: from hyeyoo ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id bd36-20020a056a0027a400b0050dc76281b1sm10261215pfb.139.2022.05.10.04.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 04:57:24 -0700 (PDT)
Date:   Tue, 10 May 2022 20:57:16 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mm/cpa: set PAGE_KERNEL in __set_pages_p()
Message-ID: <YnpTHMvOO/pLJQ+l@hyeyoo>
References: <20220506051940.156952-1-42.hyeyoo@gmail.com>
 <56f89895-601e-44c9-bda4-5fae6782e27e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56f89895-601e-44c9-bda4-5fae6782e27e@amd.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 11:06:22AM -0500, Tom Lendacky wrote:
> On 5/6/22 00:19, Hyeonggon Yoo wrote:
> > __set_pages_np() not only clears _PAGE_PRESENT and _PAGE_RW, but also
> > clears _PAGE_GLOBAL to avoid confusing _PAGE_GLOBAL as _PAGE_PROTNONE
> > when the PTE is not present.
> > 
> > Common usage for __set_pages_p() is to call it after __set_pages_np().
> > Therefore calling __set_pages_p() after __set_pages_np() clears
> > _PAGE_GLOBAL, making it unable to globally shared in TLB.
> > 
> > As they are called by set_direct_map_{invalid,default}_noflush(),
> > pages in direct map cannot be globally shared in TLB after being used by
> > vmalloc, secretmem, and hibernation.
> > 
> > So set PAGE_KERNEL isntead of __pgprot(_PAGE_PRESENT | _PAGE_RW) in
> > __set_pages_p().
> > 
> > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > ---
> >   arch/x86/mm/pat/set_memory.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> > index abf5ed76e4b7..fcb6147c4cd4 100644
> > --- a/arch/x86/mm/pat/set_memory.c
> > +++ b/arch/x86/mm/pat/set_memory.c
> > @@ -2177,7 +2177,7 @@ static int __set_pages_p(struct page *page, int numpages)
> >   	struct cpa_data cpa = { .vaddr = &tempaddr,
> >   				.pgd = NULL,
> >   				.numpages = numpages,
> > -				.mask_set = __pgprot(_PAGE_PRESENT | _PAGE_RW),
> > +				.mask_set = PAGE_KERNEL,
> 
> With SME/SEV, this will also (unintentionally) set the encryption bit, so I
> don't think this is correct.
>

Thank you for catching this.
It seems PAGE_KERNEL was too much for  __set_pages_p().

I think __pgprot_mask(_PAGE_KERNEL | _PAGE_RW | _PAGE_GLOBAL) would be correct.
Thoughts?

> Thanks,
> Tom
> 
> >   				.mask_clr = __pgprot(0),
> >   				.flags = 0};

-- 
Thanks,
Hyeonggon
