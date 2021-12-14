Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC935473A41
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 02:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244671AbhLNBii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 20:38:38 -0500
Received: from mail-eopbgr60083.outbound.protection.outlook.com ([40.107.6.83]:44962
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237640AbhLNBii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 20:38:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7pDuHbvYRvrWDsVtVk2mKgS4lVARk8eLANtSDaTYF5gdCXJfKuIPVWcZCwo4TzRLasbsXytIdmiCXEfu36RVdYCCHl4yjkxPoY5wJNyVXJoplU6R1s+cMWaucdJN1AaknIJS7cQl5seql9SoYj+94RQLCDOoaTeuqwLzK4BQOhYOgEQfdznLpOkb4NLvoqA/c10s095HZrN0hWkGK5JlUvHWXMHZNyVVuvffnFCPNFa6mQfql2wtqXBcwNEU9zXGPtVS8yY4lgrqe5ekAs2XOnW/DE8eQg4TmV3j73vn0vmTO32q+vRYyIiLObUAmtChl21xOsFP87DZrHhKTPs2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+9vteoLJTHqYYHyJK3a4c5ARSKxjMg0isU2fI4YhRk=;
 b=W9RXbZ827VPfY8JZdseFgsNoAFKXVPAkqnjGuzjI0/+ofTH7gKV+pLF5iCXmQER5crVLsabKw8R9HmA0QL/Pgf4FA62RGp6/X8jb7mGxiFG2WMOupGfT8/FzGMwkeSWqXYHFfZx3zP4YA1oBt48GrHw4y9/tftQ/7QtVYRlx7ijXe5XKPeNa/HZBEfrYDVtZpUSIoGGgt8GjBzi+fHFvYv+9UytD5g3bAHpJBBjDrOpb5wozWUG9kM5aoTmBut5s/VW/Gw+mzfYBJoNdRct4YLnVLS1wb10ORaQ16gCkqcv7BCpjg2Rb5XCIqRjo4mZuCmB0+hOYEaoBn6BXhL/1Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+9vteoLJTHqYYHyJK3a4c5ARSKxjMg0isU2fI4YhRk=;
 b=pUxxixrBDdN9yy9Jw/T6QgSHQtz5+gTQWoO/8HOLk96gTKiXyESb3m2YP2PtMilEdjMTW+Eg1FV9dC62smaqnCKTPezJmxYH4r6WME9VUNEPL0FrSmDDnnwRgn5XUtCxal9JKpwYOgIA5ljwfUFbKqrN3UX6dfQhWh07asoI5vI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by VI1PR04MB6944.eurprd04.prod.outlook.com (2603:10a6:803:133::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Tue, 14 Dec
 2021 01:38:34 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::c84:1f0b:cc79:9226]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::c84:1f0b:cc79:9226%3]) with mapi id 15.20.4755.028; Tue, 14 Dec 2021
 01:38:34 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Biwen Li <biwen.li@nxp.com>,
        Zhiqiang Hou <Zhiqiang.Hou@nxp.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC PATCH devicetree 00/10] Do something about ls-extirq interrupt-map breakage
Date:   Tue, 14 Dec 2021 03:37:50 +0200
Message-Id: <20211214013800.2703568-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8PR04CA0168.eurprd04.prod.outlook.com
 (2603:10a6:20b:331::23) To VI1PR04MB5136.eurprd04.prod.outlook.com
 (2603:10a6:803:55::19)
MIME-Version: 1.0
Received: from localhost.localdomain (188.25.173.50) by AS8PR04CA0168.eurprd04.prod.outlook.com (2603:10a6:20b:331::23) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Tue, 14 Dec 2021 01:38:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e1164d1-69f3-40cd-522e-08d9bea2712d
X-MS-TrafficTypeDiagnostic: VI1PR04MB6944:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB694468151B858A92B22E7416E0759@VI1PR04MB6944.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:332;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4y4y3ZfD2HZh6gaEB1LFswtkiAw0Gb7jdgw+zxgIvlCqD3UyXXX5YmUQnm2GUTlQdcHuX4Tw4nw/LtNK5d59Aiv10HWFrieBuqu3APXiXcKKhToeBOs5C6wg62T/EAQ/fH2Dydvp58aS+b9Mz4bBcmOXQmX/tkkpDwhBSFvWo4yB8524Yj3XvEh5YHB9BPs+VvK1Zne3jx+FBqXatzBGYopRyY4T1xpVCSxfbPBJEoyekvjxdNVbAe/d0H36H7zLsByVT3YDKM+pZZMKjCsM052xoUJwglh/a3PVknShYF+uyHwP7ln2jh2jbPHzPzEnYy952XyPYPwVvaNhvkOUd7+rbIbRTIXunhrF2jhLREIDAzfYqQ7//Zq16oFDClQOKIowE1P9LGRJmevGX5n64rhtTH2AiaDIQP95BV5mMxnAANM4z1OKkMn0RmWfjotVeVz8j9pRhx47zvJEEpN1pX12ao42iVp3qSDFtBTgJzbCzROnbtkl7W0wjKbJ7MaR2MqRP/7TaUVid0Ls+yFQC5awNsS1lUJiGznik6BSYFBM+XiBCoqnoW2cFJIhsFRvKUODrML4f6giS9mTul77QCeqtv0qewOY7vm6njv5/lPJMexZdnPcRdlc9qZKf/UpuWfsS4Fvm5suvh5PPkLWen4WTDORKGd2v3X26GLPgV3tBunzZPnPyZ+XDRn7hJGNIPRojEV2ls5I0NwFP2kZ+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(1076003)(66556008)(956004)(54906003)(36756003)(8936002)(6506007)(2616005)(86362001)(508600001)(83380400001)(66476007)(66946007)(52116002)(316002)(6486002)(186003)(2906002)(4326008)(44832011)(38350700002)(6512007)(6666004)(38100700002)(26005)(5660300002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LULEWJLDnlD1Ew9JVmF6c8xjmvb2j0406joqT7+756X5xRG0xHRNnYBGdxxK?=
 =?us-ascii?Q?QzQnz0ihKZgrfnpN4XK3GaOLwEitoz1zE3IMFAecdgcwhH1UVIHkAZTFzHHU?=
 =?us-ascii?Q?VvxJSFwyedeFf6NIIPsufEr2VAw5eLND+ILkXdzegccjERCySgpvjbUzQnIt?=
 =?us-ascii?Q?pUrGG27ioWZaOrkOOUthw63mT+o/+e3y+lm3hpqDPXzwmzDSsUH8udbDPHPg?=
 =?us-ascii?Q?3gB8e1LJEB8iptGQNw6fps4K8SAKBBBQpRZOST1pDS3EEYF/kNpGuQQISE7Z?=
 =?us-ascii?Q?gX3KfUCTcWPpLTy4Sezz97+1Ql6qPDcAawfnHvMwUVJZnQO0SiavNnK8GdbZ?=
 =?us-ascii?Q?JmqG4C/M+k20PnHyZNAw8wGAGKP6A8X46hhRC7onudQ2MSF59M0mxSdhsuSx?=
 =?us-ascii?Q?UIG3mqUKH9tWnbFs8NwEyl+eh4ES/+eLCwVmZtcpSq8ETRQJL07Z3KqAGMsN?=
 =?us-ascii?Q?+9Dc3+pXmu87gTSB/4O2a8ieXJbDyGOdFGdOGbsr5EjkmIhTdXd0PJTkAIxh?=
 =?us-ascii?Q?AID+ygVYK3SbM9YF0P0aS7t6CUeBQsxXcwAtcdg3ITZI+HAAMTj/RoUrlGxW?=
 =?us-ascii?Q?JInAX3YVrOuqnDwOuxeIlsfjAXQ2fGqJvDvZapJnxr7RLj9KWRD1opX/reXD?=
 =?us-ascii?Q?xNh1JWfwaUoK4TO8duwEC40/y1TcZzkZ9ubbAV8KHo7yGc6FzCfxkFQqShim?=
 =?us-ascii?Q?VfY8ob7Q55RKX3q+5KbSdeIYLswYF9gAPwbL2s2gldBLU+piiWI4sC42b52M?=
 =?us-ascii?Q?dnI/eJJaSklFsdgri7TxnWfK56IszYfwovfhsyk4avXtt5p71WtIFIkEClPu?=
 =?us-ascii?Q?dNeR4zNeLzMj9GAUXr0D7KVrNpEByhuQsniivXdjWD3UQHhbm4oUPF/BZl6B?=
 =?us-ascii?Q?AMWsANLSaonSkRdELo19JR5xWJC1biXrBmUtQR5QcnUF2R0ZofRS3QRKMgDh?=
 =?us-ascii?Q?+NC5PQfHBQQ9PFJnj6PpoeKRy58jrmN7Vql1qAejbCP0jhWXbpnA5hmAiAXz?=
 =?us-ascii?Q?+lRGGx3jK2lBjJUSWi9ExD+XyRL8TVgjHNwPsk9hJOLjxT7fePkf7dJJLDBI?=
 =?us-ascii?Q?Zo1ttIz0Vz5dRqVkZ9FHOprAr3WALpvEHpthX3yYU2mYVAU9RrC7+NlEpIT+?=
 =?us-ascii?Q?JBrKyjjqPkjuGp7DX4KaVeHncNbZcyCdRSs5dPzg2MTl1upzmBLDVNjmNayg?=
 =?us-ascii?Q?tP9nQzaZf+nk02TraIHh5qoOmLv2PF0UfMC0ZDDA6ZvcWh7bs953G1D+qK5V?=
 =?us-ascii?Q?qlS7cr7FNg8aJGcT+4JDaeaxsJkoYK8udGSWW2/rNsaD5UWm4x7tRfY9j4xo?=
 =?us-ascii?Q?zRtBrck2q4672m8CMyH6w2nBHrJnTv0hUQ/mAVUiurk2JcOa08IKcN37+3hM?=
 =?us-ascii?Q?/mp+brRN49kEoX3avgaHFbdMftzN+eJmL3MiROXD0eDCDwSnU0WiqHfCvYTV?=
 =?us-ascii?Q?BGqYn/dCbXzMPvALUlFcLLbPiOPTXFMjcJcOeMv70RTbLWPqnERBwK3Bfr8G?=
 =?us-ascii?Q?8bMtxPf7amlt/X/FUxny7XgY/e0nUrVuJ5Vx82RipGj4SKmBMRMU/klATa0j?=
 =?us-ascii?Q?QJhp9qX2JPrM+9kMLmPgvsso/5gZSCTRSk2Pc3cnbKUoWo1JZ09MyQL0VwwB?=
 =?us-ascii?Q?nbhs/AxsuFgRg8kOQAY+qPo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e1164d1-69f3-40cd-522e-08d9bea2712d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 01:38:34.5379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GCXNuohKxkGJE6cA97NY4Q+fQ/1hogDXSpOnoId0ptpeuKrqqTSzd93ID87er6gnWZQUfP9dz7QhcO+AKopV+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6944
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the ls-extirq driver's use of the "interrupt-map" property is
double-broken:
- once by Rob Herring's commit 869f0ec048dc ("arm64: dts: freescale: Fix
  'interrupt-map' parent address cells")
- twice by Marc Zyngier's commit 041284181226 ("of/irq: Allow matching
  of an interrupt-map local to an interrupt controller"), later revised,
  not very elegantly, through commit de4adddcbcc2 ("of/irq: Add a quirk
  for controllers with their own definition of interrupt-map"). So this
  part works but we're on an offender list.

Mark suggests that the problem may lie with the ls-extirq driver, and
its interpretation of the "interrupt-map" property, to be exact.

This set of changes attempts to make the problem smaller by using a
vendor-specific name for the property, and reverts Rob's patch because
similarity with "interrupt-map" isn't actually a desirable feature after
all, it seems.

Vladimir Oltean (10):
  irqchip/ls-extirq: rename "interrupt-map" OF property to
    "fsl,extirq-map"
  Revert "arm64: dts: freescale: Fix 'interrupt-map' parent address
    cells"
  dt-bindings: ls-extirq: replace "interrupt-map" documentation with
    "fsl,extirq-map"
  arm64: dts: ls1043a: rename the "interrupt-map" of the extirq node to
    "fsl,extirq-map"
  arm64: dts: ls1046a: rename the "interrupt-map" of the extirq node to
    "fsl,extirq-map"
  arm64: dts: ls1088a: rename the "interrupt-map" of the extirq node to
    "fsl,extirq-map"
  arm64: dts: ls208xa: rename the "interrupt-map" of the extirq node to
    "fsl,extirq-map"
  arm64: dts: lx2160a: rename the "interrupt-map" of the extirq node to
    "fsl,extirq-map"
  ARM: dts: ls1021a: rename the "interrupt-map" of the extirq node to
    "fsl,extirq-map"
  dt-bindings: ls-extirq: add a YAML schema for the validator

 .../interrupt-controller/fsl,ls-extirq.txt    |  53 ---------
 .../interrupt-controller/fsl,ls-extirq.yaml   | 110 ++++++++++++++++++
 arch/arm/boot/dts/ls1021a.dtsi                |   3 +-
 .../arm64/boot/dts/freescale/fsl-ls1043a.dtsi |   3 +-
 .../arm64/boot/dts/freescale/fsl-ls1046a.dtsi |   3 +-
 .../arm64/boot/dts/freescale/fsl-ls1088a.dtsi |  27 +++--
 .../arm64/boot/dts/freescale/fsl-ls208xa.dtsi |  27 +++--
 .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi |  27 +++--
 drivers/irqchip/irq-ls-extirq.c               |  12 +-
 9 files changed, 161 insertions(+), 104 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml

-- 
2.25.1

