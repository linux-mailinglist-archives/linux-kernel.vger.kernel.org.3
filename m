Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B82512F0D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 10:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344327AbiD1Izs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244019AbiD1Izj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:55:39 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3E713D28;
        Thu, 28 Apr 2022 01:52:25 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id B6F65DF75F;
        Thu, 28 Apr 2022 01:52:24 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oin1w0UicEvp; Thu, 28 Apr 2022 01:52:24 -0700 (PDT)
Date:   Thu, 28 Apr 2022 10:52:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1651135944; bh=7GvTiudrSeP0yh5rJkP4MPtvGvfvDnupAezm3TDBDt4=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=Gb9VNMTeIbJt88M70P2ChZEpLzARsNZPKnW5P1YEvAYAATR1enA3hQDZgB6LB4I3F
         tvlBKy3Ym2FewMFg7y0vtIPvuYwCrRvjbXAHNmsNzeLJBfjxJU6Udgc7ANH3lKbJQl
         sq/Ib7WMWWTmqIZVMV/brvdm4sPOkPN0ljnsZqGz9rGhLS6fTiybnNb7DoPp96i/jv
         NcL+f35HjDsjSfYTrz8hXBAt9d9kOnpyb8pgU65UGAz7n1X+6zyFrkpXlwlh0q9BpV
         mg9tH3Hz/ibhQpQiyRjaesmQrwhLdDS3hts0KWJJAW0vv3hlSM3qoggwkZ6ZPbyMNp
         1C80QL0xwe4Ng==
From:   Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm
Subject: [PATCHv2 2/2] media api: Try to make enum usage clearer
Message-ID: <20220428105219.4b068b1f.dorota.czaplejewicz@puri.sm>
In-Reply-To: <20220428083715.75997-1-dorota.czaplejewicz@puri.sm>
References: <20220428083715.75997-1-dorota.czaplejewicz@puri.sm>
Organization: Purism
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/QP/6qVA55yp1tf5Be2CwjWZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/QP/6qVA55yp1tf5Be2CwjWZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Fixed: typo "format" -> "frame size" in enum-frame-size
Added: no holes in the enumeration
Added: enumerations per what?
Added: who fills in what in calls
Changed: "zero" -> "0"
Changed: "given" -> "specified"
Signed-off-by: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
---
 .../v4l/vidioc-subdev-enum-frame-size.rst     | 44 ++++++++++++-------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-frame=
-size.rst b/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-frame-=
size.rst
index c25a9896df0e..2c6fd291dc44 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-frame-size.r=
st
+++ b/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-frame-size.r=
st
@@ -31,18 +31,29 @@ Arguments
 Description
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-This ioctl allows applications to enumerate all frame sizes supported by
-a sub-device on the given pad for the given media bus format. Supported
-formats can be retrieved with the
+This ioctl allows applications to access the enumeration of frame sizes su=
pported by
+a sub-device on the specified pad for the specified media bus format.
+Supported formats can be retrieved with the
 :ref:`VIDIOC_SUBDEV_ENUM_MBUS_CODE`
 ioctl.
=20
-To enumerate frame sizes applications initialize the ``pad``, ``which``
-, ``code`` and ``index`` fields of the struct
-:c:type:`v4l2_subdev_mbus_code_enum` and
-call the :ref:`VIDIOC_SUBDEV_ENUM_FRAME_SIZE` ioctl with a pointer to the
-structure. Drivers fill the minimum and maximum frame sizes or return an
-EINVAL error code if one of the input parameters is invalid.
+The enumerations are defined by the driver, and indexed using the ``index`=
` field
+of the struct :c:type:`v4l2_subdev_mbus_code_enum`.
+Each pair of ``pad`` and ``code`` correspond to a separate enumeration.
+Each enumeeration starts with the ``index`` of 0, and
+the lowest invalid index marks the end of the enumeration.
+
+Therefore, to enumerate frame sizes allowed on the specified pad
+and using the specified mbus format, initialize the
+``pad``, ``which``, and ``code`` fields to desired values,
+and set ``index`` to 0.
+Then call the :ref:`VIDIOC_SUBDEV_ENUM_FRAME_SIZE` ioctl with a pointer to=
 the
+structure.
+
+A successful call will return with minimum and maximum frame sizes filled =
in.
+Repeat with increasing ``index`` until ``EINVAL`` is received.
+``EINVAL`` means that either no more entries are available in the enumerat=
ion,
+or that an input parameter was invalid.
=20
 Sub-devices that only support discrete frame sizes (such as most
 sensors) will return one or more frame sizes with identical minimum and
@@ -72,26 +83,27 @@ information about try formats.
=20
     * - __u32
       - ``index``
-      - Number of the format in the enumeration, set by the application.
+      - Index of the frame size in the enumeration
+    belonging to the given pad and format. Filled in by the application.
     * - __u32
       - ``pad``
-      - Pad number as reported by the media controller API.
+      - Pad number as reported by the media controller API. Filled in by t=
he application.
     * - __u32
       - ``code``
       - The media bus format code, as defined in
-	:ref:`v4l2-mbus-format`.
+	:ref:`v4l2-mbus-format`. Filled in by the application.
     * - __u32
       - ``min_width``
-      - Minimum frame width, in pixels.
+      - Minimum frame width, in pixels. Filled in by the driver.
     * - __u32
       - ``max_width``
-      - Maximum frame width, in pixels.
+      - Maximum frame width, in pixels. Filled in by the driver.
     * - __u32
       - ``min_height``
-      - Minimum frame height, in pixels.
+      - Minimum frame height, in pixels. Filled in by the driver.
     * - __u32
       - ``max_height``
-      - Maximum frame height, in pixels.
+      - Maximum frame height, in pixels. Filled in by the driver.
     * - __u32
       - ``which``
       - Frame sizes to be enumerated, from enum
--=20
2.35.1


--Sig_/QP/6qVA55yp1tf5Be2CwjWZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEExKRqtqfFqmh+lu1oADBpX4S8ZncFAmJqVcMACgkQADBpX4S8
ZndMLw/+M5xYgoggZzFPYiXC9mDlflEUHKjZ1pRt+vhi22i5O2+FEqT7W4jku7h7
88vEUg5W8RI9kSeanCa4nFSlVdedu54uW77MIPA7Y6c3uHWZox8HEaotOSEPoz4+
pV91GXSFdF4jimO55fWIY4oCv2IpP8/X0PtveLt+xFi2bvDApTXKOQ5mkCzccSFc
iIIj7NLvoP5T1oK3EVFixlm+ggFpiRLyfkE5ktzmBtIF8wGTWifIu0mLuNMCXkDP
mQ0D+8Dw4sYHxf9742IICBV0TJGCdk87eeRSU+QwCiGzaHffX3MwmbWkoNNhVfku
Gk7p6LZxw+KKInFplRdl3TNxjNWiMGFX0+PpKFsftKZmzV/f1EtJoov7IjIVowlR
NzN102hzv7PISaYlSeh1JEwnd3C1fSwHg+Dmolg74lfeW74c0cJXFwIhNLuol6/S
2SM+f2L5TqNxEgWWDArtrrGJjuCsVfDFzgkJhukDJ2ApYte4AjbNck//BW1rRxk5
ExY/NOG0QXGz1kdxnw9rSDfBkIyiyXiii143N0tsR02KdhbnPRGpEIrJikrjm3tp
DLEfObsrLgZtbK3sZ+KrioQZhDkapR0UZ9PBeDNGMyuUNjmQPWMNlLAGkbhLoce6
4Dec4AYe49/UN0l/KqeAFh5+zyJUDelm6NrncgndGasCTtTay0k=
=OT3L
-----END PGP SIGNATURE-----

--Sig_/QP/6qVA55yp1tf5Be2CwjWZ--
