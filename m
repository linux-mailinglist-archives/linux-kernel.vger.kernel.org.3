Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F20463298
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 12:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240867AbhK3Lno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 06:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234242AbhK3Lnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 06:43:42 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35C8C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 03:40:23 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J3Kyq370Qz4xZ3;
        Tue, 30 Nov 2021 22:40:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1638272419;
        bh=iKguq9yFf+d9JwGO5hyACws2GSu66/aOb7glMpKwtrE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=IZ9QUD5b90hMdBYnoU+XoUtmL0zoVAWq7OlHOHMF+rKqqkJmaZRCo9Qv5XkK209S8
         hFIKFeOhcHf3Ez/ICGS/YoSMh4Ynrh2xGCE5lLRbJNDw9MjiYuvfjyc03T59MPoQRc
         w3GUaikAl44iJ+2Sls032dR7FerrbvJwEBIdSo0yLHjLUkFXHHF+mfDVoRtQuo7djB
         J78Xa1akkZQEpZA1Ci6w8FL8rGGYjoCDxqCpqLpYC7B4/T3ovb2CVcpHqRB8cKVZMo
         +07czgoYuaOnYOaOD224cJcKpbzCmWrRR3yCmwGje0lR7nNtuADewuVD2n/B5X1P6d
         Jp5NhW9NBR01w==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     LEROY Christophe <christophe.leroy@csgroup.eu>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v5 1/3] powerpc/bitops: Use immediate operand when possible
In-Reply-To: <4092f4e9-5b2a-a5ca-946b-bb7b92a74f7c@csgroup.eu>
References: <e6f815d9181bab09df3b350af51149437863e9f9.1632236981.git.christophe.leroy@csgroup.eu>
 <4092f4e9-5b2a-a5ca-946b-bb7b92a74f7c@csgroup.eu>
Date:   Tue, 30 Nov 2021 22:40:18 +1100
Message-ID: <877dcpq3bx.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LEROY Christophe <christophe.leroy@csgroup.eu> writes:
> Hi Michael,
>
> Any chance to get this series merged this cycle ?

Yeah. I hesitated a bit at the changes which make the atomic asm even
more complicated, but I guess it's worth it.

cheers

> Le 21/09/2021 =C3=A0 17:09, Christophe Leroy a =C3=A9crit=C2=A0:
>> Today we get the following code generation for bitops like
>> set or clear bit:
>>=20
>> 	c0009fe0:	39 40 08 00 	li      r10,2048
>> 	c0009fe4:	7c e0 40 28 	lwarx   r7,0,r8
>> 	c0009fe8:	7c e7 53 78 	or      r7,r7,r10
>> 	c0009fec:	7c e0 41 2d 	stwcx.  r7,0,r8
>>=20
>> 	c000d568:	39 00 18 00 	li      r8,6144
>> 	c000d56c:	7c c0 38 28 	lwarx   r6,0,r7
>> 	c000d570:	7c c6 40 78 	andc    r6,r6,r8
>> 	c000d574:	7c c0 39 2d 	stwcx.  r6,0,r7
>>=20
>> Most set bits are constant on lower 16 bits, so it can easily
>> be replaced by the "immediate" version of the operation. Allow
>> GCC to choose between the normal or immediate form.
>>=20
>> For clear bits, on 32 bits 'rlwinm' can be used instead of 'andc' for
>> when all bits to be cleared are consecutive.
>>=20
>> On 64 bits we don't have any equivalent single operation for clearing,
>> single bits or a few bits, we'd need two 'rldicl' so it is not
>> worth it, the li/andc sequence is doing the same.
>>=20
>> With this patch we get:
>>=20
>> 	c0009fe0:	7d 00 50 28 	lwarx   r8,0,r10
>> 	c0009fe4:	61 08 08 00 	ori     r8,r8,2048
>> 	c0009fe8:	7d 00 51 2d 	stwcx.  r8,0,r10
>>=20
>> 	c000d558:	7c e0 40 28 	lwarx   r7,0,r8
>> 	c000d55c:	54 e7 05 64 	rlwinm  r7,r7,0,21,18
>> 	c000d560:	7c e0 41 2d 	stwcx.  r7,0,r8
>>=20
>> On pmac32_defconfig, it reduces the text by approx 10 kbytes.
>>=20
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> Reviewed-by: Segher Boessenkool <segher@kernel.crashing.org>
>> ---
>> v5: Fixed the argument of is_rlwinm_mask_valid() in test_and_clear_bits()
>>=20
>> v4: Rebased
>>=20
>> v3:
>> - Using the mask validation proposed by Segher
>>=20
>> v2:
>> - Use "n" instead of "i" as constraint for the rlwinm mask
>> - Improve mask verification to handle more than single bit masks
>>=20
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>>   arch/powerpc/include/asm/bitops.h | 89 ++++++++++++++++++++++++++++---
>>   1 file changed, 81 insertions(+), 8 deletions(-)
>>=20
>> diff --git a/arch/powerpc/include/asm/bitops.h b/arch/powerpc/include/as=
m/bitops.h
>> index 11847b6a244e..a05d8c62cbea 100644
>> --- a/arch/powerpc/include/asm/bitops.h
>> +++ b/arch/powerpc/include/asm/bitops.h
>> @@ -71,19 +71,61 @@ static inline void fn(unsigned long mask,	\
>>   	__asm__ __volatile__ (			\
>>   	prefix					\
>>   "1:"	PPC_LLARX "%0,0,%3,0\n"			\
>> -	stringify_in_c(op) "%0,%0,%2\n"		\
>> +	#op "%I2 %0,%0,%2\n"			\
>>   	PPC_STLCX "%0,0,%3\n"			\
>>   	"bne- 1b\n"				\
>>   	: "=3D&r" (old), "+m" (*p)		\
>> -	: "r" (mask), "r" (p)			\
>> +	: "rK" (mask), "r" (p)			\
>>   	: "cc", "memory");			\
>>   }
>>=20=20=20
>>   DEFINE_BITOP(set_bits, or, "")
>> -DEFINE_BITOP(clear_bits, andc, "")
>> -DEFINE_BITOP(clear_bits_unlock, andc, PPC_RELEASE_BARRIER)
>>   DEFINE_BITOP(change_bits, xor, "")
>>=20=20=20
>> +static __always_inline bool is_rlwinm_mask_valid(unsigned long x)
>> +{
>> +	if (!x)
>> +		return false;
>> +	if (x & 1)
>> +		x =3D ~x;	// make the mask non-wrapping
>> +	x +=3D x & -x;	// adding the low set bit results in at most one bit set
>> +
>> +	return !(x & (x - 1));
>> +}
>> +
>> +#define DEFINE_CLROP(fn, prefix)					\
>> +static inline void fn(unsigned long mask, volatile unsigned long *_p)	\
>> +{									\
>> +	unsigned long old;						\
>> +	unsigned long *p =3D (unsigned long *)_p;				\
>> +									\
>> +	if (IS_ENABLED(CONFIG_PPC32) &&					\
>> +	    __builtin_constant_p(mask) && is_rlwinm_mask_valid(~mask)) {\
>> +		asm volatile (						\
>> +			prefix						\
>> +		"1:"	"lwarx	%0,0,%3\n"				\
>> +			"rlwinm	%0,%0,0,%2\n"				\
>> +			"stwcx.	%0,0,%3\n"				\
>> +			"bne- 1b\n"					\
>> +			: "=3D&r" (old), "+m" (*p)			\
>> +			: "n" (~mask), "r" (p)				\
>> +			: "cc", "memory");				\
>> +	} else {							\
>> +		asm volatile (						\
>> +			prefix						\
>> +		"1:"	PPC_LLARX "%0,0,%3,0\n"				\
>> +			"andc %0,%0,%2\n"				\
>> +			PPC_STLCX "%0,0,%3\n"				\
>> +			"bne- 1b\n"					\
>> +			: "=3D&r" (old), "+m" (*p)			\
>> +			: "r" (mask), "r" (p)				\
>> +			: "cc", "memory");				\
>> +	}								\
>> +}
>> +
>> +DEFINE_CLROP(clear_bits, "")
>> +DEFINE_CLROP(clear_bits_unlock, PPC_RELEASE_BARRIER)
>> +
>>   static inline void arch_set_bit(int nr, volatile unsigned long *addr)
>>   {
>>   	set_bits(BIT_MASK(nr), addr + BIT_WORD(nr));
>> @@ -116,12 +158,12 @@ static inline unsigned long fn(			\
>>   	__asm__ __volatile__ (				\
>>   	prefix						\
>>   "1:"	PPC_LLARX "%0,0,%3,%4\n"			\
>> -	stringify_in_c(op) "%1,%0,%2\n"			\
>> +	#op "%I2 %1,%0,%2\n"				\
>>   	PPC_STLCX "%1,0,%3\n"				\
>>   	"bne- 1b\n"					\
>>   	postfix						\
>>   	: "=3D&r" (old), "=3D&r" (t)			\
>> -	: "r" (mask), "r" (p), "i" (IS_ENABLED(CONFIG_PPC64) ? eh : 0)	\
>> +	: "rK" (mask), "r" (p), "i" (IS_ENABLED(CONFIG_PPC64) ? eh : 0)	\
>>   	: "cc", "memory");				\
>>   	return (old & mask);				\
>>   }
>> @@ -130,11 +172,42 @@ DEFINE_TESTOP(test_and_set_bits, or, PPC_ATOMIC_EN=
TRY_BARRIER,
>>   	      PPC_ATOMIC_EXIT_BARRIER, 0)
>>   DEFINE_TESTOP(test_and_set_bits_lock, or, "",
>>   	      PPC_ACQUIRE_BARRIER, 1)
>> -DEFINE_TESTOP(test_and_clear_bits, andc, PPC_ATOMIC_ENTRY_BARRIER,
>> -	      PPC_ATOMIC_EXIT_BARRIER, 0)
>>   DEFINE_TESTOP(test_and_change_bits, xor, PPC_ATOMIC_ENTRY_BARRIER,
>>   	      PPC_ATOMIC_EXIT_BARRIER, 0)
>>=20=20=20
>> +static inline unsigned long test_and_clear_bits(unsigned long mask, vol=
atile unsigned long *_p)
>> +{
>> +	unsigned long old, t;
>> +	unsigned long *p =3D (unsigned long *)_p;
>> +
>> +	if (IS_ENABLED(CONFIG_PPC32) &&
>> +	    __builtin_constant_p(mask) && is_rlwinm_mask_valid(~mask)) {
>> +		asm volatile (
>> +			PPC_ATOMIC_ENTRY_BARRIER
>> +		"1:"	"lwarx %0,0,%3\n"
>> +			"rlwinm	%1,%0,0,%2\n"
>> +			"stwcx. %1,0,%3\n"
>> +			"bne- 1b\n"
>> +			PPC_ATOMIC_EXIT_BARRIER
>> +			: "=3D&r" (old), "=3D&r" (t)
>> +			: "n" (~mask), "r" (p)
>> +			: "cc", "memory");
>> +	} else {
>> +		asm volatile (
>> +			PPC_ATOMIC_ENTRY_BARRIER
>> +		"1:"	PPC_LLARX "%0,0,%3,0\n"
>> +			"andc	%1,%0,%2\n"
>> +			PPC_STLCX "%1,0,%3\n"
>> +			"bne- 1b\n"
>> +			PPC_ATOMIC_EXIT_BARRIER
>> +			: "=3D&r" (old), "=3D&r" (t)
>> +			: "r" (mask), "r" (p)
>> +			: "cc", "memory");
>> +	}
>> +
>> +	return (old & mask);
>> +}
>> +
>>   static inline int arch_test_and_set_bit(unsigned long nr,
>>   					volatile unsigned long *addr)
>>   {
>>=20
