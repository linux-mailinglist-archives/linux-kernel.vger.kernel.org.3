Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261C951349D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346850AbiD1NOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346473AbiD1NO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:14:28 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031681CB29
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 06:11:09 -0700 (PDT)
Received: from relay12.mail.gandi.net (unknown [217.70.178.232])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 97A7DC6858
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 13:04:55 +0000 (UTC)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id D0646200018;
        Thu, 28 Apr 2022 13:04:49 +0000 (UTC)
Date:   Thu, 28 Apr 2022 15:04:48 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm
Subject: Re: [PATCHv2 1/2] doc/media api: Try to make enum usage clearer
Message-ID: <20220428130448.bfht2nf23n6lidsk@uno.localdomain>
References: <20220428105211.7106ce6a.dorota.czaplejewicz@puri.sm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="toluwoxxewqm2y5f"
Content-Disposition: inline
In-Reply-To: <20220428105211.7106ce6a.dorota.czaplejewicz@puri.sm>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--toluwoxxewqm2y5f
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Dorota,


On Thu, Apr 28, 2022 at 10:52:11AM +0200, Dorota Czaplejewicz wrote:
> Added: mbus codes must not repeat
> Added: no holes in the enumeration
> Added: enumerations per what?
> Added: who fills in what in calls
> Changed: "zero" -> "0"
> Changed: "given" -> "specified"
>
A more discoursive commit message would be appreciated. Just a few lines
before the crude list of changes:

Something like

"Update the documentation of ... in order to clarify etc etc"

> Signed-off-by: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
> ---
> Hello,
>
> this is the second attempt at updating the media documentation.
>
> Differences from previous: "selected" is now "specified", "array" is now "enumeration", and "caller" is now "application".

Please stay in 80 cols even for parts that won't end up in the commit
message, it's hard to read this if you have multiple terminal windows
open.

>
> No differences: I haven't used the frame intervals calls and haven't gathered practical knowledge about where docs may be insufficient, so I didn't touch its documentation.

I think Hans required to change the documentation of that ioctl to
match the style of the changes you have made here, not because
something is missing there.

>
> Regards,
> Dorota
>
>  .../v4l/vidioc-subdev-enum-mbus-code.rst      | 39 +++++++++++++------
>  1 file changed, 27 insertions(+), 12 deletions(-)
>
> diff --git a/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-mbus-code.rst b/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-mbus-code.rst
> index 417f1a19bcc4..87572de0fd26 100644
> --- a/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-mbus-code.rst
> +++ b/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-mbus-code.rst
> @@ -31,15 +31,29 @@ Arguments
>  Description
>  ===========
>
> -To enumerate media bus formats available at a given sub-device pad
> -applications initialize the ``pad``, ``which`` and ``index`` fields of
> -struct
> -:c:type:`v4l2_subdev_mbus_code_enum` and
> -call the :ref:`VIDIOC_SUBDEV_ENUM_MBUS_CODE` ioctl with a pointer to this
> -structure. Drivers fill the rest of the structure or return an ``EINVAL``
> -error code if either the ``pad`` or ``index`` are invalid. All media bus
> -formats are enumerable by beginning at index zero and incrementing by
> -one until ``EINVAL`` is returned.
> +This call is used by the application to access the enumeration of bus formats
> +for the selected pad.

This is a good introductory phrase.

> +
> +The enumerations are defined by the driver, and indexed using the ``index`` field
> +of struct :c:type:`v4l2_subdev_mbus_code_enum`.
> +Each value of ``pad`` corresponds to a separate enumeration.

Isn't this a repetition of the above "enumeration of bus formats for
the selected pad" ? Also, the fact different mbus codes are available
at different pads is an intrinsic characteristics of the device
capabilities and of what a pad represents. Put it in this way it seems
it's an API requirement.

> +Each enumeration starts with the ``index`` of 0, and
> +the lowest invalid index marks the end of enumeration.
> +
> +Therefore, to enumerate media bus formats available at a given sub-device pad,
> +initialize the ``pad``, and ``which`` fields to desired values,
> +and set ``index`` to 0.
> +Then call the :ref:`VIDIOC_SUBDEV_ENUM_MBUS_CODE` ioctl
> +with a pointer to this structure.

Could these two paragraphs be just:

To enumerate all the media bus codes available at a give sub-device pad,
an application set the ``index`` field to 0 and then call the
:ref:`VIDIOC_SUBDEV_ENUM_MBUS_CODE` ioctl with a pointer to this structure,
incrementing ``index`` by one until ``EINVAL`` is returned.

> +
> +A successful call will return with the ``code`` field filled in
> +with a mbus format value.

Generally, I see "mbus code", not "mbus format" as far as
I'm aware..

> +Repeat with increasing ``index`` until ``EINVAL`` is received.
> +``EINVAL`` means that either ``pad`` is invalid,
> +or that there are no more codes available at this pad.

Is it necessary to add this last paragraph. Isn't it specified in the
error code description below ?

EINVAL
    The struct
    :c:type:`v4l2_subdev_mbus_code_enum`
    ``pad`` references a non-existing pad, or the ``index`` field is out
    of bounds.


> +
> +The driver must not return the same value of ``code`` for different indices
> +at the same pad.

This might be a good thing to specify, a little obvious maybe but it
doesn't hurt.

>
>  Available media bus formats may depend on the current 'try' formats at
>  other pads of the sub-device, as well as on the current active links.
> @@ -57,14 +71,15 @@ information about the try formats.
>
>      * - __u32
>        - ``pad``
> -      - Pad number as reported by the media controller API.
> +      - Pad number as reported by the media controller API. Filled in by the application.
>      * - __u32
>        - ``index``
> -      - Number of the format in the enumeration, set by the application.
> +      - Index of the mbus code in the enumeration belonging to the given pad.
> +    Filled in by the application.

These last changes are good, provided this phrase still renders correctly
now that you added a line break.

>      * - __u32
>        - ``code``
>        - The media bus format code, as defined in
> -	:ref:`v4l2-mbus-format`.
> +	:ref:`v4l2-mbus-format`. Filled in by the driver.
>      * - __u32
>        - ``which``
>        - Media bus format codes to be enumerated, from enum

In general there are a few good additions, but to be honest I would
keep the changes small for sake of consistency with the existing
documentation of other enumeration-related ioctls

Thanks
   j

> --
> 2.35.1
>



--toluwoxxewqm2y5f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtcQ9SICaIIqPWDjAcjQGjxahVjwFAmJqkO8ACgkQcjQGjxah
VjymVhAApUEsdzPNeWh7kxkyZbVPoJgq+1UFS/zhkJNnby4tmdpJ86TbbKtzjifj
s4Hw1QyCQkEgZxl1vPpmUpcGlkVEafHT7AN9DjuToOjKJKAWhhNuUO4n8nrRUkhN
1R5KV/ffy3ighSBSOtlyaW9a+GtVwNn39UFBK9FqKKlCHQsY4qwO0jivltjIWM1h
WTSFEcl7nrky3tGp45WvezT1ZOjPCSdn2dsJ2tmBbeZQ00qJYp7hHuqKDId6jDSV
LUuQ9yV95PH1gXMTmKmraUl/qwj0teLx5SKPZ11oSTkPGdUjyisL6hp5XleTmozy
5aWnY3C0rhLoeQ4ljxWyXIppMxxO+Vkihow/CYHo9oVBHuy4EiCQoxKtJ0VBUa/r
2D/XEoJRD5xB326V3LAt7Rhk0t1RPq89kpl7ilXDdLn+meBx/NhPyPDSexbimnEf
uNSfMaWHny76bioOT/29pHrvNhss7knpwW3yXkXHbmLrtbbLJ6p6heoMJ0raP6fe
GYybe9060leuTxq30yhpuolCYOutL/+dBczD6rqm3V8qkNKmZnAiXC+2fVra6BTo
8aNE8WQ5zfjWexSQw2+g7B4rsCQp6SJ6BNWsY9ynwX11Rsrs5p7N6EWyhSNl4ntw
4CIBTDt59sCh6aGrYCLMwC62RMufYzk3UwQiTg2IPtzUjFG/i4I=
=OWpT
-----END PGP SIGNATURE-----

--toluwoxxewqm2y5f--
