Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3E250B420
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 11:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446036AbiDVJep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 05:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445941AbiDVJeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:34:36 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749B453728;
        Fri, 22 Apr 2022 02:31:42 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 00769E041E;
        Fri, 22 Apr 2022 02:31:12 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OBw0JyK1CiTz; Fri, 22 Apr 2022 02:31:10 -0700 (PDT)
Date:   Fri, 22 Apr 2022 11:30:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1650619870; bh=Onm9kRIqSZOU/4DiXxTyHXXHiBJ5pmGSDgQdiFJ83uU=;
        h=Date:From:To:Subject:From;
        b=reNQs44XviBWtVS9QHoMQnWNAV2ZctppQb/KImRQ8CZXVIzDtE9zliPTSARCCxgjD
         a1YhnR1WvUFFxVUliNRGOYJU47MlK/vgODfEDRBMsTTVzpYnaFoerBUeCliMRC3Gpc
         s5suBV8oB/ScwIps7wyzaFu65x9xOhjw4xlq9tJvT+ISZcwViO5lFgLZ5SdCxdVRML
         i5fVFCvLsDocuxcwoOG1eMROMCblMI/DQe8CSCNjJ/mkKLZeH5L52LXAVCzmIfvBXx
         11CYRe2VRMz7UluAk1c/ZHps8BViBjLm3sc8RRdXwdOPNoBe1hW+wx+sJSzIckr/AY
         su5eiee9amL4w==
From:   Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm
Subject: [PATCH] Documentation/media: Try to make enum usage clearer
Message-ID: <20220422092542.1333177-1-dorota.czaplejewicz@puri.sm>
Organization: Purism
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//UOGO4TQ=PO+oqzL++tVdoa";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//UOGO4TQ=PO+oqzL++tVdoa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Fixed: typo "format" -> "frame size" in enum-frame-size
Added: mbus codes must not repeat
Added: no holes in the array
Added: arrays per what?
Added: who fills in what (questionable naming: caller/driver. caller/callee=
 could be confusing for beginners, they look similar)
Changed: "zero" -> "0"
Changed: "given" -> "selected". "given to me by the driver?" dunno feels li=
ke "selected" or "chosen" are the words to indicate agency to the consumer

---
Hello,

I encountered some difficulties trying to implement a media-api driver, and=
 I traced the problems to not understanding the documentation. Here I try t=
o make the API usage clearer, after consulting with libcamera authors.

Still unclear how it works so I didn't touch it: "which". What is a "try fo=
rmat" vs "active format"?

Cheers,
Dorota Czaplejewicz


 .../v4l/vidioc-subdev-enum-frame-size.rst     | 44 ++++++++++++-------
 .../v4l/vidioc-subdev-enum-mbus-code.rst      | 39 +++++++++++-----
 2 files changed, 55 insertions(+), 28 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-frame=
-size.rst b/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-frame-=
size.rst
index c25a9896df0e..c7afeffb6269 100644
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
+This ioctl allows applications to access the array of frame sizes supporte=
d by
+a sub-device on the selected pad for the selected media bus format.
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
+The arrays are defined by the driver, and indexed using the ``index`` field
+of the struct :c:type:`v4l2_subdev_mbus_code_enum`.
+Each pair of ``pad`` and ``code`` correspond to a separate array.
+Each array starts with the ``index`` of 0, and
+the first invalid index marks the end of array.
+
+Therefore, to enumerate frame sizes allowed on the selected pad
+and using the selected mbus format, initialize the
+``pad``, ``which``, and ``code`` fields to desired values,
+and set ``index`` to 0.
+Then call the :ref:`VIDIOC_SUBDEV_ENUM_FRAME_SIZE` ioctl with a pointer to=
 the
+structure.
+
+A successful call will return with minimum and maximum frame sizes filled =
in.
+Repeat with increasing ``index`` until ``EINVAL`` is received.
+``EINVAL`` means that either no more entries are available in the array,
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
+    belonging to the given pad and format. Filled in by the caller.
     * - __u32
       - ``pad``
-      - Pad number as reported by the media controller API.
+      - Pad number as reported by the media controller API. Filled in by t=
he caller.
     * - __u32
       - ``code``
       - The media bus format code, as defined in
-	:ref:`v4l2-mbus-format`.
+	:ref:`v4l2-mbus-format`. Filled in by the caller.
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
diff --git a/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-mbus-=
code.rst b/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-mbus-co=
de.rst
index 417f1a19bcc4..22d046dd09c2 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-mbus-code.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-mbus-code.rst
@@ -31,15 +31,29 @@ Arguments
 Description
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-To enumerate media bus formats available at a given sub-device pad
-applications initialize the ``pad``, ``which`` and ``index`` fields of
-struct
-:c:type:`v4l2_subdev_mbus_code_enum` and
-call the :ref:`VIDIOC_SUBDEV_ENUM_MBUS_CODE` ioctl with a pointer to this
-structure. Drivers fill the rest of the structure or return an ``EINVAL``
-error code if either the ``pad`` or ``index`` are invalid. All media bus
-formats are enumerable by beginning at index zero and incrementing by
-one until ``EINVAL`` is returned.
+This call is used by the application to access the array of bus formats
+for the selected pad.
+
+The arrays are defined by the driver, and indexed using the ``index`` field
+of struct :c:type:`v4l2_subdev_mbus_code_enum`.
+Each value of ``pad`` corresponds to a separate array.
+Each array starts with the ``index`` of 0, and
+the first invalid index marks the end of array.
+
+Therefore, to enumerate media bus formats available at a given sub-device =
pad,
+initialize the ``pad``, and ``which`` fields to desired values,
+and set ``index`` to 0.
+Then call the :ref:`VIDIOC_SUBDEV_ENUM_MBUS_CODE` ioctl
+with a pointer to this structure.
+
+A successful call will return with the ``code`` field filled in
+with a mbus format value.
+Repeat with increasing ``index`` until ``EINVAL`` is received.
+``EINVAL`` means that either ``pad`` is invalid,
+or that there are no more codes available at this pad.
+
+The driver must not return the same value of ``code`` for different indices
+at the same pad.
=20
 Available media bus formats may depend on the current 'try' formats at
 other pads of the sub-device, as well as on the current active links.
@@ -57,14 +71,15 @@ information about the try formats.
=20
     * - __u32
       - ``pad``
-      - Pad number as reported by the media controller API.
+      - Pad number as reported by the media controller API. Filled in by t=
he caller.
     * - __u32
       - ``index``
-      - Number of the format in the enumeration, set by the application.
+      - Index of the mbus code in the enumeration belonging to the given p=
ad.
+    Filled in by the caller.
     * - __u32
       - ``code``
       - The media bus format code, as defined in
-	:ref:`v4l2-mbus-format`.
+	:ref:`v4l2-mbus-format`. Filled in by the driver.
     * - __u32
       - ``which``
       - Media bus format codes to be enumerated, from enum
--=20
2.34.1


--Sig_//UOGO4TQ=PO+oqzL++tVdoa
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEExKRqtqfFqmh+lu1oADBpX4S8ZncFAmJidc4ACgkQADBpX4S8
ZncAuA//XN9Fzk4x5q/BudWA/tDCy0orfHBOSkD7n13fGiDoAs0zBpTc6ZCISYHH
/DYm61a4eXLwNDP/kqrFMZBMwS6b3yifyoavhsHX5CiPsEF6BxtWQlmFbJc386w/
ucETnrAmuNNxl+hSgH/39cQbNmklDXUWY4rOZJApK1pcmyRxsaTKhl/jflk/mieF
ChlmJzNcN3U3aO64iPJbOFRsNZHBYEtc1n3K3pYNj1xG0mSC0UbvHcDSH9S1uA6u
oLLvYzIh/LyPnxxghRHV8A2Ap1yYJ/xhS60BbHo/3bi7HGmmRxn4nEag2iuMi+HN
denVEJzdw3aRYfP6I2t2ZsagkbKsiXdgmEOOI7Vo0Q0R68nXgd3M9FtgWPur+ldy
q1F4n1Prl6wQ2hJ2Z+YSaPrBMULqmNmrte+WVWSWsyuY8Uo4rajgkImHb1TP/h9d
Zf7CBpN6u81lI3qQssMpWRJ2Fs8+sA3AaFICB6fqx+CkF2pnUcLpbRuK/r4xMq9l
/A/4etO8lAPPufzWan652NxUQKh+PYyCmUZ/pKozsKaaeeB10xzd7ZO24iGxZKtN
YrWqrhHiksvRlyNSf8fE+AVkrbhwawMO4aGuKkGSNj53ZPHvB15MWV8/Y2NlZXbW
yHXKzYPuV4h55nDK2cRdGyThzk6khIDsnURj+svOFSIZKwQqEHc=
=+bH9
-----END PGP SIGNATURE-----

--Sig_//UOGO4TQ=PO+oqzL++tVdoa--
