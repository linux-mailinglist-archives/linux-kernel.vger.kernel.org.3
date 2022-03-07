Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97FFA4CF9D2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 11:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240273AbiCGKIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 05:08:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239376AbiCGJtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 04:49:39 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2124.outbound.protection.outlook.com [40.107.255.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B994F6E782;
        Mon,  7 Mar 2022 01:43:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oReBBcEkae1q1tRJWNlJu7nomlidklUn4FzELS/vZyZeadyt/FXsbShd7J3DlGXXSK0Z1R+QiUnJs1d3EecYLV6xr+gakEN2GA78ILG3u92gbIt2aedMcFv3IquBmgYQL+ofGdPZtYiwKzfVvXdGJ6HORTsYNrfsnx0LN+Z0Fc0isJCvj0FVnYpk7pxPGtSuc8m34Vq69acBvkyTEB/OQs9B9gnNwnT2xcqeqpCymZXgwFPbaC7kFyGeZEM6mAQML65YO2pbfWE8lEiVSJtujxe6x07KPF2opQ2HnebhjWSDy46LNfOON0Aa0ozWwqmqXpKdIUNYv0ub31Y+ggxd4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHSyRcdp4nLd8tk6RJf3f3HDLO7+7+jsT3clLNE0NLk=;
 b=MbAEg6bK0L4wOUjo4d9PVb/vXpxo4gnvZkYX9oTVCGAk99iGv52c0nwmzGIVP9EJGUe2SclAhQcq3aZ5HhI5eXkcH4x+r4QSzmrVfB6iIAVH6f00NNiL03XL+DdrKGETvbJsdw7rVHTxdTVjRlnBfcHhfNzuJW5RQlznXUEPZmUdRHocaZ2MlqfvZdtDEpUSZdfLvngm4qA9Cex/zIIPPqOzNJviAyQ1RAELdtkaVvsoNGHLeJ44B7mR5rJ0J6YeBYDRjHwck/6BNznLgs6N+NX25hva6WYCZ1BoeOlRiF1Dhlk8p0JOPS3Mnt5dRfcEpfuFAHigcc0+5SUIDTf4VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHSyRcdp4nLd8tk6RJf3f3HDLO7+7+jsT3clLNE0NLk=;
 b=Jbthxcxp6NcfMDN4zZW9Jbd7NkYVQthvbz57B7xoBzGEEcpdT1pk1xDDvLaIbu66Yw6n37ksEnL6vGSF44qGpjVCE1V1xaa5qpWuq9PpNMM4aY6FNpMaZhHfstl5ny6mgaZ7z7r/nxtuKly/l2CztjJiTL/aqrv7CjINXDinvKA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 TYZPR06MB4094.apcprd06.prod.outlook.com (2603:1096:400:27::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.14; Mon, 7 Mar 2022 09:43:02 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::9d3f:ff3b:1948:d732]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::9d3f:ff3b:1948:d732%4]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 09:43:02 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kael_w@qq.com, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] cxl/core/port: fix NULL but dereferenced coccicheck error
Date:   Mon,  7 Mar 2022 17:41:48 +0800
Message-Id: <20220307094158.404882-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0021.apcprd06.prod.outlook.com
 (2603:1096:202:2e::33) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a246a15b-590f-47a8-39a5-08da001edeeb
X-MS-TrafficTypeDiagnostic: TYZPR06MB4094:EE_
X-Microsoft-Antispam-PRVS: <TYZPR06MB40941EB3449D865B0467240EAB089@TYZPR06MB4094.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: avhaEd0WR064Vjak9i8lVoh8JytfIHZqVdKuxCknmCGSMcGPCp/7W7klVOSVVeaWOz+1R4ktj/EBnIBAPX9gK0jHwzQL1RNd2gh1Sh3q1bEIZQoye8zPZkYy8/Sv2PrOgOrzZn9fiJycpJCE4yPaYpAPnkmbPmgd7pHJPKifNMYAtWNcCxxiDOrNtmzMzPv51Y3Ga/bXolJkCBsLRHzqhZmG2IiBT8bJQoS0BwNIhBHm5PRAcd0eMWGsHNcI2uvO/F77712jzY8DH0YMhoLtmE7bGdcomfjqJD+NVnIp8vyFtQUarOCio8Yfm99htkcQYVpA5qMBpKNSsv9RVxiDhpKULozQmnZzD0YibSEsfdz49l+qLWwXH/8gAc0hQhq/d2y5tm8aNeLxxHoR5DmV6YzzLItuh2zssewPujxNhX9Q+PsyHtCuojMrTudO/O1YsscNQTkWNRxlmEjhTiKiUXnYHoeozdV8TZ0u20OqwpRaDNWGE30lrsTVrVHwCCbPoMMun3hoUFYdf/csj/+WZ0J+IzFBX6dU/45uYCZqESL24FndqnWHMoLG/+t3qaLAhy0K+YrnGzNtmvfNsUX7kdMu4FE54fbeAOWxKULmtuV2Q31Or5/4MzUMzgNRppTSgJjp0og+fBORwVRX1L8YULvGfZDPA8TSj1MNXqyFGyZgASEapeCDLVM9NdFeblsU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(36756003)(8676002)(4326008)(66476007)(66556008)(83380400001)(86362001)(8936002)(5660300002)(110136005)(38350700002)(38100700002)(6486002)(316002)(508600001)(1076003)(6512007)(107886003)(26005)(186003)(52116002)(6506007)(4744005)(2616005)(6666004)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?To6aVpMwae3Amw4SB/kuE8oY00NY5iN4ag18Pn4vNKXo50J2yvAkkaS5n++0?=
 =?us-ascii?Q?Y/okb9u+2ekeKFEs0c1jY0pmrIUKBDYAPbn4rQ/SLCHFlX42qkXbTkQgJUng?=
 =?us-ascii?Q?8Er070DfxOOkXPceymAIRF0xqMd7e74FVEU3P5ZOHS4vA4iShKK8jTR8i/oO?=
 =?us-ascii?Q?iw0mt2hTig/HkFP2G3r9yBCPYVeWAz6r5dUNrbDET6akDfsYx7YydFP216JL?=
 =?us-ascii?Q?Z6jhMZlP+p/6Q23JVV2CGlaiEo5tRderyiBRqnfVBTjC65dfPyCr6Y1m0rhh?=
 =?us-ascii?Q?6x4R+zYQjw46Kbdx34nukrO9PCnJP4GwGArSPt2JMlkiCJZY8ZKIc3dMG8xT?=
 =?us-ascii?Q?4B6SnqtJE9OtDHX2UVJ6qmBkeyXPJ80Rph83SkTbE/fQwJxgFeYNjEATbDt0?=
 =?us-ascii?Q?g4duNwyXx6CDjPDU3c+9bca4ZNfXiSxBKMUCtleqFLPFwvM3G2Oopo/CNVFq?=
 =?us-ascii?Q?HyJk1+kIkbETWtQRdelz6Huq0fvpp1lOCS7nvCdOhW1RD30zMODW20dkb9fa?=
 =?us-ascii?Q?NcrL49i6/y4QAcF6eQJmzM5pZxhGxSBL5uE3mN5zb7Xp15qGeNSGHSWzQoJd?=
 =?us-ascii?Q?HzvlI1Yf3AyZfIqHHnYOeD/SZVMEo1HzBlHTRgPyssQbWIWF1R/0vS7w6DgH?=
 =?us-ascii?Q?uahw4777HkYgMpsAm+PHAo3zcNxvs8Q4W8aIwj6if2vocvVDWiXDAazjHGA5?=
 =?us-ascii?Q?HWW/dEATexNulZ6um25Twco+/HnUFvxKz1eB8MuptDhd1L285+YQx1SnqnfQ?=
 =?us-ascii?Q?bPL9xVShgOaUHR2wnjEZpPKpOfwkrL9BF5g2quYO0gCzM4BLZ+HsJs//HI4/?=
 =?us-ascii?Q?lAHNnC92rt8ZYVi7/Y8lbejfVbf4PZk3BZ3hrnNKg3rLBopIJpCA3+JzDZaY?=
 =?us-ascii?Q?YSEK3iWkt2GfPrEluO9dpGMezWDlYB8k1bqQ6P4xNy645zFM9XmaH5Lb/8kn?=
 =?us-ascii?Q?RrGWL9xS2MLB44BlK7AnlBvODLXGyk1WaJB6ZUJmeREcsMUviwJ7bs1olZbP?=
 =?us-ascii?Q?XkgcopWHXEIkOwFvrcPEEPwznwIa7nAqOIze213ED8GN0kqvGKH4Flmxrcis?=
 =?us-ascii?Q?8YmFNltjGBZqzbrD9NQnw/VwfhJ+chJz1SBDcOMnCcG6Wnr3xNLvAeYwAqBH?=
 =?us-ascii?Q?Hed84VXWSeJQNhirYdnboTfif5q2LEVJw51trN0U4alfRNULw0o9ZxOzWGLy?=
 =?us-ascii?Q?PYEgVA3/LwdGOaSO5OWa5ZsaLMuR3Ba0J27g9hlf+mpMQoXjNTJdD03j1F/n?=
 =?us-ascii?Q?3uxvL4NqCC69n1sbvQREmyrgOBsQgLkTOHozWxrR1gr+enIXuYSWGcAPOamP?=
 =?us-ascii?Q?tkc+zgF4+QkkBOTmxSY8YmefxELrXyjDD1D8xRsblkXBmOUNB5XQJNOay2Si?=
 =?us-ascii?Q?OKDNzpIVhxlQ/qzB/W3Mb/I/NxpCGxWmpPqL5/HxUlrkzHtpV8BwSSZ8fttW?=
 =?us-ascii?Q?VmBF1D4JJoQyGGWxUbXMx4UsfGXkfafEQE6YC8zN9Uybp6u4jR1gi6Do1Q5x?=
 =?us-ascii?Q?KemcIrMqVFEY7dI+va50Un+nHK8OXSI9cmjxGAwQeJAg8acXrqtAuyAIoAM7?=
 =?us-ascii?Q?8CzV5UER8NfwShtzz3Q3tOAkBeFan7+BnYAZwmHI0F7fp4ePE9pJSMeTqkjR?=
 =?us-ascii?Q?Qk8hJywU7vPEx6QXBFxrTY8=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a246a15b-590f-47a8-39a5-08da001edeeb
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 09:43:01.9853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yaJ5QkS73+xrTiX3R+7N2RSk2RwsqBn9/Hwxm4UupQJL26cELkQndHyrmj7OFgEwpowzi5/p+fh/Y8aBiPZqsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4094
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:
./drivers/cxl/core/port.c:913:21-24: ERROR: port is NULL but dereferenced.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/cxl/core/port.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index d29eb2abdbc2..3349e9f7b89e 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -909,7 +909,10 @@ static void cxl_detach_ep(void *data)
 			break;
 
 		port = find_cxl_port(dport_dev);
-		if (!port || is_cxl_root(port)) {
+		if (!port)
+			continue;
+
+		if (is_cxl_root(port)) {
 			put_device(&port->dev);
 			continue;
 		}
-- 
2.35.1

