Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF07E525B0B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 07:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377086AbiEMFdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 01:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344254AbiEMFdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 01:33:50 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFB813C360
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 22:33:48 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id v10so6520633pgl.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 22:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=45P3BUfFsVexFqPhisLDrPcZ+PguqAtbUCDFuvnZQ4o=;
        b=hB2VGxySOCnZ6hzyjobSttjhGlnl0ir50A3N6LoQ4kuBhQJ6YzUcI7Rv+4+YiY9YuJ
         UV3Ix2lLblfECTY9EgZrq8ApgqzF4Nx54nW2M3B2vdUTmfifZu3m0IXR1q6xrhrx+qU0
         cj6h14XBi/pT5kesJaE5Nm5/ZyNAhocEHTejsJKGzhWz9eckUPuAeMrujV6gn+8WvSzy
         TFyFE+YSPxvqfEKKrAVJHA6ltMl2LSCfDXBkZvuS6lMR4icYU6l9ZVu13Y0R7eca1NAe
         VEzFNX1mWV047CqnmP8s/JEKVC+ZZ7kFIOUqp5/AVO3O/nDd+wfLRkjNcNGMGrMOAZrq
         H4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=45P3BUfFsVexFqPhisLDrPcZ+PguqAtbUCDFuvnZQ4o=;
        b=evKEXEy7ff0X4R7qMzgn2VgDst8jsq0jc1r1HW0Cbq7XsQEuauX4pOGLxFjT8b9DQh
         0FVz+X77JLj0tb/7xlXxGxVYB79wpBKVXQflhaNHFwC6U53izX2th2OKZf1hcT/JLQjS
         6sx104cBvIQr+g9duqnvQSDu1Wi73CNrkY/VRTVg8F6YGYZ8q58cKrBXftAZOAGWz1hv
         C77U6eBFzwvKpHiMXEcY++rth2DJJn/qUR8IwsOP3UmAK4t8lHQNr0CrObIpPjUXIQcY
         ITYGTtPK9YULhPNkJtitBxeNR71fNS/jyZBh8eEqCvmFFmBvwyFbDanF2W9Jk/OkJCof
         oXLQ==
X-Gm-Message-State: AOAM531slzIA/41LvLaEt+m1BnP56A953xkaqgXCjnTuuVIyT7ZQGIqh
        Q7J5dLkcrXSD1ZfwvHfjfrY=
X-Google-Smtp-Source: ABdhPJwebL5TyNnQJTSZtR36tHTmZ8tsM/2xWDf5AX6T22jen+T0BV3OSEtdFjbWCFxBpNxhNSXOrQ==
X-Received: by 2002:a05:6a00:174a:b0:50d:44ca:4b with SMTP id j10-20020a056a00174a00b0050d44ca004bmr3047546pfc.0.1652420027865;
        Thu, 12 May 2022 22:33:47 -0700 (PDT)
Received: from hyeyoo ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id i17-20020a056a00225100b0050dc7628161sm762640pfu.59.2022.05.12.22.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 22:33:47 -0700 (PDT)
Date:   Fri, 13 May 2022 14:33:38 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
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
        akpm@linux-foundation.org, willy@infradead.org
Subject: Re: Is _PAGE_PROTNONE set only for user mappings?
Message-ID: <Yn3tssUR8w8mC1DJ@hyeyoo>
References: <20220506051940.156952-1-42.hyeyoo@gmail.com>
 <56f89895-601e-44c9-bda4-5fae6782e27e@amd.com>
 <YnpTHMvOO/pLJQ+l@hyeyoo>
 <5fe161cb-6c55-6c4d-c208-16c77e115d3f@amd.com>
 <8c2735ac-0335-6e2a-8341-8266d5d13c30@intel.com>
 <YntHrTX12TGp35aF@hyeyoo>
 <20220512103748.GH3441@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512103748.GH3441@techsingularity.net>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 11:37:48AM +0100, Mel Gorman wrote:
> On Wed, May 11, 2022 at 02:20:45PM +0900, Hyeonggon Yoo wrote:
> > > pgprot_t vm_get_page_prot(unsigned long vm_flags)
> > > {
> > >        pgprot_t ret = __pgprot(pgprot_val(protection_map[vm_flags &
> > >                                (VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)]) |
> > >                        pgprot_val(arch_vm_get_page_prot(vm_flags)));
> > >
> > >        return arch_filter_pgprot(ret);
> > > }
> > > EXPORT_SYMBOL(vm_get_page_prot);
> > 
> > I guess it's only set for processes' VMA if no caller is abusing
> > vm_get_page_prot() for kernel mappings.
> > 
> > But yeah, just quick guessing does not make us convinced.
> > Let's Cc people working on mm.
> > 
> > If kernel never uses _PAGE_PROTNONE for kernel mappings, it's just okay
> > not to clear _PAGE_GLOBAL at first in __change_page_attr() if it's not user address,
> > because no user will confuse _PAGE_GLOBAL as _PAGE_PROTNONE if it's kernel
> > address. right?
> > 
> 
> I'm not aware of a case where _PAGE_BIT_PROTNONE is used for a kernel
> address expecting PROT_NONE semantics instead of the global bit. NUMA
> Balancing is not going to accidentally treat a kernel address as if it's
> a NUMA hinting fault. By the time a fault is determining if a PTE access
> is a numa hinting fault or accesssing a PROT_NONE region, it has been
> established that it is a userspace address backed by a valid VMA.
> 

Thanks Mel, and IIUC nor does do_kern_addr_fault() in arch/x86/mm/fault.c
expect _PAGE_PROTNONE instead of _PAGE_GLOBAL. I want to make it clear
in the code that _PAGE_PROTNONE is only used for user mappings.

How does below look?

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 40497a9020c6..f8d02b91a90c 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -35,7 +35,10 @@
 #define _PAGE_BIT_DEVMAP	_PAGE_BIT_SOFTW4
 
 /* If _PAGE_BIT_PRESENT is clear, we use these: */
-/* - if the user mapped it with PROT_NONE; pte_present gives true */
+/*
+ * if the user mapped it with PROT_NONE; pte_present gives true
+ * this is only used for user mappings (with _PAGE_BIT_USER)
+ */
 #define _PAGE_BIT_PROTNONE	_PAGE_BIT_GLOBAL
 
 #define _PAGE_PRESENT	(_AT(pteval_t, 1) << _PAGE_BIT_PRESENT)
@@ -115,7 +118,8 @@
 #define _PAGE_DEVMAP	(_AT(pteval_t, 0))
 #endif
 
-#define _PAGE_PROTNONE	(_AT(pteval_t, 1) << _PAGE_BIT_PROTNONE)
+#define _PAGE_PROTNONE	((_AT(pteval_t, 1) << _PAGE_BIT_USER) | \
+			 (_AT(pteval_t, 1) << _PAGE_BIT_PROTNONE))
 
 /*
  * Set of bits not changed in pte_modify.  The pte's

-- 
Thanks,
Hyeonggon
