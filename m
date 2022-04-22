Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A729750BD1F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447201AbiDVQdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449706AbiDVQd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:33:26 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6337F5E159;
        Fri, 22 Apr 2022 09:30:32 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id g18so17372063ejc.10;
        Fri, 22 Apr 2022 09:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SvZ3E0xQYsARXcJ6QvBK1IaaEvvaTTI66H6n3DvzotU=;
        b=XPdBkkRntroFDRCc2rRB5jJOcvlE0/YL7BfF0y1vAsz+OrwL8vCStO919jFQaG/Cjg
         DrQ1+NlZuFdBph5v3nXyvntfHIum9mE8KnHjhOPK6Uac+290n9sRPHsoIDNPtmkH6kI5
         qQduRVLroUX439nTOu2kn8y/Qm4bPJKaJwRxjmHGBCBE1tffreN/Z9oKfHYvVRG0UDL6
         /BboDGnGHZWopCr8x+aefLbMfDS9M4autIDSP07QxLOXeRN5u5H8t+Femwv7nyUS6cLG
         LPUwBSwHjigSNSUxEmNl3+JR8I5i7pJtarKSKvv1zZlv5u6N2qMQV9yBFsb8cmbo9g1m
         vxDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SvZ3E0xQYsARXcJ6QvBK1IaaEvvaTTI66H6n3DvzotU=;
        b=vHD8rX944KdD/5bzOGVVvZ60pmGcK7muKk8sKAH/gBnrNK4KOzvdEq+KKuUlFP0HMG
         m8WxhcV+od2gTpTLvT443V+qJqmoKH1wGal5aesmHmj2vVyOMsTHXZv9tOMEQ/Rx6hol
         XSuxHv3TQdZOtOqxqTfo2fv0g+GHABT+8TIa3NU8Ri6YksJirBoofqLBe0XCcncMEP3b
         3efUo3QQTbh3IlscEfyfOttlJ852z6crs6GYx2aLJtZlwLKym7KbAc2NuXr329OQR9Zo
         LoVJu3BwfxoEiPExEMoTB55ebuaGTbE6F52bLLFOkZ7HAHYTczRN4j93urb1LrnRLyrC
         GHgg==
X-Gm-Message-State: AOAM531k7BJ27Pt4yCX9tLokw6vteoUNDkyWfOgYMXzPYPw+3HTLV/Wj
        fDrjW1X4ImCmkwULT0RNqDw=
X-Google-Smtp-Source: ABdhPJzgH412AyrAQMJHm1BCKsJJZBFY8vVy8bP1bgq2M0x6FmDqh3WogmU8YLiGIZY0QDYODtsi0A==
X-Received: by 2002:a17:906:d7a2:b0:6e8:9a34:c954 with SMTP id pk2-20020a170906d7a200b006e89a34c954mr4759284ejb.697.1650645030694;
        Fri, 22 Apr 2022 09:30:30 -0700 (PDT)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id i1-20020a1709064ec100b006e89dfff2d6sm900087ejv.141.2022.04.22.09.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 09:30:29 -0700 (PDT)
Date:   Fri, 22 Apr 2022 18:30:27 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Mubin Usman Sayyed <MUBINUSM@xilinx.com>,
        linux-arm-kernel@lists.infradead.org,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, michal.simek@xilinx.com,
        Alvaro Gamez <alvaro.gamez@hazent.com>
Subject: Re: [PATCH v14 2/2] pwm: Add support for Xilinx AXI Timer
Message-ID: <YmLYI0f1Jod6gDIl@orome>
References: <20220303223544.2810594-1-sean.anderson@seco.com>
 <20220303223544.2810594-2-sean.anderson@seco.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="26AvKSQgWTUB84pd"
Content-Disposition: inline
In-Reply-To: <20220303223544.2810594-2-sean.anderson@seco.com>
User-Agent: Mutt/2.2.1 (c8109e14) (2022-02-19)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--26AvKSQgWTUB84pd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 03, 2022 at 05:35:43PM -0500, Sean Anderson wrote:
> This adds PWM support for Xilinx LogiCORE IP AXI soft timers commonly
> found on Xilinx FPGAs. At the moment clock control is very basic: we
> just enable the clock during probe and pin the frequency. In the future,
> someone could add support for disabling the clock when not in use.
>=20
> Some common code has been specially demarcated. While currently only
> used by the PWM driver, it is anticipated that it may be split off in
> the future to be used by the timer driver as well.
>=20
> This driver was written with reference to Xilinx DS764 for v1.03.a [1].
>=20
> [1] https://www.xilinx.com/support/documentation/ip_documentation/axi_tim=
er/v1_03_a/axi_timer_ds764.pdf
>=20
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> Acked-by: Michal Simek <michal.simek@xilinx.com>
> ---
>=20
> Changes in v14:
> - 1GHz -> 1 GHz
> - Clarify that we will give a very wrong estimate for rate >=3D 1 GHz
> - Remove duplicate blank line
> - Remove forward declaration of xilinx_timer_common_init (which no
>   longer exists).
>=20
> Changes in v13:
> - Clamp period/duty_cycle by assuming rate is at most U32_MAX
> - Expand comment in xilinx_timer_get_period
> - Note that the 100% duty cycle calculations may be wrong for very high
>   clock rates
>=20
> Changes in v12:
> - Add a comment to the timer driver about #pwm-cells
> - Combine/expand comments on rounding in xilinx_pwm_apply
>=20
> Changes in v11:
> - Add comment about why we test for #pwm-cells
> - Clarify comment on generate out signal
> - Rename pwm variables to xilinx_pwm
> - Round like Uwe wants...
> - s/xilinx_timer/xilinx_pwm/ for non-common functions
>=20
> Changes in v10:
> - Fix compilation error in timer driver
>=20
> Changes in v9:
> - Refactor "if { return } else if { }" to "if { return } if { }"
> - Remove drivers/clocksource/timer-xilinx-common.c from MAINTAINERS
> - Remove xilinx_timer_common_init and integrate it into xilinx_timer_probe
>=20
> Changes in v8:
> - Drop new timer driver; it has been deferred for future series
>=20
> Changes in v7:
> - Add dependency on OF_ADDRESS
> - Fix period_cycles calculation
> - Fix typo in limitations
>=20
> Changes in v6:
> - Capitalize error messages
> - Don't disable regmap locking to allow inspection of registers via
>   debugfs
> - Prevent overflow when calculating period_cycles
> - Remove enabled variable from xilinx_pwm_apply
> - Swap order of period_cycle range comparisons
>=20
> Changes in v5:
> - Allow non-zero #pwm-cells
> - Correctly set duty_cycle in get_state when TLR0=3DTLR1
> - Elaborate on limitation section
> - Perform some additional checks/rounding in apply_state
> - Remove xlnx,axi-timer-2.0 compatible string
> - Rework duty-cycle and period calculations with feedback from Uwe
> - Switch to regmap to abstract endianness issues
> - Use more verbose error messages
>=20
> Changes in v4:
> - Don't use volatile in read/write replacements. Some arches have it and
>   some don't.
> - Put common timer properties into their own struct to better reuse
>   code.
> - Remove references to properties which are not good enough for Linux.
>=20
> Changes in v3:
> - Add clockevent and clocksource support
> - Remove old microblaze driver
> - Rewrite probe to only use a device_node, since timers may need to be
>   initialized before we have proper devices. This does bloat the code a b=
it
>   since we can no longer rely on helpers such as dev_err_probe. We also
>   cannot rely on device resources being free'd on failure, so we must free
>   them manually.
> - We now access registers through xilinx_timer_(read|write). This allows =
us
>   to deal with endianness issues, as originally seen in the microblaze
>   driver. CAVEAT EMPTOR: I have not tested this on big-endian!
>=20
> Changes in v2:
> - Add comment describing device
> - Add comment explaining why we depend on !MICROBLAZE
> - Add dependencies on COMMON_CLK and HAS_IOMEM
> - Cast dividends to u64 to avoid overflow
> - Check for over- and underflow when calculating TLR
> - Check range of xlnx,count-width
> - Don't compile this module by default for arm64
> - Don't set pwmchip.base to -1
> - Ensure the clock is always running when the pwm is registered
> - Remove debugfs file :l
> - Rename TCSR_(SET|CLEAR) to TCSR_RUN_(SET|CLEAR)
> - Report errors with dev_error_probe
> - Set xilinx_pwm_ops.owner
> - Use NSEC_TO_SEC instead of defining our own
> - Use TCSR_RUN_MASK to check if the PWM is enabled, as suggested by Uwe
>=20
>  MAINTAINERS                        |   6 +
>  arch/microblaze/kernel/timer.c     |   4 +
>  drivers/pwm/Kconfig                |  14 ++
>  drivers/pwm/Makefile               |   1 +
>  drivers/pwm/pwm-xilinx.c           | 321 +++++++++++++++++++++++++++++
>  include/clocksource/timer-xilinx.h |  73 +++++++
>  6 files changed, 419 insertions(+)
>  create mode 100644 drivers/pwm/pwm-xilinx.c
>  create mode 100644 include/clocksource/timer-xilinx.h

Applied with Uwe's s/>=3D 1 GHz/> 1 GHz/ ask applied. I've also changed
the MODULE_LICENSE string to just "GPL" since that's what checkpatch
requested.

Thanks,
Thierry

--26AvKSQgWTUB84pd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmJi2CMACgkQ3SOs138+
s6FcWw/7BFABcwflK3OYAHsCvZ5fuwI0Og/yTW3KV5l0XpWPoYE2B8DwjlonaJr2
9XAqP+0NuEe5S8H8YgEHZiZdBZmXZJFi6voekQZSpnSlE/Hv7JztjsifwhABeDd7
ZIZ0YOsvWpayOJO5G5ajz48QScSjrH+K6Mm0AYy2JtjGhF0p5K6KWVzAGKQCOqTj
4wsXmYYi8DIL6z5t+2av8R5ZP2XJFJu5LJJx6qaJ+zTx1j9jBDzukNWXEx+iAO1C
hxFCb18BAAHfV4eo/F8CoHtZYraNj5adz3FbZr1hJVmAbXH5yWjJR+kR/04rQa4L
FfYmPG94G+fGs1O6N0DNw430k9uanZePIyui7aEr2/HabP5XsMp8SGDJFLz5YbYF
3kT3xZguG1KNmUNvHm7I+rpUUsGAFbp6kwgoSwtSyfPsP7Ao5agDeiH2TCXbFmrL
z2YZilVBrjFMVz2Z747vba637BqZC+EEL8kZlE+jgvIGHWcgrzUYNY7wTe3Onwt4
qejNw54PYMSoreR3cmD8wD8BjWTAdTJhzeytZUAgOeNt6jYZBlT6w8v+usR16Nos
32CHMqTETkUojTmVPiXxRzg8j6UdCwRqVHeJ3BDnCbGMtID/TfPEdZ+OtlRcSaIV
fDv56cF03p6TCjfkBNeBIByBN89XAeNvgxGScwJUnwSOafZYm5I=
=wh3X
-----END PGP SIGNATURE-----

--26AvKSQgWTUB84pd--
