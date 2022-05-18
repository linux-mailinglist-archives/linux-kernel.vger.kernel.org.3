Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D5C52B19F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 06:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiEREuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 00:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiEREul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 00:50:41 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1490513E3E
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 21:50:38 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L30t33mDSz4xVP;
        Wed, 18 May 2022 14:50:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1652849436;
        bh=LNLCsDkug1r3kbDai+5TpbpwIL81Sv0gHUxwzASZmbE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=kW2YFNy6Mydz+OYZr3o72Pk6e8jcaOqaS4BhdS8uSWLiEn9PZpa7vpwkALAOyPog8
         UW5WkzqvTIHaTUHky6hhvCbL6o4qIDreX25VuFfk5x1pzkEUhloYFNFsr5gmQ8VnPN
         cjIivInaZnZ/wqO8YgTCpRLyMfYhRMqsZtJ+GeqPoN6lBpd9isvAGSH8Zpp+UzjLIb
         HkGjENzvewWhBq42NbX/3UVxAgywDSpd+CmNpuQGB112pt4GuqEgXBzuw5UZVpNv4M
         TLqM2j4Cnchw8HUHHJV+LZUUmQNfj7xMbxsex2HAeEMrTqirY/vQvbDUPG6V7Z8hei
         tyO05KtVFELtA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     YueHaibing <yuehaibing@huawei.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "paulus@samba.org" <paulus@samba.org>
Cc:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] powerpc/book3e: Fix build error
In-Reply-To: <8b169642-5d32-4135-93a7-4969515d1ab0@huawei.com>
References: <20220517094830.27560-1-yuehaibing@huawei.com>
 <0e8b7931-9bfb-1948-c141-c4e612ba0fe6@csgroup.eu>
 <8b169642-5d32-4135-93a7-4969515d1ab0@huawei.com>
Date:   Wed, 18 May 2022 14:50:34 +1000
Message-ID: <87sfp7o351.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YueHaibing <yuehaibing@huawei.com> writes:
> On 2022/5/17 18:45, Christophe Leroy wrote:
>> Le 17/05/2022 =C3=A0 11:48, YueHaibing a =C3=A9crit=C2=A0:
>>> arch/powerpc/mm/nohash/fsl_book3e.c: In function =E2=80=98relocate_init=
=E2=80=99:
>>> arch/powerpc/mm/nohash/fsl_book3e.c:348:2: error: implicit declaration =
of function =E2=80=98early_get_first_memblock_info=E2=80=99 [-Werror=3Dimpl=
icit-function-declaration]
>>>    early_get_first_memblock_info(__va(dt_ptr), &size);
>>>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>> Add missing include file linux/of_fdt.h to fix this.
>>>
>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>>=20
>> Thats for fixing that.
>>=20
>> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>=20
>> It means we don't have any defconfig for 32 bits booke with=20
>> CONFIG_RELOCATABLE ?
>
> Indeed, there is no defconfig with CONFIG_RELOCATABLE under arch/powerpc/=
configs

It's selected by CRASH_DUMP, which is in ppc64_defconfig.

But it's not enabled in corenet32_smp_defconfig which is what I build,
or any of the other 85xx configs.

I guess it should be, I think it's true that RELOCATABLE=3Dy exercises
more interesting code paths?

cheers
