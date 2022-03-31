Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0B04EE45B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 00:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242678AbiCaWx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 18:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233610AbiCaWxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 18:53:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3241D4C0D;
        Thu, 31 Mar 2022 15:51:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB079B82207;
        Thu, 31 Mar 2022 22:51:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0A9C340ED;
        Thu, 31 Mar 2022 22:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648767094;
        bh=QZtPMXY6JUY/ZfIXbEGhe3FtZuMlYLYppA7pePl5R5Q=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=eUVu2/0sluYfq3DhNMOnQ4SajAYtEbiavPa1PqSheOk4ucJs3VxLKjLCLbuGbl9hO
         XuevYEOKMXwSFS/Tpb+r6f0IqPoBQqigC7l8mm0W4emupTTfmjEAHRYe3HZTgo8MIo
         SB4MnkP4WO8ZQkr5M6AtdtP24O8ABHi2QQteUeQASfyFZz1LMIQ/++bGvSwA0zUB+x
         tG8mkgKQJtBS7khMW7VkW9z3PuK29qPubZP0ClVE/p5/SqQ1TyJbDQvGQabWYbxM9r
         Nl4jL3godJaYUbHrN8K0r810g5D2tRiYZAWPeRUZsKJkZR22ObCIHOQ3uyxxPbTGY6
         DO11ilqutw7hw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220329111323.3569-1-jbx6244@gmail.com>
References: <20220329111323.3569-1-jbx6244@gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: clock: convert rockchip,rk3188-cru.txt to YAML
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Johan Jonker <jbx6244@gmail.com>, heiko@sntech.de,
        zhangqing@rock-chips.com
Date:   Thu, 31 Mar 2022 15:51:32 -0700
User-Agent: alot/0.10
Message-Id: <20220331225134.7A0A9C340ED@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Johan Jonker (2022-03-29 04:13:22)
> diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.=
yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.yaml
> new file mode 100644
> index 000000000..ddd7e46af
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.yaml
> @@ -0,0 +1,78 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/rockchip,rk3188-cru.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip RK3188/RK3066 Clock and Reset Unit (CRU)
> +
> +maintainers:
> +  - Elaine Zhang <zhangqing@rock-chips.com>
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +description: |
> +  The RK3188/RK3066 clock controller generates and supplies clocks to va=
rious
> +  controllers within the SoC and also implements a reset controller for =
SoC
> +  peripherals.
> +  Each clock is assigned an identifier and client nodes can use this ide=
ntifier
> +  to specify the clock which they consume. All available clocks are defi=
ned as
> +  preprocessor macros in the dt-bindings/clock/rk3188-cru.h and
> +  dt-bindings/clock/rk3066-cru.h headers and can be used in device tree =
sources.
> +  Similar macros exist for the reset sources in these files.
> +  There are several clocks that are generated outside the SoC. It is exp=
ected
> +  that they are defined using standard clock bindings with following
> +  clock-output-names:
> +    - "xin24m"    - crystal input                 - required
> +    - "xin32k"    - RTC clock                     - optional
> +    - "xin27m"    - 27mhz crystal input on RK3066 - optional
> +    - "ext_hsadc" - external HSADC clock          - optional
> +    - "ext_cif0"  - external camera clock         - optional
> +    - "ext_rmii"  - external RMII clock           - optional
> +    - "ext_jtag"  - external JTAG clock           - optional

I'd expect all these clks here to be inputs to this node.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - rockchip,rk3066a-cru
> +      - rockchip,rk3188-cru
> +      - rockchip,rk3188a-cru
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#clock-cells":
> +    const: 1
> +
> +  "#reset-cells":
> +    const: 1
> +
> +  clocks:
> +    maxItems: 1

so that maxItems here should be larger and minItems would be 1?

> +
> +  clock-names:
> +    const: xin24m
> +
> +  rockchip,grf:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the syscon managing the "general register files" (GRF),
> +      if missing pll rates are not changeable, due to the missing pll
> +      lock status.
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#clock-cells"
> +  - "#reset-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    cru: clock-controller@20000000 {
> +      compatible =3D "rockchip,rk3188-cru";
> +      reg =3D <0x20000000 0x1000>;
> +      rockchip,grf =3D <&grf>;
> +      #clock-cells =3D <1>;
> +      #reset-cells =3D <1>;

Where is clocks in the example?
