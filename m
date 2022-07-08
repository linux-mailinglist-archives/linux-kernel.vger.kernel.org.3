Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D528056B274
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 07:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237134AbiGHF4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 01:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237122AbiGHF4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 01:56:31 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65ADE7969C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 22:56:30 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id 5so9646554plk.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 22:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lGpq+k4aL6JBJ5U6CQh070/+9vynrq/t8pKneZ7U0o0=;
        b=UHOB/KpIS/lB7rEV5m5ae2u7g9rWhMnyrcbAelwongYAv3aim2c1JaUsnXYF+sUqCs
         2o0b/dBs/X8vpQ2N8GmdznXLy+2yU5K6QTx/3Fr7UwUkfGjiugPxEXGAAdfrWjiOHERW
         io0tOq9BM884HEiStsfg2++hupHngOSJyJDfaM07QU1mAuikiV1E8vPsdnkPCZHqYbMp
         ifrjXoMwzkgs29qWp67pAdkerLT3B85isME1iZ/zXSMDvUtnLGrSHU9fMn5xfSxImxGy
         ZzBHQoIpjH0+EHAX6e+pNixgMC5h52WKEtteQwWho/VKi0vRxpwAMHXYZICO38ySTzPP
         5Glg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lGpq+k4aL6JBJ5U6CQh070/+9vynrq/t8pKneZ7U0o0=;
        b=iDhSNacMci8sM7zePK90Px5vaDhhRXKG6nN2nmWXD4UKAHdsm8n9CyVrS04HTJ6V86
         nmBMnHnwgjLCZUAnSsTaLjFN329/PNNoyMjA+BjtYCp5H4G91dxLM5BYu7oY0HjF94yF
         RaBLlnMMWkd08vA67gUuJuUSD9nqfJG/BT3o4IGXic4ugs+n0f4rDQ5F2GAaxfjUzKl1
         NNrtz5wTxWPgtk8LajNRkl03B/JqHIIbEkvok7hYXgwjsMUJVscXkTeAa0WtPXTfL+7L
         +Ir09u8p4ng4Zf6vye6/PrOedLJQ4rwwSybaiJVgyerkMfQ5rprrhL50dXsnNmFIPoq+
         RWbQ==
X-Gm-Message-State: AJIora8nd0UJE34gLFVKCBemgqZ2fGlTsuI/LdBdUK0rfo5lFg4SwWiL
        pQ6QgkKM2Zy7YGh7D2Z9tfo=
X-Google-Smtp-Source: AGRyM1vRn/S+J9DQVangdlZw3nyPoWjeEi7vw4gx6o6rv4QMXgDhWl75i2N7E50LVHiCGk5h4SkGuw==
X-Received: by 2002:a17:902:c405:b0:16c:3cd:db84 with SMTP id k5-20020a170902c40500b0016c03cddb84mr1971171plk.6.1657259789568;
        Thu, 07 Jul 2022 22:56:29 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id 15-20020a63164f000000b00413d592af6asm2249095pgw.50.2022.07.07.22.56.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jul 2022 22:56:29 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH v2] x86/mm/tlb: avoid reading mm_tlb_gen when possible
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <904C4BCE-78E7-4FEE-BD8D-03DCE75A5B8B@gmail.com>
Date:   Thu, 7 Jul 2022 22:56:25 -0700
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-mm@kvack.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <575B908D-A29B-40B0-9A80-76B7E7A9762E@gmail.com>
References: <20220606180123.2485171-1-namit@vmware.com>
 <df9e416a-a6a2-34a-9fa9-dcb92fe6cee2@google.com>
 <904C4BCE-78E7-4FEE-BD8D-03DCE75A5B8B@gmail.com>
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

On Jul 7, 2022, at 9:23 PM, Nadav Amit <nadav.amit@gmail.com> wrote:

> On Jul 7, 2022, at 8:27 PM, Hugh Dickins <hughd@google.com> wrote:
>=20
>> On Mon, 6 Jun 2022, Nadav Amit wrote:
>>=20
>>> From: Nadav Amit <namit@vmware.com>
>>>=20
>>> On extreme TLB shootdown storms, the mm's tlb_gen cacheline is =
highly
>>> contended and reading it should (arguably) be avoided as much as
>>> possible.
>>>=20
>>> Currently, flush_tlb_func() reads the mm's tlb_gen unconditionally,
>>> even when it is not necessary (e.g., the mm was already switched).
>>> This is wasteful.
>>>=20
>>> Moreover, one of the existing optimizations is to read mm's tlb_gen =
to
>>> see if there are additional in-flight TLB invalidations and flush =
the
>>> entire TLB in such a case. However, if the request's tlb_gen was =
already
>>> flushed, the benefit of checking the mm's tlb_gen is likely to be =
offset
>>> by the overhead of the check itself.
>>>=20
>>> Running will-it-scale with tlb_flush1_threads show a considerable
>>> benefit on 56-core Skylake (up to +24%):
>>>=20
>>> threads		Baseline (v5.17+)	+Patch
>>> 1		159960			160202
>>> 5		310808			308378 (-0.7%)
>>> 10		479110			490728
>>> 15		526771			562528
>>> 20		534495			587316
>>> 25		547462			628296
>>> 30		579616			666313
>>> 35		594134			701814
>>> 40		612288			732967
>>> 45		617517			749727
>>> 50		637476			735497
>>> 55		614363			778913 (+24%)
>>>=20
>>> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>>> Cc: Ingo Molnar <mingo@kernel.org>
>>> Cc: Andy Lutomirski <luto@kernel.org>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: x86@kernel.org
>>> Signed-off-by: Nadav Amit <namit@vmware.com>
>>>=20
>>> --
>>>=20
>>> Note: The benchmarked kernels include Dave's revert of commit
>>> 6035152d8eeb ("x86/mm/tlb: Open-code on_each_cpu_cond_mask() for
>>> tlb_is_not_lazy()
>>> ---
>>> arch/x86/mm/tlb.c | 18 +++++++++++++++++-
>>> 1 file changed, 17 insertions(+), 1 deletion(-)
>>>=20
>>> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
>>> index d400b6d9d246..d9314cc8b81f 100644
>>> --- a/arch/x86/mm/tlb.c
>>> +++ b/arch/x86/mm/tlb.c
>>> @@ -734,10 +734,10 @@ static void flush_tlb_func(void *info)
>>> 	const struct flush_tlb_info *f =3D info;
>>> 	struct mm_struct *loaded_mm =3D =
this_cpu_read(cpu_tlbstate.loaded_mm);
>>> 	u32 loaded_mm_asid =3D =
this_cpu_read(cpu_tlbstate.loaded_mm_asid);
>>> -	u64 mm_tlb_gen =3D atomic64_read(&loaded_mm->context.tlb_gen);
>>> 	u64 local_tlb_gen =3D =
this_cpu_read(cpu_tlbstate.ctxs[loaded_mm_asid].tlb_gen);
>>> 	bool local =3D smp_processor_id() =3D=3D f->initiating_cpu;
>>> 	unsigned long nr_invalidate =3D 0;
>>> +	u64 mm_tlb_gen;
>>>=20
>>> 	/* This code cannot presently handle being reentered. */
>>> 	VM_WARN_ON(!irqs_disabled());
>>> @@ -771,6 +771,22 @@ static void flush_tlb_func(void *info)
>>> 		return;
>>> 	}
>>>=20
>>> +	if (f->new_tlb_gen <=3D local_tlb_gen) {
>>> +		/*
>>> +		 * The TLB is already up to date in respect to =
f->new_tlb_gen.
>>> +		 * While the core might be still behind mm_tlb_gen, =
checking
>>> +		 * mm_tlb_gen unnecessarily would have negative caching =
effects
>>> +		 * so avoid it.
>>> +		 */
>>> +		return;
>>> +	}
>>> +
>>> +	/*
>>> +	 * Defer mm_tlb_gen reading as long as possible to avoid cache
>>> +	 * contention.
>>> +	 */
>>> +	mm_tlb_gen =3D atomic64_read(&loaded_mm->context.tlb_gen);
>>> +
>>> 	if (unlikely(local_tlb_gen =3D=3D mm_tlb_gen)) {
>>> 		/*
>>> 		 * There's nothing to do: we're already up to date.  =
This can
>>> --=20
>>> 2.25.1
>>=20
>> I'm sorry, but bisection and reversion show that this commit,
>> aa44284960d550eb4d8614afdffebc68a432a9b4 in current linux-next,
>> is responsible for the "internal compiler error: Segmentation fault"s
>> I get when running kernel builds on tmpfs in 1G memory, lots of =
swapping.
>>=20
>> That tmpfs is using huge pages as much as it can, so splitting and
>> collapsing, compaction and page migration entailed, in case that's
>> relevant (maybe this commit is perfect, but there's a TLB flushing
>> bug over there in mm which this commit just exposes).
>>=20
>> Whether those segfaults happen without the huge page element,
>> I have not done enough testing to tell - there are other bugs with
>> swapping in current linux-next, indeed, I wouldn't even have found
>> this one, if I hadn't already been on a bisection for another bug,
>> and got thrown off course by these segfaults.
>>=20
>> I hope that you can work out what might be wrong with this,
>> but meantime I think it needs to be reverted.
>=20
> I find it always surprising how trivial one liners fail.
>=20
> As you probably know, debugging these kind of things is hard. I see =
two
> possible cases:
>=20
> 1. The failure is directly related to this optimization. The immediate
> suspect in my mind is something to do with PCID/ASID.
>=20
> 2. The failure is due to another bug that was papered by =E2=80=9Cenough=
=E2=80=9D TLB
> flushes.
>=20
> I will look into the code. But if it is possible, it would be helpful =
to
> know whether you get the failure with the =E2=80=9Cnopcid=E2=80=9D =
kernel parameter. If it
> passes, it wouldn=E2=80=99t say much, but if it fails, I think (2) is =
more likely.
>=20
> Not arguing about a revert, but, in some way, if the test fails, it =
can
> indicate that the optimization =E2=80=9Cworks=E2=80=9D=E2=80=A6
>=20
> I=E2=80=99ll put some time to look deeper into the code, but it would =
be very
> helpful if you can let me know what happens with nopcid.

Actually, only using =E2=80=9Cnopcid=E2=80=9D would most likely make it =
go away if we have
PTI enabled. So to get a good indication, a check whether it reproduces =
with
=E2=80=9Cnopti=E2=80=9D and =E2=80=9Cnopcid=E2=80=9D is needed.

I don=E2=80=99t have a better answer yet. Still trying to see what might =
have gone
wrong.=
