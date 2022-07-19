Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDBA57A9A2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 00:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239805AbiGSWGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 18:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237096AbiGSWGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 18:06:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2325439BA4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 15:06:41 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1oDvMN-0006bh-F7; Wed, 20 Jul 2022 00:06:31 +0200
Received: from mgr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1oDvMM-0007qk-Fs; Wed, 20 Jul 2022 00:06:30 +0200
Date:   Wed, 20 Jul 2022 00:06:30 +0200
From:   Michael Grzeschik <mgr@pengutronix.de>
To:     Piyush Mehta <piyush.mehta@xilinx.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, balbi@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, michal.simek@xilinx.com,
        git@xilinx.com, sivadur@xilinx.com
Subject: Re: [PATCH 0/2]  usb: dwc3: core: Enable GUCTL1 bit 10 for fixing
 crc error after resume
Message-ID: <20220719220630.GA24858@pengutronix.de>
References: <20220613124703.4493-1-piyush.mehta@xilinx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
In-Reply-To: <20220613124703.4493-1-piyush.mehta@xilinx.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Piyush!

On Mon, Jun 13, 2022 at 06:17:01PM +0530, Piyush Mehta wrote:
>This patch of the series does the following:
>- Add a new DT "snps,enable_guctl1_resume_quirk" quirk
>- Enable GUCTL1 bit 10 for fixing crc error after resume bug
>  When this bit is set to '1', the ULPI opmode will be changed
>  to 'normal' along with HS terminations after EOR.
>  This option is to support certain legacy ULPI PHYs.
>
>Piyush Mehta (2):
>  dt-bindings: usb: snps,dwc3: Add 'snps,enable_guctl1_resume_quirk'
>    quirk
>  usb: dwc3: core: Enable GUCTL1 bit 10 for fixing crc error after
>    resume bug
>
> .../devicetree/bindings/usb/snps,dwc3.yaml       |  6 ++++++
> drivers/usb/dwc3/core.c                          | 16 ++++++++++++++++
> drivers/usb/dwc3/core.h                          |  6 ++++++
> 3 files changed, 28 insertions(+)

I found your series and am wondering if you are planning to send a v2 of
it? It would really help to see this mainline.

The Xilinx Register Reference states BIT 10 as

RESUME_TERMSEL_XCVRSEL_UNIFY

which seems to be more meaningful than GUCTL1_RESUME_QUIRK. It would
probably make sense to work this in for v2.

The Documentation is also refering more than just opmode to be 0
during EOR. (termsel, xcvrsel, opmode).

https://www.xilinx.com/htmldocs/registers/ug1087/ug1087-zynq-ultrascale-reg=
isters.html#usb3_xhci___guctl1.html

Regards,
Michael

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmLXKuIACgkQC+njFXoe
LGTr7hAArDrtVWqrls/LSuZNB8TcJPoG0qggkJ+gQzs1M3v3r6+S3bhcekzJS3A8
PzJCqURWI9Cbr4hZyptG5OCU85Hizv8XJ8sVKaQONrONoGX6JxpGQSkLanndBy7n
5YwHwqDkgziI5DTytrhx8g9nhHc04XKpaeLk9IZL7Oi2FH3+PCji38VJzLBFTLAO
vHdm4s6TMGoS1Hn5P38PIrarv2ouBj5igSbZWOf7SRv9nUDYq9QtmMQ56GB3sY+u
+LdUHZvJ27+HqBGTLzo9moKpbYkgDq+J33JdUPtSBDFcqVwUl26udynekQoMq1K+
rwQqaBCqSHWE280mnda1NgXQlQhuyg564jYDVvDOZpGJjUEd8RNIi2KzE3VQZEKS
BhKQSH+BV9wsBFKex2/uXejzX62OFL5N/jxRAVeVyt350Yo/vVI4AYLUg+fR3gQw
eCGn+szhH9veQnq6UfWQEIl/oy7ueUUcPKSFKfQBhfx6sBMRqAzIADtko5Uhg0s2
VYs6e1RvARPodon02BMyFIR4G8G8Fo/8hnmUHw/p+A1tn4xQo1dCqX1XQeIRrmt9
lJK1q6XUX8piY4/n3Dntc3fJZHzDkadwJEK+fcS5feNl2ZJQnhp0bPb7Avyrqf9w
l2MAmmK9ewj7VeXFAKxxW03TcQbXt/ayP4l2E2Jkyw8dQ3HWqYo=
=P5m6
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
