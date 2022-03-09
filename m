Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEFC4D2D60
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 11:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbiCIKrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 05:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbiCIKrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 05:47:45 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363176C941
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 02:46:46 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KD85J0yKdz4xYy;
        Wed,  9 Mar 2022 21:46:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1646822804;
        bh=UNUfMtbu8jQxJ8Ldp1KCgA9gdyw7U6mYfXdtMhAz3JI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ksce+MO22Ocbz72HvCfAJVVGcoiTU526DWQbDfqV/6oa144msQGikKsMAeaAbrg+M
         WIDpNdyWPJVpJU9Vor6F+HsHbxA+GRZXGonPGbI+zNoODL3ZdsTAKZ4iMBKqiCix1L
         /f8tYlw1G/EX94rFMbYwdcdQXsNOiAHbj+2DDnFelgxJ2B7DC0SFB5FeqAKigaB6ap
         LiIHjxR7xKTvJEPzw9Jr8lQ14lLH7g3+UvxGB8f4mJK6ul8+OBMDle5O+LN/UbywQq
         N2PbIj1eWmzBF7C/hasBQKYLcWQnp2otkIuLvzX8EIKYcNVKl5xMvWhpDCZzOdMazg
         d32soOd8EXfeg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Hangyu Hua <hbh25y@gmail.com>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "paulus@samba.org" <paulus@samba.org>,
        "peng.hao2@zte.com.cn" <peng.hao2@zte.com.cn>,
        "wen.yang99@zte.com.cn" <wen.yang99@zte.com.cn>
Cc:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] powerpc: 8xx: fix a return value error in mpc8xx_pic_init
In-Reply-To: <87b40493-7630-f714-27f4-90ad2a5a7c12@csgroup.eu>
References: <20220223070223.26845-1-hbh25y@gmail.com>
 <87o82fn6yw.fsf@mpe.ellerman.id.au>
 <87b40493-7630-f714-27f4-90ad2a5a7c12@csgroup.eu>
Date:   Wed, 09 Mar 2022 21:46:43 +1100
Message-ID: <87ilsnmmi4.fsf@mpe.ellerman.id.au>
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

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 09/03/2022 =C3=A0 04:24, Michael Ellerman a =C3=A9crit=C2=A0:
>> Hangyu Hua <hbh25y@gmail.com> writes:
>>> mpc8xx_pic_init() should return -ENOMEM instead of 0 when
>>> irq_domain_add_linear() return NULL. This cause mpc8xx_pics_init to con=
tinue
>>> executing even if mpc8xx_pic_host is NULL.
>>>
>>> Fixes: cc76404feaed ("powerpc/8xx: Fix possible device node reference l=
eak")
>>> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
>>> ---
>>>   arch/powerpc/platforms/8xx/pic.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/powerpc/platforms/8xx/pic.c b/arch/powerpc/platforms/=
8xx/pic.c
>>> index f2ba837249d6..04a6abf14c29 100644
>>> --- a/arch/powerpc/platforms/8xx/pic.c
>>> +++ b/arch/powerpc/platforms/8xx/pic.c
>>> @@ -153,6 +153,7 @@ int __init mpc8xx_pic_init(void)
>>=20
>> Expanding the context:
>>=20
>> 	siu_reg =3D ioremap(res.start, resource_size(&res));
>> 	if (siu_reg =3D=3D NULL) {
>> 		ret =3D -EINVAL;
>> 		goto out;
>> 	}
>>=20
>> 	mpc8xx_pic_host =3D irq_domain_add_linear(np, 64, &mpc8xx_pic_host_ops,=
 NULL);
>>>   	if (mpc8xx_pic_host =3D=3D NULL) {
>>>   		printk(KERN_ERR "MPC8xx PIC: failed to allocate irq host!\n");
>>>   		ret =3D -ENOMEM;
>>> +		goto out;
>>>   	}
>>>=20=20=20
>>>   	ret =3D 0;
>>>=20=20=20=09
>> out:
>> 	of_node_put(np);
>> 	return ret;
>> }
>>=20
>> Proper error cleanup should also undo the ioremap() if
>> irq_domain_add_linear() fails.
>
> Uh ...
>
> If siu_reg is NULL, you get a serious problem when __do_irq() calls=20
> mpc8xx_get_irq()

Arguably it shouldn't be assigned to ppc_md.get_irq unless
mpc8xx_pic_init() succeeds. See eg. xics_init().

> unsigned int mpc8xx_get_irq(void)
> {
> 	int irq;
>
> 	/* For MPC8xx, read the SIVEC register and shift the bits down
> 	 * to get the irq number.
> 	 */
> 	irq =3D in_be32(&siu_reg->sc_sivec) >> 26;
>
> 	if (irq =3D=3D PIC_VEC_SPURRIOUS)
> 		return 0;
>
>          return irq_linear_revmap(mpc8xx_pic_host, irq);
>
> }
>
>
> So I'll leave siu_reg as is even if irq_domain_add_linear() fails.
>
> Whatever, if we do something about that it should be done in another=20
> patch I think.

Yeah OK, that's becoming a bit of a larger cleanup. I'll take this patch
as-is.

cheers
