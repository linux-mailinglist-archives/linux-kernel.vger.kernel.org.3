Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E9B56B155
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 06:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236708AbiGHEXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 00:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiGHEXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 00:23:48 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6661FF5B5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 21:23:47 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id j12so8594372plj.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 21:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=cXx67UAEHDEms/ZWdhD86sRM6wFjqHtEAMk+ffjRrxE=;
        b=JFSekI06NM32A65VsCUGKY5q7uKVQrOkBNr0f/7Me7qwFMfpuKcMw4eV0gHCTpzq8y
         q9WzUxmA91ezdxkWfSvUgECuEq8neZW3wtKRx9wzJ0/5ZDdrfGejiqVNsdzP/33wUevE
         XQVHAbLCDj8f8fEKk79Q6Sv5l+duvSg4uZnqsh+gpv9fJvQwv+CIyDA2rZULrV9rzX6L
         WXWBVZLo/CdxLUNpnJAnj3/otAN51nHHm5/mPaeyt7OP/x2yWrLSp+xWyEfHJ9kzYBem
         ScX4Xueawd2Gtl8EKfbIWyuNUsOi2YNjQUk0SfDSNYhJn4/NlzKRBASrB2yyRdjr4aQ9
         6m9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=cXx67UAEHDEms/ZWdhD86sRM6wFjqHtEAMk+ffjRrxE=;
        b=2O87faAKZF6kXfDObOZdNKdU/bAgVQZhgo5gaDXvfIdx3yPrwlQkyxOA2JLKwtf9VY
         TIZZdQ86ECOqJiP/GV0h6UG/NQFrYmEW927wzUT2zf9PrMyAMVq26NhdRO9HyYDVoQbB
         bpORx9Y3kg2zFZAIOQ5WawnNBskRAir/3D7avkRCkA+PTvKEG/3+OC2/O2w9pSJlQMAd
         7nPp3G/4r/vsNcSbeDC2Y79HEx1HDdijJKRrEK+OFwz+hkmaKtOGfhXtKx1/8NkNFDCK
         ANUldfpOXA0BaOKHpLHPqPcSnVZA5JwerbvdRyinRVKEn4ji7kC7njBdd7l6Yb2Ykolv
         Z+ZQ==
X-Gm-Message-State: AJIora9Ab2YbCImmk5oQcEHRpn8m1b55LIGQW+fRH667YyubcxsXDY99
        HpmXiIyjsn0+tvb3J4s4GLk=
X-Google-Smtp-Source: AGRyM1uBTt9rPkZ3Sgf5UWN0qyjSLmOVDBH6bD8Gpgk2mUCSmEImTx7E15TRBWxg5odBsQbtkdoYPw==
X-Received: by 2002:a17:902:7881:b0:16b:c4a6:1dc9 with SMTP id q1-20020a170902788100b0016bc4a61dc9mr1652435pll.83.1657254226580;
        Thu, 07 Jul 2022 21:23:46 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id 123-20020a621481000000b00527bb6fff6csm20668884pfu.119.2022.07.07.21.23.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jul 2022 21:23:46 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH v2] x86/mm/tlb: avoid reading mm_tlb_gen when possible
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <df9e416a-a6a2-34a-9fa9-dcb92fe6cee2@google.com>
Date:   Thu, 7 Jul 2022 21:23:44 -0700
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-mm@kvack.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <904C4BCE-78E7-4FEE-BD8D-03DCE75A5B8B@gmail.com>
References: <20220606180123.2485171-1-namit@vmware.com>
 <df9e416a-a6a2-34a-9fa9-dcb92fe6cee2@google.com>
To:     Hugh Dickins <hughd@google.com>
X-Mailer: Apple Mail (2.3696.100.31)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 7, 2022, at 8:27 PM, Hugh Dickins <hughd@google.com> wrote:

> On Mon, 6 Jun 2022, Nadav Amit wrote:
>=20
>> From: Nadav Amit <namit@vmware.com>
>>=20
>> On extreme TLB shootdown storms, the mm's tlb_gen cacheline is highly
>> contended and reading it should (arguably) be avoided as much as
>> possible.
>>=20
>> Currently, flush_tlb_func() reads the mm's tlb_gen unconditionally,
>> even when it is not necessary (e.g., the mm was already switched).
>> This is wasteful.
>>=20
>> Moreover, one of the existing optimizations is to read mm's tlb_gen =
to
>> see if there are additional in-flight TLB invalidations and flush the
>> entire TLB in such a case. However, if the request's tlb_gen was =
already
>> flushed, the benefit of checking the mm's tlb_gen is likely to be =
offset
>> by the overhead of the check itself.
>>=20
>> Running will-it-scale with tlb_flush1_threads show a considerable
>> benefit on 56-core Skylake (up to +24%):
>>=20
>> threads		Baseline (v5.17+)	+Patch
>> 1		159960			160202
>> 5		310808			308378 (-0.7%)
>> 10		479110			490728
>> 15		526771			562528
>> 20		534495			587316
>> 25		547462			628296
>> 30		579616			666313
>> 35		594134			701814
>> 40		612288			732967
>> 45		617517			749727
>> 50		637476			735497
>> 55		614363			778913 (+24%)
>>=20
>> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: Ingo Molnar <mingo@kernel.org>
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: x86@kernel.org
>> Signed-off-by: Nadav Amit <namit@vmware.com>
>>=20
>> --
>>=20
>> Note: The benchmarked kernels include Dave's revert of commit
>> 6035152d8eeb ("x86/mm/tlb: Open-code on_each_cpu_cond_mask() for
>> tlb_is_not_lazy()
>> ---
>> arch/x86/mm/tlb.c | 18 +++++++++++++++++-
>> 1 file changed, 17 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
>> index d400b6d9d246..d9314cc8b81f 100644
>> --- a/arch/x86/mm/tlb.c
>> +++ b/arch/x86/mm/tlb.c
>> @@ -734,10 +734,10 @@ static void flush_tlb_func(void *info)
>> 	const struct flush_tlb_info *f =3D info;
>> 	struct mm_struct *loaded_mm =3D =
this_cpu_read(cpu_tlbstate.loaded_mm);
>> 	u32 loaded_mm_asid =3D =
this_cpu_read(cpu_tlbstate.loaded_mm_asid);
>> -	u64 mm_tlb_gen =3D atomic64_read(&loaded_mm->context.tlb_gen);
>> 	u64 local_tlb_gen =3D =
this_cpu_read(cpu_tlbstate.ctxs[loaded_mm_asid].tlb_gen);
>> 	bool local =3D smp_processor_id() =3D=3D f->initiating_cpu;
>> 	unsigned long nr_invalidate =3D 0;
>> +	u64 mm_tlb_gen;
>>=20
>> 	/* This code cannot presently handle being reentered. */
>> 	VM_WARN_ON(!irqs_disabled());
>> @@ -771,6 +771,22 @@ static void flush_tlb_func(void *info)
>> 		return;
>> 	}
>>=20
>> +	if (f->new_tlb_gen <=3D local_tlb_gen) {
>> +		/*
>> +		 * The TLB is already up to date in respect to =
f->new_tlb_gen.
>> +		 * While the core might be still behind mm_tlb_gen, =
checking
>> +		 * mm_tlb_gen unnecessarily would have negative caching =
effects
>> +		 * so avoid it.
>> +		 */
>> +		return;
>> +	}
>> +
>> +	/*
>> +	 * Defer mm_tlb_gen reading as long as possible to avoid cache
>> +	 * contention.
>> +	 */
>> +	mm_tlb_gen =3D atomic64_read(&loaded_mm->context.tlb_gen);
>> +
>> 	if (unlikely(local_tlb_gen =3D=3D mm_tlb_gen)) {
>> 		/*
>> 		 * There's nothing to do: we're already up to date.  =
This can
>> --=20
>> 2.25.1
>=20
> I'm sorry, but bisection and reversion show that this commit,
> aa44284960d550eb4d8614afdffebc68a432a9b4 in current linux-next,
> is responsible for the "internal compiler error: Segmentation fault"s
> I get when running kernel builds on tmpfs in 1G memory, lots of =
swapping.
>=20
> That tmpfs is using huge pages as much as it can, so splitting and
> collapsing, compaction and page migration entailed, in case that's
> relevant (maybe this commit is perfect, but there's a TLB flushing
> bug over there in mm which this commit just exposes).
>=20
> Whether those segfaults happen without the huge page element,
> I have not done enough testing to tell - there are other bugs with
> swapping in current linux-next, indeed, I wouldn't even have found
> this one, if I hadn't already been on a bisection for another bug,
> and got thrown off course by these segfaults.
>=20
> I hope that you can work out what might be wrong with this,
> but meantime I think it needs to be reverted.

I find it always surprising how trivial one liners fail.

As you probably know, debugging these kind of things is hard. I see two
possible cases:

1. The failure is directly related to this optimization. The immediate
suspect in my mind is something to do with PCID/ASID.

2. The failure is due to another bug that was papered by =E2=80=9Cenough=E2=
=80=9D TLB
flushes.

I will look into the code. But if it is possible, it would be helpful to
know whether you get the failure with the =E2=80=9Cnopcid=E2=80=9D =
kernel parameter. If it
passes, it wouldn=E2=80=99t say much, but if it fails, I think (2) is =
more likely.

Not arguing about a revert, but, in some way, if the test fails, it can
indicate that the optimization =E2=80=9Cworks=E2=80=9D=E2=80=A6

I=E2=80=99ll put some time to look deeper into the code, but it would be =
very
helpful if you can let me know what happens with nopcid.

