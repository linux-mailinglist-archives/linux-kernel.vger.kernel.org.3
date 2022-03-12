Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D3A4D6FC0
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 16:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbiCLPcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 10:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbiCLPcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 10:32:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E90F192580;
        Sat, 12 Mar 2022 07:31:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3CBC60FE8;
        Sat, 12 Mar 2022 15:31:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014BBC340EB;
        Sat, 12 Mar 2022 15:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647099073;
        bh=bDZ5NHHcQ90J++YX6s/PLHNFT8CKgniuzbMo97CWXHQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KFQyc9EB4uB/9ZHnOI1jDok+Gtl1TMUJ1ME63v6hbGeEUMJO5Rx0H2Nvy8r0tf492
         WMBc5KEx6EU/VLzOfqh6Q+1w1zN6JdSAOvZHbN8Ut0IQT/kEdq/97lQNUPHCjYdMH+
         +Ym7J9B/4AOdIMXKGn6YtKypKIQHPaCLTwqRxXmsQHsusPxUA2IsZHjwfze4ENZVT9
         IvVb8a4syaDHid5BWIouHIwzRA0ihrsEBl1GWRyFqT0ruXnozCHs17rI37AGp6QIo3
         1Y2w0iQXo3bxFNxdv3dU56R3/eZ1qAthTHUSBlzTDmECsuKyugS/Z7WDUqx9vjSi8X
         /pGNNd8de21gQ==
Date:   Sat, 12 Mar 2022 16:31:05 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Niklas =?UTF-8?B?U8O2ZGVybHVuZA==?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Dillon Min <dillon.minfei@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Fabio Estevam <festevam@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH v2 07/38] media: platform: place NXP drivers on a
 separate dir
Message-ID: <20220312163105.1e97ba0c@coco.lan>
In-Reply-To: <7dedaf783d9bc7d26adb427003c17bcdc3f82193.camel@pengutronix.de>
References: <cover.1647006877.git.mchehab@kernel.org>
        <723fbc3e03d8817916a085e218befd6400d299a3.1647006877.git.mchehab@kernel.org>
        <7dedaf783d9bc7d26adb427003c17bcdc3f82193.camel@pengutronix.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 11 Mar 2022 15:33:36 +0100
Philipp Zabel <p.zabel@pengutronix.de> escreveu:

> On Fr, 2022-03-11 at 15:07 +0100, Mauro Carvalho Chehab wrote:
> > In order to cleanup the main platform media directory, move NXP
> > driver to its own directory.
> >=20
> > Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> > ---
> >=20
> > To avoid mailbombing on a large number of people, only mailing lists
> > were C/C on the cover.
> > See [PATCH v2 00/38] at: =20
> > https://lore.kernel.org/all/cover.1647006877.git.mchehab@kernel.org/
> >  =20
> [...]
> > diff --git a/drivers/media/platform/nxp/Makefile
> > b/drivers/media/platform/nxp/Makefile
> > new file mode 100644
> > index 000000000000..147bd7ad4ef4
> > --- /dev/null
> > +++ b/drivers/media/platform/nxp/Makefile
> > @@ -0,0 +1,5 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +obj-$(CONFIG_VIDEO_IMX_PXP)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0+=3D imx-pxp.o
> > +obj-$(CONFIG_VIDEO_VIU)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0+=3D fsl-viu.o
> > +obj-$(CONFIG_VIDEO_MX2_EMMAPRP)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0+=3D mx2_emmaprp.o=
 =20
>=20
> Should these be sorted as well?

I'll sort and drop the extra whitespaces.

>=20
> regards
> Philipp



Thanks,
Mauro
