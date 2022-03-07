Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD66D4CF4B3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 10:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236538AbiCGJVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 04:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236460AbiCGJUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 04:20:49 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2055.outbound.protection.outlook.com [40.107.215.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D4451E54;
        Mon,  7 Mar 2022 01:19:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVL2LfXzNCscxgGd0QyNQHwGAWFFJaTW/WGv7q/ToF7m4QsJ/yxTuRmmvdFDf9Bikm0x3nn02+6TkY8ovsEZBdB7Xr3b/BAQMLzp+xEont/iKgv6n2Pkn9kplURMlZZBF5KZUseiVpIkBYdSSNwtcWvNtf6LFHZWkdsBVI/iD82QcMQsN5bICf4YNf/CoPS/CtchGDuz3sGu6C0ucOjd/3ZC55dFdzD6pdV4pnvNj9pnnPPvs6x4TsO2wUlfIrJafjDSfBJoAalQGqS1Aw46eK05q0kNy/KywGulTxtLa1+slihYtq3PgDKod9U1qGKO4PQdGysSeqfGCVdXSC/udA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xk3fR0QObBpshHKCt59VGxdksnb+mElR9kwWjUsMm6Y=;
 b=HnVFljWGWhXtHDwakS/jJrUWfATHKEDLzoGBD1a6zZDuPtdvhwKxy9wcdracnzSeMdzZFZIEW+FzmCDsLpcjh2RpBQ3owL1KmqhHzviXTgo/6pR51QpFQeMpJ8D2Zad9H1QOhdex7Is3o9eTYxnFFHr+tnzw7H6CA/CwFfDGssZBqDYiBfke5+ZsEvu2031MBv81gJDCL5O0euMxHSP6GwFGelPv64PjdJDYTjIXTjS/Dp9bmbFY1QU+NfqPKvp2oGmnb7ONoRpvS94cKl45WP4SZA0d0H/f/5I/YTJ1mv4ZqgbEIBgRsPQh+c8W1ZBTYQtD7ls5wuS7jCpuaOgu4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nuvoton.com; dmarc=pass action=none header.from=nuvoton.com;
 dkim=pass header.d=nuvoton.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xk3fR0QObBpshHKCt59VGxdksnb+mElR9kwWjUsMm6Y=;
 b=s9IDvTBem2qd5ExSQf2hbhRMrBsW22db0G/5fJXgKJyK7l3FPZNXXmABNm6mKl99xpQbAdpLLJxJ4KzSpjbS6RfVF5uCF1KLNJdmMJj0R4lUooGAotuQThNwSd+x63g7+34em/so80HJZ/XxESfgniisPMTwpBoXkB/CqJX4kSM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nuvoton.com;
Received: from HK0PR03MB4833.apcprd03.prod.outlook.com (2603:1096:203:b1::19)
 by KL1PR03MB4646.apcprd03.prod.outlook.com (2603:1096:820:1c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.8; Mon, 7 Mar
 2022 09:19:39 +0000
Received: from HK0PR03MB4833.apcprd03.prod.outlook.com
 ([fe80::39bb:b24a:15ed:811e]) by HK0PR03MB4833.apcprd03.prod.outlook.com
 ([fe80::39bb:b24a:15ed:811e%3]) with mapi id 15.20.5061.017; Mon, 7 Mar 2022
 09:19:39 +0000
From:   Jacky Huang <ychuang3@nuvoton.com>
To:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        arnd@arndb.de, olof@lixom.net
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH 2/3] dt-bindings: clock: Document MA35D1 clock controller bindings
Date:   Mon,  7 Mar 2022 17:19:22 +0800
Message-Id: <20220307091923.9909-3-ychuang3@nuvoton.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220307091923.9909-1-ychuang3@nuvoton.com>
References: <20220307091923.9909-1-ychuang3@nuvoton.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0079.apcprd04.prod.outlook.com
 (2603:1096:202:15::23) To HK0PR03MB4833.apcprd03.prod.outlook.com
 (2603:1096:203:b1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 039c6d3f-0226-480d-837d-08da001b9b50
X-MS-TrafficTypeDiagnostic: KL1PR03MB4646:EE_
X-Microsoft-Antispam-PRVS: <KL1PR03MB46466DD4C7F2FD0C6D8443DA9E089@KL1PR03MB4646.apcprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mEWJSdFXvOhqtT4fkkBiXE+elOOLHRVxF+HuVTQApfpuBtlxOyLZBIoPLJ3IunZqtPYztQdpBG2CUQtQhhOe7VU/pLJDMEoyAqJaXec1FlPQd6gsyhB7tzTVLwgHhoo4ZSS/4mDOtDN35n0mB6OV/yOKZnj1TkqR+bKYyfrXmIvXYOWXd7l57me7bZ/PcXQ/pf6Udd7Clh9K/lctKRPlLQ0V97GWI465HHnfjegJF9XK0esgDZGuFPs3GjRC4jlKDGWzHfJqPPPTia2o1DeJGRij+9tZHhfmg63g0x3Q7PWddoVbs9eNZb2Qv84QExJMUMmfye69UGWQ2IY68suY3tWgCDihFPyAfPTuEvbieT03dM07tlEVZ2KFLoQyGgW5wrMYzXvj1yZvuWxtIpgfxiW5jxH8wwtWiKT0akH+qJ1AUro9lHIAgVH9KM39M3uFULvyqzo2U7rKUqDeZXX3XV8lN8Xd1gT1slUwSfW0SHh+lAnYXwuAk1JuYbsE2J3MHF9Hv7wBSkACUnw+mFXPNuXURn1CG83ebJ9e+kMS9MsWqT0syHg0r0fvqUGvpcxbf+cyfusk1zIDQPw53tGmqKOXQ31s2UijYqmoz2G8tmLvp5jyGjvjMzmeF9UTgUtPwb0cAiDDCRSKdrXsQ7V50Z8GENbVKkN119cKlhNE7Ev6KFjl5bJNtDImbGD8R1Dc7jjAGVSAlljqY/w1yQaAQNgmn+buocNUXqelYvXV3IKMc/AWXimjvQMlq5nX1TVAKhukfJQR/jGkizXI7Sse3ICE0dkk0fLhETKTrkOMJmg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR03MB4833.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(38100700002)(966005)(38350700002)(2616005)(1076003)(186003)(508600001)(5660300002)(8936002)(7416002)(2906002)(26005)(36756003)(6666004)(6512007)(6506007)(66556008)(66476007)(86362001)(8676002)(66946007)(4326008)(52116002)(107886003)(83380400001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uIMoNOifoVcMH1cXbcrOT2OVHCPKa6trFmJdnXtO3eOocRb5QZOPLT9Bgp+Q?=
 =?us-ascii?Q?9ErG0ID8gqvSu9m28Bm2d8BThk91iMlZrGpAq1vSUZZyqEXkLJW2+BboN31r?=
 =?us-ascii?Q?C2YbovwfC78ic408yXpWaLXE/Am5f9AKLvURNkyJglfjUN4meWtsCDahXlr7?=
 =?us-ascii?Q?ozNr8oOz/ocNPUFmQOxZqPbO6muk5BYZ0awHb4JRczMAY/AP75qhfQUFMGNL?=
 =?us-ascii?Q?il/raK69KTi8j8XCAbasmbEb9ATls6xAP0TesxRFEBkQXb8ivf6Vst9CwY7Q?=
 =?us-ascii?Q?3jJaOZ9cFjGRQK+04pz3PKmRlSlvk+cbIlEgB6OmHqXaVdySEGI4PclUzpPx?=
 =?us-ascii?Q?N4UGJ7ax/B7Hzp+rg7esC+BVR8J2/FBt5a+HPmf2sH0QbRYvbUxXVzgVHIZ+?=
 =?us-ascii?Q?srvtfAzFJhszNuUuErlh8Z30XmqOItBJveFrKR497Nl0QH4sl7sRHYBq1u5r?=
 =?us-ascii?Q?LOBnQVgMSpA2F5cEYqny5x3+MAu7bnD4KZx8WuhIP5zNqAA0YZgHvdz4otrY?=
 =?us-ascii?Q?j856QDNQrIV1thJt77YgGHAUIH3ByEZWkgAfuBoaM9DmUSzMMqPlW8/rj06B?=
 =?us-ascii?Q?lLWjB+QLUbgxsWZAWBCakDntfo61Ja4PsjnNzzagvut+W3kmJSZhUrDojomX?=
 =?us-ascii?Q?XSFtZQ4DH10sMyhbNPbtZmu2spByaGW8COSDvf/PRrhS9ePqQcUHEOYvy86B?=
 =?us-ascii?Q?ONURbxw8JoqW8hO8/nm8g+8yG+1wucvOtW5Xz0ak59N+Dh3Yn/cBplsT5810?=
 =?us-ascii?Q?Vj6nFV7qZLrev43GIjtixGGgFUQLRQvIm+nZBTFzLLZJ7/glIgwdiU9nSKaj?=
 =?us-ascii?Q?J5C1pC7MEfxWeEmsQOptif1uDiUnnagMx6eg50Ln5Qdaal7csvY2Grvg6o2d?=
 =?us-ascii?Q?zAqL+o+VUI6QtRbZ8GWA3EQABvOTFiPsKPczpNFQUCRxmRy+U1ISWz8Se55e?=
 =?us-ascii?Q?5LKqu+FDYyscpNIsM50B/iNdGPjNQlHJTOJy/vj7wVymq3Ysyi+Bb8f5h1WR?=
 =?us-ascii?Q?RWYTdhZZAkJtG1ukLw+kp4hx1zeW3ZS7U3z0S1OvxKUdOrXbwBOtWyUWKf/9?=
 =?us-ascii?Q?sAu1vwR1pZmhiUQdFwVYZ8s9ixHf96Nvp1nC1Zghlo08gz045sltEFibX/NH?=
 =?us-ascii?Q?9FWADAzu93DHaLjPxti+Ps+1t1EtC3mJbI7DxJQE+PIlUJHDi8WPu9pRgGl9?=
 =?us-ascii?Q?OKKaDHOpfXQI7iymIjvt3VDVXCZ48kRqXqR0QvFBNQhB9fOY1/HLjfK8D0W2?=
 =?us-ascii?Q?43zYrpkLXa5fYcJpMyEVK1u4VcvxaKwrsKMzMkOa5wXN3KxYWbObm+4ywCQf?=
 =?us-ascii?Q?xALDhgs8b/E/BJEUxi+Fs9oP1S7enN5wMCKy3/OmW+9VIUMofO3e1KvAqycL?=
 =?us-ascii?Q?Sf6C0Y3FOclts6Q01FoMdReC8UsCHECSIG/iIXkDR+TEIxXGbR4w7pEizu9p?=
 =?us-ascii?Q?aPzNjer2cowQtx3n6j2c+CdsmJOb1/K8ikKoeUdHEXixlwtvHlgESQ=3D=3D?=
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 039c6d3f-0226-480d-837d-08da001b9b50
X-MS-Exchange-CrossTenant-AuthSource: HK0PR03MB4833.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 09:19:39.7302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TyKpAPAjGbKnor7uU8wkqSJzQE8ChiQYE2U/UUJ0UDNdUmICBTFTpqRcavI1zZe0QTNVZUIJw6h6A4Jfeo2zIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB4646
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation to describe Nuvoton MA35D1 clock driver bindings.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
---
 .../bindings/clock/nuvoton,ma35d1-clk.yaml    | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,ma35d1-=
clk.yaml

diff --git a/Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yam=
l b/Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml
new file mode 100644
index 000000000000..f08b6f29bdcf
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/nuvoton,ma35d1-clk.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton MA35D1 Clock Control Module Binding
+
+maintainers:
+  - Chi-Fang Li <cfli0@nuvoton.com>
+  - Jacky Huang <ychuang3@nuvoton.com>
+
+description: |
+  The MA35D1 clock controller generates clocks for the whole chip,
+  including system clocks and all peripheral clocks.
+
+  See also:
+    dt-bindings/clock/ma35d1-clk.h
+
+properties:
+  compatible:
+    const: nuvoton,ma35d1-clk
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+  assigned-clocks:
+    maxItems: 4
+
+  assigned-clock-rates:
+    maxItems: 4
+
+  clock-pll-mode:
+    maxItems: 4
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+  - assigned-clocks
+  - assigned-clock-rates
+  - clock-pll-mode
+
+additionalProperties: false
+
+examples:
+  # clock control module node:
+  - |
+    clk: clock-controller@40460200 {
+        compatible =3D "nuvoton,ma35d1-clk";
+        reg =3D <0x00000000 0x40460200 0x0 0x100>;
+        #clock-cells =3D <1>;
+        assigned-clocks =3D <&clk DDRPLL>,
+                          <&clk APLL>,
+                          <&clk EPLL>,
+                          <&clk VPLL>;
+        assigned-clock-rates =3D <266000000>,
+                               <180000000>,
+                               <500000000>,
+                               <102000000>;
+        clock-pll-mode =3D <1>, <0>, <0>, <0>;
+    };
+...
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
