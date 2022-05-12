Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69FC45250DC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 17:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355711AbiELPGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 11:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355399AbiELPGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 11:06:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D11140C4D
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 08:06:43 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652368002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kFygtcm883Zn7/U1NS2HdSj+Xtje9N7wIaflQX84+U8=;
        b=GJpd2woictX7Fls9i3IfIphhaUayBlAS3b4PEjVgPONw5SpQ2fw1Yiln94J2NiAM78N32a
        mofbSXJW6uen5cZ03EJT/S2no4dWq1a7Z/GA9v7w1a95sCpFOHBRir4Z1HEYZV+31tf3NS
        OQCFUIRi58qXjKNH6TyzjxpS4pQOnZxLBkZ28Y1uUvJDb/K6gx5nWHbTfnarxoH4/dc1CS
        QXD4zPOpz7ri6Qllw5uEnzwDMGmpLlwOAkoTX98SIKJqY/o10GkDDQajHvRlDiz0mBTfLo
        wXM4hoLXt7X/by/kgcKEotA181TJFe82HMuUy0ZyU3hef5Oai8y35NBCOaSCaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652368002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kFygtcm883Zn7/U1NS2HdSj+Xtje9N7wIaflQX84+U8=;
        b=UNXNdwBvHezxPiv2SBK2qV8ueGqfJ/UmvrnNZiwaCWbXQ9YfMDKaVG3M0SUOyjtHshhcYj
        Sz5rUorlkuTFlIAA==
To:     Matthew Wilcox <willy@infradead.org>,
        David Laight <David.Laight@aculab.com>
Cc:     "'Kirill A. Shutemov'" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: Implement Linear Address Masking support
In-Reply-To: <Yn0UmdTOdceX1g05@casper.infradead.org>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511022751.65540-2-kirill.shutemov@linux.intel.com>
 <fc54d360620d436f93785ae5e9f8a23f@AcuMS.aculab.com>
 <Yn0UmdTOdceX1g05@casper.infradead.org>
Date:   Thu, 12 May 2022 17:06:41 +0200
Message-ID: <87v8uavlha.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12 2022 at 15:07, Matthew Wilcox wrote:
> On Thu, May 12, 2022 at 01:01:07PM +0000, David Laight wrote:
>> > +static inline int64_t sign_extend64(uint64_t value, int index)
>> > +{
>> > +    int shift =3D 63 - index;
>> > +    return (int64_t)(value << shift) >> shift;
>> > +}
>>=20
>> Shift of signed integers are UB.
>
> Citation needed.

I'll bite :)

C11/19: 6.5.7 Bitwise shift operators

  4 The result of E1 << E2 is E1 left-shifted E2 bit positions; vacated
    bits are filled with zeros. If E1 has an unsigned type, the value of
    the result is E1 =C3=97 2E2, reduced modulo one more than the maximum
    value representable in the result type. If E1 has a signed type and
    nonnegative value, and E1 =C3=97 2E2 is representable in the result typ=
e,
    then that is the resulting value; otherwise, the behavior is
    undefined.

This is irrelevant for the case above because the left shift is on an
unsigned integer. The interesting part is this:

  5 The result of E1 >> E2 is E1 right-shifted E2 bit positions. If E1
    has an unsigned type or if E1 has a signed type and a nonnegative
    value, the value of the result is the integral part of the quotient
    of E1/2E2.  If E1 has a signed type and a negative value, the
    resulting value is implementation-defined.

So it's not UB, it's implementation defined. The obvious choice is to
keep LSB set, i.e. arithmetic shift, what both GCC and clang do.

Thanks,

        tglx



