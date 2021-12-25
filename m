Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA3847F49E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 23:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbhLYWmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 17:42:52 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:57393 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbhLYWmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 17:42:51 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JLzTj6CNfz4xps;
        Sun, 26 Dec 2021 09:42:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1640472170;
        bh=qiVqpRlRRXS0iAH2nX/AkQBYFrUOx2vQ2Vqp7kM0LCw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ECKWTM9gdi+sCsiy1dHQXyULGKSSWTz2ZLVhuUvcXREX9nG51Nm07U1fOp7KeiGI/
         WFmzX7vg/CXq/BsT5Q5iGJZGoAgB+IkGwm1Ig1mf4/7GC8PgX3M6JUSOvCJgySS9tN
         GMYrpOWwOCAt5rq1FE7zyCzfyPNMmEk1wQ3RZBRLaIvWVOoPU4dpwZAm4wDAvfxwfC
         IQo1vaVUXbCBblQbpa0a41VYClo3FWcRXlzbfHXhTugyjRyIz340RAK0gQly+D+vi9
         GGvp8MMYzz/6Ur5oTIViGAoSb8xsI6nAXfbZcD6MSW3rdh0CF/YT/7TFiJs34cefOd
         tgW+6sSNJ1pzQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Cc:     kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: code conditional on non-existing PPC_EARLY_DEBUG_MICROWATT.
In-Reply-To: <27eefbf2-fc2c-7800-1397-8acfea7ed7e8@csgroup.eu>
References: <CAKXUXMxa6zuTncNjTVHeU7nJ9uvv3KqMtSDocMC7P5hxfrkakQ@mail.gmail.com>
 <27eefbf2-fc2c-7800-1397-8acfea7ed7e8@csgroup.eu>
Date:   Sun, 26 Dec 2021 09:42:48 +1100
Message-ID: <87y2481f2v.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 23/12/2021 =C3=A0 11:21, Lukas Bulwahn a =C3=A9crit=C2=A0:
>> Dear Benjamin, dear Paul, dear Michael,
>>=20
>> with commit 48b545b8018d ("powerpc/microwatt: Use standard 16550 UART
>> for console"), you have some code in arch/powerpc/kernel/udbg_16550.c,
>> conditional on the Kconfig symbol PPC_EARLY_DEBUG_MICROWATT. However,
>> since then, the definition of this Kconfig symbol was never introduced
>> to the mainline repository or current linux-next, nor am I finding any
>> pending patch for that.
>>=20
>> Are you going to add this config definition soon? Or did you identify
>> that this setup code in udbg_16550.c is not actually needed and can we
>> simply drop this code again?
>>=20
>> This issue was identified with the script ./scripts/checkkconfigsymbols.=
py.
>>=20
>
> Was it forgotten when handling comments to=20
> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20200509050340.GD=
1464954@thinks.paulus.ozlabs.org/=20
> ?

Yes. I reported it internally to some folks but I guess they haven't had
time to send a fixup patch.

I'm pretty sure we just need the first three hunks of that patch, but it
would be good if someone with a Microwatt setup could test it.

cheers
