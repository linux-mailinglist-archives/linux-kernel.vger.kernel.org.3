Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092D34FD78D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377282AbiDLJep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388440AbiDLJWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 05:22:12 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1E546676
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 01:28:36 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B09881C0014;
        Tue, 12 Apr 2022 08:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649752115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wzGSuUZ52CEXpm0PjnzfqryT/AQxVArAKAFDHRtNmXY=;
        b=hyMuocSLSq+lLIQ8M72hif0KMCKsTDDXZeOqDwiA2O+v3q/dvAS/1JbUle4m64ZC6ZGCvF
        LpPgQQVD5SoJrrNEZbaxXjN8ZbXIkRsd1w5yXhiuswDfYieCnb06YSVeY92LMt5D+Q9qYD
        TysR0VEHDbAEt1QE+CwwHvgaWBjAK1zJ2+35Eelc3TRDZ4cw6ucnsKTWibqcBHIhRphWRf
        onjHrZIm6100vw631T7BiLHk8Fvf80WyfkpTe8V8RJaOXt8QrqrLj12yn33CmBGlfRKX0V
        G3FesljFtwLtVcRAzfukTp0/b1ErKARhYxZxP4YCN7aYwxFPPQm6VBnpumZoIw==
Date:   Tue, 12 Apr 2022 10:28:32 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Bastian Hecht <hechtb@googlemail.com>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: rawnand: Fix return value check of
 wait_for_completion_timeout
Message-ID: <20220412102832.09957c35@xps13>
In-Reply-To: <bf603638-cc34-b185-3001-9caeba1884d7@gmail.com>
References: <202204121253.NcZifMQi-lkp@intel.com>
        <20220412063703.8537-1-linmq006@gmail.com>
        <20220412090649.33bb3f8b@xps13>
        <61783400-4df2-47af-78a7-7acb715c3a71@gmail.com>
        <20220412094822.3818ebc2@xps13>
        <bf603638-cc34-b185-3001-9caeba1884d7@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miaoqian,

linmq006@gmail.com wrote on Tue, 12 Apr 2022 16:23:24 +0800:

> Hi Miquel,
>=20
> On 2022/4/12 15:48, Miquel Raynal wrote:
> > =20
> >>> Hi Miaoqian,
> >>>
> >>> linmq006@gmail.com wrote on Tue, 12 Apr 2022 06:36:52 +0000:
> >>>   =20
> >>>> wait_for_completion_timeout() returns unsigned long not int.
> >>>> It returns 0 if timed out, and positive if completed.
> >>>> The check for <=3D 0 is ambiguous and should be =3D=3D 0 here
> >>>> indicating timeout which is the only error case.
> >>>>
> >>>> Fixes: 83738d87e3a0 ("mtd: sh_flctl: Add DMA capabilty")
> >>>> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> >>>> ---
> >>>> change in v2:
> >>>> - initialize ret to 1.
> >>>> ---
> >>>>  drivers/mtd/nand/raw/sh_flctl.c | 8 +++++---
> >>>>  1 file changed, 5 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/drivers/mtd/nand/raw/sh_flctl.c b/drivers/mtd/nand/raw/=
sh_flctl.c
> >>>> index b85b9c6fcc42..2373251f585b 100644
> >>>> --- a/drivers/mtd/nand/raw/sh_flctl.c
> >>>> +++ b/drivers/mtd/nand/raw/sh_flctl.c
> >>>> @@ -384,7 +384,8 @@ static int flctl_dma_fifo0_transfer(struct sh_fl=
ctl *flctl, unsigned long *buf,
> >>>>  	dma_addr_t dma_addr;
> >>>>  	dma_cookie_t cookie;
> >>>>  	uint32_t reg;
> >>>> -	int ret;
> >>>> +	int ret =3D 1;   =20
> >>> Does not look right. I know this function returns > 0 on positive
> >>> outcomes but this does not make any sense in the first place.   =20
> >> Yes, I made a mistake, Now I realize that in v2, it will return 1 in e=
rror path
> >>
> >> when DMA submit failed. =20
> > Not 1, but a proper error code please (-ETIMEDOUT, -EINVAL, whatever)
> > =20
> >> And for patch v1, it will return 0=C2=A0 if calls wait_for_completion_=
timeout succeeds.
> >> =20
> >>> This function is static and only called twice, please turn it into
> >>> something like:
> >>>
> >>> if (dma_fifo_transfer())
> >>> 	error
> >>> else
> >>> 	ok   =20
> >> So I want to keep ret>0 means success.
> >>
> >> Or could I set ret > 0 after in wait_for_completion_timeout() success =
path?
> >>
> >> like:
> >>
> >> =C2=A0=C2=A0=C2=A0 if(time_left =3D=3D 0)
> >>
> >> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ret =3D -ETIM=
EDOUT;
> >>
> >> =C2=A0=C2=A0=C2=A0 else
> >>
> >> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 ret =3D 1; =20
> > You can initialize ret to zero at to top. So that anything !=3D 0 is an
> > error (like a lot of functions in the kernel).  =20
>=20
> Thanks for your advice, I will do this.
> > And use:
> >
> > 	if (dma_fifo_transfer())
> > 		error(); =20
> I think keeping the original condition structure is better,
> something like:
>=20
> if (dma_fifo_transfer()=3D=3D0)

  if (cond && cond && !dma_fifo_transfer())

> 	succeed();
>=20
> In this way, only minor changes is needed=E2=80=94=E2=80=94only need to u=
pdate the symbol in condition.
> Otherwise It needs to restructure the code and be more complicated.
>=20
>=20
> Thanks,
>=20
> >> What do you think?
> >>
> >>
> >> Thanks,
> >> =20
> >>>> +	unsigned long time_left;
> >>>> =20
> >>>>  	if (dir =3D=3D DMA_FROM_DEVICE) {
> >>>>  		chan =3D flctl->chan_fifo0_rx;
> >>>> @@ -425,13 +426,14 @@ static int flctl_dma_fifo0_transfer(struct sh_=
flctl *flctl, unsigned long *buf,
> >>>>  		goto out;
> >>>>  	}
> >>>> =20
> >>>> -	ret =3D
> >>>> +	time_left =3D
> >>>>  	wait_for_completion_timeout(&flctl->dma_complete,
> >>>>  				msecs_to_jiffies(3000));
> >>>> =20
> >>>> -	if (ret <=3D 0) {
> >>>> +	if (time_left =3D=3D 0) {
> >>>>  		dmaengine_terminate_all(chan);
> >>>>  		dev_err(&flctl->pdev->dev, "wait_for_completion_timeout\n");
> >>>> +		ret =3D -ETIMEDOUT;
> >>>>  	}
> >>>> =20
> >>>>  out:   =20
> >>> Thanks,
> >>> Miqu=C3=A8l   =20
> >
> > Thanks,
> > Miqu=C3=A8l =20


Thanks,
Miqu=C3=A8l
