Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19DB6522B97
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 07:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237369AbiEKFVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 01:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238419AbiEKFU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 01:20:58 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4EA27CDC
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 22:20:55 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 204so1036138pfx.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 22:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gShjsFeiifoug2plNelUILG6jaYpeyVtnTsKqAkuZ4k=;
        b=g5r8R2+cpHQZ5CuBtznNGp56UWg6h/nYX4H8ueSja/VvsvkHE3qUB1mJEUQGlWEMti
         56aNXjewXY2clD+mpzMl4Rwc4vUJXDifmqMkh8spI1Xdk3ySZfe/oHJgZJ35aHbAAFGg
         nJhSFm+draoBSxEhb95zDgJudUoTDVP3jzAld5Gc0q6i2eoRP1h0R2f2JjlAJhfzXc4N
         CZxLVPxUpZoizs1JmN5BG+TSir3fiaEYLLH69/oFUIoPhRCGlWh0Wqa2KBm4r/0leHwB
         0YSdZAiHOvlOodAbIuy2/R5XZeF1KNeprd0ysKDeNZ+3PheTg4BU+3ndUd/e1DU3Gc3b
         UQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gShjsFeiifoug2plNelUILG6jaYpeyVtnTsKqAkuZ4k=;
        b=e99HAgoDd/dBzUIKJLru6IO0A/OWogoiAzd1iLfm5b9RUho/ubUumHVzGuYNhWn6gO
         xgI1lx8kLStY0nmRFh2fBuMwvdGGetE6c9ji+WbfOk1evyo5hLWj8mGIKyF24saJTuOE
         B3usorGy3tfU/sAA7s7Sp+bX1G3JZq3XtFYgFkfohnjp7tnKtxIW56GFl8Az/brIBo+/
         0MWltEu6dgS8OKR9tG8HM/+GYH48q1ktHlDeCtlwb3ptDuxv/8AMJ5pQhhMKLnMrH0rz
         N8+iCvhcvjJ//vAaHizQKdyB/sFKZKLqR8Khvw4bvSiQSe6qE3pUmHc/ED1YFjxgT3dx
         lZ/A==
X-Gm-Message-State: AOAM532+opOR3C+v5aML2F2Aq3ShBq1QMBiFzydrxsP/3/AMbd3UGjh5
        bSXmPawjo3asyDqRvk2O4A4=
X-Google-Smtp-Source: ABdhPJynh0hIEwsWsuoZ5ITbr5lsshxQJn43n4NSnv7tPSHLz5gURAYqSdvkCGVbhpqvgP0zjW17hQ==
X-Received: by 2002:a05:6a00:1352:b0:50d:ecff:f06c with SMTP id k18-20020a056a00135200b0050decfff06cmr23674727pfu.6.1652246455250;
        Tue, 10 May 2022 22:20:55 -0700 (PDT)
Received: from hyeyoo ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id e186-20020a621ec3000000b0050dc7628171sm517238pfe.75.2022.05.10.22.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 22:20:54 -0700 (PDT)
Date:   Wed, 11 May 2022 14:20:45 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz,
        akpm@linux-foundation.org, mgorman@techsingularity.net,
        willy@infradead.org
Subject: Is _PAGE_PROTNONE set only for user mappings?
Message-ID: <YntHrTX12TGp35aF@hyeyoo>
References: <20220506051940.156952-1-42.hyeyoo@gmail.com>
 <56f89895-601e-44c9-bda4-5fae6782e27e@amd.com>
 <YnpTHMvOO/pLJQ+l@hyeyoo>
 <5fe161cb-6c55-6c4d-c208-16c77e115d3f@amd.com>
 <8c2735ac-0335-6e2a-8341-8266d5d13c30@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c2735ac-0335-6e2a-8341-8266d5d13c30@intel.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 07:39:30AM -0700, Dave Hansen wrote:
> On 5/10/22 06:35, Tom Lendacky wrote:
> > I'm wondering if adding a specific helper that takes a boolean to
> > indicate whether to set the global flag would be best. I'll let some of
> > the MM maintainers comment about that.
> 
> First of all, I'm not positive that _PAGE_BIT_PROTNONE is ever used for
> kernel mappings.  This would all get a lot easier if we decided that
> _PAGE_BIT_PROTNONE is only for userspace mappings and we don't have to
> worry about it when _PAGE_USER is clear.

After quickly skimming code it seems the place that actually sets _PAGE_PROTNONE
is via mm/mmap.c's protection_map:

> /* description of effects of mapping type and prot in current implementation.
>  * this is due to the limited x86 page protection hardware.  The expected
>  * behavior is in parens:
>  *
>  * map_type     prot
>  *              PROT_NONE       PROT_READ       PROT_WRITE      PROT_EXEC
>  * MAP_SHARED   r: (no) no      r: (yes) yes    r: (no) yes     r: (no) yes
>  *              w: (no) no      w: (no) no      w: (yes) yes    w: (no) no
>  *              x: (no) no      x: (no) yes     x: (no) yes     x: (yes) yes
>  *              
>  * MAP_PRIVATE  r: (no) no      r: (yes) yes    r: (no) yes     r: (no) yes
>  *              w: (no) no      w: (no) no      w: (copy) copy  w: (no) no
>  *              x: (no) no      x: (no) yes     x: (no) yes     x: (yes) yes
>  *
>  */
> pgprot_t protection_map[16] = { 
>        __P000, __P001, __P010, __P011, __P100, __P101, __P110, __P111,
>        __S000, __S001, __S010, __S011, __S100, __S101, __S110, __S111
> };

Where __P000, __S000 is PAGE_NONE (_PAGE_ACCESSED | _PAGE_PROTNONE).

And protection_map is accessed via:
> pgprot_t vm_get_page_prot(unsigned long vm_flags)
> {
>        pgprot_t ret = __pgprot(pgprot_val(protection_map[vm_flags &
>                                (VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)]) |
>                        pgprot_val(arch_vm_get_page_prot(vm_flags)));
>
>        return arch_filter_pgprot(ret);
> }
> EXPORT_SYMBOL(vm_get_page_prot);

I guess it's only set for processes' VMA if no caller is abusing
vm_get_page_prot() for kernel mappings.

But yeah, just quick guessing does not make us convinced.
Let's Cc people working on mm.

If kernel never uses _PAGE_PROTNONE for kernel mappings, it's just okay
not to clear _PAGE_GLOBAL at first in __change_page_attr() if it's not user address,
because no user will confuse _PAGE_GLOBAL as _PAGE_PROTNONE if it's kernel
address. right?

> 
> Second, the number of places that do these
> __set_pages_p()/__set_pages_np() pairs is pretty limited.  Some of them
> are *quite* unambiguous over whether they are dealing with the direct map:
> 
> > int set_direct_map_invalid_noflush(struct page *page)
> > {
> >         return __set_pages_np(page, 1);
> > }
> > 
> > int set_direct_map_default_noflush(struct page *page)
> > {
> >         return __set_pages_p(page, 1);
> > }
> 
> which would make it patently obvious whether __set_pages_p() should
> restore the global bit.  That would have been a problem in the "old" PTI
> days where _some_ of the direct map was exposed to Meltdown.  I don't
> think we have any of those mappings left, though.  They're all aliases
> like text and cpu_entry_area.
>
> It would be nice if someone could look into unraveling
> _PAGE_BIT_PROTNONE.  We could even probably move it to another bit for
> kernel mappings if we actually need it (I'm not convinced we do).

-- 
Thanks,
Hyeonggon
