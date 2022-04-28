Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A943F512F16
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 10:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344653AbiD1I4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344512AbiD1I4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:56:00 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BED723165;
        Thu, 28 Apr 2022 01:52:46 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 44DADDF75A;
        Thu, 28 Apr 2022 01:52:16 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6X5VlkxIGCtY; Thu, 28 Apr 2022 01:52:15 -0700 (PDT)
Date:   Thu, 28 Apr 2022 10:52:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1651135935; bh=ohE/IebwBN77RT1W4hsybc9tmsQEIEDdP++Soon6lDM=;
        h=Date:From:To:Subject:From;
        b=ssm+Caqw19pEA+VIsRGzYk2wLUCbQo5MRYZIHPy1rv6p6INwzTyr43rnTISXq3iOA
         bKTgUZrZEaw19MXRid5CqDKqK24IM/8iljdafA1wo68VKm3dkLIBbWsOkDqmTWGhuF
         uGGoeCtmN9t5gLN72dmBtmDBCIY90uC4HfnXYEB2sAtyeAB/uPAB3XanpIGJucXx6X
         5Syo4nYGCu1Y06t1OBpMGNarkRiAEyjhbnQXHYBhtT4vUQHYpMwVYq+xOeixJOjAWT
         DrxJKseVSeOUBZnEl60XjfnKHjjMdVlfjHB7N8F8lL3DnLlOCjwFU0nhjUftDvDfh/
         CFUKy3tVqnNPQ==
From:   Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm
Subject: [PATCHv2 1/2] doc/media api: Try to make enum usage clearer
Message-ID: <20220428105211.7106ce6a.dorota.czaplejewicz@puri.sm>
Organization: Purism
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/e.DoWQfsDpUUtXTZemZU8Pq";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/e.DoWQfsDpUUtXTZemZU8Pq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Added: mbus codes must not repeat
Added: no holes in the enumeration
Added: enumerations per what?
Added: who fills in what in calls
Changed: "zero" -> "0"
Changed: "given" -> "specified"

Signed-off-by: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
---
Hello,

this is the second attempt at updating the media documentation.

Differences from previous: "selected" is now "specified", "array" is now "e=
numeration", and "caller" is now "application".

No differences: I haven't used the frame intervals calls and haven't gather=
ed practical knowledge about where docs may be insufficient, so I didn't to=
uch its documentation.

Regards,
Dorota

 .../v4l/vidioc-subdev-enum-mbus-code.rst      | 39 +++++++++++++------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-mbus-=
code.rst b/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-mbus-co=
de.rst
index 417f1a19bcc4..87572de0fd26 100644
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
+This call is used by the application to access the enumeration of bus form=
ats
+for the selected pad.
+
+The enumerations are defined by the driver, and indexed using the ``index`=
` field
+of struct :c:type:`v4l2_subdev_mbus_code_enum`.
+Each value of ``pad`` corresponds to a separate enumeration.
+Each enumeration starts with the ``index`` of 0, and
+the lowest invalid index marks the end of enumeration.
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
he application.
     * - __u32
       - ``index``
-      - Number of the format in the enumeration, set by the application.
+      - Index of the mbus code in the enumeration belonging to the given p=
ad.
+    Filled in by the application.
     * - __u32
       - ``code``
       - The media bus format code, as defined in
-	:ref:`v4l2-mbus-format`.
+	:ref:`v4l2-mbus-format`. Filled in by the driver.
     * - __u32
       - ``which``
       - Media bus format codes to be enumerated, from enum
--=20
2.35.1


--Sig_/e.DoWQfsDpUUtXTZemZU8Pq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEExKRqtqfFqmh+lu1oADBpX4S8ZncFAmJqVbsACgkQADBpX4S8
ZncNnQ/7BWFK+LkIIBRQefdCUmp2vcmXBtC+DohmJgX6hHPbZtO0BGhssjuSS6Cy
b81Z7ujEyT9Lv2zOqEa+tHFR/zAjaqo5NxbiGhMdsFgDLEg7A5T+UZcRqNeruBNM
zKU2SGvFauukf2+wTwctBni0mLUAnpQA9cxzKEww+XNMGIftnjR1eX4APZylBX+D
ET5tR5iw8prcHzzuEQEM1cSNmzUhR49XcvJQXVSS+6kjjFViUeEaImxlfPbVvmvY
nf3JwcvRpJkNrJyVHFkVaul/ezzG4Pq0l6A/swlmUXErgHrBoado1bhtDoZpy7Ez
CuFRUioNk5yI7QrIX5tq+7bWMaVVxd9gbPqN1lvZU1MJ2V2PyqxbpmC+umXSTg1v
cuXLDSkHqO6p9Gdum2bsPkEhOIpgzzirYaEyDpxLhxMrHXuatt+2v2GxkeK4xuw+
Ghc6JczAYDcFYLjJpiZqMPr7oXBSGdIU6D8zlGX2jOfHTRVotzKEHT2tiCh17Hcq
RA22RlXEjWAg92YWfz/Qv+r/5VW9EvG3lQ5Tr17m0RIaXo0N5ygK5CKvBxFvpDuT
3fDs4J0wKnCjQ+00B4yzh2xF45JcHdOQ+T4IGgM0Mew61r8UCnJAlKzBWJsYLuap
0CY+n4obCRZJTHm6GJr/0Qj04nDuWhBgPWLmFfMu8iT1ZZp3k7g=
=AivM
-----END PGP SIGNATURE-----

--Sig_/e.DoWQfsDpUUtXTZemZU8Pq--
