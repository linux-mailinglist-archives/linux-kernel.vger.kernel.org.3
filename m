Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664AE586817
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 13:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbiHALZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 07:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbiHALZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 07:25:46 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04olkn2058.outbound.protection.outlook.com [40.92.47.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CCB2F3A7;
        Mon,  1 Aug 2022 04:25:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QeKwEw602e7CehEAE5SlthVfCdhjdjqvDy2RE0smTRVobwjEdjnMa0i7IwIKw+WCd1RZz3ciurDp3oAqQDPbnS2NsIZcKTE52aLyC/c5Z8oMAuU0ANN3R/JH60FS2vPcJwSiyb8HGfvWBCpmA1ztE/zXK93HZSuKUMDy3uB/ZXqVzWglq/KT7W+wT4XXALW2Ya6dKt8F6++acS6HYahmm3od9i3FeGS5ik6EyO7miZAA8LgCFvaMq3OncE49teBbGn1C1fWnW4DYPlgVR8HwyMrtRwVFo70j11KFp3KnRuCshEzTVd4wseX9iix3hcD2CGs9hzCC2MYf/tZTLm7rVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9ZvVRpEd8Xz+sB8X8OuFpxNta/VRhKFph2o98JiOMY=;
 b=GibOId+N09r6bdjiohpX+wZ/9jNompAtpT7PfAXmqYGwqegebvwTwxCdAYZXnsZ32iWhPFM31olVETDOwwFi3220G9+n9YuI9+qlfQO9e8tM/zOR5A2pOZpoaNPhNtdTmy3xe/gq9G5TA8FLsf8qpEC8j3r9FBHOgkBWizkOW7lxPbRAqYi0yg0LbetMZQBjq9JXi2Zuo+gxVimqV6mTYNvg4PN8iam9pijyVvLSU+7EZ6sE+hRQVEmwzpuhWRev84V3VLYmFIhD8u7NiSwvifBUGdKmtoPwCy+2I1fKa0hXUDlIHV4IPsB+GejWGlpjj67z/cKUZFq00IO/KYo23Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9ZvVRpEd8Xz+sB8X8OuFpxNta/VRhKFph2o98JiOMY=;
 b=J8WRlm02fdEJZf2Aq+JoIP3NG+oa6ER2A7+n/K0GFeGFZ0WpHQX9ATrQPe4RXc3oclfvTzi2wYKFaTJQ0jcrfLZ0skIOU4N/HmbpdUAcPvYrn8Q/zi3T+vsQ2wsOG8nmy/tsOyhxpKIYv5GKW+tbLwaax16NuP97Lx3Q3t7z0H9PmFMVvi7u3PkIPyhQsNBktYt2Iq6lu/ePcI5S8rBFqZy/yxIdrV1sRCEOf30VGpFi5k2XU8GSldpyuKS7p7VQ0dvxKScfqMkICtlKJJosiQPj9y7ihCvEywo8rTD6qEWWauMQ5JDzyBMVerKwPbM1NV4Lk7KSOzKyPQI/APH3MQ==
Received: from BY5PR02MB7009.namprd02.prod.outlook.com (2603:10b6:a03:236::13)
 by CO6PR02MB7666.namprd02.prod.outlook.com (2603:10b6:303:a4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Mon, 1 Aug
 2022 11:25:37 +0000
Received: from BY5PR02MB7009.namprd02.prod.outlook.com
 ([fe80::e080:d670:29c7:9180]) by BY5PR02MB7009.namprd02.prod.outlook.com
 ([fe80::e080:d670:29c7:9180%8]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 11:25:37 +0000
From:   Joel Selvaraj <joel.selvaraj@outlook.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Joel Selvaraj <joel.selvaraj@outlook.com>
Subject: [PATCH v2 2/3] arm64: dts: qcom: sdm845-xiaomi-beryllium-common: move common nodes to a common dtsi
Date:   Mon,  1 Aug 2022 16:55:11 +0530
Message-ID: <BY5PR02MB70091276EDE0CE4FCB6CFBD5EA9A9@BY5PR02MB7009.namprd02.prod.outlook.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220801112512.209047-1-joel.selvaraj@outlook.com>
References: <20220801112512.209047-1-joel.selvaraj@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [d5q2uJByj/vXozlPk49whx3JR/w6USk+OTEq3cte08NlUZzvCSxFtLItIzTSmS43]
X-ClientProxiedBy: PN2PR01CA0107.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::22) To BY5PR02MB7009.namprd02.prod.outlook.com
 (2603:10b6:a03:236::13)
X-Microsoft-Original-Message-ID: <20220801112512.209047-3-joel.selvaraj@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d1a250d-8105-41fb-ff75-08da73b08e94
X-MS-Exchange-SLBlob-MailProps: tBYDyRQCPckhYfnxUdDn+O6zSuD/K+SS7wOMhaXwnS3Y670VHlHWjOE9Eger95o4HtZxcOPY5FCFaNhFi3geXKHVRIHMn/88WAEfkbkDICZhM/70lrg8GeMOr5bAoa0QrLhQmE8tE/rNGNsd38rMhslODzUHYEbhrZf6ZpCBYUDsAWAlKmQXSzCRTPSpSqSqVXhzhzHuGXHskCHkPZM9O+S/QaVhgYScKPZsQrJttfoPTNBW6gxefQV6PJGLsVqTZYQeuv6ySXGmzK8czj7vXCnzLcI858vvEdvN2YK5gwKRpwGR1b2aORcNADNTBhyq1Ug/Bky7x3TT96fPUogezJnauVu+/nH0Ug9koZitT/ehdoj0sDYEky4aaJlfNb1zQn5qzJnk40hnlYMVmJ6F0wvQCT1A/kNXVa/dk2thoFUQOyZanPxB6HXcHGFq7TCr/pSMUYlXONyaifH/lngy9FD+hChbKJ/re0EIJRt6GXm4Wg0/0+FnJnUSWDSSMV+wWCOcVBUHFf6mC+7VeLPsxz1HYZGMGQiA+GEaPTMs2mLjjkuO7X5/X9zxmWKpUNUicxOrWTOSZ3IpUUaEbeKKi0KHKiRb5AZHX9tEPO5DS+Qwbs87Vj4meUTZLmJYsHe9ExYc4A4LhHitDLE8i2zOaq9hbUqMYhTbYtBXZZ+cU24DTkvPZQmrj5GrrgkBuJrOnZPrP8swe6DzFI1E7svdmjz3oBLDJ1pR1jzMWoqGFOzyrkujItHBCTdV1lVEgdzMnMzIqg6MixI=
X-MS-TrafficTypeDiagnostic: CO6PR02MB7666:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9AU405sbRbB+nf7BAPfHblShmMJuLxcfvs/PE70HnHBz8dotwAkGwtYD7EP5XmqobRxo2qGZ4WLrWGpyEBuZO8XPCT4SOvLulzPxWsLRq9Ez5QIxkPu+RqXiIzZ0ev5BpmIL0zcGzlmYUPhnxcuNsqUlh6/kLJw7LeiH+REaSvdvXvfTszCLX0tzbyJJt6oRMk212M5QBKlFUeE6QOMcF4eD+7tqOQ3I0OubrjAAjLigCyVb9nXdzB91k5VY+wVhzCW/fAxP/0rZrHjCHQ5kg0zDjoPKgT/24i1u1P2uvkFABEhOd0nG97yEkZfx/F7XGXPA8liHeC/er8s5BtOlQal5z8pr8p6rL8GAryv4hkadRtTgUv/G8ysFW1PvgDE3YH0aqYepNRypG609jy8b8mGl9Xviy05IPjhIGxUMnW4Orgjix89LB5ke28MXZVDWPl4P1hpNf14M0GizTsN7ZREroKSExz6TLa9gm2//KwVZInGq3e+D/rjQIZgmw6MK7ap02WxCApmddtAdGFfbpDt6pdyZPY3JvjeXXbmWPoHFF7ULOv/JIPFxM3M5aYsiqh9lsuSf1ugL00RXsVwMNpn2NdB83BTQI+y4VOvhgkFJSIok9hZ+sTRqZGOSDok9e2R7wdEFF/6DogsJicMQMA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x3VT8XZZlDZzOEKlf/rsyoz7+49LoxOzpedjLTYhe110oDrtItHYdx7JVJYE?=
 =?us-ascii?Q?T0DgMYcAVlU9hs6OXkn2fLaqGVLVKe0ZYoF9h4KdxUvqmyiOkNcbeM3syhX6?=
 =?us-ascii?Q?WnK7u3tANukWYS2HG0czK/SPTorWkW7lkO6jO+7shbQquUW5vrGnm8LebvJO?=
 =?us-ascii?Q?uphOJWnOewXmS2jVpcFx28UciyF5fIqE9+/nnGHBDVsrfk/WA64CiLPOa7f2?=
 =?us-ascii?Q?mU9zFG25rwxICAnjfSRglcMG9ZJKNVdKQHtXpy+e6RZ0wXSaTNswEFKceArU?=
 =?us-ascii?Q?YbbNuACGqRnANh+43WE9ucRICvK0XwudZ4lKl10VQ0I5xDOg8NzEtqV06xe2?=
 =?us-ascii?Q?B8vcWGmSRdi57k/yN/oEMdxrF9gYVfyjnjOwgytXlwuDRwWQEZKCZfTNLgWJ?=
 =?us-ascii?Q?8+U6g2nzHe+JZaO5QNshXF1E3pLQNxROgGIlhUxxYPm9S8HHmMAjxC7ITGU1?=
 =?us-ascii?Q?eZS6LqbR7TKjF5MOJSPbEczL0QncI077m+5vriAtu6MtfOkB1pnKmvR0mHDY?=
 =?us-ascii?Q?mQFe11id4f3275phsUe67oU/UdvfuyMknbmhZV1tF+t8fw1SPKC77SAxH0dH?=
 =?us-ascii?Q?KOqRk32WnNboFtT43p6rBKqQDiuh8ZENgoCrlgO7kMFVEi+7DoYBKxbZVmou?=
 =?us-ascii?Q?aIerZzy3w3efNQ3I+e0tmy6kByW+KWft7kPD0u0xbDCnTzrkYHDWnegEW6Av?=
 =?us-ascii?Q?SVGVeFpJG/3u3WlipihI76ZfHQ5IliAm1Q5FQEGN50WYiVOiZqkbDwSPUKxw?=
 =?us-ascii?Q?yYUWL7HcqTWaIICIIjzcOhy5vnS+rXRclN+iWdw3Fo2zUufwVwotfmmY366r?=
 =?us-ascii?Q?6l4XHBsMT/gT56CpVqjI4USbNcB0WaGOZA83DdooGTRHvyt8Q+fp3l9dGnyV?=
 =?us-ascii?Q?IE11VYvbL2OULn8tHeULDVMTJTPQHfYSZfbMhUMF5fBRLHGdS9fmh5382I16?=
 =?us-ascii?Q?dKxd3y6vqW/ds1uy256/qXyI+L+QEkNAGO9TcSSNc1HfObbXhtaVeBehUlkG?=
 =?us-ascii?Q?0Scb2TgEHhGMikix2yMzGdiCsS1/GNJ+Ejb7NXFNwTBKbyOXivT6EY7ObtjN?=
 =?us-ascii?Q?4HJoFX7TVlnHJPlK/D1SpVdnAuPGDpoMY9YtGtxXBl8doYgDrol0brxYDOWj?=
 =?us-ascii?Q?qq5hOs+TRfiMLdAm8+jcsIwpT4iFSCoPiP4MilejLICaBMDm3mQR1FZrzaLj?=
 =?us-ascii?Q?ScKFN0kYsrNEhBoECN3/+GOd+IuN50UoiTnjdJugjU9FR2NdjC53SQUELO9d?=
 =?us-ascii?Q?z3SWrc/cy51gHVh/0aDx98j2s+5Nh4UXlNVPC8gtGeFsCDuIaNwpEPF6uGDK?=
 =?us-ascii?Q?gfbHdusmzydm83NFIlkj0nk3lG3i32rm70P9q9vadMeNGg=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d1a250d-8105-41fb-ff75-08da73b08e94
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB7009.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 11:25:37.3976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7666
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since there are two variants of Xiaomi Poco F1, move the common nodes from
Tianma variant into a new common dtsi. The EBBG variant will also inherit
the new common dtsi.

Signed-off-by: Joel Selvaraj <joel.selvaraj@outlook.com>
---
 .../qcom/sdm845-xiaomi-beryllium-common.dtsi  | 595 ++++++++++++++++++
 .../qcom/sdm845-xiaomi-beryllium-tianma.dts   | 590 +----------------
 2 files changed, 598 insertions(+), 587 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi

diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
new file mode 100644
index 000000000000..83edcb1171f5
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
@@ -0,0 +1,595 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/dts-v1/;
+
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+#include <dt-bindings/sound/qcom,q6afe.h>
+#include <dt-bindings/sound/qcom,q6asm.h>
+#include "sdm845.dtsi"
+#include "pm8998.dtsi"
+#include "pmi8998.dtsi"
+
+/*
+ * Delete following upstream (sdm845.dtsi) reserved
+ * memory mappings which are different in this device.
+ */
+/delete-node/ &tz_mem;
+/delete-node/ &adsp_mem;
+/delete-node/ &wlan_msa_mem;
+/delete-node/ &mpss_region;
+/delete-node/ &venus_mem;
+/delete-node/ &cdsp_mem;
+/delete-node/ &mba_region;
+/delete-node/ &slpi_mem;
+/delete-node/ &spss_mem;
+/delete-node/ &rmtfs_mem;
+
+/ {
+	model = "Xiaomi Pocophone F1";
+	compatible = "xiaomi,beryllium", "qcom,sdm845";
+	chassis-type = "handset";
+
+	/* required for bootloader to select correct board */
+	qcom,board-id = <69 0>;
+	qcom,msm-id = <321 0x20001>;
+
+	aliases {
+		hsuart0 = &uart6;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		autorepeat;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&vol_up_pin_a>;
+
+		vol-up {
+			label = "Volume Up";
+			linux,code = <KEY_VOLUMEUP>;
+			gpios = <&pm8998_gpio 6 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	/* Reserved memory changes from downstream */
+	reserved-memory {
+		tz_mem: memory@86200000 {
+			reg = <0 0x86200000 0 0x4900000>;
+			no-map;
+		};
+
+		adsp_mem: memory@8c500000 {
+			reg = <0 0x8c500000 0 0x1e00000>;
+			no-map;
+		};
+
+		wlan_msa_mem: memory@8e300000 {
+			reg = <0 0x8e300000 0 0x100000>;
+			no-map;
+		};
+
+		mpss_region: memory@8e400000 {
+			reg = <0 0x8e400000 0 0x7800000>;
+			no-map;
+		};
+
+		venus_mem: memory@95c00000 {
+			reg = <0 0x95c00000 0 0x500000>;
+			no-map;
+		};
+
+		cdsp_mem: memory@96100000 {
+			reg = <0 0x96100000 0 0x800000>;
+			no-map;
+		};
+
+		mba_region: memory@96900000 {
+			reg = <0 0x96900000 0 0x200000>;
+			no-map;
+		};
+
+		slpi_mem: memory@96b00000 {
+			reg = <0 0x96b00000 0 0x1400000>;
+			no-map;
+		};
+
+		spss_mem: memory@97f00000 {
+			reg = <0 0x97f00000 0 0x100000>;
+			no-map;
+		};
+
+		rmtfs_mem: memory@f6301000 {
+			compatible = "qcom,rmtfs-mem";
+			reg = <0 0xf6301000 0 0x200000>;
+			no-map;
+
+			qcom,client-id = <1>;
+			qcom,vmid = <15>;
+		};
+	};
+
+	vreg_s4a_1p8: vreg-s4a-1p8 {
+		compatible = "regulator-fixed";
+		regulator-name = "vreg_s4a_1p8";
+
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
+};
+
+&adsp_pas {
+	status = "okay";
+	firmware-name = "qcom/sdm845/beryllium/adsp.mbn";
+};
+
+&apps_rsc {
+	pm8998-rpmh-regulators {
+		compatible = "qcom,pm8998-rpmh-regulators";
+		qcom,pmic-id = "a";
+
+		vreg_l1a_0p875: ldo1 {
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <880000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l5a_0p8: ldo5 {
+			regulator-min-microvolt = <800000>;
+			regulator-max-microvolt = <800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l7a_1p8: ldo7 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l12a_1p8: ldo12 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l13a_2p95: ldo13 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l14a_1p8: ldo14 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
+
+		vreg_l17a_1p3: ldo17 {
+			regulator-min-microvolt = <1304000>;
+			regulator-max-microvolt = <1304000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l20a_2p95: ldo20 {
+			regulator-min-microvolt = <2960000>;
+			regulator-max-microvolt = <2968000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l21a_2p95: ldo21 {
+			regulator-min-microvolt = <2960000>;
+			regulator-max-microvolt = <2968000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l23a_3p3: ldo23 {
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3312000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l24a_3p075: ldo24 {
+			regulator-min-microvolt = <3088000>;
+			regulator-max-microvolt = <3088000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l25a_3p3: ldo25 {
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3312000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l26a_1p2: ldo26 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-boot-on;
+		};
+	};
+};
+
+&cdsp_pas {
+	status = "okay";
+	firmware-name = "qcom/sdm845/beryllium/cdsp.mbn";
+};
+
+&dsi0 {
+	status = "okay";
+	vdda-supply = <&vreg_l26a_1p2>;
+
+	display_panel: panel@0 {
+		reg = <0>;
+		vddio-supply = <&vreg_l14a_1p8>;
+		vddpos-supply = <&lab>;
+		vddneg-supply = <&ibb>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		backlight = <&pmi8998_wled>;
+		reset-gpios = <&tlmm 6 GPIO_ACTIVE_LOW>;
+
+		status = "disabled";
+
+		port {
+			panel_in_0: endpoint {
+				remote-endpoint = <&dsi0_out>;
+			};
+		};
+	};
+};
+
+&dsi0_out {
+	remote-endpoint = <&panel_in_0>;
+	data-lanes = <0 1 2 3>;
+};
+
+&dsi0_phy {
+	status = "okay";
+	vdds-supply = <&vreg_l1a_0p875>;
+};
+
+&gcc {
+	protected-clocks = <GCC_QSPI_CORE_CLK>,
+			   <GCC_QSPI_CORE_CLK_SRC>,
+			   <GCC_QSPI_CNOC_PERIPH_AHB_CLK>,
+			   <GCC_LPASS_Q6_AXI_CLK>,
+			   <GCC_LPASS_SWAY_CLK>;
+};
+
+&gmu {
+	status = "okay";
+};
+
+&gpu {
+	status = "okay";
+
+	zap-shader {
+		memory-region = <&gpu_mem>;
+		firmware-name = "qcom/sdm845/beryllium/a630_zap.mbn";
+	};
+};
+
+&ibb {
+	regulator-min-microvolt = <4600000>;
+	regulator-max-microvolt = <6000000>;
+	regulator-over-current-protection;
+	regulator-pull-down;
+	regulator-soft-start;
+	qcom,discharge-resistor-kohms = <300>;
+};
+
+&lab {
+	regulator-min-microvolt = <4600000>;
+	regulator-max-microvolt = <6000000>;
+	regulator-over-current-protection;
+	regulator-pull-down;
+	regulator-soft-start;
+};
+
+&mdss {
+	status = "okay";
+};
+
+&mss_pil {
+	status = "okay";
+	firmware-name = "qcom/sdm845/beryllium/mba.mbn", "qcom/sdm845/beryllium/modem.mbn";
+};
+
+&ipa {
+	status = "okay";
+	memory-region = <&ipa_fw_mem>;
+	firmware-name = "qcom/sdm845/beryllium/ipa_fws.mbn";
+};
+
+&pm8998_gpio {
+	vol_up_pin_a: vol-up-active {
+		pins = "gpio6";
+		function = "normal";
+		input-enable;
+		bias-pull-up;
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
+	};
+};
+
+&pmi8998_wled {
+	status = "okay";
+	qcom,current-boost-limit = <970>;
+	qcom,ovp-millivolt = <29600>;
+	qcom,current-limit-microamp = <20000>;
+	qcom,num-strings = <2>;
+	qcom,switching-freq = <600>;
+	qcom,external-pfet;
+	qcom,cabc;
+};
+
+&pm8998_pon {
+	resin {
+		compatible = "qcom,pm8941-resin";
+		interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
+		debounce = <15625>;
+		bias-pull-up;
+		linux,code = <KEY_VOLUMEDOWN>;
+	};
+};
+
+/* QUAT I2S Uses 1 I2S SD Line for audio on TAS2559/60 amplifiers */
+&q6afedai {
+	qi2s@22 {
+		reg = <22>;
+		qcom,sd-lines = <0>;
+	};
+};
+
+&q6asmdai {
+	dai@0 {
+		reg = <0>;
+	};
+
+	dai@1 {
+		reg = <1>;
+	};
+
+	dai@2 {
+		reg = <2>;
+	};
+};
+
+&qupv3_id_0 {
+	status = "okay";
+};
+
+&sdhc_2 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdc2_default_state &sdc2_card_det_n>;
+
+	vmmc-supply = <&vreg_l21a_2p95>;
+	vqmmc-supply = <&vreg_l13a_2p95>;
+
+	bus-width = <4>;
+	cd-gpios = <&tlmm 126 GPIO_ACTIVE_HIGH>;
+};
+
+&sound {
+	compatible = "qcom,db845c-sndcard";
+	pinctrl-0 = <&quat_mi2s_active
+			&quat_mi2s_sd0_active>;
+	pinctrl-names = "default";
+	model = "Xiaomi Poco F1";
+	audio-routing =
+		"RX_BIAS", "MCLK",
+		"AMIC1", "MIC BIAS1",
+		"AMIC2", "MIC BIAS2",
+		"AMIC3", "MIC BIAS3";
+
+	mm1-dai-link {
+		link-name = "MultiMedia1";
+		cpu {
+			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA1>;
+		};
+	};
+
+	mm2-dai-link {
+		link-name = "MultiMedia2";
+		cpu {
+			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA2>;
+		};
+	};
+
+	mm3-dai-link {
+		link-name = "MultiMedia3";
+		cpu {
+			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA3>;
+		};
+	};
+
+	slim-dai-link {
+		link-name = "SLIM Playback";
+		cpu {
+			sound-dai = <&q6afedai SLIMBUS_0_RX>;
+		};
+
+		platform {
+			sound-dai = <&q6routing>;
+		};
+
+		codec {
+			sound-dai =  <&wcd9340 0>;
+		};
+	};
+
+	slimcap-dai-link {
+		link-name = "SLIM Capture";
+		cpu {
+			sound-dai = <&q6afedai SLIMBUS_0_TX>;
+		};
+
+		platform {
+			sound-dai = <&q6routing>;
+		};
+
+		codec {
+			sound-dai = <&wcd9340 1>;
+		};
+	};
+};
+
+&tlmm {
+	gpio-reserved-ranges = <0 4>, <81 4>;
+
+	sdc2_default_state: sdc2-default {
+		clk {
+			pins = "sdc2_clk";
+			bias-disable;
+			drive-strength = <16>;
+		};
+
+		cmd {
+			pins = "sdc2_cmd";
+			bias-pull-up;
+			drive-strength = <10>;
+		};
+
+		data {
+			pins = "sdc2_data";
+			bias-pull-up;
+			drive-strength = <10>;
+		};
+	};
+
+	sdc2_card_det_n: sd-card-det-n {
+		pins = "gpio126";
+		function = "gpio";
+		bias-pull-up;
+	};
+
+	wcd_intr_default: wcd_intr_default {
+		pins = <54>;
+		function = "gpio";
+
+		input-enable;
+		bias-pull-down;
+		drive-strength = <2>;
+	};
+};
+
+&uart6 {
+	status = "okay";
+
+	bluetooth {
+		compatible = "qcom,wcn3990-bt";
+
+		vddio-supply = <&vreg_s4a_1p8>;
+		vddxo-supply = <&vreg_l7a_1p8>;
+		vddrf-supply = <&vreg_l17a_1p3>;
+		vddch0-supply = <&vreg_l25a_3p3>;
+		max-speed = <3200000>;
+	};
+};
+
+&ufs_mem_hc {
+	status = "okay";
+
+	reset-gpios = <&tlmm 150 GPIO_ACTIVE_LOW>;
+
+	vcc-supply = <&vreg_l20a_2p95>;
+	vcc-max-microamp = <800000>;
+};
+
+&ufs_mem_phy {
+	status = "okay";
+
+	vdda-phy-supply = <&vreg_l1a_0p875>;
+	vdda-pll-supply = <&vreg_l26a_1p2>;
+};
+
+&usb_1 {
+	status = "okay";
+};
+
+&usb_1_dwc3 {
+	dr_mode = "peripheral";
+};
+
+&usb_1_hsphy {
+	status = "okay";
+
+	vdd-supply = <&vreg_l1a_0p875>;
+	vdda-pll-supply = <&vreg_l12a_1p8>;
+	vdda-phy-dpdm-supply = <&vreg_l24a_3p075>;
+
+	qcom,imp-res-offset-value = <8>;
+	qcom,hstx-trim-value = <QUSB2_V2_HSTX_TRIM_21_6_MA>;
+	qcom,preemphasis-level = <QUSB2_V2_PREEMPHASIS_5_PERCENT>;
+	qcom,preemphasis-width = <QUSB2_V2_PREEMPHASIS_WIDTH_HALF_BIT>;
+};
+
+&usb_1_qmpphy {
+	status = "okay";
+
+	vdda-phy-supply = <&vreg_l26a_1p2>;
+	vdda-pll-supply = <&vreg_l1a_0p875>;
+};
+
+&venus {
+	status = "okay";
+	firmware-name = "qcom/sdm845/beryllium/venus.mbn";
+};
+
+&wcd9340{
+	pinctrl-0 = <&wcd_intr_default>;
+	pinctrl-names = "default";
+	clock-names = "extclk";
+	clocks = <&rpmhcc RPMH_LN_BB_CLK2>;
+	reset-gpios = <&tlmm 64 0>;
+	vdd-buck-supply = <&vreg_s4a_1p8>;
+	vdd-buck-sido-supply = <&vreg_s4a_1p8>;
+	vdd-tx-supply = <&vreg_s4a_1p8>;
+	vdd-rx-supply = <&vreg_s4a_1p8>;
+	vdd-io-supply = <&vreg_s4a_1p8>;
+	qcom,micbias1-microvolt = <2700000>;
+	qcom,micbias2-microvolt = <1800000>;
+	qcom,micbias3-microvolt = <2700000>;
+	qcom,micbias4-microvolt = <2700000>;
+};
+
+&wifi {
+	status = "okay";
+
+	vdd-0.8-cx-mx-supply = <&vreg_l5a_0p8>;
+	vdd-1.8-xo-supply = <&vreg_l7a_1p8>;
+	vdd-1.3-rfa-supply = <&vreg_l17a_1p3>;
+	vdd-3.3-ch0-supply = <&vreg_l25a_3p3>;
+	vdd-3.3-ch1-supply = <&vreg_l23a_3p3>;
+};
+
+/* PINCTRL - additions to nodes defined in sdm845.dtsi */
+
+&qup_uart6_default {
+	pinmux {
+		pins = "gpio45", "gpio46", "gpio47", "gpio48";
+		function = "qup6";
+	};
+
+	cts {
+		pins = "gpio45";
+		bias-disable;
+	};
+
+	rts-tx {
+		pins = "gpio46", "gpio47";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	rx {
+		pins = "gpio48";
+		bias-pull-up;
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts
index d88dc07205f7..fcbef5ad2909 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts
@@ -2,593 +2,9 @@
 
 /dts-v1/;
 
-#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
-#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
-#include <dt-bindings/sound/qcom,q6afe.h>
-#include <dt-bindings/sound/qcom,q6asm.h>
-#include "sdm845.dtsi"
-#include "pm8998.dtsi"
-#include "pmi8998.dtsi"
+#include "sdm845-xiaomi-beryllium-common.dtsi"
 
-/*
- * Delete following upstream (sdm845.dtsi) reserved
- * memory mappings which are different in this device.
- */
-/delete-node/ &tz_mem;
-/delete-node/ &adsp_mem;
-/delete-node/ &wlan_msa_mem;
-/delete-node/ &mpss_region;
-/delete-node/ &venus_mem;
-/delete-node/ &cdsp_mem;
-/delete-node/ &mba_region;
-/delete-node/ &slpi_mem;
-/delete-node/ &spss_mem;
-/delete-node/ &rmtfs_mem;
-
-/ {
-	model = "Xiaomi Pocophone F1";
-	compatible = "xiaomi,beryllium", "qcom,sdm845";
-	chassis-type = "handset";
-
-	/* required for bootloader to select correct board */
-	qcom,board-id = <69 0>;
-	qcom,msm-id = <321 0x20001>;
-
-	aliases {
-		hsuart0 = &uart6;
-	};
-
-	gpio-keys {
-		compatible = "gpio-keys";
-		autorepeat;
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&vol_up_pin_a>;
-
-		vol-up {
-			label = "Volume Up";
-			linux,code = <KEY_VOLUMEUP>;
-			gpios = <&pm8998_gpio 6 GPIO_ACTIVE_LOW>;
-		};
-	};
-
-	/* Reserved memory changes from downstream */
-	reserved-memory {
-		tz_mem: memory@86200000 {
-			reg = <0 0x86200000 0 0x4900000>;
-			no-map;
-		};
-
-		adsp_mem: memory@8c500000 {
-			reg = <0 0x8c500000 0 0x1e00000>;
-			no-map;
-		};
-
-		wlan_msa_mem: memory@8e300000 {
-			reg = <0 0x8e300000 0 0x100000>;
-			no-map;
-		};
-
-		mpss_region: memory@8e400000 {
-			reg = <0 0x8e400000 0 0x7800000>;
-			no-map;
-		};
-
-		venus_mem: memory@95c00000 {
-			reg = <0 0x95c00000 0 0x500000>;
-			no-map;
-		};
-
-		cdsp_mem: memory@96100000 {
-			reg = <0 0x96100000 0 0x800000>;
-			no-map;
-		};
-
-		mba_region: memory@96900000 {
-			reg = <0 0x96900000 0 0x200000>;
-			no-map;
-		};
-
-		slpi_mem: memory@96b00000 {
-			reg = <0 0x96b00000 0 0x1400000>;
-			no-map;
-		};
-
-		spss_mem: memory@97f00000 {
-			reg = <0 0x97f00000 0 0x100000>;
-			no-map;
-		};
-
-		rmtfs_mem: memory@f6301000 {
-			compatible = "qcom,rmtfs-mem";
-			reg = <0 0xf6301000 0 0x200000>;
-			no-map;
-
-			qcom,client-id = <1>;
-			qcom,vmid = <15>;
-		};
-	};
-
-	vreg_s4a_1p8: vreg-s4a-1p8 {
-		compatible = "regulator-fixed";
-		regulator-name = "vreg_s4a_1p8";
-
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		regulator-always-on;
-	};
-};
-
-&adsp_pas {
-	status = "okay";
-	firmware-name = "qcom/sdm845/beryllium/adsp.mbn";
-};
-
-&apps_rsc {
-	pm8998-rpmh-regulators {
-		compatible = "qcom,pm8998-rpmh-regulators";
-		qcom,pmic-id = "a";
-
-		vreg_l1a_0p875: ldo1 {
-			regulator-min-microvolt = <880000>;
-			regulator-max-microvolt = <880000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-
-		vreg_l5a_0p8: ldo5 {
-			regulator-min-microvolt = <800000>;
-			regulator-max-microvolt = <800000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-
-		vreg_l7a_1p8: ldo7 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-
-		vreg_l12a_1p8: ldo12 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-
-		vreg_l13a_2p95: ldo13 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <2960000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-
-		vreg_l14a_1p8: ldo14 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-boot-on;
-			regulator-always-on;
-		};
-
-		vreg_l17a_1p3: ldo17 {
-			regulator-min-microvolt = <1304000>;
-			regulator-max-microvolt = <1304000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-
-		vreg_l20a_2p95: ldo20 {
-			regulator-min-microvolt = <2960000>;
-			regulator-max-microvolt = <2968000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-
-		vreg_l21a_2p95: ldo21 {
-			regulator-min-microvolt = <2960000>;
-			regulator-max-microvolt = <2968000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-
-		vreg_l23a_3p3: ldo23 {
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3312000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-
-		vreg_l24a_3p075: ldo24 {
-			regulator-min-microvolt = <3088000>;
-			regulator-max-microvolt = <3088000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-
-		vreg_l25a_3p3: ldo25 {
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3312000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-
-		vreg_l26a_1p2: ldo26 {
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <1200000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-boot-on;
-		};
-	};
-};
-
-&cdsp_pas {
+&display_panel {
+	compatible = "tianma,fhd-video";
 	status = "okay";
-	firmware-name = "qcom/sdm845/beryllium/cdsp.mbn";
-};
-
-&dsi0 {
-	status = "okay";
-	vdda-supply = <&vreg_l26a_1p2>;
-
-	panel@0 {
-		compatible = "tianma,fhd-video";
-		reg = <0>;
-		vddio-supply = <&vreg_l14a_1p8>;
-		vddpos-supply = <&lab>;
-		vddneg-supply = <&ibb>;
-
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		backlight = <&pmi8998_wled>;
-		reset-gpios = <&tlmm 6 GPIO_ACTIVE_LOW>;
-
-		port {
-			tianma_nt36672a_in_0: endpoint {
-				remote-endpoint = <&dsi0_out>;
-			};
-		};
-	};
-};
-
-&dsi0_out {
-	remote-endpoint = <&tianma_nt36672a_in_0>;
-	data-lanes = <0 1 2 3>;
-};
-
-&dsi0_phy {
-	status = "okay";
-	vdds-supply = <&vreg_l1a_0p875>;
-};
-
-&gcc {
-	protected-clocks = <GCC_QSPI_CORE_CLK>,
-			   <GCC_QSPI_CORE_CLK_SRC>,
-			   <GCC_QSPI_CNOC_PERIPH_AHB_CLK>,
-			   <GCC_LPASS_Q6_AXI_CLK>,
-			   <GCC_LPASS_SWAY_CLK>;
-};
-
-&gmu {
-	status = "okay";
-};
-
-&gpu {
-	status = "okay";
-
-	zap-shader {
-		memory-region = <&gpu_mem>;
-		firmware-name = "qcom/sdm845/beryllium/a630_zap.mbn";
-	};
-};
-
-&ibb {
-	regulator-min-microvolt = <4600000>;
-	regulator-max-microvolt = <6000000>;
-	regulator-over-current-protection;
-	regulator-pull-down;
-	regulator-soft-start;
-	qcom,discharge-resistor-kohms = <300>;
-};
-
-&lab {
-	regulator-min-microvolt = <4600000>;
-	regulator-max-microvolt = <6000000>;
-	regulator-over-current-protection;
-	regulator-pull-down;
-	regulator-soft-start;
-};
-
-&mdss {
-	status = "okay";
-};
-
-&mss_pil {
-	status = "okay";
-	firmware-name = "qcom/sdm845/beryllium/mba.mbn", "qcom/sdm845/beryllium/modem.mbn";
-};
-
-&ipa {
-	status = "okay";
-	memory-region = <&ipa_fw_mem>;
-	firmware-name = "qcom/sdm845/beryllium/ipa_fws.mbn";
-};
-
-&pm8998_gpio {
-	vol_up_pin_a: vol-up-active {
-		pins = "gpio6";
-		function = "normal";
-		input-enable;
-		bias-pull-up;
-		qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
-	};
-};
-
-&pmi8998_wled {
-	status = "okay";
-	qcom,current-boost-limit = <970>;
-	qcom,ovp-millivolt = <29600>;
-	qcom,current-limit-microamp = <20000>;
-	qcom,num-strings = <2>;
-	qcom,switching-freq = <600>;
-	qcom,external-pfet;
-	qcom,cabc;
-};
-
-&pm8998_pon {
-	resin {
-		compatible = "qcom,pm8941-resin";
-		interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
-		debounce = <15625>;
-		bias-pull-up;
-		linux,code = <KEY_VOLUMEDOWN>;
-	};
-};
-
-/* QUAT I2S Uses 1 I2S SD Line for audio on TAS2559/60 amplifiers */
-&q6afedai {
-	qi2s@22 {
-		reg = <22>;
-		qcom,sd-lines = <0>;
-	};
-};
-
-&q6asmdai {
-	dai@0 {
-		reg = <0>;
-	};
-
-	dai@1 {
-		reg = <1>;
-	};
-
-	dai@2 {
-		reg = <2>;
-	};
-};
-
-&qupv3_id_0 {
-	status = "okay";
-};
-
-&sdhc_2 {
-	status = "okay";
-
-	pinctrl-names = "default";
-	pinctrl-0 = <&sdc2_default_state &sdc2_card_det_n>;
-
-	vmmc-supply = <&vreg_l21a_2p95>;
-	vqmmc-supply = <&vreg_l13a_2p95>;
-
-	bus-width = <4>;
-	cd-gpios = <&tlmm 126 GPIO_ACTIVE_HIGH>;
-};
-
-&sound {
-	compatible = "qcom,db845c-sndcard";
-	pinctrl-0 = <&quat_mi2s_active
-			&quat_mi2s_sd0_active>;
-	pinctrl-names = "default";
-	model = "Xiaomi Poco F1";
-	audio-routing =
-		"RX_BIAS", "MCLK",
-		"AMIC1", "MIC BIAS1",
-		"AMIC2", "MIC BIAS2",
-		"AMIC3", "MIC BIAS3";
-
-	mm1-dai-link {
-		link-name = "MultiMedia1";
-		cpu {
-			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA1>;
-		};
-	};
-
-	mm2-dai-link {
-		link-name = "MultiMedia2";
-		cpu {
-			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA2>;
-		};
-	};
-
-	mm3-dai-link {
-		link-name = "MultiMedia3";
-		cpu {
-			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA3>;
-		};
-	};
-
-	slim-dai-link {
-		link-name = "SLIM Playback";
-		cpu {
-			sound-dai = <&q6afedai SLIMBUS_0_RX>;
-		};
-
-		platform {
-			sound-dai = <&q6routing>;
-		};
-
-		codec {
-			sound-dai =  <&wcd9340 0>;
-		};
-	};
-
-	slimcap-dai-link {
-		link-name = "SLIM Capture";
-		cpu {
-			sound-dai = <&q6afedai SLIMBUS_0_TX>;
-		};
-
-		platform {
-			sound-dai = <&q6routing>;
-		};
-
-		codec {
-			sound-dai = <&wcd9340 1>;
-		};
-	};
-};
-
-&tlmm {
-	gpio-reserved-ranges = <0 4>, <81 4>;
-
-	sdc2_default_state: sdc2-default {
-		clk {
-			pins = "sdc2_clk";
-			bias-disable;
-			drive-strength = <16>;
-		};
-
-		cmd {
-			pins = "sdc2_cmd";
-			bias-pull-up;
-			drive-strength = <10>;
-		};
-
-		data {
-			pins = "sdc2_data";
-			bias-pull-up;
-			drive-strength = <10>;
-		};
-	};
-
-	sdc2_card_det_n: sd-card-det-n {
-		pins = "gpio126";
-		function = "gpio";
-		bias-pull-up;
-	};
-
-	wcd_intr_default: wcd_intr_default {
-		pins = <54>;
-		function = "gpio";
-
-		input-enable;
-		bias-pull-down;
-		drive-strength = <2>;
-	};
-};
-
-&uart6 {
-	status = "okay";
-
-	bluetooth {
-		compatible = "qcom,wcn3990-bt";
-
-		vddio-supply = <&vreg_s4a_1p8>;
-		vddxo-supply = <&vreg_l7a_1p8>;
-		vddrf-supply = <&vreg_l17a_1p3>;
-		vddch0-supply = <&vreg_l25a_3p3>;
-		max-speed = <3200000>;
-	};
-};
-
-&ufs_mem_hc {
-	status = "okay";
-
-	reset-gpios = <&tlmm 150 GPIO_ACTIVE_LOW>;
-
-	vcc-supply = <&vreg_l20a_2p95>;
-	vcc-max-microamp = <800000>;
-};
-
-&ufs_mem_phy {
-	status = "okay";
-
-	vdda-phy-supply = <&vreg_l1a_0p875>;
-	vdda-pll-supply = <&vreg_l26a_1p2>;
-};
-
-&usb_1 {
-	status = "okay";
-};
-
-&usb_1_dwc3 {
-	dr_mode = "peripheral";
-};
-
-&usb_1_hsphy {
-	status = "okay";
-
-	vdd-supply = <&vreg_l1a_0p875>;
-	vdda-pll-supply = <&vreg_l12a_1p8>;
-	vdda-phy-dpdm-supply = <&vreg_l24a_3p075>;
-
-	qcom,imp-res-offset-value = <8>;
-	qcom,hstx-trim-value = <QUSB2_V2_HSTX_TRIM_21_6_MA>;
-	qcom,preemphasis-level = <QUSB2_V2_PREEMPHASIS_5_PERCENT>;
-	qcom,preemphasis-width = <QUSB2_V2_PREEMPHASIS_WIDTH_HALF_BIT>;
-};
-
-&usb_1_qmpphy {
-	status = "okay";
-
-	vdda-phy-supply = <&vreg_l26a_1p2>;
-	vdda-pll-supply = <&vreg_l1a_0p875>;
-};
-
-&venus {
-	status = "okay";
-	firmware-name = "qcom/sdm845/beryllium/venus.mbn";
-};
-
-&wcd9340{
-	pinctrl-0 = <&wcd_intr_default>;
-	pinctrl-names = "default";
-	clock-names = "extclk";
-	clocks = <&rpmhcc RPMH_LN_BB_CLK2>;
-	reset-gpios = <&tlmm 64 0>;
-	vdd-buck-supply = <&vreg_s4a_1p8>;
-	vdd-buck-sido-supply = <&vreg_s4a_1p8>;
-	vdd-tx-supply = <&vreg_s4a_1p8>;
-	vdd-rx-supply = <&vreg_s4a_1p8>;
-	vdd-io-supply = <&vreg_s4a_1p8>;
-	qcom,micbias1-microvolt = <2700000>;
-	qcom,micbias2-microvolt = <1800000>;
-	qcom,micbias3-microvolt = <2700000>;
-	qcom,micbias4-microvolt = <2700000>;
-};
-
-&wifi {
-	status = "okay";
-
-	vdd-0.8-cx-mx-supply = <&vreg_l5a_0p8>;
-	vdd-1.8-xo-supply = <&vreg_l7a_1p8>;
-	vdd-1.3-rfa-supply = <&vreg_l17a_1p3>;
-	vdd-3.3-ch0-supply = <&vreg_l25a_3p3>;
-	vdd-3.3-ch1-supply = <&vreg_l23a_3p3>;
-};
-
-/* PINCTRL - additions to nodes defined in sdm845.dtsi */
-
-&qup_uart6_default {
-	pinmux {
-		pins = "gpio45", "gpio46", "gpio47", "gpio48";
-		function = "qup6";
-	};
-
-	cts {
-		pins = "gpio45";
-		bias-disable;
-	};
-
-	rts-tx {
-		pins = "gpio46", "gpio47";
-		drive-strength = <2>;
-		bias-disable;
-	};
-
-	rx {
-		pins = "gpio48";
-		bias-pull-up;
-	};
 };
-- 
2.37.1

