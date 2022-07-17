Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB545777DF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 21:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbiGQTIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 15:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbiGQTIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 15:08:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B73B50
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 12:08:45 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658084923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=35pBj3j945cPov6myYlDwKCg2pzfpExowA2dmczpaCA=;
        b=ZpugCNJbNnFJt6ppDgxTehkV5C9RkF3SIosg2s3W1ftGLJ3CH1DmCgkkxitkSCzoB3Iwfu
        vt5hM5ASCl+hrTZWwpLq3wBVIVUYJb9Fn26JIPn6BJvNiRIWoYsoi+BPJJSxVUXdXmAT+W
        N5ixXU8XUn/ak6yOzm2kLWHI499Sohb85CQhaenMHfm/hFkF97ihz3DXQHkB9Ki10wibR0
        x36pIjFb40Yk20HvfeU6Vd0/YuFuzKbFNQduRBNSIt5LwB5EfwrM7LRNBphJpYmBgJNiHH
        JolH4BwRmUSwIIBDWCJ4izGImWNegYF+cvMJjeKshxt1p6yDq7eCX9r1l+RWxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658084923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=35pBj3j945cPov6myYlDwKCg2pzfpExowA2dmczpaCA=;
        b=3h9+9t4lUwBF/mWct6OY+54XvCPQmFOTzPMnqpnj4u+BN8/fDwo3FcbOvaYtexdLKtwOEY
        j7f7uR5VdvuaPhCA==
To:     Andrew Cooper <Andrew.Cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch 02/38] x86/cpu: Use native_wrmsrl() in
 load_percpu_segment()
In-Reply-To: <0bec8fe2-d1e3-f01c-6e52-06ab542efdd8@citrix.com>
References: <20220716230344.239749011@linutronix.de>
 <20220716230952.787452088@linutronix.de>
 <0bec8fe2-d1e3-f01c-6e52-06ab542efdd8@citrix.com>
Date:   Sun, 17 Jul 2022 21:08:42 +0200
Message-ID: <87zgh7wo91.ffs@tglx>
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

On Sun, Jul 17 2022 at 00:22, Andrew Cooper wrote:
>> -void load_percpu_segment(int cpu)
>> +static noinstr void load_percpu_segment(int cpu)
>>  {
>>  #ifdef CONFIG_X86_32
>>  	loadsegment(fs, __KERNEL_PERCPU);
>>  #else
>>  	__loadsegment_simple(gs, 0);
>> -	wrmsrl(MSR_GS_BASE, cpu_kernelmode_gs_base(cpu));
>> +	/*
>> +	 * Because of the __loadsegment_simple(gs, 0) above, any GS-prefixed
>> +	 * instruction will explode right about here. As such, we must not have
>> +	 * any CALL-thunks using per-cpu data.
>> +	 *
>> +	 * Therefore, use native_wrmsrl() and have XenPV take the fault and
>> +	 * emulate.
>> +	 */
>> +	native_wrmsrl(MSR_GS_BASE, cpu_kernelmode_gs_base(cpu));
>>  #endif
>
> Lovely :-/
>
> But I still don't see how that works, because __loadsegment_simple() is
> a memory clobber and cpu_kernelmode_gs_base() has a per-cpu lookup in
> it.

No. It uses an array lookup :)

> That said, this only has a sole caller, and in context, it's bogus for
> 64bit.=C2=A0 Can't we fix all the problems by just doing this:
>
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 736262a76a12..6f393bc9d89d 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -701,16 +701,6 @@ static const char *table_lookup_model(struct
> cpuinfo_x86 *c)
> =C2=A0__u32 cpu_caps_cleared[NCAPINTS + NBUGINTS] __aligned(sizeof(unsign=
ed
> long));
> =C2=A0__u32 cpu_caps_set[NCAPINTS + NBUGINTS] __aligned(sizeof(unsigned l=
ong));
> =C2=A0
> -void load_percpu_segment(int cpu)
> -{
> -#ifdef CONFIG_X86_32
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 loadsegment(fs, __KERNEL_PERCPU);
> -#else
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __loadsegment_simple(gs, 0);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wrmsrl(MSR_GS_BASE, cpu_kernelmode_=
gs_base(cpu));
> -#endif
> -}
> -
> =C2=A0#ifdef CONFIG_X86_32
> =C2=A0/* The 32-bit entry code needs to find cpu_entry_area. */
> =C2=A0DEFINE_PER_CPU(struct cpu_entry_area *, cpu_entry_area);
> @@ -742,12 +732,15 @@ EXPORT_SYMBOL_GPL(load_fixmap_gdt);
> =C2=A0 * Current gdt points %fs at the "master" per-cpu area: after this,
> =C2=A0 * it's on the real one.
> =C2=A0 */
> -void switch_to_new_gdt(int cpu)
> +void __noinstr switch_to_new_gdt(int cpu)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Load the original GDT */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 load_direct_gdt(cpu);
> +
> +#ifdef CONFIG_X86_32
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Reload the per-cpu base */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 load_percpu_segment(cpu);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 loadsegment(fs, __KERNEL_PERCPU);
> +#endif
> =C2=A0}
> =C2=A0
> =C2=A0static const struct cpu_dev *cpu_devs[X86_VENDOR_NUM] =3D {};
>
>
> It's only 32bit where the percpu pointer is tied to the GDT.=C2=A0 On 64b=
it,
> gsbase is good before this, and remains good after.
>
> With this change,
>
> # Make sure load_percpu_segment has no stackprotector
> CFLAGS_common.o=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :=3D -fno=
-stack-protector
>
> comes up for re-evaluation too.

Good point. Let me stare at it some more.

Thanks,

        tglx
