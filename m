Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AECCD52F1DE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 19:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352339AbiETRri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 13:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352326AbiETRrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 13:47:36 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA20D2E68C
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 10:47:35 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id q4so7936065plr.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 10:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lAoFLAZClaXd8fd/V0KTEeUVpBsVq8dDj5Pbr2VssL0=;
        b=aalpFu/MVF1DHHxMs4gLPTt22wEhmmmSjJpxpsUeJNoFTatDlVBeG9q8mD5RPFjrFa
         fMxW8EVAfH+NoGJNNoAHss+R1VHIaeciSsb9y3zZDvpzmF4P7p/VACErvpwfshapsmYh
         N9qwsFt57RwKY1HgNarsE3zgHN0srytox0sr7pjd5AUKXj8g2vvSmLBXiurIDVl0PvP4
         s2uS7dn0o87RzGGVrjHPaS/9i3QtBuGROzap2powOZDQG5KI7RBOIjE76f/OEl93e34N
         CCAIanbV/GmBtc83hkGf/NC2UvrEsS22i+MNyIFOBFRpDcT0yLqVk7//QjalAHPisbnP
         3Qrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lAoFLAZClaXd8fd/V0KTEeUVpBsVq8dDj5Pbr2VssL0=;
        b=hq8vIdEMOA83vpk0pVUMdwblGl0d0yD55gNvzoxlidxDLTw0rw46XAeLSrNdJm/dXk
         ckdh8Fx7qprnXm7l5ZBYfJDnTf1+3P0fAK4NQFQeZAENRBBLs1pgc+kf/cHdRHp8xj46
         M25UH9nxGxFgVffwRmvbWPJUav+hutNzNsFlH7r3QByatCbOoGS/5k0PkThdopWnRZ41
         ZCtfNOxPgHkr/Sw66DdZtql/jEIj+TZf6HJ904s35fqYigtL7e+L7CpTG29Bx9NvhweB
         BhF8twLqeDU1alqDtAqngXx2zMxcjS0XPx75FExhL/hzya1bjS3Xa1E77dWgKEMtLe3K
         wZnQ==
X-Gm-Message-State: AOAM531QVu9yxDb/AwwO7JSWlPOg00zwvyuse7L4eCWU7fdQ0D6hn4cN
        +GgvwGWEi/qMOsa9WJyPaNMW2w==
X-Google-Smtp-Source: ABdhPJydX/9yo/v7KCXD5UJAwqknAqTS/P5C6HV8TfVPNFM/tXt6BP31NoAkClGVBY3TJeM5JApC3g==
X-Received: by 2002:a17:902:cecb:b0:161:bbbf:c45f with SMTP id d11-20020a170902cecb00b00161bbbfc45fmr10867951plg.155.1653068854938;
        Fri, 20 May 2022 10:47:34 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id x21-20020a1709027c1500b0015e8d4eb272sm30850pll.188.2022.05.20.10.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 10:47:34 -0700 (PDT)
Date:   Fri, 20 May 2022 17:47:30 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        thomas.lendacky@amd.com, x86@kernel.org
Subject: Re: [PATCHv2 3/3] x86/tdx: Handle load_unaligned_zeropad()
 page-cross to a shared page
Message-ID: <YofUMlc3ORYZ8if7@google.com>
References: <20220520031316.47722-1-kirill.shutemov@linux.intel.com>
 <20220520031316.47722-4-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520031316.47722-4-kirill.shutemov@linux.intel.com>
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

On Fri, May 20, 2022, Kirill A. Shutemov wrote:
> load_unaligned_zeropad() can lead to unwanted loads across page boundaries.
> The unwanted loads are typically harmless. But, they might be made to
> totally unrelated or even unmapped memory. load_unaligned_zeropad()
> relies on exception fixup (#PF, #GP and now #VE) to recover from these
> unwanted loads.
> 
> In TDX guests, the second page can be shared page and VMM may configure
> it to trigger #VE.
> 
> Kernel assumes that #VE on a shared page is MMIO access and tries to
> decode instruction to handle it. In case of load_unaligned_zeropad() it
> may result in confusion as it is not MMIO access.
> 
> Check fixup table before trying to handle MMIO.
> 
> The issue was discovered by analysis. It was not triggered during the
> testing.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/coco/tdx/tdx.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 010dc229096a..1a1c8a92cfa5 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -11,6 +11,8 @@
>  #include <asm/insn.h>
>  #include <asm/insn-eval.h>
>  #include <asm/pgtable.h>
> +#include <asm/trapnr.h>
> +#include <asm/extable.h>
>  
>  /* TDX module Call Leaf IDs */
>  #define TDX_GET_INFO			1
> @@ -299,6 +301,24 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
>  	if (WARN_ON_ONCE(user_mode(regs)))
>  		return -EFAULT;
>  
> +	/*
> +	 * load_unaligned_zeropad() relies on exception fixups in case of the
> +	 * word being a page-crosser and the second page is not accessible.
> +	 *
> +	 * In TDX guests, the second page can be shared page and VMM may
> +	 * configure it to trigger #VE.
> +	 *
> +	 * Kernel assumes that #VE on a shared page is MMIO access and tries to
> +	 * decode instruction to handle it. In case of load_unaligned_zeropad()
> +	 * it may result in confusion as it is not MMIO access.

The guest kernel can't know that it's not "MMIO", e.g. nothing prevents the host
from manually serving accesses to some chunk of shared memory instead of backing
the shared chunk with host DRAM.

> +	 *
> +	 * Check fixup table before trying to handle MMIO.

This ordering is wrong, fixup should be done if and only if the instruction truly
"faults".  E.g. if there's an MMIO access lurking in the kernel that is wrapped in
exception fixup, then this will break that usage and provide garbage data on a read
and drop any write.

> +	 */
> +	if (fixup_exception(regs, X86_TRAP_VE, 0, ve->gla)) {
> +		/* regs->ip is adjusted by fixup_exception() */
> +		return 0;
> +	}
> +
>  	if (copy_from_kernel_nofault(buffer, (void *)regs->ip, MAX_INSN_SIZE))
>  		return -EFAULT;
>  
> -- 
> 2.35.1
> 
