Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A2D51FCE3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 14:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbiEIMf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 08:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234475AbiEIMfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 08:35:21 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EABA20AE43;
        Mon,  9 May 2022 05:31:27 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KxgWp3pt1z4xXh;
        Mon,  9 May 2022 22:31:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1652099485;
        bh=SaSGAWOIlHMiL03aULPz9oOhk6sxCFXHchcnqd+bBpA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=PbX2S4d5oYkLXdvSGuVI7LqILlKlaziIAHMrU2vKHXvTe6E99DYJR/x2ZurxyP/Je
         7aHELqir2k3dFvZPoTSHM/jeMpXpv2+YFxTNhcCZ8Qstt+S9P+pHZYY2oBu5os1xdZ
         myKlub3bTkUWD6ekYYmZ1R0ueDrjMWqE7lnH6WvdxsyDzIIKvfjsTNeNYFBZ4VD+ye
         EE4lAHSPR/UlLEivLGaVOUPqxAG4e3qB4rZ4lSA4eVckw92N9TYCr7ZfGgGlhaxhlW
         TJp6Eb72phdng6mKi+w8+aPbBpiKZUuU6MM/LHyT2FKpLUoCZ1qqLmRxBOZX1rG9wj
         PNkNm4ObBPm5w==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Josh Poimboeuf <jpoimboe@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH] bug: Use normal relative pointers in 'struct bug_entry'
In-Reply-To: <afddb4548e93f6458ec1d9ec185a834c348eda33.1651798983.git.jpoimboe@kernel.org>
References: <afddb4548e93f6458ec1d9ec185a834c348eda33.1651798983.git.jpoimboe@kernel.org>
Date:   Mon, 09 May 2022 22:31:14 +1000
Message-ID: <871qx2ubu5.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Josh Poimboeuf <jpoimboe@kernel.org> writes:
> With CONFIG_GENERIC_BUG_RELATIVE_POINTERS, the addr/file relative
> pointers are calculated weirdly: based on the beginning of the bug_entry
> struct address, rather than their respective pointer addresses.
>
> Make the relative pointers less surprising to both humans and tools by
> calculating them the normal way.
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
...
> diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bug.h
> index ecbae1832de3..76252576d889 100644
> --- a/arch/powerpc/include/asm/bug.h
> +++ b/arch/powerpc/include/asm/bug.h
> @@ -13,7 +13,8 @@
>  #ifdef CONFIG_DEBUG_BUGVERBOSE
>  .macro __EMIT_BUG_ENTRY addr,file,line,flags
>  	 .section __bug_table,"aw"
> -5001:	 .4byte \addr - 5001b, 5002f - 5001b
> +5001:	 .4byte \addr - .
> +	 .4byte 5002f - .
>  	 .short \line, \flags
>  	 .org 5001b+BUG_ENTRY_SIZE
>  	 .previous
> @@ -24,7 +25,7 @@
>  #else
>  .macro __EMIT_BUG_ENTRY addr,file,line,flags
>  	 .section __bug_table,"aw"
> -5001:	 .4byte \addr - 5001b
> +5001:	 .4byte \addr - .
>  	 .short \flags
>  	 .org 5001b+BUG_ENTRY_SIZE
>  	 .previous

Embarrassingly, we have another copy of the logic, used in the C
versions, they need updating too:

diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bug.h
index ecbae1832de3..3fde35fd67f8 100644
--- a/arch/powerpc/include/asm/bug.h
+++ b/arch/powerpc/include/asm/bug.h
@@ -49,14 +49,14 @@
 #ifdef CONFIG_DEBUG_BUGVERBOSE
 #define _EMIT_BUG_ENTRY				\
 	".section __bug_table,\"aw\"\n"		\
-	"2:\t.4byte 1b - 2b, %0 - 2b\n"		\
+	"2:\t.4byte 1b - ., %0 - .\n"		\
 	"\t.short %1, %2\n"			\
 	".org 2b+%3\n"				\
 	".previous\n"
 #else
 #define _EMIT_BUG_ENTRY				\
 	".section __bug_table,\"aw\"\n"		\
-	"2:\t.4byte 1b - 2b\n"			\
+	"2:\t.4byte 1b - .\n"			\
 	"\t.short %2\n"				\
 	".org 2b+%3\n"				\
 	".previous\n"


With that added it seems to be working correctly for me.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)


cheers
