Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A348258F542
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 02:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbiHKAio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 20:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiHKAim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 20:38:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE77E7E00E
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 17:38:40 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660178319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FRnVS+EneaoKmPMGcBzopQrqSsVith3/9iRTg2srvio=;
        b=uVoMXRNQCYRCvmLpo+8b8xFp2Z8SBMG7pNAmgFdzUvy22hM1Xzs/MV8cnyWpzNZkVilmfy
        fZrm8rwApdt6WrkOISdPX3n4+rUw8xIQId4e08xVzb51+6Oe3EwOMbU/bedBqLq0AF1z+v
        ny5w/6WoCxBgofVF8NMqHunc/XZG61wVT+lUcHV+tASsh/1AWMAAo+p+XAqGN/a0KCuprj
        FfCagrim3ZBSlUgwx5gJxcyfQOQ8a5Pou9dGCVXxcCLWsMv/uJmWK43LhHTtuFLNb2s6mA
        KErgqowEuJJR1GHTvxIrqkuc/KF8N9pHdmplh6xhMBdQBoNIjf5wGS/6wb/1lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660178319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FRnVS+EneaoKmPMGcBzopQrqSsVith3/9iRTg2srvio=;
        b=Z/gZYbluxcIus8XNKR4RW2YwdnMRp5FXrdSO7zf780YXPf3ywyVjxVZw0zUUe8liLz645S
        xgR/UWtoTEhzD8Dg==
To:     Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        "Huang, Kai" <kai.huang@intel.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        "Gomez Iglesias, Antonio" <antonio.gomez.iglesias@intel.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: Re: [PATCH] x86/apic: Don't disable x2APIC if locked
In-Reply-To: <1d81ef6a-7505-fc13-ecbf-f3ca7a6fbfce@linux.intel.com>
References: <20220809234000.783284-1-daniel.sneddon@linux.intel.com>
 <d6ffb489-7024-ff74-bd2f-d1e06573bb82@intel.com>
 <238ea612-5a25-9323-b31f-0a14493db2f7@linux.intel.com>
 <d4bcb22e-224c-d256-cb93-3ff6ed89a7d0@intel.com>
 <341ea6e9-d8f3-ee7a-6794-67408abbf047@linux.intel.com>
 <87r11nu52l.ffs@tglx>
 <83a0d220-1872-caba-4e7e-b6a366655cf2@linux.intel.com>
 <ba80b303-31bf-d44a-b05d-5c0f83038798@intel.com>
 <bff78ad9-57d8-ca82-cc75-0b7e5024116d@linux.intel.com>
 <9888a920-37b8-9a1f-b887-6630492955c6@intel.com>
 <1d81ef6a-7505-fc13-ecbf-f3ca7a6fbfce@linux.intel.com>
Date:   Thu, 11 Aug 2022 02:38:38 +0200
Message-ID: <87lervty0h.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10 2022 at 17:01, Daniel Sneddon wrote:
> On 8/10/22 16:44, Dave Hansen wrote:
>> On 8/10/22 16:38, Daniel Sneddon wrote:
>>>>
>>>> config INTEL_TDX_GUEST
>>>>         bool "Intel TDX (Trust Domain Extensions) - Guest Support"
>>>>         depends on X86_64 && CPU_SUP_INTEL
>>>>         depends on X86_X2APIC
>>> So I got some more input.  SPR and newer will lock the APIC.  
>> 
>> Could you get a _little_ more clarity on this, please?  Exactly how and
>> when will it be locked?  What does the BIOS writer's guide say?  Will
>> there be an explicit x2APIC lock option?  Or, will it be implicitly
>> locked when SGX or TDX is enabled?
>
> The BIOS doesn't explicitly lock the APIC.  The APIC will be locked if X2APIC
> mode is enabled when the BIOS does an MCHECK.  X2APIC mode will be enabled if
> SGX or TDX are enabled.  So when exactly does the BIOS do an MCHECK?  That I'll
> have to get clarification on.

Sorry, this is uncomprehensible word salad and none of this makes any
sense at all to me.

Can you please explain this in comprehensible sentences understandable
by mere mortals?

Thanks,

        tglx
