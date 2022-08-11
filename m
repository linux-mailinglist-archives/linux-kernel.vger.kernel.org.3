Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036FA58F52E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 02:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbiHKARu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 20:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbiHKARq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 20:17:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E878FD5D
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 17:17:45 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660177062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cUuS5wR61NmFQ4xmvkQge0ofNDbuv+yhiaUNvgh6AaU=;
        b=xmTLXaHG72SxY4EMQyLqM7ceLTg3hPNtd4Xrdl9ZuWxoHsWKeLQ0mW+RmFUQkhLx3Fegp7
        SfHN0dCSvYLqprnsaOl5JcHbuAyRQAL90JnNA3xH5vPYXV0x+3X2fxSf3YYjrCJT9LnEzs
        Dhuj2OYMOQijvRyu56bPTR6YqNjmlZSU7dZziAOUaddcQKnpweY9+T4W060aeULLlfiPaI
        Asgov5Z7vcbCutdE/ZIiYMgpGQw1QvfsuNydWWoZnAj5kk7amuCVNYZD8Y9ZeACAeir8AD
        tgksaRPvKJju9HTUv7y4lyoDBw3qFl5wm9O3OW+Mq9JpNXbDn/OrUYVlGGppSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660177062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cUuS5wR61NmFQ4xmvkQge0ofNDbuv+yhiaUNvgh6AaU=;
        b=CkbZwGW3eV47VPXcugEyl8MaxUw/0yG42ErEOPfCNPpqR5XNB8Odvxip2H3gVJQy0MQaKO
        zAU3tNSrOfh9VgAQ==
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
In-Reply-To: <bff78ad9-57d8-ca82-cc75-0b7e5024116d@linux.intel.com>
References: <20220809234000.783284-1-daniel.sneddon@linux.intel.com>
 <d6ffb489-7024-ff74-bd2f-d1e06573bb82@intel.com>
 <238ea612-5a25-9323-b31f-0a14493db2f7@linux.intel.com>
 <d4bcb22e-224c-d256-cb93-3ff6ed89a7d0@intel.com>
 <341ea6e9-d8f3-ee7a-6794-67408abbf047@linux.intel.com>
 <87r11nu52l.ffs@tglx>
 <83a0d220-1872-caba-4e7e-b6a366655cf2@linux.intel.com>
 <ba80b303-31bf-d44a-b05d-5c0f83038798@intel.com>
 <bff78ad9-57d8-ca82-cc75-0b7e5024116d@linux.intel.com>
Date:   Thu, 11 Aug 2022 02:17:41 +0200
Message-ID: <87o7wrtyze.ffs@tglx>
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

On Wed, Aug 10 2022 at 16:38, Daniel Sneddon wrote:
> On 8/10/22 16:09, Dave Hansen wrote:
>> config INTEL_TDX_GUEST
>>         bool "Intel TDX (Trust Domain Extensions) - Guest Support"
>>         depends on X86_64 && CPU_SUP_INTEL
>>         depends on X86_X2APIC
>
> So I got some more input.  SPR and newer will lock the APIC.  Older products
> will get a ucode update, but that ucode update won't include the APIC lock.  So,
> on non-SPR parts do we still want to make SGX depend on X2APIC?

What is the ucode update doing on pre SPR parts?
Just providing magic voodoo which pretends to be safe?

The public available documentation for this is a huge pile of void.

The point is that if the SGX attestation will fail when X2APIC is not
enforced on the host as of 'some magic dates in 2023' according to the
documentation I pointed to, then any pre SPR SGX capable system is going
to be disfunctional vs. SGX at one of those magic dates.

Some people inside a particular company need to get their act together
and either make this consistent or provide some coherent information why
this is not required for pre SPR parts and why SPR needs to have it.

Thanks,

        tglx


