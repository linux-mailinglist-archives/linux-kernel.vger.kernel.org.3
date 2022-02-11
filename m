Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E554B2934
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 16:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238851AbiBKPlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 10:41:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbiBKPlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 10:41:02 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4564713A;
        Fri, 11 Feb 2022 07:41:00 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 616F21BF204;
        Fri, 11 Feb 2022 15:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644594058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qp1uvSCll9e+XoqAo0K2+ZnWbyAAKcHSRy3v4H7ll4g=;
        b=l8WQv/CAyMdPT6fSHDJ3FxJ6V8xVqjZxq7jsfX0VRcHye3b8E5WRDWp3ivSulUGKIdWp5k
        x06WdR4HOSoPNhn/wo4DYc6FmnxRA9JR2hms7/1UpjETMSDN8yANV9aaiPY825ZPA/VGBf
        dxC/tMApm6e+RjnAw2EQwCAu/nWicZz2nhlC6s4Elx1UZ4BhGjXs7XRPRg5W1stpj5DmR1
        aMVIHtYA3tD2jmQ80mnbmW5U5ckKyivbTElJs49T+8IOwYdfneRn2vmR//B8H/qpxCwaM6
        p3dIdpL+CUtFnwp1UO3IHXM7TDF7MBvr0fLJ/dG0D0Izof12iQvkPPh4CLX3+w==
Date:   Fri, 11 Feb 2022 16:40:55 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-staging@lists.linux.dev,
        Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helen Koike <helen.koike@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 32/66] media: sun6i-csi: Add capture state using vsync
 for page flip
Message-ID: <YgaDhxYLciLUm5ks@aptenodytes>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
 <20220205185429.2278860-33-paul.kocialkowski@bootlin.com>
 <20220209092642.hhppmrrekj7zrorj@houat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EeBCw5B6aMoynUBc"
Content-Disposition: inline
In-Reply-To: <20220209092642.hhppmrrekj7zrorj@houat>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EeBCw5B6aMoynUBc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed 09 Feb 22, 10:26, Maxime Ripard wrote:
> On Sat, Feb 05, 2022 at 07:53:55PM +0100, Paul Kocialkowski wrote:
> > This introduces a new state structure and associated helpers for
> > capture, which handles the buffer queue and state for each submitted
> > buffer.
> >=20
> > Besides from the code refactoring, this changes the page flip point
> > to vsync instead of frame done, which allows working with only
> > two buffers without losing frames. This is apparently a more
> > appropriate thing to do with this controller.
>=20
> Why? What issues were you seeing before, how does using a separate
> interrupt addresses it, and what makes you think it's more appropriate?

I'll try to update the commit log to address this, thanks.

One of the main issues that the rework is trying to address is the way
that double buffering is handled, which currently requires up to 3 buffers
to work, due to how buffer configuration is implemented. In particular,
it's synchronizing to the frame done interrupt which seems to hit after
scanout of the next frame begins, so page flips are always delayed by one
frame.

This is currently solved by setting two buffers when starting the stream:
the first one is set before vcap is enabled and seems to be sampled when the
first frame scan begins and the second one is set after and stays until the
second vsync hits, at which point it becomes the current active buffer.
This way no frame is lost but 3 frames are needed to start.

This proposal changes the sync point to vsync which allows page flipping to
happen for the next frame, thus only 2 buffers are required.

Paul

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--EeBCw5B6aMoynUBc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmIGg4cACgkQ3cLmz3+f
v9FBkgf/XeGRgZ1V/7sJ0ZcawpYN5TgUP8CYJqD7lrdYPo8dqJyKNln/wFou2iXQ
vA2rfXQIumoeMEGStvu3RfXFHhEXF3zrScW/DYNfSlhSM0+fKWVhQrJfU8Lsvet2
Zm5qqm5BM+8KjafzCLQWmJj8hXWB1J5goZprtlrlxbSNKFQhaeFE+mrLbYjoMMh0
alNjgE5LeQC2/FmgS1bm9j+7+Zl5c0v5WZU7/QS/i/X7xSgN4oyj3rwhVD1cJ2c/
tq7aNj4H6Bxmtu4U4EgDt4QOGiRqLS/LE7TzV0/w6LfVlj4h9vn5SS0TOPwNWFIL
/t/fdcrPLRjJFc8zm7lRGew/xxd83g==
=qgUb
-----END PGP SIGNATURE-----

--EeBCw5B6aMoynUBc--
