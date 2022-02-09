Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567AF4AFE94
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 21:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbiBIUhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 15:37:07 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbiBIUhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:37:05 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7188C102FE9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 12:37:07 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1B7CA1EC0576;
        Wed,  9 Feb 2022 21:37:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644439022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3bN14m9k77kQn4q/kQOVP6/l1JRFJq8/BMG6LYEanUg=;
        b=obf4W4vCrdFF3+UlaBCCLjTAt8SSXnYWf4qNoeWRtUdDFCc5kQDk6K2puovSHC1O7SqB59
        uXqiKs9v1tvw0+q6VX0//ZfRrdEOVidMDN60RAQMSz1182PNSllB1WSiTREl/rl4VfnS3h
        sA5OtZKb1U1Gki/SP4EkY43au3qO4C8=
Date:   Wed, 9 Feb 2022 21:36:57 +0100
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
        linux-kernel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCHv2 00/29] TDX Guest: TDX core support
Message-ID: <YgQl6Uk9rONgv9+F@zn.tnic>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220209235613.652f5720cd196331d7a220ec@intel.com>
 <YgOgog9Pb886lfsv@zn.tnic>
 <20220210003033.e57c2925b69bab5cfabf7292@intel.com>
 <YgOoId+vyd1VhIqQ@zn.tnic>
 <20220210004831.03dea501738bee060003d040@intel.com>
 <YgOr6tZjsooJgAi9@zn.tnic>
 <YgPwwI2+16/7jQC4@google.com>
 <YgQR/S67Fqz9PanR@zn.tnic>
 <YgQfGKXOemtXnFau@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YgQfGKXOemtXnFau@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ SEV guys. You can scroll upthread to read up on the context.

On Wed, Feb 09, 2022 at 08:07:52PM +0000, Sean Christopherson wrote:
> Don't forget :-)
> 
>   arch/x86/kernel/kvm.c - KVM guest stuff

I knew I'd miss something, ofc.

> No objection to omitting "coco".  Though what about using "vmx" and "svm" instead
> of "tdx" and "sev".

I'm not dead-set on this but ...

> We lose the more explicit tie to coco, but it would mirror the
> sub-directories in arch/x86/kvm/

... having them too close in naming to the non-coco stuff, might cause
confusion when looking at:

arch/x86/kvm/vmx/vmx.c

vs

arch/x86/virt/vmx/vmx.c

Instead of having

arch/x86/kvm/vmx/vmx.c

and

arch/x86/virt/tdx/vmx.c

That second version differs just the right amount. :-)

> and would avoid a mess in the scenario where tdx
> or sev needs to share code with the non-coco side, e.g. I'm guessing TDX will need
> to do VMXON.
> 
>   arch/x86/virt/vmx/
>   	tdx.c
> 	vmx.c
> 
>   arch/x86/virt/svm/
>   	sev.c
> 	sev-es.c
> 	sev-snp.c
>   	svm.c

That will probably be two files too: sev.c and svm.c

But let's see what the other folks think first...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
