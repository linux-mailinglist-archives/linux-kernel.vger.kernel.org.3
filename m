Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6155448ED01
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 16:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239355AbiANPTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 10:19:16 -0500
Received: from mail-gv0che01on2108.outbound.protection.outlook.com ([40.107.23.108]:64257
        "EHLO CHE01-GV0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233544AbiANPTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 10:19:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xf6K/Amya8iXxcCMnpfGnUc6O7rTfPTlkR4LEtYn4zzsGkt2Rp16Mf7y1naqlAFjYy25ZR654mUYG+uNLBinYKtDoaQ6BP2S/2NQp88RnMkOPl8p1i/hOPb5JGYCdFcnT72CQMF0q6cbvSpECp4S/b3EcDbcrcIkdz//QujQl3IMZhJRmrbzvWtPZEai+qCHunczY+cHOwwmTkL3Cvq7TlTi1XzrJDZ3sae+caU4rDrhP6ga046mkfCgX6pfIDQlZe/O1L0aesEgrC8/vy5aU7T2ruMXWIdDk6hNd9ksW6k6bkfF0NQh2UEbBs6gUYRhzrA6nYtkEb0YycisXO9+Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZKB6TGndXsP9eznZ8TDWOdRtbW3Ssn0tYCthaAXcFNw=;
 b=ddm/rS4AqMIfuUEyZSMz/GDK6jROQ7oprap8mcVQpbz/uMnuMD5ivDlWtC4Ki5rC5ROVvUaqnqg8DreedCmfhIjBFzwZ/PtQpPXziH35fnGX/jqEW+piw9ZqFWnnLT0/t/5LlbmVRLMMYEIOyFdIB/rQ+WBOVS9g1fJYJYlpMbCcTSaMNcFBhhE4dIRtVfEyFJ1W+4zyDvrrO4u1MLWUaFxhJiGG05a0aICXUni4/1ud86/FjTuY7sTgMHNtm0YvWNIHFrnwlhi5BqWGCahWl6fjbqsSOcB4osqF+pbMth8mll7iPtMyrrv1dFEdR5AXMGE6s5gYOx0vfUXCsrVs/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKB6TGndXsP9eznZ8TDWOdRtbW3Ssn0tYCthaAXcFNw=;
 b=XVSzkds9NARQRNb23v7kdvv9vRJSKbn/g98BdMzXhlru/kROwkQfRAXAAooaMxdx4xmYqGd9X2H96FhjeInVIkvUTgMVEUqL5DRyjdnttqvNBkztv0Hp1gQQlKEd297Is5W0nBlWKaWPGh6fznbk3M0Styvx4zRJ4PbB924sHiI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toradex.com;
Received: from ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3d::11)
 by ZRAP278MB0080.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:13::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 14 Jan
 2022 15:19:05 +0000
Received: from ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d837:7398:e400:25f0]) by ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d837:7398:e400:25f0%2]) with mapi id 15.20.4888.012; Fri, 14 Jan 2022
 15:19:05 +0000
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
Subject: [PATCH v1 0/2] Enable i.MX7 SOLO temperature sensor
Date:   Fri, 14 Jan 2022 16:18:45 +0100
Message-Id: <20220114151847.290518-1-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV0P278CA0062.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2a::13) To ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:3d::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00d5a733-cd7e-4815-cce3-08d9d77133ae
X-MS-TrafficTypeDiagnostic: ZRAP278MB0080:EE_
X-Microsoft-Antispam-PRVS: <ZRAP278MB008047B8D458E1766A845B8EE2549@ZRAP278MB0080.CHEP278.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zZFaExarWaKS/vl7aZA5pi7hKumc2CVevd5kH1SAtgE7vdh/mKxlREFmqt1lofBeiuGR3T5uVEToJJrhV0U4kjun1RZQAXtZDXqSrIf05ZGEc/0QJYfihXNt6Li4+w/Np0D27+UmNRlSaVFG4BHGAVyfgfK564OItlaLLe1sSvT1Gs36Ran6EJu1APz218rRfxito7LK1T4GdWpCoVRIUWAkKu+FdisNP8hsedDrCSDkhih7dYXllik/mIOcoJahZ5pBHafVe3LJ6epqOz8gz1ATACIeSHWeypjgLHhMxloFdWNY65lVv46Rr+QuSZc0XugLwDiD8t1k4j1CE5BcXSs2ZNuIlTy4aXttiEAglVJv2jSKqL08zWqCyM3K78YII5ov3Y6IgavdmJdyJSYrAj8JWhKB0qpWNnc+TsyjeMYZSOXWDdLuBai+yllr+wr3VWUTeWpRgck6bAgOPfLR2/ayWED8ZDeFRrCvzyz5DWylDVOLLG6MzItJhJ+zdBG/xqDwNUhFEGZrVYpS3fhsbmoyPZj/9IDhuewgJ2NX5HPGdnpf4Eko/9zqnVfwrX1W29q3S5hgVlsk75RQyc72Psy+LiFKdWiABnLbGOPmQMZYCchKHFk/C4rPzmz6kscy5ELUe4FvNREXD5vhRUyOAEnxvFP7yeBhAm6nVfW/yjPF/5Mi/5uMZ58Abu6cYeCQ0h1y88RiWuXvt7oeHM96rw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(39850400004)(396003)(366004)(36756003)(110136005)(86362001)(5660300002)(2616005)(316002)(54906003)(38350700002)(6506007)(26005)(4744005)(52116002)(8676002)(66946007)(66476007)(66556008)(186003)(44832011)(83380400001)(1076003)(6512007)(7416002)(6666004)(6486002)(38100700002)(508600001)(4326008)(2906002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iJmYs5GciaeEryo9O172HHRhk0icca8ENIx159P8kEdpDdPxz0yCLTa0KHzR?=
 =?us-ascii?Q?brbXR9yIq0n9fPyqsYi6JD0vXM9OBQ4etySV3Vje3UCZst1WZAa2RfCxT+ti?=
 =?us-ascii?Q?mgqKbTqV6KGib99Ys5SEolntMQLWvD/itmddsIoG9MuYjNJJ9jMZC/5ei1lf?=
 =?us-ascii?Q?XdZ+aD2KXms1J9sutfVve/dO/GTynMljN635M3txQdyiCsm7PHbnTjflCUIl?=
 =?us-ascii?Q?k4A9C+9PHxECOBVcex0ZI5Qo5b0rYw5ArTf7flSsA2uV253Hsz5+tRmIxJp2?=
 =?us-ascii?Q?4IrvdrCp8ay9YhyyPegEFwteiXe8rnBmYrQqoiY8XBKP2uiEfvsgE+IlWKxL?=
 =?us-ascii?Q?tQOixz/Calk5DUOPZ1WW7xo1a/UYUPQ3Yn/zccusYM4qWmrBDqW+a1eDByip?=
 =?us-ascii?Q?tgJAT3WbsMw48c59JrvIYdxcC9A9Oqff4TJaBNWavTQc/rJg9w3EkByzL3IW?=
 =?us-ascii?Q?PtYmXFmLnwMey3QTE6T+ojWkf2X4ebnAwRUBCuk+abMQwROjE53MePKDx4/5?=
 =?us-ascii?Q?h3dAWLB9TRN59WgpBfKzKVqdU+SnvYwMaxL+D1ilXcAO1pU4yX0rNf3f8mLe?=
 =?us-ascii?Q?xpU/R+SFa2Ys31cMLJdCzBqDdY/Cuk7Ox5xTpm2ZHWDU4/BvQEsBvlkAYUTj?=
 =?us-ascii?Q?rVHJuuXAyJKFdQS9Z3FEXpBwk5N53v72/vNs/QV5tmJisxwDxj/DLEPkXoDz?=
 =?us-ascii?Q?yKzsk+Lq+gzr9j2Fx74g95sm25pCTfCu1pvoDX4pRfyslMLZ8O4dmKQ3iUcg?=
 =?us-ascii?Q?twvHK63EmAO4y/HtsW8f1K7vF69hGLJ0j3dea+x89tH2QoyHHfwVwiCy3SWA?=
 =?us-ascii?Q?ouAL0KWMnSfsFt7xNAJBcoaYQ3VLHaROUXrmm0Q20XnoYah9I1NqAga7XhmM?=
 =?us-ascii?Q?jPbI1NW+DiYyW3eGnhhkLit3eB+SUuROOXyVY+sc9ho9cs7jTb4OJI02U7GL?=
 =?us-ascii?Q?EAzf4EsMSqVqrq64sE1gd7wXYOxfyQWL9UD1k7PCyojbAb3Cewe+NyfL6KNR?=
 =?us-ascii?Q?rMG5o1FQYpqeJRoCJoHgi72U53kxrsKzZ0AYMWHv8FiqCMciLc9j+UIyRtsr?=
 =?us-ascii?Q?DPFfvpeH2D8QgTHd68oY7mNhzEcCm0zJdKUmdX3GJh07788g47wu5rqd0WYN?=
 =?us-ascii?Q?hOmMT74JZWC9sgx28GraS3gLTd0Fa3PjeqPlOdXlX96WZpsa+oTBVtXS6SyO?=
 =?us-ascii?Q?6J9PcVheO8JSiVvgriQ0ZtnsMrqqzcdtC1On004Bg9hmk4VzCInl1mIzTlzb?=
 =?us-ascii?Q?upd4tWfXmD4MWwPnrQODW2Hw6NvI9Sx3SW5VCTfAD+sHUiimfglVtsgZPsep?=
 =?us-ascii?Q?3iahAGvgWA0RlATWvI/ywvOTPXo8EOxANVhENWUtmQ+TRDFsgIy5k+DcHRPd?=
 =?us-ascii?Q?jz45jNakk9+xqh4F1ExWl++gPCXDZ7DKQwZOKLLgkYNG25D9YS9Ro8PypuSb?=
 =?us-ascii?Q?sn+Rq1xGz90XN1h+aj6HxacL2b2kVm2dTyH6DIPia6Q67UB9ULa+8QQPkBqv?=
 =?us-ascii?Q?UyLBWDxEVwxiRsf0GcEtxuPwmfVkezstRSKiNi8d/mA+ViMLgvOem9OhQco+?=
 =?us-ascii?Q?G2MLn5eLTxKxjsJA4XNkVu5tHQyMCLh4mhPgyvjUuyQg0wWaz0EDUtcVzhP9?=
 =?us-ascii?Q?jqjLchxy/DQHOqw7pQE5VkreJJjZeqRyfA3oV6dmw0P55+XvmArXKftlfSZW?=
 =?us-ascii?Q?lTi/SA=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d5a733-cd7e-4815-cce3-08d9d77133ae
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 15:19:04.8633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sg4cfx7j9NGdCmqbjI9wbvLuGHYloEJ3CHzW3IX22yVk5srZCZsyT+dr2Jwl2z3pv0UkEchA/91o/UvJvv9GQVdajzp4GUIiWq95Qo9nfZc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0080
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


Denys Drozdov (1):
  ARM: dts: imx7s: Define operating points table for cpufreq

Stefan Agner (1):
  cpufreq: Add i.MX7S to cpufreq-dt-platdev blocklist

 arch/arm/boot/dts/imx7s.dtsi         | 16 ++++++++++++++++
 drivers/cpufreq/cpufreq-dt-platdev.c |  2 ++
 2 files changed, 18 insertions(+)

-- 
2.25.1

