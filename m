Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E342C4CD030
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 09:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbiCDIj0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 4 Mar 2022 03:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbiCDIid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 03:38:33 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAF61D9;
        Fri,  4 Mar 2022 00:37:45 -0800 (PST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2247IXYX028487;
        Fri, 4 Mar 2022 08:37:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3eke90s86t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Mar 2022 08:37:09 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2248SrHq021740;
        Fri, 4 Mar 2022 08:37:09 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3eke90s86c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Mar 2022 08:37:09 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2248XW5P020673;
        Fri, 4 Mar 2022 08:37:07 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma05fra.de.ibm.com with ESMTP id 3ek4ka920p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Mar 2022 08:37:06 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2248b4c049611120
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Mar 2022 08:37:04 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81EAAA405C;
        Fri,  4 Mar 2022 08:37:04 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D243AA4054;
        Fri,  4 Mar 2022 08:37:03 +0000 (GMT)
Received: from smtp.tlslab.ibm.com (unknown [9.101.4.1])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri,  4 Mar 2022 08:37:03 +0000 (GMT)
Received: from yukon.home (unknown [9.171.91.16])
        by smtp.tlslab.ibm.com (Postfix) with ESMTP id 1D5B32200FD;
        Fri,  4 Mar 2022 09:37:02 +0100 (CET)
From:   =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To:     linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org
Cc:     Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-aspeed@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH v3 10/11] ARM: dts: aspeed: Enable Dual SPI RX transfers
Date:   Fri,  4 Mar 2022 09:36:42 +0100
Message-Id: <20220304083643.1079142-11-clg@kaod.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220304083643.1079142-1-clg@kaod.org>
References: <20220304083643.1079142-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WCdqW2nETb4UQ0Mwgm4fKcA-MTAiRqt1
X-Proofpoint-ORIG-GUID: HtRGs9r0M2zi5Ybu2iNLriu2HSRkh_lF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-04_02,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1034
 lowpriorityscore=0 mlxscore=0 bulkscore=0 mlxlogscore=746
 priorityscore=1501 suspectscore=0 spamscore=0 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203040044
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All these controllers support at least Dual SPI. Update the DTs.

Reviewed-by: Joel Stanley <joel@jms.id.au>
Tested-by: Joel Stanley <joel@jms.id.au>
Tested-by: Tao Ren <rentao.bupt@gmail.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 6 ++++++
 arch/arm/boot/dts/aspeed-g5.dtsi | 7 +++++++
 arch/arm/boot/dts/aspeed-g6.dtsi | 8 ++++++++
 3 files changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index 9ae67e83cf60..31e6569db97e 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -64,27 +64,32 @@ fmc: spi@1e620000 {
 			flash@0 {
 				reg = < 0 >;
 				compatible = "jedec,spi-nor";
+				spi-rx-bus-width = <2>;
 				spi-max-frequency = <50000000>;
 				status = "disabled";
 			};
 			flash@1 {
 				reg = < 1 >;
 				compatible = "jedec,spi-nor";
+				spi-rx-bus-width = <2>;
 				status = "disabled";
 			};
 			flash@2 {
 				reg = < 2 >;
 				compatible = "jedec,spi-nor";
+				spi-rx-bus-width = <2>;
 				status = "disabled";
 			};
 			flash@3 {
 				reg = < 3 >;
 				compatible = "jedec,spi-nor";
+				spi-rx-bus-width = <2>;
 				status = "disabled";
 			};
 			flash@4 {
 				reg = < 4 >;
 				compatible = "jedec,spi-nor";
+				spi-rx-bus-width = <2>;
 				status = "disabled";
 			};
 		};
@@ -100,6 +105,7 @@ flash@0 {
 				reg = < 0 >;
 				compatible = "jedec,spi-nor";
 				spi-max-frequency = <50000000>;
+				spi-rx-bus-width = <2>;
 				status = "disabled";
 			};
 		};
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index c3e0a8e13c8a..29bf017899b6 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -66,18 +66,21 @@ flash@0 {
 				reg = < 0 >;
 				compatible = "jedec,spi-nor";
 				spi-max-frequency = <50000000>;
+				spi-rx-bus-width = <2>;
 				status = "disabled";
 			};
 			flash@1 {
 				reg = < 1 >;
 				compatible = "jedec,spi-nor";
 				spi-max-frequency = <50000000>;
+				spi-rx-bus-width = <2>;
 				status = "disabled";
 			};
 			flash@2 {
 				reg = < 2 >;
 				compatible = "jedec,spi-nor";
 				spi-max-frequency = <50000000>;
+				spi-rx-bus-width = <2>;
 				status = "disabled";
 			};
 		};
@@ -93,12 +96,14 @@ flash@0 {
 				reg = < 0 >;
 				compatible = "jedec,spi-nor";
 				spi-max-frequency = <50000000>;
+				spi-rx-bus-width = <2>;
 				status = "disabled";
 			};
 			flash@1 {
 				reg = < 1 >;
 				compatible = "jedec,spi-nor";
 				spi-max-frequency = <50000000>;
+				spi-rx-bus-width = <2>;
 				status = "disabled";
 			};
 		};
@@ -114,12 +119,14 @@ flash@0 {
 				reg = < 0 >;
 				compatible = "jedec,spi-nor";
 				spi-max-frequency = <50000000>;
+				spi-rx-bus-width = <2>;
 				status = "disabled";
 			};
 			flash@1 {
 				reg = < 1 >;
 				compatible = "jedec,spi-nor";
 				spi-max-frequency = <50000000>;
+				spi-rx-bus-width = <2>;
 				status = "disabled";
 			};
 		};
diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index 1ad05dde19d2..ce93c56a21a7 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -106,18 +106,21 @@ flash@0 {
 				reg = < 0 >;
 				compatible = "jedec,spi-nor";
 				spi-max-frequency = <50000000>;
+				spi-rx-bus-width = <2>;
 				status = "disabled";
 			};
 			flash@1 {
 				reg = < 1 >;
 				compatible = "jedec,spi-nor";
 				spi-max-frequency = <50000000>;
+				spi-rx-bus-width = <2>;
 				status = "disabled";
 			};
 			flash@2 {
 				reg = < 2 >;
 				compatible = "jedec,spi-nor";
 				spi-max-frequency = <50000000>;
+				spi-rx-bus-width = <2>;
 				status = "disabled";
 			};
 		};
@@ -133,12 +136,14 @@ flash@0 {
 				reg = < 0 >;
 				compatible = "jedec,spi-nor";
 				spi-max-frequency = <50000000>;
+				spi-rx-bus-width = <2>;
 				status = "disabled";
 			};
 			flash@1 {
 				reg = < 1 >;
 				compatible = "jedec,spi-nor";
 				spi-max-frequency = <50000000>;
+				spi-rx-bus-width = <2>;
 				status = "disabled";
 			};
 		};
@@ -154,18 +159,21 @@ flash@0 {
 				reg = < 0 >;
 				compatible = "jedec,spi-nor";
 				spi-max-frequency = <50000000>;
+				spi-rx-bus-width = <2>;
 				status = "disabled";
 			};
 			flash@1 {
 				reg = < 1 >;
 				compatible = "jedec,spi-nor";
 				spi-max-frequency = <50000000>;
+				spi-rx-bus-width = <2>;
 				status = "disabled";
 			};
 			flash@2 {
 				reg = < 2 >;
 				compatible = "jedec,spi-nor";
 				spi-max-frequency = <50000000>;
+				spi-rx-bus-width = <2>;
 				status = "disabled";
 			};
 		};
-- 
2.34.1

