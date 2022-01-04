Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F181483B3E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 05:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbiADEO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 23:14:28 -0500
Received: from mail-4319.protonmail.ch ([185.70.43.19]:52357 "EHLO
        mail-4319.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiADEO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 23:14:27 -0500
Date:   Tue, 04 Jan 2022 04:14:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1641269664;
        bh=IvTkpfbUiuCp5b5JT8RQ28eHfOSOWqPHcurO4pZoOwM=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=R37NhaWLqXh9AnVJC1AeqSNqLvKw0Zg0KN/2PbYCGzoF4aZf5NtVbKB66ElieSo9+
         SLDs8LPtVCCVMdHryC0tAel14Q2kVNHi69flMT3IDROhOpxTEt4cDFV3jEf4114s6q
         /ANd0Xgm8UQUCwMBt0E//mQrIEC+DZ1CLxh/A9iDJa/ugqHoSMVCpcg298xZfDIcLe
         pHvv0jhXgVisPF0bcUDkLGKQxNVdOs5raXsk1NV91d/2KP2KT523TeNRm/qEq+/FyQ
         Z/5/GPXw9UKlHp9NU0kVjbWdfKcMOOzC45Y3a0m+RgO98JRNuxPGm8xaoX46HlFxyh
         SpdOTHQsl+zsg==
To:     Rob Herring <robh@kernel.org>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Niklas Cassel <nks@flawful.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: Re: [PATCH] dt-bindings: power: avs: qcom,cpr: Convert to DT schema
Message-ID: <20220104041303.349963-1-y.oudjana@protonmail.com>
In-Reply-To: <YcJgDToAY/vXXekl@robh.at.kernel.org>
References: <20211221133937.173618-1-y.oudjana@protonmail.com> <YcJgDToAY/vXXekl@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Dec 2021 19:15:25 -0400, Rob Herring <robh@kernel.org> wrote:
> On Tue, Dec 21, 2021 at 01:40:05PM +0000, Yassine Oudjana wrote:
> > Convert qcom,cpr.txt to DT schema format.
> >=20
> > Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> > ---
> >  .../bindings/power/avs/qcom,cpr.txt           | 130 --------------
> >  .../bindings/power/avs/qcom,cpr.yaml          | 161 ++++++++++++++++++
> >  MAINTAINERS                                   |   2 +-
> >  3 files changed, 162 insertions(+), 131 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/power/avs/qcom,cp=
r.txt
> >  create mode 100644 Documentation/devicetree/bindings/power/avs/qcom,cp=
r.yaml
>=20
>=20
> > diff --git a/Documentation/devicetree/bindings/power/avs/qcom,cpr.yaml =
b/Documentation/devicetree/bindings/power/avs/qcom,cpr.yaml
> > new file mode 100644
> > index 000000000000..852eb36eea93
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/avs/qcom,cpr.yaml
> > @@ -0,0 +1,161 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/power/avs/qcom,cpr.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Qualcomm Core Power Reduction (CPR) bindings
> > +
> > +maintainers:
> > +  - Niklas Cassel <nks@flawful.org>
> > +
> > +description: |
> > +  CPR (Core Power Reduction) is a technology to reduce core power on a=
 CPU
> > +  or other device. Each OPP of a device corresponds to a "corner" that=
 has
> > +  a range of valid voltages for a particular frequency. While the devi=
ce is
> > +  running at a particular frequency, CPR monitors dynamic factors such=
 as
> > +  temperature, etc. and suggests adjustments to the voltage to save po=
wer
> > +  and meet silicon characteristic requirements.
> > +
> > +properties:
> > +  compatible:
> > +    allOf:
>=20
> Don't need allOf with only 1 entry.

I get this from dt_binding_check without it:

Documentation/devicetree/bindings/power/avs/qcom,cpr.yaml: properties:compa=
tible: [{'items': [{'enum': ['qcom,qcs404-cpr']}, {'const': 'qcom,cpr'}]}] =
is not of type 'object', 'boolean'

>=20
> > +      - items:
> > +          - enum:
> > +              - qcom,qcs404-cpr
> > +          - const: qcom,cpr
> > +
> > +  reg:
> > +    description: Base address and size of the RBCPR register region.
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: Reference clock.
> > +
> > +  clock-names:
> > +    items:
> > +      - const: ref
> > +
> > +  vdd-apc-supply:
> > +    description: APC regulator supply.
> > +
> > +  '#power-domain-cells':
> > +    const: 0
> > +
> > +  operating-points-v2:
> > +    description: |
> > +      A phandle to the OPP table containing the performance states
> > +      supported by the CPR power domain.
> > +
> > +  acc-syscon:
> > +    description: A phandle to the syscon used for writing ACC settings=
.
> > +
> > +  nvmem-cells:
> > +    items:
> > +      - description: Corner 1 quotient offset
> > +      - description: Corner 2 quotient offset
> > +      - description: Corner 3 quotient offset
> > +      - description: Corner 1 initial voltage
> > +      - description: Corner 2 initial voltage
> > +      - description: Corner 3 initial voltage
> > +      - description: Corner 1 quotient
> > +      - description: Corner 2 quotient
> > +      - description: Corner 3 quotient
> > +      - description: Corner 1 ring oscillator
> > +      - description: Corner 2 ring oscillator
> > +      - description: Corner 3 ring oscillator
> > +      - description: Fuse revision
> > +
> > +  nvmem-cell-names:
> > +    items:
> > +      - const: cpr_quotient_offset1
> > +      - const: cpr_quotient_offset2
> > +      - const: cpr_quotient_offset3
> > +      - const: cpr_init_voltage1
> > +      - const: cpr_init_voltage2
> > +      - const: cpr_init_voltage3
> > +      - const: cpr_quotient1
> > +      - const: cpr_quotient2
> > +      - const: cpr_quotient3
> > +      - const: cpr_ring_osc1
> > +      - const: cpr_ring_osc2
> > +      - const: cpr_ring_osc3
> > +      - const: cpr_fuse_revision
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +  - clock-names
> > +  - vdd-apc-supply
> > +  - '#power-domain-cells'
> > +  - operating-points-v2
> > +  - nvmem-cells
> > +  - nvmem-cell-names
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    cpr_opp_table: cpr-opp-table {
> > +        compatible =3D "operating-points-v2-qcom-level";
> > +
> > +        cpr_opp1: opp1 {
> > +            opp-level =3D <1>;
> > +            qcom,opp-fuse-level =3D <1>;
> > +        };
> > +        cpr_opp2: opp2 {
> > +            opp-level =3D <2>;
> > +            qcom,opp-fuse-level =3D <2>;
> > +        };
> > +        cpr_opp3: opp3 {
> > +            opp-level =3D <3>;
> > +            qcom,opp-fuse-level =3D <3>;
> > +        };
> > +    };
> > +
> > +    power-controller@b018000 {
> > +        compatible =3D "qcom,qcs404-cpr", "qcom,cpr";
> > +        reg =3D <0x0b018000 0x1000>;
> > +        interrupts =3D <0 15 IRQ_TYPE_EDGE_RISING>;
> > +        clocks =3D <&xo_board>;
> > +        clock-names =3D "ref";
> > +        vdd-apc-supply =3D <&pms405_s3>;
> > +        #power-domain-cells =3D <0>;
> > +        operating-points-v2 =3D <&cpr_opp_table>;
> > +        acc-syscon =3D <&tcsr>;
> > +
> > +        nvmem-cells =3D <&cpr_efuse_quot_offset1>,
> > +            <&cpr_efuse_quot_offset2>,
> > +            <&cpr_efuse_quot_offset3>,
> > +            <&cpr_efuse_init_voltage1>,
> > +            <&cpr_efuse_init_voltage2>,
> > +            <&cpr_efuse_init_voltage3>,
> > +            <&cpr_efuse_quot1>,
> > +            <&cpr_efuse_quot2>,
> > +            <&cpr_efuse_quot3>,
> > +            <&cpr_efuse_ring1>,
> > +            <&cpr_efuse_ring2>,
> > +            <&cpr_efuse_ring3>,
> > +            <&cpr_efuse_revision>;
> > +        nvmem-cell-names =3D "cpr_quotient_offset1",
> > +            "cpr_quotient_offset2",
> > +            "cpr_quotient_offset3",
> > +            "cpr_init_voltage1",
> > +            "cpr_init_voltage2",
> > +            "cpr_init_voltage3",
> > +            "cpr_quotient1",
> > +            "cpr_quotient2",
> > +            "cpr_quotient3",
> > +            "cpr_ring_osc1",
> > +            "cpr_ring_osc2",
> > +            "cpr_ring_osc3",
> > +            "cpr_fuse_revision";
> > +    };
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index a7d86182fa6b..9ebbccb0494e 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -15746,7 +15746,7 @@ M:=09Niklas Cassel <nks@flawful.org>
> >  L:=09linux-pm@vger.kernel.org
> >  L:=09linux-arm-msm@vger.kernel.org
> >  S:=09Maintained
> > -F:=09Documentation/devicetree/bindings/power/avs/qcom,cpr.txt
> > +F:=09Documentation/devicetree/bindings/power/avs/qcom,cpr.yaml
> >  F:=09drivers/soc/qcom/cpr.c
> > =20
> >  QUALCOMM CPUFREQ DRIVER MSM8996/APQ8096
> > --=20
> > 2.34.1
> >=20
> >=20
> >=20
>=20

