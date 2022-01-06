Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C10485E27
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 02:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344404AbiAFBbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 20:31:10 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:47150 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344399AbiAFBbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 20:31:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E6726198A;
        Thu,  6 Jan 2022 01:31:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842FCC36AEB;
        Thu,  6 Jan 2022 01:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641432660;
        bh=Iwj05aKWewpLNoRYcVUDH50+c9SAsTaThMF89Too084=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=k6Wa1JAm5YH23lmwEFAtDilxCcHgNO8f1s1PYsky5OlqA8D4nfl/DUiDE7wn8onv3
         HSVWhRMX7/wxPwJwQNWTDT5/Xw2H8ygCXUsmVRYu5WfUZr8/R3YcO1Pa/N/prEwmad
         Sjis1vI5JrDP2BAVhLaw2vYm3XrMKzmyDF/gU/V4FRslmpDyjzUlvytr7dfzguFY3N
         UhQL3SOjGkAP29Wf9WwXT9Z5U2Ay3Hm+6HnzogXemAdW0nqN8K1zy600LUE+ZP3j4j
         k8PX7gXhC0ulF9K2Jgy5fJ6oqiL2DHEk9qtNfJNWx/7Jsa0vsdcSkWMtOefX1BGEg4
         7XVANSC83e22g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211217112345.14029-7-nbd@nbd.name>
References: <20211217112345.14029-1-nbd@nbd.name> <20211217112345.14029-7-nbd@nbd.name>
Subject: Re: [PATCH v7 06/14] dt-bindings: Add en7523-scu device tree binding documentation
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     john@phrozen.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Felix Fietkau <nbd@nbd.name>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Wed, 05 Jan 2022 17:30:58 -0800
User-Agent: alot/0.9.1
Message-Id: <20220106013100.842FCC36AEB@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Felix Fietkau (2021-12-17 03:23:36)
> diff --git a/Documentation/devicetree/bindings/clock/airoha,en7523-scu.ya=
ml b/Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml
> new file mode 100644
> index 000000000000..79660f8126fa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/airoha,en7523-scu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: EN7523 Clock Device Tree Bindings
> +
> +maintainers:
> +  - Felix Fietkau <nbd@nbd.name>
> +  - John Crispin <nbd@nbd.name>
> +
> +description: |
> +  This node defines the System Control Unit of the EN7523 SoC,
> +  a collection of registers configuring many different aspects of the So=
C.
> +
> +  The clock driver uses it to read and configure settings of the
> +  PLL controller, which provides clocks for the CPU, the bus and
> +  other SoC internal peripherals.
> +
> +  Each clock is assigned an identifier and client nodes use this identif=
ier
> +  to specify which clock they consume.
> +
> +  All these identifiers can be found in:
> +  [1]: <include/dt-bindings/clock/en7523-clk.h>.
> +
> +  The clocks are provided inside a system controller node.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: airoha,en7523-scu
> +
> +  reg:
> +    maxItems: 2
> +
> +  "#clock-cells":
> +    description:
> +      The first cell indicates the clock number, see [1] for available
> +      clocks.
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#clock-cells'
> +

Any input clocks?

> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/en7523-clk.h>
> +    scu: scu@1fa20000 {

Maybe that should be system-controller@1fa20000 instead?

> +      compatible =3D "airoha,en7523-scu";
> +      reg =3D <0x1fa20000 0x400>,
> +            <0x1fb00000 0x1000>;
> +      #clock-cells =3D <1>;
> +    };
