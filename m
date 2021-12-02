Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF4E14669CB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 19:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376611AbhLBSaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 13:30:19 -0500
Received: from mail.skyhub.de ([5.9.137.197]:41436 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235498AbhLBSaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 13:30:18 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 51E8A1EC0545;
        Thu,  2 Dec 2021 19:26:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1638469610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=IKiIPj9jcXZHi0UaadNnk9AdT5NMb4JVaPkx3+dAlgc=;
        b=ODDDTkhuLtwubeaMu1DPHsJvlmG75MawdrrZN5W1je20MCKEdp64red03dptdOvs6roLDs
        LXfBQ8+9/wBgFJEMv608gARTegHNWRFK9N58AQtpgyRSMtgIhQjOtOF/fGs+L71jGd0xKQ
        C11Jbb4UpvgUKHvgFC1A13Lds0tw2wA=
Date:   Thu, 2 Dec 2021 19:26:58 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, hpa@zytor.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brijesh Singh <brijesh.singh@amd.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] x86/mm: Flush global TLB when switching to
 trampoline page-table
Message-ID: <YakP8vPPcm71oQqj@zn.tnic>
References: <20211001154817.29225-1-joro@8bytes.org>
 <20211001154817.29225-4-joro@8bytes.org>
 <YXki1Zx4jCmikBuf@zn.tnic>
 <YajDC/tgx7qR/UcW@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YajDC/tgx7qR/UcW@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 01:58:51PM +0100, Joerg Roedel wrote:
> Okay, but in the caller it is not visible the CR4.PCID is disabled in
> this function. I'd rather update the comment to tell that the function
> is called before transitioning to real mode?

Well, if something calls load_trampoline_pgtable(), it kinda assumes
that if it wants that that function will do all the necessary steps to
load it, including clearing PCIDE.

Why does the caller even need to know that that function clears
CR4.PCIDE?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
