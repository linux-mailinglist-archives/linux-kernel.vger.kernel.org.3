Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D680858D8DC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 14:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242922AbiHIMpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 08:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239296AbiHIMpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 08:45:21 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1C955B1
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 05:45:19 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1oLObf-00054K-Cr; Tue, 09 Aug 2022 14:45:11 +0200
Received: from mgr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1oLObc-0005jR-PX; Tue, 09 Aug 2022 14:45:08 +0200
Date:   Tue, 9 Aug 2022 14:45:08 +0200
From:   Michael Grzeschik <mgr@pengutronix.de>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] media: hantro: Add support for RK356x JPEG encoder
Message-ID: <20220809124508.GL14307@pengutronix.de>
References: <20220427224438.335327-1-frattaroli.nicolas@gmail.com>
 <20220427224438.335327-3-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3VRmKSg17yJg2MZg"
Content-Disposition: inline
In-Reply-To: <20220427224438.335327-3-frattaroli.nicolas@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3VRmKSg17yJg2MZg
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nicolas,

On Thu, Apr 28, 2022 at 12:44:37AM +0200, Nicolas Frattaroli wrote:
>The RK3566 and RK3568 SoCs come with a small Hantro instance which
>is solely dedicated to encoding JPEG. This patch adds the necessary
>structs to the Hantro driver to allow it to function.
>
>Tested with the following GStreamer command:
>
>gst-launch-1.0 videotestsrc ! v4l2jpegenc ! matroskamux ! \
>               filesink location=3Dfoo.mkv

I just tried this pipeline on v5.19. The filesize generated is increasing a=
nd
data is generated. However the content seems to be unusable.

When playing foo.mkv with e.g. vlc the following errors, that no JPEG data =
was found
in the images, is generated:


[mjpeg @ 0x7f2f08c1f780] No JPEG data found in image
[mjpeg @ 0x7f2f08c1f780] No JPEG data found in image
[mjpeg @ 0x7f2f08c1f780] No JPEG data found in image
=2E..


The same with gstreamer:

gst-launch-1.0 filesrc location=3Dfoo.mkv ! decodebin ! glimagesink
=2E./ext/jpeg/gstjpegdec.c(1418): gst_jpeg_dec_handle_frame (): /GstPipelin=
e:pipeline0/GstDecodeBin:decodebin0/GstJpegDec:jpegdec0:
Decode error #53: Not a JPEG file: starts with 0x00 0x00
=2E.


Do you have an idea why that is? Did you test the pipeline with an earlier
kernelversion and validated the generated content of foo.mkv?

Regards,
Michael

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--3VRmKSg17yJg2MZg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmLyVs4ACgkQC+njFXoe
LGTYuw/+PelCMxyHigxqTvgAD9DPu7gzli42mTGyGTs7HvtGonypuAk0UbV9W9nG
w7kb/aIrBdUz9X1HBgYcSCtbg5YItDIPou1o3DpvDk68Q/QAETZqmhLRbRgUbf9i
T6TPfKbVij9gcbWmdQYwoMT+TMxdaBZwEB2QSFfDZA7wXeYmv/IEJoX5NjFNdGHt
VS20uTP+uCA64ZKW2fVsfbZpF+Auoxs28XIFR++tw5q7QZzBd9seSfzI3sSXra//
Fj154jUUJxRbzeeoB8XeN9QKNgv5PCXO2pWkJiSviC5BKrI31guO4AwyZWRSSS2n
jWhMHm6YSDpzAcZvpMO+vn0xsUjmr7KGYGsuMQMSMNZ70/PPshG+wh1CX3xDxFYM
2NdAzqE7GM8pBCxznhwyPb1VtLiIQedX0tDIuYRJt+0UiQB6Oerwcpd00Nc/H8nP
LAn3vW1RgS7DiCi10pASHei3jNNsSAvrTly0+TNauHj/Tfy2BNI4gwV1VGtFLMy2
yIE+nuwC0xcMrLWj1iRBYa9gyINiU6g0hvkQ2PKWX8zdELEqA66AO61s5vlMrWJb
Le/3i/IAU4PV8fx2j4+pXMTMEoQ6h9SAK7RCITZtWkrZe5qsprWlA4r5JEV4e8EL
jXvzDcq+aLMqujKzFBsfnpetShHewnXxb1kIq8rqgwgFQbnNBXg=
=OcIw
-----END PGP SIGNATURE-----

--3VRmKSg17yJg2MZg--
