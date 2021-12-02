Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA6914664F5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 15:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358446AbhLBOTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 09:19:16 -0500
Received: from mail-eopbgr20071.outbound.protection.outlook.com ([40.107.2.71]:13287
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1358436AbhLBOTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 09:19:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QAE2Kj3PsUxIm8P7wiBOebz7d7ovCYYCXAFpGzSICmoCzcgT+Vm2E9x2PsL87/pjaICv7NAF5t+tmmSF8f1RASXzYyPdFbehbkMUGY5f5jr4ZPTSUodnwdBzN/yJl/0tus8WYc7S4r/jNdMGqL9Ojep1oXH7KomOJIsx2qs47JlK93fp9jfb4VHfCleYxDe+g/OhU7QpXGcmJtaharIVqFmOJ1SaSEcbQC95c31XZAbLinx9DDjhgskmU+if0BjFj1EpuBaMz6cXsRHKneMcR3TCBhuL684nzQJWHEw5IrUjPJJO2eYHtoXymDud17xc2WXidcLJlj7xYz6jIv2EVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTkdhSHKlGsHprxaXxsJym+K4u9Eu2L/U1W8gLJQAdI=;
 b=R0SOGPUr5I7pvcpf7mljvpgezQ75Z+iTou2RWws5B2KYumSic4I4ZbYqBE2SisKlg+EGDni22O0L0S/v5OS+6UrNnmcqWit5lN0ywj2d3jUXoZv8MjoKrjBIR7+ute0EK6Ngut7znK6wQld1mT49BMjrHKC5UQTNTZxBr/wWsVpOxGub9/mTa0OtARrkUlnddvkAekpHBOVbXNDTotHtDQmL9v5oJbgFE+uZN3hVhvXUfm6KwBdcuXxnSMXVicsVfskpTLKNxQfeB1cBbUPqY1rKG28Ug1iIAKkWquRKHC7ZmlwA/UDo3UoD7csTXjFhkMgY8lq41UPrLisETUJR4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTkdhSHKlGsHprxaXxsJym+K4u9Eu2L/U1W8gLJQAdI=;
 b=IwKtSCnYi0K+p6vd3cOR26zNjfq8EHhkw01Z3UlH3HUf6QqbYc5k1U2KgHd6/JEvPl8NDQ74hOj5KDaahNS1TOZ7zTbPNkqkf9aGGCDA2f71q6TCEKOsom3ESFYREVUmDQF8uokU/GCn9c6/6HqiIhbbh/SCxyH+ysJa1QNNS6s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by VI1PR0402MB3838.eurprd04.prod.outlook.com (2603:10a6:803:20::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Thu, 2 Dec
 2021 14:15:49 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::796e:38c:5706:b802]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::796e:38c:5706:b802%3]) with mapi id 15.20.4755.016; Thu, 2 Dec 2021
 14:15:49 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, Michael Walle <michael@walle.cc>
Subject: [PATCH 0/4] NXP LS1028A-RDB preparation for device tree sync with U-Boot
Date:   Thu,  2 Dec 2021 16:15:24 +0200
Message-Id: <20211202141528.2450169-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0110.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::15) To VI1PR04MB5136.eurprd04.prod.outlook.com
 (2603:10a6:803:55::19)
MIME-Version: 1.0
Received: from localhost.localdomain (188.25.173.50) by AM0PR01CA0110.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend Transport; Thu, 2 Dec 2021 14:15:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15daaace-aeb2-4bb4-0dc7-08d9b59e3d76
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3838:
X-Microsoft-Antispam-PRVS: <VI1PR0402MB38386AD37F8C9C18D2E5F3FEE0699@VI1PR0402MB3838.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z+E3uVEKdeWQ7Q1k45jVZSPOcC0VLPRkg5NlvOMYgXCpTfv5biW1lIB+ueyFIuMVA1kyYNAl5dUTausMlf1CwNJ32En/7XSPLQOf28UFP48pLeuW7k1+iCZA33Ko9ridhfgZ46jYkg8ELkPnKx4FPqZvevUiGKHbhe/9pVRcIm0N6RR2W/lG+qUaJnmU8BiYwJW2HFiUwp+4AYStzjZixj8TLW+VFQGJ25z7nhhHoPrT0rahPz/Vsu4PxsnHYRWELKtDFh03ajYnnigNTouPlFzupcCSfsqQ4Rs4NUFZ1iKmHsWdcYzDZTPPnHL3T15oJZEYO3IloGbmSy0cM8p2oyRPrVTPDymkGyd674qwjN8mrOI9QgbQsl+2x2Fk8KBApYZ8BupTVOqUjbh+o0A0BXDa5GeEJaGh5prhhRn1ewUHuDHDKrc8HctPkbDBuo+nlL0QjFgjg8LpD5e7jwqFBWNz+mr6lK9IkHxWIvgQR/d48qQZZ8s0U7OeL4lwBDNmAhdKuzvY2z8gHCCX584KXh/8WXd+hB8YRrnYzXZDULdGOuLxGFEFw0tahL+YRyWVMwaQmtpR4fiis0j1340rXGqv3ZasVGr4F79C5Y4LNtSeh0XmdHcnqyNqGPaqa9dwt02VsOWCKEyD5fkWn2mVXYNjSeXLgSzUIP5Bh0b1t/3IpBw+5d6qjt4E/pBYOQlqNWPdNXSrHqC4BUcUIJBOGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(86362001)(1076003)(6506007)(4744005)(38350700002)(6486002)(44832011)(83380400001)(6666004)(186003)(66946007)(52116002)(956004)(316002)(26005)(508600001)(8676002)(36756003)(6512007)(5660300002)(54906003)(38100700002)(2906002)(66476007)(2616005)(8936002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PBb31l2MPZoO2yUN6Fw85rpOUsKhNZ9Db6CN0YrUsAYus686QTBpEAx9VWBH?=
 =?us-ascii?Q?qy9l+VAhmfQgSrt8ZbwRwrfh2GApe9XuIn97RiJLIxFuB/8pOkQ+myQdVAlk?=
 =?us-ascii?Q?qTuTLb5UWrun0CZPpSn3CzQ1f9BehS59BGDOADu/d29tvLKCAju87PnRRRqh?=
 =?us-ascii?Q?M6xLvAcvived2QNKtGSikfRu6G3FKFESsskpLNgM5+ArikhMT+0p96ie33s8?=
 =?us-ascii?Q?GEXH7x8ID63OlZFL4T2scefprxyBtQJp9WZ5WNXBgc48yWu5GAe6DcGP4mS9?=
 =?us-ascii?Q?Rt5WY7GoET45PiRdzOZgMQOQzwwsoa22ieG1oY/aNf6CcfUtFGtvf67MgvM4?=
 =?us-ascii?Q?67iNiwHTODj1cjc2mktXKfQ3zqP05Fz+YottbefPwu9w4fdQHN0NutSiMmed?=
 =?us-ascii?Q?GGiw27Ihnv686CPYeUSzlfbvZ2mrXXRVUaZY5TMhhvpU7qISyEbjdrw2q+5p?=
 =?us-ascii?Q?pgVp9OtqT/tzOYNuGQ2k4X0w7nVQMRO1C9aaOOqQH7NSTalhnvbQFj2f1Lf2?=
 =?us-ascii?Q?vFjqc2cDgZFbL7iDvOOHv9qDTx7Iy3wJpxXk53q1WCYZZEEFlA0fQvZpNpiU?=
 =?us-ascii?Q?RpB4fzl5Q/PBsCvim3oW8Il1CdZ0JHg8ecVrv2DiwLZqCku2Ja4CdkmoE0SM?=
 =?us-ascii?Q?Lra2Y2edRcNPuK10QfwkLn7xPNMHnRUYfhhES6dwuP0VBOufDYEMXe1e/ouF?=
 =?us-ascii?Q?FaujqbKpaY/ofLStsE5PzcD99OR1Ph37E0xGw3OYnIcMq/FJNVpVaB/Z2X+Q?=
 =?us-ascii?Q?9NVUTmjizdZm429vctMXDwjXOTeNype5yNTDsIZC1ddY5xN09v2siSSokxQR?=
 =?us-ascii?Q?KdDbCEA1UgJJwEmtKyiyVT+DAj2O6Pf5T4fo2Sl30/LonRklT2Jex8NXFbjQ?=
 =?us-ascii?Q?rK2BZrN0PXBI/nt/cqJVsUnoERl1mxyOxcP6A1iCw6cYJ+IEDUeiMHF7B0U+?=
 =?us-ascii?Q?6+7MW8Vuc7p3pK4LjIimHtfhipQx2BP/fux5cw3ownnvLAfXp0HcSknmiduQ?=
 =?us-ascii?Q?x2nfF1N7wZbCyjglXHPA9vVYknRf1jqQqT/umJMmZdR2imhg4g9CB6gLRWVD?=
 =?us-ascii?Q?MS+MIuiBvf+ozr4ojSBgjpIXGrdRmMjRlAMGo6jA+PjB2Z1rQK6kRj+OFQEu?=
 =?us-ascii?Q?p7kR0TUKewIpItOV1ynsmaU/izqvLEyamboHr4YExwPy99o27E8CvnIdkdu7?=
 =?us-ascii?Q?AuSjFoKafi8LUsGEZEyAtyKHkX3N+Yd5UZRcuf9vqu99EvIl6NZOAkDHoodF?=
 =?us-ascii?Q?SlmTmlL+6MUSvMI49Fns8lLS/dR83laflauM5eYLIhXaBHjTocWkOKrKCOlu?=
 =?us-ascii?Q?BbVnXCIQ6V0hdnYaRL1Qcjw+68gzOHkqS9O+NvnKXsrH48Od0LOSV3RQ00PH?=
 =?us-ascii?Q?3GGk9EfeP4HioLpjDcflW5Ld4Q2uBea73Qm/ScPsy6HtVwp2LQK3WE93b8GT?=
 =?us-ascii?Q?nNQIQRYJE0/pcZRNAQyhcw4Uo1YeI369VFtjfgYXJdzBIomwilWd7LMKFSaz?=
 =?us-ascii?Q?2zzbPsSD69zu56PHl5sUa8paTXsZsYxOdVtM+SiEgZoujxsAj//U92FfLAML?=
 =?us-ascii?Q?IUPvkDAZBiaP/LCIsHcjES6BJ4ejr7IGSoMQK1CoUy+q0f1m0omOmZHcA6tY?=
 =?us-ascii?Q?+nWbknIbEbpbdF+t2y5kFg4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15daaace-aeb2-4bb4-0dc7-08d9b59e3d76
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 14:15:49.2899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SDQ35eNqmrfYzYol0d/Ek47Y5/LT6ejY5/i6E5Y4fOqdtJZlAlcXwPaeZKyCTi+MD6iAQ0ffLeFV8ceRDtmloA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3838
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An effort was started for the NXP LS1028A to share device trees between
Linux and U-Boot, and so far the common SoC dtsi is shared, but
individual boards still aren't. This patch makes some minor changes to
the Linux device tree so the DT for the reference design board can be
successfully shared with U-Boot.

Vladimir Oltean (4):
  arm64: dts: ls1028a-rdb: sort nodes alphabetically by label
  arm64: dts: ls1028a-rdb: add an alias for the FlexSPI controller
  arm64: dts: ls1028a-rdb: add aliases for the Ethernet ports
  arm64: dts: ls1028a-rdb: update copyright

 .../boot/dts/freescale/fsl-ls1028a-rdb.dts    | 93 ++++++++++---------
 1 file changed, 50 insertions(+), 43 deletions(-)

-- 
2.25.1

