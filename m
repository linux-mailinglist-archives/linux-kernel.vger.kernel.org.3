Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8EB59B0B1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 00:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235844AbiHTWBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 18:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235776AbiHTWBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 18:01:12 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A553275D0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 15:01:00 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id f4so5566330qkl.7
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 15:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=KykEBBUCJiG8hWNQH+HNXVEIkWlq4MXZ6NZu3UE4RTg=;
        b=ZkGSLVKi4sggsqFIAZKvovnEa0HXHlb7Ig9Ib3MAgXo1DMrVjhIpEvWDmF9jjk9p0S
         GF8Tx0fbOr+Cy3EoYJwqS0QHgsnxJfboDwD1N5mW65A0O9grtdtImCJ+CH6otZ0LdAq/
         cHD1Ug+1NUz8bXOuAT3n6vwgVWZGFRYB+BQcbqCf51MxNUETgJIf21uoVVsCYy/dauRH
         Reaa40LHNi8/Q/ZzpvfXb+90mxmZ3RAorHnglDWVFPCMuUG2XXRR/2f4MxFRdhQZGctg
         L4bzBbirr9kcBdXbOqp7fyST8FS5sgYv+OJZI8o8VuFO2JpI3AMTmL4WquUI5muqiM1T
         RJcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=KykEBBUCJiG8hWNQH+HNXVEIkWlq4MXZ6NZu3UE4RTg=;
        b=WEloTySq5m8qzE41UUjBpFQU+XGPxeGmja4A+EMlaloxvhjPwBco6HKLXMDCl32Rez
         gJjv1W8qJzdAgwTuKZdHGbHD2hkKe+XcVNdpw2bJoMbTmE1jIfeaDw5AooB2P5/16Cv/
         QNJ37gTWnffdaSwFzei6jZ0XccQ1PGrUHAGRxlloeM6KdcrNpPWCtGM2vIsW6+5C5CmW
         +UONvpIq40GGWIMQWxJKBzNGfV5RFu01mbkK3tuXzpoIpQL51Ck8SI4B7yXCLpR9zj33
         IMO7UdHqu/hj59RR/0Gjr32ejADQ1tjmD68vpddCgT9dqV9nfF6Xe54RXRhK4yCROlbe
         sn5Q==
X-Gm-Message-State: ACgBeo3NhsEH06LYnxSEO4PgPkcUv6O4YEV34+BhRGuz+PCja7aT0B2g
        vjjDDDXd6Zc+yu5k0noS312QZg==
X-Google-Smtp-Source: AA6agR6WU12+zbM5VGNizCLQfDVR1duJWik7phAdRLZddHz21A7bbu41K9rXQBRZdfh7P1Uif+Iv5w==
X-Received: by 2002:a05:620a:2a0d:b0:6b6:6c75:f050 with SMTP id o13-20020a05620a2a0d00b006b66c75f050mr9016152qkp.199.1661032859180;
        Sat, 20 Aug 2022 15:00:59 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id u9-20020a05620a430900b006af08c26774sm7071581qko.47.2022.08.20.15.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 15:00:58 -0700 (PDT)
Date:   Sat, 20 Aug 2022 18:00:56 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Julien Panis <jpanis@baylibre.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mranostay@ti.com,
        fabien.lahoudere@collabora.com, gwendal@chromium.org,
        enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, jic23@kernel.org, david@lechnology.com,
        robertcnelson@gmail.com
Subject: Re: [PATCH v5 0/3] ECAP support on TI AM62x SoC
Message-ID: <YwFZmN9H+Fjqm8sf@fedora>
References: <20220817141620.256481-1-jpanis@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y6Uakq24GtS4M/ov"
Content-Disposition: inline
In-Reply-To: <20220817141620.256481-1-jpanis@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y6Uakq24GtS4M/ov
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 17, 2022 at 04:16:17PM +0200, Julien Panis wrote:
> The Enhanced Capture (ECAP) module can be used to timestamp events
> detected on signal input pin. It can be used for time measurements
> of pulse train signals.
>=20
> ECAP module includes 4 timestamp capture registers. For all 4 sequenced
> timestamp capture events (1->2->3->4->1->...), edge polarity (falling/ris=
ing
> edge) can be selected.
>=20
> This driver leverages counter subsystem to :
> - select edge polarity for all 4 capture events (event mode)
> - log timestamps for each capture event
> Event polarity, and CAP1/2/3/4 timestamps give all the information
> about the input pulse train. Further information can easily be computed :
> period and/or duty cycle if frequency is constant, elapsed time between
> pulses, etc...
>=20
> Modifications since v4:
> 	- Modify yaml commit message prefix (dt-bindings)
> 	- Modify driver file name & Makefile (ti-ecap-capture)
> 	- Modify compilation flag name in Kconfig (TI_ECAP_CAPTURE)
> 	- Select REGMAP_MMIO in Kconfig
> 	- Add capture items to sysfs-bus-counter ABI documentation
> 	- Cleanup probe function (dev_err_probe & devm_clk_get_enabled & devm_ad=
d_action_or_reset for PM)
> 	- Enable/Disable device clock in suspend/resume functions
> 	- Add PM explanations
> 	- Add ECAP clock signal & 'frequency' sysfs entry
> 	- Replace elapsed_time & spinlock by nb_ovf (atomic_t) & 'count_cumul' s=
ysfs entry
> 	- Add counter overflow event
> 	- Modify 'name' sysfs entry for signal0 & signal1 & count0
> 	- Modify watch_validate function
> 	- Add macros for callbacks related to cap1/2/3/4
>=20
> Userspace commands :
> 	### SIGNAL INPUT ###
> 	cd /sys/bus/counter/devices/counter0/signal0
>=20
> 	# Get available polarities for each capture event
> 	cat polarity1_available
> 	cat polarity2_available
> 	cat polarity3_available
> 	cat polarity4_available
>=20
> 	# Get polarity for each capture event
> 	cat polarity1
> 	cat polarity2
> 	cat polarity3
> 	cat polarity4
>=20
> 	# Set polarity for each capture event
> 	echo rising edge > polarity1
> 	echo falling edge > polarity2
> 	echo rising edge > polarity3
> 	echo falling edge > polarity4
>=20
> 	### SIGNAL CLOCK ###
> 	cd /sys/bus/counter/devices/counter0/signal1
>=20
> 	# Get clock rate
> 	cat frequency
>=20
> 	### COUNT ###
> 	cd /sys/bus/counter/devices/counter0/count0
>=20
> 	# Run ECAP
> 	echo 1 > enable
>=20
> 	# Get current timebase counter value
> 	cat count
>=20
> 	# Get cumulated counter value
> 	cat count_cumul
>=20
> 	# Get captured timestamps
> 	cat capture1
> 	cat capture2
> 	cat capture3
> 	cat capture4
>=20
> 	# Note that counter watches can also be used to get
> 	# data from userspace application
> 	# -> see tools/counter/counter_example.c
>=20
> 	# Stop ECAP
> 	echo 0 > enable
>=20
> Julien Panis (3):
>   dt-bindings: counter: add ti,am62-ecap-capture.yaml
>   Documentation: ABI: sysfs-bus-counter: add capture items
>   counter: ti-ecap-capture: capture driver support for ECAP
>=20
>  Documentation/ABI/testing/sysfs-bus-counter   |  49 ++
>  .../counter/ti,am62-ecap-capture.yaml         |  61 ++
>  drivers/counter/Kconfig                       |  15 +
>  drivers/counter/Makefile                      |   1 +
>  drivers/counter/ti-ecap-capture.c             | 624 ++++++++++++++++++
>  include/uapi/linux/counter.h                  |   2 +
>  6 files changed, 752 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/counter/ti,am62-eca=
p-capture.yaml
>  create mode 100644 drivers/counter/ti-ecap-capture.c
>=20
> --=20
> 2.25.1

Hello Julien,

I'm CCing a number of other developers here who have indicated interest
in counter timestamp functionality in past, just in case they would like
to particpate in this discussion.

Adding buffers to the Counter subsystem will be a user-visible ABI
change, so I want to make sure we get the interface design correct
before we merge any of those changes; once it's exposed to userspace it
can't be changed. However, we can still improve your patches while we
develop this interface, so revisions are welcome even if I can't merge
your counter driver until we iron out the Counter subsystem buffer
interface.

So in the v4 patchset we discussed introducing a new counter_comp_type
COUNTER_COMP_BUFFER_U64 enum constant with respective counter_comp read
callbacks::

     int (*count_buffer_u64_read)(struct counter_device *counter,
                                  struct counter_count *count,
                                  size_t index, u64 *val);=20

Drive authors can then handle buffer reads by receiving an "index",
locating the value at that buffer offset, and returning the value via
the "val" u64 pointer.

Defining a buffer as Count extensions could be done using a helper
macro::

     COUNTER_COMP_COUNT_BUFFER_U64("capture", ecap_cnt_cap_read, 4)

Originally I considered unrolling this into four COUNTER_COMP_COUNT_U64,
but I'm unsure if that is possible in GCC. Regardless, I believe it's
feasible to implement this in counter-chrdev.c by passing the buffer
length in the "priv" member of struct counter_comp and handling it when
creating sysfs attributes. I might be able to write a prototype for this
in the next couple weeks.

In the end, we should have four buffer elements exposed as sysfs
attributes under the respective count directory:

* /sys/bus/counter/devices/counterX/count0/capture0
* /sys/bus/counter/devices/counterX/count0/capture1
* /sys/bus/counter/devices/counterX/count0/capture2
* /sys/bus/counter/devices/counterX/count0/capture3=20

One worry I do have is whether this will scale well enough; I can
imagine some future device having a timestamp history buffer of much
later than four elements. In cases with large buffers, it might be more
practical to expose a FIFO queue to deliver buffer data. However, the
existing Counter character device interface isn't designed for data of
arbitrary length, so we'd likely have to introduce a secondary character
device to provide the queue.

We can postpone implementation of such a queue until the need arises and
focus on just the sysfs interface for this particular driver. If we
expose each element of the buffer as its own sysfs attribute, then the
existing Counter character device interface gets access to these
elements for free without any additional code changes to that part of
the Counter subsystem.

So my concerns right now are making sure this is a sane design and the
right path forward to expose device buffer elements in sysfs.

William Breathitt Gray

--y6Uakq24GtS4M/ov
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYwFZmAAKCRC1SFbKvhIj
K/ovAP47QIMo+w4JiGDrqtcUb5OvA8DBd6zMjz/pQ4jLO+MWsQD/ZE/q0/vn6zaq
nx05yy65K++Fl4e6kQJF+/LC4i24fws=
=dkgg
-----END PGP SIGNATURE-----

--y6Uakq24GtS4M/ov--
