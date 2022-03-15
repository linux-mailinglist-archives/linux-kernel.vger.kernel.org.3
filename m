Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6CD4DA1DA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 19:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350899AbiCOSF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 14:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240754AbiCOSF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 14:05:26 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0412DFF;
        Tue, 15 Mar 2022 11:04:09 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id b15so21149599edn.4;
        Tue, 15 Mar 2022 11:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qFfhcnR25QBbKMTyD3WFxgAV3+y7t1gzDzKevMTQXp4=;
        b=msKkh5iCl1d57T9/SCN0EEBJyGOX4BtPLQeFBeNa4eInDUVgX3vsJunXKiBjMpvAqR
         JocA7Qk2JlqFoCCszyCS2eB16UcfFOVwRxkJOcemdAKe72yJ6U83fbIngJrNWqzvXfsq
         RE5EkuSd+KH49482LKo31SpY2+UpcKJZtsHpjYNPf3aMmGIho8skYnaIw8ItYwY4YUjt
         1LBmeIPABm2/vuWLzqO7D9NPKzNhzhTBEwTVhpB8f72uWGAnsBmMeM7trnGWmkA1nfrA
         zW6HEzIP4FYsyIo77UA4Ef5Ow/KRN3KhQ1sgYRFRSmBmGZd2tDVXaGLNhak7vTWgOEd0
         sECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qFfhcnR25QBbKMTyD3WFxgAV3+y7t1gzDzKevMTQXp4=;
        b=Gr+D8iv/W1+VGjIhfzEGEafbZspJNSELJh/vVJrdOYttYAm+XinDIymi/J4dVe8I4q
         zl+RyMY8M7GSFHbotVkFJeawbkSJdF6bxvd1u5pmqNhp9qofeWRJGNDzVemP62WE6mZb
         6mDO3WNhIG9AE33Mvlv656sVUaAPXv9EIbj6bovlSPPZUn7bc6XNXJlUyauW2ne4uINQ
         PzPJgZQyDFuNGT6cVAGdpeiKFCtSwEjtrUau7cFB4l3GzyjTQhvVYmndzBBRlF/sEPBY
         iPLgTPVMjFuJBmc8ln2sy4qUIZY2l326A0QdwubecrtWuA1YUOZpq+Ef9aAxNoWSh4Bm
         OVjw==
X-Gm-Message-State: AOAM5309PKN/7vP15p5oZoICsqZ0n4T1AQJJ9m0ZUiP03HrU938JFw8q
        B9kUYPE1/4bTuOj+Tob6GEg=
X-Google-Smtp-Source: ABdhPJxPoR/tudnRCHZZ6F/QXJ9VwVYOCMtY23ScrIJynkJlCQaY28VxkSwUqDP3grTq3FKfTnxxZQ==
X-Received: by 2002:aa7:c58c:0:b0:415:9ed3:1a59 with SMTP id g12-20020aa7c58c000000b004159ed31a59mr26301986edq.25.1647367448168;
        Tue, 15 Mar 2022 11:04:08 -0700 (PDT)
Received: from kista.localnet (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id v2-20020a17090606c200b006a728f4a9bcsm8490757ejb.148.2022.03.15.11.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 11:04:07 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Niklas =?ISO-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Dmitry Osipenko <digetx@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maxime Ripard <mripard@kernel.org>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Ming Qian <ming.qian@nxp.com>,
        Ondrej Jirman <megous@megous.com>,
        Robert Foss <robert.foss@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Yong Deng <yong.deng@magewell.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: Re: [PATCH v2 47/67] media: platform: rename sunxi/ to allwinner/
Date:   Tue, 15 Mar 2022 19:04:05 +0100
Message-ID: <5701348.MhkbZ0Pkbq@kista>
In-Reply-To: <YjBPuafv1B5dbu/r@pendragon.ideasonboard.com>
References: <cover.1647274406.git.mchehab@kernel.org> <20220315092736.7e805c81@coco.lan> <YjBPuafv1B5dbu/r@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 15. marec 2022 ob 09:35:05 CET je Laurent Pinchart napisal(a):
> On Tue, Mar 15, 2022 at 09:27:36AM +0100, Mauro Carvalho Chehab wrote:
> > Em Tue, 15 Mar 2022 08:54:25 +0200
> > Laurent Pinchart <laurent.pinchart@ideasonboard.com> escreveu:
> >=20
> > > Hi Mauro,
> > >=20
> > > On Tue, Mar 15, 2022 at 06:40:05AM +0100, Mauro Carvalho Chehab wrote:
> > > > Em Mon, 14 Mar 2022 18:22:20 +0100 Jernej =C5=A0krabec escreveu:
> > > >  =20
> > > > > Dne ponedeljek, 14. marec 2022 ob 17:34:42 CET je Mauro Carvalho=
=20
Chehab=20
> > > > > napisal(a): =20
> > > > > > As the end goal is to have platform drivers split by vendor,
> > > > > > rename sunxi/ to allwinner/.
> > > > > >=20
> > > > > > Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>   =20
> > > > >=20
> > > > > I would rather not do that. Everything related to Allwinner is=20
called sunxi,=20
> > > > > albeit there are a few outliers. This is similar to Amlogic/meson=
=20
situation. =20
> > > >=20
> > > > The rationale of having one directory per manufacturer is that, if=
=20
drivers
> > > > for newer platforms with different names from the same manufacturer=
s=20
are=20
> > > > added, those will still fit under allwinner/ and amlogic/.
> > > >=20
> > > > The Kconfig names for sunxi and meson didn't change, nor the driver=
's=20
name.=20
> > > > Also, the directories under allwinner preserve sun<x>i name on them:
> > > >=20
> > > > 	drivers/media/platform/allwinner/
> > > > 	=E2=94=9C=E2=94=80=E2=94=80 sun4i-csi
> > > > 	=E2=94=9C=E2=94=80=E2=94=80 sun6i-csi
> > > > 	=E2=94=9C=E2=94=80=E2=94=80 sun8i-di
> > > > 	=E2=94=94=E2=94=80=E2=94=80 sun8i-rotate
> > > >=20
> > > > and so the directory under amlogic/:
> > > >=20
> > > > 	drivers/media/platform/amlogic/
> > > > 	=E2=94=94=E2=94=80=E2=94=80 meson-ge2d
> > > >=20
> > > > Now, if Allinner decides to release a new platforms named after=20
another star,
> > > > let's say, "Vega" and "Rigel", it would be just a matter of adding=
=20
> > > > "vega/" and "rigel/" directories under allwinner. No need to touch
> > > > media/platform/Kconfig and media/platform/Makefile. Everything will=
=20
happen
> > > > on much more smaller vendor-specific Kconfig/Makefile. =20
> > >=20
> > > But the day Allwinner changes its name to Noloser, we'll have a simil=
ar
> > > problem.=20
> >=20
> > Not really. It will still be a single directory per vendor (whatever
> > name it is).
> >=20
> > > Thnk about Freescale vs. NXP, or Altera bought by Intel.
> >=20
> > Yeah, when some drivers move from one vendor to another one that
> > already exists there, we should probably move the directories, in
> > order to keep things well organized.
>=20
> I'm not sure we should. We still have arch/arm64/boot/dts/freescale/ for
> instance. We can answer that question later though, when confronted with
> the situation.
>=20
> > The worse case scenario is really if, let's say, TI decides to sell the=
ir
> > omap architecture to NXP, keeping the rest. On such case, the best would
> > be to move platform/ti/omap* to the directory of its newer owner.
> >=20
> > That's said, when things like that happen, there are usually a change
> > at MAINTAINERS, as e-mails, mailing lists and contact people will
> > likely change. So, this will very likely generate patches anyway.
> >=20
> > > No
> > > naming scheme is totally future-proof. If the accepted standard throu=
gh
> > > the kernel is to use sunxi to refer to Allwinner SoCs, I don't think
> > > it's a bit idea to go with that.
> >=20
> > I'm not too concerned about the name here, but rather about the
> > process. Needing to do reorg like this is painful, as it causes=20
> > all pending work to fail merging against upstream, requiring rebases.
> > So, we should avoid needing to re-do it by trying our best to avoid
> > the need of another global change like that in the future.
>=20
> Most of the pain we'll go through in the immediate future comes from the
> fact that we never really cared about this. I think renames (of vendors
> or product lines) will be infrequent enough that picking sunxi for
> Allwinner drivers wouldn't be an issue.
>=20
> There's a similar think with Renesas, which had an SH product line and
> then moved to ARM, creating R-Mobile and R-Car (among other product
> liens). That's why we still have drivers/dma/sh/ for Renesas DMA
> drivers.
>=20
> > By organizing entries per vendor, while we may need to do puntual
> > per-vendor adjustments when they rename and change IP with other
> > vendors, the global platform Kconfig/Make will contain a single entry
> > per vendor. I can't foresee any need to change this in the future,
> > if we take care of keeping the entries there properly sorted.
> >=20
> > With regards to naming the per-vendor directory, while I do prefer to h=
ave
> > the  directories named after the vendor, and not after a vendor's nick=
=20
> > name, It should also be ok to use a vendor's nick name, provided that=20
> > such name is meant to be used by all their current and future IP.
> >=20
> > Not sure if "sunxi" is actually a vendor's nick name. It sounds
> > much likely that it is, instead, a brand name that covers their=20
> > current media-related SoC.=20
> >=20
> > Can someone from the vendor shed a light on it?

Allwinner (as a company) isn't directly involved in maintaining upstream Li=
nux=20
support. Drivers are provided by linux-sunxi community, sometimes by cleani=
ng=20
up vendor drivers or more often by writing them from scratch.

That being said, "sunxi" is extensively used in vendor kernel, most often i=
t's=20
directory name containing vendor specific driver. It's derived from SoC fam=
ily=20
name, like sun4i, sun5i, sun5i, sun50i, etc. where number is replaced with =
X.

sunxi is synonym for Allwinner basically from the start. Community build=20
around these SoCs is called linux-sunxi and even entry in MAINTAINERS conta=
ins=20
both names: "ARM/Allwinner sunXi SoC support". Note that sunxi is not limit=
ed=20
to ARM SoCs. RISC-V family is called sun20i.

Hope this helps.

Best regards,
Jernej

>=20
> Maybe we can let the Allwinner upstream community tell us what name to
> pick ? I'm sure they know better than us :-)



>=20
> --=20
> Regards,
>=20
> Laurent Pinchart
>=20


