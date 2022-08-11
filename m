Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B988590725
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 21:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235965AbiHKTzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 15:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbiHKTzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 15:55:06 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2E06E885
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 12:55:04 -0700 (PDT)
Received: from [127.0.0.1] ([12.0.243.163])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 27BJs2nF568664
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Thu, 11 Aug 2022 12:54:02 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 27BJs2nF568664
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022080501; t=1660247645;
        bh=pmf6BMEHJK5PK7BNKtSJh7WF6hlmWzZhuKR8Hozwx5g=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=iBOr2Wpk9AMENOiksLgBGwDaGjrFDubQGmCUx5HZLynAluG4ahFuDZvwQcIW0dhZ2
         iHoup1YrmiBlJpE5vmi6peH5/Skh8LG+d6DL9h6F6lUluF3iJujPd9shrRsHyZHuzo
         sfK+yQsmvrPoLv7dLi62uF5DzMm5HcykymnCDOjjsi3AkghbVgs/Hdn6dBXMM2a2e2
         jlRog8Nte2oLpacw7d2kGLaBk1uInNpONWU82WTDH5jVSZnAvJLV0cuUjOAhBzlpn+
         NHz54cW8E1qBYTw95A8ey4varnvEiRE1xsS/zeDFtN9UZuiK+uOd4jof95qdzWWEXd
         Fdo8VGu5WlqUA==
Date:   Thu, 11 Aug 2022 12:53:56 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Adam Dunlap <acdunlap@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ben Dooks <ben-linux@fluff.org>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
CC:     Jacob Xu <jacobhxu@google.com>, Alper Gun <alpergun@google.com>,
        Marc Orr <marcorr@google.com>
Subject: Re: [PATCH] x86/asm: Force native_apic_mem_read to use mov
User-Agent: K-9 Mail for Android
In-Reply-To: <20220811180010.3067457-1-acdunlap@google.com>
References: <20220811180010.3067457-1-acdunlap@google.com>
Message-ID: <657243C6-8EC8-4B44-BC74-8723BEC7B580@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On August 11, 2022 11:00:10 AM PDT, Adam Dunlap <acdunlap@google=2Ecom> wro=
te:
>Previously, when compiled with clang, native_apic_mem_read gets inlined
>into __xapic_wait_icr_idle and optimized to a testl instruction=2E When
>run in a VM with SEV-ES enabled, it attempts to emulate this
>instruction, but the emulator does not support it=2E Instead, use inline
>assembly to force native_apic_mem_read to use the mov instruction which
>is supported by the emulator=2E
>
>Signed-off-by: Adam Dunlap <acdunlap@google=2Ecom>
>Reviewed-by: Marc Orr <marcorr@google=2Ecom>
>Reviewed-by: Jacob Xu <jacobhxu@google=2Ecom>
>---
> arch/x86/include/asm/apic=2Eh | 13 ++++++++++++-
> 1 file changed, 12 insertions(+), 1 deletion(-)
>
>diff --git a/arch/x86/include/asm/apic=2Eh b/arch/x86/include/asm/apic=2E=
h
>index 3415321c8240=2E=2E281db79e76a9 100644
>--- a/arch/x86/include/asm/apic=2Eh
>+++ b/arch/x86/include/asm/apic=2Eh
>@@ -109,7 +109,18 @@ static inline void native_apic_mem_write(u32 reg, u3=
2 v)
>=20
> static inline u32 native_apic_mem_read(u32 reg)
> {
>-	return *((volatile u32 *)(APIC_BASE + reg));
>+	volatile u32 *addr =3D (volatile u32 *)(APIC_BASE + reg);
>+	u32 out;
>+
>+	/*
>+	 * Functionally, what we want to do is simply return *addr=2E However,
>+	 * this accesses an MMIO which may need to be emulated in some cases=2E
>+	 * The emulator doesn't necessarily support all instructions, so we
>+	 * force the read from addr to use a mov instruction=2E
>+	 */
>+	asm_inline("movl %1, %0" : "=3Dr"(out) : "m"(*addr));
>+
>+	return out;
> }
>=20
> extern void native_apic_wait_icr_idle(void);

As I recall, there are some variants which only support using the ax regis=
ter, so if you are going to do this might as well go all the way and force =
a specific instruction with specific registers, like mov (%rdx),%rax (by an=
alogy with the I/O registers=2E)
