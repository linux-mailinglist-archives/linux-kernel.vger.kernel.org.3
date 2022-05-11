Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2495D523877
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 18:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344591AbiEKQRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 12:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344592AbiEKQQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 12:16:53 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0435F2899C;
        Wed, 11 May 2022 09:16:48 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id c9so2370522plh.2;
        Wed, 11 May 2022 09:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JXNk/wGnkhO9VQdBWaw8cOb3okfyhdJAFrNpF+Zj220=;
        b=qT6/+aArDex9TwZvim8fIl+e29xlaIC/Su3Dyl7y1c60aVGspiCsjYBsn/u7fqkNRL
         gvM4a3VMv4Q0g6d6fExO7WKnE/DaXnIqurC+x3StoYRhlzZIim/rlRtav3x0SWbKcDhP
         xhLJXLiEh/RX9Xt9DT8ZDuHZ5wsGnDAGFax2iIWKDH3rPb1890bvXtTCKjmSnuM5scBA
         soIN6nBzxkCSgFMZt5kvNmQX1HtcU9HDdBoDPFhk7Mc+hRURLKBQqfkDRPZa/WZZszeq
         zo1ea+Q6B8rvPebNsYQgEeQh4fjOpYUk4tsUkj2lZR3qm99cXs+981VS45PyRIH0i9Jp
         fpQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JXNk/wGnkhO9VQdBWaw8cOb3okfyhdJAFrNpF+Zj220=;
        b=HMZkKitBa2agl8wsyXWX0D89aBjPyhkU+KT6my+AFYHOWwmO9kAPyOJgON+PRtftB9
         GAeetndsKephrdH5J2Nl/m815TLEArA8rsDOGUUez0IMKB4jeL0xT0skfv14l5TpOHPh
         KX7HOnhdhojrrCk65fhT8+vZqZDlZGEd1dL/QAEyEtbSGt7v4huEcEV7E89+x8M/tvDT
         3/iodko2FRlgTcRpQR00/8l+JY9J6Rv97Rz31Kp6VhHQKDPGquYZWJrqYMKJueuWZAsJ
         mgDxSACJccX1Age8zBS0z1Ehiva3p/NMUSfT/fWjW9Qqr5BCB+iJ4htLOEiNy2qEb/CG
         Zeyw==
X-Gm-Message-State: AOAM531ifC4h0epc8VgCLHvyeEIXENtQRDK4yPn0n0UeEyFU0sQkkmln
        VojivaDYf3b6cGBxhTOFpYTCA6usP/N6PQl4
X-Google-Smtp-Source: ABdhPJwhFGsG/qtfM4JVViSKoMGZ6MG37oGtmEFe18+pstGspH7dcLRoiBz7LFe8g3YjvXSp3vRX/g==
X-Received: by 2002:a17:903:120a:b0:15f:99f:95bc with SMTP id l10-20020a170903120a00b0015f099f95bcmr16874453plh.48.1652285807972;
        Wed, 11 May 2022 09:16:47 -0700 (PDT)
Received: from skynet-linux.local ([49.204.239.218])
        by smtp.googlemail.com with ESMTPSA id x7-20020a17090a1f8700b001ded49491basm220322pja.2.2022.05.11.09.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 09:16:47 -0700 (PDT)
From:   Sireesh Kodali <sireeshkodali1@gmail.com>
To:     linux-remoteproc@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sireesh Kodali <sireeshkodali1@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH 6/9] dt-bindings: remoteproc: qcom: mss: Convert bindings to YAML
Date:   Wed, 11 May 2022 21:45:59 +0530
Message-Id: <20220511161602.117772-7-sireeshkodali1@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220511161602.117772-1-sireeshkodali1@gmail.com>
References: <20220511161602.117772-1-sireeshkodali1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the bindings to YAML from txt. The bindings follow a similar
schema to `qcom,adsp.yaml`.

Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
---
 .../bindings/remoteproc/qcom,q6v5.txt         | 302 --------
 .../bindings/remoteproc/qcom,q6v5.yaml        | 702 ++++++++++++++++++
 2 files changed, 702 insertions(+), 302 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,q6v5.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
deleted file mode 100644
index 8f1507052afd..000000000000
--- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
+++ /dev/null
@@ -1,302 +0,0 @@
-Qualcomm Hexagon Peripheral Image Loader
-
-This document defines the binding for a component that loads and boots firmware
-on the Qualcomm Hexagon core.
-
-- compatible:
-	Usage: required
-	Value type: <string>
-	Definition: must be one of:
-		    "qcom,q6v5-pil",
-		    "qcom,ipq8074-wcss-pil"
-		    "qcom,qcs404-wcss-pil"
-		    "qcom,msm8916-mss-pil",
-		    "qcom,msm8974-mss-pil"
-		    "qcom,msm8996-mss-pil"
-		    "qcom,msm8998-mss-pil"
-		    "qcom,sc7180-mss-pil"
-		    "qcom,sc7280-mss-pil"
-		    "qcom,sdm845-mss-pil"
-
-- reg:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: must specify the base address and size of the qdsp6 and
-		    rmb register blocks
-
-- reg-names:
-	Usage: required
-	Value type: <stringlist>
-	Definition: must be "q6dsp" and "rmb"
-
-- interrupts-extended:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: reference to the interrupts that match interrupt-names
-
-- interrupt-names:
-	Usage: required
-	Value type: <stringlist>
-	Definition: The interrupts needed depends on the the compatible
-		    string:
-	qcom,q6v5-pil:
-	qcom,ipq8074-wcss-pil:
-	qcom,qcs404-wcss-pil:
-	qcom,msm8916-mss-pil:
-	qcom,msm8974-mss-pil:
-		    must be "wdog", "fatal", "ready", "handover", "stop-ack"
-	qcom,msm8996-mss-pil:
-	qcom,msm8998-mss-pil:
-	qcom,sc7180-mss-pil:
-	qcom,sc7280-mss-pil:
-	qcom,sdm845-mss-pil:
-		    must be "wdog", "fatal", "ready", "handover", "stop-ack",
-		    "shutdown-ack"
-
-- firmware-name:
-	Usage: optional
-	Value type: <stringlist>
-	Definition: must list the relative firmware image paths for mba and
-		    modem. They are used for booting and authenticating the
-		    Hexagon core.
-
-- clocks:
-	Usage: required
-	Value type: <phandle>
-	Definition: reference to the clocks that match clock-names
-
-- clock-names:
-	Usage: required
-	Value type: <stringlist>
-	Definition: The clocks needed depend on the compatible string:
-	qcom,ipq8074-wcss-pil:
-		    no clock names required
-	qcom,qcs404-wcss-pil:
-		    must be "xo", "gcc_abhs_cbcr", "gcc_abhs_cbcr",
-		    "gcc_axim_cbcr", "lcc_ahbfabric_cbc", "tcsr_lcc_cbc",
-		    "lcc_abhs_cbc", "lcc_tcm_slave_cbc", "lcc_abhm_cbc",
-		    "lcc_axim_cbc", "lcc_bcr_sleep"
-	qcom,q6v5-pil:
-	qcom,msm8916-mss-pil:
-	qcom,msm8974-mss-pil:
-		    must be "iface", "bus", "mem", "xo"
-	qcom,msm8996-mss-pil:
-		    must be "iface", "bus", "mem", "xo", "gpll0_mss",
-		    "snoc_axi", "mnoc_axi", "pnoc", "qdss"
-	qcom,msm8998-mss-pil:
-		    must be "iface", "bus", "mem", "xo", "gpll0_mss",
-		    "snoc_axi", "mnoc_axi", "qdss"
-	qcom,sc7180-mss-pil:
-		    must be "iface", "bus", "xo", "snoc_axi", "mnoc_axi",
-		    "nav"
-	qcom,sc7280-mss-pil:
-		    must be "iface", "xo", "snoc_axi", "offline", "pka"
-	qcom,sdm845-mss-pil:
-		    must be "iface", "bus", "mem", "xo", "gpll0_mss",
-		    "snoc_axi", "mnoc_axi", "prng"
-
-- resets:
-	Usage: required
-	Value type: <phandle>
-	Definition: reference to the reset-controller for the modem sub-system
-		    reference to the list of 3 reset-controllers for the
-		    wcss sub-system
-		    reference to the list of 2 reset-controllers for the modem
-		    sub-system on SC7180, SC7280, SDM845 SoCs
-
-- reset-names:
-	Usage: required
-	Value type: <stringlist>
-	Definition: must be "mss_restart" for the modem sub-system
-		    must be "wcss_aon_reset", "wcss_reset", "wcss_q6_reset"
-		    for the wcss sub-system
-		    must be "mss_restart", "pdc_reset" for the modem
-		    sub-system on SC7180, SC7280, SDM845 SoCs
-
-For devices where the mba and mpss sub-nodes are not specified, mba/mpss region
-should be referenced as follows:
-- memory-region:
-	Usage: required
-	Value type: <phandle>
-	Definition: reference to the reserved-memory for the mba region followed
-		    by the mpss region
-
-For the compatible strings below the following supplies are required:
-  "qcom,q6v5-pil"
-  "qcom,msm8916-mss-pil",
-- cx-supply: (deprecated, use power domain instead)
-- mx-supply: (deprecated, use power domain instead)
-- pll-supply:
-	Usage: required
-	Value type: <phandle>
-	Definition: reference to the regulators to be held on behalf of the
-		    booting of the Hexagon core
-
-For the compatible string below the following supplies are required:
-  "qcom,msm8974-mss-pil"
-- cx-supply: (deprecated, use power domain instead)
-- mss-supply:
-- mx-supply: (deprecated, use power domain instead)
-- pll-supply:
-	Usage: required
-	Value type: <phandle>
-	Definition: reference to the regulators to be held on behalf of the
-		    booting of the Hexagon core
-
-For the compatible string below the following supplies are required:
-  "qcom,qcs404-wcss-pil"
-- cx-supply:
-	Usage: required
-	Value type: <phandle>
-	Definition: reference to the regulators to be held on behalf of the
-		    booting of the Hexagon core
-
-For the compatible string below the following supplies are required:
-  "qcom,msm8996-mss-pil"
-- pll-supply:
-	Usage: required
-	Value type: <phandle>
-	Definition: reference to the regulators to be held on behalf of the
-		    booting of the Hexagon core
-
-- power-domains:
-	Usage: required
-	Value type: <phandle>
-	Definition: reference to power-domains that match power-domain-names
-
-- power-domain-names:
-	Usage: required
-	Value type: <stringlist>
-	Definition: The power-domains needed depend on the compatible string:
-	qcom,ipq8074-wcss-pil:
-		    no power-domain names required
-	qcom,q6v5-pil:
-	qcom,msm8916-mss-pil:
-	qcom,msm8974-mss-pil:
-	qcom,msm8996-mss-pil:
-	qcom,msm8998-mss-pil:
-		    must be "cx", "mx"
-	qcom,sc7180-mss-pil:
-		    must be "cx", "mx", "mss"
-	qcom,sc7280-mss-pil:
-		    must be "cx", "mss"
-	qcom,sdm845-mss-pil:
-		    must be "cx", "mx", "mss"
-
-- qcom,qmp:
-	Usage: optional
-	Value type: <phandle>
-	Definition: reference to the AOSS side-channel message RAM.
-
-- qcom,smem-states:
-	Usage: required
-	Value type: <phandle>
-	Definition: reference to the smem state for requesting the Hexagon to
-		    shut down
-
-- qcom,smem-state-names:
-	Usage: required
-	Value type: <stringlist>
-	Definition: must be "stop"
-
-- qcom,halt-regs:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: a phandle reference to a syscon representing TCSR followed
-		    by the three offsets within syscon for q6, modem and nc
-		    halt registers.
-		    a phandle reference to a syscon representing TCSR followed
-		    by the four offsets within syscon for q6, modem, nc and vq6
-		    halt registers on SC7280 SoCs.
-
-For the compatible strings below the following phandle references are required:
-  "qcom,sc7180-mss-pil"
-- qcom,spare-regs:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: a phandle reference to a syscon representing TCSR followed
-		    by the offset within syscon for conn_box_spare0 register
-		    used by the modem sub-system running on SC7180 SoC.
-
-For the compatible strings below the following phandle references are required:
-  "qcom,sc7280-mss-pil"
-- qcom,ext-regs:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: two phandle references to syscons representing TCSR_REG and
-		    TCSR register space followed by the two offsets within the syscon
-		    to force_clk_en/rscc_disable and axim1_clk_off/crypto_clk_off
-		    registers respectively.
-
-- qcom,qaccept-regs:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: a phandle reference to a syscon representing TCSR followed
-		    by the three offsets within syscon for mdm, cx and axi
-		    qaccept registers used by the modem sub-system running on
-		    SC7280 SoC.
-
-The Hexagon node must contain iommus property as described in ../iommu/iommu.txt
-on platforms which do not have TrustZone.
-
-= SUBNODES:
-The Hexagon node must contain two subnodes, named "mba" and "mpss" representing
-the memory regions used by the Hexagon firmware. Each sub-node must contain:
-
-- memory-region:
-	Usage: required
-	Value type: <phandle>
-	Definition: reference to the reserved-memory for the region
-
-The Hexagon node may also have an subnode named either "smd-edge" or
-"glink-edge" that describes the communication edge, channels and devices
-related to the Hexagon.  See ../soc/qcom/qcom,smd.txt and
-../soc/qcom/qcom,glink.txt for details on how to describe these.
-
-= EXAMPLE
-The following example describes the resources needed to boot control the
-Hexagon, as it is found on MSM8974 boards.
-
-	modem-rproc@fc880000 {
-		compatible = "qcom,q6v5-pil";
-		reg = <0xfc880000 0x100>,
-		      <0xfc820000 0x020>;
-		reg-names = "qdsp6", "rmb";
-
-		interrupts-extended = <&intc 0 24 1>,
-				      <&modem_smp2p_in 0 0>,
-				      <&modem_smp2p_in 1 0>,
-				      <&modem_smp2p_in 2 0>,
-				      <&modem_smp2p_in 3 0>;
-		interrupt-names = "wdog",
-				  "fatal",
-				  "ready",
-				  "handover",
-				  "stop-ack";
-
-		clocks = <&gcc GCC_MSS_Q6_BIMC_AXI_CLK>,
-			 <&gcc GCC_MSS_CFG_AHB_CLK>,
-			 <&gcc GCC_BOOT_ROM_AHB_CLK>;
-		clock-names = "iface", "bus", "mem";
-
-		qcom,halt-regs = <&tcsr_mutex_block 0x1180 0x1200 0x1280>;
-
-		resets = <&gcc GCC_MSS_RESTART>;
-		reset-names = "mss_restart";
-
-		cx-supply = <&pm8841_s2>;
-		mss-supply = <&pm8841_s3>;
-		mx-supply = <&pm8841_s1>;
-		pll-supply = <&pm8941_l12>;
-
-		qcom,smem-states = <&modem_smp2p_out 0>;
-		qcom,smem-state-names = "stop";
-
-		mba {
-			memory-region = <&mba_region>;
-		};
-
-		mpss {
-			memory-region = <&mpss_region>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.yaml
new file mode 100644
index 000000000000..1c67c6cbf417
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.yaml
@@ -0,0 +1,702 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/qcom,q6v5.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Hexagon Peripheral Image Loader
+
+maintainers:
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+
+description:
+  This document defines the binding for a component that loads and boots firmware
+  on the Qualcomm Hexagon core.
+
+properties:
+  compatible:
+    # Special case, because older platforms like MSM8916 use both compatibles together
+    minItems: 1
+    maxItems: 2
+    oneOf:
+      - items:
+          - enum:
+              - qcom,msm8916-mss-pil
+          - enum:
+              - qcom,q6v5-pil
+      - items:
+          - enum:
+              - qcom,q6v5-pil
+              - qcom,ipq8074-wcss-pil
+              - qcom,qcs404-wcss-pil
+              - qcom,msm8916-mss-pil
+              - qcom,msm8974-mss-pil
+              - qcom,msm8996-mss-pil
+              - qcom,msm8998-mss-pil
+              - qcom,sc7180-mss-pil
+              - qcom,sc7280-mss-pil
+              - qcom,sdm845-mss-pil
+
+  reg:
+    description: must specify the base address and size of the qdsp6 and rmb
+      register blocks
+    maxItems: 2
+
+  reg-names:
+    items:
+      - const: qdsp6
+      - const: rmb
+
+  interrupts-extended:
+    minItems: 5
+    maxItems: 6
+
+  interrupt-names:
+    minItems: 5
+    maxItems: 6
+
+  firmware-name:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    description: List the relative firmware image paths for the mba and
+      modem. They are used for booting and authenticating the Hexagon core.
+    maxItems: 2
+
+  clocks:
+    minItems: 4
+    maxItems: 10
+
+  clock-names:
+    minItems: 4
+    maxItems: 10
+
+  resets:
+    description: Reference to the reset-controllwer for the modem subsystem
+    minItems: 1
+    maxItems: 3
+
+  reset-names:
+    minItems: 1
+    maxItems: 3
+
+  memory-region:
+    maxItems: 1
+    description: Reference to the reserved-memory for the mba region followed
+      by the mpss region. Required if the mba and mpss sub-nodes are not
+      specified.
+
+  cx-supply:
+    description: Phandle to the CX regulator
+
+  mx-supply:
+    description: Phandle to the MX regulator
+
+  pll-supply:
+    description: Phandle to the PLL regulator, to be held on behalf of the
+      booting Hexagon core
+
+  mss-supply:
+    description: Phandle to the mss regulator, to be held on behalf of the
+      booting Hexagon core
+
+  power-domains:
+    minItems: 1
+    maxItems: 4
+
+  power-domain-names:
+    minItems: 1
+    maxItems: 4
+
+  qcom,qmp:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Reference to the AOSS side-channel message RAM.
+
+  qcom,smem-states:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: States used by the AP to signal the Hexagon core
+    items:
+      - description: Stop the modem
+
+  qcom,smem-state-names:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    description: The names of the state bits used for SMP2P output
+    items:
+      - const: stop
+
+  qcom,halt-regs:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      Phandle reference to a syscon representing TCSR followed by the
+      three offsets within syscon for q6, modem and nc halt registers.
+
+  qcom,spare-regs:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      A phandle reference to a syscon representing TCSR followed by the
+      offset within syscon for conn_box_spare0 register used by the modem
+      sub-system running on SC7180 SoC.
+
+  qcom,ext-regs:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      Two phandle references to syscons representing TCSR_REG and TCSR
+      register space followed by the two offsets within the syscon to
+      force_clk_en/rscc_disable and axim1_clk_off/crypto_clk_off registers
+      respectively.
+
+  qcom,qaccept-regs:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      A phandle reference to a syscon representing TCSR followed by the three
+      offsets within syscon for mdm, cx and axi qaccept registers used by the
+      modem sub-system running on SC7280 SoC.
+
+  iommus:
+    description:
+      Only required on platforms that do not have TrustZone.
+
+  smd-edge:
+    type: object
+    description:
+      Qualcomm Shared Memory subnode which represents communication edge,
+      channels and devices related to the ADSP.
+
+  glink-edge:
+    type: object
+    description:
+      Qualcomm G-Link subnode which represents communication edge, channels
+      and devices related to the ADSP.
+
+  mba:
+    type: object
+    properties:
+      memory-region:
+        maxItems: 1
+
+    required:
+      - memory-region
+
+  mpss:
+    type: object
+    properties:
+      memory-region:
+        maxItems: 1
+
+    required:
+      - memory-region
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - interrupts-extended
+  - interrupt-names
+  - qcom,smem-states
+  - qcom,smem-state-names
+
+additionalProperties: false
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,ipq8074-wcss-pil
+    then:
+      properties:
+        clocks: false
+        clock-names: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,qcs404-wcss-pil
+    then:
+      properties:
+        clocks:
+          items:
+            - description: GCC_AHBS_CBCR clock
+            - description: GCC_AXIM_CBCR clock
+            - description: LCC_AHBFABRIC_CBC clock
+            - description: TCSR_LCC_CBC clock
+            - description: LCC_AHBS_CBC clock
+            - description: LCC_TCM_SLAVE_CBC clock
+            - description: LCC_ABHM_CBC clock
+            - description: LCC_AXIM_CBC clock
+            - description: LCC_BCR_SLEEP clock
+            - description: XO clock
+        clock-names:
+          items:
+            - const: gcc_ahbs_cbcr
+            - const: gcc_axim_cbcr
+            - const: lcc_ahbfabric_cbc
+            - const: tcsr_lcc_cbc
+            - const: lcc_abhs_cbc
+            - const: lcc_tcm_slave_cbc
+            - const: lcc_abhm_cbc
+            - const: lcc_axim_cbc
+            - const: lcc_bcr_sleep
+            - const: xo
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,q6v5-pil
+              - qcom,msm8916-mss-pil
+              - qcom,msm8974-mss-pil
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Interface clock
+            - description: Bus clock
+            - description: Memory clock
+            - description: XO clock
+        clock-names:
+          items:
+            - const: iface
+            - const: bus
+            - const: mem
+            - const: xo
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,msm8996-mss-pil
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Interface clock
+            - description: Bus clock
+            - description: Memory clock
+            - description: GPLL0_MSS clock
+            - description: SNOC_AXI clock
+            - description: MNOC_AXI clock
+            - description: PNOC clock
+            - description: QDSS clock
+            - description: XO clock
+        clock-names:
+          items:
+            - const: iface
+            - const: bus
+            - const: mem
+            - const: gpll0_mss
+            - const: snoc_axi
+            - const: mnoc_axi
+            - const: pnoc
+            - const: qdss
+            - const: xo
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,msm8998-mss-pil
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Interface clock
+            - description: Bus clock
+            - description: Memory clock
+            - description: GPLL0_MSS clock
+            - description: SNOC_AXI clock
+            - description: MNOC_AXI clock
+            - description: QDSS clock
+            - description: XO clock
+        clock-names:
+          items:
+            - const: iface
+            - const: bus
+            - const: mem
+            - const: gpll0_mss
+            - const: snoc_axi
+            - const: mnoc_axi
+            - const: qdss
+            - const: xo
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sc7180-mss-pil
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Interface clock
+            - description: Bus clock
+            - description: NAV clock
+            - description: SNOC_AXI clock
+            - description: MNOC_AXI clock
+            - description: XO clock
+        clock-names:
+          items:
+            - const: iface
+            - const: bus
+            - const: nav
+            - const: snoc_axi
+            - const: mnoc_axi
+            - const: xo
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sc7280-mss-pil
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Interface clock
+            - description: Offline clock
+            - description: SNOC_AXI clock
+            - description: PKA clock
+            - description: XO clock
+        clock-names:
+          items:
+            - const: iface
+            - const: offline
+            - const: snoc_axi
+            - const: pka
+            - const: xo
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sdm845-mss-pil
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Interface clock
+            - description: Bus clock
+            - description: Memory clock
+            - description: GPLL0_MSS clock
+            - description: SNOC_AXI clock
+            - description: MNOC_AXI clock
+            - description: PRNG clock
+            - description: XO clock
+        clock-names:
+          items:
+            - const: iface
+            - const: bus
+            - const: mem
+            - const: gpll0_mss
+            - const: snoc_axi
+            - const: mnoc_axi
+            - const: prng
+            - const: xo
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,q6v5-pil
+              - qcom,ipq8074-wcss-pil
+              - qcom,qcs404-wcss-pil
+              - qcom,msm8916-mss-pil
+              - qcom,msm8974-mss-pil
+    then:
+      properties:
+        interrupts-extended:
+          items:
+            - description: Watchdog interrupt
+            - description: Fatal interrupt
+            - description: Ready interrupt
+            - description: Handover interrupt
+            - description: Stop acknowledge interrupt
+        interrupt-names:
+          items:
+            - const: wdog
+            - const: fatal
+            - const: ready
+            - const: handover
+            - const: stop-ack
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,msm8996-mss-pil
+              - qcom,msm8998-mss-pil
+              - qcom,sc7180-mss-pil
+              - qcom,sc7280-mss-pil
+              - qcom,sdm845-mss-pil
+    then:
+      properties:
+        interrupts-extended:
+          items:
+            - description: Watchdog interrupt
+            - description: Fatal interrupt
+            - description: Ready interrupt
+            - description: Handover interrupt
+            - description: Stop acknowledge interrupt
+            - description: Shutdown acknowledge interrupt
+        interrupt-names:
+          items:
+            - const: wdog
+            - const: fatal
+            - const: ready
+            - const: handover
+            - const: stop-ack
+            - const: shutdown-ack
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - const: qcom,q6v5-pil
+            - const: qcom,msm8916-mss-pil
+            - const: qcom,msm8974-mss-pil
+    then:
+      properties:
+        cx-supply:
+          deprecated: true
+        mx-supply:
+          deprecated: true
+
+      required:
+        - pll-supply
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,msm8916-mss-pil
+            - qcom,msm8974-mss-pil
+            - qcom,msm8996-mss-pil
+            - qcom,msm8998-mss-pil
+    then:
+      properties:
+        power-domains:
+          items:
+            - description: CX power domain
+            - description: MX power domain
+        power-domain-names:
+          items:
+            - const: cx
+            - const: mx
+
+      required:
+        - power-domains
+        - power-domain-names
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - const: qcom,msm8996-mss-pil
+    then:
+      properties:
+        cx-supply: false
+        mx-supply: false
+
+      required:
+        - pll-supply
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - const: qcom,qcs404-wcss-pil
+    then:
+      required:
+        - cx-supply
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sdm845-mss-pil
+              - qcom,sc7180-mss-pil
+    then:
+      properties:
+        power-domains:
+          items:
+            - description: CX power domain
+            - description: MX power domain
+            - description: MSS power domain
+        power-domain-names:
+          items:
+            - const: cx
+            - const: mx
+            - const: mss
+
+      required:
+        - power-domains
+        - power-domain-names
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sc7280-mss-pil
+    then:
+      properties:
+        power-domains:
+          items:
+            - description: CX power domain
+            - description: MSS power domain
+        power-domain-names:
+          items:
+            - const: cx
+            - const: mss
+
+      required:
+        - power-domains
+        - power-domain-names
+        - qcom,ext-regs
+        - qcom,qaccept-regs
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,q6v5-pil
+              - qcom,msm8916-mss-pil
+              - qcom,msm8974-mss-pil
+              - qcom,msm8996-mss-pil
+              - qcom,msm8998-mss-pil
+    then:
+      properties:
+        resets:
+          items:
+            - description: MSS reset
+        reset-names:
+          items:
+            - const: mss_restart
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,ipq8074-wcss-pil
+              - qcom,qcs404-wcss-pil
+    then:
+      properties:
+        resets:
+          items:
+            - description: WCSS Always On restart
+            - description: WCSS reset
+            - description: WCSS Q6 reset
+        reset-names:
+          items:
+            - const: wcss_aon_restart
+            - const: wcss_reset
+            - const: wcss_q6_reset
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sc7180-mss-pil
+              - qcom,sc7280-mss-pil
+              - qcom,sdm845-mss-pil
+    then:
+      properties:
+        resets:
+          items:
+            - description: MSS restart
+            - description: PDC reset
+        reset-names:
+          items:
+            - const: mss_restart
+            - const: pdc_reset
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,q6v5-pil
+              - qcom,ipq8074-wcss-pil
+              - qcom,qcs404-wcss-pil
+              - qcom,msm8916-mss-pil
+              - qcom,msm8974-mss-pil
+              - qcom,msm8996-mss-pil
+              - qcom,msm8998-mss-pil
+    then:
+      properties:
+        qcom,qmp: false
+        iommus: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmcc.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/qcom,gcc-msm8974.h>
+    #include <dt-bindings/reset/qcom,gcc-msm8974.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    modem-rproc@fc880000 {
+        compatible = "qcom,q6v5-pil";
+        reg = <0xfc880000 0x100>,
+              <0xfc820000 0x020>;
+        reg-names = "qdsp6", "rmb";
+
+        interrupts-extended = <&intc GIC_SPI 24 IRQ_TYPE_EDGE_RISING>,
+                              <&modem_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+                              <&modem_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+                              <&modem_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+                              <&modem_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "wdog",
+                          "fatal",
+                          "ready",
+                          "handover",
+                          "stop-ack";
+
+        clocks = <&gcc GCC_MSS_Q6_BIMC_AXI_CLK>,
+                 <&gcc GCC_MSS_CFG_AHB_CLK>,
+                 <&gcc GCC_BOOT_ROM_AHB_CLK>,
+                 <&xo_board>;
+        clock-names = "iface", "bus", "mem", "xo";
+
+        qcom,halt-regs = <&tcsr_mutex_block 0x1180 0x1200 0x1280>;
+
+        resets = <&gcc GCC_MSS_RESTART>;
+        reset-names = "mss_restart";
+
+        cx-supply = <&pm8841_s2>;
+        mss-supply = <&pm8841_s3>;
+        mx-supply = <&pm8841_s1>;
+        pll-supply = <&pm8941_l12>;
+
+        qcom,smem-states = <&modem_smp2p_out 0>;
+        qcom,smem-state-names = "stop";
+
+        mba {
+                memory-region = <&mba_region>;
+        };
+
+        mpss {
+                memory-region = <&mpss_region>;
+        };
+
+        smd-edge {
+                interrupts = <GIC_SPI 25 IRQ_TYPE_EDGE_RISING>;
+
+                qcom,ipc = <&apcs 8 12>;
+                qcom,smd-edge = <0>;
+
+                label = "modem";
+        };
+    };
-- 
2.36.0

