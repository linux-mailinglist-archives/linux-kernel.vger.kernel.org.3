Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586325134A1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346864AbiD1NPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238516AbiD1NPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:15:22 -0400
X-Greylist: delayed 419 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 28 Apr 2022 06:11:51 PDT
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A25F1D306;
        Thu, 28 Apr 2022 06:11:50 -0700 (PDT)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 6F4B01C0007;
        Thu, 28 Apr 2022 13:11:48 +0000 (UTC)
Date:   Thu, 28 Apr 2022 15:11:46 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm
Subject: Re: [PATCHv2 2/2] media api: Try to make enum usage clearer
Message-ID: <20220428131146.ofdn7tr5mkxya3ck@uno.localdomain>
References: <20220428083715.75997-1-dorota.czaplejewicz@puri.sm>
 <20220428105219.4b068b1f.dorota.czaplejewicz@puri.sm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mydpssort7jg2wxh"
Content-Disposition: inline
In-Reply-To: <20220428105219.4b068b1f.dorota.czaplejewicz@puri.sm>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mydpssort7jg2wxh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Dorota

On Thu, Apr 28, 2022 at 10:52:19AM +0200, Dorota Czaplejewicz wrote:
> Fixed: typo "format" -> "frame size" in enum-frame-size
> Added: no holes in the enumeration
> Added: enumerations per what?
> Added: who fills in what in calls
> Changed: "zero" -> "0"
> Changed: "given" -> "specified"

Empty line here

> Signed-off-by: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
> ---
>  .../v4l/vidioc-subdev-enum-frame-size.rst     | 44 ++++++++++++-------
>  1 file changed, 28 insertions(+), 16 deletions(-)
>
> diff --git a/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-frame-size.rst b/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-frame-size.rst
> index c25a9896df0e..2c6fd291dc44 100644
> --- a/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-frame-size.rst
> +++ b/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-frame-size.rst
> @@ -31,18 +31,29 @@ Arguments
>  Description
>  ===========
>
> -This ioctl allows applications to enumerate all frame sizes supported by
> -a sub-device on the given pad for the given media bus format. Supported
> -formats can be retrieved with the
> +This ioctl allows applications to access the enumeration of frame sizes supported by

over 80 cols

> +a sub-device on the specified pad for the specified media bus format.
> +Supported formats can be retrieved with the

This seems quite an arbitrary change. What's wrong with the existing
phrase ?

>  :ref:`VIDIOC_SUBDEV_ENUM_MBUS_CODE`
>  ioctl.
>
> -To enumerate frame sizes applications initialize the ``pad``, ``which``
> -, ``code`` and ``index`` fields of the struct
> -:c:type:`v4l2_subdev_mbus_code_enum` and
> -call the :ref:`VIDIOC_SUBDEV_ENUM_FRAME_SIZE` ioctl with a pointer to the
> -structure. Drivers fill the minimum and maximum frame sizes or return an
> -EINVAL error code if one of the input parameters is invalid.
> +The enumerations are defined by the driver, and indexed using the ``index`` field
> +of the struct :c:type:`v4l2_subdev_mbus_code_enum`.
> +Each pair of ``pad`` and ``code`` correspond to a separate enumeration.
> +Each enumeeration starts with the ``index`` of 0, and

s/enumeeration/enumeration/

> +the lowest invalid index marks the end of the enumeration.
> +
> +Therefore, to enumerate frame sizes allowed on the specified pad
> +and using the specified mbus format, initialize the
> +``pad``, ``which``, and ``code`` fields to desired values,
> +and set ``index`` to 0.
> +Then call the :ref:`VIDIOC_SUBDEV_ENUM_FRAME_SIZE` ioctl with a pointer to the
> +structure.
> +
> +A successful call will return with minimum and maximum frame sizes filled in.
> +Repeat with increasing ``index`` until ``EINVAL`` is received.
> +``EINVAL`` means that either no more entries are available in the enumeration,
> +or that an input parameter was invalid.
>
>  Sub-devices that only support discrete frame sizes (such as most
>  sensors) will return one or more frame sizes with identical minimum and
> @@ -72,26 +83,27 @@ information about try formats.
>
>      * - __u32
>        - ``index``
> -      - Number of the format in the enumeration, set by the application.
> +      - Index of the frame size in the enumeration

Rougue line break

> +    belonging to the given pad and format. Filled in by the application.
>      * - __u32
>        - ``pad``
> -      - Pad number as reported by the media controller API.
> +      - Pad number as reported by the media controller API. Filled in by the application.

over 80 cols

>      * - __u32
>        - ``code``
>        - The media bus format code, as defined in
> -	:ref:`v4l2-mbus-format`.
> +	:ref:`v4l2-mbus-format`. Filled in by the application.
>      * - __u32
>        - ``min_width``
> -      - Minimum frame width, in pixels.
> +      - Minimum frame width, in pixels. Filled in by the driver.
>      * - __u32
>        - ``max_width``
> -      - Maximum frame width, in pixels.
> +      - Maximum frame width, in pixels. Filled in by the driver.
>      * - __u32
>        - ``min_height``
> -      - Minimum frame height, in pixels.
> +      - Minimum frame height, in pixels. Filled in by the driver.
>      * - __u32
>        - ``max_height``
> -      - Maximum frame height, in pixels.
> +      - Maximum frame height, in pixels. Filled in by the driver.
>      * - __u32
>        - ``which``
>        - Frame sizes to be enumerated, from enum

Even more than 1/2, I am a bit failing to see what is missing in the
existing doc. If it feels better to others who will have a look, I for sure
won't oppose this change though :)

> --
> 2.35.1
>



--mydpssort7jg2wxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtcQ9SICaIIqPWDjAcjQGjxahVjwFAmJqkpIACgkQcjQGjxah
VjwkRQ//XOof8zmTn52P5jTy7sxMrWz8z9pDTDsFi4ZouonRODL6WRssg7gMtXXq
QO/haVRwKwgG/PRgwXFgJAZ7GAsWDpu3gcoLgzenX2DiAbYu8XPz8/Nr1rCmUOoZ
roP7VK2COn+Y0KgdzArHI/W2Rpzw1cDqbbZVzQvJvqyP/WELYD7ddCJegLwKTqFD
7KMlWAcg8FkX60yKEhoNf8je5tfC9fNQ0QJcAT7piazfXcfCvF/1EhjRSLiP046r
mQgSbETN6L9GQ1NsAaR3Vn6b0j7/WAussYUBpQGNm05egS7SaI1ETP78sFWmncF9
U0No76QwBm+ZPgvWEFMbHQpvQPwlioSUA9gBYqPP6tBBBsb/l6AQLWXJ4wuXC/G/
87LBPdsjyyIHV5yCOjohMMQA4wdBIrhtsutUGIdS8iUiTi8X41AXACivM10qifuV
jT/i9JoAWo9gkMpfw7SfQze7pJUwRhe0FBmm7WeXES/i3EwHinCUHLFs4quZYnVa
YGxVuO63V6n/AT1QYdMFYKA2aBhJC7gwPZ/DQoVL2BaexVJVH7PMXQtAl/0YX6xC
qEmvm/DT3Y9qJaginKAeuLeCFmtkO6ynHNkYsnVqcz+5MAHd8YavcTbTdnJNki9W
PH6lbEkbaChsnbtDP09X4xBrW+HKWVCiCzZPAvLl6/88PtK3T4w=
=DgoL
-----END PGP SIGNATURE-----

--mydpssort7jg2wxh--
