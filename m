Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678EB4C11BA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 12:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240263AbiBWLm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 06:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240177AbiBWLmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 06:42:13 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60075.outbound.protection.outlook.com [40.107.6.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A24F2B1AD;
        Wed, 23 Feb 2022 03:41:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTnaKGydzAJX6tFrHxj+5RQ0mJwhCQoE6j78feZQeTmkOHVYBqeZ0qXqGJFsXzR2eOJUx0j1q3upqT+rHYytEN9NH8UwXRf/ZPomBke25J+JUEBKZjL0r6iN9LtFNOGBg9f52W7hb9fS8yhb2k8rUJ5F+5WilngFOkM229LaF8a+jNdC0yDmhibUtwS23jvTH1Wo9TCKFsKWmP47GEUGoR+TzuOZ+Br9ZYhLxvs4y+UyxXAtgc7l59HnMRNmA/EBAoUrpLMDUtha15Io/OVPLJVoLLJJn72kVPyR3gpXLiX7cplzDN+neXRgK5M4V5dp3WGprIg1twx3GYvOQO/bfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clbsh1pO4bSa373v+VY84oyLQOD0KBQLDvU+XkwxmLw=;
 b=Ovc4eozdbt+EnNehzHcDUgKXQ+HQ1T4tCkY+MjBRGE0Mg+tNO/LKcGq5i0zOkteIqOaH4vWKIavU1MljkDCwU3yKUDhRt+R6l7sX18qYhiOIf9Jsmo+k9djoBj/hZIabprFeERAGYgSUgr7rJJ+pS5T3uUA+NF/eZwO6IFJqh2eVubDGlaiVhCox1PimOdOXR8LigKWmls0PRBShcSZnIR/fseMyhIo8lp0jkoerQcqMlJhr307qqCumOWoHflxf4tr0QIrQgLQvRg8Z3qywiTYRjQeglA3S4D3wfNHYoFnvmKXv4lLoMkW+85SVs5lSc57VrHWt3SI7canUGzj4cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clbsh1pO4bSa373v+VY84oyLQOD0KBQLDvU+XkwxmLw=;
 b=CPC0vOa2w8TTwadOoNmC10hv8gs5gqxoL/BfVv8+Xl5gQShMyDZCCYpNSSzK5XX45nhNECPoybpmRivAgSO0g+g8zuvoPrDJQIdSs/8RVhIvMOL9r0CfU3Y7K392Kc7OeI+e3YaEZE4HPcHt3IF+iLd9PCE1RWa/dWxp24mCPTk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM6PR0402MB3416.eurprd04.prod.outlook.com (2603:10a6:209:6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Wed, 23 Feb
 2022 11:41:43 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967%5]) with mapi id 15.20.4995.027; Wed, 23 Feb 2022
 11:41:43 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v17 14/14] arm64: defconfig: amphion: enable vpu driver
Date:   Wed, 23 Feb 2022 19:40:07 +0800
Message-Id: <e185eed7783f5bd05222211e6a61dcea3a3b1f21.1645615976.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1645615976.git.ming.qian@nxp.com>
References: <cover.1645615976.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR0601CA0015.apcprd06.prod.outlook.com (2603:1096:3::25)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae9e3ecb-47f6-4f20-f2c4-08d9f6c17694
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3416:EE_
X-Microsoft-Antispam-PRVS: <AM6PR0402MB3416A9DACF84C0678C41BFD6E73C9@AM6PR0402MB3416.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ekJ5f0PiAGjE03bD9Kg16P7EH4ZCUeXcYHmhIXwxOEmQQLg6NEd+d1dK5dxFxhFHqZGnCIBU/FWfDW2dAmdwt54sj5k+mGqjqHRTLYtVE+gflIkLWSknuIEedlL4OV8DGf8hyLP67DUYa2YcK2CyII759nWuZP+Jw9iXhEsmyxhoTSrFAWM7a3uUTVJrfeOWRj5W+05x29SQwMOgOxU3Iu7epROa8NRvL0SQnmK+bVTJGsHactMkW8qAuY7d28mdKsnn4BYToFPR9Sl/mcq6DrV5vyVKpffVMEZ0Mw7VH3yLtORFVqwTKgvjAHaV3G+PnDDQF+0mDNiE/MNRrjjGeVL+NeZO2U8/5XItUGED/rxFFtd0dH5bSA4lktM67oVjyfOoAXgvzEv/OczRxg8bMXUlBp5mJ+F2FRRUo7vMd5mVX+sx/oVeFv12Rln+md9hbYSn/j1vrCoPcPWXLcHDSDwFfqKFEom3tSBsQNYZtkGscjozG5f+RmPYVrWpbnR7qzqshQn87QmOu3g60smmG6AdWV7I/Ib4NhqV32ZNT8nvXK/SPM/S6vVWfmFGCVegzACFiqUaqxuuE52VTZ35mJtaschpxuWnwUt+dbjTu27famKBbL/NmBfqC3AX3rzBhyyjsOirCk3v3xmYVxhUGgnPzICKuk0njkUD6Tv04s1lN/EH3oAox5L4gN2PNUmQWrTxwRIyGu2xQQ12dRtj+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(2616005)(6666004)(6506007)(6486002)(52116002)(508600001)(38350700002)(6512007)(2906002)(38100700002)(66476007)(4326008)(186003)(5660300002)(8676002)(8936002)(26005)(66556008)(316002)(44832011)(86362001)(4744005)(66946007)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qY918SKPpCJdiwntCA9rTRW0mXOpSuRLwdRbu/TfvDw0HpZ8mdh5fuETtFol?=
 =?us-ascii?Q?2FExGSJBaRF54z3blYGDi/rP26Dq0yUdGC8vLS/GkbmXLSXXcoQOOUb8R9By?=
 =?us-ascii?Q?mmAGElPUpE9PJ86yqEVRbkdpRoLjgMckfuz/wb5aRJuMJI/G4UG9BDlUK0or?=
 =?us-ascii?Q?EW+QQxa3J4r4JNltOfn+J1aMeZCgPwq5ZsXLcirJ9lkWaFYlMzRqSZUOA98a?=
 =?us-ascii?Q?mCUpbHuCcr4apb2iF2OWWjIgi7prIrFCypUjMOtKdgkEaFNBPW8v6opHrBkc?=
 =?us-ascii?Q?Jh3ocJhEOknlgMxAs/JPDHrGonRj06EOH3Dzc/XPdjsG1NBGM45CEEeF3U3N?=
 =?us-ascii?Q?mdA95XTaypQQfYwpSOQEtALkNaGMYEUO5QtLmNfcFYGOpGu0Vj++5Eo3GGjt?=
 =?us-ascii?Q?mS/WJ4nFuOTW+lEYFybINUGEfuqQn9wgMbuaCsnPcMQrN9eGPwcfz0e2Z5KB?=
 =?us-ascii?Q?6KcNA9iKzolmemw+c3kdPiP8JV1O4ebJX4+JzWrtGEqKzckbx3qFaBGis9tQ?=
 =?us-ascii?Q?8AKbwFaSt4+9S9qqMpHSKubjd/NrdF38OgODNVC7oSBaZLlclfkFrIBx6bf3?=
 =?us-ascii?Q?3HnrjhQIg9bKu7i22D3xVhjNIY+8Y6oTQSLuJTxP+YF7zRIcT132+PQG/T2l?=
 =?us-ascii?Q?US//hNY/f7zw8mleyilZhpWTfEyTcClX4iEjTv5l82SqLwxgBlDBGsoV3mKx?=
 =?us-ascii?Q?AC2gcgmtVjMnNWwNeOEWaONf0X6mKRLRXQR5pDv2PT8tqwWf40ifVUSusS+j?=
 =?us-ascii?Q?sJU7NQHCnt2unxOWuHVFxSXM9W1zAy8kKtLnU7NfDJpyMI+oytqOBgcXRAUO?=
 =?us-ascii?Q?68akhVhiLUPNQTa1kHFVaeTz6BQm8mwCHvk0kNqRvT0enbazhxZxQzKiKSLo?=
 =?us-ascii?Q?K9tiKam/tjH8P9A/ycJAKytTfA371wAzR4QnOPmK9U8MMCe9WMQZAk60bKvV?=
 =?us-ascii?Q?9y+VKGvtpnUM6LTAEWIF2QmR9XEQ1zeigS4gINtC4JDVjLuZUjrxgP+7JYRE?=
 =?us-ascii?Q?iiaIdzVD8mtsvu2cZghgnVyb/PG1gqnDaDlLJbXaZqMMlj2APpFOANpn5Oma?=
 =?us-ascii?Q?fA0yZ7HftOSzO0vkWcGIYb5FS9SBzkWf7n18jT8hlpejGhwEkVw7jL3PB9G1?=
 =?us-ascii?Q?S8sxZVak2caQuvpDtADbmAPB+lT+wAasIKafl9/Cvz7SYsyW9Wh7EngsoTLm?=
 =?us-ascii?Q?uFikiEeqKXPhWHW6Ya9KzYg8y8b5B9Sf+ytBV6DRFD9nawDQTj1gDfQaDTK/?=
 =?us-ascii?Q?nH2o8BAcF16n8nzoKnrjlb9jPJVBborOmjCHZ8tYGHXnZv2FEO5v10GkmLT8?=
 =?us-ascii?Q?X/mVXFRuu4DnqEXFrOV6z/3/nnpZqvNQkgzVaetKpPqX6DaC9ukw8IdxP9VF?=
 =?us-ascii?Q?x/I+bx+ks4oX2WLLVoFnvf+VpOMzqoi4f0emKDFeZCqt1dwSRmCDbn7mBV9A?=
 =?us-ascii?Q?lCuDHffB/+E62Bm9Jbf3O5fv4JUKvZsJF6Ue+MTHi8uP9vnxsNr7hZEnBEIe?=
 =?us-ascii?Q?vZKJq+/48JkjYaO0k7gglzvNGjBeEa+wMFmHDnPFAr62CrwwK6A13NtW7FMB?=
 =?us-ascii?Q?ww0KDGQSpagvOJSnGI/7sfVNoZt0gKBo7prhoTHk+9mvLFey+3V2TmzX9TRX?=
 =?us-ascii?Q?KJ2wbqP3OWI6a4ItqW4hxAw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae9e3ecb-47f6-4f20-f2c4-08d9f6c17694
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 11:41:43.0885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UouTt+e9XMA1P63bYyBVsM7Yj/jXbhtRfqs4mwwj40RWj+NyH9nEackZJEGarsQkc7vmdHpGpR+9nDiVX3WrfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3416
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

