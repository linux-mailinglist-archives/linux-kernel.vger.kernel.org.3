Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963AE4DA36E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 20:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350719AbiCOToq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 15:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351449AbiCOTon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 15:44:43 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D657033882
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 12:43:27 -0700 (PDT)
Received: from zn.tnic (p5de8e440.dip0.t-ipconnect.de [93.232.228.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 51D461EC04AD;
        Tue, 15 Mar 2022 20:43:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1647373402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=DdXlmQwuyC+sPRsD469XJsY3XWqM5u/DZbryZN2pSZQ=;
        b=VaBY2Z4nzEOzA1DIGqTaXQci4sHaCX+eSLT7CRNbIUL3w4hlzXVmnH/ssdXfHJg1Zdn4W0
        VXNg3tUlzOhI2W3OZioxdJ9ZxXyPuCJnxXNlV86d8VzLlF4HuIO8tvpkcCld1yTnIHwQDy
        f/mOOGt/+kkIgWGxA7dHj+wGBxcVJe0=
Date:   Tue, 15 Mar 2022 20:41:08 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     dave.hansen@intel.com, aarcange@redhat.com, ak@linux.intel.com,
        brijesh.singh@amd.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, sdeep@vmware.com,
        seanjc@google.com, tglx@linutronix.de, thomas.lendacky@amd.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org
Subject: Re: [PATCHv5.2 04/30] x86/tdx: Extend the confidential computing API
 to support TDX guests
Message-ID: <YjDr1F+/xVAtOAKv@zn.tnic>
References: <79432a51-4d26-1fcb-81f2-6a9e7a44706f@intel.com>
 <20220309235121.33236-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220309235121.33236-1-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 02:51:21AM +0300, Kirill A. Shutemov wrote:
> diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
> index fc1365dd927e..6529db059938 100644
> --- a/arch/x86/coco/core.c
> +++ b/arch/x86/coco/core.c
> @@ -87,9 +87,18 @@ EXPORT_SYMBOL_GPL(cc_platform_has);
>  
>  u64 cc_mkenc(u64 val)
>  {
> +	/*
> +	 * Both AMD and Intel use a bit in page table to indicate encryption

"... a bit in the page table ..."

> +	 * status of the page.
> +	 *
> +	 * - for AMD, bit *set* means the page is encrypted
> +	 * - for Intel *clear* means encrypted.
> +	 */
>  	switch (vendor) {
>  	case CC_VENDOR_AMD:
>  		return val | cc_mask;
> +	case CC_VENDOR_INTEL:
> +		return val & ~cc_mask;
>  	default:
>  		return val;
>  	}

With that fixed:

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
