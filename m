Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDC553CCA5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 17:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244968AbiFCPuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 11:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343507AbiFCPt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 11:49:26 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2339651300
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 08:49:18 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220603154916epoutp018448da9e7a3d8a15c8579999d510abc8~1Jwiy_N2_2315023150epoutp013
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 15:49:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220603154916epoutp018448da9e7a3d8a15c8579999d510abc8~1Jwiy_N2_2315023150epoutp013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654271356;
        bh=GKJmr86kB7TxwNHcq4Ru7OONVnHX6Ub75EnaPEqr+Mg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PN2syGKAjWMKofKaYNCvTbjp7W7txNWDzBDi7r70dQh7mivnljIQRJ2qlyde3dQ/8
         YnixLw6OB5WC/xOS6k/YRJ7BRBd20HUTCTNcFlk1M5re9zJEB2Qee9JV8LHVFJwuYm
         iBCbOivlF+Wfp6gZocp/fw5wbWk/cSXJBE9E4dBk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220603154915epcas5p33d3ddd53155455e24e6337b9344923fd~1JwiAj0Fi1875418754epcas5p3x;
        Fri,  3 Jun 2022 15:49:15 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4LF6kd00Wgz4x9Pq; Fri,  3 Jun
        2022 15:49:13 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        98.28.09762.87D2A926; Sat,  4 Jun 2022 00:49:12 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220603154912epcas5p2bf984fb4e32ee1b1357a3cc595e70a67~1JwewVuAp1440614406epcas5p2O;
        Fri,  3 Jun 2022 15:49:12 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220603154912epsmtrp21b756d203773ea29d7606d6b63f310e5~1JwevSMRc0407504075epsmtrp2x;
        Fri,  3 Jun 2022 15:49:12 +0000 (GMT)
X-AuditID: b6c32a4b-1fdff70000002622-a8-629a2d78c9f1
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        7F.27.08924.77D2A926; Sat,  4 Jun 2022 00:49:12 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220603154909epsmtip11e1a185d3c58c95348896101f19f2fb0~1JwcCuNKq2494124941epsmtip1K;
        Fri,  3 Jun 2022 15:49:09 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        avri.altman@wdc.com, bvanassche@acm.org,
        martin.petersen@oracle.com, chanho61.park@samsung.com,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>,
        Bharat Uppal <bharat.uppal@samsung.com>
Subject: [PATCH v2 7/7] arm64: dts: fsd: add ufs device node
Date:   Fri,  3 Jun 2022 21:17:14 +0530
Message-Id: <20220603154714.30532-8-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220603154714.30532-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjk+LIzCtJLcpLzFFi42LZdlhTU7dCd1aSwcEZlhYP5m1js3j58yqb
        xbWXF9gtpn34yWxxeb+2xfwj51gt+l48ZLbY9Pgaq8XlXXPYLCas+sZi0X19B5vF8uP/mCwW
        bf3CbtG69wi7xc47J5gd+D0uX/H22LSqk83jzrU9bB6bl9R7fHx6i8Wjb8sqRo/Pm+Q82g90
        MwVwRGXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gCd
        rqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMCnQK07MLS7NS9fLSy2xMjQwMDIF
        KkzIzni29ypjwQPxip7dF9gaGLcJdzFyckgImEhMntjC3MXIxSEksJtRYseXI0wgCSGBT4wS
        u1bKQCQ+M0pc3bqVEaZjzY/1rBBFuxglVj/lhChqYZJoOfWSDSTBJqAtcXf6FiaQhIhAM6PE
        wY5dYA6zwE4miYu/pzODVAkL2Ei8XPEDbCyLgKrEijP7wHbzAsXP/v7KBrFOXmL1hgNA9Rwc
        nAK2ElNP84HMkRCYyiHRtGwi1EkuEkefLmSHsIUlXh3fAmVLSXx+t5cNpFdCwENi0R8piHCG
        xNvl66Fa7SUOXJnDAlLCLKApsX6XPkiYWYBPovf3EyaITl6JjjYhiGpVieZ3V1kgbGmJid3d
        rBC2h8Sqht/skHCYwChxYtJs9gmMsrMQpi5gZFzFKJlaUJybnlpsWmCcl1oOj6fk/NxNjOAE
        qeW9g/HRgw96hxiZOBgPMUpwMCuJ8JbNm5kkxJuSWFmVWpQfX1Sak1p8iNEUGGITmaVEk/OB
        KTqvJN7QxNLAxMzMzMTS2MxQSZxX4H9jkpBAemJJanZqakFqEUwfEwenVANT25fs888ajsYY
        vvLyMdyRvyK0Z+32/AidjyxOr//dWtwdVeS7LHiavERxqdNZ1/Kp0+7z7RZRbv/ZIX3nZI5I
        mGSOyaT0KxP5Ftr6/A4LzZ82ozDNdum92z8+L3M19ZJlr2UR63q1YcqMqILZP/9tMLIy/35i
        WdkNprfNq5a3pd/qdvrnVtq7Nywk5uzdLqmkV6/2BGROMCy+mlGUUq6i88tRb/eeGVadnxRb
        kxdtbZx21CKx6PzlKZbPP3Ys/FxjezW4z+hw6941Zq2Vbyb2dk34e7+LjWfz8wmacsYuUzkf
        +sQ3PVr84UFaQu5Hk8iTx045H57E78i+eK++n3nbsRuKDHOy2hW916Xe/BCkxFKckWioxVxU
        nAgAM3wXehkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsWy7bCSnG6F7qwkgwmrGC0ezNvGZvHy51U2
        i2svL7BbTPvwk9ni8n5ti/lHzrFa9L14yGyx6fE1VovLu+awWUxY9Y3Fovv6DjaL5cf/MVks
        2vqF3aJ17xF2i513TjA78HtcvuLtsWlVJ5vHnWt72Dw2L6n3+Pj0FotH35ZVjB6fN8l5tB/o
        ZgrgiOKySUnNySxLLdK3S+DKeLb3KmPBA/GKnt0X2BoYtwl3MXJySAiYSKz5sZ61i5GLQ0hg
        B6PEn82v2CES0hLXN06AsoUlVv57DmYLCTQxSbS+EAGx2QS0Je5O38IEYosItDNK3N/OBjKI
        WeAok8TyU8eYQRLCAjYSL1f8YASxWQRUJVac2QfWwAsUP/v7KxvEAnmJ1RsOANVzcHAK2EpM
        Pc0HsctG4vv5+6wTGPkWMDKsYpRMLSjOTc8tNiwwykst1ytOzC0uzUvXS87P3cQIDm4trR2M
        e1Z90DvEyMTBeIhRgoNZSYS3bN7MJCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8F7pOxgsJpCeW
        pGanphakFsFkmTg4pRqYZHXMLxROZnhxoP93XLlwcp3c8luxDOkTjCMF9jByrNnn9/R/SCHL
        tOWMJjt/vGefK+exu6Tykfzy2KRvm9pF5pTUJdcLfg2v4bfRlVmn43njn926TzUMgtzBHsnV
        0bsETzxuU0uzfpE645q62nb+h312jfoNH0UZ3x9ctZnDVW+pU9TsbXVPS+4rB4Zc+rYuYlb3
        tr9XxDIvnA/nUn45a12vkwujof2We8xmNSLb19j1ztoTu1DkVkvrf9/ZMtnbzj1TFNx2o+WO
        +6W1ar3KvTsWepyvdA40nJtas/z9nBaZkPfKsuKMFS76TUcXx7Y1HZtVd9Dgdc/ktAfxvf94
        N8/b27TQbNPZ8ujHaaJKLMUZiYZazEXFiQCnEuK/3QIAAA==
X-CMS-MailID: 20220603154912epcas5p2bf984fb4e32ee1b1357a3cc595e70a67
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220603154912epcas5p2bf984fb4e32ee1b1357a3cc595e70a67
References: <20220603154714.30532-1-alim.akhtar@samsung.com>
        <CGME20220603154912epcas5p2bf984fb4e32ee1b1357a3cc595e70a67@epcas5p2.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds FSD ufs device node and enable the same for fsd platform.
This also adds the required pin configuration for the same.

Signed-off-by: Bharat Uppal <bharat.uppal@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 arch/arm64/boot/dts/tesla/fsd-evb.dts      |  4 +++
 arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi | 14 +++++++++++
 arch/arm64/boot/dts/tesla/fsd.dtsi         | 29 ++++++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/tesla/fsd-evb.dts b/arch/arm64/boot/dts/tesla/fsd-evb.dts
index 5af560c1b5e6..1db6ddf03f01 100644
--- a/arch/arm64/boot/dts/tesla/fsd-evb.dts
+++ b/arch/arm64/boot/dts/tesla/fsd-evb.dts
@@ -37,3 +37,7 @@ &fin_pll {
 &serial_0 {
 	status = "okay";
 };
+
+&ufs {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
index d4d0cb005712..387a41e251d5 100644
--- a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
@@ -50,6 +50,20 @@ gpf5: gpf5-gpio-bank {
 		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
+
+	ufs_rst_n: ufs-rst-n-pins {
+		samsung,pins = "gpf5-0";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV2>;
+	};
+
+	ufs_refclk_out: ufs-refclk-out-pins {
+		samsung,pins = "gpf5-1";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV2>;
+	};
 };
 
 &pinctrl_peric {
diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi b/arch/arm64/boot/dts/tesla/fsd.dtsi
index af39655331de..7d1acf8f6466 100644
--- a/arch/arm64/boot/dts/tesla/fsd.dtsi
+++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
@@ -740,6 +740,35 @@ timer@10040000 {
 			clocks = <&fin_pll>, <&clock_imem IMEM_MCT_PCLK>;
 			clock-names = "fin_pll", "mct";
 		};
+
+		ufs: ufs@15120000 {
+			compatible = "tesla,fsd-ufs";
+			reg = <0x0 0x15120000 0x0 0x200>,  /* 0: HCI standard */
+			      <0x0 0x15121100 0x0 0x200>,  /* 1: Vendor specified */
+			      <0x0 0x15110000 0x0 0x8000>,  /* 2: UNIPRO */
+			      <0x0 0x15130000 0x0 0x100>;  /* 3: UFS protector */
+			reg-names = "hci", "vs_hci", "unipro", "ufsp";
+			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clock_fsys0 UFS0_TOP0_HCLK_BUS>,
+				 <&clock_fsys0 UFS0_TOP0_CLK_UNIPRO>;
+			clock-names = "core_clk", "sclk_unipro_main";
+			freq-table-hz = <0 0>, <0 0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&ufs_rst_n &ufs_refclk_out>;
+			phys = <&ufs_phy>;
+			phy-names = "ufs-phy";
+			status = "disabled";
+		};
+
+		ufs_phy: ufs-phy@15124000 {
+			compatible = "tesla,fsd-ufs-phy";
+			reg = <0x0 0x15124000 0x0 0x800>;
+			reg-names = "phy-pma";
+			samsung,pmu-syscon = <&pmu_system_controller>;
+			#phy-cells = <0>;
+			clocks = <&clock_fsys0 UFS0_MPHY_REFCLK_IXTAL26>;
+			clock-names = "ref_clk";
+		};
 	};
 };
 
-- 
2.25.1

