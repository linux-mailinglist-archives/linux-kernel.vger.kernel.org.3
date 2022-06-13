Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF19E547EE2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 07:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbiFMFXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 01:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbiFMFX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 01:23:27 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AA910F7;
        Sun, 12 Jun 2022 22:23:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eC/6D3Sjn3asRTC7WWzLq4jkIbqRa+5U0ro3XIKbaBSB4kjQ+VTR1raclJocbpyaCr03U5p1W0jb8fFIRzfYANjP+Wk8XdZrdExvxg6X3lrSHTfGdn1s7cvspSP105ydcBNFXoMzBvn6ujGCCSjRLKct7BDtvsyNqx9CcZ7Lvro8kKU7QJrB0Mh3qjHtef73VftBxchG2Fi7rNuMmQcKdm0x0CRHBNQ59c6kBN5kSc1PrbLAohyuQxlm1XYLYfyAbRlH3i9Fs0vKtNH8R0Y3NHe0Fi80dtat/8nKcaCgQ0BZC2AV5WUiu392zbdEVc74Ns9XO6qhUrkaxJ3KO184dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EmD244jJoOEYpFPag/CK4MpSakZDM+q/s+uyG0rcrqM=;
 b=OknvzT4HRGYTK33vbQyDLAY1vxuKHXpjvZM+p2aCurOeP2m1mF69Spfusf0x8S8FVb8JV+JBwK8H2zHo1XIF2dlmVxqU9PvBwWPwoXr9o6xGjwjUC5XY4Q6QeZ4fy0EeP4yOzDLcvXYNkmjJaexcJVQHwYnDVyrCxy38TVhhxGrvwEtx3B6/0zy4Z1pEn+6QUVb91+AL7A/O7t0z5fHusf90fWegMkwSubMFimm9J07rEARR/tQSamoHBew7GIC2rsl5+y5C0CEesSiWdE+ihhzb7DyygHo94mv6H8OnJ5oZ7KSpwTER286pZ57qjhSp4RDIYT+4XAkPoKjAXPbUCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmD244jJoOEYpFPag/CK4MpSakZDM+q/s+uyG0rcrqM=;
 b=RdmoDMIAJUsKkVnG0SRgttybFNNPsd5kK7NrATCSDec99au9qEBSLo4++XTuzIIOqXNg3qSDk7NPd6djmEcjged3ZUo+c/Ix+pI3WyycrsCeBt3hP5r+fqdSeGSrA9lwyWgB46Cl3AUZEHFLR6e0pnJRO0O3AN/JE1uAUeN5Sj0=
Received: from DM6PR02MB6635.namprd02.prod.outlook.com (2603:10b6:5:221::18)
 by CH2PR02MB6600.namprd02.prod.outlook.com (2603:10b6:610:a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16; Mon, 13 Jun
 2022 05:23:22 +0000
Received: from DM6PR02MB6635.namprd02.prod.outlook.com
 ([fe80::914b:e95d:6a:8044]) by DM6PR02MB6635.namprd02.prod.outlook.com
 ([fe80::914b:e95d:6a:8044%3]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 05:23:22 +0000
From:   Shubhrajyoti Datta <shubhraj@xilinx.com>
To:     Shubhrajyoti Datta <shubhraj@xilinx.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v14 0/5] clk: clocking-wizard: Driver updates
Thread-Topic: [PATCH v14 0/5] clk: clocking-wizard: Driver updates
Thread-Index: AQHYTYuVTKGc5tZzXkGPQANpjpyWDq1NMBvw
Date:   Mon, 13 Jun 2022 05:23:22 +0000
Message-ID: <DM6PR02MB66350E44F54101752D4046FCAAAB9@DM6PR02MB6635.namprd02.prod.outlook.com>
References: <20220411100443.15132-1-shubhrajyoti.datta@xilinx.com>
In-Reply-To: <20220411100443.15132-1-shubhrajyoti.datta@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-13T05:23:18Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=62b70cee-b4c3-4ebd-bb51-833b082ac206;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb3bafb4-4cec-4726-a833-08da4cfcd58c
x-ms-traffictypediagnostic: CH2PR02MB6600:EE_
x-microsoft-antispam-prvs: <CH2PR02MB6600EF3FE5F66B3D7489EC2CAAAB9@CH2PR02MB6600.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J62684uqPyiLhCd9inh+2DA6ryfbVOXSI6EHIPk1WbpU+g2St2W9ofSwGvXixpDOgyPfiAG3DjMvQ1W+woCFlqN8bai8iXVtypnemUboGufkCcShlZ077CLWF6GLFavIILrD+TmrdbUAwuOW8FqoQWKhu68eMA3WkzyJwwGSkQeu3DTmgcf8MdgTra5raN1Ecl6x47MZ8dM4m6nLeHWqZqndKEV04+SSAyGV1rxldvGg+1D2wUE5m1RPDhAlzpgBMaxYg9GQGk7yLJazk3TOYrege3ahoPvT0GAaOIFE3Bb4IE8+Oj3g4mavQMPSq00bICsFpGTB7xhSUgLyyNiBh0NMS6Ah/7F/XzRkr6MSigeiVzHKHEd/of5HgoPTIemGhsd2lXyh1UzPy5D2NTUWXCZa5VA7uno9LV/d+gTbw+5NdbEnRVgURnZ+Y2LvekP4fGi9J3IyRbw47kdhneZpsb5CFVsNj8PejZyqoWImfsa+JQVjn5nozZwiev0DhniCb8Ffl91XKGJZO+vcekK6qtOGSvGzX5SafdbQTUlwyW/nkiJdceGXwDNqKpi38D+Eglh4IVJtE45ZQt/R7FpL0Ad+taS67tw8nmtUHFz8tx0LHQBAKl0FA2ILsXKPfqOoVW+bNwa3pqtbyp6+DlxO8zt0SldjKVDJH1fcHO6z0Q9kskAQYcQ/6P9PD52ukvsOTHSvSFAn13LymNcfUc5djw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB6635.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(122000001)(71200400001)(38070700005)(76116006)(66946007)(9686003)(86362001)(8676002)(508600001)(66556008)(66446008)(316002)(110136005)(54906003)(186003)(26005)(66476007)(4326008)(64756008)(55016003)(53546011)(7696005)(6506007)(38100700002)(83380400001)(5660300002)(52536014)(15650500001)(2906002)(33656002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x9Otrwz4UzHExQ7Ew5oJ4ZKpJvB4T4ugvuwy5PxVtNxzpkgOXCb4dPtIrSnR?=
 =?us-ascii?Q?im2h6BWpFtVKqo3eTh6k2qpRgqEo6jwT4lX5Pg7oMjxiaF0MTIgxLifJX3zQ?=
 =?us-ascii?Q?87Etl7GbIssxNrL+a8EVszsIommTrxFhY2ZKUuidC5/sCtPegZoIV/7etUMd?=
 =?us-ascii?Q?mGHxKvbIHw0/csC8JPBxYYfKhky7lp9GgrgvbtTXazlOvJFVxWKf/RdDiwOg?=
 =?us-ascii?Q?aQq77DIx1yAdOkaF7vKHME5gFeWmrWLF49xWPx2lNHvb7mBAZAlQ8BahIjzS?=
 =?us-ascii?Q?XX0h0eVN5nK14WGWWXD4Kw8JYtyPfUH1gbqAbhwxsxZJqbBTfxaFwUibMhOI?=
 =?us-ascii?Q?78VYoW48D7ATPG1Vl5/sYi3/g3A+IQfFPH5u0cayL7c4KMkoc0ij//D+uvBb?=
 =?us-ascii?Q?+ki0nOARcqJUn3E2Rzp4nW2nW8eX8S4pJPWxUlJvBquTpoGWxo0l4h3A+jAF?=
 =?us-ascii?Q?DO9dgTJjaKx7R9ddo2z51P2z2giArc4MLFvsM3vuT53Ef9SLFEaIeMvOsTQS?=
 =?us-ascii?Q?OUAbim0e/3aLFqA9f7xrO7yU0z8zly9gbS8mvcIFBdrkGoczDnfaTezA5WaJ?=
 =?us-ascii?Q?nT3rbS5gvipbxSc1zUSGzaXWj4MwrxeAE2afl2KwBl5zBfbYt3AqsNuy8emi?=
 =?us-ascii?Q?sbuptCf4fBbrl7dOkp4E9Wvp7bWw5C5GRHwASrBMoNqMbTjYjYpWDcvetHhC?=
 =?us-ascii?Q?cImyCWji2bW5nQNfOu0vu/vbdBIL0JdfK2AOGeFCpkEEhZuK3QLPUBPh6uod?=
 =?us-ascii?Q?oU1DrZqlOzAk2oIodfsOaMnrJKPhyduefElcRDlzd0oydVHgPnuvme+NgTo3?=
 =?us-ascii?Q?3BwhBxV7/ocUs96kMh3TdXID2jVB4szO8fi8Be3DUFCNZA4C1hIpoWARIJx6?=
 =?us-ascii?Q?a8lEEw8vzySDBdqBiNHhS83IAER2YtoCBcBNVLEmQ2RWeJRTFjjZX4wshYRg?=
 =?us-ascii?Q?fnp6QfzuWm43vvkyZndqbmIz4brnI5W58tUUkVAQBWNuhWCHo34nmBnL3W+J?=
 =?us-ascii?Q?Zq8yOhW8/+HiH91NakoWssGjhecwm2rdRiyivi5GwuXy7BD6t0+lZVLAcvF6?=
 =?us-ascii?Q?pLTH5mXXoy/mn1pLPcJ8oUon4RR2qXPnSw2TRETZv8gjrjQ/zjUMjsR/jYBi?=
 =?us-ascii?Q?Wmg98opQL3whLiM3HmIGSlpdnHrR+WlbXWzxM2SoKq2r9GP61eKWK1NW2+K8?=
 =?us-ascii?Q?S0DddssF3qmc/7c+F3jk+DQPhh62Ma6eZBLc116QpGHLJoEDopeTmBqemA07?=
 =?us-ascii?Q?hARcjcuv5RDyohHBNqez3xx22xZ+RPTNtBSrk+RzdDu4MDOAAcAt4W6o9SNz?=
 =?us-ascii?Q?cxEeDvfBlJL8hdm6oj/IJu2xFtEL0d56Oxt5A5NhLCoVokd/ELg4dMtIrONu?=
 =?us-ascii?Q?7jP/lo5tgXUgvSddm+tyoQZ162Ur/DlU1ZF6Nkl4h7qX87FFXtDkmPlOivqT?=
 =?us-ascii?Q?X++uvWpb2Y7ZV4vX19ZZb4ey9/rd3MrOH/QAr8A7J7GG3ZxTGj/ncTSa4z2b?=
 =?us-ascii?Q?d6077QCQmHXd9LKwznjGiNdlfmKLjzNIN0ZFIMHMm9dBQrtIdWOREJvrsNtk?=
 =?us-ascii?Q?/QITqn1Ofph3wb7ekJSinv+bNQi0H3Jxi25eVA+T99ueGMo/aUaIsdJ3ffZt?=
 =?us-ascii?Q?NXizqOOVkwgUHluY//NIdlsGBzxSwgc5MAETqM23rF62kPPhxI1uH7T1WzrD?=
 =?us-ascii?Q?NXlzi47X820b7ka7YZV/hssZAWjFoIN7Jkk7apTcK9mDk3yCFATW4uBvky9r?=
 =?us-ascii?Q?sTyhVnQQJQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB6635.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb3bafb4-4cec-4726-a833-08da4cfcd58c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2022 05:23:22.4425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oQr0GQrzThmab0CcC2EV54VzpPicCM9PxVppExflRl/bojySm9vf4kt3e/dPCo5wqWjKMPWVP95TlIOGWyRTWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6600
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]

Gentle ping.

-----Original Message-----
From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>=20
Sent: Monday, April 11, 2022 3:35 PM
To: linux-clk@vger.kernel.org
Cc: robh+dt@kernel.org; gregkh@linuxfoundation.org; sboyd@kernel.org; devic=
etree@vger.kernel.org; linux-kernel@vger.kernel.org; Shubhrajyoti Datta <sh=
ubhraj@xilinx.com>
Subject: [PATCH v14 0/5] clk: clocking-wizard: Driver updates

The patch does the following
Update the versions of the clocking wizard ip.
Move from staging to clk directory.
Update the bindings.

v12:=20
No change.=20
Rebased
v13:
Update the clocking compatible
Add the change removing the driver from staging
v14:
Moved to the xilinx folder

Shubhrajyoti Datta (5):
  dt-bindings: add documentation of xilinx clocking wizard
  clk: clocking-wizard: Add the clockwizard to clk directory
  clk: clocking-wizard: Rename nr-outputs to xlnx,nr-outputs
  clk: clocking-wizard: Fix the reconfig for 5.2
  clk: clocking-wizard: Update the compatible

 .../bindings/clock/xlnx,clocking-wizard.yaml  | 77 +++++++++++++++++++
 drivers/clk/xilinx/Kconfig                    | 11 +++
 drivers/clk/xilinx/Makefile                   |  1 +
 .../xilinx}/clk-xlnx-clock-wizard.c           | 19 +++--
 drivers/staging/Kconfig                       |  2 -
 drivers/staging/Makefile                      |  1 -
 drivers/staging/clocking-wizard/Kconfig       | 10 ---
 drivers/staging/clocking-wizard/Makefile      |  2 -
 drivers/staging/clocking-wizard/TODO          | 13 ----
 .../staging/clocking-wizard/dt-binding.txt    | 30 --------
 10 files changed, 103 insertions(+), 63 deletions(-)  create mode 100644 D=
ocumentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml
 rename drivers/{staging/clocking-wizard =3D> clk/xilinx}/clk-xlnx-clock-wi=
zard.c (96%)  delete mode 100644 drivers/staging/clocking-wizard/Kconfig
 delete mode 100644 drivers/staging/clocking-wizard/Makefile
 delete mode 100644 drivers/staging/clocking-wizard/TODO
 delete mode 100644 drivers/staging/clocking-wizard/dt-binding.txt

--
2.17.1
