Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07EAD55F1B0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 01:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbiF1W7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 18:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiF1W7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 18:59:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3348A1EC56
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 15:59:10 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1656457147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E5qCdzZKSngq9kBKyQeHMungQUBGO3EPdUEJsmBI+6g=;
        b=gneh9/4iQUO2UFoB8fpJKaKULN5nl7l2bMQYdk0tTJlvtWKGElhYU0HyKX4ZXO20UUIo+y
        sx/aVU3Ma3mv3ZcK7MxV+YH1x43fzapgci1yrYaUs21rVQY9YhiwfqsyQBehtIn5dgelAi
        9QIoHYhnXItaEH2zXEVTXlCTrzUaIpUtLNH72m3w2ZaD31or0CEiokHWdVvaYvbFHROHi6
        XlTYgHU7vZ1SVFPLLdUnB1cU+RJDesTrEMAijtouX192rAhAPG476mnTxp5m1RLPFATAW5
        BFLnP2naHrmVSEb8s/4flSHhv/ifRA4EnAqm8sIVB8gM2gvAyIbcrLW72x7qEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1656457147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E5qCdzZKSngq9kBKyQeHMungQUBGO3EPdUEJsmBI+6g=;
        b=NCgW31YDjuoPFvKkXlmFw5OMELNJaffqXGnQQyHkBRAk3T6ZgQuEie9LPbDlW1/1PpMDva
        F9Sd5GUoDPPJADDw==
To:     Alexandre Messier <alex@me.ssier.org>,
        Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, Andrew.Cooper3@citrix.com,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        regressions@lists.linux.dev
Subject: Re: [REGRESSION] Unable to unlock encrypted disk starting with
 kernel 5.19-rc1+
In-Reply-To: <19f8897b-c445-4e66-49b2-9ceca738a263@me.ssier.org>
References: <6025678c-e94a-6966-e298-82fad658a889@me.ssier.org>
 <YrrHwxtD2dpts7PF@zn.tnic>
 <19f8897b-c445-4e66-49b2-9ceca738a263@me.ssier.org>
Date:   Wed, 29 Jun 2022 00:59:07 +0200
Message-ID: <874k04e6o4.ffs@tglx>
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

Alexandre,

On Tue, Jun 28 2022 at 17:31, Alexandre Messier wrote:
> flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
>                   pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext
>                   fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl
>                   nonstop_tsc cpuid extd_apicid aperfmperf rapl pni pclmulqdq
>                   monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave
>                   avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm
>                   sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce
>                   topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb
>                   cat_l3 cdp_l3 hw_pstate ssbd mba ibrs ibpb stibp vmmcall
>                   fsgsbase bmi1 avx2 smep bmi2 erms invpcid cqm rdt_a rdseed
>                   adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1
>                   xsaves cqm_llc cqm_occup_llc cqm_mbm_total
>                   cqm_mbm_local

So this CPU supports XSAVEC and XSAVES which means the kernel uses
XSAVES as the kernel before that.

> And here is the dmesg output of 5.19-rc4 without the revert (taken from the
> initramfs). I put it on a paste service since it is too big for email:
>
>   https://paste.debian.net/1245491/

[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[9]:  832, xstate_sizes[9]:    8
[    0.000000] x86/fpu: Enabled xstate features 0x207, context size is 840 bytes, using 'compacted' format.

This is correct. Is there any difference on a 5.18 kernel or on 5.19-rc
with the commit reverted? I doubt that.

I'm completely puzzled and stared at the commit in question on and off,
but I can't spot the fail.

> I setup an unencrypted Debian installation on another drive to be able to run
> cryptsetup commands in userspace while using rc4, and was able to see the
> issue. In a up-to-date Debian Sid installation (important, more on this below),
> running these commands makes it possible to reproduce the issue:
>
>   dd if=/dev/zero bs=1M count=20 of=./test.img
>   sudo cryptsetup luksFormat ./test.img
>   sudo cryptsetup luksOpen ./test.img test_crypt
>
> The "luksOpen" will fail with the same error message I get on my main system.
>
> It seems using the latest Debian Sid is important. At first, I was trying with
> Debian Bullseye, but everything was working, even unlocking my main drive.
>
> Could it be a difference due to the cryptsetup version? Sid is using 2.4.3,
> while Bullseye is based on 2.3.7. I will try to compile cryptsetup 2.4.3 and
> use it in a Bullseye system with kernel 5.19-rc4, to see if the issue occurs
> in that setup.

It might use a different crypto algorithm.

Still confused....

I'll have another look tomorrow morning with brain awake.

Thanks,

        tglx
