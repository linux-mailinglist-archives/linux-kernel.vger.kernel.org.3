Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED1B57781C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 22:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiGQUIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 16:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiGQUIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 16:08:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB05BB80
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 13:08:18 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658088497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a+bvcxFTTxt/CNJIaN7HoFvtlBW3sfJl7MdYiZF7/Ac=;
        b=tQe1fG3WsL4hfTLPUZG79XQx9kB2x/kU3KUQAV4eJhEztQmaK+pYep2FKt/p8PriSlvMnC
        DSl3HoQ9e0z9PzZhcPojNu/RjNxHSNGQbBlI4IXk/zrckQX6pxv7VRMwExsgATQFSNwX8C
        DEPGDBxYvPvFIVaxZM7DDXDkV8lLrBg20L00u6qOU+mI5N5a05MR8qU0YbHKOyxRITY271
        xLzZaNjiQFba50rAcE1U607C2I1JfIbGzt8nAEG2Jvsz4Sh3uF7LYAndG7uZqTEVw/+DDq
        MVSnNkNDYeQRHwjEseuttfC2M9JVADGvvP4DnZV30xCOlbTchzj9Pn6YWvFhoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658088497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a+bvcxFTTxt/CNJIaN7HoFvtlBW3sfJl7MdYiZF7/Ac=;
        b=r7/addJHboDgbFll4Uo1UImdrMXyuzxHxExcG61gdJBiHySU+YUWS8aCjLIRcTV6YIJbVW
        T3oX3rnLTs8yxuDw==
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
In-Reply-To: <87zgh7wo91.ffs@tglx>
References: <20220716230344.239749011@linutronix.de>
 <20220716230952.787452088@linutronix.de>
 <0bec8fe2-d1e3-f01c-6e52-06ab542efdd8@citrix.com> <87zgh7wo91.ffs@tglx>
Date:   Sun, 17 Jul 2022 22:08:16 +0200
Message-ID: <87tu7fwlhr.ffs@tglx>
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

On Sun, Jul 17 2022 at 21:08, Thomas Gleixner wrote:
> On Sun, Jul 17 2022 at 00:22, Andrew Cooper wrote:
>> =C2=A0#ifdef CONFIG_X86_32
>> =C2=A0/* The 32-bit entry code needs to find cpu_entry_area. */
>> =C2=A0DEFINE_PER_CPU(struct cpu_entry_area *, cpu_entry_area);
>> @@ -742,12 +732,15 @@ EXPORT_SYMBOL_GPL(load_fixmap_gdt);
>> =C2=A0 * Current gdt points %fs at the "master" per-cpu area: after this,
>> =C2=A0 * it's on the real one.
>> =C2=A0 */
>> -void switch_to_new_gdt(int cpu)
>> +void __noinstr switch_to_new_gdt(int cpu)
>> =C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Load the original GDT */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 load_direct_gdt(cpu);
>> +
>> +#ifdef CONFIG_X86_32
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Reload the per-cpu base */
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 load_percpu_segment(cpu);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 loadsegment(fs, __KERNEL_PERCPU);
>> +#endif
>> =C2=A0}
>> =C2=A0
>> =C2=A0static const struct cpu_dev *cpu_devs[X86_VENDOR_NUM] =3D {};
>>
>>
>> It's only 32bit where the percpu pointer is tied to the GDT.=C2=A0 On 64=
bit,
>> gsbase is good before this, and remains good after.
>>
>> With this change,
>>
>> # Make sure load_percpu_segment has no stackprotector
>> CFLAGS_common.o=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :=3D -fn=
o-stack-protector
>>
>> comes up for re-evaluation too.
>
> Good point. Let me stare at it some more.

If it only would be that simple :)

loadsegment_simple() was a red herring. The gs segment is already zero.

So what explodes here is the early boot when switching from early per
CPU to the real per CPU area.

start_kernel()
        .....
        setup_per_cpu_areas();
        smp_prepare_boot_cpu()
          switch_to_new_gdt()
       	     load_direct_gdt(cpu);
          load_percpu_segment(cpu)
            GS: 0
            GS_BASE: 0xffffffff829d0000 (early PERCPU)=20
            wrmsrl()
            GS_BASE: 0xffff888237c00000 (real PERCPU)

So the explosion happens when accessing a per CPU variable after loading
the GDT and before GS_BASE is fixed up.

That's the only case AFAICT where this matters. In all other invocations
GS_BASE is already correct.

Let me fix this proper.

Thanks,

        tglx
