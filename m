Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04A8487877
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 14:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347669AbiAGNqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 08:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347663AbiAGNqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 08:46:46 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E75DC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 05:46:45 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 124061EC0464;
        Fri,  7 Jan 2022 14:46:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1641563200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=C1pkyHo94BGO/tBMRde+1i2VQ9Ft0h9GgoA41VSbaxM=;
        b=XXjObhAf7T2FHM7XmYB9J9bf+1FK5lvodL7CL1/otDfDlDGR2xN6hcwVN/xTZFCHdjtpmc
        qU1MUWEgRpqJcKhVPUxIxau89v4b7E5IisdRDgHJlEWxzkCrZ/iEH5MMEZsAIRAXAbL61s
        GsL9hH9OHUyj6V2endmuvyz4C3mwRAY=
Date:   Fri, 7 Jan 2022 14:46:41 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
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
Subject: Re: [PATCH 08/26] x86/tdx: Handle in-kernel MMIO
Message-ID: <YdhEQTnm+XMxoDPW@zn.tnic>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
 <20211214150304.62613-9-kirill.shutemov@linux.intel.com>
 <YdV1BpMiAUGrwASv@zn.tnic>
 <20220105154311.bocij4mwbga4t2hb@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220105154311.bocij4mwbga4t2hb@box.shutemov.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 06:43:11PM +0300, Kirill A. Shutemov wrote:
> Not encrypted, saved/restored by TDX module. But yes, cannot be exposed
> (without guest intend).
> 
> I talk here about *why* the traditional way to handle MMIO -- on VMM side
> -- doesn't work for TDX. It's not safe with untrusted VMM.

Lemme see if I understand this correctly: TDX module saves/restores
guest registers so a malicious hypervisor cannot access them? And that's
why you can't do the traditional way MMIO is done?

> readX()/writeX() helpers limit the range of instructions which can trigger
> MMIO. It makes MMIO instruction emulation feasible. Raw access to MMIO
> region allows compiler to generate whatever instruction it wants.
> Supporting all possible instructions is a task of a different scope.

Yap, please add that to the commit message.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
