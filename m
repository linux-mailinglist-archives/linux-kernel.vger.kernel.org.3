Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1E550BD08
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241617AbiDVQcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449696AbiDVQb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:31:59 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763715F274;
        Fri, 22 Apr 2022 09:29:04 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id bu29so15255121lfb.0;
        Fri, 22 Apr 2022 09:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VVq6o5wCZGSmTHfLzRyLr+TER7G1UwlwBLgm07wTDMk=;
        b=M1BWlbkx/D7WiJ0YQ03dvxAcXcayXtVA8uekyyCVvlvT2F0BkXHG5lLcy6+6zHBEIp
         yW5/BrqxzVneAMh7yZve38nO2oAatYQL+sVQaUYz9vizrRZ68MQ08zUsWAWiy75ZEL8J
         kQKCbK8GNDP4nuucy+b7Yx1lHGHqIVvAv5YfYQX+CtbIKkx/HT65EPh6oXbvoHk78vFh
         Y4y3i3xVTWukRLDqbNTHbgC3DzXrj51lU83BVab6XbLX/sXWGPCEuPMi0mqElDfGAQHT
         34EcM7njIJo7L1WwAl0FRH02p/gcfDNRYoV6g+OngyHVwKCU27/rdMFlSTZgCv0s9qHJ
         JmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VVq6o5wCZGSmTHfLzRyLr+TER7G1UwlwBLgm07wTDMk=;
        b=KY1wEXKIoBsW95QjkX7cWQKNOyxI4IAz6VU6qwJEPQpDYAJdQ+DCcDbpVL6dIkOaQI
         AgJIp5VfGuWxpUxTAxf4lodIXP+dDkBZzbsBK0aqdNQjMvPhawg6BatUxCb+qLtMVKlN
         oYdvlVvLxPDcgq1lS3OSJ7B41XRBnOI40HxRDvBySqVZ79M3RsL44G3oDzuq9T7DEH+/
         c5cR/JFrz+w7mKG65nov6tux/oVHD4/7H/PIQw9TEL1krdXTP96Ur7e8WvDCdHjx+L8e
         PjzWLW6mAaxtglR3QEL2gNEcKmQESZ6c+dM0M94wqAg7ic7tA+XKB0b7J466L87yFLTA
         Pmwg==
X-Gm-Message-State: AOAM5320Or88ZgWEWwFBl7WeDpRGbD/jpVqK7BBGmAjvihk49XNq0obJ
        q7p4slnRkFrY33zW1Dzhz5M=
X-Google-Smtp-Source: ABdhPJzySzGOHFiWGM/zRng+nCTx4pCvMpMfe01qKenQAmazDLEkLJnzdxvnhOhdSTNeiaCdn1s2EA==
X-Received: by 2002:a05:6512:2293:b0:471:9951:3978 with SMTP id f19-20020a056512229300b0047199513978mr3710433lfu.101.1650644942290;
        Fri, 22 Apr 2022 09:29:02 -0700 (PDT)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id q7-20020a2e84c7000000b0024da52893c4sm268255ljh.22.2022.04.22.09.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 09:29:01 -0700 (PDT)
Date:   Fri, 22 Apr 2022 18:28:58 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Mubin Usman Sayyed <MUBINUSM@xilinx.com>,
        linux-arm-kernel@lists.infradead.org,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, michal.simek@xilinx.com,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v14 1/2] dt-bindings: pwm: Add Xilinx AXI Timer
Message-ID: <YmLXyoBOPA8NqjHY@orome>
References: <20220303223544.2810594-1-sean.anderson@seco.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ItmECfP7fegOVQ7B"
Content-Disposition: inline
In-Reply-To: <20220303223544.2810594-1-sean.anderson@seco.com>
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


--ItmECfP7fegOVQ7B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 03, 2022 at 05:35:42PM -0500, Sean Anderson wrote:
> This adds a binding for the Xilinx LogiCORE IP AXI Timer. This device is a
> "soft" block, so it has some parameters which would not be configurable in
> most hardware. This binding is usually automatically generated by Xilinx's
> tools, so the names and values of some properties should be kept as they
> are, if possible. In addition, this binding is already in the kernel at
> arch/microblaze/boot/dts/system.dts, and in user software such as QEMU.
>=20
> The existing driver uses the clock-frequency property, or alternatively t=
he
> /cpus/timebase-frequency property as its frequency input. Because these
> properties are deprecated, they have not been included with this schema.
> All new bindings should use the clocks/clock-names properties to specify
> the parent clock.
>=20
> Because we need to init timer devices so early in boot, we determine if we
> should use the PWM driver or the clocksource/clockevent driver by the
> presence/absence, respectively, of #pwm-cells. Because both counters are
> used by the PWM, there is no need for a separate property specifying which
> counters are to be used for the PWM.
>=20
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>=20
> (no changes since v8)
>=20
> Changes in v8:
> - Set additionalProperties: false
>=20
> Changes in v7:
> - Add #pwm-cells to properties
> - Document why additionalProperties is true
>=20
> Changes in v6:
> - Enumerate possible counter widths
> - Fix incorrect schema id
>=20
> Changes in v5:
> - Add example for timer binding
> - Fix indentation lint
> - Move schema into the timer directory
> - Remove xlnx,axi-timer-2.0 compatible string
> - Update commit message to reflect revisions
>=20
> Changes in v4:
> - Make some properties optional for clocksource drivers
> - Predicate PWM driver on the presence of #pwm-cells
> - Remove references to generate polarity so this can get merged
>=20
> Changes in v3:
> - Add an example with non-deprecated properties only.
> - Add xlnx,pwm and xlnx,gen?-active-low properties.
> - Make newer replacement properties mutually-exclusive with what they
>   replace
> - Mark all boolean-as-int properties as deprecated
>=20
> Changes in v2:
> - Use 32-bit addresses for example binding
>=20
>  .../bindings/timer/xlnx,xps-timer.yaml        | 92 +++++++++++++++++++
>  1 file changed, 92 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/xlnx,xps-time=
r.yaml

Applied, thanks.

Thierry

--ItmECfP7fegOVQ7B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmJi18oACgkQ3SOs138+
s6FB8hAAvpxjBL7o8vIHq7JAbsyCS94ow+zAQsfsUoEVPUIQL2UZVyscJkPtqPnv
8FSyKLpkpbZoQX88i5+/UZSceI2AFzOH+UjlJJi2t8Fqlfj+R/EB0ZeKWE5k9c9Q
w5JzxWwJZOWcFQ3RBQlqXb9F//tBFySp4PEJhs3z8BvPhRO/a2ibssV4FZnYV7wP
OXMk/qa08Wa3R2dt1uKkiHVqWqMJjfeerFF60eLKZGbGaZtjCERHZE93RLj608m/
pZfYjsWN+hou6e/ywZcs2Y1c+85B9iANSqSbVyKZC75rjZ21+FySwtQq/ROhTidQ
eLM4B9Usq1F72g8Ktq8lUl0tscUkibo2hQ3tDqNsvEV2IXdXlLTMOgkWAAaVrbzX
eXpyJdnL106xlSJjaoMGlPJ1UpYZiZYsWSF/qjDrwC5326+g5PpFfKfHlcuH3603
1u4LPnJf2pn+KyM69zUeOMElxLoz18Nu1iEE+2vp0ET6PuZHUtXOY9Ib84tYy55o
qBSa5kJFOYABryUrnFjQxLe7nV0xoNo+lvbSqfH42TBX8JMFqRDpyiyKSJ/Vtc71
+3asUk5u7t5YA2g27DF63kLadBhfLyKtdwm1M3QjZSqQslqxm3oKM65rRC1hicjh
6/V9n+HfRH/fOxozOFYutCiFyJAwEfuEqMUaB9akdt2IcZ/c5iM=
=hSsw
-----END PGP SIGNATURE-----

--ItmECfP7fegOVQ7B--
