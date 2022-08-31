Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E945A76E9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 08:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiHaGuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 02:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiHaGuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 02:50:15 -0400
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBE253006
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 23:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1661928611;
        bh=70USwLN0cVzP/zKh6wgTroCrDHnsKsgsZzrBU5FMj9c=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=J8M9dW33G6NpWL38Dakdfk1FaAds7+8jwYyCzXG0EI25qQar3AXtJPqjoy+a6Uzq0
         3AXlxLTYRCeYDuKPcLAYPyg2q/pHKrsoDzM38IsEU0a0mF0FLyFc/r+Zjy+3Z3c8Y8
         pmd3z8ZIJrgVa+b1dm+czrc8EyIBRystlOC7LL8M=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 9C078667E8;
        Wed, 31 Aug 2022 02:50:09 -0400 (EDT)
Message-ID: <feb773a8df5d30b8d9347d1c922997c9da1fd06a.camel@xry111.site>
Subject: Re: [PATCH 1/1] LoongArch: Fixed loongarch kernel csr_xxx implicit
 declaration.
From:   Xi Ruoyao <xry111@xry111.site>
To:     Yupeng Li <liyupeng@zbhlos.com>, chenhuacai@kernel.org,
        kernel@xen0n.name, jiaxun.yang@flygoat.com
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        caizp2008@163.com
Date:   Wed, 31 Aug 2022 14:50:07 +0800
In-Reply-To: <20220831061406.431027-1-liyupeng@zbhlos.com>
References: <20220831061406.431027-1-liyupeng@zbhlos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.45.2 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-08-31 at 14:14 +0800, Yupeng Li wrote:
> Loongarch CSR register operation related interface, use the
> interface defined=C2=A0 __builtin_loongarch_xxx instead.
> Build kernel error messages like:

It's likely because you are using a draft version of LoongArch GCC port.
Wrapper functions like __csrrd_w has been there in larchintrin.h since
the first day GCC port was merged upstream
(https://gcc.gnu.org/r12-7881).

A quick search shows IA64 and PowerPC also use GCC ia64intrin.h and
spu_intrinsics.h, so the use of these wrappers are not forbidden in
kernel source.

Unless there is some new good reason for the change,

Nacked-by: Xi Ruoyao <xry111@xry111.site>

>=20
> =C2=A0 CALL=C2=A0=C2=A0=C2=A0 scripts/atomic/check-atomics.sh
> =C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arch/loongarch/kernel/asm-offsets=
.s
> In file included from ./arch/loongarch/include/asm/cpu-info.h:11,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 from ./arch/loongarch/include/asm/processor.h:13,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 from ./arch/loongarch/include/asm/thread_info.h:15=
,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 from ./include/linux/thread_info.h:60,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 from ./include/asm-generic/current.h:5,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 from
> ./arch/loongarch/include/generated/asm/current.h:1,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 from ./include/linux/sched.h:12,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 from arch/loongarch/kernel/asm-offsets.c:8:
> ./arch/loongarch/include/asm/loongarch.h: In function 'csr_read32':
> ./arch/loongarch/include/asm/loongarch.h:232:9: error: implicit
> declaration of function '__csrrd_w'; did you mean '__iocsrrd_w'? [-
> Werror=3Dimplicit-function-declaration]
> =C2=A0 return __csrrd_w(reg);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __iocsrrd_w

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
