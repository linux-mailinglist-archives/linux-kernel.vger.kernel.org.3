Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF8F5719C4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 14:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbiGLMUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 08:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiGLMUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 08:20:23 -0400
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F2A564CF;
        Tue, 12 Jul 2022 05:20:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1657628362; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=FJj1MZJAFJrfnBPewVGJgduey6uHYBrbH6lGXkQlj1dpr4J2tOphiNlZiKL1Tsyk37f0QapHAV0f5kMaOLDJJFwukDxmV1e6lgmS8uYKGllHhY9EG6kXjdaG0gK9WTVKzNvdz0taQQZztiVAkTOQlGtIKUvV56NCh3sbwq3BZac=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1657628362; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=SxdnHC2dnxNY4yLBqg/y0wuycbRGOVX5whTYGdp2GTw=; 
        b=T1XQ1Ez2wjc4wupOXVhG8YW3VvsbgdrG1XdcJrye5IJQreS54W84054CdfN5KXBsPlGfzXoUt5K8Z8WYUUjFU1nX68sJzNEdPwx3krIhy/TxIlX2Lfxks+0D2DcHujIzJJf4YrY4chR2cpoDztbwkDBWnMZqeGtdHZeWGCJ60Fc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1657628362;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=SxdnHC2dnxNY4yLBqg/y0wuycbRGOVX5whTYGdp2GTw=;
        b=Jwtz8dwblhId0JrvlCSpBmOBx0InzCgsI0Bicb1FXOB1Ikj5g1XZLtyZ3uL2okis
        1YqE9x6FBm/ac6ZGwcGvU9sFNQCJfmiUvNVgFktZbALHCqyJ4l4T4hz/b0YrH12nmp3
        7clzSOv7K+2PsCQ2H1Jnmw0gpzUpqI1tZ7UZft3k=
Received: from edelgard.icenowy.me (59.41.160.3 [59.41.160.3]) by mx.zohomail.com
        with SMTPS id 1657628218526833.9611344929851; Tue, 12 Jul 2022 05:16:58 -0700 (PDT)
Message-ID: <dfa6507c68bae9c62520cf100172e1a79bc201c1.camel@icenowy.me>
Subject: Re: [PATCH 06/12] clk: sunxi=ng: add support for R329 CCUs
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Tue, 12 Jul 2022 20:16:49 +0800
In-Reply-To: <4fc9873e87c11dce23099a24be34465f09f3a9a4.camel@aosc.io>
References: <20220422140902.1058101-1-icenowy@aosc.io>
         <BYAPR20MB2472930AAFFBDC0ACB9A7487BCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
         <c858b944-d72f-4e59-6a1a-329b5b8949c4@sholland.org>
         <4fc9873e87c11dce23099a24be34465f09f3a9a4.camel@aosc.io>
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

=E5=9C=A8 2022-07-12=E6=98=9F=E6=9C=9F=E4=BA=8C=E7=9A=84 19:57 +0800=EF=BC=
=8CIcenowy Zheng=E5=86=99=E9=81=93=EF=BC=9A
> =E5=9C=A8 2022-04-23=E6=98=9F=E6=9C=9F=E5=85=AD=E7=9A=84 21:12 -0500=EF=
=BC=8CSamuel Holland=E5=86=99=E9=81=93=EF=BC=9A
> > On 4/22/22 10:41 AM, icenowy@outlook.com=C2=A0wrote:
> > > From: Icenowy Zheng <icenowy@aosc.io>
> > >=20
> > > Allwinner R329 has two CCUs, one in CPUX and another in PRCM.
> > >=20
> > > Add support for them.
> > >=20
> > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> >=20
> > There is a typo in your commit title. =3D should be -.
> >=20
> > Thanks for updating the driver to use .fw_name and be loadable as a
> > module. All
> > of those changes look good.
> >=20
> > There are still some missing clocks here compared to the BSP, and a
> > couple of
> > other minor issues. Please see my earlier review:
> >=20
> > https://lore.kernel.org/linux-sunxi/99a74950-fdc0-ecfe-e5f0-ba4a7d8751f=
0@sholland.org/
> >=20
> > So far it's been consistent that any settable bits in the CCU
> > registers actually
> > do something. So I would expect all of those bits to have an index
> > reserved in
> > the binding, even if we do not model them. I want to avoid having
> > to
>=20
> Sorry but I don't think it proper to reserve unclear bits, because
> we're just allocating the numbers as a random sequence (in fact it's
> the sequence that it gets implemented).
>=20
> Or consider a structural number scheme, in which a value can be
> uniquely predicted by its name?

Well by thinking a little further, I realized our current CCU DT
binding is just based on implementation details of sunxi-ng drivers
(for example, some intermediate clocks get a number too, just not
exposed to the DT binding header). This continues to prove that
reserving numbers is just needed at all, and the current way to make
CCU DT bindings might be totally wrong.

Maybe we should start to use reasonable slice numbers in the next CCU
driver?

>=20
> > go back and
> > add gates to the binding out-of-order later, like we are doing for
> > H6.
> >=20
> > Regards,
> > Samuel
>=20
>=20
>=20


