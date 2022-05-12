Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14AA524DAA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 15:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354052AbiELNBR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 12 May 2022 09:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354049AbiELNBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 09:01:15 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ECC5B5EBDC
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:01:12 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-308-WKnz_SfHO5SeLrhiKjvyFg-1; Thu, 12 May 2022 14:01:09 +0100
X-MC-Unique: WKnz_SfHO5SeLrhiKjvyFg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Thu, 12 May 2022 14:01:07 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Thu, 12 May 2022 14:01:07 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Kirill A. Shutemov'" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        "Dmitry Vyukov" <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86: Implement Linear Address Masking support
Thread-Topic: [PATCH] x86: Implement Linear Address Masking support
Thread-Index: AQHYZN7+/opgI73BZUKmGdIzOSRkmq0bNCgQ
Date:   Thu, 12 May 2022 13:01:07 +0000
Message-ID: <fc54d360620d436f93785ae5e9f8a23f@AcuMS.aculab.com>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511022751.65540-2-kirill.shutemov@linux.intel.com>
In-Reply-To: <20220511022751.65540-2-kirill.shutemov@linux.intel.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kirill A. Shutemov
> Sent: 11 May 2022 03:28
> 
> Linear Address Masking feature makes CPU ignore some bits of the virtual
> address. These bits can be used to encode metadata.
> 
> The feature is enumerated with CPUID.(EAX=07H, ECX=01H):EAX.LAM[bit 26].
> 
> CR3.LAM_U57[bit 62] allows to encode 6 bits of metadata in bits 62:57 of
> user pointers.
> 
> CR3.LAM_U48[bit 61] allows to encode 15 bits of metadata in bits 62:48
> of user pointers.
> 
> CR4.LAM_SUP[bit 28] allows to encode metadata of supervisor pointers.
> If 5-level paging is in use, 6 bits of metadata can be encoded in 62:57.
> For 4-level paging, 15 bits of metadata can be encoded in bits 62:48.
> 
...
> +static vaddr clean_addr(CPUArchState *env, vaddr addr)
> +{
> +    CPUClass *cc = CPU_GET_CLASS(env_cpu(env));
> +
> +    if (cc->tcg_ops->do_clean_addr) {
> +        addr = cc->tcg_ops->do_clean_addr(env_cpu(env), addr);

The performance of a conditional indirect call will be horrid.
Over-engineered when there is only one possible function.

....
> +
> +static inline int64_t sign_extend64(uint64_t value, int index)
> +{
> +    int shift = 63 - index;
> +    return (int64_t)(value << shift) >> shift;
> +}

Shift of signed integers are UB.

> +vaddr x86_cpu_clean_addr(CPUState *cs, vaddr addr)
> +{
> +    CPUX86State *env = &X86_CPU(cs)->env;
> +    bool la57 = env->cr[4] & CR4_LA57_MASK;
> +
> +    if (addr >> 63) {
> +        if (env->cr[4] & CR4_LAM_SUP) {
> +            return sign_extend64(addr, la57 ? 56 : 47);
> +        }
> +    } else {
> +        if (env->cr[3] & CR3_LAM_U57) {
> +            return sign_extend64(addr, 56);
> +        } else if (env->cr[3] & CR3_LAM_U48) {
> +            return sign_extend64(addr, 47);
> +        }
> +    }

That is completely horrid.
Surely it can be just:
	if (addr && 1u << 63)
		return addr | env->address_mask;
	else
		return addr & ~env->address_mask;
Where 'address_mask' is 0x7ff....
although since you really want a big gap between valid user and
valid kernel addresses allowing masked kernel addresses adds
costs elsewhere.

I've no idea how often the address masking is required?
Hopefully almost never?

copy_to/from_user() (etc) need to be able to use user addresses
without having to mask them.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

