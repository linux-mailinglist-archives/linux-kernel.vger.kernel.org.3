Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535E35721FE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 19:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbiGLRyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 13:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbiGLRyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 13:54:09 -0400
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4AD4F65F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 10:54:08 -0700 (PDT)
Received: from spock.localnet (unknown [83.148.33.151])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id E940FF91F2E;
        Tue, 12 Jul 2022 19:54:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1657648446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZAEvDrruioRUeOqOP35LLO6mwrB7yP6awQauT5tRizA=;
        b=FLmLObv3ScGZwWlYLs0MNDpULkQzehYJPhcioXM0GJuqruQ/WDaS/RSbQfuMkZ9OajXmIq
        +BxSIdJTsQdkNx3TO6pRhnPmF5xdGbUGxq9Rw48shoPmO8EQW1dDVMsw4+LxTpst0UFQK6
        SX0KpRkS3BpV48//SPa2es2kTxz9bng=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     "Yuan, Perry" <Perry.Yuan@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [REGRESSION] amd-pstate doesn't work since v5.18.11
Date:   Tue, 12 Jul 2022 19:54:04 +0200
Message-ID: <2414945.NDPYyZybsh@natalenko.name>
In-Reply-To: <MN0PR12MB6101ECFEFBBDBB65CA75F1C3E2869@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <3559249.JlDtxWtqDm@natalenko.name> <DM4PR12MB527879122FE84DCD355C33B59C869@DM4PR12MB5278.namprd12.prod.outlook.com> <MN0PR12MB6101ECFEFBBDBB65CA75F1C3E2869@MN0PR12MB6101.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On =C3=BAter=C3=BD 12. =C4=8Dervence 2022 19:50:33 CEST Limonciello, Mario =
wrote:
> [Public]
>=20
> + Ray=20
>=20
> > -----Original Message-----
> > From: Yuan, Perry <Perry.Yuan@amd.com>
> > Sent: Tuesday, July 12, 2022 12:50
> > To: Oleksandr Natalenko <oleksandr@natalenko.name>; Limonciello, Mario
> > <Mario.Limonciello@amd.com>; linux-kernel@vger.kernel.org
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>; Sasha Levin
> > <sashal@kernel.org>; x86@kernel.org; H. Peter Anvin <hpa@zytor.com>;
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Subject: RE: [REGRESSION] amd-pstate doesn't work since v5.18.11
> >=20
> > [AMD Official Use Only - General]
> >=20
> > Hi Oleksandr:
> >=20
> > > -----Original Message-----
> > > From: Oleksandr Natalenko <oleksandr@natalenko.name>
> > > Sent: Wednesday, July 13, 2022 1:40 AM
> > > To: Limonciello, Mario <Mario.Limonciello@amd.com>; linux-
> > > kernel@vger.kernel.org
> > > Cc: Yuan, Perry <Perry.Yuan@amd.com>; Rafael J. Wysocki
> > > <rafael.j.wysocki@intel.com>; Sasha Levin <sashal@kernel.org>;
> > > x86@kernel.org; H. Peter Anvin <hpa@zytor.com>; Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org>
> > > Subject: [REGRESSION] amd-pstate doesn't work since v5.18.11
> > >
> > > [CAUTION: External Email]
> > >
> > > Hello Mario.
> > >
> > > The following commits were pulled into v5.18.11:
> > >
> > > ```
> > > $ git log --oneline --no-merges v5.18.10..v5.18.11 | grep ACPI
> > > 2783414e6ef7 ACPI: CPPC: Don't require _OSC if X86_FEATURE_CPPC is
> > > supported
> > > 3068cfeca3b5 ACPI: CPPC: Only probe for _CPC if CPPC v2 is acked
> > > 8beb71759cc8 ACPI: bus: Set CPPC _OSC bits for all and when CPPC_LIB =
is
> > > supported
> > > 13bb696dd2f3 ACPI: CPPC: Check _OSC for flexible address space ```
> > >
> > > and now this happens:
> > >
> > > ```
> > > $ sudo modprobe amd-pstate shared_mem=3D1
> > > modprobe: ERROR: could not insert 'amd_pstate': No such device ```
> > >
> > > With v5.18.10 this worked just fine.
> > >
> > > In your upstream commit 8b356e536e69f3a4d6778ae9f0858a1beadabb1f
> > > you write:
> > >
> > > ```
> > > If there is additional breakage on the shared memory designs also mis=
sing
> > > this _OSC, additional follow up changes may be needed.
> > > ```
> > >
> > > So the question is what else should be pulled into the stable tree to
> > > unbreak amd-pstate?
> > >
> > > Thanks.
> > >
> > > --
> > > Oleksandr Natalenko (post-factum)
> > >
> >=20
> > Could you share the lscpu output ?

Here's my `lscpu`:

```
Architecture:                    x86_64
CPU op-mode(s):                  32-bit, 64-bit
Address sizes:                   43 bits physical, 48 bits virtual
Byte Order:                      Little Endian
CPU(s):                          24
On-line CPU(s) list:             0-23
Vendor ID:                       AuthenticAMD
Model name:                      AMD Ryzen 9 3900XT 12-Core Processor
CPU family:                      23
Model:                           113
Thread(s) per core:              2
Core(s) per socket:              12
Socket(s):                       1
Stepping:                        0
=46requency boost:                 enabled
CPU(s) scaling MHz:              59%
CPU max MHz:                     3800,0000
CPU min MHz:                     2200,0000
BogoMIPS:                        7589.71
=46lags:                           fpu vme de pse tsc msr pae mce cx8 apic =
sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmx=
ext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid=
 extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16 sse4_1 ss=
e4_2 x2apic movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm e=
xtapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt t=
ce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_=
l3 hw_pstate ssbd mba ibpb stibp vmmcall fsgsbase bmi1 avx2 smep bmi2 cqm r=
dt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves =
cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr =
rdpru wbnoinvd arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushb=
yasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif v_spe=
c_ctrl umip rdpid overflow_recov succor smca sev sev_es
Virtualization:                  AMD-V
L1d cache:                       384 KiB (12 instances)
L1i cache:                       384 KiB (12 instances)
L2 cache:                        6 MiB (12 instances)
L3 cache:                        64 MiB (4 instances)
NUMA node(s):                    1
NUMA node0 CPU(s):               0-23
Vulnerability Itlb multihit:     Not affected
Vulnerability L1tf:              Not affected
Vulnerability Mds:               Not affected
Vulnerability Meltdown:          Not affected
Vulnerability Mmio stale data:   Not affected
Vulnerability Spec store bypass: Mitigation; Speculative Store Bypass disab=
led via prctl
Vulnerability Spectre v1:        Mitigation; usercopy/swapgs barriers and _=
_user pointer sanitization
Vulnerability Spectre v2:        Mitigation; Retpolines, IBPB conditional, =
STIBP conditional, RSB filling
Vulnerability Srbds:             Not affected
Vulnerability Tsx async abort:   Not affected

```

> > Perry.
>=20
> Thanks this is the sort of thing I was worried might happen as a result o=
f requiring
> the _OSC.  It was introduced as part of that commit 8beb71759cc8.
>=20
> To solve it I think we need to add more things to cpc_supported_by_cpu
> (https://github.com/torvalds/linux/blob/525496a030de4ae64bb9e1d6bfc88eec6=
f5fe6e2/arch/x86/kernel/acpi/cppc.c#L19)
>=20
> The question is how do we safely detect the shared memory designs?
> These are a fixed quantity as newer designs /should/ be using the MSR.
>=20
> I am tending to thing that unfortunately we need to have an allow-list of=
 shared
> memory design here unless someone has other ideas.

Happy to test any patches as needed.

=2D-=20
Oleksandr Natalenko (post-factum)


