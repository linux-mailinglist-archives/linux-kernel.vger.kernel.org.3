Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E9C4E8003
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 09:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbiCZI3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 04:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiCZI3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 04:29:43 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD6925EC82
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 01:28:05 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 103CE1EC05F1;
        Sat, 26 Mar 2022 09:28:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1648283280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=DaPzlO0lCBv97L6stIXP2Y4y6m9nV5ApnzETJlOBo8Y=;
        b=cMvGO5IKzFDcw+4zOxFzxDc6Xy0qZb7AQdAu1q9nNDc/GjFZBkOlSZ0ON+6l4zUhCUFYxK
        i0xpXNAu2DW2icNl3/rE6jwjdRAF0783VG3l9q1QZjl4SzeGU8NnysBPV7Pm5a/lxVU5wF
        VRsFSNFat/1LWtohLnrDUAMpkiPsGB8=
Date:   Sat, 26 Mar 2022 09:27:55 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Matthias Welwarsky <matthias.welwarsky@sysgo.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86-ml <x86@kernel.org>
Subject: Re: x86, possible bug in __memmove() alternatives patching
Message-ID: <Yj7Oi9g/B54xAcmF@zn.tnic>
References: <3422754.iIbC2pHGDl@linux-3513>
 <Yj49F1pnehy3ga5U@zn.tnic>
 <d9d0405e-b118-b028-d26f-fbb8de4e7a0e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d9d0405e-b118-b028-d26f-fbb8de4e7a0e@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 09:45:24PM -0700, Dave Hansen wrote:
> On 3/25/22 15:07, Borislav Petkov wrote:
> > I know it's is probably a very rare case and Intel recommends having fast 
> > string ops enabled, hence the question: would this be considered a bug in the 
> > kernel that should be fixed? A potential fix could be to clear FSRM together 
> > with ERMS depending on IA32_MISC_ENABLE.
> 
> I'd consider it a bug in the hypervisor, personally. ;)

That's a given.

> 
> But, we do try to make the kernel work even the face of funky
> hypervisors that do things that never occur on real hardware.  If a nice
> patch to fix this up showed up, I'd definitely take a look.

So, more to the point, it is about this chunk:

        /*
         * If fast string is not enabled in IA32_MISC_ENABLE for any reason,
         * clear the fast string and enhanced fast string CPU capabilities.
         */
        if (c->x86 > 6 || (c->x86 == 6 && c->x86_model >= 0xd)) {
                rdmsrl(MSR_IA32_MISC_ENABLE, misc_enable);
                if (!(misc_enable & MSR_IA32_MISC_ENABLE_FAST_STRING)) {
                        pr_info("Disabled fast string operations\n");
                        setup_clear_cpu_cap(X86_FEATURE_REP_GOOD);
                        setup_clear_cpu_cap(X86_FEATURE_ERMS);
                }
        }

we already check whether fast strings was disabled, regardless of HV or
not. Question is, should we clear X86_FEATURE_FSRM there too. I wanna
say yes.

Or is it that, *if* MSR_IA32_MISC_ENABLE_FAST_STRING is clear, the FSRM
CPUID bit was not set either so nothing to clear...

Hmm?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
