Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E7D4E21EE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 09:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345266AbiCUIRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 04:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345193AbiCUIRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 04:17:08 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2135.outbound.protection.outlook.com [40.107.243.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DBE1207E6;
        Mon, 21 Mar 2022 01:15:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jb8S+KqNQ1tFSUNbPvWaVtvwj4HdStgm9t0yz13VckDUufURgGizySFpA/AoVfETC/sZVh0BaZ0i1sXTHr2Md4JAVOKTjRoeAYWggphUHlqakl5h55ITiL8aGd1y5U7aaLfTi69aFBGzBtS+NdLXEeucdOnS6bySDB4WxxBCKDfLF22tCj0gs+b3dbGmmnH7NdaPIfjCPSKhpLWPruQFaendIroygnPo7RTVnhhrCws+FQ3OKQ5yJN60lz9xq26BE6/wFDP0K4j7A9x4g9XM7XgmYUa+mCLBMO7YIKZCvyN7nv72ql+Gx3pfR6/jS0iJvBrAEHO5MwT5euJpqq+Fxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRZKxQMlvGxYqJe7hFmCrVdwbvnVoMNuYxi76qf524A=;
 b=G388+wvsiSVbPSTRhjjruCMQ9A6etaEYPvujbPjRK0DaToMtYVU/9QNn24Y5cdBo6gY/HNNhEDFhj12Gzh1mDVUXZLNl5w0W35xuKhVR7oY5/xIl9jHp97z6KRR5w7RiHQONJn661hPQBqxUUKox4l8A8SvsKUpyRpqTyKN2Ifyjh0fo0S2gcQgiT5l0vhSBqGJnVVagn0hmtjxYabLqe5iSHE/eam5PJS1PX8AiikqShUDfuHvIRy/ZEQeR8nrUPiOkpATXFCYmGI0bvVvgTZ6erEDWEI4IARqpo748Wr0XPKH5d9jMu5ixOqqkiSkdaPLhOssJHs+4cdKgePfSiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRZKxQMlvGxYqJe7hFmCrVdwbvnVoMNuYxi76qf524A=;
 b=auK5RvKv4HDa1KBLSVaQUrm268LriURbnscz0BkahA0/6X4rYcNfFe9huPkzMnrt/ynPH200hXAK5w2LUL4ydCAIsz5Qh9TbguQElQkAOfJMDyxPw4DQQ9mWFNUVD0G1pC1pujCOcRqaf8WsdjMIOfaGbrM9NaeKKt0H5s+AfAY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ0PR01MB7282.prod.exchangelabs.com (2603:10b6:a03:3f2::24) by
 SN6PR01MB4112.prod.exchangelabs.com (2603:10b6:805:a6::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.21; Mon, 21 Mar 2022 08:15:11 +0000
Received: from SJ0PR01MB7282.prod.exchangelabs.com
 ([fe80::cd24:39ed:7042:46d6]) by SJ0PR01MB7282.prod.exchangelabs.com
 ([fe80::cd24:39ed:7042:46d6%8]) with mapi id 15.20.5081.022; Mon, 21 Mar 2022
 08:15:11 +0000
From:   Quan Nguyen <quan@os.amperecomputing.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Quan Nguyen <quan@os.amperecomputing.com>,
        Thu Nguyen <thu@os.amperecomputing.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        linux-kernel@vger.kernel.org (open list),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-hwmon@vger.kernel.org (open list:HARDWARE MONITORING),
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Cc:     Open Source Submission <patches@amperecomputing.com>,
        Phong Vo <phong@os.amperecomputing.com>,
        "Thang Q . Nguyen" <thang@os.amperecomputing.com>
Subject: [PATCH v7 7/9] dt-bindings: mfd: Add bindings for Ampere Altra SMPro MFD driver
Date:   Mon, 21 Mar 2022 15:13:53 +0700
Message-Id: <20220321081355.6802-8-quan@os.amperecomputing.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220321081355.6802-1-quan@os.amperecomputing.com>
References: <20220321081355.6802-1-quan@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::22)
 To SJ0PR01MB7282.prod.exchangelabs.com (2603:10b6:a03:3f2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04e1a142-5fbc-4ed4-eef7-08da0b12eb13
X-MS-TrafficTypeDiagnostic: SN6PR01MB4112:EE_
X-Microsoft-Antispam-PRVS: <SN6PR01MB4112991AA02EFAD314F48999F2169@SN6PR01MB4112.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zbz9S4F90MjNQIVlEsQ0PgzOwgtGC3OanWWNF7gfNCt46dxuS+yn/oloUIbZIRhJDSVyc5hQct948VuyNYbbKiWxz6Z8bG0MA+Iq6nR28Sh3MzwGXV1okEiuKUDYglnH/iOnhOKR1bKjK1J/5eywNVrSIsHSwq8cQLGXJHpGVHiq+WSWVGWaCGRiZYY7DhhffunQYlipNovzPAarxABuCL724TDt8s0xwqAidmpcd4UG0Vs1XZK4fybZVJtYp3b7n1tx98mOOIOGwtM8iAaZXOhwJU12vGGGDBTC2sIG08SKHgre4zL8kgQMc/iHV19QYHfS7wQH/OdlZ1kQnj7GnHD4OO2h+6+IWS4F9icfgZfXdIBL3t4pFNdXT9RfoFECez+meefJ5b1qFe6E4wUtENXvjZiEOG6MsTXwPVWJ6aXW0ynr3IKxCvEppe/c64TKeQ4QNg0x2ndR2zzyvSrB9php1GhjO93bpwo1YqqAVpzXEA5FfpDQy/TXbMoCf9clyzDNv1L6tHkngSW37a4rfVwHwzKOF4ZUTGWMVt6XT0Yd28qbQ5vKUS+9sWUCCm85Fqlqj+4BtNXhK7gxA1nA91MxcnJ/X3HE1N/6mqYmfYzXCe3vdGLuID4pxH7UgNdC14FlWcVnEcqlsju4Ddw44/z//krJX0X3S2vCHgMnNxU/AZV139lEcNrbIcw7GedZqv3hjJ/Uuj9/eTA0zg18J3ZWhE4jE9AhEaNEbB5QyCDl5XLuC0rtFeZo2ddmf6qmserI4D0vk+K0Yez7pgLHj5aytBsSWqTPNEhQFRBrkzGQqkxQs0NiPooUiYDPdLo1K/89rIntaQ8WhRIp8T0YCLjP8m7qUUzLrPnCDUdraCU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB7282.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(508600001)(966005)(2616005)(26005)(107886003)(86362001)(8936002)(186003)(2906002)(1076003)(52116002)(7416002)(6666004)(6512007)(6506007)(921005)(38350700002)(38100700002)(110136005)(83380400001)(8676002)(66946007)(316002)(4326008)(66556008)(66476007)(6486002)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jsZDriuzFkmEfFx/TD18MTJ9Wo4z30OQroS2//BR5l8G6FaIjbdZ57FMXS/y?=
 =?us-ascii?Q?yROb5wtbyTmdCC3zTEYA2VQWhevRdrYVYQKA1M6jJqIyE6LtQf79ExuwOULE?=
 =?us-ascii?Q?lqQ9eFa1uulErP0k1coqLbdtSz2U0YBFQ8J6lOoQf4RiqFEP/L/HMcBmabyk?=
 =?us-ascii?Q?nNdKpE1enEZFn793oO0GY6u/W9aU/SkhMs01BK5gjODljVBKNUxAdPyNfpsV?=
 =?us-ascii?Q?Nq9vsaunIF1uYuJMh+RyLSkpsKzPbVuHLA7ISF7jWknkv87sCqvpUBOF/zC+?=
 =?us-ascii?Q?KiSoVd2iSGx0Pg3eBlvIKlB6IppskNo+J8wetin6EnTvLXkvXsN9Q9zBgg54?=
 =?us-ascii?Q?M2UrP81SWEGumaTKTK4CqbUplvzcp85W6lNb1TbRNFBzExjY7XsRP0uc2X7f?=
 =?us-ascii?Q?CKNowk8diwXRLw2+apXKEuPj03P5ZOoZ7e8Vfk2fRDpJrtueWg5+cesKmXBh?=
 =?us-ascii?Q?u2mYPU0YqxwaDjK1PSH/BhFTZPavzI8d3L/iXIqI+CtlXUqkZMqhPE8N1Iv/?=
 =?us-ascii?Q?ionw7XRAsMHefRxVERDH4OTD576m/SUpuBB0QoMT89xteAIRe3cxyNkJQ0Dy?=
 =?us-ascii?Q?x3TrR0NLaQJfuMhB+oMRECdtRA1R3RQw8xXYsufMEfVc32+MLYCaYXr/AYjj?=
 =?us-ascii?Q?2RHhHv0bar+HzXWsZd79bCydW5dZ75/K9B4mA7zfvbgbB5o++dSu28pYJ3cQ?=
 =?us-ascii?Q?IeRx2uiy9XfvZwtvBYH0/BDBqrsLNicW4pR25PqthIb7O9eZI7t2wVBBxskj?=
 =?us-ascii?Q?uTZuDxvMqOQBtyChPlocvHXEbJ1NeVutdtiIb/iNkcnXRpeYcOOmQ7UywBaw?=
 =?us-ascii?Q?L0CKTM6jX4vgZV5sEYtkUWSzs7htixSJRwyZjafQzGhguGzORy4+xqpXydlv?=
 =?us-ascii?Q?zb9P8o/GLRwbCY78BoIgON8MRsZBMg84lueOOhlifvvrse+xNQE/M09WToDa?=
 =?us-ascii?Q?stxsNF2FBBnSQM5L8LhmqH+qziOkXz5fz1mhzXW1805NvvyyGRe0j4UjVyqN?=
 =?us-ascii?Q?/Zs3c4+5qAzsnrfb4+eo/PTpwLOwSS0/TP5oSOAd0q/gcbiIh7XbYmtaKOWF?=
 =?us-ascii?Q?ql45JS98xGW6EnunqRQJ+RvYNmQUKoS62CMKCE8/tScemnq3uCe1rGkBdF4u?=
 =?us-ascii?Q?ghmmCjQ0FUErz/0PAaw0LWm1bXgi+1i8tSBkkO+PQz3CYyJ5w/xSKd1GnVOp?=
 =?us-ascii?Q?TR25YrauJr0blWi/Qw+5uUCLSdHMhv26h23hWdVdHTdfDqu9qA82J01qwwBH?=
 =?us-ascii?Q?FvzmBQVilBKJ3CpmOMCqVg59/EESVqCFdG4n8B4++Bab9GdR+/JWzBZytLYF?=
 =?us-ascii?Q?NvpY0yksk+zLVqJ1RiWMobHhUxh6Lo/7BworDueKMGFX6/VUEWxFEqDuFpBA?=
 =?us-ascii?Q?gDPLSv9a8C5OIpm8WWgS4WWZsc5L7RHdLpveiC2AOk1YiimJbQMQbVXOlaQ1?=
 =?us-ascii?Q?Fn/JMb6a6UyszUBrq2/5kBzOLbaJ9hKLpUlfXBC9k98wxXo1v6J7sIGwzdwL?=
 =?us-ascii?Q?S7OsRhch3rlWBOw=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e1a142-5fbc-4ed4-eef7-08da0b12eb13
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB7282.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 08:15:11.0598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sVUZOg8lvYtCofeOQLOGF3h8u/ho2r5NGr382LPDXrAak03dCpe3rXhteKKzq1SVxKsJ5uJ5WljFP06lpSZanQhu7he3RhOF5NhVGaPqAWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR01MB4112
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds device tree bindings for SMPro MFD driver found on the Mt.Jade
hardware reference platform with Ampere's Altra Processor family.

The SMpro co-processor on Ampere Altra processor family is to monitor
and report various data included hwmon-related info, RAS errors, and
other miscellaneous information.

Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in v7:
  + None

Changes in v6:
  + None

 .../devicetree/bindings/mfd/ampere,smpro.yaml | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/ampere,smpro.yaml

diff --git a/Documentation/devicetree/bindings/mfd/ampere,smpro.yaml b/Documentation/devicetree/bindings/mfd/ampere,smpro.yaml
new file mode 100644
index 000000000000..c29d975c1bc3
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/ampere,smpro.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/ampere,smpro.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ampere Altra SMPro firmware driver
+
+maintainers:
+  - Quan Nguyen <quan@os.amperecomputing.com>
+
+description: |
+  Ampere Altra SMPro firmware may contain different blocks like hardware
+  monitoring, error monitoring and other miscellaneous features.
+
+properties:
+  compatible:
+    enum:
+      - ampere,smpro
+
+  reg:
+    description:
+      I2C device address.
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        smpro@4f {
+            compatible = "ampere,smpro";
+            reg = <0x4f>;
+        };
+    };
-- 
2.35.1

