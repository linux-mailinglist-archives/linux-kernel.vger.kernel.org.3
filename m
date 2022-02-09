Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE964AF0B6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbiBIMEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbiBIMDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:03:14 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D913AC033249
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 03:40:27 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4F2D71EC054C;
        Wed,  9 Feb 2022 12:40:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644406822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=YW2m9uiYmForoP7mys5vbamX9CSY0dr8MG2u1gRwbQU=;
        b=It8Diogeg1sUuDhyQoluVuNV7ePec4LRfJpuM0wYVw7nmTBLn+0WfOw6HSCeZjhsL5igSc
        +F8BjOwdhuAatqqH/8UIY8+38kmJWKt8pBwOaB5BXeh89yhXclGRtRLN6Hd+Ta+rabMoVt
        NYyYox4KN1y9RXyQpNQjej5o9oH8FoI=
Date:   Wed, 9 Feb 2022 12:40:17 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Kai Huang <kai.huang@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 00/29] TDX Guest: TDX core support
Message-ID: <YgOoId+vyd1VhIqQ@zn.tnic>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220209235613.652f5720cd196331d7a220ec@intel.com>
 <YgOgog9Pb886lfsv@zn.tnic>
 <20220210003033.e57c2925b69bab5cfabf7292@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220210003033.e57c2925b69bab5cfabf7292@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 12:30:33AM +1300, Kai Huang wrote:
> Because SEAM, P-SEAMLDR can logically be independent, so I feel it's better to
> have separate C files for them.

Most of those look like small files. I don't see the point of having it
all in separate files - you can just as well put them in tdx.c and carve
out only then when the file becomes too unwieldy to handle.

> Thanks for the information.  However, for now does it make sense to also put
> TDX host files under arch/x86/kernel/, or maybe arch/x86/kernel/tdx_host/?

Didn't you just read what I wrote about "kernel"?

> As suggested by Thomas, host SEAMCALL can share TDX guest's __tdx_module_call()
> implementation.  Kirill will have a arch/x86/kernel/tdxcall.S which implements
> the core body of __tdx_module_call() and is supposed to be included by the new
> assembly file to implement the host SEAMCALL function.  From this perspective,
> it seems more reasonable to just put all TDX host files under arch/x86/kernel/?

It would be a lot harder to move them to a different location later,
when they're upstream already. I'm talking from past experience here.

But let's see what the others think first.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
