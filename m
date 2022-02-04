Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFE94A9A4D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 14:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359012AbiBDNuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 08:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235063AbiBDNuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 08:50:10 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58746C061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 05:50:10 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A37441EC0662;
        Fri,  4 Feb 2022 14:50:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643982604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oG61hjWt/E+i7OIsspn7nAQezVhhbhg1afVFCFPtmnY=;
        b=BwEGcIFsfk/C6URpiZbEOrg/423xa+mNsp/WlrmAWys7gk8NAsmAeiz8r1J+zZQBQFd+1B
        WBtUDGgQitOc7wb/hEgKWJpEroBPOFPDICxYU1AxbZiVOBYUZGW3fmIAV4dDkqHdm2Ra+G
        qKuGks9dWSWuwo0KgyduwDbT80kcNl4=
Date:   Fri, 4 Feb 2022 14:49:59 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Kai Huang <kai.huang@intel.com>
Subject: Re: [PATCHv2 16/29] x86/boot: Add a trampoline for booting APs via
 firmware handoff
Message-ID: <Yf0vB+TBR2AjHmV5@zn.tnic>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-17-kirill.shutemov@linux.intel.com>
 <Yfpqk0amEbcyte+w@zn.tnic>
 <25fec256-7feb-e94d-5e37-3a174b6c6a66@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25fec256-7feb-e94d-5e37-3a174b6c6a66@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 03:27:19AM -0800, Kuppuswamy, Sathyanarayanan wrote:
> trampoline_start and sev_es_trampoline_start are not mutually exclusive.
> Both are
> used in arch/x86/kernel/sev.c.

I know - I've asked Jörg to have a look here.

> But trampoline_start64 can be removed and replaced with trampoline_start.
> But using
> _*64 suffix makes it clear that is used for 64 bit(CONFIG_X86_64).
> 
> Adding it for clarity seems to be fine to me.

Does it matter if the start IP is the same for all APs? Or do will there
be a case where you have some APs starting from the 32-bit trampoline
and some from the 64-bit one, on the same system? (that would be weird
but what do I know...)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
