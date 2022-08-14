Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A075925E7
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 20:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240070AbiHNSAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 14:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiHNSAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 14:00:32 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A312210FCB
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 11:00:29 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id i24so4230267qkg.13
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 11:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=qbgoZeZmViWvFKGo3vDKiMkLriw1iy/wD7V+tnwIV3E=;
        b=F0gsWapUFAmXsS70/FT2w7UJfE2rokB7ixzPGczQfI07TuC1fc2U11uuBywngI/3jB
         AFUpGhI20FQluH0MY1YaEo2CgZhfbMKboyXTDOyq386fsex/ELLlbbMIlMgzfzZfI6Kv
         gkeNk+TmY40Cx7Rg6AeYI43982jGwi3XT1hv2vUQkJxW6aaYQvC8qaYN6x2gaaT4aZI3
         ngaaN09zSOcTOnodJvLUORhTCtK5d/IJyhBAVekcWSRmcusK8/96so880hWPSkv7h+Dj
         gqhwX70G3VFnYgxom2F9wWfPBgvgoQhPYNEkRwgXNndPiFaMrXcTUhazcMMUYqzUx75g
         c/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=qbgoZeZmViWvFKGo3vDKiMkLriw1iy/wD7V+tnwIV3E=;
        b=6IBD+ylkf8bTb+S85ybgxnfGy+sx5iigNghcSQvseO7JRbQaMZPHdVyUF39+XMPQZ+
         61UahtwyE4L5EiOeS241ZCohrkcq0/c6H8yP/zfsZEmh+xfhVdeEC6U2Zy/J2OSecMYG
         VKwbss5pUot6mLBEgy7QXRCZkxe/Vrltu9odYAW0kC1sfj1oKKNzf9Sw7RmiR1Q6BoHw
         upUsDW/z6ORxrF16Vgphsp9fjjf1Fq+4+U0OaeyiGtLosqjU2VjfviBbFz99FUweq198
         E+BltyOsixRWdBePYiUUXM/NepQEgLBEBmDH/1UJjevTfEXJMN+7ahR+EPuMVQ5vLBGZ
         YuyA==
X-Gm-Message-State: ACgBeo36FBkhZd6iNhKqcr9R4m5U62Wtv8rxwCKuSBOTK7WmT7uStEim
        XYssIib4Hiw8YxHAhEGZPuOG/NZI7aAIEA==
X-Google-Smtp-Source: AA6agR6yLu/QXtwon8Xp97JiVrlbGGdQdxYfHlgqI4icqpn3WSS1oA2Q8E+Mb8lZGhB4SpB3uShoVw==
X-Received: by 2002:a05:620a:288f:b0:6b6:4e6e:c68c with SMTP id j15-20020a05620a288f00b006b64e6ec68cmr8883748qkp.240.1660500028773;
        Sun, 14 Aug 2022 11:00:28 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id s16-20020a05620a255000b006b5f06186aesm6672551qko.65.2022.08.14.11.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 11:00:28 -0700 (PDT)
Date:   Sun, 14 Aug 2022 14:00:26 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Julien Panis <jpanis@baylibre.com>
Cc:     robh+dt@kernel.org, jic23@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mranostay@ti.com
Subject: Re: [PATCH v4 0/3] ECAP support on TI AM62x SoC
Message-ID: <Yvk4OijjBj+Wa7fT@fedora>
References: <20220810140724.182389-1-jpanis@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="T5liTN5OdHlrk5BP"
Content-Disposition: inline
In-Reply-To: <20220810140724.182389-1-jpanis@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--T5liTN5OdHlrk5BP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 10, 2022 at 04:07:21PM +0200, Julien Panis wrote:
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
> Modifications since v3:
> 	- Migrate driver from IIO to Counter subsystem
> 	- Minor modification in yaml ($id) to match Counter subsystem
> 	- Add ABI documentation
>=20
> Userspace commands :
> 	### SIGNAL ###
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
> 	echo rising > polarity1
> 	echo falling > polarity2
> 	echo rising > polarity3
> 	echo falling > polarity4
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
>   dt-binding: counter: add ti,am62-ecap-capture.yaml
>   Documentation: ABI: add sysfs-bus-counter-ecap
>   counter: capture-tiecap: capture driver support for ECAP
>=20
>  .../ABI/testing/sysfs-bus-counter-ecap        |  64 ++
>  .../counter/ti,am62-ecap-capture.yaml         |  61 ++
>  drivers/counter/Kconfig                       |  14 +
>  drivers/counter/Makefile                      |   1 +
>  drivers/counter/capture-tiecap.c              | 634 ++++++++++++++++++
>  include/uapi/linux/counter.h                  |   2 +
>  6 files changed, 776 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-counter-ecap
>  create mode 100644 Documentation/devicetree/bindings/counter/ti,am62-eca=
p-capture.yaml
>  create mode 100644 drivers/counter/capture-tiecap.c
>=20
> --=20
> 2.25.1

Something that has become apparent to me is the code repetition in this
driver in order to support the capture buffer. Buffers are common
components in devices, so it'll be good for us to standardize some of
what we're exploring here into an interface that other drivers can also
use. We have two ABIs to consider: the driver interface and the sysfs
interface.

For the sysfs interface, I think we'll have to expose each element
individually (e.g. capture1, capture2, etc.) because sysfs attributes
are suppose to expose only a single datum for any given attribute.

For the driver side, we might want to introduce a new Counter component
type for buffers and respective macros to streamline some of the code
for driver authors. For example, a new COUNTER_COMP_BUFFER_U64 enum
counter_comp_type constant could be introduced to represent a u64 buffer
element; respective struct counter_comp read callbacks could be
introduced::

    int (*count_buffer_u64_read)(struct counter_device *counter,
                                 struct counter_count *count,
				 size_t index, u64 *val);

So a driver author can use the "index" parameter to locate the buffer
element and pass back its value via the "val" parameter. To define the
buffer, maybe helper macros like this could be introduced::

    COUNTER_COMP_COUNT_BUFFER_U64("capture", ecap_cnt_cap_read, 4)

This would define four u64 buffer elements each named prefixed with
"capture" and with their read callbacks set to ecap_cnt_cap_read().

One problem however is that I'm not sure if the C preprocessor would be
able to unroll the COUNTER_COMP_COUNT_BUFFER_U64 to a dynamic number of
elements based on a macro parameter (maybe there is a GCC extension).

I'm just throwing out ideas, so I'd like to hear some comments and
suggestions from others about how we should add buffer support to the
Counter subsystem.

William Breathitt Gray

--T5liTN5OdHlrk5BP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYvk4OgAKCRC1SFbKvhIj
K1puAQCKVF17W73GrxMBUVmEpZBsMchm0VgY1hKbIVPA69IlsQEAxjCytel3C7oB
cPBVwjGnEm0sDNveEi6Tbs+QjkxUNgI=
=X96e
-----END PGP SIGNATURE-----

--T5liTN5OdHlrk5BP--
