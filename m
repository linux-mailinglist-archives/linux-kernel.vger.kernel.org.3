Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A405F4C1744
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 16:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242292AbiBWPm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 10:42:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241099AbiBWPmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 10:42:17 -0500
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363852D1E5;
        Wed, 23 Feb 2022 07:41:41 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 34AD75802FD;
        Wed, 23 Feb 2022 10:41:38 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 23 Feb 2022 10:41:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=M2/b5MIE6bQJByA3Vh9tC6cYzTZFNeBiNnMth2
        KLMVo=; b=Bnv7woDYcd7mmSSfipVO5la+dn+WX97gG+qYFku5RwmJ0b+uz29gKk
        W/2lgSs3Ox46zW5BJNzdu9QnQWAlaLv9ZEUY0uScxAuhSrTdfl0gsZRpbn1AcuYR
        rp4ogfiwhwIy7fX4XzhoNXVUe1eeXWt2U9LEcNfLrDCarGqOdsOMaBwLKq6lc07C
        TkJ7jeBpIQyorDeqGZ0InOnN44owKvZhafYZamH9gD/VG9LHBpIY8KrmyNlKXmeU
        eCiGVRY7pmgpwMCiDx8x4QwOzvl7/1CU5o57TZXUXTmaZH8/duxrLhtRBf3tyn49
        j2w6NdoCyh5lxb0a9vrXxRjbWQl/WwkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=M2/b5MIE6bQJByA3V
        h9tC6cYzTZFNeBiNnMth2KLMVo=; b=QV9Juy7QQSjZuVHHhURF+1JcKbpnwuM2L
        VBX0qBqM9COq6G8JtlBAGoYKPbuEo+hs+LLmqfg83f1gF0NFFEBeGu+vJf1DmY8O
        RkOddVQ2IlNLls2Oj3ZkY6djaPU4zSBcDqnY6Z/0iUIHZy49MsCds/ZL33u9ch/v
        XetHOyJnIKeMMcKumKLPnQssQ+uO+DjUdMMOt4QblQzlekvmXrX7Cdw2zhJBzdDN
        jc0jXWr9dqAXKhvw3sk/mR4XmLh8trrHmi9ogmq8oIbzZSMIhdSgCAyKh2oBolEm
        4kYXV2zaSg26RpZYRA1icgL6iyLDAVcbbQrBkYREWdhapRc3V6SVw==
X-ME-Sender: <xms:sFUWYm-GEEjdbSALW-ne4zr0sLOEzsXQtkNn_Zyd5wc69QchaF-seA>
    <xme:sFUWYmsTGwCa4aj1bgfQeK6Cx2WlsgGywYi7Yg_ErHCOtJxzNXhtdN_z_Nh5HhqYF
    OHdd9nQg-pDWF5Imfw>
X-ME-Received: <xmr:sFUWYsC-_QYnAVMxuCBJ1m-eY9bXN7V78hbuLSoOd0TrLUfjscuc6K4DsF-X7mzly28hBjWUH6uJLxKEMMSh9bEaiPH4okiUoU0G8Q0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrledtgdejkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeduvdduhfekkeehgffftefflefgffdtheffudffgeevteffheeuiedvvdejvdfg
    veenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    igihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:sFUWYucjTpHs6Qn-MDTcCWWmXKBaJcOi8k7atOJd8k3NlTCjoAZtcQ>
    <xmx:sFUWYrOXvrls4gJweUQTNaIcB_4eu8l17ekbpWVprS4CJ_ltn8bFIg>
    <xmx:sFUWYokFXOZhIiRJnnF2QEvDa3gLV_16w0kxGw56zZN4sFSw0cYyug>
    <xmx:slUWYucAa7gT1-vE7e0qdSDMi9pH5PrgDoV3u88A1vtFcOMsjvpvWg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Feb 2022 10:41:36 -0500 (EST)
Date:   Wed, 23 Feb 2022 16:41:34 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Sui Jingfeng <15330273260@189.cn>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Qing Zhang <zhangqing@loongson.cn>,
        suijingfeng <suijingfeng@loongson.cn>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v10 3/4] drm/lsdc: add drm driver for loongson display
 controller
Message-ID: <20220223154134.y7slxu3jaje2jtwr@houat>
References: <20220220145554.117854-1-15330273260@189.cn>
 <20220220145554.117854-4-15330273260@189.cn>
 <20220222082747.66otrkc4zwvhem7w@houat>
 <54ea69d7-2fac-74dc-2ef6-843a666cff85@189.cn>
 <20220223143912.m727fie3vtdkvklo@houat>
 <0d4a75c4-78bb-4aed-0fa8-88e9cc165896@189.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uwizgizeraqcnone"
Content-Disposition: inline
In-Reply-To: <0d4a75c4-78bb-4aed-0fa8-88e9cc165896@189.cn>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uwizgizeraqcnone
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 23, 2022 at 11:14:12PM +0800, Sui Jingfeng wrote:
>=20
> On 2022/2/23 22:39, Maxime Ripard wrote:
> > On Tue, Feb 22, 2022 at 10:46:35PM +0800, Sui Jingfeng wrote:
> > > On 2022/2/22 16:27, Maxime Ripard wrote:
> > > > > +	if (!of_device_is_available(output)) {
> > > > > +		of_node_put(output);
> > > > > +		drm_info(ddev, "connector%d is not available\n", index);
> > > > > +		return NULL;
> > > > > +	}
> > > > > +
> > > > > +	disp_tims_np =3D of_get_child_by_name(output, "display-timings"=
);
> > > > > +	if (disp_tims_np) {
> > > > > +		lsdc_get_display_timings_from_dtb(output, &lconn->disp_tim);
> > > > > +		lconn->has_disp_tim =3D true;
> > > > > +		of_node_put(disp_tims_np);
> > > > > +		drm_info(ddev, "Found display timings provided by connector%d\=
n", index);
> > > > > +	}
> > > > > +
> > > > > +	connector_type =3D lsdc_get_connector_type(ddev, output, index);
> > > > > +
> > > > > +	if (output) {
> > > > > +		of_node_put(output);
> > > > > +		output =3D NULL;
> > > > > +	}
> > > > > +
> > > > > +DT_SKIPED:
> > > > > +
> > > > > +	/* Only create the i2c channel if display timing is not provide=
d */
> > > > > +	if (!lconn->has_disp_tim) {
> > > > > +		const struct lsdc_chip_desc * const desc =3D ldev->desc;
> > > > > +
> > > > > +		if (desc->have_builtin_i2c)
> > > > > +			lconn->ddc =3D lsdc_create_i2c_chan(ddev, index);
> > > > > +		else
> > > > > +			lconn->ddc =3D lsdc_get_i2c_adapter(ddev, index);
> > > > This looks weird: the connector bindings have a property to store t=
he
> > > > i2c controller connected to the DDC lines, so you should use that
> > > > instead.
> > > >=20
> > > This is not=A0 weird,=A0 ast, mgag200, hibmc do the same thing.
> > And none of them have DT support.
> >=20
> > Maxime
>=20
> You are wrong, ast driver have dt support. See ast_detect_config_mode() in
> drm/ast/ast_main.c
>=20
> static void ast_detect_config_mode(struct drm_device *dev, u32 *scu_rev)
> {
> =A0=A0 =A0struct device_node *np =3D dev->dev->of_node;
> =A0=A0 =A0struct ast_private *ast =3D to_ast_private(dev);
> =A0=A0 =A0struct pci_dev *pdev =3D to_pci_dev(dev->dev);
> =A0=A0 =A0uint32_t data, jregd0, jregd1;
>=20
> =A0=A0 =A0/* Defaults */
> =A0=A0 =A0ast->config_mode =3D ast_use_defaults;
> =A0=A0 =A0*scu_rev =3D 0xffffffff;
>=20
> =A0=A0 =A0/* Check if we have device-tree properties */
> =A0=A0 =A0if (np && !of_property_read_u32(np, "aspeed,scu-revision-id",
> =A0=A0 =A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 scu_rev)) {
> =A0=A0 =A0=A0=A0=A0 /* We do, disable P2A access */
> =A0=A0 =A0=A0=A0=A0 ast->config_mode =3D ast_use_dt;
> =A0=A0 =A0=A0=A0=A0 drm_info(dev, "Using device-tree for configuration\n"=
);
> =A0=A0 =A0=A0=A0=A0 return;
> =A0=A0 =A0}
>=20
> =A0....
>=20
> }

It doesn't seem to probe from the DT though. It uses 4 properties, and
none of them are documented. It's still a widely different case than
your driver that uses the connector binding, and therefore has access to
the ddc bus there.

Maxime

--uwizgizeraqcnone
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYhZVrQAKCRDj7w1vZxhR
xS48AQCiz86aru05sqZwXNd++y8Km72yvxlQbVk5ANA9UCjlYAD+KYiiiZuOLSqM
9g3/jplVDK9jJSxClRqmlsO5loCq/QI=
=H2N/
-----END PGP SIGNATURE-----

--uwizgizeraqcnone--
