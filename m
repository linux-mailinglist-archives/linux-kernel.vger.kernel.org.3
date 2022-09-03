Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A455ABFE5
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 18:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbiICQxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 12:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbiICQxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 12:53:40 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA35B4B4BE
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 09:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1662224018;
        bh=t52IjX6+hBLIxyQMJHaMiz0wEz1Uswpk4fyzMkyIEAw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=JETq2/CbFjHgWSfUSgGE/9SA/kHRz+tdtSQ7zd+KIjqlcevtKyCZ7MBMrkaA9lU8o
         GZ6z35DI4ESFeMUlcHz+BP5CyjEaXPhkhYt73hKKS+yJv7iywDVg+3A7BCQmohO11G
         jafxS/mtZQmRXqoJrBVND2Kd1OM6o4P91jdJjBuE=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id DC7C366783;
        Sat,  3 Sep 2022 12:53:36 -0400 (EDT)
Message-ID: <0b2d115c42ff6cb9b8c65d852ec2f0746ca6e8d9.camel@xry111.site>
Subject: Re: [PATCH 1/3] LoongArch: tools: Add relocs tool support
From:   Xi Ruoyao <xry111@xry111.site>
To:     Jinyang He <hejinyang@loongson.cn>,
        Youling Tang <tangyouling@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Date:   Sun, 04 Sep 2022 00:53:34 +0800
In-Reply-To: <fffdd2ac-4ba6-8eb3-f269-b22a3d9c32f6@loongson.cn>
References: <1662113335-14282-1-git-send-email-tangyouling@loongson.cn>
         <1662113335-14282-2-git-send-email-tangyouling@loongson.cn>
         <c9880165f0355fc3be3ec23153b43ad33e558b5d.camel@xry111.site>
         <4df8a26c49a35c1fce36d80c370f738fa71a2bef.camel@xry111.site>
         <f0e77716-9533-724a-2ea9-86bc5b52066c@loongson.cn>
         <78a4a6b0970c309daa336a2329e69d28df486552.camel@xry111.site>
         <fffdd2ac-4ba6-8eb3-f269-b22a3d9c32f6@loongson.cn>
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

On Sun, 2022-09-04 at 00:23 +0800, Jinyang He wrote:
> On 2022/9/3 18:49, Xi Ruoyao wrote:
>=20
> > On Sat, 2022-09-03 at 09:57 +0800, Youling Tang wrote:
> > > > > Unlike (pre-r6) MIPS, LoongArch has a complete support for PIC, a=
nd
> > > > > currently LoongArch toolchain always produces PIC (except, if -Wa=
,-mla-
> > > > > {local,global}-with-abs or la.abs macros are used explicitly).
> > > > >=20
> > > > > So would it be easier to review and correct the uses of "la.abs" =
in the
> > > > > code, and make the main kernel image a real PIE?=C2=A0 Then we ca=
n load it
> > > > > everywhere w/o any need to do relocation at load time.
> > > At the beginning I also wanted to make the main kernel image a real P=
IE
> > > and tried it, some of the "la.abs" can be modified, but I encountered
> > > difficulties in modifying the=C2=A0 exception handling code part, the=
 kernel
> > > will not=C2=A0 boot after modification :(, I will continue to work ha=
rd try.

> > I just tried the same thing and get the same result :(.=C2=A0 Will spen=
d
> > several hours reading the LoongArch manual about exception...

The reason is the handler code is not executed in linker address, but
copied elsewhere.  Then PC-relative offset is broken.  I managed to work
around it by creating a trampoline and jump into the handler, instead of
copy the handler code.  Then I could remove most "la.abs" occurrence
(except two in kernel entry point, which seem deliberately used):

- https://github.com/xry111/linux/commit/56a433f
- https://github.com/xry111/linux/commit/48203e6

Using the trampoline in handler table will definitely lead to sub-
optimal performance. I just use it as a proof-of-concept. Later we may
use some assembler trick to generate hard-coded handler table with
correct PC-relative offsets.

> The following ideas are based on experience, without validation. Patches
> show that three types of relocation are needed to be done.
> 1, GOT is generated by toolchain, so=C2=A0 I think eliminating them by=
=20
> toolchain is better.

https://gcc.gnu.org/pipermail/gcc-patches/2022-September/600797.html

I stop to read the mail here because it's 00:52 AM now :).

> 2, Ex_table is generated but striped relocation info. We can plays pcrel
> way to resolve this problem. One of ways like follows, (pseudo-code)

/* snip */


--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
