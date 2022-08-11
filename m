Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A54590734
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 22:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbiHKUDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 16:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiHKUDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 16:03:16 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829619BB70
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 13:03:15 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id w14so17813610plp.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 13:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=5DXPg8t4nKLD1PTzgaCTQkm5JKH0KySmWKOFVHH9klU=;
        b=kDq4XVu1WdZw2CbWPKdUEkyk4G/oDO4pKstTlT0pq3kUBzkBAO8J+qPcOQ5ne6I0Y4
         PvLW4AB+bLogHUX0g5we958xznnreN3VPoof6XeOBLptTMXXy7R3xxxWtDsuSJBJLMUD
         yD+B1mtQV3h6AwVQG8cZPFucsdCloto60Bi26jdTyZWRXPs/Upu8NHKga6EHOXMMpy5H
         Pt2Z/Y8Q/hx95JJ9zw0qrBre/JRVh9GEdkrVFHxyPQnssEt2iaZQ6WWqXY02y/8tT3rF
         Fa6WBnh2fEMDMUUSjBUEkNpO/bOgb9B1jzFduyRFbFRL/WntNnoo5E1HT3flT/wiFAia
         IEoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=5DXPg8t4nKLD1PTzgaCTQkm5JKH0KySmWKOFVHH9klU=;
        b=SWpRQATCdEU6XQEee5WGrA1Fzg9F7E71aUIuCTT+Q31vsLk8B3tykCjG2eZOh+qFgL
         Krvo675HORE/E9nQqDFM7zxV3YPmBwx+kOt/Bcr7aVBg56L6F84TgkeC0Fw9d5hDVO4J
         NG7O0ivhUR8y8E7ZEXqfjsXugHSOtEYCv0c9clHwNO7bCiyYi2Y6esZbNl/h+AlSQJ2Z
         xh1nLhWKbzsWkAu4Zb6PNBH1kBLgL0RZpnxAZdJJZ5NQLKuqg1UVR+kRcbjHNLLFCmL8
         Zl7//QZCZcPkMWClNHQID3hVDsIk9vozvQnT2i1dMsQbFwhlkOjU6H1+JFZpBTFeaOAw
         IXeg==
X-Gm-Message-State: ACgBeo0F7/7celHuHLFFa2kVvkIu50pLVryCYg3Y38mZeE8ostMBmheh
        Sg4R8uBwuI36hTiZSkvMdcDqiA==
X-Google-Smtp-Source: AA6agR5Qw0Z88nTMdWqhmOFkd9zZDudVEqKx2PqZ66q85bdBiDssLxxztecMw08FFG+Ey1YgjhQAZg==
X-Received: by 2002:a17:90a:c283:b0:1f8:a3e3:f937 with SMTP id f3-20020a17090ac28300b001f8a3e3f937mr6078665pjt.141.1660248194849;
        Thu, 11 Aug 2022 13:03:14 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id a16-20020a170902ecd000b0016d295888e3sm44460plh.241.2022.08.11.13.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 13:03:14 -0700 (PDT)
Date:   Thu, 11 Aug 2022 20:03:11 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Adam Dunlap <acdunlap@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ben Dooks <ben-linux@fluff.org>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Jacob Xu <jacobhxu@google.com>,
        Alper Gun <alpergun@google.com>, Marc Orr <marcorr@google.com>
Subject: Re: [PATCH] x86/asm: Force native_apic_mem_read to use mov
Message-ID: <YvVgfx+hah/V+r5n@google.com>
References: <20220811180010.3067457-1-acdunlap@google.com>
 <YvVYDn1JODiu6hKK@google.com>
 <AB38B5DA-D3AC-4568-A8DD-FC281DDE261A@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AB38B5DA-D3AC-4568-A8DD-FC281DDE261A@zytor.com>
X-Spam-Status: No, score=-14.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022, H. Peter Anvin wrote:
> On August 11, 2022 12:27:10 PM PDT, Sean Christopherson <seanjc@google.com> wrote:
> >On Thu, Aug 11, 2022, Adam Dunlap wrote:
> >> Previously, when compiled with clang, native_apic_mem_read gets inlined
> >> into __xapic_wait_icr_idle and optimized to a testl instruction. When
> >> run in a VM with SEV-ES enabled, it attempts to emulate this
> >> instruction, but the emulator does not support it. Instead, use inline
> >> assembly to force native_apic_mem_read to use the mov instruction which
> >> is supported by the emulator.
> >> 
> >> Signed-off-by: Adam Dunlap <acdunlap@google.com>
> >> Reviewed-by: Marc Orr <marcorr@google.com>
> >> Reviewed-by: Jacob Xu <jacobhxu@google.com>
> >> ---
> >>  arch/x86/include/asm/apic.h | 13 ++++++++++++-
> >>  1 file changed, 12 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
> >> index 3415321c8240..281db79e76a9 100644
> >> --- a/arch/x86/include/asm/apic.h
> >> +++ b/arch/x86/include/asm/apic.h
> >> @@ -109,7 +109,18 @@ static inline void native_apic_mem_write(u32 reg, u32 v)
> >>  
> >>  static inline u32 native_apic_mem_read(u32 reg)
> >>  {
> >> -	return *((volatile u32 *)(APIC_BASE + reg));
> >> +	volatile u32 *addr = (volatile u32 *)(APIC_BASE + reg);
> >> +	u32 out;
> >> +
> >> +	/*
> >> +	 * Functionally, what we want to do is simply return *addr. However,
> >> +	 * this accesses an MMIO which may need to be emulated in some cases.
> >> +	 * The emulator doesn't necessarily support all instructions, so we
> >> +	 * force the read from addr to use a mov instruction.
> >> +	 */
> >> +	asm_inline("movl %1, %0" : "=r"(out) : "m"(*addr));
> >> +
> >> +	return out;
> >
> >Can't this just be:
> >
> >	return readl((void __iomem *)(APIC_BASE + reg));
> 
> The very point of the patch is to force a specific instruction sequence.

Yes, and that specific emulator-friendly instruction also has to be forced for all
of the core x86 read/write MMIO helpers.  And it's also possible for MMIO read/write
to be enlightened to skip the MOV and go straight to #VMGEXIT, i.e. the xAPIC code
shouldn't assume MOV is the best/only option (ignoring the handling of the P54C
erratum in the write path).
