Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B2C497A55
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236363AbiAXI2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:28:20 -0500
Received: from mail-gv0che01on2128.outbound.protection.outlook.com ([40.107.23.128]:41184
        "EHLO CHE01-GV0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229800AbiAXI2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:28:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kOmP72pNET/H0mWKoP3y2X/SEcfJtFfLyFmbmsGl0f9uzhwDQb2IvIRJFwfZ9OkBZnhdKZYMSOgwK9SSK5UQRdlP8sjOxHJBp4t8ZEFozP7uvwWnzoUcP4k3gnv0aaWwQPMOPTI2XmsAP8ChI/a84eE1C6JteO+vW2GkHTYwIDiRC6e3qU3dzQw9EeU0RqmlABVOJyd0dl9p5nwKVdaCzxfiISmFd7uxJ8UXxRRGJmT6zMSN+CK22TiCLOWbKge6nTlzE17kcxbL4R5IURmE42ZpDXtzc75sG1+xUIcAWuHhu463p1GFMLiFOm/BOOF/pwBa8f0uyjkamIATTkefOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pnVzTx2385A4jfz4t0Uoq12PQFUqYmBXCStZwmMGciY=;
 b=Qol6TcROUMFfJj8p9ZimJSllYzs2Ce8Tysl0IFMFwtYBQXRRsPItTsDJs2ACQ1/p+OoNCt1sv4lfKodJ7+/3Zm2gIjoTE0WggVJ0P6hnwJu8pdj/DnRhdSITye6PuGfD2yFUji+MUIuYRfBr27JwHIRfOEOffuE2wYKQb2amYWKjEAADJ7TCrQrGZyTE7bti3DO1c0gczGSvJLEMS0fVdewMM0WRzCry66JVQGkhJb1ehthpgxDThS98s4PmXv4db05EqeL9z421fyeU7+tayiASNS+mjPv46jQGERoBaPgjsCnp2S+0gHFT6kT5HG0R1/H3a3dU99pMPjzv26cyHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnVzTx2385A4jfz4t0Uoq12PQFUqYmBXCStZwmMGciY=;
 b=n6UvDuid/xA3sUDCdj2MMBa0Td4JRX9Ouf5RAFtWe+HUQsGG1bF1ZbIvUwlSqGagrPrMiFUXBOQmQ57tWtPkegktcoplZ2kjGxN4VnokutUX+EjXk6BLertOENJSHgFdRWw5vZcR7kgQVl+rsSOR31YHLJeP+NQyIihBcwAm+YI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toradex.com;
Received: from ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3d::11)
 by GV0P278MB0227.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:31::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Mon, 24 Jan
 2022 08:28:16 +0000
Received: from ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d837:7398:e400:25f0]) by ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d837:7398:e400:25f0%2]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 08:28:16 +0000
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH v2 0/2] Enable i.MX7 SOLO temperature sensor
Date:   Mon, 24 Jan 2022 09:28:01 +0100
Message-Id: <20220124082803.94286-1-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV0P278CA0051.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:29::20) To ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:3d::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 633aa44a-b036-4957-347e-08d9df1377f8
X-MS-TrafficTypeDiagnostic: GV0P278MB0227:EE_
X-Microsoft-Antispam-PRVS: <GV0P278MB02273DFBCE18C438195B8D1AE25E9@GV0P278MB0227.CHEP278.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VzvHZ6XlIDWXwk6iP3nbM6HLiDpfCKzV+mYphbKV11kKrRNWPhIo0gSZefarSJH0+Izm938bW5+gel8FH35b15f62eMQhPCL4T+3D2EeuZNsa+D5Z0FWiLNJ+J4lYoFO9Hho6yKB6PqtU2Z7p7fz340RaYwxn6D/VzupRN3SImk1rKMBnzJiqp4VOhtQ/QYi0zBDVmiVflg7ja6tbRrZcT2oA7ik8LpfKLHxnTStEMoO0NoZnIpvaJoJtoDw+1fujFu2ecQg9e786qj+eoK0htVVSUm9IfO3tqveQQiRlqWVASE64OMeLoSkhDezlrQGQs4qcc2HuHrAmFZPskdHe/UEDVXlG4e8T453yCyJHcK4XIYNAe0uDNUx1tiS3N0Y5WN/kyQLSzL7wKqPs7He5x8NdndGY2A0ODkh4RQhH3Jc84kaa+dRBOKbW6DwltShxZvToOOt+5Xc5xbC19zYs3fBqd8x4Zj14+3Q+Y/J7/a6nyNmINmDDaxwQrOOqCiOgCgC8+/PvFmwOA9jmOvH5Nv/IzMYqirXZAD4pxklyEqD7eZN27XNv9E/p/DTTRBxjGr6HtWy5zxeFPfGkTQXSsP3PI65oGlZ6spWo7N+hPRWvIOuevs0grazY41teFbhxF8oJD454lg9y2mDCH6J6BI2ERDue3jsNzwrfCugzL8TEg67nhJgYtEo/9kIpItlOXR526GIhekNTGFD64L4gA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39840400004)(366004)(396003)(376002)(54906003)(52116002)(26005)(1076003)(44832011)(110136005)(83380400001)(5660300002)(38100700002)(186003)(38350700002)(4326008)(8936002)(8676002)(66476007)(2906002)(66556008)(6666004)(316002)(86362001)(7416002)(36756003)(2616005)(6506007)(508600001)(6486002)(66946007)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zKhiZpWA2gYiAoqw8f7y7cVRs/os+lSn2bak+tEYXZx/ititcaK+yjWNrCP7?=
 =?us-ascii?Q?0MJMGo1C2zSOXSsOx2fWV5hrBAWAw3ZUNF+o1alWoDUOGkAS804snN3ooRct?=
 =?us-ascii?Q?y366loETPmD234j1MCWBB2n0a5tmhZYNtiAcAf2dfv4FCU1ccVBOM9eB6dMA?=
 =?us-ascii?Q?4794OClpPDy2hY6osLntgB02chzc4WaXOee46U8M95EnxhlnpJCOlQlGI1fe?=
 =?us-ascii?Q?eitXAEMIXVlxNogNDLu7BTByZS6VxJ8mgLdmJHBeIntahQrMmyFTtKh146DC?=
 =?us-ascii?Q?aqKZTgWZeq/Iv8fM2FLgCYxKRI1RGarmb0JdbJZQZ6sPbxoNYuBcBqEtZkkw?=
 =?us-ascii?Q?4/fqklkE6ra8Qy3T5vD59ndcXt+pMWagflg2P7IzkCF5LbfxyOq5EnVkWFqZ?=
 =?us-ascii?Q?YqIOV8Kkh3rShys54R7IoH2WXTD06Y3tHzOI9PAhbEc8B1ZPK3TnetVBm3LD?=
 =?us-ascii?Q?N+eY+v7DrMEYpQTKOy6bpynWxFFhvIT/iyKO/yU86/lElfWztgArQt2wd/DQ?=
 =?us-ascii?Q?0+bn+bvwOv07yqUpYXCsD+PsdT+5xsISvLJhlB9QJ3NAgzo6yHm5sQoiF+jL?=
 =?us-ascii?Q?y0VlQ5lYnc2yl2Hl7cdxiSTF7XGWXBvZCT073Ywuh4ZUTP6h/YxlS0fWuKNN?=
 =?us-ascii?Q?UUcxmxXPkBZpp0smdSZt4U3CZgIVaCueAbldsbTovg76heNWSF8LTRBgJZ9j?=
 =?us-ascii?Q?2DvHxhVpegZbdy9/vsfcE8XQYG3MbUFvryQPqpHKT2l1QeUHMiBH1h5iCBwT?=
 =?us-ascii?Q?Iumpl3B5iLggUs4XS2a7G0xTHK3pk2e38i6Mlc6VNGJ3jC6YqjC4F54A7H2L?=
 =?us-ascii?Q?KJe0WHbL9MdcjsPR0sepspnRii2t/kH4AhtwvgztvJFNWg+CsRwc5KUkg5JC?=
 =?us-ascii?Q?S6vXJc4Ht2vQhqX4LqMELZJOwxSQAN7gScalPCQDfdR1xOfsi+77sZ/pcqPK?=
 =?us-ascii?Q?fYwVNVEmLZp4J4i2v5NS3hDq2QcV4vktVbPt3Mz857G4PIpAx+X859MGZGHb?=
 =?us-ascii?Q?tdhY/hsuHTk96zwlP4xQFpJAOrhn8KBjB8TlI2dCloGCTRUlufRCgEChXrk+?=
 =?us-ascii?Q?rRpXIenOsI9ELGNc93MRstTabxW4VV4GUNVgZGZfaBf2mM0Shje38D70XFRH?=
 =?us-ascii?Q?6M/uuLQxwgaLhEN7ZNvpIjp6RQ9lJYOSh4RsT4B1oi9vAfSVu6pmIBJ2KLg9?=
 =?us-ascii?Q?T/AOt4qXiuKJxePSLZW00ZCIoyELGrn9jP1uXKYRCjuuqDqWdDtUheJCRXMQ?=
 =?us-ascii?Q?XN7osvwcvCDCTwfp7drn16LHOCX0eHaJnbm1z1d1p7jRPvsGJsdpjJDGRIZ9?=
 =?us-ascii?Q?eYg9+9ebxXx4CHVmjKiSB9GVRz3HDVkpttwep3IliszRJmwU0uZqs2R0ai9M?=
 =?us-ascii?Q?9uwm0Ror7KJLYY1p5SLnFe+C0nPa8u9gIDKwupOI4Lk2QJy0tRyMB6Hr2xKM?=
 =?us-ascii?Q?ETG4f6dWHDh0GRmik9U0uRqNw0Rlw585F7eGdJmpteJXts3C2855jURZaR1W?=
 =?us-ascii?Q?ffl1SLpgx2Gpyij1QcQvqan/gc0Bw/XM+KPrnySHdhoGeqMoMAzIRn8/oZmL?=
 =?us-ascii?Q?UO2m193JJg1U5HmGVG3DTG04p2U+yZgadZbid5E7b1WBD1cmIY4zFRt61etM?=
 =?us-ascii?Q?Wo5lluMGh+pq75VqFOesOx+GI04vxTQWrXs6M989pSUyP+jxTTXecjwSF+Tu?=
 =?us-ascii?Q?g2soMw=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 633aa44a-b036-4957-347e-08d9df1377f8
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 08:28:16.0769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZpDwYKDhphfwBEaQFqz5Z+iYuUd049kWQoDuNQX44MC6cdE2qCSWJuvgmHB9JVBTJL5Z8MIDV4w4P7pef08QSm4Z2GiRA0WbCv51/R22pwU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0227
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To be able to read the T junction on i.MX CPU the imx-cpufreq-dt needs to be
loaded, however this is currently not the case for i.MX7S given that it does
have only one operating frequency.

Add "fsl,imx7s" to cpufreq-dt-platdev blocklist and a single frequency
operating point to the CPU.

With that it is now possible to correctly read the CPU T junction.

Tested on Toradex Colibri iMX7S

[    6.232577] imx-cpufreq-dt imx-cpufreq-dt: cpu speed grade 0 mkt segment 1 supported-hw 0x1 0x2
...
[    6.880624] imx_thermal 30360000.anatop:tempmon: Extended Commercial CPU temperature grade - max:105C critical:100C passive:95C

root@colibri-imx7-02983025:~# cat /sys/class/thermal/thermal_zone0/temp 
38000

v2:
 - removed empty new line
 - rebased and tested on v5.17-rc1


Denys Drozdov (1):
  ARM: dts: imx7s: Define operating points table for cpufreq

Stefan Agner (1):
  cpufreq: Add i.MX7S to cpufreq-dt-platdev blocklist

 arch/arm/boot/dts/imx7s.dtsi         | 16 ++++++++++++++++
 drivers/cpufreq/cpufreq-dt-platdev.c |  1 +
 2 files changed, 17 insertions(+)

-- 
2.25.1

