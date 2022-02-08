Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E14C4ADBDB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379211AbiBHO75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 09:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379105AbiBHO7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 09:59:43 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80051.outbound.protection.outlook.com [40.107.8.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25764C0613C9
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 06:59:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCPXgsnnG9Twt2g+LdIvu8gj+Ypv7yFgrzVoI7+WIYGXqd8mcCMBF/a+sIDlfn9Sea0/O24iAj8UQj8279XU67JvukZEywg55qmt4JLMhvXaLsVX+ZYQirfpWXrI132rzi1MDVxpKOByEaaqKCuATKlU1OUW42CZMFKVTtrgi7HvN9fXCuDRqb47joWOX0AnzHnstiF5OoZgOYG3rrfkY9FYbBwAiMH2NRDzFjU90KWViCUZbr2cBOZSrhbtds9nvPieFLNuxRdGhctK3gWKzreHDIe7FF2qOKCTJxgbY8p49vveIHT14BW/3oYePweMIcwm7WZorkspcg8Jk/WnHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KEiP/ywqN9yMvcn/2KHSElXcnlQrXeO8JiGoouRU/uk=;
 b=LWIjdrCQ5aioiICIHVBA9mL7DMUCzFD+bvOtQu6Weo5osQQLpr+RAm9I98AUx7aOY/Q0BphOejqFrSzwKYH+PQV4IlW4YZRsUuPdujJyBwjzDRbxU7LsfYssmuDDWsnIwMCwQNs6Rb3HfZlM2WG6vOpqQxk2RJiQ8cWVJWbXFCtcjT0m+3p8CvgI5ZKVuKW8kdHni0eSKeW/IxzRw6sZEAXsvmqa8Sn2aGU+vHnnCl3+r5fFZw5EHnLRDwpWez5kRzz8ApkKffDcMtRSxOl2FymizeX98IB7HUT/lPFhENpM6kTYcJEkAvjqgv+fnfiY19x4rOsA7rHUd67gksnEPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEiP/ywqN9yMvcn/2KHSElXcnlQrXeO8JiGoouRU/uk=;
 b=lgyYfc6zJw06UHl2sco25CM5X3Txm9mnBnynUcnknb6wIp2DQ6wEZTfU6sJ0lGSta8Xko92FBiVn9XxwCvliXWXTwWHSjU2TfTPPG01tgK9jJQ91kTnmdCP669wyhx3jixK0yEeCKJB05o1dSNAjI4MjAEWW8K9qEI+l9tQIPJE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by AS1PR04MB9381.eurprd04.prod.outlook.com (2603:10a6:20b:4db::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Tue, 8 Feb
 2022 14:59:40 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::f826:3bf6:b77d:5a53]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::f826:3bf6:b77d:5a53%7]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 14:59:40 +0000
From:   laurentiu.tudor@nxp.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     ioana.ciornei@nxp.com, diana.craciun@oss.nxp.com,
        jon@solid-run.com, Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH 2/6] bus: fsl-mc: fix a use-after-free issue
Date:   Tue,  8 Feb 2022 16:59:24 +0200
Message-Id: <20220208145928.12468-3-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220208145928.12468-1-laurentiu.tudor@nxp.com>
References: <20220208145928.12468-1-laurentiu.tudor@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR08CA0025.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::38) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffb46b98-8915-4316-64db-08d9eb13a1df
X-MS-TrafficTypeDiagnostic: AS1PR04MB9381:EE_
X-Microsoft-Antispam-PRVS: <AS1PR04MB93811859CE63FCDCC4B26650EC2D9@AS1PR04MB9381.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:785;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h0TLp/o3YCDWqWDbuoMWri5QtwYAVR6Ebd5czgQ73lTprNEmMGIhqCheprPFpmzpGxkiEus5/pT42DOYXKgSO4QzWasPanq2HlOdfiD9mLMhNA5coKxkWBJC8J7m3j4gv2ov/gMZjUD43Aye1i0ri8EmEIkl8gFYyunoPGCLeqfaQVj1ULhdpkSPO8jASk+kcxtNlCbjr2v8PzN0pmxGid1qmj9fnSc3U4vYe3XOfK8rhlRWA6lq8RjNAH5uYM/SEsPGcMTNa5U2YDG5Gu4MBBeS2NZg13d3IK3FUAkyxs8SvZGq0ikywu1MdF4CZmtdNds8yIS92J/1YSewY/uoZ4nUT5G8fodgq5UFcsbGddMbIP/5fnN2UdIjlmF3PMMbwjZ3ByqZa3FO+fHrTmSwqFlUf5bB9WMLSQRCh7M8hpfuHXz6BhNq+/pTix7rXxBYgURP0SduS6h/9S3JBNpq9z0qR4/qMzRP3/BqrEV5NO/lhhYPLAjvckrHHSWS1CXfkb8fJ8TsGbJqU6l3s5oAjyVzZXfK849beEA1nz588J6m/me4YjCgdfavJCQiNrcNjkO+yhIskvFj5UQd0pCKXNYLClYktoTYT4pNwTpD/sZ2Ox7kbQkeKY54KKYa9eJKTEDBRMVmAdR10uerEVfCBnMSAXF+SJwnIkLroAkJetrtivWKHNjr6y/FVl6XXlyzReHLPYwi2FKaX6GgtG8+og==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(6506007)(6666004)(4326008)(38100700002)(8936002)(83380400001)(66946007)(508600001)(8676002)(66556008)(2906002)(186003)(36756003)(6486002)(86362001)(2616005)(5660300002)(6512007)(9686003)(26005)(1076003)(52116002)(316002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J6H42U7skdzkdoc9dsw9mM8HkwnHKeC/DyoqoY37QrgzN4aUTSnbfUntQB0L?=
 =?us-ascii?Q?GtI2tLKE6HpgxSmc4YyRozEMWvxxxvpR/JWryPZfUkIKa33ON/9Y9pQtoJUd?=
 =?us-ascii?Q?o8Ly/MxeiSpKjFidzRpC7t3EcGOmC86E0s6CzQeNp9AFlGCYKL6Oe51buemj?=
 =?us-ascii?Q?SGQpDwMWvJ1yf8hK8g/ccVsURCFaJep9r9HNpdQrm3muh9CEtktJEgLqZLyi?=
 =?us-ascii?Q?52KMRWIUxTs+iQl4pvcUlBwK3Rp8xX9uKS9wU+76s+mk/6W/VCPBUreNS4gr?=
 =?us-ascii?Q?J1hDolltFTcUaU9xRLgQhxdPtwixBBZYmdWDCsFPNMCyum3Jz/BxkZuNz/MQ?=
 =?us-ascii?Q?rJQY/F3bHIhZt6EO5Fl1xbaTJ15ceO4iCCL/8Ic5hyTigRBngvlrGchNSs1v?=
 =?us-ascii?Q?AIvYFLMNkxMxqziqNrlnghm192tFezBn0bdPN7hNF/Z4EyN1O3wX7j5SISnV?=
 =?us-ascii?Q?sHCfKMl5nIA+N79bqKxPcawK56X2CMDqrOKbfmlJK7Fwn9XjQVW0I7ZODcat?=
 =?us-ascii?Q?KsGY48Bt3a9gXqIb/mEIk5OMYJ8ckZFQE5k84m3PRj8Zcs2+UM0gsGaAJAwD?=
 =?us-ascii?Q?fIaBPLDhb6AjONbB6nAXjMOTEv0PTC+fHuQzvedkqgNeS+btXUENEK3LPDdb?=
 =?us-ascii?Q?nrGciHmOFGC6REcbu+iJK0jr25XNIODEqIApyqSdA+eXPLcs8AolTOaQu7bg?=
 =?us-ascii?Q?WUimDPwKoX7Ks9O2U0vQlNJxScLtP69kSHnv3LBWDCFH38UpdtXsO9cQ1bQV?=
 =?us-ascii?Q?XXQd55g4IQ2vmdfh9XNPWxgLQ2j4Oz4JYfPPpFWLavrCHvU2FLz7+w0K11Xs?=
 =?us-ascii?Q?qTZfeEzuaM7uF8ySi2Le8bJRxI/abjanC4pmxBQkspnynaeObW0uqzyOIkYm?=
 =?us-ascii?Q?sKpchiJ2h/bYM9Bj8CpNc19/oOBtq4qoaoJWVLj86BLm9Hc6m8tK3ly/JQ7X?=
 =?us-ascii?Q?FKFLN3iUGpYp7wO/q6tH/4ejU8Y/CvfsmQW57dIcNssHzxUu/xrmeM61KnR+?=
 =?us-ascii?Q?ecJGrRAuOWRDgAINdqKyOrW6LEWEU+GS/WUiprnxP5JqLSmjsUbxg/fyPslm?=
 =?us-ascii?Q?MGddX1n/T45HEWgToohSwNTFpdf9Yaw+gArSqH3DYfdwO5jtYMWhZ10N4aGd?=
 =?us-ascii?Q?GW5q2xwzeSPCVLr6obWyqt8hn3P/+7IOMxQm/4ftdijPdCXceg06l1adSOmf?=
 =?us-ascii?Q?lBHpLPCceJW50l7UHHaVX64/knzZeVvf8oPSjogKIEyoi7kTkUyTQl72tZzj?=
 =?us-ascii?Q?5fuO45JnMLuqEbzo4siHI0TFa5DpUmrRe4Gg0jlD5EjzGT6hJ9TaOuDIiH6L?=
 =?us-ascii?Q?tapV3CymDZ4b1M1Opa8MEp2xCjCXTgwvAu6KKiMi6qSeezqL7J/RhiMEzd5B?=
 =?us-ascii?Q?u2D8rAuOFdLJSEMHa0+iv+stZti38g4LH5R7ajzpqcHWaU1c2mhPqKixJzzD?=
 =?us-ascii?Q?bEZreh8l5zXU1sE8VXkAq0cxFQG7LxSnvMMZgTWXs0s4C4J1E2OX/gnB2xW6?=
 =?us-ascii?Q?hUIU1L1Gaivdw/2U5Dgmlo3A+T9do6DZRhXYqFuvUphyNedTd+uYnE/F2g1M?=
 =?us-ascii?Q?gtTvFcHHW5rw/mJ6U/mfHQ3o+itNbbjSjDQyAO6Pi2a7W+Y42VhpxfJXyavZ?=
 =?us-ascii?Q?sg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb46b98-8915-4316-64db-08d9eb13a1df
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 14:59:40.3876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a3dhwc/jnSKpCQw38FBhgKELyQdSqerIw5jYD4Yv/i8OJRbe8RmipeJvWwUOR5CnTqO1dyqMKENHrSF+GSMa3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9381
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

Lets keep a reference to the MC IO object before deleting the
containing device structure, so that we can safely free it.
This fixes the below use-after-free kasan warning:

==================================================================
BUG: KASAN: use-after-free in fsl_mc_bus_remove+0xb8/0x198
Read of size 8 at addr ffff00203a304300 by task reboot/1362

CPU: 8 PID: 1362 Comm: reboot Not tainted 5.14.0-rc1-00218-g23d67ae4b6d7-dirty #111
Hardware name: NXP NXP LX2160ARDB Platform, BIOS EDK II Apr 16 2021
Call trace:
 dump_backtrace+0x0/0x2a4
 show_stack+0x1c/0x30
 dump_stack_lvl+0x68/0x84
 print_address_description.constprop.0+0x74/0x2b8
 kasan_report+0x1e0/0x24c
 __asan_load8+0xa4/0xd0
 fsl_mc_bus_remove+0xb8/0x198
 fsl_mc_bus_shutdown+0x14/0x24
 platform_shutdown+0x44/0x54
 device_shutdown+0x1f0/0x430
 __do_sys_reboot+0x290/0x31c
 __arm64_sys_reboot+0x58/0x70
 invoke_syscall+0x60/0x190
 el0_svc_common+0x84/0x130
 do_el0_svc+0x88/0xa4
 el0_svc+0x24/0x34
 el0t_64_sync_handler+0xa8/0x130
 el0t_64_sync+0x198/0x19c

Allocated by task 7:
 kasan_save_stack+0x2c/0x60
 __kasan_kmalloc+0x90/0xb4
 fsl_mc_device_add+0x104/0x8f0
 fsl_mc_bus_probe+0x400/0x650
 platform_probe+0x90/0x110
 really_probe.part.0+0xec/0x480
 __driver_probe_device+0xd4/0x180
 driver_probe_device+0xf8/0x1e0
 __device_attach_driver+0x120/0x190
 bus_for_each_drv+0xec/0x15c
 __device_attach+0x168/0x250
 device_initial_probe+0x18/0x24
 bus_probe_device+0xec/0x100
 deferred_probe_work_func+0xe8/0x130
 process_one_work+0x3b8/0x650
 worker_thread+0x3cc/0x72c
 kthread+0x1f8/0x210
 ret_from_fork+0x10/0x18

Freed by task 1362:
 kasan_save_stack+0x2c/0x60
 kasan_set_track+0x2c/0x40
 kasan_set_free_info+0x2c/0x50
 __kasan_slab_free+0xdc/0x140
 kfree+0xd4/0x360
 fsl_mc_device_release+0x30/0x40
 device_release+0x54/0x110
 kobject_put+0xac/0x180
 put_device+0x18/0x30
 fsl_mc_device_remove+0x48/0x5c
 fsl_mc_bus_remove+0x84/0x198
 fsl_mc_bus_shutdown+0x14/0x24
 platform_shutdown+0x44/0x54
 device_shutdown+0x1f0/0x430
 __do_sys_reboot+0x290/0x31c
 __arm64_sys_reboot+0x58/0x70
 invoke_syscall+0x60/0x190
 el0_svc_common+0x84/0x130
 do_el0_svc+0x88/0xa4
 el0_svc+0x24/0x34
 el0t_64_sync_handler+0xa8/0x130
 el0t_64_sync+0x198/0x19c

The buggy address belongs to the object at ffff00203a304000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 768 bytes inside of
 2048-byte region [ffff00203a304000, ffff00203a304800)
The buggy address belongs to the page:
page:00000000c0d8f504 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x20ba300
head:00000000c0d8f504 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xbfffc0000010200(slab|head|node=0|zone=2|lastcpupid=0xffff)
raw: 0bfffc0000010200 0000000000000000 dead000000000122 ffff002000002a00
raw: 0000000000000000 0000000000080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff00203a304200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff00203a304280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff00203a304300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff00203a304380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff00203a304400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 8fd4a356a86e..8cbac1b4b60e 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -1236,14 +1236,16 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
 static int fsl_mc_bus_remove(struct platform_device *pdev)
 {
 	struct fsl_mc *mc = platform_get_drvdata(pdev);
+	struct fsl_mc_io *mc_io;
 
 	if (!fsl_mc_is_root_dprc(&mc->root_mc_bus_dev->dev))
 		return -EINVAL;
 
+	mc_io = mc->root_mc_bus_dev->mc_io;
+
 	fsl_mc_device_remove(mc->root_mc_bus_dev);
 
-	fsl_destroy_mc_io(mc->root_mc_bus_dev->mc_io);
-	mc->root_mc_bus_dev->mc_io = NULL;
+	fsl_destroy_mc_io(mc_io);
 
 	bus_unregister_notifier(&fsl_mc_bus_type, &fsl_mc_nb);
 
-- 
2.17.1

