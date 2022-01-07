Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27263487BA3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 18:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348642AbiAGRtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 12:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiAGRtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 12:49:08 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4C9C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 09:49:08 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id u13so18134576lff.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 09:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EOrXK/pt2KxH00sPOIrT/imjYzgNcf0g9PVSApWES1E=;
        b=MLp6hFszY0sDHzT3/qGAiJPGJvsWDGhmQ8So6ahRd6S9cLvDngxOLdIAiB/iA3eZ4m
         x0Cu5AE18Jjzfc5gQe/SxnhYXeExacdDBGxzbKjPaG0l3t31yInvnhB5UEMUYauqw8jZ
         EBnJ9CLEOdTp7970IlwIVVyadpx5N2j/wWdJfJlYr55Oyk1rmf8SQVpYefOeYLoqbiog
         PS2caBn3Gu3hkXIh+iglfgT2P1vmc+siDWhZr7v319k6fPWbmNPonK63P1B/Ctng/n6b
         CxD2SvQdn2XkqKpGUXTj8g+KO428eBvsXAc/wo5RodE/AD3mI/XtJO8n1WkzKAOQL7XC
         boNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EOrXK/pt2KxH00sPOIrT/imjYzgNcf0g9PVSApWES1E=;
        b=jb4mK9ugYCZFu9aKNwai1hWzNmNQppWNISDECE1aPUVrDvwur52IyqJKb5Kb59f4ck
         8ZKZG0x6pxApxLedL+iNTeKC/k5q4rDQDcVhllPftBYwv0qnKJ8YgeBnkKqkljhZt9I/
         a/j76EVhooH01g8dg0RPLTWDg7XA5Y0eTCQfqbEUjFTSZP70fsSl5FI8mh+0jLKbDdb6
         oDH0gqQ4sLDjMvTTNq6CmQknE6mFllxctPYuw+3oL8HFow6td7hZy6zBqiHzcrBhhnO8
         +0/bA3DE/x2J68CmXiEUjgFK+ZA+F2Lp6/dlIcS98GZ8t3gwIoa0NL4/PquDiJ7hgQJW
         CDiw==
X-Gm-Message-State: AOAM533SpF1IZd5UDxuLwPREYEyTeeVtwXjFIrKGgPPnUHs0q/zSlue4
        boFMzvHfveznLedZMJBH0mj0xw==
X-Google-Smtp-Source: ABdhPJw1fo7tfqR1pz1cCRi/nrv/myNBYQYAmnlVL2Kuihn6xeVZIO634cyKSm485CiFcq5ILFuptw==
X-Received: by 2002:a19:5201:: with SMTP id m1mr55046197lfb.367.1641577746454;
        Fri, 07 Jan 2022 09:49:06 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id i7sm655597lfr.299.2022.01.07.09.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 09:49:05 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 4DB42104542; Fri,  7 Jan 2022 20:49:26 +0300 (+03)
Date:   Fri, 7 Jan 2022 20:49:26 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Borislav Petkov <bp@alien8.de>
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
Message-ID: <20220107174926.rh35qcyhu6u2tkzw@box.shutemov.name>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
 <20211214150304.62613-9-kirill.shutemov@linux.intel.com>
 <YdV1BpMiAUGrwASv@zn.tnic>
 <20220105154311.bocij4mwbga4t2hb@box.shutemov.name>
 <YdhEQTnm+XMxoDPW@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdhEQTnm+XMxoDPW@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 02:46:41PM +0100, Borislav Petkov wrote:
> On Wed, Jan 05, 2022 at 06:43:11PM +0300, Kirill A. Shutemov wrote:
> > Not encrypted, saved/restored by TDX module. But yes, cannot be exposed
> > (without guest intend).
> > 
> > I talk here about *why* the traditional way to handle MMIO -- on VMM side
> > -- doesn't work for TDX. It's not safe with untrusted VMM.
> 
> Lemme see if I understand this correctly: TDX module saves/restores
> guest registers so a malicious hypervisor cannot access them? And that's
> why you can't do the traditional way MMIO is done?

To emulate an instruction the emulator needs two things:

  - R/W access to the register file to read/modify instruction arguments
    and see RIP of the faulted instruction.

  - Read access to memory where instruction is placed to see what to
    emualte. In this case it is guest kernel text.

Both of them are not available to VMM in TDX environment:

  - Register file is never exposed to VMM. When a TD exits to the module,
    it saves registers into the state-save area allocated for that TD.
    The module then scrubs these registers before returning execution
    control to the VMM, to help prevent leakage of TD state.

  - Memory is encrypted TD-private key. The CPU disallows software other
    than the TDX module and TDs from making memory accesses using the
    private key.
> 
> > readX()/writeX() helpers limit the range of instructions which can trigger
> > MMIO. It makes MMIO instruction emulation feasible. Raw access to MMIO
> > region allows compiler to generate whatever instruction it wants.
> > Supporting all possible instructions is a task of a different scope.
> 
> Yap, please add that to the commit message.

Okay.

-- 
 Kirill A. Shutemov
