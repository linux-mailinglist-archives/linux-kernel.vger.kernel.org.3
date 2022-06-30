Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D251656158D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 10:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbiF3I7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 04:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234012AbiF3I7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 04:59:01 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E037AF585;
        Thu, 30 Jun 2022 01:58:57 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5DED124000F;
        Thu, 30 Jun 2022 08:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1656579535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=89fMKXThRMbfnxK3x4C5LtcV95DQSbT+9sICTdF5QyA=;
        b=KNbtNjU4PuHLFcDfwedq/EcJljUhoSqijcpl2WajqxXPMaPk0wdAbJvjtDaTWp/69E0cXt
        vY0hMypuvNSQDdpdohMihglIP8Zbw97JEW28DQYGdoqETX/ZdnRYjZ8SLhvKoLw5iROm6t
        QkYmRgG3tNRSdfm3y1yvadZ7VH42oS+U0huISZ5mLAucGCV9rNYzO1NaWo13HzyHUkJtqO
        IiXJ3N5sb5qj2ZNzJd7AXcFd+Xz4byy2Aalrz8fwEchtc3pli1tW5g+KcD3YXPnLCkNd9h
        o94lHBHCKC3KNZV/ZPqD0l2Tgg3jLpTiuYi5RtFfK0rLFWGAnb/2jjCMVfe41A==
Date:   Thu, 30 Jun 2022 10:58:51 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] memory: renesas-rpc-if: Pass device instead of
 rpcif to rpcif_*()
Message-ID: <20220630105851.59e12f77@xps-13>
In-Reply-To: <2df6673b-6f8d-19c2-90ca-342e3ba72040@linaro.org>
References: <cover.1656341824.git.geert+renesas@glider.be>
        <e313b7f9a856fd8546aabb20d44d10e3af6676c6.1656341824.git.geert+renesas@glider.be>
        <20220630092552.68a8b3ff@xps-13>
        <2df6673b-6f8d-19c2-90ca-342e3ba72040@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
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

Hi Krzysztof,

krzysztof.kozlowski@linaro.org wrote on Thu, 30 Jun 2022 10:46:51 +0200:

> On 30/06/2022 09:25, Miquel Raynal wrote:
> > Hi Krzysztof,
> >=20
> > geert+renesas@glider.be wrote on Mon, 27 Jun 2022 17:31:13 +0200:
> >  =20
> >> Most rpcif_*() API functions do not need access to any other fields in
> >> the rpcif structure than the device pointer.  Simplify dependencies by
> >> passing the device pointer instead.
> >>
> >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >> ---
> >>  drivers/memory/renesas-rpc-if.c | 32 ++++++++++++++++----------------
> >>  drivers/mtd/hyperbus/rpc-if.c   | 18 +++++++++--------- =20
> >=20
> > [...]
> >  =20
> >> diff --git a/drivers/mtd/hyperbus/rpc-if.c b/drivers/mtd/hyperbus/rpc-=
if.c
> >> index d00d302434030b20..41734e337ac00e40 100644
> >> --- a/drivers/mtd/hyperbus/rpc-if.c
> >> +++ b/drivers/mtd/hyperbus/rpc-if.c
> >> @@ -56,7 +56,7 @@ static void rpcif_hb_prepare_read(struct rpcif *rpc,=
 void *to,
> >>  	op.data.nbytes =3D len;
> >>  	op.data.buf.in =3D to;
> >> =20
> >> -	rpcif_prepare(rpc, &op, NULL, NULL);
> >> +	rpcif_prepare(rpc->dev, &op, NULL, NULL);
> >>  }
> >> =20
> >>  static void rpcif_hb_prepare_write(struct rpcif *rpc, unsigned long t=
o,
> >> @@ -70,7 +70,7 @@ static void rpcif_hb_prepare_write(struct rpcif *rpc=
, unsigned long to,
> >>  	op.data.nbytes =3D len;
> >>  	op.data.buf.out =3D from;
> >> =20
> >> -	rpcif_prepare(rpc, &op, NULL, NULL);
> >> +	rpcif_prepare(rpc->dev, &op, NULL, NULL);
> >>  }
> >> =20
> >>  static u16 rpcif_hb_read16(struct hyperbus_device *hbdev, unsigned lo=
ng addr)
> >> @@ -81,7 +81,7 @@ static u16 rpcif_hb_read16(struct hyperbus_device *h=
bdev, unsigned long addr)
> >> =20
> >>  	rpcif_hb_prepare_read(&hyperbus->rpc, &data, addr, 2);
> >> =20
> >> -	rpcif_manual_xfer(&hyperbus->rpc);
> >> +	rpcif_manual_xfer(hyperbus->rpc.dev);
> >> =20
> >>  	return data.x[0];
> >>  }
> >> @@ -94,7 +94,7 @@ static void rpcif_hb_write16(struct hyperbus_device =
*hbdev, unsigned long addr,
> >> =20
> >>  	rpcif_hb_prepare_write(&hyperbus->rpc, addr, &data, 2);
> >> =20
> >> -	rpcif_manual_xfer(&hyperbus->rpc);
> >> +	rpcif_manual_xfer(hyperbus->rpc.dev);
> >>  }
> >> =20
> >>  static void rpcif_hb_copy_from(struct hyperbus_device *hbdev, void *t=
o,
> >> @@ -105,7 +105,7 @@ static void rpcif_hb_copy_from(struct hyperbus_dev=
ice *hbdev, void *to,
> >> =20
> >>  	rpcif_hb_prepare_read(&hyperbus->rpc, to, from, len);
> >> =20
> >> -	rpcif_dirmap_read(&hyperbus->rpc, from, len, to);
> >> +	rpcif_dirmap_read(hyperbus->rpc.dev, from, len, to);
> >>  }
> >> =20
> >>  static const struct hyperbus_ops rpcif_hb_ops =3D {
> >> @@ -130,9 +130,9 @@ static int rpcif_hb_probe(struct platform_device *=
pdev)
> >> =20
> >>  	platform_set_drvdata(pdev, hyperbus);
> >> =20
> >> -	rpcif_enable_rpm(&hyperbus->rpc);
> >> +	rpcif_enable_rpm(hyperbus->rpc.dev);
> >> =20
> >> -	error =3D rpcif_hw_init(&hyperbus->rpc, true);
> >> +	error =3D rpcif_hw_init(hyperbus->rpc.dev, true);
> >>  	if (error)
> >>  		goto out_disable_rpm;
> >> =20
> >> @@ -150,7 +150,7 @@ static int rpcif_hb_probe(struct platform_device *=
pdev)
> >>  	return 0;
> >> =20
> >>  out_disable_rpm:
> >> -	rpcif_disable_rpm(&hyperbus->rpc);
> >> +	rpcif_disable_rpm(hyperbus->rpc.dev);
> >>  	return error;
> >>  } =20
> >=20
> > This will only apply on top of mtd/next, because that
> > rpcif_disable_rpm() balance call was very recently contributed by Geert:
> > https://lore.kernel.org/linux-mtd/f3070e1af480cb252ae183d479a593dbbf947=
685.1655457790.git.geert+renesas@glider.be/
> >=20
> > So we need to first share an immutable tag on the current mtd/next
> > branch. Richard, that is my vacation gift for you :) =20
>=20
> I don't want entire mtd/next. I could take Renesas hyperbus specific
> commits.

I applied this patch a week ago and did not remembered there was a
possibly conflicting series aside.

> Another solution is me to rebase on some rcX, if that commit
> was sent as fix for current cycle.

Unfortunately, no.

> The third option is to simply resolve a conflict - which should looks
> pretty easy and compile-testable. In that case the commit should be
> rebased on my v5.19-rc1.

I believe it should work. As this is mostly a cleanup, you can also
wait 5.20-rc1.

Thanks,
Miqu=C3=A8l
