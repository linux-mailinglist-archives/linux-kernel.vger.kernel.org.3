Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99ECA4CCADD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 01:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237416AbiCDAgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 19:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbiCDAgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 19:36:21 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2118.outbound.protection.outlook.com [40.107.215.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107BC1160D1;
        Thu,  3 Mar 2022 16:35:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ttd8LyZEzmwLGHPbmPNeIQQeelUGfG2pgndosWEnMY//e8/ZcjnooyWQLTuHOx+IbdNYrMTEJrUUvx7QaHZRCfhWBDcVMA2HqHW0MwXAR3EBsLy1gnKjPB1G8Ug3i+cETcVsf8sVj1xNQ0tqhWH/UE/c3NvKwNj8v37JUMLaeghMDP6ncPqJQnaZiQTJw44qqN0/fyl7SBSo0YmIAPj6FkWukFfpUnfm2DyHHwmFw0ZDCucN3NwqgJWgCOgyxAgsSYvKLfuxEBFDepZXu2swTiCuZU86iXLU+CWa4ruhVVOI2bEd/4ZjbzxmJHjImGBG4VJIah28+bZE0ZupxLmWzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/bj018B+wt3+3fZftHIFn+PHQrkd953TkmVr0utHkM=;
 b=bY2wpQewocP+XACRwnbUbR8cPrGazq3pJP0N2vyamIrp8GG54UuJ434jcvwh/9HrurqT2biYTVKV3MGRhRgB7W206b8BsAXUgb0wj7O08iHEb6NXj3WqXhAwQCpiiXM8SyAAxiBei+c1e0vmm0+CjqHhQwu+l8HSMa+tZwt2AmdBIBZuiTspeGfVEkcIcbVUPj2TJzfKTqQmf9XyTNOl2paMUcrFmHX6Z+v8QAIwko9ZKzQPYk4TIqpaqZWK9+2LGdQYz9XDW0vAut4TESoFFzOE/0MNw91Lt/Zg4V1SLxVawknry8WL95GOAapjBATuGyDMTC0zIYEgKKLKUH+c8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantatw.com; dmarc=pass action=none header.from=quantatw.com;
 dkim=pass header.d=quantatw.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/bj018B+wt3+3fZftHIFn+PHQrkd953TkmVr0utHkM=;
 b=UeLMXB9F/n2ozQpOP9uiilo7cP+fym8BajMNrmYccZYL3EExtWyMdhzMS5EPZPNj5hGU3Zh3m8xiMQ5ErXTuv/9nKL+wHVbWYx6zSCFAa9gyvhTVulHOVzGey1jPp7s13lmCey2yVKLCzVwobjbOs5cY69AmhOqA0KF/D86xHKs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by HK0PR04MB2323.apcprd04.prod.outlook.com (2603:1096:203:4d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 4 Mar
 2022 00:35:29 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::b57e:962a:3820:eab]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::b57e:962a:3820:eab%3]) with mapi id 15.20.5017.027; Fri, 4 Mar 2022
 00:35:29 +0000
From:   Potin Lai <potin.lai@quantatw.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai@quantatw.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] ARM: dts: aspeed: bletchley: add sample averaging for ADM1278
Date:   Fri,  4 Mar 2022 08:35:06 +0800
Message-Id: <20220304003506.4243-1-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0135.apcprd02.prod.outlook.com
 (2603:1096:202:16::19) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0981b4a6-c8a1-4557-2cbe-08d9fd76e263
X-MS-TrafficTypeDiagnostic: HK0PR04MB2323:EE_
X-Microsoft-Antispam-PRVS: <HK0PR04MB232319CA01F14BAD758DA7B88E059@HK0PR04MB2323.apcprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J9cdfxlz14/Vc53rgpmjWbR/5Um3BWWHVPrRaZ3X6gd7kcWXFzRAxMAq+VKpLiIBiPwHWkJA6Z6akIJ4mpxE8I7eBIMBO/yL9IB0VnSw6YQM6abp1AA9tytacBHCfGp7vqW7583+3uLJEr+trWahez/AYgPtwC0z2XM1j7jjZDG5LBJQfheIIglCHWobjGzKSWohynOub4+Xi6MBNhIBB2LNz1Z+AMYQtA5soMJTZUvisoYo/AYk3WQsGuhvneB3ihovnJflEg28qifG7X0DYdtKQRB4ZDvYfPHM/4bQSVXg/Kf3Ue89bGCLgbC2JMJRGJuFChfisKVOOVM6UO8kTn4+yTRbIm8ds1gskUaV2peMgj40qSK8b8pswYHrVxO+cYBIQ/gdQghJsC5dVePhj4fnhBsOjsUfPfh+lYGaNqvqFq+xldzESAwRKsrW21t935vqcF4luwBdC265FB2kKGaXNcC56m6GgR0xTo0V+O5KqPzlntrv9gJ9bBKRYAp76dbPxCRzv/7WAFZfwM/TX556GjI89yAkiW+G4PDDHWET3F4xuPk28cidFOxeKCDVrvt2oOPj/rA03PnBy1sG5HIqJ6/i6U+b2bMoXvqWX6QwfH6vE7hnSu3hwd7PFre51P4CyKZJMLtv8rSa/f8NRJnTGEqdNVCIr1pyAkahHuYBK1PQOt0Ehme/+NAlNnVl0LpvRtrdbw1zuuaxRvMZ8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(5660300002)(6512007)(4744005)(110136005)(44832011)(8936002)(38350700002)(54906003)(38100700002)(508600001)(52116002)(2616005)(26005)(4326008)(186003)(1076003)(316002)(66556008)(66476007)(66946007)(2906002)(86362001)(36756003)(8676002)(6506007)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VLO9SLs3WpcR0nJGOofYlcrbXgIR9qQ1JYCu4WaLwlelhaHY0i4E0l2CIFlE?=
 =?us-ascii?Q?CGkBzMmVeZHNYDdtv55dH3TmmRuFOHvIk8Gn46Mf/lZ4Mx72LvXebQaYdrTp?=
 =?us-ascii?Q?QdZrfuOpfN4jp2VCQ1niJvkxViFmYxn4khTT9AibBT9aDmq378/1X2db8wzK?=
 =?us-ascii?Q?qHPn3r1Gq6P7BBUDf9YcWOw6/D7taNZp3AK2d6XSmFEb/BlizT1nN0pn1qyB?=
 =?us-ascii?Q?F2jfYPVI+3AukyV30krwPbDK9sqhDJz8Z8di53W38b/5vwcqRKLs38hi5sKw?=
 =?us-ascii?Q?G8kdtoskNJIk6GIksIHh3UH20N4Woxb17wjnQuYLydAc/wp275bI0TKZp6tl?=
 =?us-ascii?Q?3kdl0VPDUPULOqAnyHgn/KqW2XzHIgEx4n4EAR2p9Ftia2SjOtO0Klai1FW4?=
 =?us-ascii?Q?/i5JfGAZ7y1QnHBYM0cDouomTS8fNk+SxgvyOgNra7bTfbxRTde7zq3i4eif?=
 =?us-ascii?Q?GWatAapGcznQAxAYOLPiN/1VuKTX0eo1RuWXqQQqvltHbl7PcMb5sHZpHYK0?=
 =?us-ascii?Q?/H+PBim4/PO1MkeIWZMYYZZ4i8IF+vlgef6vz2qRo2VGCmHuUJOcSpqrT3VS?=
 =?us-ascii?Q?B36jxdrl54ZPrKZG+PUpRod7C4NokspMx5TdTst1Q9UbqXiulo+ash0Gv2/3?=
 =?us-ascii?Q?Gcxl1ju6EL3ml9iesqyJ2XVdI24VBPgZAqaNPKVNXszHuGsH3/CZi+RDGGQB?=
 =?us-ascii?Q?YsAwz9x7lmHwX6j8r39eDVZQnZyb5PHaYaKypc4Pv85SpYSHuYt5NPba8SMz?=
 =?us-ascii?Q?ccLSMXWphM8eSNIdVsfbDzTALRvBtUtOqi0Q1V3BU+tMRF91NYwO+FZs7oR5?=
 =?us-ascii?Q?6oDrxHRZLwcMDCntAcsxTFfb5qMlxe5oGPluiIMt36AqCtmpDutf2offUW3C?=
 =?us-ascii?Q?hvZFb3L5nqIwVMDQnR/eLF6onTXlPGvKbN1cWdXKfI7m4PiRDLHfDKv9TRf9?=
 =?us-ascii?Q?aGmXV9wgjk1G8DbqbVCBmIIElWkirAYLtUHv2POR0bfc9m+kBsIB0HbweOf6?=
 =?us-ascii?Q?NqReZExXnUXuHupaQTrt7kmfS42cK7qVaFFIVKt9ExKCOLYSS+WZhuC8u22H?=
 =?us-ascii?Q?2cPbNeAzsz8ZZOyhkyXbsz8bzu6bK2zogG8dx94gZfmg6ezbNoYf0w7UsnVG?=
 =?us-ascii?Q?MN+walESjq9TilpaMPC2kjAoxOQKAs2+n+tSjAWPFtLHPkSkGrjEWP+cQnxE?=
 =?us-ascii?Q?d3WN0mgmK2S9vbAq5rXvPiwd8trx1o2PpUza1NCUJSatgp6E9b+NnPx/rokh?=
 =?us-ascii?Q?SVOP+emn0tGcinjvZN0uy0Uhegofu8qKiI01HynlsL6fMx8Ov5gTVEP6m4Pu?=
 =?us-ascii?Q?aaJfDv5qOTEmq8ftb4mZcCveIRsEcQ2buCOD+pD+vNUH4T6kTGdGWLqPEiuM?=
 =?us-ascii?Q?bi9KH/g3baHBS1uRwGREudXxBTWaVWVs+e8ILV3Im3AnaSGcQPMgmrW1XnGw?=
 =?us-ascii?Q?WAUW83NXdpxowYWbH8gbtuSscdqC1mBNabsp5UJYdBD+fmFa9yd5EkkCZLn2?=
 =?us-ascii?Q?8sA9unf+MrtTrV+VrlP/r3afy5erYCHVH0LFaIc690n0dCP9pWLa2OEFf7Uv?=
 =?us-ascii?Q?6/xuS0xhg0hY/IND2ZZZAYl5nUFu/uJ9GiHVMcPZDIEoNA0hVeebMCJaWYGc?=
 =?us-ascii?Q?/SdOyCvLm4QXhQWUYQR6b4U=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0981b4a6-c8a1-4557-2cbe-08d9fd76e263
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 00:35:29.9035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2F/00u52Fc/v1upM2KiyBWQCNe9AHgguSZM7ctAoKKi0YSewgDWyJlYPKlt5Akfg/4XMzuezbDVBeq06V+S17w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR04MB2323
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

set number of sample averaging to 128 for both PWR_AVG and VI_AVG

Signed-off-by: Potin Lai <potin.lai@quantatw.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index eaf1bc261ee3..be76cd955129 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -732,6 +732,8 @@
 		compatible = "adi,adm1278";
 		reg = <0x11>;
 		shunt-resistor-micro-ohms = <300>;
+		adi,volt-curr-sample-average = <128>;
+		adi,power-sample-average = <128>;
 	};
 
 	tmp421@4c {
-- 
2.17.1

