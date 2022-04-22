Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41BDC50B564
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446619AbiDVKoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446793AbiDVKoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:44:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989CBC2F
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 03:41:07 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650624066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8OWHCGhf98mxnHF3GBVLKPpbLrNg/Ir3H4vcDTXq2PA=;
        b=Mv4G/SimB+4TF/4Q6arbVpuwFI0wyHtTAazn0TW3VPujwkKU8Ii82JeDkqxrShtfF/ucfz
        MlRhVcUTkKdg73xj7qimSUyRwX8cPYuU8H+RD48A9QqUK4LvKYP15C6CvVjyosChNWCsz9
        zFXiP/3qeAlO6RBQYQ7TfdOkk0QYhHM7y5gmPDgF4v1yQqd9mtxs3bZY32SdIAo+zK6VOz
        FyFK/fJBla1If4EPe6+3mlVY8OvSNlpTTmQjESIXAQCVsWXska8ZmDQOL8ouXKjUwYyXNe
        OgqNLQJ0Rhl2I1rmqqPSObdGRUGNmS542WVXdwJPC/KRu98rg8ktRBZ5PeHqyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650624066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8OWHCGhf98mxnHF3GBVLKPpbLrNg/Ir3H4vcDTXq2PA=;
        b=qLKAU9C/77+9XxFOXmQJP2TfWYDZU98/SxFybKjmzkT0gtxcpasChAoj+Mylpg0iH3fmPY
        lvg0AZN87vMUnQBA==
To:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Feng Tang <feng.tang@intel.com>,
        Bill Gray <bgray@redhat.com>, Jirka Hladky <jhladky@redhat.com>
Subject: Re: [PATCH 2/2] x86/tsc_sync: Add synchronization overhead to tsc
 adjustment
In-Reply-To: <d1a04785-4822-3a3f-5c37-81329a562364@redhat.com>
References: <20220314194630.1726542-1-longman@redhat.com>
 <20220314194630.1726542-3-longman@redhat.com> <87czhymql2.ffs@tglx>
 <d1a04785-4822-3a3f-5c37-81329a562364@redhat.com>
Date:   Fri, 22 Apr 2022 12:41:05 +0200
Message-ID: <87levx8kou.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18 2022 at 11:41, Waiman Long wrote:
> On 4/3/22 06:03, Thomas Gleixner wrote:
> [ =C2=A0 =C2=A00.008815] TSC ADJUST compensate: CPU36 observed 86056 warp=
=20
> (overhead 150). Adjust: 86206
> [ =C2=A0 =C2=A00.008815] TSC ADJUST compensate: CPU54 observed 86148 warp=
=20
> (overhead 158). Adjust: 86306
>
>> Also if the compensation value is at the upper end and the real overhead
>> is way lower then the validation run might end up with the opposite
>> result. I'm a bit worried about this variation.
>
> I also have a little concern about that. That is why I add patch 1 to=20
> minimize as much external interference as possible. For the TSC=20
> adjustment samples that I got so far, I have never seen one that need a=20
> 2nd adjustment to go backward.

I did some experiments and noticed that the boot time overhead is
different from the overhead when doing the sync check after boot
(offline a socket and on/offline the first CPU of it several times).

During boot the overhead is lower on this machine (SKL-X), during
runtime it's way higher and more noisy.

The noise can be pretty much eliminated by running the sync_overhead
measurement multiple times and building the average.

The reason why it is higher is that after offlining the socket the CPU
comes back up with a frequency of 700Mhz while during boot it runs with
2100Mhz.

Sync overhead: 118
Sync overhead:  51 A: 22466 M: 22448 F: 2101683

Sync overhead: 178
Sync overhead: 152 A: 22477 M: 67380 F:  700529

Sync overhead: 212
Sync overhead: 152 A: 22475 M: 67380 F:  700467

Sync overhead: 153
Sync overhead: 152 A: 22497 M: 67452 F:  700404

Can you try the patch below and check whether the overhead stabilizes
accross several attempts on that copperlake machine and whether the
frequency is always the same or varies?

Independent of the outcome on that, I think have to take the actual CPU
frequency into account for calculating the overhead.

Thanks,

        tglx
---
--- a/arch/x86/kernel/tsc_sync.c
+++ b/arch/x86/kernel/tsc_sync.c
@@ -446,7 +446,8 @@ void check_tsc_sync_target(void)
 	unsigned int cpu =3D smp_processor_id();
 	cycles_t cur_max_warp, gbl_max_warp;
 	cycles_t start, sync_overhead;
-	int cpus =3D 2;
+	u64 ap1, ap2, mp1, mp2;
+	int i, cpus =3D 2;
=20
 	/* Also aborts if there is no TSC. */
 	if (unsynchronized_tsc())
@@ -514,6 +515,23 @@ void check_tsc_sync_target(void)
 	arch_spin_lock(&sync.lock);
 	arch_spin_unlock(&sync.lock);
 	sync_overhead =3D rdtsc_ordered() - start;
+	pr_info("Sync overhead: %lld\n", sync_overhead);
+
+	sync_overhead =3D 0;
+	rdmsrl(MSR_IA32_APERF, ap1);
+	rdmsrl(MSR_IA32_MPERF, mp1);
+	for (i =3D 0; i < 256; i++) {
+		start =3D rdtsc_ordered();
+		arch_spin_lock(&sync.lock);
+		arch_spin_unlock(&sync.lock);
+		sync_overhead +=3D rdtsc_ordered() - start;
+	};
+	rdmsrl(MSR_IA32_APERF, ap2);
+	rdmsrl(MSR_IA32_MPERF, mp2);
+	ap2 -=3D ap1;
+	mp2 -=3D mp1;
+	pr_info("Sync overhead: %lld A: %llu M: %llu F: %llu\n", sync_overhead >>=
 8,
+		ap2, mp2, mp2 ? div64_u64((cpu_khz * ap2), mp2) : 0);
=20
 	/*
 	 * If the warp value of this CPU is 0, then the other CPU
