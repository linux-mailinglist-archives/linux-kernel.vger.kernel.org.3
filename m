Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A7655AEDB
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 06:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbiFZEcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 00:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiFZEcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 00:32:20 -0400
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D29F120B4
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 21:32:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1656217902; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=mhbi1uu6vVxUi2jFtaaqGSWBzfGI4Fybg1G8k+5J1cx6Yi8/54IB9tCWG9SN/Wz5RJDjdGZrYANuA/JsSWhe7G3aaCdLAUnsNnRkufCA/f1A+mWhpqgkPniAFnymPXuYDGgWx3TlPAIL28XmRMXhh318G+qHA+4iPPVxR54y7gU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1656217902; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=m0GJoA8N1D+ADr9TilMdmNJP85FBo9fAO2AjMIO46oY=; 
        b=IHCyZ0TKvEuYpLwe0rTBu1oJzjbmQ9qCGmtyVbbntRVMEW2cBV/QbTWCGt9xyvxzNSk4EZ3UPqLnRbfUgSX/9UxWnpD26GypNUOLGVPaNIw8i0Id3Px0J2umrwwpNHi1cPFly9Wqp8NZ57VW155Jc7TMR1/qhBJWZZvy5xHm02A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1656217902;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=m0GJoA8N1D+ADr9TilMdmNJP85FBo9fAO2AjMIO46oY=;
        b=gW/0BML9giZH5pku8fw9KPRcLzhseBMfCOPqUzllrEtIy+GKArLZPlMxIiXnsUYr
        bImaqdTGV4ry8dVyDVSOlS+XeBL8Q9jHp5fmo5TeqO6EXRmB/46D6Puct7y0RMQ3j3a
        fycPrt3X4DBkv2hS6k6ERvfFDxUmohj5Wa26vdYw=
Received: from edelgard.icenowy.me (59.41.163.103 [59.41.163.103]) by mx.zohomail.com
        with SMTPS id 1656217900652289.35212594776544; Sat, 25 Jun 2022 21:31:40 -0700 (PDT)
Message-ID: <b3a6ca6a4af7773f68f29b443fa5a4e106727e83.camel@icenowy.me>
Subject: Re: [RESEND PATCH] rtc: sun6i: add support for R329 RTC
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Samuel Holland <samuel@sholland.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-sunxi@lists.linux.dev
Date:   Sun, 26 Jun 2022 12:31:33 +0800
In-Reply-To: <20220626042756.58961-1-samuel@sholland.org>
References: <20220626042756.58961-1-samuel@sholland.org>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2022-06-25=E6=98=9F=E6=9C=9F=E5=85=AD=E7=9A=84 23:27 -0500=EF=BC=
=8CSamuel Holland=E5=86=99=E9=81=93=EF=BC=9A
> From: Icenowy Zheng <icenowy@aosc.io>
>=20
> Allwinner R329 has a RTC with a similar time storage with H616 but a
> slightly different clock part.
>=20
> As we have already handled the R329 RTC clocks in the CCU driver, add
> a
> compatible string to RTC driver to allow probing of the RTC.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> Resending this patch separately from Icenowy's R329 series[1] because
> it
> is also needed for D1 (which has R329 as its fallback compatible[2]),
> so
> I would like to get it in to 5.20.

Thanks!

BTW when will you put D1 DTs into kernel?

>=20
> [1]:
> https://lore.kernel.org/lkml/BYAPR20MB2472C608678F3FAEDA7B7541BCF79@BYAPR=
20MB2472.namprd20.prod.outlook.com/
> [2]:
> https://lore.kernel.org/lkml/20220203021736.13434-3-samuel@sholland.org/
>=20
> =C2=A0drivers/rtc/rtc-sun6i.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
> index 57540727ce1c..ed5516089e9a 100644
> --- a/drivers/rtc/rtc-sun6i.c
> +++ b/drivers/rtc/rtc-sun6i.c
> @@ -875,6 +875,8 @@ static const struct of_device_id
> sun6i_rtc_dt_ids[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ .compatible =3D "allwin=
ner,sun50i-h6-rtc" },
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ .compatible =3D "allwin=
ner,sun50i-h616-rtc",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0.data =3D (void *)RTC_LINEAR_DAY },
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ .compatible =3D "allwinner,s=
un50i-r329-rtc",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0.data =3D (void *)RTC_LINEAR_DAY },
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ /* sentinel */ },
> =C2=A0};
> =C2=A0MODULE_DEVICE_TABLE(of, sun6i_rtc_dt_ids);


