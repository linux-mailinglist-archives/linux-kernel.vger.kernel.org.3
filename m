Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBF457FB2C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbiGYIUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233972AbiGYIUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:20:18 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4629514091
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 01:20:03 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LrtJK6dcZz4x1k;
        Mon, 25 Jul 2022 18:20:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1658737202;
        bh=Wrn2BUW27rZ1SIN5JnOFM+dnk2r7UcKK57unfYC/sd4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Hg8mJWfvVBw1KMVgXUSsxvnOoXxJkLw4ag24+n3PENoq4IhXjFD+y1pcFO8rA4GIP
         0FP23qil4YvTU0bz/Gb8o41Q7ghv2lFpxb1AVkztq9ryFkZiOx4ciQBrStDPfVGoeP
         2TkzldCofvui1w8FfVZq2Pf+5p2MlnUUg9gbOFIa16jN4Nugmdojv8OwIE5+ZTU5iq
         /PnDHcuUMToUst6ONFhGbjJSo0BWoP2CMPR+2AqzKfIiaUhhItSVfZ+Nc136stoHiJ
         kX4TDCUfWO6XmCZ87Ygh8zU/qrpyeCSObjLNE1W4V9bC+ZgjVG98y2dAVyMZA1/ayj
         J9S3R6/uFRFQw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Regression: Linux v5.15+ does not boot on Freescale P2020
In-Reply-To: <20220723150702.jecerkhxhy65dgww@pali>
References: <20220722090929.mwhmxxdd7yioxqpz@pali>
 <6b227478-73b8-2a97-1c78-89570d928739@csgroup.eu>
 <20220723150702.jecerkhxhy65dgww@pali>
Date:   Mon, 25 Jul 2022 18:20:01 +1000
Message-ID: <875yjld2oe.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pali Roh=C3=A1r <pali@kernel.org> writes:
> On Saturday 23 July 2022 14:42:22 Christophe Leroy wrote:
>> Le 22/07/2022 =C3=A0 11:09, Pali Roh=C3=A1r a =C3=A9crit=C2=A0:
>> > Trying to boot mainline Linux kernel v5.15+, including current version
>> > from master branch, on Freescale P2020 does not work. Kernel does not
>> > print anything to serial console, seems that it does not work and after
>> > timeout watchdog reset the board.
>>=20
>> Can you provide more information ? Which defconfig or .config, which=20
>> version of gcc, etc ... ?
>
> I used default defconfig for mpc85xx with gcc 8, compilation for e500
> cores.
>
> If you need exact .config content I can send it during week.
>
>> > I run git bisect and it found following commit:
>> >=20
>> > 9401f4e46cf6965e23738f70e149172344a01eef is the first bad commit
>> > commit 9401f4e46cf6965e23738f70e149172344a01eef
>> > Author: Christophe Leroy <christophe.leroy@csgroup.eu>
>> > Date:   Tue Mar 2 08:48:11 2021 +0000
>> >=20
>> >      powerpc: Use lwarx/ldarx directly instead of PPC_LWARX/LDARX macr=
os
>> >=20
>> >      Force the eh flag at 0 on PPC32.
>> >=20
>> >      Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> >      Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> >      Link: https://lore.kernel.org/r/1fc81f07cabebb875b963e295408cc3dd=
38c8d85.1614674882.git.christophe.leroy@csgroup.eu
>> >=20
>> > :040000 040000 fe6747e45736dfcba74914a9445e5f70f5120600 96358d08b65d32=
00928a973efb5b969b3d45f2b0 M      arch
>> >=20
>> >=20
>> > If I revert this commit then kernel boots correctly. It also boots fine
>> > if I revert this commit on top of master branch.
>> >=20
>> > Freescale P2020 has two 32-bit e500 powerpc cores.
>> >=20
>> > Any idea why above commit is causing crash of the kernel? And why it is
>> > needed? Could eh flag set to 0 cause deadlock?
>>=20
>> Setting the eh flag to 0 is not supposed to be a change introduced by=20
>> that commit. Indeed that commit is not supposed to change anything at=20
>> all in the generated code.
>
> My understanding of that commit is that it changed eh flag parameter
> from 1 to 0 for 32-bit powerpc, including also p2020.

Can you compare the disassembly before and after and find a place where
an instruction has changed?

cheers
