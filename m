Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB23E50AD81
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 03:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443209AbiDVB5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 21:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235265AbiDVB47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 21:56:59 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2136.outbound.protection.outlook.com [40.107.117.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EAF49F2E;
        Thu, 21 Apr 2022 18:54:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UuLejdUOna1rhhco3zikXAg3HLkMSI1o8oMo3rsc0etBcf6Nod/vGVEMu8OE2Na6KAMEvWP6m7nUpbAjhS5yMGR6THEucA+B4+ANwGvnu6RHpnAFMmcZcK4FCCX/eI0fjTsnECZKqD87GjmPmsl1XoW4rRyE9Q4YvCu5UyEOYzAAgU+xYGyiNCu9Ucf5Avj0GApk6bl21VdxPw4X53GkbEAvapxfctXpjZXo2EaEdFKUBIAu6HrahlovWnK49WmeIjc7zuVKcLWE8jq+cWpGteiixrLMXOA4qXc8Fjx1L62diJlbv23qp9nBI0QEx/uggtYPn0FfSQVav6FKzBWipA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2X+/SYs7ZMYql4wn8ofMeA8B+vbIFCOmEMvl2h6a3qQ=;
 b=QvkhQ3K6T4PcYB59U5yehmdOF5epncOzHHij1BUz4CTgz3YMjygRQfdGLqEOK5vWZvDo63KMJWG27Vqx9EGIjnWSWYdiXXoNRlQvptPa6J+Df9bj4gEDI1TiEqNbheM5yE8MKGoDJHB4M0S4I/byv/7JR+I+yKIgg9jvSXP+hjajZlrpkS7STDXYqaNu+6oKYM5d0RuWm7GeQRFU2hmDOsuaE+z2gwTirNGyas2VUQu0cTQuSkJhmo3JjYZmTJjCWDBbCrNj+hjZ/xyofSoUIT/ZvqqbocmGZou97D1s7QfEtL3h/3kcU8Dr6L6fBI7wfKtnJW/1rcIyor9sdMBSGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2X+/SYs7ZMYql4wn8ofMeA8B+vbIFCOmEMvl2h6a3qQ=;
 b=VD7PsKTTOetg2HyN1dPbz687Kzvo/LQOsoDPi4Ovlh/fakiv5Imfzzg+eTKKlB7hyzXrJPJBYyOXw5g9/YztWtovWLugtculXu6yWSnMxv5CQEMgvoyQzIF7/iHyQstvz2CWUbVrAtwO3RxyRjyKiI8D8L+ZueOF4PZ1t0qZN2Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 TYAPR06MB2143.apcprd06.prod.outlook.com (2603:1096:404:1c::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.14; Fri, 22 Apr 2022 01:54:04 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::4591:4f3e:f951:6c8c]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::4591:4f3e:f951:6c8c%7]) with mapi id 15.20.5164.025; Fri, 22 Apr 2022
 01:54:04 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wan Jiabing <wanjiabing@vivo.com>,
        kernel test robot <lkp@intel.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2] of: Add missing of_node_put() before return
Date:   Fri, 22 Apr 2022 09:53:31 +0800
Message-Id: <20220422015331.120632-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0003.apcprd04.prod.outlook.com
 (2603:1096:202:2::13) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26eac4e2-8549-4100-ae02-08da2402fa16
X-MS-TrafficTypeDiagnostic: TYAPR06MB2143:EE_
X-Microsoft-Antispam-PRVS: <TYAPR06MB2143AFA6B740A2AC9B44D90FABF79@TYAPR06MB2143.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k4tiz/j+rWxLymcdVR0V1inQfOkXIdaIxjnqAqMygS3meURNJIBWuh2wBenkg09pSl7rjGHojPqalo43IY+vzWgqNRy7KOaTBEZmOBL1eAixwjJD54Mj0IZLEDdN0dTIHT9yv1EfIJwv07xiFRtlhk6nc391K5x+qE2T+GaKwx3X4IpUTcm0aGQaP6QaobYCkkliWSggODVEvGHvjqnkR9Ifu57jEg9spfRISXZPoEkbICghM9C00TvrQvoH8v3dwGXVfDifafz/K6eBlre1KUA9vc8QRnJRkgbZ7K9IBPOnu11kEk9L04GZhKwswvfzEKlmtuxapIr3nGMBAYpm1X62zAE8lJlkVKo7k0sMtAwoANw3ORfC6JJpJ1AWobvFTFUUB3/cEVRd/SeMkHtXuSLRHEmyuXQ9kW+mKSQigbhgKvSUrMDzsx0niuwTQQBmJ6rN8juo2/JXZwT/mm+1pV+90lJW7D//zdopuZGxfaHmG49ndjB423UxEQIJI37RkoAlQCRxBJZ9pKrLyeCUR6vDjDrjCKYLzSJ4Y3jE64SAPov+rTWVF+uI1L4PVftCT1RzB30q51OYuUe047k5cs6QcfHEfoCdOt5+dsS7Zig1WD+s1ikBaRV70H0uCJY0+ollCWQCFEQbddDqXoxzR0738D2DHOFwr+3e+PlPW+upkVYIzce7E16VEMG10Sz/GRqO4Iva7Wet2nkDcZs8tw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(66476007)(36756003)(38350700002)(86362001)(38100700002)(2906002)(8936002)(4326008)(316002)(66946007)(8676002)(54906003)(83380400001)(26005)(2616005)(508600001)(6512007)(186003)(1076003)(6486002)(6506007)(6666004)(52116002)(110136005)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VQnWg9i58n0O3RAc/UYX2gmb622MJPuS/aHB1ZntstWWXW2KMi9aXnqextIp?=
 =?us-ascii?Q?+i90RBnJtvPVN1MBlyOFSIBf6ove1TCpvUkozoFRRN5CWLXlg5EpMkyxRw2d?=
 =?us-ascii?Q?qyeb8uPc82DfHEwxgN+eq71oyetyx2Hj2UvBT88wNTVtL6WXqJOnTZFWxfKr?=
 =?us-ascii?Q?mDCfN/JgqlvOQC/+jADg5VXzRZpU39DWZyipyYbr0N5srcQY4DeUATjgU8KY?=
 =?us-ascii?Q?56tbHZIuoAxa3ywTEJUIuDwJEd4hrEuf8QYEGkSDLangiFgWzt4Ls6YmRUKj?=
 =?us-ascii?Q?QrU5EqTUb7tnOwcFBGaCQ4usTXq5FfBqLPvoCXNHBnTUMqFceZesUiwomOHo?=
 =?us-ascii?Q?OSOwCHblE+5ZJHqr3wcNArR8B0pnplplINHQ62/1mqmYxwQNxat8mqkeiwHO?=
 =?us-ascii?Q?BwdUm/A77yAkV7T34moKT26vI+iBjtZL+oVD2ZP4/VjTUffU7xogYJEcBBmY?=
 =?us-ascii?Q?gdJb4iurbUu0KzfiYsdo814tHmKwDhsAPvA43TAJ7vdHENJR3NmbFKlGP96R?=
 =?us-ascii?Q?H3PlxUXbCFD3mxl5W+heplzALnoN+lqPVsgtntWVMkytmm5Fc837wRB1bNu7?=
 =?us-ascii?Q?sgTkou8RD2qsnoW0pFlRo4xOq33WQOUbT0z7lIi+aWjZto4L7pT03aHx7uLb?=
 =?us-ascii?Q?DlASBdEynBayRVs1jQsvd9sVpxJtsTTkUjsVnsiQbVcGTtwn8aImQ3rAB8I3?=
 =?us-ascii?Q?yj1SWXffmZKXmhIbt/lNvtUHCe5+ELoZLt926BD9QU4IUe2MdUnXjVwREz2+?=
 =?us-ascii?Q?wGrLkQsw33ZgtLlV6bRq9RLfM0ArYfQOwKcbsD0EgI87qkzna0ATySrT2TkJ?=
 =?us-ascii?Q?pmCET0n4KZNDjItN2zIUD1IS5eF6XR2DNmSKVabLEsounl21cTZCMpKB7GjS?=
 =?us-ascii?Q?KC/wb8zxhbrN1bXmbzNrE1WAs1en6muM2xlD/GB32Bm/UFHg0mums1U6q0D6?=
 =?us-ascii?Q?ErzgQTaejrJC5C6U81rFN57j8xzIexbM8Gw553X95pPOAioSRCkCbMJAC2CX?=
 =?us-ascii?Q?S69ObigwOqKuwsIJfHrcIqokuaorE9nNlM+Lv8FLBQO+FQHCf4Q51URfIc/N?=
 =?us-ascii?Q?l7Vl8Uab0qspA92/tBGEZIzqnG2aEYYR0FDmAKiVIJkIskRdY3PQ2TvXG1G4?=
 =?us-ascii?Q?zjzgBPnYhABTCOnBGuoHXvfcrl3qJZlpOUSZwZPgJVwdCydGV1bY6ITP03BX?=
 =?us-ascii?Q?iaBGbUSE7BTYWceGSbmJ5yRGrzbYR7PbUc4ARoJDjcd3Z1UwNGcuQ7dhtolW?=
 =?us-ascii?Q?dO0xA3OxEN9UC1tYRZ9JXruz0LCw0gA2q4jVjGodlDkTLm8eAOD9m1f4wlnj?=
 =?us-ascii?Q?XYy436UK4jQ4+FWlezwaaKL+kgJmU/n3UD6pncARCg6fSWGuKHk/0VwiWNdk?=
 =?us-ascii?Q?0KUDG4M93QzIjJTUywOm2xz/6QkUQngV/b81FlrNjvWVJOx2dp0WS6sfR63H?=
 =?us-ascii?Q?f9ug/ZqRQm8ebvVr5rwFbUsc/AANfGQ78cr4WXVuVuQiaNdEjj3Y1sQdOb4o?=
 =?us-ascii?Q?JLgaB0Dprjyl/Ks0VgzqHtcd01xIvhPlf+UYIy3wFRf5DMii0G9evzGOzUIa?=
 =?us-ascii?Q?WgMHkjwq4Cqs9xD9HtuLcrH1CoZWr9OkTbRwARD6OT1qFo+Kk5yPKMyj1jX5?=
 =?us-ascii?Q?YaZtkz8rTLaMBKWXvRDuziWGHr5GdYkAb6cE2iuMuv8vvmBV0M36KynMCO9T?=
 =?us-ascii?Q?NTMYuwiSyTRjEK9XfyTyjCneLhUdm3BvaVGAWI7tuizfdfijRwJ5UD8ckgX6?=
 =?us-ascii?Q?4mxToxVUGQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26eac4e2-8549-4100-ae02-08da2402fa16
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 01:54:03.4264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sWt2dx6hEpW2UYAyYa230Kbv0nBsf9jR0ABKM7zgqrBZUDWEs3hIVOxtKIJYujruJqU3P17q2Com/LIJJEsK4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR06MB2143
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck error:
drivers/of/platform.c:554:2-23: WARNING: Function for_each_node_by_type
should have of_node_put() before return around line 560.

Early exits from for_each_node_by_type() should decrement the
node reference counter.

Fixes: 52b1b46c39ae ("of: Create platform devices for OF framebuffers")
Reported-by: kernel test robot <lkp@intel.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
Changelog:
v2:
- Add a missing ';'.
---
 drivers/of/platform.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 2dff3a3d137c..1bb895feb06d 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -556,8 +556,10 @@ static int __init of_platform_default_populate_init(void)
 			    !of_get_property(node, "linux,boot-display", NULL))
 				continue;
 			dev = of_platform_device_create(node, "of-display", NULL);
-			if (WARN_ON(!dev))
+			if (WARN_ON(!dev)) {
+				of_node_put(node);
 				return -ENOMEM;
+			}
 			boot_display = node;
 			break;
 		}
-- 
2.35.1

