Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96EE652F13B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 19:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351998AbiETRBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 13:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347721AbiETRBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 13:01:30 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237785B888
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 10:01:29 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id j21so8024425pga.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 10:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RoNlLsxylgzgfC69nMQmi2zqf9LwL+coM7x4S8s5JZU=;
        b=GqW33ZAcWSgnmPnsDNTzHj8eFw1OlXO41V4KOwhggIsr+RHna+goh91gIrp1Zt/Yw1
         WAct4MSoa20UhWbJu9eLYDWm70hNonEgv8a345DBzuCLZli3Mu/vzHUopsPGXzS6nz8C
         9oOlpWpcWi+Hcs0mmakoAPmILxCeJ5KkJn+iNTCbugRfojTDqvfCtfOReqzPOEVZz/dF
         6zLGpO7yIv9snyFFjnsomeN90+7jM+b02bDTkBNOj4h2gApxhL62wuTVVYRI4DA99gR2
         i+U/qF24B0zOFBt/QmmvJXWhQPjkXLl/yfx26VSeOMpjooCXI5UJ1tQZQ+ilHW95KqN/
         ZH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RoNlLsxylgzgfC69nMQmi2zqf9LwL+coM7x4S8s5JZU=;
        b=LfNWKOd0lD3ttqR+vmmROctabnM+XUK+PlZH0md6VJTtP7MFEfDkeHFfknxkIGbMoA
         J1geTSTpXW/eh2n2G4ckEcnz6I41U1wbpl1iSD+4Us4zt+eLAkEz6zdD36wCnXZlPGoO
         +ILnEHyFRHDF/Am/x2qc3cKbTOwaYf1M2RJm/NAmTcBK5RLBubLrlGiaEEdvbdpmRVMl
         WWR0Va3ct6myonvhHfr2a3TP0Vt8E4FfrDB3fi3cQ4OicfHRVkSfdC1ysAR49o+mZqHj
         /+/UMTobfWcDP1IgIdZ7olWn7CIxEiNQWhsWr9n5jff3mYwr8hZ7DT+3oCcesAqWooOT
         n+MA==
X-Gm-Message-State: AOAM530+m4Z3LNH0nnAEH/LSX+cGFM6vCardeS7IJMY5C3GccmwkW0QX
        EsEx0ju+4OPuR88cFkhDTGRmng==
X-Google-Smtp-Source: ABdhPJyqYUStJcHWGBFrZZbtKzjsFone927lyRoEAHG1uTo7CYH1wWjYiMR1anQTgESqFt2nD+UtsQ==
X-Received: by 2002:a63:84c8:0:b0:3f9:c7cb:aedb with SMTP id k191-20020a6384c8000000b003f9c7cbaedbmr1796305pgd.603.1653066088440;
        Fri, 20 May 2022 10:01:28 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id h20-20020aa786d4000000b00518389cfba9sm2122216pfo.21.2022.05.20.10.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 10:01:26 -0700 (PDT)
Date:   Fri, 20 May 2022 17:01:22 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        thomas.lendacky@amd.com, x86@kernel.org
Subject: Re: [PATCHv2 1/3] x86/tdx: Fix early #VE handling
Message-ID: <YofJYpBLeyNsuw5W@google.com>
References: <20220520031316.47722-1-kirill.shutemov@linux.intel.com>
 <20220520031316.47722-2-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520031316.47722-2-kirill.shutemov@linux.intel.com>
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
> Move RIP in tdx_early_handle_ve() after handling the exception. Failure
> to do that leads to infinite loop of exceptions.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Fixes: 32e72854fa5f ("x86/tdx: Port I/O: Add early boot support")
> ---
>  arch/x86/coco/tdx/tdx.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 03deb4d6920d..faae53f8d559 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -447,13 +447,17 @@ static bool handle_io(struct pt_regs *regs, u32 exit_qual)
>  __init bool tdx_early_handle_ve(struct pt_regs *regs)
>  {
>  	struct ve_info ve;
> +	bool ret;
>  
>  	tdx_get_ve_info(&ve);
>  
>  	if (ve.exit_reason != EXIT_REASON_IO_INSTRUCTION)
>  		return false;
>  
> -	return handle_io(regs, ve.exit_qual);
> +	ret = handle_io(regs, ve.exit_qual);
> +	if (ret)

Ugh, the boolean returns instead of 0/-errno are fugly.  At first glance I thought
this was wrong, i.e. advancing RIP on failure.

Assuming moving away from booleans isn't happening anytime soon maybe s/ret/success
or s/ret/handled to make it more obvious that it's a happy path?
