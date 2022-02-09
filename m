Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0442D4AFD01
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 20:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiBITMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 14:12:54 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbiBITMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 14:12:46 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C4AC02B65C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 11:12:38 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6AE1A1EC0576;
        Wed,  9 Feb 2022 20:12:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644433922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=v5XkO5vEJiccQUAW/+IchFJcN9nJFlnPd8upgP+e0Rw=;
        b=ZgE0b4xJsN/Pzn0SzHw7GXJuagDjWhZajqiyUEyjV3Teaml9bbLZLFlRU4pXPCLDTp+b1B
        4Yzafm/lWBpH2yUNh85or9sB3Qy4bIzYtg5u619DuqXKeWJUpzpQcvwT6pLU9lYRVnR58P
        lnof3n14KcMLuM0QcMnm24VmcRNYuME=
Date:   Wed, 9 Feb 2022 20:11:57 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Kai Huang <kai.huang@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, tony.luck@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 00/29] TDX Guest: TDX core support
Message-ID: <YgQR/S67Fqz9PanR@zn.tnic>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220209235613.652f5720cd196331d7a220ec@intel.com>
 <YgOgog9Pb886lfsv@zn.tnic>
 <20220210003033.e57c2925b69bab5cfabf7292@intel.com>
 <YgOoId+vyd1VhIqQ@zn.tnic>
 <20220210004831.03dea501738bee060003d040@intel.com>
 <YgOr6tZjsooJgAi9@zn.tnic>
 <YgPwwI2+16/7jQC4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YgPwwI2+16/7jQC4@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 04:50:08PM +0000, Sean Christopherson wrote:
> On Wed, Feb 09, 2022, Borislav Petkov wrote:
> > On Thu, Feb 10, 2022 at 12:48:31AM +1300, Kai Huang wrote:
> > > Are you suggesting even for now we can start to put TDX host support to
> > > arch/x86/coco/tdx/ ?
> > 
> > That's exactly what I'm suggesting. The TDX stuff is not upstream so
> > nothing's cast in stone yet. This way there won't be any unpleasant code
> > movements later.
> 
> I strongly prefer we put the guest and host code in separate directories.  Both
> TDX and SEV are big enough that they'll benefit from splitting up files, having
> to fight over file names or tag all files with guest/host will get annoying.
> 
> I do like the idea of arch/x86/coco though.  The most straightforward approach
> would be:
> 
>   arch/x86/coco/guest/
>   arch/x86/coco/host/
> 
> but that doesn't provide any extensibility on the host virtualization side, e.g.
> to land non-coco, non-KVM-specific host virtualization code (we have a potential
> use case for this).  If that happens, we'd end up with x86 KVM having code and
> dependencies split across:
> 
>   arch/x86/coco/host
>   arch/x86/kvm/
>   arch/x86/???/
> 
> An alternative idea would be to mirror what generic KVM does (virt/kvm/), and do:
> 
>   arch/x86/coco/<guest stuff>
>   arch/x86/virt/<"generic" x86 host virtualization stuff>
>   arch/x86/virt/coco/<host coco stuff>
>   arch/x86/virt/kvm/
> 
> Though I can already hear the stable trees and downstream kernels crying out in
> horror at moving arch/x86/kvm :-)

Hmmm, so I am still thinking about guest-only when we're talking about
arch/x86/coco/.

Lemme look at the other virt things:

the kvm host virt stuff is in:

arch/x86/kvm/

 (btw, this is where the SEV host stuff is: arch/x86/kvm/svm/sev.c)

arch/x86/hyperv/ - looks like hyperv guest stuff

arch/x86/xen/ - xen guest stuff

arch/x86/kernel/cpu/vmware.c - vmware guest stuff

arch/x86/kernel/cpu/acrn.c - Acorn guest stuff

So we have a real mess. :-(

Not surprised though. So that last thing you're suggesting kinda makes
sense but lemme tweak it a bit:

arch/x86/coco/<guest stuff>
arch/x86/virt/<"generic" x86 host virtualization stuff>
arch/x86/virt/tdx/ - no need for the "coco" thing - TDX is nothing but coco. TDX host
stuff

arch/x86/virt/sev/ - ditto

and we'll keep arch/x86/kvm because of previous precedents with other
things I've enumerated above.

Hmmm?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
