Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A805618FC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 13:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbiF3LUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 07:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234683AbiF3LUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 07:20:13 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D574D4ED;
        Thu, 30 Jun 2022 04:20:11 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id ay16so38361867ejb.6;
        Thu, 30 Jun 2022 04:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=s8MO9mMa1bq2hJggtQa7J+wxVNTG6bz7mxC4q8MXXFI=;
        b=ozapMMM+OpcCkvZB2MwOtC0ncVnDKR0WF4UiDQdsmDHZGD4DTFwmSyMjseFxfBIlYB
         /stb3g3PgJFHBE+1TrUOpO9MB6pwGfLDWc89XE6YJePjyLaHsLzfNZk7NxyXpo+UjN/V
         Ap/wGWW3RwutxyrDNmK0snOLVDGnn6Poh0ENdgxVWHviPRkKyTIJcLoW/LlF/RcM7XLw
         TWXbGqtdWF5+Y1jzpbUuzTxhfCkUVQCoCW6VV+PjGGEn0oKNDE+dPNuw4XyOgGsnuwmj
         OAezAOhkZfCm8WGG3hg/6S4YmoQ/5vNUx5aEssEJ8mOF0ARWda08fiFSYzcH8As8PFv1
         OHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=s8MO9mMa1bq2hJggtQa7J+wxVNTG6bz7mxC4q8MXXFI=;
        b=s+INmmq2/h1Z6GG5GVKq//zVOuPwKS8qiDsBhJObEF6oWv1aVOl5xf3xbZn8DF9ow+
         zDXC6K8/Jr/ExcrdNoiFDvTeIf+X6zth3EC1qoAHwxfsLoes6l3O1+2NGQPgJGVk80a4
         tC4bFw2XPmoHQkuhi+tqaIG4/dbfIbSCiohvB9UdVTXuR04QQW2SoXLW+B8vsu9nzJAs
         Zrp0fy0QQENz4Of89YpD4Tu30SEZOAli1LqL0vv0WfKOsk+XDnsUMBO1iT8H245kdQrJ
         USRsrubOfnwKrzB7lEzjH+zgPXEyitj/Y/HRjpurNpZ+M/ccUy3ikOgAMDKOgkXTTHXy
         zoPQ==
X-Gm-Message-State: AJIora+LoQTblIjdz//EVp6Or4g9Q1NHUw36SD1ixm2010kwwjICAZFV
        qTteHdEQmX7nScw5f3taPUU=
X-Google-Smtp-Source: AGRyM1vfpQq6ZOVJ0VDwuAbaEwiREFT06sNqfr7RErBzIzhM45kbRbqxz071SdAVbUmH6oK7r82Aog==
X-Received: by 2002:a17:907:2d9f:b0:726:8e98:63f9 with SMTP id gt31-20020a1709072d9f00b007268e9863f9mr8584152ejc.28.1656588009884;
        Thu, 30 Jun 2022 04:20:09 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id s3-20020a1709067b8300b0070efa110afcsm8919142ejo.83.2022.06.30.04.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 04:20:09 -0700 (PDT)
Message-ID: <62bd86e9.1c69fb81.0796.06ac@mx.google.com>
X-Google-Original-Message-ID: <Yr2G51HPmXz+RDHm@Ansuel-xps.>
Date:   Thu, 30 Jun 2022 13:20:07 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 3/5] dt-bindings: arm: msm: Rework kpss-gcc driver
 Documentation to yaml
References: <20220629121441.6552-1-ansuelsmth@gmail.com>
 <20220629121441.6552-4-ansuelsmth@gmail.com>
 <D90DE67E-DA29-4A0D-BBC1-C8209FDF69D3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D90DE67E-DA29-4A0D-BBC1-C8209FDF69D3@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 09:43:05AM +0300, Dmitry Baryshkov wrote:
> 
> 
> On 29 June 2022 15:14:39 GMT+03:00, Christian Marangi <ansuelsmth@gmail.com> wrote:
> >Rework kpss-gcc driver Documentation to yaml Documentation.
> >The current kpss-gcc Documentation have major problems and can't be
> >converted directly. Introduce various changes to the original
> >Documentation.
> >
> >Add #clock-cells additional binding as this clock outputs a static clk
> >named acpu_l2_aux with supported compatible.
> >Only some compatible require and outputs a clock, for the others, set
> >only the reg as a required binding to correctly export the kpss-gcc
> >registers. As the reg is shared also add the required syscon compatible.
> >
> >Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> >---
> > .../bindings/arm/msm/qcom,kpss-gcc.txt        | 44 ---------
> > .../bindings/arm/msm/qcom,kpss-gcc.yaml       | 90 +++++++++++++++++++
> > 2 files changed, 90 insertions(+), 44 deletions(-)
> > delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
> > create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml
> >
> >diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
> >deleted file mode 100644
> >index e628758950e1..000000000000
> >--- a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
> >+++ /dev/null
> >@@ -1,44 +0,0 @@
> >-Krait Processor Sub-system (KPSS) Global Clock Controller (GCC)
> >-
> >-PROPERTIES
> >-
> >-- compatible:
> >-	Usage: required
> >-	Value type: <string>
> >-	Definition: should be one of the following. The generic compatible
> >-			"qcom,kpss-gcc" should also be included.
> >-			"qcom,kpss-gcc-ipq8064", "qcom,kpss-gcc"
> >-			"qcom,kpss-gcc-apq8064", "qcom,kpss-gcc"
> >-			"qcom,kpss-gcc-msm8974", "qcom,kpss-gcc"
> >-			"qcom,kpss-gcc-msm8960", "qcom,kpss-gcc"
> >-
> >-- reg:
> >-	Usage: required
> >-	Value type: <prop-encoded-array>
> >-	Definition: base address and size of the register region
> >-
> >-- clocks:
> >-	Usage: required
> >-	Value type: <prop-encoded-array>
> >-	Definition: reference to the pll parents.
> >-
> >-- clock-names:
> >-	Usage: required
> >-	Value type: <stringlist>
> >-	Definition: must be "pll8_vote", "pxo".
> >-
> >-- clock-output-names:
> >-	Usage: required
> >-	Value type: <string>
> >-	Definition: Name of the output clock. Typically acpu_l2_aux indicating
> >-		    an L2 cache auxiliary clock.
> >-
> >-Example:
> >-
> >-	l2cc: clock-controller@2011000 {
> >-		compatible = "qcom,kpss-gcc-ipq8064", "qcom,kpss-gcc";
> >-		reg = <0x2011000 0x1000>;
> >-		clocks = <&gcc PLL8_VOTE>, <&gcc PXO_SRC>;
> >-		clock-names = "pll8_vote", "pxo";
> >-		clock-output-names = "acpu_l2_aux";
> >-	};
> >diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml
> >new file mode 100644
> >index 000000000000..27f7df7e3ec4
> >--- /dev/null
> >+++ b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml
> >@@ -0,0 +1,90 @@
> >+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> >+%YAML 1.2
> >+---
> >+$id: http://devicetree.org/schemas/arm/msm/qcom,kpss-gcc.yaml#
> >+$schema: http://devicetree.org/meta-schemas/core.yaml#
> >+
> >+title: Krait Processor Sub-system (KPSS) Global Clock Controller (GCC)
> >+
> >+maintainers:
> >+  - Christian Marangi <ansuelsmth@gmail.com>
> >+
> >+description: |
> >+  Krait Processor Sub-system (KPSS) Global Clock Controller (GCC). Used
> >+  to control L2 mux (in the current implementation) and provide access
> >+  to the kpss-gcc registers.
> >+
> >+properties:
> >+  compatible:
> >+    items:
> >+      - enum:
> >+          - qcom,kpss-gcc-ipq8064
> >+          - qcom,kpss-gcc-apq8064
> >+          - qcom,kpss-gcc-msm8974
> >+          - qcom,kpss-gcc-msm8960
> >+          - qcom,kpss-gcc-msm8660
> >+          - qcom,kpss-gcc-mdm9615
> >+      - const: qcom,kpss-gcc
> >+      - const: syscon
> >+
> >+  reg:
> >+    maxItems: 1
> >+
> >+  clocks:
> >+    items:
> >+      - description: phandle to pll8_vote
> >+      - description: phandle to pxo_board
> >+
> >+  clock-names:
> >+    items:
> >+      - const: pll8_vote
> >+      - const: pxo
> >+
> >+  '#clock-cells':
> >+    const: 0
> >+
> >+required:
> >+  - compatible
> >+  - reg
> >+
> >+if:
> >+  properties:
> >+    compatible:
> >+      contains:
> >+        enum:
> >+          - qcom,kpss-gcc-ipq8064
> >+          - qcom,kpss-gcc-apq8064
> >+          - qcom,kpss-gcc-msm8974
> >+          - qcom,kpss-gcc-msm8960
> >+then:
> >+  required:
> >+    - clocks
> >+    - clock-names
> >+    - '#clock-cells'
> >+else:
> >+  properties:
> >+    clock: false
> >+    clock-names: false
> >+    '#clock-cells': false
> 
> I suppose this chunk is not so correct. We can not describe these properties as required since current DTs do not have them. Also if somebody decides to fix the mdm9615 or msm8660 platforms, he works have to change this (again). Thus I'd just leave this whole chunk out.
>

With a quick check I notice that all the other platform doesn't have
pxo_board or PLL8_VOTE clk so they wouln't work with the current
driver... to me it seems they are just exposing the kpss-gcc reg with
syscon and they are used in the rpm driver... This is very similar to
the acc-v1 and acc-v2 separation where acc-v2 only provide the reg and
nothing else. Wonder if we should do the same here or add clk support
only for the specific compatible as I did here...

In both case dts changes are required and a similar chunk is necessary.

> >+
> >+additionalProperties: false
> >+
> >+examples:
> >+  - |
> >+    #include <dt-bindings/clock/qcom,gcc-ipq806x.h>
> >+
> >+    clock-controller@2011000 {
> >+      compatible = "qcom,kpss-gcc-ipq8064", "qcom,kpss-gcc", "syscon";
> >+      reg = <0x2011000 0x1000>;
> >+      clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
> >+      clock-names = "pll8_vote", "pxo";
> >+      #clock-cells = <0>;
> >+    };
> >+
> >+  - |
> >+    clock-controller@2011000 {
> >+      compatible = "qcom,kpss-gcc-mdm9615", "qcom,kpss-gcc", "syscon";
> >+      reg = <0x02011000 0x1000>;
> >+    };
> >+...
> >+
> 
> -- 
> With best wishes
> Dmitry

-- 
	Ansuel
