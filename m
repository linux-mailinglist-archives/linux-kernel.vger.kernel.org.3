Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0B54F51F0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1848812AbiDFC3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356185AbiDEVex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 17:34:53 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0907FDF49B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 13:38:47 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E41531EC01D4;
        Tue,  5 Apr 2022 22:38:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1649191122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=hjY4xaC+Y0huxRGOUA02K58jj2yfeN469mtBYn5pstk=;
        b=YTfK+rSBq+aFG1SkmKXyyA20xicGvyDGzg6nSksyizeSiq2Fejs/O2d1RWcSAcdwq2YFUh
        ur26OEx2lHC4W6+WLR7hLTocAiGQBdfHpF6OanJLInuqXPjZ9FxpNauE4Bq5d2JhRaL2Pv
        GWKJuZuhIZljGfX7/zdzYwmBsL9S4HE=
Date:   Tue, 5 Apr 2022 22:38:43 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Carroll, Lewis" <Lewis.Carroll@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
        "Narayan, Ananth" <Ananth.Narayan@amd.com>,
        "Rao, Bharata Bhasker" <bharata@amd.com>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "chang.seok.bae@intel.com" <chang.seok.bae@intel.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "metze@samba.org" <metze@samba.org>,
        "zhengqi.arch@bytedance.com" <zhengqi.arch@bytedance.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: Re: [PATCH] x86: Prefer MWAIT over HALT on AMD processors
Message-ID: <Ykyo00r8aIibvLpP@zn.tnic>
References: <20220405130021.557880-1-wyes.karny@amd.com>
 <YkxMtx9zdk+nH33r@zn.tnic>
 <MN2PR12MB3949923BCD8B368F8269565BFAE49@MN2PR12MB3949.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <MN2PR12MB3949923BCD8B368F8269565BFAE49@MN2PR12MB3949.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 08:26:53PM +0000, Carroll, Lewis wrote:
> This happens when:
>  * User disables global C-states in BIOS
>  * User disables cpuidle (e.g. idle=off or processor.max_cstate=0)
>  * Kernel does not have CONFIG_ACPI_PROCESSOR_IDLE

All three or any one of those?

> Genesis of this patch is customer performance observations.

Please add that explanation to the changelog - it is important when
looking back, trying to figure out why this was done.

> Yes. We felt the code more readable with the prefer_mwait_c1_over_halt fn.
> Hygon CPU init indeed sets X86_FEATURE ZEN.
> AMD CPU init sets X86_FEATURE_ZEN for family >= 17h (not only 17h).

Yes, but this new logic you're adding, basically says, use MWAIT on all
Zen uarch CPUs, right?

So why not write exactly that?

The simpler the logic and the clearer the code, the better.

> Cleanest solution might be a new CPU feature (e.g.
> X86_PREFER_MWAIT_IDLE) that gets set appropriately, but that would
> require touching more files.

Yes, I thought about it too.

Not really necessary if what I wrote above fits.

And while you're touching files, pls add that change too:

---
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 73e643ae94b6..c1091f78f104 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -219,7 +219,7 @@
 #define X86_FEATURE_IBRS		( 7*32+25) /* Indirect Branch Restricted Speculation */
 #define X86_FEATURE_IBPB		( 7*32+26) /* Indirect Branch Prediction Barrier */
 #define X86_FEATURE_STIBP		( 7*32+27) /* Single Thread Indirect Branch Predictors */
-#define X86_FEATURE_ZEN			( 7*32+28) /* "" CPU is AMD family 0x17 or above (Zen) */
+#define X86_FEATURE_ZEN			( 7*32+28) /* "" Set on CPUs of the Zen uarch */
 #define X86_FEATURE_L1TF_PTEINV		( 7*32+29) /* "" L1TF workaround PTE inversion */
 #define X86_FEATURE_IBRS_ENHANCED	( 7*32+30) /* Enhanced IBRS */
 #define X86_FEATURE_MSR_IA32_FEAT_CTL	( 7*32+31) /* "" MSR IA32_FEAT_CTL configured */

so that dhansen and peterz are not confused anymore. :-)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
