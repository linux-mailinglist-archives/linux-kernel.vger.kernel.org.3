Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C5D58FB4D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 13:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234857AbiHKLav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 07:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234908AbiHKLal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 07:30:41 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB331F2D1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 04:30:40 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d20so16225113pfq.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 04:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=Lotv4i3sKmDKswFL2LYiAv6JLCAKP8IKIqlMg8tjwe0=;
        b=mlj2F/TR0hM3q/t91pZcveyGmKVpFRS4Ilk8VCtxu4KJlB/ehJ7eII6ljjnHYMhyMl
         jVtPdP4FYP/dq2UfOGWmH8gM+3vxOPwowlOMq6ffo4Due677PERHa8uB//H8Daz7uYWn
         DhpnRKsMa64+t12A4lMJbNP8jZ0AYLoGBYCnlF4+16XQhAnO5N0DZAN4j2AbwGPHe94X
         n2Mda6q/IP0UYXr9xDvsZta3uX+98OuWt9gKJjd+WHwKYekLShi5elv/8ClHO1tj4WPM
         +sG3wmMNFJQcu6eulo8r0DQ2kkho41jGtmvIsDqHYMxx9ikHkXRmV4bLGzAIvzG6q1Nu
         d2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Lotv4i3sKmDKswFL2LYiAv6JLCAKP8IKIqlMg8tjwe0=;
        b=tKTI3L+ArTalxPsBBvDgAAmkf4RGSCqVWbmP3WwRu44kshWgm336Elo8NmLgfM5bhD
         u4JNxThjQNfeTw7m57uyG/lvkTYCPZtXy9/hB3mt7/9RWDCCXgWHYLaey/YUlLpLnda0
         u02HoxlKSE1iOgu2iKzmSAmqV+pRnP7M1cpL1gb1b4+UKld0wFwf11fhXpo0t9NmaR2c
         XHDLrbEq2BUksUwArG5daA+rZKdIbAb8xRGKEQ1UFfemutsLfB3FOK8ctZSXJLuYgEGO
         4Lpl7omVhxk718vYQUJPEYwS+jzo80H02iou/E/BE0jlZAKOb+5BvP60qsxIk6KHfVXx
         M4aA==
X-Gm-Message-State: ACgBeo0D8aQgqKzteWeHbwIJG8OhN/bKAx872kjPVnGBtBMi19WTUPM+
        uu4XHaG1b6bUkZTYodsBXbo=
X-Google-Smtp-Source: AA6agR7YlV3DyUOnbRxF8nRvoqiL+Rbu7XjoJHGco4E9c997E6TnmELb5JYXnLUqMjnQtr6y5Y30Jg==
X-Received: by 2002:a63:8241:0:b0:41b:c27b:c18 with SMTP id w62-20020a638241000000b0041bc27b0c18mr26953689pgd.370.1660217439758;
        Thu, 11 Aug 2022 04:30:39 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id m17-20020a170902d19100b0016d83ed0a2csm14486958plb.80.2022.08.11.04.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 04:30:38 -0700 (PDT)
Date:   Thu, 11 Aug 2022 20:30:34 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     "Lu, Aaron" <aaron.lu@intel.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "song@kernel.org" <song@kernel.org>
Subject: Re: [RFC PATCH 1/4] x86/mm/cpa: restore global bit when page is
 present
Message-ID: <YvToWsNqXudd6cSN@hyeyoo>
References: <20220808145649.2261258-1-aaron.lu@intel.com>
 <20220808145649.2261258-2-aaron.lu@intel.com>
 <YvSRyjDsrbB7v2JT@ip-172-31-24-42.ap-northeast-1.compute.internal>
 <df4f40ff3e4c408931ed21ab4e8968bdb1871f79.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df4f40ff3e4c408931ed21ab4e8968bdb1871f79.camel@intel.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 08:16:08AM +0000, Lu, Aaron wrote:
> On Thu, 2022-08-11 at 05:21 +0000, Hyeonggon Yoo wrote:
> > On Mon, Aug 08, 2022 at 10:56:46PM +0800, Aaron Lu wrote:
> > > For configs that don't have PTI enabled or cpus that don't need
> > > meltdown mitigation, current kernel can lose GLOBAL bit after a page
> > > goes through a cycle of present -> not present -> present.
> > > 
> > > It happened like this(__vunmap() does this in vm_remove_mappings()):
> > > original page protection: 0x8000000000000163 (NX/G/D/A/RW/P)
> > > set_memory_np(page, 1):   0x8000000000000062 (NX/D/A/RW) lose G and P
> > > set_memory_p(pagem 1):    0x8000000000000063 (NX/D/A/RW/P) restored P
> > > 
> > > In the end, this page's protection no longer has Global bit set and this
> > > would create problem for this merge small mapping feature.
> > > 
> > > For this reason, restore Global bit for systems that do not have PTI
> > > enabled if page is present.
> > > 
> > > (pgprot_clear_protnone_bits() deserves a better name if this patch is
> > > acceptible but first, I would like to get some feedback if this is the
> > > right way to solve this so I didn't bother with the name yet)
> > > 
> > > Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> > > ---
> > >  arch/x86/mm/pat/set_memory.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> > > index 1abd5438f126..33657a54670a 100644
> > > --- a/arch/x86/mm/pat/set_memory.c
> > > +++ b/arch/x86/mm/pat/set_memory.c
> > > @@ -758,6 +758,8 @@ static pgprot_t pgprot_clear_protnone_bits(pgprot_t prot)
> > >  	 */
> > >  	if (!(pgprot_val(prot) & _PAGE_PRESENT))
> > >  		pgprot_val(prot) &= ~_PAGE_GLOBAL;
> > > +	else
> > > +		pgprot_val(prot) |= _PAGE_GLOBAL & __default_kernel_pte_mask;
> > >  
> > >  	return prot;
> > >  }
> > 
> > IIUC It makes it unable to set _PAGE_GLOBL when PTI is on.
> > 
> 
> Yes. Is this a problem?
> I think that is the intended behaviour when PTI is on: not to enable
> Gloabl bit on kernel mappings.

Please note that I'm not expert on PTI.

but AFAIK with PTI, at least everything (kernel part) mapped to user page table is
mapped as global when PGE is supported.

Not sure "Global bit is never used for kernel part when PTI is enabled"
is true.

Also, commit d1440b23c922d ("x86/mm: Factor out pageattr _PAGE_GLOBAL setting") that introduced
pgprot_clear_protnone_bits() says:
	
	This unconditional setting of _PAGE_GLOBAL is a problem when we have
	PTI and non-PTI and we want some areas to have _PAGE_GLOBAL and some
	not.

	This updated version of the code says:
	1. Clear _PAGE_GLOBAL when !_PAGE_PRESENT
	2. Never set _PAGE_GLOBAL implicitly
	3. Allow _PAGE_GLOBAL to be in cpa.set_mask
	4. Allow _PAGE_GLOBAL to be inherited from previous PTE

> > Maybe it would be less intrusive to make
> > set_direct_map_default_noflush() replace protection bits
> > with PAGE_KENREL as it's only called for direct map, and the function
> > is to reset permission to default:
> > 
> > diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> > index 1abd5438f126..0dd4433c1382 100644
> > --- a/arch/x86/mm/pat/set_memory.c
> > +++ b/arch/x86/mm/pat/set_memory.c
> > @@ -2250,7 +2250,16 @@ int set_direct_map_invalid_noflush(struct page *page)
> > 
> >  int set_direct_map_default_noflush(struct page *page)
> >  {
> > -       return __set_pages_p(page, 1);
> > +       unsigned long tempaddr = (unsigned long) page_address(page);
> > +       struct cpa_data cpa = {
> > +                       .vaddr = &tempaddr,
> > +                       .pgd = NULL,
> > +                       .numpages = 1,
> > +                       .mask_set = PAGE_KERNEL,
> > +                       .mask_clr = __pgprot(~0),

Nah, this sets _PAGE_ENC unconditionally, which should be evaluated.
Maybe less intrusive way would be:
		       .mask_set = __pgprot(_PAGE_PRESENT |
					   (_PAGE_GLOBAL & __kernel_default_pte_mask)),
                       .mask_clr = __pgprot(0),

> > +                       .flags = 0};
> > +
> > +       return __change_page_attr_set_clr(&cpa, 0);
> >  }
> 
> Looks reasonable to me and it is indeed less intrusive. I'm only
> concerned there might be other paths that also go through present ->
> not present -> present and this change can not cover them.
>

AFAIK other paths going through present->not present->present (using CPA)
is only when DEBUG_PAGEALLOC is used.

Do we care direct map fragmentation when using DEBUG_PAGEALLOC?

> > 
> > set_direct_map_{invalid,default}_noflush() is the exact reason
> > why direct map become split after vmalloc/vfree with special
> > permissions.
> 
> Yes I agree, because it can lose G bit after the whole cycle when PTI
> is not on. When PTI is on, there is no such problem because G bit is
> not there initially.
> 
> Thanks,
> Aaron

-- 
Thanks,
Hyeonggon
