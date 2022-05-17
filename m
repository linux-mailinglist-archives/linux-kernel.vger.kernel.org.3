Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE6152A23A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 14:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346718AbiEQM5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 08:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347103AbiEQM5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 08:57:46 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7425C4D9EC
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 05:57:38 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220517125736epoutp029a526d3e3aee81d03cc41d6c415a8572~v5czQ_fav1207912079epoutp02k
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 12:57:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220517125736epoutp029a526d3e3aee81d03cc41d6c415a8572~v5czQ_fav1207912079epoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652792256;
        bh=uHqewmCaROzslLCmX960HpVstV/AWGzxsNtBNYjrViI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vWR27UmLYMM5a5qP0k75U4zYJz1jtyKbL9B9VB6rFB+zlpw/RRXbpgBTQwrdIwn0k
         JIHBzJtWK5qux5HI/GZuRgzG1c+diUkr7Bg/35lw83GdL9ykmgUP2yBb9d1hZT2uVV
         KZbr6FHLq45x1nPkFXyHVRw7yoGRf6HucjDfzc0M=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220517125735epcas5p40e8ecdd36014593b538562dd16454678~v5cyl5-652229322293epcas5p4m;
        Tue, 17 May 2022 12:57:35 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4L2bkN0Hgyz4x9Q0; Tue, 17 May
        2022 12:57:32 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AC.0C.09762.BBB93826; Tue, 17 May 2022 21:57:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220517125554epcas5p4e87a71471525056281f1578f4f80f760~v5bU9b8EW2165121651epcas5p4K;
        Tue, 17 May 2022 12:55:54 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220517125554epsmtrp2d2750be09599dd454f51a4a2bc6e8dd4~v5bU3uLV-0914309143epsmtrp2F;
        Tue, 17 May 2022 12:55:54 +0000 (GMT)
X-AuditID: b6c32a4b-1fdff70000002622-77-62839bbb2e76
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        52.36.08924.A5B93826; Tue, 17 May 2022 21:55:54 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220517125551epsmtip19affd32baed8d8c2e966c2ae3d9c1e34~v5bRvwsVo1799817998epsmtip1K;
        Tue, 17 May 2022 12:55:51 +0000 (GMT)
From:   Smitha T Murthy <smitha.t@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, jernej.skrabec@gmail.com,
        benjamin.gaignard@collabora.com, stanimir.varbanov@linaro.org,
        dillon.minfei@gmail.com, david.plowman@raspberrypi.com,
        mark.rutland@arm.com, robh+dt@kernel.org, krzk+dt@kernel.org,
        andi@etezian.org, alim.akhtar@samsung.com,
        aswani.reddy@samsung.com, pankaj.dubey@samsung.com,
        Smitha T Murthy <smitha.t@samsung.com>, linux-fsd@tesla.com
Subject: [PATCH 02/20] dt-bindings: media: s5p-mfc: Convert s5p-mfc.txt to
 new DT schema
Date:   Tue, 17 May 2022 18:25:30 +0530
Message-Id: <20220517125548.14746-3-smitha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220517125548.14746-1-smitha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTe0xTVxzHPfe2txcSzBVwHNlgzY1swQi0k8eFFd2iM3dhWcAuM2EPKOWO
        Mtrbrg/GZtCisDnURVwm8mhBQDfxVXmUDipg7cDHMmd4ObNSXhuCTjdqUXCTtbuw/ff5/X7f
        3/me8zvn4GjwbSwcz2f1jJaVKUkskGe9HB0d01WzL0e0uP9lasxsxajGx9MI5W708ChHa7uA
        ahusQalv+nv5VJ3zRz7VcWmCR12446verHLxqOm6c4CaqR7FqJbJYT41PruTGuisxaiDlnY+
        ddbpElAnRm4i1MmWvxCqof2hgCq76BRQLrsVUKWfOZFXwugz5jOAtrmaAD3SNIfS31W7BHSj
        fQahW5q/wOhfhu0Y3dq0hy77fpFHf9nWDOine00Cutw5gtGelkj6mtcjSF+dWSBRMLJcRitk
        WLk6N5/NSyXTpFlbsxISReIYcTKVRApZmYpJJbe9kR6zPV/pmwApLJQpDb5UukynI+M2S7Rq
        g54RKtQ6fSrJaHKVmnhNrE6m0hnYvFiW0aeIRaKXEnzC7ALFYp8F0/SJi+pqjgIjsK0vBwE4
        JOLhBYeZVw4C8WCiC8CmCjvGBXMADno8KBd4AOw+NAhWWo6M3EO4QieAB1xLgAtKEXh7wsv3
        qzBiI5x/cB3zcyhRAuDkfr2fUeIJCqsGI/0cQmTCpbuPfXoc5xFR0GTa4k8HEclwarQN48ye
        h6ctvahfEkCkQNPT9/xWkFjC4fUrt1BOsw1OHj3F4zgEzva3CTgOh577F5fXyYNuz77lA2ig
        ydiGcLwF9g7W8vzro0Q0PN8Zx6Uj4NfXziHcjlfDQ0+mluVB0GZeYRI2/HBl2QrCod/b+RzT
        8NuF+uXBHQJw7ufT2GEQWf2/RT0AzWAdo9Gp8hhdgmYTy3z836XJ1aoW8O8j35BmAxNjf8Q6
        AIIDB4A4SoYGiYqMOcFBubJPPmW06iytQcnoHCDBN74KNHytXO37Jaw+SxyfLIpPTEyMT96U
        KCbDgoilkpxgIk+mZwoYRsNoV/oQPCDciHzgdM9KJfxdlc8pyuJSEpjG7TOFpwLfXaU+0F1s
        UnZ4NlvYGxUZQw2irHnjVry1//M6zPV6beHd6IIk3vFuifstJsLacXy2YG6+bkB+Z+9Bb1TG
        +zsfrLO89rDY4Jg6snbY2yf/KuIYI11wfzQ02To63qO6HxdqPfnbJZshUxpQZF+aj7hcEpv7
        4oJXupAkrTJIFOb2d26hC+tP7GHo7L8tpmciyKhfU2/Y1piNf+6e7myu2Phq9k+opWzs2cBO
        ekdX84fIC2+yj4SL6p7Cq96O7sOVNozZXe+y4jveHm8Qh92bE6EDIaWSSqHwEd8+uurqrrMZ
        PVGq4vNu+Rok7RjJ0ylk4g2oVif7BxlU8UhtBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsWy7bCSnG7U7OYkg+5VyhYP5m1js1j84zmT
        xf3Fn1ksDm3eym6x5cpsZovlxw+wWsw/co7VYvvBRywWG18AZS/OvMti8Xz+OkaLl7PusVls
        enyN1eLhq3CLy7vmsFn0bNjKarH2yF12i6XXLzJZLNv0h8li0dYv7Bate4+wW9zds43RoqXt
        CJODuMeaeWsYPXbcXcLocX3JJ2aPnbPusnss3vOSyWPTqk42jzvX9rB5bF5S79F69BeLR9+W
        VYwe/5rmsnt0HbnO5vF5k5zHqa+f2QP4orhsUlJzMstSi/TtErgyfh3bwFZwzLBi/uxpjA2M
        O1S6GDk5JARMJCZdf8MEYgsJ7GCUWPstDyIuIbHy9yRGCFtYYuW/5+xdjFxANU1MErubdjGD
        JNgEdCS+vT/NBpIQEWhllLi+spMJxGEWmMgiMeX6L7AqYYEIiea5W4DaOThYBFQl5s61Bwnz
        ClhKPLm3hQ1ig7zE6g0HmEFKOAWsJOb+iwUxhYBKnu63mMDIt4CRYRWjZGpBcW56brFhgVFe
        arlecWJucWleul5yfu4mRnCkaWntYNyz6oPeIUYmDsZDjBIczEoivAYVDUlCvCmJlVWpRfnx
        RaU5qcWHGKU5WJTEeS90nYwXEkhPLEnNTk0tSC2CyTJxcEo1MFlkXVnFcz/OZtEJ7o2BV2SO
        J0ZPeftGTOTlwoYmbp4qoaMbS6SOvuW9NDsxTcv32K3QK5s4ncpvruReYsk+NWgz56SKA0Jv
        /9+4/a1EtG1BmvsRDoeZBzpc5yTn3zosVrZaapqljvOlaVM/BWgt0ddJOL1gityX5uaYbUYN
        taaCG2o57aYyzp03Q1HudIXLjvZEb7kzZbdPXPGJf//qo8BXH4ara/v/+E6Ib2YoZr5ibSDS
        M62z2fznmXuP8qYttbLLF2st/8Q3ecqXr32bi6t9Cq7duXku8jo/8z2r6K6la9asOrdkTQvP
        5xPZy50SfSc7n/WYZ8B9M7TZpick2q++zVoo6faiQCOxmbGFpUosxRmJhlrMRcWJAHWzGLAj
        AwAA
X-CMS-MailID: 20220517125554epcas5p4e87a71471525056281f1578f4f80f760
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220517125554epcas5p4e87a71471525056281f1578f4f80f760
References: <20220517125548.14746-1-smitha.t@samsung.com>
        <CGME20220517125554epcas5p4e87a71471525056281f1578f4f80f760@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds DT schema for s5p-mfc in yaml format.

Cc: linux-fsd@tesla.com
Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
---
 .../devicetree/bindings/media/s5p-mfc.txt     | 77 +--------------
 .../devicetree/bindings/media/s5p-mfc.yaml    | 98 +++++++++++++++++++
 2 files changed, 99 insertions(+), 76 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/s5p-mfc.yaml

diff --git a/Documentation/devicetree/bindings/media/s5p-mfc.txt b/Documentation/devicetree/bindings/media/s5p-mfc.txt
index aa54c8159d9f..f00241ed407f 100644
--- a/Documentation/devicetree/bindings/media/s5p-mfc.txt
+++ b/Documentation/devicetree/bindings/media/s5p-mfc.txt
@@ -1,76 +1 @@
-* Samsung Multi Format Codec (MFC)
-
-Multi Format Codec (MFC) is the IP present in Samsung SoCs which
-supports high resolution decoding and encoding functionalities.
-The MFC device driver is a v4l2 driver which can encode/decode
-video raw/elementary streams and has support for all popular
-video codecs.
-
-Required properties:
-  - compatible : value should be either one among the following
-	(a) "samsung,mfc-v5" for MFC v5 present in Exynos4 SoCs
-	(b) "samsung,mfc-v6" for MFC v6 present in Exynos5 SoCs
-	(c) "samsung,mfc-v7" for MFC v7 present in Exynos5420 SoC
-	(d) "samsung,mfc-v8" for MFC v8 present in Exynos5800 SoC
-	(e) "samsung,exynos5433-mfc" for MFC v8 present in Exynos5433 SoC
-	(f) "samsung,mfc-v10" for MFC v10 present in Exynos7880 SoC
-
-  - reg : Physical base address of the IP registers and length of memory
-	  mapped region.
-
-  - interrupts : MFC interrupt number to the CPU.
-  - clocks : from common clock binding: handle to mfc clock.
-  - clock-names : from common clock binding: must contain "mfc",
-		  corresponding to entry in the clocks property.
-
-Optional properties:
-  - power-domains : power-domain property defined with a phandle
-			   to respective power domain.
-  - memory-region : from reserved memory binding: phandles to two reserved
-	memory regions, first is for "left" mfc memory bus interfaces,
-	second if for the "right" mfc memory bus, used when no SYSMMU
-	support is available; used only by MFC v5 present in Exynos4 SoCs
-
-Obsolete properties:
-  - samsung,mfc-r, samsung,mfc-l : support removed, please use memory-region
-	property instead
-
-
-Example:
-SoC specific DT entry:
-
-mfc: codec@13400000 {
-	compatible = "samsung,mfc-v5";
-	reg = <0x13400000 0x10000>;
-	interrupts = <0 94 0>;
-	power-domains = <&pd_mfc>;
-	clocks = <&clock 273>;
-	clock-names = "mfc";
-};
-
-Reserved memory specific DT entry for given board (see reserved memory binding
-for more information):
-
-reserved-memory {
-	#address-cells = <1>;
-	#size-cells = <1>;
-	ranges;
-
-	mfc_left: region@51000000 {
-		compatible = "shared-dma-pool";
-		no-map;
-		reg = <0x51000000 0x800000>;
-	};
-
-	mfc_right: region@43000000 {
-		compatible = "shared-dma-pool";
-		no-map;
-		reg = <0x43000000 0x800000>;
-	};
-};
-
-Board specific DT entry:
-
-codec@13400000 {
-	memory-region = <&mfc_left>, <&mfc_right>;
-};
+This file has moved to s5p-mfc.yaml
diff --git a/Documentation/devicetree/bindings/media/s5p-mfc.yaml b/Documentation/devicetree/bindings/media/s5p-mfc.yaml
new file mode 100644
index 000000000000..fff7c7e0d575
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/s5p-mfc.yaml
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/s5p-mfc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Exynos Multi Format Codec (MFC)
+
+maintainers:
+  - Mauro Carvalho Chehab <mchehab@kernel.org>
+  - Rob Herring <robh+dt@kernel.org>
+  - Mark Rutland <mark.rutland@arm.com>
+  - Smitha T Murthy <smitha.t@samsung.com>
+
+properties:
+  compatible:
+    enum:
+      - samsung,mfc-v5                  # Exynos4
+      - samsung,mfc-v6                  # Exynos5
+      - samsung,mfc-v7                  # Exynos5420
+      - samsung,mfc-v8                  # Exynos5800
+      - samsung,exynos5433-mfc          # Exynos5433
+      - samsung,mfc-v10                 # Exynos7880
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    description:
+      Phandle to MFC IP clock.
+    maxItems: 1
+
+  clock-names:
+    description:
+      Must contain clock name (mfc) matching phandle in clocks
+      property.
+    maxItems: 1
+
+  interrupts:
+    description:
+      MFC interrupt number to the CPU.
+    maxItems: 1
+
+  memory-region:
+    description:
+      From reserved memory binding phandles to two reserved
+      memory regions, first is for "left" mfc memory bus interfaces,
+      second if for the "right" mfc memory bus, used when no SYSMMU
+      support is available; used only by MFC v5 present in Exynos4 SoCs.
+    minItems: 1
+    maxItems: 2
+
+  iommus:
+    description:
+      Include the IOMMU domain MFC belong to.
+    maxItems: 2
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+  - iommus
+
+additionalProperties: false
+
+examples:
+  - |
+        /* Reserved memory specific DT entry for given board */
+        reserved-memory {
+                #address-cells = <1>;
+                #size-cells = <1>;
+                ranges;
+
+                mfc_left: region@84000000 {
+                        compatible = "shared-dma-pool";
+                        no-map;
+                        reg = <0x84000000 0x800000>;
+                };
+
+                mfc_right: region@A9000000 {
+                        compatible = "shared-dma-pool";
+                        no-map;
+                        reg = <0xA9000000 0x800000>;
+                };
+        };
+
+        mfc_0: mfc0@12880000 {
+                compatible = "samsung,mfc-v12";
+                reg = <0x12880000 0x10000>;
+                clock-names = "mfc";
+                interrupts = <0 137 4>;
+                clocks = <&clock_mfc 1>;
+                memory-region = <&mfc_left>, <&mfc_right>;
+                /* If IOMMU is present use below instead of memory-region property */
+                iommus = <&smmu_isp 0x1000 0x0>, <&smmu_isp 0x1400 0x0>;
+        };
-- 
2.17.1

