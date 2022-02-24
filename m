Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014764C2238
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 04:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiBXDNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 22:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbiBXDMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 22:12:36 -0500
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30040.outbound.protection.outlook.com [40.107.3.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CDE177D03;
        Wed, 23 Feb 2022 19:12:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYtQCB66F2nNHjC+J2HuaGG/xxeieWSs1NIK0GpXxiE9cnO7EDLEBxQy90juVjTxVtEJvzFG5vU7gJP+4vbZxbJsTjMf5zIwaLy1X9g3YqbAyYH4fzSxDIlupmDWOvu9VRBDAyyOED++HzdJhgEDHPt5CALtE116w/diwOrx10JIZOedSpGHXwyM5o2Hm3fWqbbLAAvf5EGBD2btXbAuDVYetYDaALZlKaJEowXrShrmvYKMioV68zMlGCW1VOwtxVvUYutGD5FVU7Nfa2G8eay6BLyyK+aVCCnqtUOhGa6pUkXS4aujtL2yTypY/snqrVJ3pbWopCtBGW+HMyJn7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clbsh1pO4bSa373v+VY84oyLQOD0KBQLDvU+XkwxmLw=;
 b=d3WlcMITs0cSxf8sLk9zkZXR8F+IEECwk8UmZIb/C3Pskgib5kfTEMCcg+XPDInmoYOdhxwuHmW3RFkiiXoYPn8DBdVamHfjAdgHzQ5L2B255K52G33U6aVez9ycZaPxoUOAezx/9F31VrNxNomLuNTA/etSR8UzzEr+J8ThKxGLfRypMiDIH+ORcHMUQbBQ7SiRDJAmcXdCYQg43Qyonlr9/F/DgJtaowTd3B5v/gYhzpAySF87J75Xoh/zY4AFgSykrHeRH1HG39ax0/IxJOBLrwwiUxJ1waCNQ9g55U7iwFVVHFGR6D+rxGUywWlFqGFNQE7lkXMsHq07eft6hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clbsh1pO4bSa373v+VY84oyLQOD0KBQLDvU+XkwxmLw=;
 b=Guye2Jy9O78i3dvEFHc3gE4HItwzURyEO52M0CcvL7pyYXtPD3AKDVxK5MQZZBE96z21hL4zpsUkzJ1nkit9i2zwnBHe8eEZp+yegVrN3i7HHi1F2QqaHU7BvWBrtEQtuXdoJLN2g7dn92oA4NF6CSNTurtwSBG0+G8ztQzeF6A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by PA4PR04MB8013.eurprd04.prod.outlook.com (2603:10a6:102:c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Thu, 24 Feb
 2022 03:11:58 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967%5]) with mapi id 15.20.5017.024; Thu, 24 Feb 2022
 03:11:58 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v18 14/15] arm64: defconfig: amphion: enable vpu driver
Date:   Thu, 24 Feb 2022 11:10:12 +0800
Message-Id: <679ffeb81363dbb650cd139f7bf4cab9bc176244.1645670589.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1645670589.git.ming.qian@nxp.com>
References: <cover.1645670589.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0029.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::16)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b40ccad-3c82-4ec0-2f9e-08d9f7436b4b
X-MS-TrafficTypeDiagnostic: PA4PR04MB8013:EE_
X-Microsoft-Antispam-PRVS: <PA4PR04MB8013B0388042018B64241E79E73D9@PA4PR04MB8013.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KdI+I/r5hf0pBptR3jQziBFgyHqaHk5RrOmc86lZ3M6N3jaOcVNMGoISGNy2bDay9LPpfqkk63JmiY0bYcK/29ljHqu118+6JMk7TwGP5FrCaGs+cIrdXAIYenJkarZGYTQ0T5r1If30xQuvsgqPQKD0GX9+TL50dSrWrexzZKN08O6c9Pd4l+H/1J/h58+aJ8+1WunFaoCo4Dyh8TROvi1XfCeLpiXruFld7VOL7qVS6nKgCl7lW9mscN5BYxBDY498ldSDesl3BLsor38rIGM1S8agyXxByN2kUd7YuVEeJO8uTpubU7GbTsdYwQiNRsJ9aiaYEQ2hauvYXBIMTTnwQmwkEsrBbiypGS+Q/DPnRA1rW8pBpPEeT7BNYJY5XiJY9TofYbhuwCQu1jmZr4YXGEY0+B8p9mb0ABdlIl2DvmsZWtP6f0TM8V3ziOvTQ1OiLxDUb9PdQ32pYdx6j6i+B+0yN0tGfFXQDbxi93KjcytmVDBWeFcJ/Dbi4RIH+CzgaFH/HgPSMKeq6EiQ3pJzOwuJQwoMRZDO3X1rVCyn/EETeI9UbPWGAFsXsyiJVbwZIUpBAKJw9djSs4FWkFUO+IcABpv/8N85x/HUSzRqJ+g7RCN1HeAdDGmSwpw/SRRSNEgkLYJDSGTWQolM7778KRBg5TP7Im18TFF2ic8nZJShioPcbcCCaNi7nkEEUR1dZxvzK7Rw4E/FvjK5TA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(2616005)(44832011)(6512007)(38100700002)(38350700002)(186003)(26005)(5660300002)(508600001)(6486002)(52116002)(6506007)(4744005)(86362001)(6666004)(7416002)(66946007)(8936002)(2906002)(8676002)(4326008)(66476007)(66556008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ad9j7suHFGmv+XPfJVQ88HjPhpuEoIYE5lb/JyTnRopFUxtjd2C71w0CTVlR?=
 =?us-ascii?Q?LtiympQ2eUrMRRUg9b94SMyqqOn0d0C+kxibnjw6ShumhuA4lPIgeN2knXCf?=
 =?us-ascii?Q?buPUPKHAlhPJOxm3HEcWL/Ub4zS8O6pOAe7elGEsma4KA9iYjwXl+xCqzvx7?=
 =?us-ascii?Q?9WRcv8gSC//eR5rW68PYJIjn+S2fCX7lPBw8L0YIh24jcsN+0PmTEcdDDQ1G?=
 =?us-ascii?Q?gVJCeAGaOnnhRbr8AOXnJlFXCntJVUlRNkR41jUfLsc2NezIJIAp0cM/TZda?=
 =?us-ascii?Q?DwcRoi3lKWZq9Fjd6LvIch8Iip1GIR61FxiybsJmX1y3UqPCWW+W0vFqcUzC?=
 =?us-ascii?Q?jit3KrxqbiBtbwLUJphlls+iPihgg/J5XFeyrx3MlswxDVnPLkeo5uzpkS9c?=
 =?us-ascii?Q?4rQ48n1rDGz4/Rs08iemY8WviEJ4/xln9/2i8xxhS3PNb75vLTM/jFDb8kA6?=
 =?us-ascii?Q?rl48krPJqHVHvJcahBEI8TT0h1d+Se/1+YCmT9Bna+hRoADp3QiLpBY9Np+W?=
 =?us-ascii?Q?Z6UYE8alYEXOvcq4bROp8R0cW8fxs/4bw4TJcPyiA+MM7Iixwq3SonUUt/aj?=
 =?us-ascii?Q?4xJ5We7Nk/fBIozBFwaFSfxivySvlJQu78Sk3E9DABdb/qy8fjMsA3acGYDX?=
 =?us-ascii?Q?XyloxpU+15OvZXyHTlU5iMIZ1YLmncn6GueP88VoW6Tj86fZWC+8WLWpuugL?=
 =?us-ascii?Q?mkOm5tvWNzLeraWpx+duNmOopEGNG0Po9cCf0NhwAGHD7wpoi+y2TMlCaqtH?=
 =?us-ascii?Q?4RV6/pRc7N17F9yj5d+7TKBC0Rc7TKSjo9aXZ7UzrtnPowXQG4/QALaEpwNK?=
 =?us-ascii?Q?7FbijwURiblNZonQjV1C/zifTyhKp4grwb+9e2SHbvigVKPz/5Em7srqcPcY?=
 =?us-ascii?Q?vRLHddBY/wxm3iHAVkHtwqO1hQ1pCIWNSBLZvICRqqPc7cIPn4hi3YxPxS2L?=
 =?us-ascii?Q?JdUGRnTw6uWK3gaRVyFcD5+XK2mlT4vTeFl0SY40ry09olymWD7kG7sOK//A?=
 =?us-ascii?Q?lGhoTbruHfxCfxm/hYv+Q8P12Zp/mCHWo+FJz4oxJGTIGdDwNgvuOte9XVPe?=
 =?us-ascii?Q?WX3J5+EZaS4FqkGV8AgFeJYIHChql4d+RwGCyYpEU26ua/tWInKnHPTt+CHN?=
 =?us-ascii?Q?QTgVP0yny3KJsHeBSE/Okt8IC5cEBe0rkp+Wg+LiI1FiUdX3ZAQ49xTmveue?=
 =?us-ascii?Q?AvVKsXFmiwYzVWM8fB0hdahPAnlPTtuNIuGrqL1B3mbi0nIEhvqRTLiuPtoz?=
 =?us-ascii?Q?GscmmbS6HiTjvDHaGZ/upR+9C9leKr7fzOQps6h5AJ2c1oSmM2LnCMI2hDqv?=
 =?us-ascii?Q?qetxkuf8iMFteVXJAOMXnBO1hqsXKISd4ADEKrpHbtY90bZqHp0vAFEhvTTA?=
 =?us-ascii?Q?2mwTMxrElnKKgCWaGH7OdiyQwuu9Z4iHxX2y9TSmAQVdx5IMRUIDTLJFL6OT?=
 =?us-ascii?Q?P5gvqXNDmUA3l+YOsFT4UIV444Vecel5dPr11AlfjpX/IRcaUcZT4JDwKIpN?=
 =?us-ascii?Q?Io9fLavmMDUsd+I7ic+Rr2zxCu2G4Jr0ZrMHYWdJCtMo5HqWMfOWgIiiGgFK?=
 =?us-ascii?Q?ZIIPz2Bf0ZIJAETNdJbt5YvZ0pV7KxXKfQPMfTbR4AN2x2ODVY8WWqyU4OLr?=
 =?us-ascii?Q?2nbeFn/Gza+/wl+760wCQk4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b40ccad-3c82-4ec0-2f9e-08d9f7436b4b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 03:11:58.7407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qh5azOk10wD1i27Z8OiAk8vkSxNu/WCDyRkYs9ZLHMgLdeqPEnB+wJTFtuYFDYCHhZYDd9aCckqIJ1KZsvtYlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8013
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the amphion vpu driver for i.MX8QXP as a module

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 30516dc0b70e..63ee67dac6e0 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -670,6 +670,7 @@ CONFIG_VIDEO_RENESAS_FDP1=m
 CONFIG_VIDEO_RENESAS_FCP=m
 CONFIG_VIDEO_RENESAS_VSP1=m
 CONFIG_VIDEO_QCOM_VENUS=m
+CONFIG_VIDEO_AMPHION_VPU=m
 CONFIG_SDR_PLATFORM_DRIVERS=y
 CONFIG_VIDEO_RCAR_DRIF=m
 CONFIG_VIDEO_IMX219=m
-- 
2.33.0

