Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CDB59157F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 20:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238833AbiHLScT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 14:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiHLScQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 14:32:16 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873D0AF0D8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 11:32:15 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-3246910dac3so17842497b3.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 11:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ORIsyUO0VTM3cCQDkfzGyTL3t6ofQrr59k7+5WV0MlE=;
        b=dDQp7SowWnPSZmEJqrKIQ8A8DafQRisivyCnbZVo+Khl8dnmtZ6RmT7/EPNVRtMzYF
         14lWJtjBcn27dUdBwWBcZf40LxdPAcmIiuPtiSECXNIvOyLmJskv2FWInjOG36WU0uM8
         qNtNaBi+wdmBVZprLL5/UMEpgOADm9c+lvi3fnLsPDESzTgOEg5Z9JpyybDzdlwCwcyC
         It26RVZ5vmJdLU4Lu6UbYVB7xn22S/z59UAiDnHRcPJvfNAYDAPu7diKQzhi/yBdd5w7
         Ms9EmgfQ1A9odRFx1S8lKo9+GiI6Zx52y3GDaSpgbMXcvnCahcsnYRZjKQ+slS0AT1Bx
         AinQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ORIsyUO0VTM3cCQDkfzGyTL3t6ofQrr59k7+5WV0MlE=;
        b=ybXx93eQycBAjbMghojqY7IwErZPmxEFU4iPpKFUyG0CWt/WjrhXqC7HlFz5vm18D0
         NKPfrOihhoMDAzmqyEfrbHH9Ri6AwoeJNmKwRMMTtMbo1ZLzu7DnckofejmS7xbLXNcJ
         m/cJX+T74Bw5slhG1yhfyUCda9hB/NtJ7CuaR6oKPk8RMqaXUkaVFbDaPtpkUg9k5/N7
         ce/TK+CFEFii5JJiAYMYpxbTIWS9uE1LHLWVSLroAUW0y04HGgpXDCbT1fpsxg/Dpn0T
         pYaq9LbabuRCs18MAf1VyP3pbAB2Mot+QsqLzA/KT4LbQnN0gn25+rUgLPoABrphbFOb
         kaLg==
X-Gm-Message-State: ACgBeo2vBb7EuX4cMU6dPCOHaN6QX2CL6JJEOD7EWm14fc5stSM2KDJR
        JJhoHVH1sw4h6tLZGtqhcoSyg2/FxExXgft2VnEHVQ==
X-Google-Smtp-Source: AA6agR45OaG4gWA/xB45D5aiX3ywvG7HtNsAOaJpftApMuVTBgr68MEeev9YiXIbdMgKc0XP7nUNzSmo7Aurk/rnNCM=
X-Received: by 2002:a0d:cb50:0:b0:32e:4e5c:a51e with SMTP id
 n77-20020a0dcb50000000b0032e4e5ca51emr5185007ywd.188.1660329134698; Fri, 12
 Aug 2022 11:32:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220811180010.3067457-1-acdunlap@google.com> <YvVYDn1JODiu6hKK@google.com>
 <AB38B5DA-D3AC-4568-A8DD-FC281DDE261A@zytor.com> <YvVgfx+hah/V+r5n@google.com>
 <0D6A1E49-F21B-42AA-BBBF-13BFC308BB1E@zytor.com>
In-Reply-To: <0D6A1E49-F21B-42AA-BBBF-13BFC308BB1E@zytor.com>
From:   Adam Dunlap <acdunlap@google.com>
Date:   Fri, 12 Aug 2022 11:32:02 -0700
Message-ID: <CAMBK9=b1ALFYOB1iTUW7BHgq=sg=x9t8sTnC5YgQ5bePF+UvNg@mail.gmail.com>
Subject: Re: [PATCH] x86/asm: Force native_apic_mem_read to use mov
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Sean Christopherson <seanjc@google.com>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 9:40 PM H. Peter Anvin <hpa@zytor.com> wrote:
>
> On August 11, 2022 1:03:11 PM PDT, Sean Christopherson <seanjc@google.com> wrote:
> >On Thu, Aug 11, 2022, H. Peter Anvin wrote:
> >> On August 11, 2022 12:27:10 PM PDT, Sean Christopherson <seanjc@google.com> wrote:
> >> >On Thu, Aug 11, 2022, Adam Dunlap wrote:
> >> >> Previously, when compiled with clang, native_apic_mem_read gets inlined
> >> >> into __xapic_wait_icr_idle and optimized to a testl instruction. When
> >> >> run in a VM with SEV-ES enabled, it attempts to emulate this
> >> >> instruction, but the emulator does not support it. Instead, use inline
> >> >> assembly to force native_apic_mem_read to use the mov instruction which
> >> >> is supported by the emulator.
> >> >>
> >> >> Signed-off-by: Adam Dunlap <acdunlap@google.com>
> >> >> Reviewed-by: Marc Orr <marcorr@google.com>
> >> >> Reviewed-by: Jacob Xu <jacobhxu@google.com>
> >> >> ---
> >> >>  arch/x86/include/asm/apic.h | 13 ++++++++++++-
> >> >>  1 file changed, 12 insertions(+), 1 deletion(-)
> >> >>
> >> >> diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
> >> >> index 3415321c8240..281db79e76a9 100644
> >> >> --- a/arch/x86/include/asm/apic.h
> >> >> +++ b/arch/x86/include/asm/apic.h
> >> >> @@ -109,7 +109,18 @@ static inline void native_apic_mem_write(u32 reg, u32 v)
> >> >>
> >> >>  static inline u32 native_apic_mem_read(u32 reg)
> >> >>  {
> >> >> - return *((volatile u32 *)(APIC_BASE + reg));
> >> >> + volatile u32 *addr = (volatile u32 *)(APIC_BASE + reg);
> >> >> + u32 out;
> >> >> +
> >> >> + /*
> >> >> +  * Functionally, what we want to do is simply return *addr. However,
> >> >> +  * this accesses an MMIO which may need to be emulated in some cases.
> >> >> +  * The emulator doesn't necessarily support all instructions, so we
> >> >> +  * force the read from addr to use a mov instruction.
> >> >> +  */
> >> >> + asm_inline("movl %1, %0" : "=r"(out) : "m"(*addr));
> >> >> +
> >> >> + return out;
> >> >
> >> >Can't this just be:
> >> >
> >> >    return readl((void __iomem *)(APIC_BASE + reg));
> >>
> >> The very point of the patch is to force a specific instruction sequence.
> >
> >Yes, and that specific emulator-friendly instruction also has to be forced for all
> >of the core x86 read/write MMIO helpers.  And it's also possible for MMIO read/write
> >to be enlightened to skip the MOV and go straight to #VMGEXIT, i.e. the xAPIC code
> >shouldn't assume MOV is the best/only option (ignoring the handling of the P54C
> >erratum in the write path).
>
> That's not reasonable... but xAPIC is "special" enough.

Thanks for your responses. I think for now it makes sense to use the
readl function because
I haven't seen it require the ax register so can't verify the result.
I will send out a modified
patch using readl shortly.
