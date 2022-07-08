Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3EC56B30B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 09:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237218AbiGHHAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 03:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237049AbiGHG77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 02:59:59 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C935C73598
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 23:59:58 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id g126so8373353pfb.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 23:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vkhHDiKcv15bM4xa5h83OBiBFyvWgUOvR5NKKqCXVpM=;
        b=dIWFSpGMHqXLNATmw37/G1QzqjZtKOQO8WeF8UY7sBYcVdTnJUhdTXweIso5x9aEOn
         EpCZBDEio6kpWQmyYM0K6WiKtRombEvBImMz3hsfD4XlHGxpyeLfEUejIyGXqeO7+1bA
         wE8ukMI3zbvXj8Rg9BJJQ843jRDsiW2T6YxuVArXW2/avzn8XI3NZKYBJg1fY9xjpi6T
         8v0VJ9Mh/QQf3P43KBPQAK+nzN3B1+GO10sloA+IZms8Jt2HNeh5+ZUQBAPwPqwQ7mGO
         DlvjXd8U/B2D5LGR/4j5JrZUWMEykL3pq2lZdwVFzlr0soIdhkhfAR9+N68Cm1PWTk/B
         6NQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vkhHDiKcv15bM4xa5h83OBiBFyvWgUOvR5NKKqCXVpM=;
        b=foe5v6oIjQDDyZlZqxtPbjq7npo9e1e/rGwCtzD5YyI2CKYpv2+lLdoRMiZPCiNLvr
         iP5L6UezSynVdo4EMFLthGzR/HhhUxwyFrIL1W4R9SplU4RH+XFXGFZmGCPzpzHTC2i4
         Z5qbofEeFBCZ8Y/sjk0BenXp8qISgt+Pm6HBUMostsCZIl3m/GRBXQvtZfsqVriSIWjv
         yefKOlP0siZ1B54u27bFggJ5eCXHgVkfOJs2SNnO0fFAsed6MI6mEjaozSxELKNYyhkI
         Bo+rXANRSLiJ3A5O4cunPTG3Yp+d94sppUeliX1xaoxrrqZ6ruLaCt19Dnt1l7aH0WqD
         1C4A==
X-Gm-Message-State: AJIora/E/012yHsdUp/lGUPqkat30U5VXxyV6u6PzUvVtCWeMOpXUazm
        E/pCoMWqyLOR2kAAP9oCAiI=
X-Google-Smtp-Source: AGRyM1vA6+SJfUVB4ySYKkfX9ta0YfaeEosdqRAd0sV8DHCTyPkkCeHfhHo9LqvW94d8CtHuzaLgWw==
X-Received: by 2002:a05:6a00:1901:b0:4fa:fa9e:42e6 with SMTP id y1-20020a056a00190100b004fafa9e42e6mr2478254pfi.1.1657263598146;
        Thu, 07 Jul 2022 23:59:58 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id 19-20020a170902e9d300b0016bfdcb34d4sm5457614plk.152.2022.07.07.23.59.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jul 2022 23:59:57 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH v2] x86/mm/tlb: avoid reading mm_tlb_gen when possible
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <575B908D-A29B-40B0-9A80-76B7E7A9762E@gmail.com>
Date:   Thu, 7 Jul 2022 23:59:55 -0700
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-mm@kvack.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8CC20C66-F223-44E8-9F40-90CFE6E8858B@gmail.com>
References: <20220606180123.2485171-1-namit@vmware.com>
 <df9e416a-a6a2-34a-9fa9-dcb92fe6cee2@google.com>
 <904C4BCE-78E7-4FEE-BD8D-03DCE75A5B8B@gmail.com>
 <575B908D-A29B-40B0-9A80-76B7E7A9762E@gmail.com>
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

On Jul 7, 2022, at 10:56 PM, Nadav Amit <nadav.amit@gmail.com> wrote:

> On Jul 7, 2022, at 9:23 PM, Nadav Amit <nadav.amit@gmail.com> wrote:
>=20
>> On Jul 7, 2022, at 8:27 PM, Hugh Dickins <hughd@google.com> wrote:
>>=20
>>> On Mon, 6 Jun 2022, Nadav Amit wrote:
>>>=20
>>>> From: Nadav Amit <namit@vmware.com>
>>>>=20
>>>> On extreme TLB shootdown storms, the mm's tlb_gen cacheline is =
highly
>>>> contended and reading it should (arguably) be avoided as much as
>>>> possible.
>>>>=20
>>>> Currently, flush_tlb_func() reads the mm's tlb_gen unconditionally,
>>>> even when it is not necessary (e.g., the mm was already switched).
>>>> This is wasteful.
>>>>=20
>>>> Moreover, one of the existing optimizations is to read mm's tlb_gen =
to
>>>> see if there are additional in-flight TLB invalidations and flush =
the
>>>> entire TLB in such a case. However, if the request's tlb_gen was =
already
>>>> flushed, the benefit of checking the mm's tlb_gen is likely to be =
offset
>>>> by the overhead of the check itself.
>>>>=20
>>>> Running will-it-scale with tlb_flush1_threads show a considerable
>>>> benefit on 56-core Skylake (up to +24%):
>>>>=20
>>>> threads		Baseline (v5.17+)	+Patch
>>>> 1		159960			160202
>>>> 5		310808			308378 (-0.7%)
>>>> 10		479110			490728
>>>> 15		526771			562528
>>>> 20		534495			587316
>>>> 25		547462			628296
>>>> 30		579616			666313
>>>> 35		594134			701814
>>>> 40		612288			732967
>>>> 45		617517			749727
>>>> 50		637476			735497
>>>> 55		614363			778913 (+24%)
>>>>=20
>>>> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>>>> Cc: Ingo Molnar <mingo@kernel.org>
>>>> Cc: Andy Lutomirski <luto@kernel.org>
>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>> Cc: x86@kernel.org
>>>> Signed-off-by: Nadav Amit <namit@vmware.com>
>>>>=20
>>>> --
>>>>=20
>>>> Note: The benchmarked kernels include Dave's revert of commit
>>>> 6035152d8eeb ("x86/mm/tlb: Open-code on_each_cpu_cond_mask() for
>>>> tlb_is_not_lazy()
>>>> ---
>>>> arch/x86/mm/tlb.c | 18 +++++++++++++++++-
>>>> 1 file changed, 17 insertions(+), 1 deletion(-)
>>>>=20
>>>> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
>>>> index d400b6d9d246..d9314cc8b81f 100644
>>>> --- a/arch/x86/mm/tlb.c
>>>> +++ b/arch/x86/mm/tlb.c
>>>> @@ -734,10 +734,10 @@ static void flush_tlb_func(void *info)
>>>> 	const struct flush_tlb_info *f =3D info;
>>>> 	struct mm_struct *loaded_mm =3D =
this_cpu_read(cpu_tlbstate.loaded_mm);
>>>> 	u32 loaded_mm_asid =3D =
this_cpu_read(cpu_tlbstate.loaded_mm_asid);
>>>> -	u64 mm_tlb_gen =3D atomic64_read(&loaded_mm->context.tlb_gen);
>>>> 	u64 local_tlb_gen =3D =
this_cpu_read(cpu_tlbstate.ctxs[loaded_mm_asid].tlb_gen);
>>>> 	bool local =3D smp_processor_id() =3D=3D f->initiating_cpu;
>>>> 	unsigned long nr_invalidate =3D 0;
>>>> +	u64 mm_tlb_gen;
>>>>=20
>>>> 	/* This code cannot presently handle being reentered. */
>>>> 	VM_WARN_ON(!irqs_disabled());
>>>> @@ -771,6 +771,22 @@ static void flush_tlb_func(void *info)
>>>> 		return;
>>>> 	}
>>>>=20
>>>> +	if (f->new_tlb_gen <=3D local_tlb_gen) {
>>>> +		/*
>>>> +		 * The TLB is already up to date in respect to =
f->new_tlb_gen.
>>>> +		 * While the core might be still behind mm_tlb_gen, =
checking
>>>> +		 * mm_tlb_gen unnecessarily would have negative caching =
effects
>>>> +		 * so avoid it.
>>>> +		 */
>>>> +		return;
>>>> +	}
>>>> +
>>>> +	/*
>>>> +	 * Defer mm_tlb_gen reading as long as possible to avoid cache
>>>> +	 * contention.
>>>> +	 */
>>>> +	mm_tlb_gen =3D atomic64_read(&loaded_mm->context.tlb_gen);
>>>> +
>>>> 	if (unlikely(local_tlb_gen =3D=3D mm_tlb_gen)) {
>>>> 		/*
>>>> 		 * There's nothing to do: we're already up to date.  =
This can
>>>> --=20
>>>> 2.25.1
>>>=20
>>> I'm sorry, but bisection and reversion show that this commit,
>>> aa44284960d550eb4d8614afdffebc68a432a9b4 in current linux-next,
>>> is responsible for the "internal compiler error: Segmentation =
fault"s
>>> I get when running kernel builds on tmpfs in 1G memory, lots of =
swapping.
>>>=20
>>> That tmpfs is using huge pages as much as it can, so splitting and
>>> collapsing, compaction and page migration entailed, in case that's
>>> relevant (maybe this commit is perfect, but there's a TLB flushing
>>> bug over there in mm which this commit just exposes).
>>>=20
>>> Whether those segfaults happen without the huge page element,
>>> I have not done enough testing to tell - there are other bugs with
>>> swapping in current linux-next, indeed, I wouldn't even have found
>>> this one, if I hadn't already been on a bisection for another bug,
>>> and got thrown off course by these segfaults.
>>>=20
>>> I hope that you can work out what might be wrong with this,
>>> but meantime I think it needs to be reverted.
>>=20
>> I find it always surprising how trivial one liners fail.
>>=20
>> As you probably know, debugging these kind of things is hard. I see =
two
>> possible cases:
>>=20
>> 1. The failure is directly related to this optimization. The =
immediate
>> suspect in my mind is something to do with PCID/ASID.
>>=20
>> 2. The failure is due to another bug that was papered by =E2=80=9Cenoug=
h=E2=80=9D TLB
>> flushes.
>>=20
>> I will look into the code. But if it is possible, it would be helpful =
to
>> know whether you get the failure with the =E2=80=9Cnopcid=E2=80=9D =
kernel parameter. If it
>> passes, it wouldn=E2=80=99t say much, but if it fails, I think (2) is =
more likely.
>>=20
>> Not arguing about a revert, but, in some way, if the test fails, it =
can
>> indicate that the optimization =E2=80=9Cworks=E2=80=9D=E2=80=A6
>>=20
>> I=E2=80=99ll put some time to look deeper into the code, but it would =
be very
>> helpful if you can let me know what happens with nopcid.
>=20
> Actually, only using =E2=80=9Cnopcid=E2=80=9D would most likely make =
it go away if we have
> PTI enabled. So to get a good indication, a check whether it =
reproduces with
> =E2=80=9Cnopti=E2=80=9D and =E2=80=9Cnopcid=E2=80=9D is needed.
>=20
> I don=E2=80=99t have a better answer yet. Still trying to see what =
might have gone
> wrong.

Ok. My bad. Sorry. arch_tlbbatch_flush() does not set any generation in
flush_tlb_info. Bad.

Should be fixed by something like - I=E2=80=99ll send a patch tomorrow:

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index d9314cc8b81f..9f19894c322f 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -771,7 +771,7 @@ static void flush_tlb_func(void *info)
                return;
        }
=20
-       if (f->new_tlb_gen <=3D local_tlb_gen) {
+       if (unlikely(f->mm && f->new_tlb_gen <=3D local_tlb_gen)) {
                /*
                 * The TLB is already up to date in respect to =
f->new_tlb_gen.
                 * While the core might be still behind mm_tlb_gen, =
checking




