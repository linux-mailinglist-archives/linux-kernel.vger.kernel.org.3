Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3DA4D6A37
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 00:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbiCKW3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 17:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiCKW3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 17:29:17 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC62F2706FB
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 14:18:34 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id o64so10914189oib.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 14:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=XH+5/+cW8VQKO81AORhyT2Hmdy1TzbLeTlOyFWJWYeA=;
        b=PgciNoUU40YKRk+bsPBh194RRGa5sI3NFQvsgyxxdemnlRf1lRQ/7uF7PvVTwNVjfQ
         7Wyakm1uYkqo7VUjKAM5orbK+8q8lq7akwX+fqKy6nN1+sjl1DfS0c8YnPPtBGF5jDg6
         fJkE1+lwwLz8zeQVLEywqWQi90ErE7gVWl4dNjehnQZsCox+D81F4cPth65VOI7g0VKD
         WfK1qgaHCY4UHfnAsl3pcdK/OEzZAO2tLDrXaen8KPpom8gQnUTQbnAxvLrka4s29uMb
         eS9Up5m0pSRi6L7s5+L8KqFaRtMyIWUWJDKnkL7XPpKByOKQcdqnCmmVV9QkS2tr+VFX
         4SGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=XH+5/+cW8VQKO81AORhyT2Hmdy1TzbLeTlOyFWJWYeA=;
        b=H1xl/B+2hmGtgEFO6e9KRYIX3sq8iumGRNqsB4RbYNvI8LNfJVr0tYci8jMge2ln3N
         l5kIiVIglYJKC4qVg//B3P+hVA1r4vO5NvneErudujMwCz8a0qWlBZddpWvZhJOGjoHt
         oD4b2WOrJqbb7gtdBivGgya0gNjkFjRESLPGcT4rvBd0hucmFioKlL+R80ryIadP4bSJ
         qytn3yW8diGD1UaJ8QZ3OECAfrmWCD/rceVJ9Oe5iJKfMKygDtp/i56e842Lw0kmXh5K
         /HgSr7wR28vJ4Dy7Td/ko9arpIFy7miCNQEBxUSjt4fNJTa+SpXutAKIrk58MJ9EsrrD
         0XWQ==
X-Gm-Message-State: AOAM532eQn+jq29d6OpmRb3BUDgFZ5DtwUN7+8MPy7JMDZ/M5TmIx3lq
        hrlW4Y5kERqORmQmYgjMnVS2oBRNnq4=
X-Google-Smtp-Source: ABdhPJwucZP2RjPXu31Wk6NuUNHwx2Rs6nW29uTE/rQOakKnRfuUIrgOwAsq2TZhmEYXGijjSMbAJg==
X-Received: by 2002:a17:90b:4ac1:b0:1bf:6d51:1ad9 with SMTP id mh1-20020a17090b4ac100b001bf6d511ad9mr23648278pjb.199.1647033421514;
        Fri, 11 Mar 2022 13:17:01 -0800 (PST)
Received: from smtpclient.apple ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id c14-20020a056a00248e00b004f77e0fbfc0sm6864387pfv.185.2022.03.11.13.17.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Mar 2022 13:17:01 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [RESEND PATCH v3 2/5] x86/mm: check exec permissions on fault
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <70e08bd5-187a-daee-2822-1d9a437a9cff@intel.com>
Date:   Fri, 11 Mar 2022 13:16:59 -0800
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E46E0DA7-6427-4733-9D43-6CC1107194D6@gmail.com>
References: <20220311190749.338281-1-namit@vmware.com>
 <20220311190749.338281-3-namit@vmware.com>
 <a2a43395-b848-a4f9-4065-109387680701@intel.com>
 <AC8D21EA-CD32-4F9F-B5C1-ED8804EC76FF@vmware.com>
 <70e08bd5-187a-daee-2822-1d9a437a9cff@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 11, 2022, at 12:59 PM, Dave Hansen <dave.hansen@intel.com> =
wrote:
>=20
> On 3/11/22 12:38, Nadav Amit wrote:
>>> On Mar 11, 2022, at 11:41 AM, Dave Hansen <dave.hansen@intel.com> =
wrote:
> ...
>>> Can any sane code trigger this?
>>=20
>> Well, regarding this question and the previous one: I do not think =
that
>> this scenario is possible today since mprotect() holds the mmap_lock
>> for write. There is no other code that I am aware of that toggles
>> the NX bit on a present entry.
>>=20
>> But I will not bet my life on it. That=E2=80=99s the reason for the =
somewhat
>> vague phrasing that I used.
>=20
> =46rom the userspace perspective, mmap(MAP_FIXED) can do this too.  =
But,
> sane userspace can't rely on the syscall to have done any work and the
> TLB flushing is currently done before the syscall returns.
>=20
> I'd put it this way:
>=20
> 	Today, it is possible for a thread to end up in access_error()
> 	for a PF_INSN fault and observe a VM_EXEC VMA.  If you are
> 	generous, this could be considered a spurious fault.
>=20
> 	However, the faulting thread would have had to race with the
> 	thread which was changing the PTE and the VMA and is currently
> 	*in* mprotect() (or some other syscall).  In other words, the
> 	faulting thread can encounter this situation, but it never had
> 	any assurance from the kernel that it wouldn't fault.  This is
> 	because the faulting thread never had a chance to observe the
> 	syscall return.
>=20
> 	There is no evidence that the existing behavior can cause any
> 	issues with sane userspace.

Done. Thanks.

>=20
>>>> index d0074c6ed31a..ad0ef0a6087a 100644
>>>> --- a/arch/x86/mm/fault.c
>>>> +++ b/arch/x86/mm/fault.c
>>>> @@ -1107,10 +1107,28 @@ access_error(unsigned long error_code, =
struct vm_area_struct *vma)
>>>> 				       (error_code & X86_PF_INSTR), =
foreign))
>>>> 		return 1;
>>>>=20
>>>> -	if (error_code & X86_PF_WRITE) {
>>>> +	if (error_code & (X86_PF_WRITE | X86_PF_INSTR)) {
>>>> +		/*
>>>> +		 * CPUs are not expected to set the two error code bits
>>>> +		 * together, but to ensure that hypervisors do not =
misbehave,
>>>> +		 * run an additional sanity check.
>>>> +		 */
>>>> +		if ((error_code & (X86_PF_WRITE|X86_PF_INSTR)) =3D=3D
>>>> +					(X86_PF_WRITE|X86_PF_INSTR)) {
>>>> +			WARN_ON_ONCE(1);
>>>> +			return 1;
>>>> +		}
>>>=20
>>> access_error() is only used on the do_user_addr_fault() side of =
things.
>>> Can we stick this check somewhere that also works for kernel address
>>> faults?  This is a generic sanity check.  It can also be in a =
separate
>>> patch.
>>=20
>> I can wrap it in a different function and also call it from
>> do_kern_addr_fault() or spurious_kernel_fault().
>>=20
>> Anyhow, spurious_kernel_fault() should handle spurious faults on
>> executable code correctly.=20
>=20
> This is really about checking the sanity of the "hardware"-provided
> error code.  Let's just do it in  handle_page_fault(), maybe hidden in =
a
> function like:
>=20
> void check_error_code_sanity(unsigned long error_code)
> {
> 	WARN_ON_ONCE(...);
> }
>=20
> You can leave the X86_PF_PK check in place for now.  It's probably =
going
> away soon anyway.

Done. Thanks. But note that removing the check from access_error() means
that if the assertion is broken, userspace might crash inadvertently
(in contrast to the version I sent, which would have potentially led to
infinite stream of page-faults). I don=E2=80=99t know which behavior is =
better,
so let=E2=80=99s go with your version and just hope it doesn=E2=80=99t =
happen.

>=20
>>> Also, we should *probably* stop talking about CPUs here.  If there's
>>> ever something wonky with error code bits, I'd put my money on a =
weird
>>> hypervisor before any kind of CPU issue.
>>=20
>> I thought I manage to convey exactly that in the comment. Can you =
provide
>> a better phrasing?
>=20
> Maybe:
>=20
> 	/*
> 	 * X86_PF_INSTR for instruction _fetches_.  Fetches never write.
> 	 * X86_PF_WRITE should never be set with X86_PF_INSTR.
> 	 *
> 	 * This is most likely due to a buggy hypervisor.
> 	 */

Done, thank you.

