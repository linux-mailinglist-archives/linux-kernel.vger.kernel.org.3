Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8DD4CF4B6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 10:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236441AbiCGJVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 04:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236406AbiCGJUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 04:20:50 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2055.outbound.protection.outlook.com [40.107.215.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B849522C3;
        Mon,  7 Mar 2022 01:19:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kwh5Plf3eIQ9gs53ZERTk0TLNCR9Vd6KS1ITHC2mj6G9AtBB8j7qR97dcKglPvvy4KCfNlCUHKg+Ye9yDpOvnuTo9j/xQpY4hlBj7vgQUZBImVF6iyKwZi/t0gBbScw/ZshzJ15MSrHF6cBNSw0+Q7iAr5wrOmTM1p/uADXFveo66LfWSauBo1/jY7K+BbBxFdtfnC91VmWU3MBJ37laX5lAVGUIuU25IrpbmTU912tHOsO+PBgiFrZMOR+BSzrRpk/xOED44oeuHtpuOKlqEGd0nklmxIg+dcbLNvJMGXEFS71V0jW/dsMdFL+yGC6v4D2mLThJfqiGMZU7KdL7rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjNjjnzCJMF2QjZTTKHEKWi2u+8FCf2NGgGvl5IlhIA=;
 b=K/U2rRlbhW8SgfTfu8+3uQ8xkYHfCZBsRJgk2DnwLvhesOX2C88L7Bo3Xa8z0C+WZV4s4ShvGdVxlXOJA+xz/tiJ1iwk4B13zZ7urahu9cVQcbT9rPe8bsO7N8Qj5U/X1IwZ0nCmHCKTaB9J804TBrLYV+77KV9UuRHIjLBefgH2MXjUDHjU4Rx06SFagcFN+pvuBkTwQgN6bId0BEDwttukoP3H4FwdY9c9bw2hBilwubtmlu2B4hTPK5V2l0eCXZTbOmpbg0NL4wEuKD/PQ2t5Pn/AfeGR6CRjtI93EVMmsNAkyiegExm7ES1Isd+UlFSN+AfiMGGYx77cKbqckQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nuvoton.com; dmarc=pass action=none header.from=nuvoton.com;
 dkim=pass header.d=nuvoton.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjNjjnzCJMF2QjZTTKHEKWi2u+8FCf2NGgGvl5IlhIA=;
 b=Csem5soSXU3IymIxtJfGl394wwyHsEdq9SbHCnVeogH/YwcUiHl/JO/udHsZXD1Bc3TW40TF4bQ5XcG5BLIwX2bUVQERxWM0xO+60frl1WN5RTUGdHjaGzVlVHpkOsWQyszmvi+HfBsKTWVFymeCs1h6ZdzxDBC/G5Uot7dTa7o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nuvoton.com;
Received: from HK0PR03MB4833.apcprd03.prod.outlook.com (2603:1096:203:b1::19)
 by KL1PR03MB4646.apcprd03.prod.outlook.com (2603:1096:820:1c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.8; Mon, 7 Mar
 2022 09:19:41 +0000
Received: from HK0PR03MB4833.apcprd03.prod.outlook.com
 ([fe80::39bb:b24a:15ed:811e]) by HK0PR03MB4833.apcprd03.prod.outlook.com
 ([fe80::39bb:b24a:15ed:811e%3]) with mapi id 15.20.5061.017; Mon, 7 Mar 2022
 09:19:41 +0000
From:   Jacky Huang <ychuang3@nuvoton.com>
To:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        arnd@arndb.de, olof@lixom.net
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH 3/3] arm64: dts: nuvoton: Add initial support for MA35D1
Date:   Mon,  7 Mar 2022 17:19:23 +0800
Message-Id: <20220307091923.9909-4-ychuang3@nuvoton.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220307091923.9909-1-ychuang3@nuvoton.com>
References: <20220307091923.9909-1-ychuang3@nuvoton.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0079.apcprd04.prod.outlook.com
 (2603:1096:202:15::23) To HK0PR03MB4833.apcprd03.prod.outlook.com
 (2603:1096:203:b1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98286bfb-2bc3-44a6-d1c8-08da001b9c88
X-MS-TrafficTypeDiagnostic: KL1PR03MB4646:EE_
X-Microsoft-Antispam-PRVS: <KL1PR03MB4646B43A5BE3938A798BECFC9E089@KL1PR03MB4646.apcprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LQtfbZ34joxcM6pQ++h7Ic+cqex3smPuO6BN5CXt2JkLUpFNK8iVkbhs6IorLQLm+R1ohl+U3hQX/TOnlUw3Ub5S8sAwr2/rQQ9dyEr6Oo2il+Dl/O2GLCQutsh7Uvy181/GYYJicHK/kjGQHfvz1HIj77Eb+RomVvdQC4Z/Kn3jsT4siu+46v9lVoG9FuQf4jBx/V/v+xe1K3W+Us5yG3JIQs6FTVciqVEuJHGovZvitTH5AtEj79E75i72A8M5QZm2/GD5xgLLEe9gog2Aw6SY72lgP5AqyQHqdvNcDBiHA0/waiaQT4K1zlURhIvq/rlvz+pvZ004f/o+uYBzlVqzYVrHD0w63OuiyPiRRcd0YEWzJo/kFLPF06ZzvA8vxjunlTDw/nbXqe9QR289SPrxUQfQgZCbbDIF3Eef4Wazo3sKLupNcjFF5j1/6aMHLGmxgkmp686ScmySt4qwpcPHp59wrgDuHFEA7s9O022UoN7LaMLoKTwmT/QgME1vcYmwa13z0ROehTJKA9mAIfWchHZH5bk4LHetUf2LBAExIwV/rC7klBSdfmQAgBCDTOiqgNvUAn9U8dYBiwUA474lr4VacEkwYayr1KMCO/2vdAjlCLqEeZukFooW3OIrjgT0a+HpyDYQfnQMEZIxbxv8/oHTNJ+uq/RUFtYB6e0QEyjllZq/IZfgW0/o7EXdcg4GwpLPVPoBVNYX1qqx0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR03MB4833.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(38100700002)(38350700002)(2616005)(1076003)(186003)(508600001)(5660300002)(8936002)(7416002)(2906002)(26005)(36756003)(6666004)(6512007)(6506007)(66556008)(66476007)(86362001)(8676002)(66946007)(4326008)(52116002)(107886003)(83380400001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XK2tvCUdKMK5w63kvgU7uOuGGAmY6kv1MkEZGbk9zIjYfAty9e91TBT3Uiao?=
 =?us-ascii?Q?NDuPjZp8vOPB2N3VTXlDC4wqeAI8pQ6131fEK7sDrqAby5GVgTVx+gPgs95s?=
 =?us-ascii?Q?S0uWQBDi7m6gy1SzbfwXqVI0IG4vAlwKVBoMAo7/iZNcS1pBRoSCLMBARj+v?=
 =?us-ascii?Q?C1QDXKfK9+zcJ978Kggvm8vyNt/1vymqKCwg3Qtk0O5PvvPjhjIgSZH6lGhK?=
 =?us-ascii?Q?dt7U1V74DiBVQitrIXaDYqa4Re6AAThtetQO2qAYVWbdPuSLewvEtexz5kpq?=
 =?us-ascii?Q?BiiSA9Hdb0+xeZ2aeO8bhqmNxtMwsliTu8CKyk+vVNMFA7YfBUxSmobRswI5?=
 =?us-ascii?Q?bdKOR0cQn4q1EDRqBNYJ4szB15pRQbWtSQ1c01yoV0rSSsQLGYKMEjskwCHc?=
 =?us-ascii?Q?patmkWz720eRz7ZBQHTv65m5CgwJUlJFllP0bhBUh0TWWcTpWRrKk8G5URso?=
 =?us-ascii?Q?U2CHtCnFH0nTgmc0Sne1erZJH2GDPWcH/raNhHUy2jYvwyKebWLz5tfXh8Zp?=
 =?us-ascii?Q?HSHWHnXXuUEhTX/qvATKEcqtjifBdEZSyNfBdcoiXiRMrCdE5l2272WjMboz?=
 =?us-ascii?Q?tTxcgqO7DeTEF3JE3HJe6m7duljn3WqoZC/i7KX4UdwYWPK5svaEsZ2uNcJj?=
 =?us-ascii?Q?pQ9U1Gl+XLOkNfraV601tjed8jM+nUFn5AMin3FwT86skMUawDNY1wAehRho?=
 =?us-ascii?Q?nqWjnZpaMxPzr/+JPGjnEObPomENhlUMz326kxbLaBVgBA2TrR1FNb3nDe3E?=
 =?us-ascii?Q?0qLMdULYHOEnL9XrDFHkLmraAwQl9aonV6SiXS6niRIbepvBpcqcH0eRuvs3?=
 =?us-ascii?Q?X9PDFELNqYg7JNHTaBuMx0z0jYPaPa6vkqAeVoVIYCxxc0fuyD8uXsuprdFw?=
 =?us-ascii?Q?dks8wsb5pU2vPZr69mbmvZt9T5Bnr193Y38H0qdqbsZhQhun1MFCpNiLNN/c?=
 =?us-ascii?Q?1bnOB59Qb9agNbBRQxOp5B15BoQv6dAJk2AePf9c9MVKpeypdnAjD4UX3GFI?=
 =?us-ascii?Q?nEisaFrX5xdiLDG2NFBkjpVbLXoqDLXe1YxwE9P+8/FrpGFPbNRUxETDNJCt?=
 =?us-ascii?Q?luUnsf/KTVSR/kdtMVqvJ7Tfbhx5Zv//35TSCHCq5EHRe87NKAZNid21MyEj?=
 =?us-ascii?Q?mlYATYwX8GJncAJl2aYZYEcgREBzV++g+L+wtam1umNK715XX5/cmpjpqtuH?=
 =?us-ascii?Q?G6NL6IQUJqI8Eaw9pqCU2VPT2qj/09CiwlX7sCPKrvyCEcN9cKzQtEEvXg+s?=
 =?us-ascii?Q?QzBWZr2gp0px0UiNtChJPdxLo2eLrEIQqJ+bDf/KGpztD9AV9IdRVI1kygvL?=
 =?us-ascii?Q?LAIOXaMeOeGIAn4zwubS15UhjzP0XQS1rubwmRfRZS/O7memIAPzAOUAQOOY?=
 =?us-ascii?Q?Fn4HNAQzIlvag/B6jK9haNkdhTK9UPUlrsDfWFKTXQJ2mc/8BHX13KXNH2VP?=
 =?us-ascii?Q?cyQANCK/W+qOtejaAmcqt124ck4dAVbg8EAU8dSedf4qEQU5231NiA=3D=3D?=
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98286bfb-2bc3-44a6-d1c8-08da001b9c88
X-MS-Exchange-CrossTenant-AuthSource: HK0PR03MB4833.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 09:19:41.7769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E2fkD9qL1Rt5lJn+gxvaGy/3/X2SbQCEVD3HNJB9y3CcLoFDMxgpSO7nzAUJWZfKtihKmB4o4tZpx5SrIzMRdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB4646
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the initial device tree files for Nuvoton MA35D1 Soc.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
---
 arch/arm64/boot/dts/Makefile               |   1 +
 arch/arm64/boot/dts/nuvoton/Makefile       |   2 +
 arch/arm64/boot/dts/nuvoton/ma35d1-evb.dts |  23 +++++
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi    | 106 +++++++++++++++++++++
 4 files changed, 132 insertions(+)
 create mode 100644 arch/arm64/boot/dts/nuvoton/Makefile
 create mode 100644 arch/arm64/boot/dts/nuvoton/ma35d1-evb.dts
 create mode 100644 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi

diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index 639e01a4d855..28e01442094f 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -30,3 +30,4 @@ subdir-y +=3D synaptics
 subdir-y +=3D ti
 subdir-y +=3D toshiba
 subdir-y +=3D xilinx
+subdir-y +=3D nuvoton
diff --git a/arch/arm64/boot/dts/nuvoton/Makefile b/arch/arm64/boot/dts/nuv=
oton/Makefile
new file mode 100644
index 000000000000..e1e0c466bf5e
--- /dev/null
+++ b/arch/arm64/boot/dts/nuvoton/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_NUVOTON) +=3D ma35d1-evb.dtb
diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1-evb.dts b/arch/arm64/boot/d=
ts/nuvoton/ma35d1-evb.dts
new file mode 100644
index 000000000000..38e4f734da0f
--- /dev/null
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1-evb.dts
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Device Tree Source for MA35D1 Evaluation Board (EVB)
+ *
+ * Copyright (C) 2021 Nuvoton Technology Corp.
+ */
+
+/dts-v1/;
+#include "ma35d1.dtsi"
+
+/ {
+       model =3D "Nuvoton MA35D1-EVB";
+
+       chosen {
+               bootargs =3D "console=3DttyS0,115200n8";
+       };
+
+       memory@80000000 {
+               device_type =3D "memory";
+               reg =3D <0x00000000 0x80000000 0 0x10000000>;
+       };
+};
+
diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi b/arch/arm64/boot/dts/=
nuvoton/ma35d1.dtsi
new file mode 100644
index 000000000000..27adac4975c3
--- /dev/null
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2022 Nuvoton Technology Corp.
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
+
+/ {
+       compatible =3D "nuvoton,ma35d1";
+       interrupt-parent =3D <&gic>;
+       #address-cells =3D <2>;
+       #size-cells =3D <2>;
+
+       cpus {
+               #address-cells =3D <2>;
+               #size-cells =3D <0>;
+               cpu-map {
+                       cluster0 {
+                               core0 {
+                                       cpu =3D <&cpu0>;
+                               };
+                               core1 {
+                                       cpu =3D <&cpu1>;
+                               };
+                       };
+               };
+               cpu0: cpu@0 {
+                       device_type =3D "cpu";
+                       compatible =3D "arm,cortex-a35";
+                       reg =3D <0x0 0x0>;
+                       enable-method =3D "psci";
+                       next-level-cache =3D <&L2_0>;
+               };
+               cpu1: cpu@1 {
+                       device_type =3D "cpu";
+                       compatible =3D "arm,cortex-a35";
+                       reg =3D <0x0 0x1>;
+                       enable-method =3D "psci";
+                       next-level-cache =3D <&L2_0>;
+               };
+               L2_0: l2-cache0 {
+                       compatible =3D "cache";
+                       cache-level =3D <2>;
+               };
+       };
+
+       psci {
+               compatible =3D "arm,psci-0.2";
+               method =3D "smc";
+       };
+
+       timer {
+               compatible =3D "arm,armv8-timer";
+               interrupts =3D <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) |
+                                         IRQ_TYPE_LEVEL_LOW)>,
+                            <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) |
+                                         IRQ_TYPE_LEVEL_LOW)>,
+                            <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) |
+                                         IRQ_TYPE_LEVEL_LOW)>,
+                            <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) |
+                                         IRQ_TYPE_LEVEL_LOW)>;
+               clock-frequency =3D <12000000>;
+       };
+
+       sys: system-controller@40460000 {
+               compatible =3D "nuvoton,ma35d1-sys", "syscon", "simple-mfd"=
;
+               reg =3D <0x0 0x40460000 0x0 0x200>;
+       };
+
+       reset: reset-controller {
+               compatible =3D "nuvoton,ma35d1-reset";
+               nuvoton,ma35d1-sys =3D <&sys>;
+               #reset-cells =3D <1>;
+       };
+
+       clk: clock-controller@40460200 {
+               compatible =3D "nuvoton,ma35d1-clk";
+               reg =3D <0x00000000 0x40460200 0x0 0x100>;
+               #clock-cells =3D <1>;
+               assigned-clocks =3D <&clk DDRPLL>,
+                                 <&clk APLL>,
+                                 <&clk EPLL>,
+                                 <&clk VPLL>;
+               assigned-clock-rates =3D <266000000>,
+                                      <180000000>,
+                                      <500000000>,
+                                      <102000000>;
+               clock-pll-mode =3D <1>, <0>, <0>, <0>;
+       };
+
+       gic: interrupt-controller@50800000 {
+               compatible =3D "arm,gic-400";
+               #interrupt-cells =3D <3>;
+               interrupt-parent =3D <&gic>;
+               interrupt-controller;
+               reg =3D <0x0 0x50801000 0 0x1000>,
+                     <0x0 0x50802000 0 0x2000>,
+                     <0x0 0x50804000 0 0x2000>,
+                     <0x0 0x50806000 0 0x2000>;
+               interrupts =3D <GIC_PPI 9 (GIC_CPU_MASK_RAW(0x13) |
+                                        IRQ_TYPE_LEVEL_HIGH)>;
+       };
+};
--
2.17.1

________________________________
________________________________
 The privileged confidential information contained in this email is intende=
d for use only by the addressees as indicated by the original sender of thi=
s email. If you are not the addressee indicated in this email or are not re=
sponsible for delivery of the email to such a person, please kindly reply t=
o the sender indicating this fact and delete all copies of it from your com=
puter and network server immediately. Your cooperation is highly appreciate=
d. It is advised that any unauthorized use of confidential information of N=
uvoton is strictly prohibited; and any information in this email irrelevant=
 to the official business of Nuvoton shall be deemed as neither given nor e=
ndorsed by Nuvoton.
