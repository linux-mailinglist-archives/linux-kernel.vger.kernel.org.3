Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E43D5612B4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 08:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbiF3GpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 02:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbiF3GpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 02:45:17 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3662031205
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 23:45:15 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id r9so16491317ljp.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 23:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:user-agent:in-reply-to:references:message-id
         :mime-version:content-transfer-encoding;
        bh=fTV3UZJ8iWa2cSqb4oJMbGSxrzXh4aLO9yzSsaSbNW8=;
        b=sQ9mpyLEUMu6hJYiXdFDncQJ0BJCa0ot78zi4pUlPT7BFc1v8Yh/MQgyo0E1wiOljb
         Tl+6R0AfPc8ImR3AKsWMP7G4PYLa7h9v/XJXineSAeEC7LsEAFB6eVp+2rYOYsI0xjyT
         XN3rDDxv+lrxceIdHxjWz8g19DPvLUBPkzsk74lvrlyodedG8fFbBi/EuzJl6r8VD4O7
         yr2ko687WHJ/ZkL786xe9BD+SEjfimE+KQ6a8rcT8yZRs0/bG8HQzAgiaNmyjf8Og9uy
         NgLzAeooWsIXOgd2H0VjXBhgLabIex/hIXQTmUAEGltppttpn5fD2ZcSt1gOFezRQ5tE
         DYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=fTV3UZJ8iWa2cSqb4oJMbGSxrzXh4aLO9yzSsaSbNW8=;
        b=uYhv/JbnX0y6vDb3dzPi4I6QOiNaPL6TL8vkKgF6qP1QaFPrUMmjodVtZQ/FD+a2Ki
         nIIP0DOrSh1HN2W+qttL0yKqIeBU1f7yV0wU3wTZQGGsKO4EYTxguwYPkkVDteAFZvjb
         jvTP5Us2EssBtWllkXZVfm699UhwBFLSReGROhpIMcB/7i2ROyj9Qk6ayweHG//Nh9uy
         NqH0ulEGWgxWdnDaBt+FBngde+VFUTG2SmK0oZ5Wzr2IFJlFT3ZYRV80y5MsddI07RUU
         PKYqp3qb+oEEEPdxjLoWb1qzqrw0rJ7LEyL0+RYsXJMm5z1eiLubE3RJ6HgAYFohWFMw
         3JLg==
X-Gm-Message-State: AJIora/zafT176gNnbF9dglv7Y9Q+dQs1qv0UoQ1paExn1X/JbUPXHjK
        aZJP/mL77KWymkPe2Dhgn0Biyw==
X-Google-Smtp-Source: AGRyM1sg5NrMfFA43dw9hkBCjjzWbbjZlTBQWU2W1F81EEQzjiWxr05HUwdPiFvHyKlySpuzKLH/Pw==
X-Received: by 2002:a05:651c:158c:b0:250:a23d:2701 with SMTP id h12-20020a05651c158c00b00250a23d2701mr4209164ljq.475.1656571513552;
        Wed, 29 Jun 2022 23:45:13 -0700 (PDT)
Received: from [127.0.0.1] ([94.25.229.210])
        by smtp.gmail.com with ESMTPSA id 20-20020ac25f54000000b0047fa0251460sm2942546lfz.174.2022.06.29.23.45.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jun 2022 23:45:12 -0700 (PDT)
Date:   Thu, 30 Jun 2022 09:43:05 +0300
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_3/5=5D_dt-bindings=3A_arm=3A_msm=3A_R?= =?US-ASCII?Q?ework_kpss-gcc_driver_Documentation_to_yaml?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20220629121441.6552-4-ansuelsmth@gmail.com>
References: <20220629121441.6552-1-ansuelsmth@gmail.com> <20220629121441.6552-4-ansuelsmth@gmail.com>
Message-ID: <D90DE67E-DA29-4A0D-BBC1-C8209FDF69D3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29 June 2022 15:14:39 GMT+03:00, Christian Marangi <ansuelsmth@gmail=2E=
com> wrote:
>Rework kpss-gcc driver Documentation to yaml Documentation=2E
>The current kpss-gcc Documentation have major problems and can't be
>converted directly=2E Introduce various changes to the original
>Documentation=2E
>
>Add #clock-cells additional binding as this clock outputs a static clk
>named acpu_l2_aux with supported compatible=2E
>Only some compatible require and outputs a clock, for the others, set
>only the reg as a required binding to correctly export the kpss-gcc
>registers=2E As the reg is shared also add the required syscon compatible=
=2E
>
>Signed-off-by: Christian Marangi <ansuelsmth@gmail=2Ecom>
>---
> =2E=2E=2E/bindings/arm/msm/qcom,kpss-gcc=2Etxt        | 44 ---------
> =2E=2E=2E/bindings/arm/msm/qcom,kpss-gcc=2Eyaml       | 90 +++++++++++++=
++++++
> 2 files changed, 90 insertions(+), 44 deletions(-)
> delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-g=
cc=2Etxt
> create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-g=
cc=2Eyaml
>
>diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc=2Etx=
t b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc=2Etxt
>deleted file mode 100644
>index e628758950e1=2E=2E000000000000
>--- a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc=2Etxt
>+++ /dev/null
>@@ -1,44 +0,0 @@
>-Krait Processor Sub-system (KPSS) Global Clock Controller (GCC)
>-
>-PROPERTIES
>-
>-- compatible:
>-	Usage: required
>-	Value type: <string>
>-	Definition: should be one of the following=2E The generic compatible
>-			"qcom,kpss-gcc" should also be included=2E
>-			"qcom,kpss-gcc-ipq8064", "qcom,kpss-gcc"
>-			"qcom,kpss-gcc-apq8064", "qcom,kpss-gcc"
>-			"qcom,kpss-gcc-msm8974", "qcom,kpss-gcc"
>-			"qcom,kpss-gcc-msm8960", "qcom,kpss-gcc"
>-
>-- reg:
>-	Usage: required
>-	Value type: <prop-encoded-array>
>-	Definition: base address and size of the register region
>-
>-- clocks:
>-	Usage: required
>-	Value type: <prop-encoded-array>
>-	Definition: reference to the pll parents=2E
>-
>-- clock-names:
>-	Usage: required
>-	Value type: <stringlist>
>-	Definition: must be "pll8_vote", "pxo"=2E
>-
>-- clock-output-names:
>-	Usage: required
>-	Value type: <string>
>-	Definition: Name of the output clock=2E Typically acpu_l2_aux indicatin=
g
>-		    an L2 cache auxiliary clock=2E
>-
>-Example:
>-
>-	l2cc: clock-controller@2011000 {
>-		compatible =3D "qcom,kpss-gcc-ipq8064", "qcom,kpss-gcc";
>-		reg =3D <0x2011000 0x1000>;
>-		clocks =3D <&gcc PLL8_VOTE>, <&gcc PXO_SRC>;
>-		clock-names =3D "pll8_vote", "pxo";
>-		clock-output-names =3D "acpu_l2_aux";
>-	};
>diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc=2Eya=
ml b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc=2Eyaml
>new file mode 100644
>index 000000000000=2E=2E27f7df7e3ec4
>--- /dev/null
>+++ b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc=2Eyaml
>@@ -0,0 +1,90 @@
>+# SPDX-License-Identifier: GPL-2=2E0-only OR BSD-2-Clause
>+%YAML 1=2E2
>+---
>+$id: http://devicetree=2Eorg/schemas/arm/msm/qcom,kpss-gcc=2Eyaml#
>+$schema: http://devicetree=2Eorg/meta-schemas/core=2Eyaml#
>+
>+title: Krait Processor Sub-system (KPSS) Global Clock Controller (GCC)
>+
>+maintainers:
>+  - Christian Marangi <ansuelsmth@gmail=2Ecom>
>+
>+description: |
>+  Krait Processor Sub-system (KPSS) Global Clock Controller (GCC)=2E Use=
d
>+  to control L2 mux (in the current implementation) and provide access
>+  to the kpss-gcc registers=2E
>+
>+properties:
>+  compatible:
>+    items:
>+      - enum:
>+          - qcom,kpss-gcc-ipq8064
>+          - qcom,kpss-gcc-apq8064
>+          - qcom,kpss-gcc-msm8974
>+          - qcom,kpss-gcc-msm8960
>+          - qcom,kpss-gcc-msm8660
>+          - qcom,kpss-gcc-mdm9615
>+      - const: qcom,kpss-gcc
>+      - const: syscon
>+
>+  reg:
>+    maxItems: 1
>+
>+  clocks:
>+    items:
>+      - description: phandle to pll8_vote
>+      - description: phandle to pxo_board
>+
>+  clock-names:
>+    items:
>+      - const: pll8_vote
>+      - const: pxo
>+
>+  '#clock-cells':
>+    const: 0
>+
>+required:
>+  - compatible
>+  - reg
>+
>+if:
>+  properties:
>+    compatible:
>+      contains:
>+        enum:
>+          - qcom,kpss-gcc-ipq8064
>+          - qcom,kpss-gcc-apq8064
>+          - qcom,kpss-gcc-msm8974
>+          - qcom,kpss-gcc-msm8960
>+then:
>+  required:
>+    - clocks
>+    - clock-names
>+    - '#clock-cells'
>+else:
>+  properties:
>+    clock: false
>+    clock-names: false
>+    '#clock-cells': false

I suppose this chunk is not so correct=2E We can not describe these proper=
ties as required since current DTs do not have them=2E Also if somebody dec=
ides to fix the mdm9615 or msm8660 platforms, he works have to change this =
(again)=2E Thus I'd just leave this whole chunk out=2E

>+
>+additionalProperties: false
>+
>+examples:
>+  - |
>+    #include <dt-bindings/clock/qcom,gcc-ipq806x=2Eh>
>+
>+    clock-controller@2011000 {
>+      compatible =3D "qcom,kpss-gcc-ipq8064", "qcom,kpss-gcc", "syscon";
>+      reg =3D <0x2011000 0x1000>;
>+      clocks =3D <&gcc PLL8_VOTE>, <&pxo_board>;
>+      clock-names =3D "pll8_vote", "pxo";
>+      #clock-cells =3D <0>;
>+    };
>+
>+  - |
>+    clock-controller@2011000 {
>+      compatible =3D "qcom,kpss-gcc-mdm9615", "qcom,kpss-gcc", "syscon";
>+      reg =3D <0x02011000 0x1000>;
>+    };
>+=2E=2E=2E
>+

--=20
With best wishes
Dmitry
