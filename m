Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B74473A51
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 02:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244788AbhLNBi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 20:38:58 -0500
Received: from mail-eopbgr60083.outbound.protection.outlook.com ([40.107.6.83]:44962
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244717AbhLNBir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 20:38:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLc5KYkLun57eULzubROhRyo7clAkavXDDPQX8lMkGFSofKK8EeYs96LZIMhiJG6ZlVGn3anDlWPxYW+7E/cXwKFZJ9EtQ7cvhcOoIv4ecIVxfUesbRyl6p7wg1UzNtkavZLnq9nemAJb03YR9YqFXWwP4Vuu6B2IpIwBmXUxszeXkDnY5YSxRUcmiiya2fVQoIa8rrmkTFb1sKneWG1NEFbhYOOZbTVybNKh1decJ9IWy0hQilctPaDThxkvIx4Bglq41J9Suw18CJChFQcjfKqS374Qo3wAKldWE8preoKGwVFAiOxyEQpuluTwqana0o5VoTu7z1RyDGoI42b4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t3mNTaLZD3YqRvs5egvF5m0O+2Ua+qRVx+ykxKj3nyU=;
 b=nrSAIdFiISZhi4zuy1Sx+tI4tKqcD04xxTD1EhsgCrvl40Knyv9af413k/kwq1JpVy03pocFRsn1LF5EVfz24dEvUBiWVIT8u6ifdzHnC2Uxpmyv0mlmso3w/Gfzqqrjala+mEOfrYXINboj6LBKtnBFMJpEVbObQXIMBXE3HwdFo2S17UcaxblyrH8adJtJkNkHJkoDlQw8UHtO0SQLeWzBL6s2UnQ6mxzZ+o+ePBfQ+C6tM9qPp3yRaIxRk020AIt9ua5UX5kys9Xq1hHz02pHoce6p3bZNlOMES6YmRacXhLPTUu8IL/ErHqz4OqUGVXNR60BpXcW3Lp0c4r3xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3mNTaLZD3YqRvs5egvF5m0O+2Ua+qRVx+ykxKj3nyU=;
 b=R87llsjzfaFkis24oFUsB2vhjyc7JlHbiEzFjPwBh9a3vaCqc7/r6o2VkUtdWoVFW294VgRNr9DaodYmFVK+B5gYGaCQ+28ybTmgdg/e/C9fnFoURff2DXMFE8O3F7B2ZDXeyb9iUMhhE0AfUwZ0ACTGPFlMRQjiFW91yK4Kpjc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by VI1PR04MB6944.eurprd04.prod.outlook.com (2603:10a6:803:133::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Tue, 14 Dec
 2021 01:38:42 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::c84:1f0b:cc79:9226]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::c84:1f0b:cc79:9226%3]) with mapi id 15.20.4755.028; Tue, 14 Dec 2021
 01:38:42 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Biwen Li <biwen.li@nxp.com>,
        Zhiqiang Hou <Zhiqiang.Hou@nxp.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC PATCH devicetree 07/10] arm64: dts: ls208xa: rename the "interrupt-map" of the extirq node to "fsl,extirq-map"
Date:   Tue, 14 Dec 2021 03:37:57 +0200
Message-Id: <20211214013800.2703568-8-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211214013800.2703568-1-vladimir.oltean@nxp.com>
References: <20211214013800.2703568-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8PR04CA0168.eurprd04.prod.outlook.com
 (2603:10a6:20b:331::23) To VI1PR04MB5136.eurprd04.prod.outlook.com
 (2603:10a6:803:55::19)
MIME-Version: 1.0
Received: from localhost.localdomain (188.25.173.50) by AS8PR04CA0168.eurprd04.prod.outlook.com (2603:10a6:20b:331::23) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Tue, 14 Dec 2021 01:38:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3b0fd24-2e8b-4b27-12d6-08d9bea27637
X-MS-TrafficTypeDiagnostic: VI1PR04MB6944:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB69447723A3BFCF5CC65C8090E0759@VI1PR04MB6944.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jjnPJi3NhgWXbi5JVctPWV6DkgO7bSLatRkwrk9+C1vdJXs0ALx9/8zX8tEgVUBKuLJ1MMuBWgl/9AmLpPwdzrAezuJnAUd4VjHn8Gp1Ds3fvQuJzfFJenZkibr4y00HNdJyJRz/1ggGHap3vXuw8ISqSGZGso1nk93QJcLtOYzZtK0DYKsOp7Qti21s6Z038AkV61yqy/zW8UGAEEt1YqDJ9SdKpJ40HakM7luB4XE2/QNgMFD6FgBGj+WQOx3qBbVYt1oAZDrnCCSV2cIvj+pSJ14HOBxtICvZ56aOVPUsQa7OsE6WTbhTVcmKQsfdUlA6Tkp3NmSArWi664UrV59clBuXsuby/UUWerC0AuJiBU9dJiYSWQAMHd1kZcNX7rEQUjA5HGdJYmAWKBqYxmjb8kZbhmckiULyOf44S/WnbPiK3jPNI5/YeNgSNVJH7TfUakOlBMvJqNFW/uhQMjqAdxKSST+rpP0Co9bV/PSHzAk9LDhe/gR8o55qW1xwQmEb8HyGyccZMV9BHoNWZwGrgIpyPzJ1ZARhQsUHjZ0mGe+CQGRqSzTZHWyzmQ88s5eIBNXjkCo42t6KrATRPRHI7JcJso21vMCzQaWDkPvR88WwsS9sSaLK/+K/5O6oQUdAhwACSgD63iMTNQJGXO7FJ6qiV0GfevftSJrBUKOsMRNn3y3O07mQJGIE7AEc469H7TX6dO22Dh0rrzMZoFF3xaZlnK7HRa/vLF0Z0clKFFBGnnKILis+8EoLzPVLVx0PawjLh1T5l4vfhqcqjuIlYXzDlH5l4JwYjj2xM+Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(966005)(1076003)(66556008)(956004)(54906003)(36756003)(8936002)(6506007)(2616005)(86362001)(508600001)(83380400001)(66476007)(66946007)(52116002)(316002)(6486002)(186003)(2906002)(4326008)(44832011)(38350700002)(6512007)(6666004)(38100700002)(26005)(5660300002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZqkoKrzFM/HPT2BZoujxQLts8vpUcDnNVQxoOiJDjwApTHqChPNWvJG9WDnB?=
 =?us-ascii?Q?OlpGikwncnuf83XiJDXiOt3+fcyhH7qNOF89wnCYB6X/3VyK7SXY0HsaKZzD?=
 =?us-ascii?Q?kT4QlSmMoEGmLTnDjDe0AxBzi65MKBRRyqz/1mGoa2CLrEH7TaPhkKztASHS?=
 =?us-ascii?Q?qRd4KTvb1Sm3lzJqdXswFXdO2359JeaiiPoc3SgP0TQkjJlgENkbyhwUULPC?=
 =?us-ascii?Q?ZSepbJgGT6lKT/c7If1NicIIy0pxdMsKELe4//TCTtUQ33YqY6NeopJX7Dhd?=
 =?us-ascii?Q?Fzh0q7bBTjzTcStZBVaxfpyaKJn5iGny+YEL72XTEPx/+ySEDv31umpM6As4?=
 =?us-ascii?Q?DSkfLwT7bzPGlepd7NN23BjmyaD3s2cN49rd+IcQ1tA+XK1iV17rnueyWdY3?=
 =?us-ascii?Q?sbAp47Yf0EPFlQefuswFfza1PaCceJoAeufwGujdzwlM/yks9bdLRi812K+M?=
 =?us-ascii?Q?9z6Hd/VnCMlHZ/XAEpL2wk3BEerIlKqLQtB2skF42s8ZTELE3CV7qhta32x+?=
 =?us-ascii?Q?3z2aXCMtY3PFL80oIGaWJ11drwEU5C5HgEplup1V5WYir8jcNIMV1WOoRp5o?=
 =?us-ascii?Q?c1hsx6UQr8y6jv/226W9ELyfw62VGkApgqHl7q2gVk5QaPl2Hu936YvBatN/?=
 =?us-ascii?Q?YIoNzoNYnuUr/Eteh2hMN6KF9A7CudojbJvK1B7l+DyYksjElqXA5/OprJTr?=
 =?us-ascii?Q?uL/fP3sUSFLk2Lxy59kmbFo5/mRvBQsBgaMpQcFunImSfGXR+obDs3nad5DN?=
 =?us-ascii?Q?Q5lkvb55aCOdowFHl1+do8F9EPYnTzTqAnT3IFOh0ZKl5NK1XUVywj8u/0qo?=
 =?us-ascii?Q?VYhSampvCC2kqQxUASSUwS9rZSYa101wgTJso0XT1kwxgogg9s9EQIpwo4L2?=
 =?us-ascii?Q?CIWSQglm3U6Z2AoG4E6bSou1ksLFmj6Sl+HTU8FWNOj5ygX0W/Eyi0JSNvw3?=
 =?us-ascii?Q?qTk0UlkpbC7RV+0fpoKVA0OiM4Hlp93lNjAP6j/ULJhjUHd4nX3PHSEVefUH?=
 =?us-ascii?Q?pYCTJ8Ln5OyYhPGrerUPT143dOS6Qu1im8sH78gdiPf6at6Bdk8BLnXqt02i?=
 =?us-ascii?Q?470JtCMEg5fYGN6m9NpBqVv6HXStaH9IdcRjSllAHi8z8JhXREPsw1ijQ7ao?=
 =?us-ascii?Q?ED4/GEe8VINNowogW/67JoXu/nwU96uInpx2sJa+F5r4tC6GY/LB61qz6RNi?=
 =?us-ascii?Q?7iI0zlvUHsAS3Hjt0QDKRLq0jg9eAmNpKgnD3OL1oawPeIMv7NTKTcmOAhgF?=
 =?us-ascii?Q?fgoi7ZrYD6Tv7sBFAsSHUYAznuPb9iRzmt0m2Aeyf3xzVXoNMOb64ekGdHSZ?=
 =?us-ascii?Q?MUlVUGDHu+UNhzRVVofwHCNWHS5KNeZaNWBsdZfvHzoiK1y6xDw/YdVmIg/h?=
 =?us-ascii?Q?kMJQUjoIlNMzciu4e62rCgrj4CYDvbWWAAUDoEjHZgG7N7rmH2aZ/W2SUOQH?=
 =?us-ascii?Q?rjx0W4A/U8/KERtRIs/NVjA9G+4c0LiGUI6B/nblxgKydBfrsPaHFQWb1Vxm?=
 =?us-ascii?Q?2SO7tTXnrAuFhRcdL8ubceMV/DmGvH7ix2dLMXIy5Ocsb/aWOxtyfGyd0FQv?=
 =?us-ascii?Q?VSTrDbqdOMWyhAMyQHVTMf8PWGGYTTUsZMRn1RxSGQCmaHsshhQO35idh3BD?=
 =?us-ascii?Q?wygc1RVlB1OUVIGQ8GkvMdQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3b0fd24-2e8b-4b27-12d6-08d9bea27637
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 01:38:42.8498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rqk1NaEJl0T9J5xhcl0KiKxnJ2G9DCPQRQu+IAUnkNuyNL27G+D4EmmfyePHYWIX1WS06pSAYsN0fVaYnuphoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6944
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the discussions here:
https://lore.kernel.org/all/CAMuHMdXM34nNz1nfowNqDvdsdg+d69Bo3_ufs6fbcq65iYd5-A@mail.gmail.com/T/#m3449390080c5a0c8f59b8f8286a87e31e093b98b
Marc Zyngier points out that the ls-extirq driver should have never used
the "interrupt-map" keyword for mapping its channels to GIC interrupts.

This change modifies the device trees for the LS2 family of devices to
use a driver-specific OF property for that purpose. The change is
intended to target stable kernels, to accelerate the conversion and
ultimate removal of the improperly used "interrupt-map" property.

Note that "interrupt-map-mask" isn't needed now (nor was it needed
before, it was just there to keep an apparent compatibility in form with
the reserved "interrupt-map" property). So delete it.

Fixes: ebb0713736ac ("arm64: dts: ls208xa: add DT node for external interrupt lines")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index 1282b61da8a5..50d530d66750 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -292,7 +292,7 @@ extirq: interrupt-controller@14 {
 				#address-cells = <0>;
 				interrupt-controller;
 				reg = <0x14 4>;
-				interrupt-map =
+				fsl,extirq-map =
 					<0 0 &gic GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
 					<1 0 &gic GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
 					<2 0 &gic GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
@@ -305,7 +305,6 @@ extirq: interrupt-controller@14 {
 					<9 0 &gic GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
 					<10 0 &gic GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
 					<11 0 &gic GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-map-mask = <0xffffffff 0x0>;
 			};
 		};
 
-- 
2.25.1

