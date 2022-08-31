Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D859C5A763F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 08:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiHaGKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 02:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiHaGKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 02:10:14 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B9233425
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 23:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1661926212;
        bh=/TER4iJHDBefpw95HzCdjG3bDhB21B9H1g+yQMQEbes=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=h++eRIqWYr2VAslir2CMvR3E5V+NfSELO5/cM+dMXeXd3KHe10CzHfmOPssSjRU43
         yIrkZTb6e3aTQq46Bvbj/6l/+gZQP2a1bQI1OfJuNCejxEHibrMixx36mrCx1X+31H
         TZY0omxhkkjYZ3tVxwZiD73MLsTGQ7ULwt7BbJok=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 196BB667CA;
        Wed, 31 Aug 2022 02:10:10 -0400 (EDT)
Message-ID: <5b87173faeef587a2ffaaa6f58d34e0940231067.camel@xry111.site>
Subject: Re: [PATCH v7 0/5] LoongArch: Support toolchain with new relocation
 types
From:   Xi Ruoyao <xry111@xry111.site>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     loongarch@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        Youling Tang <tangyouling@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>
Date:   Wed, 31 Aug 2022 14:10:09 +0800
In-Reply-To: <CAAhV-H7Dz21qRgwkMcJ0SnA9FNDN19E6mpa7C25LUitrO9LGeA@mail.gmail.com>
References: <20220830104806.128365-1-xry111@xry111.site>
         <CAAhV-H5bH7xZTWLhqcZ_Bmh=RNaEVBy9523hmj-gTmitqqc8ag@mail.gmail.com>
         <c0ba2e23-5be3-924d-554a-2f10272c05bc@xen0n.name>
         <CAAhV-H7Dz21qRgwkMcJ0SnA9FNDN19E6mpa7C25LUitrO9LGeA@mail.gmail.com>
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

On Wed, 2022-08-31 at 13:44 +0800, Huacai Chen wrote:

> With this series applied and ARCH_WANT_LD_ORPHAN_WARN enabled, we get
> loongarch64-unknown-linux-gnu-ld: warning: orphan section `.got' from
> `arch/loongarch/kernel/head.o' being placed in section `.got'
> loongarch64-unknown-linux-gnu-ld: warning: orphan section `.got.plt'
> from `arch/loongarch/kernel/head.o' being placed in section `.got.plt'
>=20
> I think we should add this lines in vmlinux.lds.S
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .got : { *(.got) }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .got.plt : { *(.got.plt) }
>=20
> But put them to which patch? Patch 2 or Patch 5?

In patch 2 IMO.  Because in patch 2 we already know "-Wa,-mla-global-
with-pcrel" does not prevent the generation of GOT with new toolchain.

If you need a v8 please tell me to send it, but I don't know how to
handle -Woverride-init warnings (IMO the fix for this warning should be
a standalone patch outside of the series).

P. S. The ld warning message seems a little strange because "head.o"
does not contain .got or .got.plt sections...  I guess there is a linker
bug causing it outputs the very first input file in the message, instead
of the first input file really containing an orphaned section.

Another P. S.: the use of GOT is actually unneeded in main kernel image
but we don't have something equivalent to "-Wa,-mla-global-with-pcrel"
in the new toolchain.  Perhaps we can add this feature to GCC later.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
