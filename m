Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5A550C6F7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 05:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbiDWDuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 23:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbiDWDtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 23:49:40 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08olkn2104.outbound.protection.outlook.com [40.92.47.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B270313976D;
        Fri, 22 Apr 2022 20:46:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zgt1yu64UtGJWUVVCxflQrWyG+jBbc5r72p1x/Qrk2Atib9ivFOXwP4DLErH5NAaK95uPY1jbzLhlUNiMygfkPHPcy4w1RX4qjS4aHtyXCnpW4HQAfe/XceOQhmNACrhEYV1pxRp6oQUG8oqJDN14I0SnEtRFqW1HeyViaeUY2Xi76ybguwuUlqefM2/dZltdbODjYNkt5M+2y1XGdHVzABAMw5j1iLwRFRSUdFf+kcTkvaN1v+mI7QnAy4okvPSTemiBdHI6lFTNxR1//08zvGsV/TibB8WY6IZsXhse3G0ewtJHodSOpKGLSiS1N1K4XDE2EBQ+HPmQ1yLA/hK8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TEFyQpoFygt63asuQVsE0XVF+UYmrJJETWTjkVoqdo=;
 b=kpnBrei7/Rkj3BNuyHsyJmmoCyUd+az7NGLm+saUx99MKjf1a1Znj+KzcrJFtttcUQbYWt6cUKr7HxfXnWIiE0b8wnCMw7H1oSrMxTL4QEbxpsG2+Gfn4x75FPoN4OX4lMNv43D9kistpQBAm1hAdiJ76C3Gf71yrMudZyKAmYAf0ndvH7yX1BlwEwHx9jO3zFRttfU8DFQwJygUcY94mDBQsWkE0pkZnsO+Ctg72skfRS2hu8nUb7AjxtGjzz2w8x0rRVTqztG0Ffwed71khPAqafF5JU1RPFfIWW5Iom00VoOSUp6ThSEjM1Gt2RTRyPSAEwVp1JDZcSx5SbyXXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from CY4PR04MB0567.namprd04.prod.outlook.com (2603:10b6:903:b1::20)
 by SN6PR04MB4205.namprd04.prod.outlook.com (2603:10b6:805:30::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Sat, 23 Apr
 2022 03:46:43 +0000
Received: from CY4PR04MB0567.namprd04.prod.outlook.com
 ([fe80::8e:6e22:f98c:29d5]) by CY4PR04MB0567.namprd04.prod.outlook.com
 ([fe80::8e:6e22:f98c:29d5%5]) with mapi id 15.20.5186.015; Sat, 23 Apr 2022
 03:46:42 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Tomasz Figa <tomasz.figa@gmail.com>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH 2/5] mtd: onenand: samsung: Set name field of mtd_info struct
Date:   Fri, 22 Apr 2022 20:46:19 -0700
Message-ID: <CY4PR04MB0567121FF1C304D782B07E58CBF69@CY4PR04MB0567.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220423034524.366612-1-xc-racer2@live.ca>
References: <20220423034524.366612-1-xc-racer2@live.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TMN:  [31aCKBWYxvekUmHCZrlZnJNvfi/1AJUPOl6OL4jNZaWYvHMCzP04AHwLqwS9nyHz]
X-ClientProxiedBy: MW4PR04CA0210.namprd04.prod.outlook.com
 (2603:10b6:303:86::35) To CY4PR04MB0567.namprd04.prod.outlook.com
 (2603:10b6:903:b1::20)
X-Microsoft-Original-Message-ID: <20220423034622.366696-1-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9508204a-d12f-42aa-6e7a-08da24dbe16a
X-MS-TrafficTypeDiagnostic: SN6PR04MB4205:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /8IaNIf5He4Ia/OtVPUH4CG+StIaos5VoAgfgQrPdUjmZwZA0bMQF93YnmwFOBdhJV231g4TDjyitW51/9LdEnmhkaQTa+InDEmwmxBG9KiBUZVarsqIHW9pQGvcTxhAoerALrpZ/OriiJI4i7LINIg1xDBnv5n2SgNYjuCrWKlthtJ40HBa31Yn1tb9uIk10fWc68XN6CVLkUcmJEDaVWLATfjvT86e6t0pczdP/W70pGdEPATpFMBeq4tI56UH2WFe3biZiu2a+u6QIzQeorQ291gAkeviP+c3QMY2je8u//LrP/e55r5FS5A19SGi8fYCEafZn5aX8MYZ+1FlxAaalAYMehFe5eMhF15UAfqHOxWh6Q22Ifo2QCh3hzx545MO4zkmBKbfLnJMNSJyllwso4Cv3oslqOSKwgiwf/SzuJGuKIhsX6dN45dAu0LAb2lh58oG3WUsJFw9wM3al6xIM2RHrKT9IY6VYfOKdZbPEdas407a4maJQ7MLJZMcQzX4X20aODmKFvwTquVXrCU/5HVOXhE4skBbbHv5cBL6QmhjewRiFdVb5pw86IVfgDXs7IRHuSuChc2Qx84OHg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWNoNVZvTzQ4Mkc3a1ZxZlhIaTVuMVRGaTQ1VHFVbU9KTWUyN29tSXFxODlo?=
 =?utf-8?B?VDlOZlBFem1iL083eGJveWlUU0toRGJ2aURVYUNPRGFici9BS2dZZEQ0QUhy?=
 =?utf-8?B?OTVPZThTNXEvcU50VmVuc1FBZWt6UzhlUjc5NXIwSURZRlNCRzl5VWxnSHps?=
 =?utf-8?B?RkN3TEhIM09BalhiSjdtd3JFOEtlbTNJV3JlcWFiVGlCN3AxN1JpdEZyTVRN?=
 =?utf-8?B?Y3ZCSzZhbFZ5ZjVPWS96dkR3U3d3TEg4dU5ZeUVZMXNobERSY0JVc3piS1kz?=
 =?utf-8?B?dElLQWFzNC84ZXczZEtQczk5NXcrbEF1ODVvQkliajNlc0d4VzlpWThMb0hZ?=
 =?utf-8?B?SWt0ZVBSTjVQN3FabTNOelc2QlZENGJrRE5tK3Bubm4rNWVKeVM5YnVpa0F0?=
 =?utf-8?B?UWxTVjVxWS9EOVZCL1pIeDluakhqbS9JZmNxS2cxV0tnbWJXU1M5bEtCYjEr?=
 =?utf-8?B?SzE1cFZER1VRMnhra1ppVzNJeExQbXlHZkZBQS9ZWGpKUVBCVk5JZWhUMTNk?=
 =?utf-8?B?d3RRM0VGNVpLY25QeUNRbHBvSC8yZXJwamVQQ3hUeWVwUDE0YkpYTEtOd0hU?=
 =?utf-8?B?QWhxYVlEUmp2YVpudDRLRnJUaTUrNW5kTG9UOXFObUlWNHhqMFA2TFpaWUlY?=
 =?utf-8?B?d1lBVVU1dEpIV0NtQSt6dUZoQ1l1RnplQThNb3ZtTnhTSzlHVEhmUFoxMTNn?=
 =?utf-8?B?SS9HM1hhMlo0djV6TUJMMnF1N0M3U0k3eTRmenZaRWwzcUc0ZHJ6bWEwNzgw?=
 =?utf-8?B?VEttU3Zlck5EY1JBVTJRd25QaXhKK2QwUjRLU3hMQm9BU0x3VXdpRW1qdFdM?=
 =?utf-8?B?MjQrb0wxR3Z1N2YvTXdZdExKRXoxR3IzWkZJRlpsSjJsdW9ZT0Jid2xqZ3Qw?=
 =?utf-8?B?SUdKZlJaM1hNRnJXYmJvU1BJYXVhZ0o5TTcwL1pReG43ZUZzWVR6NWZGRXRw?=
 =?utf-8?B?WHlPZ0hGV0I3aEVqSXVWS25YZ25UaHdITVRmT3JtZXpud085NkU5NVQ4SHhL?=
 =?utf-8?B?OEUzazd1anRPaDVXMkhsWUx0RlkxS0VYc1VNUG9zTExxMjcwak1RZzZXVWdM?=
 =?utf-8?B?QVd1UndVblRKZDI5eFUzdFpvOFZHdGRLUFhTVnhycldkMzdRU2FKSEF4WFd5?=
 =?utf-8?B?ZCtKckZIWFp5bytHZ3JjbUtZQUh4SHJNL0RnK0NxYmJEdTdtdnQ0UCswVWxB?=
 =?utf-8?B?by9SUEhYNWtvc3RmZW1aSnY2aTdOMzR0aG5FRithN3pLS1hDdUdnM0NqQmIz?=
 =?utf-8?B?MklEWExKVFdLZGxZKzNKQlA2dVpGckhjdWFOM2JuYVB6VWFzNXBXK00yMGlM?=
 =?utf-8?B?S1ZPQXc5TVNyTlNQN1R6Tk1tOVpselYxaWx3NU1wSVZIZXhoSlViNWMxcm5p?=
 =?utf-8?B?ZXBOeWRZeXpOaFF4dFd6b09udWljaXVrWnBtSVdLMnhRaHdkSFRXd1FONVlr?=
 =?utf-8?B?R0VHbWNWUTZOVGQ1dGptc3pqU1JPcU9wVVRnQlZGMWhFLzIvL01qbU9zcXFV?=
 =?utf-8?B?SEY0d0hVNkE5Zit0TDFWeDNqeEhtQzZUbW1US1hEV1ZUelo3S240WXNDSVN2?=
 =?utf-8?B?TkEzZ0tZbURqTXBnelg5ZFdMWWczaTA4MmxYRmF1R2RzaHM0N3ozOTdYOS9V?=
 =?utf-8?B?WFNFM3dOT1lCenBCRmdnV1JtWE45TFY5VlE0c0RvVUVGMGNkM3EwUXZERGpI?=
 =?utf-8?B?bUdBOWtJeGRodndTV1lGTW5laU5rcGFESVJmRS9MNk14MXA1WVVXOTBBSkdM?=
 =?utf-8?B?Z0lXUnk1aVpnNVh3bDRzd2xxb3dEaGVSUlFMaXAwRm1VbWdGWUczcUFMZTBE?=
 =?utf-8?B?OFRpT0g3SFZnVFM5OFgyTHh1QjBxVmFsanZETkNlWjU4SkY4L0VLVjJEQUtt?=
 =?utf-8?B?UVUrQUNqcDFQaTBHR0d4dklDVml6U0JmZWpYN0dISUYwdTc5azZQV2dCUk5m?=
 =?utf-8?B?NnRKNERiQSsyUFBTS3RqNStRTUxMUFYvYVVoNGlGOUpUWHNsck43b09PRnNG?=
 =?utf-8?Q?SjSwQUejowjCIo3KN4+P89BtCcl+4o=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-edb50.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9508204a-d12f-42aa-6e7a-08da24dbe16a
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB0567.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2022 03:46:42.8851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4205
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomasz Figa <tomasz.figa@gmail.com>

This patch adds initialization of .name field of mtd_info struct to
avoid printing "(null)" in kernel log messages, such as:

[    1.942519] 1 ofpart partitions found on MTD device (null)
[    1.949708] Creating 1 MTD partitions on "(null)":

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 drivers/mtd/nand/onenand/onenand_samsung.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/onenand/onenand_samsung.c b/drivers/mtd/nand/onenand/onenand_samsung.c
index b64895573515..924f5ddc9505 100644
--- a/drivers/mtd/nand/onenand/onenand_samsung.c
+++ b/drivers/mtd/nand/onenand/onenand_samsung.c
@@ -853,6 +853,7 @@ static int s3c_onenand_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	this = (struct onenand_chip *) &mtd[1];
+	mtd->name = dev_name(&pdev->dev);
 	mtd->priv = this;
 	mtd->dev.parent = &pdev->dev;
 	onenand->pdev = pdev;
-- 
2.30.2

