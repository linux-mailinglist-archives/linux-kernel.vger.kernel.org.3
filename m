Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD254ADBDD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379144AbiBHPAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379104AbiBHO7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 09:59:44 -0500
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30042.outbound.protection.outlook.com [40.107.3.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07ECC061579
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 06:59:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SiYpMkffwm2zrxRQjIhX/REi2uL9gNBMqGASD2ayWWbiIRWd4PRu1fQ7zX6oo9HCwe/2Qd+96f2M2dyBZQzlt4/Z6u9Eu22csN70EgjeGbZ6vHAKLauSNQQrSv7Vd5MVN6qhnAbzXfShd8ev0WCxFB6xRPW64zHoTwtTJqwPdRKDh1Oj/wXCuHd1P8PZ9ZuZ41qB1soU6z5ivjCYqj4WTiYHyLRIRD6Af8B50VxSjnXLZe8BfEdyJcGzY4s+suP+yxEpT2NaS0UvObLp32O9Q9Qn3yK+Gky1SpSLhhXA3RwjveBMa7VzDOUjlArV9HT3BxNkjM6X1cLlTjGcsz0BDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zp9WvG8u/m3csNO8MZjMsh5YCHzDETXae6QZMPRyjO8=;
 b=k3OpI2LH3992IkBe7tBdxfZ1AkgQRs9BRsG30CtOBqYknIdDSwUWqQYNXq6cEHd9Y0ixBCpqIzrOJc/WFFudjby8FQz2awxjgWvoAIa01T4IZLREkqoC5UlNM7vC+zDUhzfLmOt9zbONoRXjJBm4ytJ9uEa27DH+S05s4jUI1Irmts76WAAngFDcJkVZTkHUj7SGvNWtxmJMGYV6vbFHUclq+4K5oQrro0JieTL6k26u5vow3RzqCKBQTaOYpX6ya0WdPUwwEcPGBBubo5oy1yL+l9gmzu/SFr2j0378huNrM4VYox+bs+93oMK7sPavjafrgrO5q1KJYsA3icGqEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zp9WvG8u/m3csNO8MZjMsh5YCHzDETXae6QZMPRyjO8=;
 b=sUturYqMswkxYNujlxmCH6IvGiOrd1dghuM0/rqILK/5G14IdVwbnFaJmVbZ+44M0b2Uc7rd9k9AoDbdORukgzodLumpNRrP5ha2FYO3G1Af3B5zSIOtIFN7eg5JCRWZPvw7dNK56EVnOxGKWILvu1y9NciFRFsIg0PEIhNerCw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by HE1PR04MB3018.eurprd04.prod.outlook.com (2603:10a6:7:1f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Tue, 8 Feb
 2022 14:59:41 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::f826:3bf6:b77d:5a53]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::f826:3bf6:b77d:5a53%7]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 14:59:41 +0000
From:   laurentiu.tudor@nxp.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     ioana.ciornei@nxp.com, diana.craciun@oss.nxp.com,
        jon@solid-run.com, Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH 3/6] bus: fsl-mc: fix double free of the root DPRC fsl-mc device
Date:   Tue,  8 Feb 2022 16:59:25 +0200
Message-Id: <20220208145928.12468-4-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220208145928.12468-1-laurentiu.tudor@nxp.com>
References: <20220208145928.12468-1-laurentiu.tudor@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR08CA0025.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::38) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0405d3db-4b5c-411a-6fa5-08d9eb13a26e
X-MS-TrafficTypeDiagnostic: HE1PR04MB3018:EE_
X-Microsoft-Antispam-PRVS: <HE1PR04MB3018D880FD2A014B7C3ED5C5EC2D9@HE1PR04MB3018.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e6RvCam0YohuF74l6b/LSpzDvmO1t/lhxjKOQ3gWKqHzzGTibbb0JSR/JHU12S7I+43a8UUmpmnyZEmlw/KBk41oiIk6+1yc1cyWbSxnfo3Ql25CaWOAyVtMa0cxvB/tAWNu/y9wxao1Rvh1tuTS+jd/kFRvpH4hyCk0iQiYG4T+3CJzt6x9FwzavhqK/G201aPusdclDb4iFwV9neLdHIJaTcgWCbZGnXQTPe4rRzHtgrDl1BKN8XoX5kY7h+FBB2cxgaw617Ob2KV6OlKTRQLs5ntr/o3GEc2VRVq0UPpS0HEvbiZpVE9/YAR05oiFHriGl6cpK3G4VOeg5QAp1Udd0d/0Bi14c8eHM/auY+LCEBSmEWiME0PVB7dFC/xh5d3555A1Y1K1ui4yGKKla5jw3QX1d0ydEy4/QGQcafBlkV65pzB4t4GE8CB2dhKLOuxtCg8yGsqYXxKzXi0XCtZIYAGjKOQjKBuWiF9w5YQ0kV13n9bdTel3QvZkH76FSady8zzlLpx7PKsD+4WIgWWt97VhfhQTXMVBxrkdxfkiqaw3mezrpn0AQrbYleUVyyXV3iDCmizh00YSkYg/EwrfDQ11pujGsvBoMl3xhJ/DG7eQYgKVz8VK5Jja+RJTtc5LDR5jahP0akv2HO6UfqBggn+6cbakdLyJ4T4RL3941AvUGsFjK4EhY0JEvehA9QB+Vf3SpTHJlFTa0kPRuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(6666004)(66476007)(316002)(9686003)(66556008)(508600001)(52116002)(186003)(6506007)(2906002)(6512007)(1076003)(45080400002)(26005)(5660300002)(6486002)(8676002)(66946007)(4326008)(86362001)(36756003)(83380400001)(8936002)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XX2XmiL39mOa9QE6k5bpY8+2SgV+NsVEPFH/MYbONRIScs7F8g4FMN4UFvi8?=
 =?us-ascii?Q?FcSR1TilZ8KRDckLyxn4ZVyByTplT74+/hHRJU91EZNL7xUspo98zc4Yr5o3?=
 =?us-ascii?Q?NZ0XCwrjhWTndzgbFmbjEnINyoj1odxTYu1BucXkVaYEwEhXrskUhL9c3M8r?=
 =?us-ascii?Q?qinbUI0CVcDtkV5R0COyUvkoxRbeg47mQBuWlGhESMdiTElD+LSyKs6PZWBq?=
 =?us-ascii?Q?7cEYGV3QXyJG+2p+jWKz5+akanJQwypEG1SgmlE/dcsYyMAu+OnYHoXPvcc0?=
 =?us-ascii?Q?jR4mDkG4XqN7qXzhT29QepgBli6OAvpa5CQmJEW3RjTV7lhdkiz9wyMfhoQA?=
 =?us-ascii?Q?7q4cfsywrX/2Bpe1t/SMTQZ5qx7T4AVmHzX3NCJKXGbwQ9ezSCGmrVxWcG18?=
 =?us-ascii?Q?e23wcZZkDALqJAV6ceNG3tcxkhCCaBXzSw27UciSQj+zBVGGpn1QmYJ3vMh5?=
 =?us-ascii?Q?RET3CHGOFGX8jPpH5Ap5n/7DSt3Xxk5dA9kaIgUJuiF81Vfx1jo7zW5eevD2?=
 =?us-ascii?Q?RdnWmD3l4acDR7HHU3ZwEx1HzfdAtA/UORsqPC3HZHxR2Amyi7D2MYiPywqC?=
 =?us-ascii?Q?ZIom0R0Aaado+7UygcBxoS0w5q3OvX1FZhNRFykLr444PMx9XDQtf9frrB++?=
 =?us-ascii?Q?RwTru6jnFCkOmak7x5krPKlxuYTk6N3LwUFEnE6IIgASBZbgPOsuvNErIQ43?=
 =?us-ascii?Q?qPEKLabT6/BJ8wNMYtwX1DgKsTrFWaZi4fBG6DZNd27WkkwozF4FEGLKCcvj?=
 =?us-ascii?Q?juIR6DHp5NRGRCAJpDOhMUM7dU1vvOVRHm676QcdpZ7aONUIzXdwcbZct4SJ?=
 =?us-ascii?Q?b3Wzk0IrVv79C/9jCnfHyLcawRr0sI9xuNW6wPonb1mj/QtrlB0P0LLyIUUu?=
 =?us-ascii?Q?t4Yegemd22tGvWVfC76oGudgOCBxwmXFb2puIfzB0cvcjC0R1SfVdxeTyN4f?=
 =?us-ascii?Q?xccDLbTyaFGhk5HEoSfdudi5z+eIuOVYAJKSFztvmX46GCRhPcyNdHjY6/Ik?=
 =?us-ascii?Q?rbecehr/md3YKAioCdW4ntVNJ7yH2aGLp2B6IZB+HkNg7giZZeCCKbJ7g+pT?=
 =?us-ascii?Q?hVxh/niqFvJy8FRBZfAxUIY52IQ/2RpKITEY594zjpsw0YJhDyVpcy3MrV02?=
 =?us-ascii?Q?BwnBcEvzKmM6JF7OEU5aSvhQvbe4gGXUJUrdlNkcaY3Y0iWv4dOKTM+ZpqBC?=
 =?us-ascii?Q?CFsN0w8C2Tz6CP5z+ImKh1TUZgC0bVQwP7nq65bIeMNWx90sQVO5xDuv7H4+?=
 =?us-ascii?Q?70vqbPjRloWXa+q5/jfsDBmoAryFn+KTLmb1q8JnLmf91FXeWQdW9ArLdcQL?=
 =?us-ascii?Q?wYVC05XHV/tL2cid0ObllU92gejFqWYJz5mhxOyWz2TgYPs12rHfJwMQXclB?=
 =?us-ascii?Q?KigVF7/IDOgjAjDNopudK8Med4Zwft29WX04O8P+DJTaJtSXPvTek5XzS4AB?=
 =?us-ascii?Q?BsUIxkQhvp9TCgIYppuC59cfLqbWQJ1o+jnzTy8bAl5I71NXe2r/NzgMWY5d?=
 =?us-ascii?Q?yoii5Blww5UAP+BLq4JozqhqGg8B0KlIka5hJc2Zeex4jmkXE7aWsNC9i3ic?=
 =?us-ascii?Q?+6cC34UE6qCcqHixoYo7CzkH7TB2ku0+hXvhAIGGIJB/RRxZyAjzRgKN8qNR?=
 =?us-ascii?Q?NQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0405d3db-4b5c-411a-6fa5-08d9eb13a26e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 14:59:41.3406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +YWhMnxvzfym0wRAXXYNYiU0nv4LUDNZ3iIlwlKw0mkShBFyRIwNYxeIP1NzSMzClg/ASZM8ONpHMHVi/Bz0YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3018
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

By simply calling remove() op from shutdown() op we end up
deleting twice the root DPRC fsl-mc device. This causes various
issues such as the crash below [1], on reboot. Re-arrange the code
in shutdown and remove callbacks so this does not happen any more.

Unable to handle kernel NULL pointer dereference at virtual address 0
Mem abort info:
  ESR = 0x96000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000006
  CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=00000081086db000
Internal error: Oops: 96000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 977 Comm: reboot Not tainted 5.14.0-rc1-00221
Hardware name: Freescale Layerscape 2088A RDB Board (DT)
pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
pc : sysfs_remove_link_from_group+0x28/0x94
lr : iommu_device_unlink+0x94/0xb4
sp : ffff800012b3b8c0
x29: ffff800012b3b8c0 x28: ffff24f8e061a940 x27: 0000000000000000
x26: 0000000000000000 x25: ffffb43783811228 x24: ffff24f840a882f0
x23: ffff24f8400cf000 x22: 0000000000000003 x21: ffffb43783bb6e10
x20: ffff24f8c9641040 x19: 0000000000000000 x18: ffffffffffffffff
x17: 3236366535672d31 x16: 323230302d316372 x15: ffff800092b3b537
x14: 0000000000000004 x13: 0000000000000000 x12: ffff24f840467af8
x11: ffff24f8404c7d98 x10: ffff24f840467908 x9 : ffff24f840064b98
x8 : ffff24f840467930 x7 : ffff24f8e061a940 x6 : ffff24f840453b30
x5 : 0000000000000001 x4 : 0000000000000000 x3 : ffffb43784442d28
x2 : ffff24f8c9641040 x1 : ffffb43783bb6e10 x0 : 0000000000000000
Call trace:
 sysfs_remove_link_from_group+0x28/0x94
 iommu_device_unlink+0x94/0xb4
 iommu_release_device+0x34/0x94
 iommu_bus_notifier+0xc0/0xd4
 blocking_notifier_call_chain+0x70/0xac
 device_del+0x2f4/0x424
 fsl_mc_device_remove+0x4c/0x80
 __fsl_mc_device_remove+0x14/0x2c
 device_for_each_child+0x5c/0xac
 dprc_remove+0x44/0x70
 fsl_mc_driver_remove+0x4c/0xa0
 __device_release_driver+0x188/0x22c
 device_release_driver+0x30/0x50
 bus_remove_device+0x10c/0x140
 device_del+0x16c/0x424
 fsl_mc_bus_remove+0xb8/0x160
 fsl_mc_bus_shutdown+0x14/0x20
 platform_shutdown+0x28/0x40
 device_shutdown+0x15c/0x360
 __do_sys_reboot+0x218/0x2a0
 __arm64_sys_reboot+0x28/0x34
 invoke_syscall+0x48/0x114
 el0_svc_common+0x40/0xdc
 do_el0_svc+0x2c/0x94
 el0_svc+0x2c/0x54
 el0t_64_sync_handler+0xa8/0x12c
 el0t_64_sync+0x198/0x19c
Code: aa0203f4 f90013f5 aa0103f5 b5000060 (f9400002)
---[ end trace 1a98489358f432bb ]---
/etc/rc6.d/S90reboot: line 15:   977 Segmentation fault      reboot -d -f

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 8cbac1b4b60e..459947988e0d 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -1230,21 +1230,18 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
 }
 
 /*
- * fsl_mc_bus_remove - callback invoked when the root MC bus is being
- * removed
+ * fsl_mc_bus_shutdown - callback invoked when the root MC bus is being
+ * shutdown
  */
-static int fsl_mc_bus_remove(struct platform_device *pdev)
+static void fsl_mc_bus_shutdown(struct platform_device *pdev)
 {
 	struct fsl_mc *mc = platform_get_drvdata(pdev);
 	struct fsl_mc_io *mc_io;
 
 	if (!fsl_mc_is_root_dprc(&mc->root_mc_bus_dev->dev))
-		return -EINVAL;
+		return;
 
 	mc_io = mc->root_mc_bus_dev->mc_io;
-
-	fsl_mc_device_remove(mc->root_mc_bus_dev);
-
 	fsl_destroy_mc_io(mc_io);
 
 	bus_unregister_notifier(&fsl_mc_bus_type, &fsl_mc_nb);
@@ -1258,13 +1255,24 @@ static int fsl_mc_bus_remove(struct platform_device *pdev)
 		       (GCR1_P1_STOP | GCR1_P2_STOP),
 		       mc->fsl_mc_regs + FSL_MC_GCR1);
 	}
-
-	return 0;
 }
 
-static void fsl_mc_bus_shutdown(struct platform_device *pdev)
+/*
+ * fsl_mc_bus_remove - callback invoked when the root MC bus is being
+ * removed
+ */
+static int fsl_mc_bus_remove(struct platform_device *pdev)
 {
-	fsl_mc_bus_remove(pdev);
+	struct fsl_mc *mc = platform_get_drvdata(pdev);
+
+	if (!fsl_mc_is_root_dprc(&mc->root_mc_bus_dev->dev))
+		return -EINVAL;
+
+	fsl_mc_device_remove(mc->root_mc_bus_dev);
+
+	fsl_mc_bus_shutdown(pdev);
+
+	return 0;
 }
 
 static const struct of_device_id fsl_mc_bus_match_table[] = {
-- 
2.17.1

