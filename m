Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1694E50B335
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 10:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445619AbiDVIvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 04:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356251AbiDVIvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 04:51:19 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2092.outbound.protection.outlook.com [40.107.92.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1AD532F1;
        Fri, 22 Apr 2022 01:48:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpiM6sjwJllwUsr3EzFq64DOeKo8yq2xr/nMg4shvDp05QInirTvH67Le2LFq+MlvOezGB/rBgHXCUHUK3UCrq/rrFYsMQwf9wiPWf/pGPzsroYZ6j4us4YO/qqiQwhVSOlHi1nnNeXCyfgNCUz0lcFoMQ8LFKDqrFWXezu0sjs/ysz5btNSnR/9RKuHXpQA1sE8JTj5mE6DRg+bnnj95oAB+nW/iWb+7b7yAtZsMTaKUkhaBrWiOEns1DY7Edb1VS3XnRcAP2U65OifPJreOoTmWEse6sGXp6Sj3YNXgxbZgpUmLaA4AsV4HyAEu8q7TLcIyy8HaA61E/sB9Ous+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=501iF2AV4C5p/d0y0TqDX+5vG4iDa3xVgLp9nMtmVpk=;
 b=AlFayE/WRy/igpVRuSqAKqczFxetdzAI59lQJafjNcbQDfhXui0RSVChIwFo9UfXTS7cYVfUKN9dsghmN7e2cB4pLqdw7C1dQcTgrkbVukZtCjujEfRTlN8fYRghrSB1FOW+QsCnVlIWkm17b2TJXUJTy9fIqjKT8OMmEn6ZuCyXv9k28gpt+u0VWTQt6OQLBJS8wwzAeChQxzHqPPk12Hjxkn/e7YnUjuo+bn1nf4zHKcOQIIUbqnQk4TjkYSTYt72yZ1/1gmjsTYkS2WUafZd9HaTD57KXtmyOIdMOvf5mcFjE+Wi86I1JAdhehWaKpJRdUSnnJSfdwUzcujKfrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=501iF2AV4C5p/d0y0TqDX+5vG4iDa3xVgLp9nMtmVpk=;
 b=OM8UsKvyeZDhcuyKkQis0j19yzU9+GkNG3mQ2PRCAXfOOhC1aHD+Jn647GqJNnPZrp6Gsg4a2pW5bTH/TA0LXSYGZy8oE2cuWUTrpLU5L1FC0m16GZT774VUJUDeWBGuk0QDiWtGee7AdsjqqXohpEReyEf4d9+nTG1t5BqcMfo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by BYAPR04MB4598.namprd04.prod.outlook.com (2603:10b6:a03:55::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 08:48:23 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::e9ba:4c90:6e9c:39f]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::e9ba:4c90:6e9c:39f%4]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 08:48:23 +0000
From:   Xin Ji <xji@analogixsemi.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     robert.foss@linaro.org, bliang@analogixsemi.com,
        qwen@analogixsemi.com, Xin Ji <xji@analogixsemi.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] media/v4l2-core: Add enum V4L2_FWNODE_BUS_TYPE_DPI
Date:   Fri, 22 Apr 2022 16:47:15 +0800
Message-Id: <20220422084720.959271-1-xji@analogixsemi.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0019.apcprd03.prod.outlook.com
 (2603:1096:202::29) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd56a55f-cf52-4cca-fccd-08da243cdbc2
X-MS-TrafficTypeDiagnostic: BYAPR04MB4598:EE_
X-Microsoft-Antispam-PRVS: <BYAPR04MB45983B2560F4CAFDD08B228FC7F79@BYAPR04MB4598.namprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CmihFpe/8o6ZOrgnWv6tyt+ZqP2XedvAaNcZ6JzdMSc2+zbJ5bUZpmKKG4borunU/rigX6nZts4m6GE0yc25u01+P9yybW180q7EpRMCgcPfcMuyGdNAz219S0Srw1wXqwHAkVd3f+VHO9ZjxARfwnnmWE0uroumEgFLThUjQOc44EdccrziUZXFwdja1gl5+YnIZTtOO7aWc+1BtdLD87vx4o29ZV7uVZkIkwhFh0nNoJS3UXo1TezDhlQFRufOCUNfdH0mY3QXvaVSeB3ud9HYtHqykpaSyJZpwCmLuaJqMtjV9LRMiBK/eitBH7cquzDFXwYNWNjUh5OHptEtd2gnsh8fbSioowxMQuOyLxokiWStUJLzNzkt6/KE6YaZp3Rlk0Zy4LnCZjvmeMbP6nwCB5Fr9LlQ1rybeWBuoA+GRfKXhAJdAsVRmaa37AXi5cE+qejNqVEmpTnNBXR9qckx4fDkIwOsqzmrtPW3eRthPB8+sBO2Heg0mJg59f2mvHkX1u4vfoYZfdkqibfVnzUvRXoECiluWqhMavR3UXnUtJY76DqYtr39g4VqZM5ugqijn8UfCA8sPK2+SezMnKNJ2O+yHsKLw51go3uwprgZhEFxpIac768DbQ80soRkZ14dSKxyWchf71x2/2907ueWsq5Xqz7LEKe97bneAfhhS0wwcV/K5qWDhhkYKWTp5iLXQKoUbjIRMhVPDUPwqi94zSbpwV/Q7GZ8XtvFk1Zd4QPu4E5goFo9p6lFVRs1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(8936002)(5660300002)(38350700002)(38100700002)(6506007)(55236004)(508600001)(86362001)(52116002)(6486002)(6512007)(6666004)(36756003)(66556008)(66946007)(66476007)(1076003)(6916009)(26005)(186003)(4326008)(8676002)(2616005)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vThAcfEN6cE0YDHZHyDQS3gDe8FnD55W/f4+tg4NlqeLbBlu4vzvy2A92GtC?=
 =?us-ascii?Q?+8bfr2ai+0YrZaxz9bVgAma2VA2RD7Ext9pED2Sf4NDEvNZI0m/QHq7yC5aV?=
 =?us-ascii?Q?Vql5pwtmhVHOppAW64svgQ6Prgo/EH25jAKMhwuLrMPMuRrse2yDn+vxsF/U?=
 =?us-ascii?Q?1Ks8MOSZfAX2uc43bA6twwH6KlUziqnSwgA7Tf6SVI8CN6/6Iv7lolLOIC7h?=
 =?us-ascii?Q?gL5+QOFHWfRioed4I/Tsqy5EugCuM3DZfAA21oy3tS6ElRvoxP6E/MAWgC2s?=
 =?us-ascii?Q?JHdIrUYpydQSavC0UBqzcOWsUrm545rDldsdoMVOzgT4ydFwxkj96bLYN1+a?=
 =?us-ascii?Q?T/G84KYbynR1O6MD3kZw3pqFbozgheKC6mAGcl39PsATGQfeFUfJ00Xf5JYd?=
 =?us-ascii?Q?Syzyz0SJmWC28ie2FqRm3jQNiqPAEV0Voo+Ic/s3h5w9HntOYDzBkZ7N/Zue?=
 =?us-ascii?Q?p/y3iNDZNRm4IsgUlG9otpA+mppZi1slfMmN/Mi4WojbQ7lQZv+C/zYHj7qZ?=
 =?us-ascii?Q?3xhlLMYBTHtsBfUN0tho4Jhm1WB6iLRH/Z4Ln60NS9nkr3YZ71xB+d5JAJNk?=
 =?us-ascii?Q?LdFVMvyvQ7I860lkk7A2Rwr70pfjxKpAiXetNP+k5tLaeYno+bJdUrfluj4C?=
 =?us-ascii?Q?4nS9IOQCNpyW5/ZSgrMaq6g5vDeA87FcVo5xAxDXuxm9fx1r4iH1x5oE3i6l?=
 =?us-ascii?Q?E/W2MUxhxJa5tXscPvjzEhQnONFfvksjAZCBlOfnf+gQTcfy/RYinojLUcJp?=
 =?us-ascii?Q?Kajxm4b10hYMLWIRbd0EHU8vfFH7L1iJuwKfg3KBRnpxDB5zBsAusxSfZ8iA?=
 =?us-ascii?Q?o566SuQP6lKy4wPZ1K9ef6Y5WCy1mSmTkEwqj8TMyUmGuXncaxKjIlVRzUNB?=
 =?us-ascii?Q?PY1yNg1xSSwQ7rHeHLn0QZzwH2Jo98VaUZvQcmZmMheemlNojanFLEANtdUF?=
 =?us-ascii?Q?iFQGy8K94be/CUK5R0lpPKp9T+t47+M25Cpsu4K9RNnaiIwYfIX+YLj7hNr4?=
 =?us-ascii?Q?YTrM33scYIx4BWsCP76802ylDb/48en/Rklahh/aBp4lYVrOf8gpOoMOabNV?=
 =?us-ascii?Q?otP1dGhN1deXC63B2EIKgIYS+uKdh7nsVpCkqauF82FuKn3gPyg5HtX9ELgW?=
 =?us-ascii?Q?Vtxr4/VXb93gBiMBzPA5VNV2uCK/1XAQ/0HF08gtS6LjB8eEUTI4ScPYqWnw?=
 =?us-ascii?Q?rCHBbROejNCpyFDGcYlr6KNad4LSg6Y3KeBRMPoIE3CeoJgkl4pELYri4aWa?=
 =?us-ascii?Q?dsVZfcZqni04K0+DfWWnaU03f8ggS9zLVnkpwmmiivxjRd3LNFiwbWIxW2SQ?=
 =?us-ascii?Q?wRBZ4VllpUr6j4C/Tn6E93NudjsMjCqpsbnDdEhB8r1Y2IiFAH7nyTQvKIOd?=
 =?us-ascii?Q?Ir9BR+fqTpOddopBEHucWziGRtA+Ef4CYsnSevBW73zUT0LR/NMtlyJ1UbNe?=
 =?us-ascii?Q?MkWyf6xlnYywpYAhNOT6Gb9pTjHMnBk3dfg2EjT0SQugfHAi3lzqbskCC5XA?=
 =?us-ascii?Q?hnMX3vI4d/SO5rV1BLTzVCjmvDnZi+d+Ae2Pr6gPsOQT4aIJsI2OBSe7p6as?=
 =?us-ascii?Q?QGLkvk/YQidDD5eStpHgqNsfsA7Ag7fXMjufxHz4yCqB3kjAXiW/2T1q7eoG?=
 =?us-ascii?Q?0QxsXPEhOz+YDFJkvJpUHstaZ7qD0hrXy5hJ64TMwbMY7L/um3wAZUriZ8of?=
 =?us-ascii?Q?8ZGatkCm3+9AxknVUgk1DlGJnasYuz5o/UHBqjmt+S+0z8cZo+bduwpW4NQo?=
 =?us-ascii?Q?pwE31EBT3A=3D=3D?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd56a55f-cf52-4cca-fccd-08da243cdbc2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 08:48:23.2160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T+uekX4QSs7GhkizLvBi6dhrAqjpy/NOSvMuSZ1wxsJWVyp8qyeXJAnM3aX/YCINuBHwkJztIl2vxDY6cL7uXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4598
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As V4L2_FWNODE_BUS_TYPE_PARALLEL is not used for DPI interface, this
patch add V4L2_FWNODE_BUS_TYPE_DPI for video DPI interface.

Signed-off-by: Xin Ji <xji@analogixsemi.com>
---
 drivers/media/v4l2-core/v4l2-fwnode.c | 4 ++++
 include/media/v4l2-fwnode.h           | 2 ++
 include/media/v4l2-mediabus.h         | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
index afceb35e500c..3d85a8600f57 100644
--- a/drivers/media/v4l2-core/v4l2-fwnode.c
+++ b/drivers/media/v4l2-core/v4l2-fwnode.c
@@ -61,6 +61,10 @@ static const struct v4l2_fwnode_bus_conv {
 		V4L2_FWNODE_BUS_TYPE_BT656,
 		V4L2_MBUS_BT656,
 		"Bt.656",
+	}, {
+		V4L2_FWNODE_BUS_TYPE_DPI,
+		V4L2_MBUS_DPI,
+		"DPI",
 	}
 };
 
diff --git a/include/media/v4l2-fwnode.h b/include/media/v4l2-fwnode.h
index feb132df45a3..15e4ab672223 100644
--- a/include/media/v4l2-fwnode.h
+++ b/include/media/v4l2-fwnode.h
@@ -173,6 +173,7 @@ struct v4l2_fwnode_connector {
  * @V4L2_FWNODE_BUS_TYPE_CSI2_DPHY: MIPI CSI-2 bus, D-PHY physical layer
  * @V4L2_FWNODE_BUS_TYPE_PARALLEL: Camera Parallel Interface bus
  * @V4L2_FWNODE_BUS_TYPE_BT656: BT.656 video format bus-type
+ * @V4L2_FWNODE_BUS_TYPE_DPI: Video Parallel Interface bus
  * @NR_OF_V4L2_FWNODE_BUS_TYPE: Number of bus-types
  */
 enum v4l2_fwnode_bus_type {
@@ -183,6 +184,7 @@ enum v4l2_fwnode_bus_type {
 	V4L2_FWNODE_BUS_TYPE_CSI2_DPHY,
 	V4L2_FWNODE_BUS_TYPE_PARALLEL,
 	V4L2_FWNODE_BUS_TYPE_BT656,
+	V4L2_FWNODE_BUS_TYPE_DPI,
 	NR_OF_V4L2_FWNODE_BUS_TYPE
 };
 
diff --git a/include/media/v4l2-mediabus.h b/include/media/v4l2-mediabus.h
index e0db3bcff9ed..f67a74daf799 100644
--- a/include/media/v4l2-mediabus.h
+++ b/include/media/v4l2-mediabus.h
@@ -129,6 +129,7 @@ struct v4l2_mbus_config_mipi_csi1 {
  * @V4L2_MBUS_CCP2:	CCP2 (Compact Camera Port 2)
  * @V4L2_MBUS_CSI2_DPHY: MIPI CSI-2 serial interface, with D-PHY
  * @V4L2_MBUS_CSI2_CPHY: MIPI CSI-2 serial interface, with C-PHY
+ * @V4L2_MBUS_DPI:      MIPI VIDEO DPI interface
  * @V4L2_MBUS_INVALID:	invalid bus type (keep as last)
  */
 enum v4l2_mbus_type {
@@ -139,6 +140,7 @@ enum v4l2_mbus_type {
 	V4L2_MBUS_CCP2,
 	V4L2_MBUS_CSI2_DPHY,
 	V4L2_MBUS_CSI2_CPHY,
+	V4L2_MBUS_DPI,
 	V4L2_MBUS_INVALID,
 };
 
-- 
2.25.1

