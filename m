Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59D8512DD9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 10:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241870AbiD1IOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbiD1INp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:13:45 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E7FA0BE3;
        Thu, 28 Apr 2022 01:09:40 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id p18so4585017edr.7;
        Thu, 28 Apr 2022 01:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6jNeearvH+hhGDjLkKRhMtvv9bKx6EoH/x/e7DTa8KY=;
        b=o56ujL31V7wnkN7VUd9hMJAvi4RE+WM7gseNBy/zWj3rLUkXCUQPYEz9oPUeqUUdKy
         VhMAAOL7HzhILMEpRyn3EoXNBVUpONutknkQVIk2ZvqE68qZQO/EGedE+xpx7oyJlcAh
         wnZBOqi8SjCB9pK1dnDZsspnaqhZnYIe10Fl7eMD8JQqLYGsmFDJRajprTllxjEjTl0v
         rpQ58PfZQXK/y8efND2yLShSuFuIbVFJRNE7Iyb0jwlkova0ywmF1vfSNju8MQiYT1TT
         byiLiHdCk1OkS0l1/V2fx+Jb/frp/dE8x3NJpTWDAzHztDB4HNABOkTYhTjcd0TArHU3
         aY2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6jNeearvH+hhGDjLkKRhMtvv9bKx6EoH/x/e7DTa8KY=;
        b=HekmjPUlJB1uf5p9FGI2bP/8c8mmeorKb3NTvgCdqJUBRv/FVtPi2UfakchHnsDn3j
         JoV7e3pC/FYpByTdcBIawi22R7v1T5nO4/5ZwtFypeX56q/2TCalZXX6F6mhM7QXUYyi
         fvrgqGzyaNvH9RuFOxF2gZcgb5ETm64/Rli1QL73HXl45P7IG+vvwJxGifRNxAnnyTwM
         cD2PjFR0C6JEjtcBHaxvhLrHOegLfAifBpBFD96hWG2zE733BEjUxZB0VERPAFkm5pFs
         Twx1FVdbFylQb9shWyCYDu4XuVwLpWahPXIN6mU7gB4V1GZitC+i+kuxcl84gV+kqiPO
         Y8hQ==
X-Gm-Message-State: AOAM532pMEeLun/8NjJDoU51/drgV99OqP2GcfsFD3l6n8WDe1/DrJB7
        lbeoMqQXp/orVLZU17ZRnKU=
X-Google-Smtp-Source: ABdhPJztZ8+oV4qu6hJupS3cSC9OJkpEoajvHWbIk6ZrA7gAfI5DNOsmUdXa9+0qvACKdhuKUqf1SA==
X-Received: by 2002:a05:6402:298b:b0:41d:675f:8b44 with SMTP id eq11-20020a056402298b00b0041d675f8b44mr34705939edb.377.1651133379069;
        Thu, 28 Apr 2022 01:09:39 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id g2-20020a056402114200b0042617ba637fsm1130681edw.9.2022.04.28.01.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 01:09:38 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 43/45] media: sun6i-csi: Detect the availability of the ISP
Date:   Thu, 28 Apr 2022 10:09:37 +0200
Message-ID: <5794263.alqRGMn8q6@jernej-laptop>
In-Reply-To: <YmpIjPe8pw+yvGyL@aptenodytes>
References: <20220415152811.636419-1-paul.kocialkowski@bootlin.com> <2029179.KlZ2vcFHjT@jernej-laptop> <YmpIjPe8pw+yvGyL@aptenodytes>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne =C4=8Detrtek, 28. april 2022 ob 09:55:56 CEST je Paul Kocialkowski napi=
sal(a):
> Hi Jernej,
>=20
> Thanks a lot for all your reviews!
>=20
> On Wed 27 Apr 22, 22:07, Jernej =C5=A0krabec wrote:
> > Dne petek, 15. april 2022 ob 17:28:09 CEST je Paul Kocialkowski=20
napisal(a):
> > > Add a helper to detect whether the ISP is available and connected
> > > and store the indication in a driver-wide variable.
> > >=20
> > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > ---
> > >=20
> > >  .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 33 +++++++++++++++++=
++
> > >  .../platform/sunxi/sun6i-csi/sun6i_csi.h      |  3 ++
> > >  2 files changed, 36 insertions(+)
> > >=20
> > > diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > > b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c index
> > > a88deb8ba1e7..f185cbd113c7 100644
> > > --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > > +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > > @@ -25,6 +25,35 @@
> > >=20
> > >  #include "sun6i_csi_capture.h"
> > >  #include "sun6i_csi_reg.h"
> > >=20
> > > +/* ISP */
> > > +
> > > +static bool sun6i_csi_isp_detect(struct sun6i_csi_device *csi_dev)
> > > +{
> > > +	struct device *dev =3D csi_dev->dev;
> > > +	struct fwnode_handle *handle =3D NULL;
> > > +
> > > +	/* ISP is not available if disabled in kernel config. */
> > > +	if (!IS_ENABLED(CONFIG_VIDEO_SUN6I_ISP))
> >=20
> > Where is this symbol defined?
>=20
> That is defined through Kconfig's auto-generated header, from the associa=
ted
> option for the ISP driver. It is defined in the ISP support series so this
> will effectively always be false for now.

Well, then, that driver should be merged before this patch. While I underst=
and=20
that it's likely that ISP driver with such name will eventually materialize=
 in=20
kernel, I don't want to rely on things that are not set in stone, e.g. alre=
ady=20
merged.

Best regards,
Jernej

>=20
> > Best regards,
> > Jernej
> >=20
> > > +		return 0;
> > > +
> > > +	/*
> > > +	 * ISP is not available if not connected via fwnode graph.
> > > +	 * This weill also check that the remote parent node is available.
> > > +	 */
> > > +	handle =3D fwnode_graph_get_endpoint_by_id(dev_fwnode(dev),
> > > +
> >=20
> > SUN6I_CSI_PORT_ISP, 0,
> >=20
> > > +
> >=20
> > FWNODE_GRAPH_ENDPOINT_NEXT);
> >=20
> > > +	if (!handle)
> > > +		return 0;
> > > +
> > > +	fwnode_handle_put(handle);
> > > +
> > > +	dev_info(dev, "ISP link is available\n");
> > > +	csi_dev->isp_available =3D true;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >=20
> > >  /* Media */
> > > =20
> > >  static const struct media_device_ops sun6i_csi_media_ops =3D {
> > >=20
> > > @@ -306,6 +335,10 @@ static int sun6i_csi_probe(struct platform_device
> > > *platform_dev) if (ret)
> > >=20
> > >  		return ret;
> > >=20
> > > +	ret =3D sun6i_csi_isp_detect(csi_dev);
> > > +	if (ret)
> > > +		goto error_resources;
> > > +
> > >=20
> > >  	ret =3D sun6i_csi_v4l2_setup(csi_dev);
> > >  	if (ret)
> > >  =09
> > >  		goto error_resources;
> > >=20
> > > diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
> > > b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h index
> > > 6aa83dd11684..9b105c341047 100644
> > > --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
> > > +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
> > > @@ -22,6 +22,7 @@
> > >=20
> > >  enum sun6i_csi_port {
> > > =20
> > >  	SUN6I_CSI_PORT_PARALLEL		=3D 0,
> > >  	SUN6I_CSI_PORT_MIPI_CSI2	=3D 1,
> > >=20
> > > +	SUN6I_CSI_PORT_ISP		=3D 2,
> > >=20
> > >  };
> > > =20
> > >  struct sun6i_csi_buffer {
> > >=20
> > > @@ -46,6 +47,8 @@ struct sun6i_csi_device {
> > >=20
> > >  	struct clk			*clock_mod;
> > >  	struct clk			*clock_ram;
> > >  	struct reset_control		*reset;
> > >=20
> > > +
> > > +	bool				isp_available;
> > >=20
> > >  };
> > > =20
> > >  struct sun6i_csi_variant {




