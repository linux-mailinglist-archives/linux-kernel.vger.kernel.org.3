Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0DAA508728
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 13:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378151AbiDTLjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 07:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357528AbiDTLjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 07:39:07 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2085.outbound.protection.outlook.com [40.107.21.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5E641628;
        Wed, 20 Apr 2022 04:36:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQaRG8ZqUKqSOILZSWNXXJzZglgLnQR6z5a3QhcGNluBs1+lVJ/czbfP9ijyHoQdSLiu9Oxh4VMYWtVdMCBhcsbxhlcYs7YdMfxy3oWHGdz2S0wnUJtrXCPYMnGWD9QDG01OVXSk41lLe5eUhMX6xU7ZVZGCzQ7p4G6SNp0mxAOGlMSuQocI6Y1NiPjroyQq72MT6I1+XBljRh2E3dnItbaJwN5V0CBxbq8HWbR1BSQMx7k1yNw6jsbIASPLugCkGPYIsMpC8RDUFBJ+TyDb6vUDoKK14hwhBb4d6I+IfbafA4Ub6XONhbXy9SfzW90V/geXaHM1a8iqk+tjJQFr2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFc6fnKVdvpj9e2B/puNiLY+1Z9BYKnSOg7QguH7SpQ=;
 b=Yep5bdRd6dPL+wNr4tWOjLdKBh/ryPmbThIVfm1SB3IsZXryzIy6Cjzpt9efl4Y5f/vqKbXkOhIjxp98iXIDhp3QKxPfheRPD6vY/cDIos3SUU84BiYGB8/nZiSdk6FQUjIBqph67j+CgKeUrt4mIDbDWVySwjS5Kkqp3eWnn9lf90aW0zPKEt55aGAJpvuTkojaDrPXpN0dycheZhUgefF1L2OeqU7ZnQvvnq30Nz3ljvcxBwy6QMd7Fg/fWC7o3wXGdd3EN0toauMwaBlmYkxSzj/C1Sswb34foMqShUqUevvvC56340iCtAG1G/aJayFYK141jCbo5MfR4I7FUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFc6fnKVdvpj9e2B/puNiLY+1Z9BYKnSOg7QguH7SpQ=;
 b=ISkLPCsn1tSy4uZmWohHBim4dYnfIf0CVG0QLSzrjnXpLFibEF9IYqQBP78ngsfjReG1D7RBRQFskw1nrvVkfSKYsFEDXJG0olGROwVNeoURGUG0kPk5xIB30MoO82DMEkC/SNqEJf/THyOuhyIBatgr8CAXtOP7tplzWkxEFhk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB8PR04MB6923.eurprd04.prod.outlook.com (2603:10a6:10:114::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Wed, 20 Apr
 2022 11:36:18 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::d8b5:5914:5189:ffa5]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::d8b5:5914:5189:ffa5%6]) with mapi id 15.20.5186.014; Wed, 20 Apr 2022
 11:36:17 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org
Cc:     hverkuil-cisco@xs4all.nl, robh+dt@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: amphion: handle picture skipped event
Date:   Wed, 20 Apr 2022 19:35:59 +0800
Message-Id: <20220420113559.29176-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0089.apcprd02.prod.outlook.com
 (2603:1096:4:90::29) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a8bd349-30e2-459c-fcc8-08da22c1fbb6
X-MS-TrafficTypeDiagnostic: DB8PR04MB6923:EE_
X-Microsoft-Antispam-PRVS: <DB8PR04MB6923018F1AB497951478A613E7F59@DB8PR04MB6923.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qbfTDPNAEyPaXmK7xGdB4LSMBbtNW59wlMilzX1BZj74OkILlo9B1ZZBak41GTS1BbOS2AnBACAKVOKqWDcjK7yDvSIsKHkmUXeAv/KC6/KZ6WwnLfjvCZCRtNXNZP9/o7vV7vHj0lmglD+Ghky0yTdi2svH9FkZmnoN4wj776U80lYrL5aNM1BfYOFSZ9FPA82yWfRkkDfOb4Ev0e9ZpWuWN/Bqi0SqWld9Q0LdLidSGKppG9G8fT5Ek7RT21NFXN3w8P1gwLlOpG4o1BeXjtELAHFdaT1cDvmRt4RV2TRWZCePwLWtOJcO8j66Zilf/T3lB98QhYtp7eC7RRQfJ8aq0rrDYrEXPZmxHJPHyw3sEdqWmgSxNh94C3bCBYft2OE7YUH4MBAnSpOyp8NZTw09ogrj86JM5rgU+5nRHgKBr3XGecsgCv19gav/3HVuibWyi3JRDoHVA7cgwBPNlH8dAjshwzrw6nTnDYeQiSVaq77mV41MiQL6NmIMYIuvpQHaQkF/sNJ0k2yyh81g3TtetZImfv+vxAdZIOD9tjhVGsLLh82C3tSAIwzQdxumzAPdhieRAAVHDAIdtcoKEYl+5NkglN7/trMc8ivuZN8F5BnJsSv6RP+6vNVTTo3XEkJAEj/Olobb/+MAmDi2XPGI4Qposgt47HmLpnvCp/JrGpR7Z14QY47WZl2gAnyJxWY29Ngu1UZzw+6lc/OJGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(6512007)(26005)(52116002)(6506007)(38100700002)(6666004)(38350700002)(1076003)(2616005)(186003)(83380400001)(5660300002)(44832011)(316002)(8676002)(8936002)(66946007)(66476007)(4326008)(7416002)(66556008)(36756003)(2906002)(508600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uFlfJ1wNI5npuU5m3N+SBFmhleikrKi8W+zd1pQRFCDKUGuAKMaPA5vgYPoI?=
 =?us-ascii?Q?WCpqsEdM/tnyLWr5+qXpDnqom5+gK0U5CQrJ/DTPpJ+QXwcdbFwHLZYYeqVU?=
 =?us-ascii?Q?/hw27PZ3l/UYAYozQCCn4OFs6Jju3vN9Es1leO4dkLJR1YSa+vXvHe9ZyX5g?=
 =?us-ascii?Q?ehCv3yI3pGyOCjXf7T7ZBCirpKge2RU1ifpqsBb1YEAV0DJf0votpq+M4GH3?=
 =?us-ascii?Q?Kz3xZvCbciXoyL5WdHiNlcGT4sXGS9jBI+0C/JhL93fWhHb/460UYywMgptO?=
 =?us-ascii?Q?ORkNpKMa9Ztem9ovsS+y4GfyTPnVQreKs7wt0h9IkwLIWU8eWCZrI2CyNJzc?=
 =?us-ascii?Q?O+YrDLvuKt2bWdo7c0oXyfLsXUdK1kcTw2P84wsN47i1XftB0wPVnYj7dill?=
 =?us-ascii?Q?xz4wrWfwGqdpzOYAihD3ncHyKjAfodwlEvBWiiGOGGK1esYJRMDk04JRdU+6?=
 =?us-ascii?Q?fMNBuY9vQpUXGbRjKphw8bfFYC3OUfbcKBjAsl16QVCLsey5+DnREW1FHqdv?=
 =?us-ascii?Q?G4b9E6Tz7+0D/kBxZHkrszqgdCq6DYBqoIbwTDbUhnXZlWDLab3CKY1JYK+G?=
 =?us-ascii?Q?/uCUhEofBl1uicB3Ban5R6Mtjs01DTp6WFdhFMKEVHWmqtvhGRgsCJ++qW6h?=
 =?us-ascii?Q?xP49P8jmAKuuBuIKYLCKg7CsKxN+fTloSnsdJ9+06Jo8O0IPhY8KVjeYiS+E?=
 =?us-ascii?Q?xUZO+VKP0BohkVls9grdBFigmfmQopv9OLKyD2JJTYe3gzx2UxwzGcMHU5+O?=
 =?us-ascii?Q?A1VgTToP/dMO1G8s8ST3SauptdFo5dNBEJ7OjdGmqlUdwScmzNiKzodqKcv4?=
 =?us-ascii?Q?N8qociMmxG5zwlf3pLV3fVM2tpYAQZeJXYaVxYRb90s3K0mwYgddeQliAUZ9?=
 =?us-ascii?Q?KSWO5tKJcjZxa6vDR6HziOOMRaJdtXt9Bb09ZAV8wwEe6/WFbTmZplBy3ws+?=
 =?us-ascii?Q?DhMUdI5WtVWDG7l1AQxgiHnoPTkg9thQtbhYhFsf8lqp5JkKCl3AvhaOThCf?=
 =?us-ascii?Q?bh6dOb4A0VDg7nXjLZLwWeNkZdIDHJmAFHVewanBtpTqHhWaMBDf/0QDM5Ks?=
 =?us-ascii?Q?3vpirJdp18ih3G+oSElYrbCJuF0+fbS7DkGievPlLZAInTzgiUS3hHhlkmSf?=
 =?us-ascii?Q?C5Cl9Q9f8OwbpKeZgFKMVDAOvlDEo/qCIPIqmNKhlxfqBtYzmrPVPzQf+bgT?=
 =?us-ascii?Q?0liSqP9w4Tgk2iaeC3HTYnaqAmu22k8YKjSA2TuH+Ag2gKBv7m8Y9POE48pc?=
 =?us-ascii?Q?pyMT9l7ErJ4MqeCqnE1/xgL+D9tPGLYE2RMUDEhxH/thkWKTsPPuI00Gke4N?=
 =?us-ascii?Q?0dUw/sw9av6gxUiDzESfcfydAFrdWqs4kBJ0HQjUzfLn6KLi6aTya+rDdd8X?=
 =?us-ascii?Q?KHaFz4vlXunB2bl+c3x87jCrx7liixjJAOSGUkyJBlMXvhuDqR7Acc1Z/KJg?=
 =?us-ascii?Q?Wyi1z2cb5hxKNuD6YDNdGd7wE4zdtUMpCXskWIQ4iujHa/9VEPRFXXk9FCVk?=
 =?us-ascii?Q?mGDwBdjYC0IjWzPcEqCMsn1xOoKIYtpA7g/+VNsK7yOCtuLjrtQKlKHCy7sB?=
 =?us-ascii?Q?0rgTRbR+M3UV8tHoF9LAUJozUVGQlZRIXBXK3MlIcFxUviwoBHT/pQ1YHowl?=
 =?us-ascii?Q?kOPRfu0LyGxlAIlBjc5vzoGb7WsUc7XXP28vJEZUmiwuEdafsNHI8g8zUS0p?=
 =?us-ascii?Q?AEIAr2/6mda1JCrSBQVLO84I1a7i+lY3YujpOmMgwggPy4rbmJbLurYMBLHl?=
 =?us-ascii?Q?gWyWCGwmDQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a8bd349-30e2-459c-fcc8-08da22c1fbb6
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 11:36:17.4858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b8Xav7sXOHcO4E1EFDxIaEdCKJoN2XRiDX0LBQqgAq6yJFvZ7LhHmkEq1iqrUmyQMAZXrcvuPlGbGiCW8wrQZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6923
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some invalid frames,
especially multiple consecutive invalid frames,
they all can't be decoded,
then the firmware can send picture skipped event
to notify driver that some frames are invalid,
driver can return them with error flag.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/vpu_defs.h   | 2 +-
 drivers/media/platform/amphion/vpu_malone.c | 2 ++
 drivers/media/platform/amphion/vpu_msgs.c   | 8 ++++++++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/amphion/vpu_defs.h b/drivers/media/platform/amphion/vpu_defs.h
index 282664202dcf..667637eedb5d 100644
--- a/drivers/media/platform/amphion/vpu_defs.h
+++ b/drivers/media/platform/amphion/vpu_defs.h
@@ -69,8 +69,8 @@ enum {
 	VPU_MSG_ID_BS_ERROR,
 	VPU_MSG_ID_UNSUPPORTED,
 	VPU_MSG_ID_TIMESTAMP_INFO,
-
 	VPU_MSG_ID_FIRMWARE_XCPT,
+	VPU_MSG_ID_PIC_SKIPPED,
 };
 
 enum VPU_ENC_MEMORY_RESOURSE {
diff --git a/drivers/media/platform/amphion/vpu_malone.c b/drivers/media/platform/amphion/vpu_malone.c
index f1eca885122a..f29c223eefce 100644
--- a/drivers/media/platform/amphion/vpu_malone.c
+++ b/drivers/media/platform/amphion/vpu_malone.c
@@ -170,6 +170,7 @@ enum {
 	VID_API_EVENT_DEC_CHECK_RES		= 0x24,
 	VID_API_EVENT_DEC_CFG_INFO		= 0x25,
 	VID_API_EVENT_UNSUPPORTED_STREAM	= 0x26,
+	VID_API_EVENT_PIC_SKIPPED		= 0x27,
 	VID_API_EVENT_STR_SUSPENDED		= 0x30,
 	VID_API_EVENT_SNAPSHOT_DONE		= 0x40,
 	VID_API_EVENT_FW_STATUS                 = 0xF0,
@@ -703,6 +704,7 @@ static struct vpu_pair malone_msgs[] = {
 	{VPU_MSG_ID_BS_ERROR, VID_API_EVENT_BS_ERROR},
 	{VPU_MSG_ID_UNSUPPORTED, VID_API_EVENT_UNSUPPORTED_STREAM},
 	{VPU_MSG_ID_FIRMWARE_XCPT, VID_API_EVENT_FIRMWARE_XCPT},
+	{VPU_MSG_ID_PIC_SKIPPED, VID_API_EVENT_PIC_SKIPPED},
 };
 
 static void vpu_malone_pack_fs_alloc(struct vpu_rpc_event *pkt,
diff --git a/drivers/media/platform/amphion/vpu_msgs.c b/drivers/media/platform/amphion/vpu_msgs.c
index 58502c51ddb3..d5850df8f1d5 100644
--- a/drivers/media/platform/amphion/vpu_msgs.c
+++ b/drivers/media/platform/amphion/vpu_msgs.c
@@ -166,6 +166,13 @@ static void vpu_session_handle_firmware_xcpt(struct vpu_inst *inst, struct vpu_r
 	vpu_v4l2_set_error(inst);
 }
 
+static void vpu_session_handle_pic_skipped(struct vpu_inst *inst, struct vpu_rpc_event *pkt)
+{
+	vpu_inst_lock(inst);
+	vpu_skip_frame(inst, 1);
+	vpu_inst_unlock(inst);
+}
+
 static struct vpu_msg_handler handlers[] = {
 	{VPU_MSG_ID_START_DONE, vpu_session_handle_start_done},
 	{VPU_MSG_ID_STOP_DONE, vpu_session_handle_stop_done},
@@ -181,6 +188,7 @@ static struct vpu_msg_handler handlers[] = {
 	{VPU_MSG_ID_PIC_EOS, vpu_session_handle_eos},
 	{VPU_MSG_ID_UNSUPPORTED, vpu_session_handle_error},
 	{VPU_MSG_ID_FIRMWARE_XCPT, vpu_session_handle_firmware_xcpt},
+	{VPU_MSG_ID_PIC_SKIPPED, vpu_session_handle_pic_skipped},
 };
 
 static int vpu_session_handle_msg(struct vpu_inst *inst, struct vpu_rpc_event *msg)
-- 
2.35.1

