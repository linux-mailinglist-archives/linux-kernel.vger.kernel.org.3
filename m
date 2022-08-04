Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF8D589748
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 07:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238637AbiHDFLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 01:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbiHDFLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 01:11:44 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C6729C90;
        Wed,  3 Aug 2022 22:11:43 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id a89so23902900edf.5;
        Wed, 03 Aug 2022 22:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VyZa5TJB9oiw7FauEZNXxwEhTJ8c38FlpshZL71Yq5g=;
        b=I9+dszNyPQlVgxbzYD9E2EbYroZLkzVgaJEsEZVhu6OEzvgfaU9ERbqABInGimYesm
         O5MKciSgFuzqBQQ4PgHqQOUV4x6PILpEx1qhlawKFdmFIn61gxBuRrSCLFvHPAM2DhLG
         dMgeSAItCtuDTSuk2DbeH6OFLKpha0jprJXeEG/TWi9xNUvV8ai0npDukeZcniUiXY5X
         eBuDJATq1iC/x6W6OORZMBmc28DiF772r5PZ4pI84Cb19NiNLjCiEBI+5E7QtRP8f3Rf
         Tn6/Cbi6nsRH8OgDwbsn8jYL0GQMg1znnsjKV3JozifJzR80icg0b5g9N2+VfokU9iWq
         ycwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VyZa5TJB9oiw7FauEZNXxwEhTJ8c38FlpshZL71Yq5g=;
        b=xUg6cCpOU0kUcOK+905SySJ+p/TVOxLfGh8CmaBfdyDQHebJ6COs7pXcWmy0qKFU7G
         gejxLLre0lrlYT1v638mtFpmj3OU8CJ+9ZERN9sxFuk5BzIbJ8c7tfHUjd892uAfpqoF
         es707HqwEIq4T77QgS5JVJwgLdeNGbjNtZN84xJARcMh2nReaagUgLxfl9dVag/7veUW
         GnmHgh3Db2x3J+tHzdCMJrPRJJiUbDvpqtuYAzKVRO0lPAZPLhpuh+SNK9hKFZTy4Ihz
         l6coeJ3HTCQJhjOmso/15O8KML/7mgF1i9LYvZsApWkF5Od5LBhd3PVjPCLucnORI+np
         SNFg==
X-Gm-Message-State: ACgBeo0cMIVJu2AYSAMRTOeyGzZwEzodwKiH3hFDRFR1F+q2Gm3lM4Vn
        HmF6aKMcmPt9Kwj6oPwAVuc=
X-Google-Smtp-Source: AA6agR6uxLpA8e87m8/yg5mswH8hlsBA8l67gyBlhaV3Vi88H08mWYRGyheqjz6+QFEmbSo0t0R/4g==
X-Received: by 2002:a05:6402:3506:b0:43d:6a88:12cd with SMTP id b6-20020a056402350600b0043d6a8812cdmr197170edd.211.1659589901556;
        Wed, 03 Aug 2022 22:11:41 -0700 (PDT)
Received: from jernej-laptop.localnet (194-152-27-124.dynamic.telemach.net. [194.152.27.124])
        by smtp.gmail.com with ESMTPSA id g26-20020a170906539a00b0073080c22898sm4263400ejo.15.2022.08.03.22.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 22:11:41 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Rob Herring <robh@kernel.org>, Samuel Holland <samuel@sholland.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 3/4] regulator: dt-bindings: Add Allwinner D1 LDOs
Date:   Thu, 04 Aug 2022 07:11:39 +0200
Message-ID: <5588658.DvuYhMxLoT@jernej-laptop>
In-Reply-To: <918a83a7-1b8d-04b1-4f7b-386fc800e653@sholland.org>
References: <20220802053213.3645-1-samuel@sholland.org> <20220802150452.GA86158-robh@kernel.org> <918a83a7-1b8d-04b1-4f7b-386fc800e653@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne =C4=8Detrtek, 04. avgust 2022 ob 05:03:07 CEST je Samuel Holland napisa=
l(a):
> Hi Rob,
>=20
> Thanks again for your review.
>=20
> On 8/2/22 10:04 AM, Rob Herring wrote:
> > On Tue, Aug 02, 2022 at 12:32:12AM -0500, Samuel Holland wrote:
> >> The Allwinner D1 SoC contains two pairs of in-package LDOs. One pair is
> >> for general purpose use. LDOA generally powers the board's 1.8 V rail.
> >> LDOB generally powers the in-package DRAM, where applicable.
> >>=20
> >> The other pair of LDOs powers the analog power domains inside the SoC,
> >> including the audio codec, thermal sensor, and ADCs. These LDOs require
> >> a 0.9 V bandgap voltage reference. The calibration value for the volta=
ge
> >> reference is stored in an eFuse, accessed via an NVMEM cell.
> >>=20
> >> Neither LDO control register is in its own MMIO range; instead, each
> >> regulator device relies on a regmap/syscon exported by its parent.
> >>=20
> >> Signed-off-by: Samuel Holland <samuel@sholland.org>
> >> ---
> >>=20
> >> Changes in v2:
> >>  - Remove syscon property from bindings
> >>  - Update binding examples to fix warnings and provide context
> >> =20
> >>  .../allwinner,sun20i-d1-analog-ldos.yaml      | 65 +++++++++++++++++++
> >>  .../allwinner,sun20i-d1-system-ldos.yaml      | 57 ++++++++++++++++
> >>  2 files changed, 122 insertions(+)
> >>  create mode 100644
> >>  Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-analo=
g-
> >>  ldos.yaml create mode 100644
> >>  Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-syste=
m-
> >>  ldos.yaml>>=20
> >> diff --git
> >> a/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-anal=
og
> >> -ldos.yaml
> >> b/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-anal=
og
> >> -ldos.yaml new file mode 100644
> >> index 000000000000..19c984ef4e53
> >> --- /dev/null
> >> +++
> >> b/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-anal=
og
> >> -ldos.yaml @@ -0,0 +1,65 @@
> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id:
> >> http://devicetree.org/schemas/regulator/allwinner,sun20i-d1-analog-ldo=
s.
> >> yaml# +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Allwinner D1 Analog LDOs
> >> +
> >> +description:
> >> +  Allwinner D1 contains a set of LDOs which are designed to supply
> >> analog power +  inside and outside the SoC. They are controlled by a
> >> register within the audio +  codec MMIO space, but which is not part of
> >> the audio codec clock/reset domain. +
> >> +maintainers:
> >> +  - Samuel Holland <samuel@sholland.org>
> >> +
> >> +properties:
> >> +  compatible:
> >> +    enum:
> >> +      - allwinner,sun20i-d1-analog-ldos
> >> +
> >> +  nvmem-cells:
> >> +    items:
> >> +      - description: NVMEM cell for the calibrated bandgap reference
> >> trim value +
> >> +  nvmem-cell-names:
> >> +    items:
> >> +      - const: bg_trim
> >> +
> >> +patternProperties:
> >=20
> >> +  "^(aldo|hpldo)$":
> > '^(a|hp)ldo$'
> >=20
> >> +    type: object
> >> +    $ref: regulator.yaml#
> >>=20
> >        unevaluatedProperties: false
> >>=20
> >> +
> >> +required:
> >> +  - compatible
> >> +  - nvmem-cells
> >> +  - nvmem-cell-names
> >> +
> >> +unevaluatedProperties: false
> >> +
> >> +examples:
> >> +  - |
> >> +    audio-codec@2030000 {
> >> +        compatible =3D "simple-mfd", "syscon";
> >=20
> > Needs a specific compatible. Obviously there's some other functionality
> > here if this is an 'audio-codec'.
>=20
> I am not yet ready to submit the binding or driver for the audio codec, a=
s I
> still need to work out the details for jack detection (and some other
> issues). If I added the specific audio codec compatible now, without the
> properties required for the sound driver, that would create backward
> compatibility issues, right?
>=20
> My intention is to add the specific compatible along with the ASoC suppor=
t.
>=20
> > 'simple-mfd' also means the child nodes have zero dependence on the
> > parent node and its resources.
>=20
> That is correct. The regulators have zero dependencies on the audio codec
> resources (clocks/resets/etc.). The _only_ relationship is the overlapping
> address of the MMIO register.

LDO registers are at the end of analogue codec MMIO space, right? We can=20
easily split that to separate device, like it's been done for A20 timer &=20
watchdog.

Best regards,
Jernej

>=20
> >> +        reg =3D <0x2030000 0x1000>;
> >> +
> >> +        regulators {
> >> +            compatible =3D "allwinner,sun20i-d1-analog-ldos";
> >=20
> > Is there a defined set of registers for these regulators? If so, put
> > them into 'reg'.
>=20
> What do you suggest for 'ranges' in the parent device? I ask because the
> SRAM/system controller binding requires an empty 'ranges' property.
>=20
> With empty 'ranges', the child has to compute the relative address for use
> with the parent's regmap, but maybe that is okay?
>=20
> >> +            nvmem-cells =3D <&bg_trim>;
> >> +            nvmem-cell-names =3D "bg_trim";
> >> +
> >> +            reg_aldo: aldo {
> >> +                regulator-min-microvolt =3D <1800000>;
> >> +                regulator-max-microvolt =3D <1800000>;
> >> +            };
> >> +
> >> +            reg_hpldo: hpldo {
> >> +                regulator-min-microvolt =3D <1800000>;
> >> +                regulator-max-microvolt =3D <1800000>;
> >> +            };
> >> +        };
> >> +    };
> >> +
> >> +...
> >> diff --git
> >> a/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-syst=
em
> >> -ldos.yaml
> >> b/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-syst=
em
> >> -ldos.yaml new file mode 100644
> >> index 000000000000..c95030a827d6
> >> --- /dev/null
> >> +++
> >> b/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-syst=
em
> >> -ldos.yaml @@ -0,0 +1,57 @@
> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id:
> >> http://devicetree.org/schemas/regulator/allwinner,sun20i-d1-system-ldo=
s.
> >> yaml# +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Allwinner D1 System LDOs
> >> +
> >> +description:
> >> +  Allwinner D1 contains a pair of general-purpose LDOs which are
> >> designed to +  supply power inside and outside the SoC. They are
> >> controlled by a register +  within the system control MMIO space.
> >> +
> >> +maintainers:
> >> +  - Samuel Holland <samuel@sholland.org>
> >> +
> >> +properties:
> >> +  compatible:
> >> +    enum:
> >> +      - allwinner,sun20i-d1-system-ldos
> >> +
> >> +patternProperties:
> >=20
> >> +  "^(ldoa|ldob)$":
> > '^ldo[ab]$'
> >=20
> > Any reason the naming is not consistent with 'ldo' as the prefix or
> > suffix?
>=20
> All four names match the pin names from the SoC datasheet.
>=20
> >> +    type: object
> >> +    $ref: regulator.yaml#
> >>=20
> >        unevaluatedProperties: false
>=20
> I will fix these for v3.
>=20
> Regards,
> Samuel
>=20
> >> +
> >> +required:
> >> +  - compatible
> >> +
> >> +unevaluatedProperties: false
> >> +
> >> +examples:
> >> +  - |
> >> +    syscon@3000000 {
> >> +        compatible =3D "allwinner,sun20i-d1-system-control";
> >> +        reg =3D <0x3000000 0x1000>;
> >> +        ranges;
> >> +        #address-cells =3D <1>;
> >> +        #size-cells =3D <1>;
> >> +
> >> +        regulators {
> >> +            compatible =3D "allwinner,sun20i-d1-system-ldos";
> >> +
> >> +            reg_ldoa: ldoa {
> >> +                regulator-min-microvolt =3D <1800000>;
> >> +                regulator-max-microvolt =3D <1800000>;
> >> +            };
> >> +
> >> +            reg_ldob: ldob {
> >> +                regulator-name =3D "vcc-dram";
> >> +                regulator-min-microvolt =3D <1500000>;
> >> +                regulator-max-microvolt =3D <1500000>;
> >> +            };
> >> +        };
> >> +    };
> >> +
> >> +...




