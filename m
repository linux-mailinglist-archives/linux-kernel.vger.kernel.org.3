Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C2F52AE40
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 00:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbiEQWkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 18:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbiEQWkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 18:40:20 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7FD43EC9
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 15:40:19 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id bo5so430154pfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 15:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=auGGP9hSqu/zyX82WeVpcnq0XvJWTzPrysxZ8hpBnF8=;
        b=JosQQTx6C7AcoVPpV3vaP0tjDU6drR0IhjBE0YPqb0tQPKNWM/ljnKBIXGfyXRoKsb
         klteyrXM6clwiR62ZC5r6YLOX4RHCl0sVYmcXvsKgiVeUVZulbIGXpJ1wNE1d5lXOBqg
         OTua7imTcqnH9meqgv19nDSaDPZawCLvq1a3F5SbIkIHEaaC6T3nHoSwgJfgX1nk6PxG
         P4Vfy5Vue7tdMYWF4rx1XCt9+Fc5GB+BZV3zm3rm1HFDB2d/wWocrOpnvW6vL7ModADw
         EErW2dY9Z7DqGU+r2O8vHM3pki3f9QorSm2+L7C0eMrivnbiYxSD3tMTjXFdnsItU2SA
         8wSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=auGGP9hSqu/zyX82WeVpcnq0XvJWTzPrysxZ8hpBnF8=;
        b=bpi83mUPVcFlBcnDKEHCwDxufogQ5LX0sG/KdVKqoYKmj8KTdMXzwFtYkxUMvysYip
         vHj0g75oG7whJDkRWfPd6Cgiuo0Ix0+l0/CVkpMr5kGyR4/w8xDo6F4624gxhlTfJ161
         /dp36lx58MOcKR9QN5DSQiu4DLNEm+armJxRRksR6QnYxxvNcqPpLJbhyX8YIXM5Uq4h
         qKVGnGqox/8SgikNtXYi8QShfF03Q84sjmWAsK4a+t448xmxOlj7B+X9V5Yc7i9tSEjP
         eWAnK0GN8H7IgKZf/a1fF3xH/aXL5+K1UkP8bZ58inz2reoYvS3u05BbTZn8RV1A6QNq
         ++XQ==
X-Gm-Message-State: AOAM532f2N009vQCcIjuyKwoxSs0Duv5QZw2A5UZb7s0UvX73HMfMowW
        N8q31LOPC8CHctor+XSHC8WCYA==
X-Google-Smtp-Source: ABdhPJzWoZBSggHALeI9rJpbFu52hwnh43g2+v9NoZhfnSmwHRI1/kpW3V+kr/8FIk3m2JdfNS7jRw==
X-Received: by 2002:a62:3881:0:b0:4b0:b1c:6fd9 with SMTP id f123-20020a623881000000b004b00b1c6fd9mr24561795pfa.27.1652827218747;
        Tue, 17 May 2022 15:40:18 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id m11-20020a17090a7f8b00b001cd4989fee6sm2135422pjl.50.2022.05.17.15.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 15:40:17 -0700 (PDT)
Date:   Tue, 17 May 2022 22:40:14 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, ak@linux.intel.com,
        dan.j.williams@intel.com, david@redhat.com, hpa@zytor.com,
        thomas.lendacky@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/tdx: Handle load_unaligned_zeropad() page-cross to a
 shared page
Message-ID: <YoQkTtrMiU2bff9i@google.com>
References: <20220517153021.11116-1-kirill.shutemov@linux.intel.com>
 <e73cb19e-7dab-2fc1-b947-fac70fd607d2@intel.com>
 <20220517174042.v6s7wm3u5j2ebaoq@black.fi.intel.com>
 <c761e774-8014-6fa9-cf21-e7cd8f7aca54@intel.com>
 <20220517201710.ixbpsaga5jzvokvy@black.fi.intel.com>
 <083519ab-752f-9815-7741-22b3fcc03322@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <083519ab-752f-9815-7741-22b3fcc03322@intel.com>
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

On Tue, May 17, 2022, Dave Hansen wrote:
> On 5/17/22 13:17, Kirill A. Shutemov wrote:
> >>> Given that we had to adjust IP in handle_mmio() anyway, do you still think
> >>> "ve->instr_len = 0;" is wrong? I dislike ip_adjusted more.
> >> Something is wrong about it.
> >>
> >> You could call it 've->instr_bytes_to_handle' or something. Then it
> >> makes actual logical sense when you handle it to zero it out.  I just
> >> want it to be more explicit when the upper levels need to do something.
> >>
> >> Does ve->instr_len==0 both when the TDX module isn't providing
> >> instruction sizes *and* when no handling is necessary?  That seems like
> >> an unfortunate logical multiplexing of 0.
> > For EPT violation, ve->instr_len has *something* (not zero) that doesn't
> > match the actual instruction size. I dig out that it is filled with data
> > from VMREAD(0x440C), but I don't know where is the ultimate origin of the
> > data.
> 
> The SDM has a breakdown:
> 
> 	27.2.5 Information for VM Exits Due to Instruction Execution
> 
> I didn't realize it came from VMREAD.  I guess I assumed it came from
> some TDX module magic.  Silly me.
> 
> The SDM makes it sound like we should be more judicious about using
> 've->instr_len' though.  "All VM exits other than those listed in the
> above items leave this field undefined."  Looking over
> virt_exception_kernel(), we've got five cases from CPU instructions that
> cause unconditional VMEXITs:

None of the below exit unconditionally.

>         case EXIT_REASON_HLT:
>         case EXIT_REASON_MSR_READ:
>         case EXIT_REASON_MSR_WRITE:
>         case EXIT_REASON_CPUID:
>         case EXIT_REASON_IO_INSTRUCTION:
> 
> and should have that field filled out, plus one that doesn't:
> 
>         case EXIT_REASON_IO_INSTRUCTION:

I/O fills the length.  IN, INS, OUT, and OUTS are all listed.  It's not just
unconditional exits that provide the instruction length.  The instruction length
is provided if the instruction is the direct cause of the exit, whether or not
the instruction exits unconditionally doesn't matter.

  For fault-like VM exits due to attempts to execute one of the following
  instructions that cause VM exits unconditionally or based on the settings of
  VM-execution controls.

> Then handle_mmio() can say:
> 
> 	/*
> 	 * VM-exit instruction length is not provided for the EPT
> 	 * violations that MMIO causes.  Use the insn_decode() length:

This is inaccurate.  The instruction length _is_ provided on EPT Violation VM-Exits
(it's also provided by all Intel CPUs on EPT Misconfigs even though the SDM doesn't
say so).

The instruction length is wrong in the TDX case because there is no EPT Violation
VM-Exit.  The EPT Violation is morphed to a #VE by the CPU, and the instruction
length isn't one of the fields that's saved into the #VE info struct by the CPU.
When the TDX Module gets control on the TDCALL, VMCS.INSTRUCTION_LENGTH will hold
the length of the TDCALL, not the instruction that caused the #VE, i.e. the TDX
Module can't provide the correct length.

For all other #VE cases in TDX, the #VE is injected by software (TDX module) after
the instruction-based VM-Exit.  Before injecting the #VE, the TDX module grabs the
length from the VMCS and manually records it in the #VE info struct.

