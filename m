Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8821D4D4147
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 07:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239865AbiCJGmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 01:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbiCJGmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 01:42:11 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70075.outbound.protection.outlook.com [40.107.7.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DB7E33B3;
        Wed,  9 Mar 2022 22:41:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XclMlPPVKT+dFXpsvA2/Kqea1g5RJJem/7Xljz/qlkN+XnjIfXQDMbmG5WeSGrS3iEWfNeMxt2KhyvFcIneQ0G+/MEgJ4j6pTe1hLtymlN5Ym0moDr1NqB2zp5wuf8Mcf/cdNgfwUi4+4OfG+huJqj2u1GhGDsI8VRrx7aoCB+pp+cAsUch8VTgAEmyTUYh7NPGMJhZyLKZEnnBtyoZoqj0Nu2m1AEKbaOSfy/5bWORkPJ5jiqdWf554VeKHMYe+V9HUPbVGjDyIoqn0CAlzOgBHWF14xI+lehWaocSqhqgiQJvVLyYOhy4nC88ecjWQi1BflNZoWeu4t2rydWngOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cEKR7q+Irl2plfgWI7IAGt9uGr3G5B3IZzpRWiKcakU=;
 b=F92wyOvDSecAqzk+b5ac+nQh66Bg3WoAK/w7MHgUHxYFRKlNszauYL/4T7/ilvPZd18G74MLwxSSUd1rQ/f7OCWnZbQHmhjaMx++43wO/mkRMEEq/eZlaQYT4mOAJfxv/6R3jXf2nKo7SFASXeDRf/gSSxQSEBhvPtTaz7Prb8hDJcy0BtG0WCN27BZVDdSMfN+LoXGX103CFmjlGCxVVujnLY3LAde6TkipCQAsaAyHkxOVYB+JUp77cq9dL//R5SczS0C6bC+zwZ8fLCQtWpqT7Z9NRwOhMoA0OCwTpX+KnMLg+nFQdlnLzgoBYVynGI/GZ5FQVxJMJTNyEJWyqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEKR7q+Irl2plfgWI7IAGt9uGr3G5B3IZzpRWiKcakU=;
 b=P2MQXawxk6no3lmlXIMLoxE7DrJ/z10E/UQt4VpLOleiMBY+nHtlfbN33tnpwl9pJGHLk/raW3O05wXYLJh1OGlbk1sr7HtYKvM604uzzNE27b5pOLLix5xbZqnFcnY1UBpcvTd5SUMb6xDMqb8HKuYBcl5VvthgnLeJqm6U2Nc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM8PR04MB7235.eurprd04.prod.outlook.com (2603:10a6:20b:1d1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Thu, 10 Mar
 2022 06:41:08 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967%5]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 06:41:08 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: amphion: fix an issue that using pm_runtime_get_sync incorrectly
Date:   Thu, 10 Mar 2022 14:38:56 +0800
Message-Id: <20220310063856.9627-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0215.apcprd04.prod.outlook.com
 (2603:1096:4:187::14) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e8cd16c-1cbf-48af-5b01-08da0260f540
X-MS-TrafficTypeDiagnostic: AM8PR04MB7235:EE_
X-Microsoft-Antispam-PRVS: <AM8PR04MB7235B59D540978B89C4C21EEE70B9@AM8PR04MB7235.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Y/KriuGpg73cg9DTu/oicK9rRTM5n1OVOqtM095o2mPvX91JrdyHw1jbiG5jgE4ZFaG00DKO8xcnwHhgjQc+Rz/zeTTgH9boDU+rlnXBYFpBGrOPwOCtg0iG05O+dUEJzZAg4NtqJHUzlTgd9/QgmcsA/oqLzdwltxFb42upsamjaU9ydxFCdOBt+LMUW0BogwdoLv4J2X/csdMXC2E3MMlmqreFeY+RdlRi3r7BIl0aTRiTZs/eks4dcatOEERhIEOdJlqA95BMJa9qN0e36PxqXcygwshlvfNjbR9pNc/LT/p1TsVfm0gyjScqHW7oK0R9zFcGBUI90TYFRaRR0etZzIEptYqRbJommLdaKdevaD3LuaYfyT0LtgKaJjySN/PM5lkdtNxiQ5geEuJuWvJpIOx4x4eX98uFVOcJmzFSZjAeH1pPHeIdIPE5n56f9IhHh9AHrFt7eJ9Ftixd/u5Ro0jfAVvtNcc3EZ5YYIr5H+c86NszWoLyp5M3A+QPssYpx/WU4qs/5Yi843NXNupcQ3LfIfejFvJzol/TIfjHIhg9WzhfyJu6C/1shFUsFR3S2UdMXrl8wvLnct1psAmwsyCTNdMbMBQtZNXJ9S5rss9yx64PObdWZ8X27G1+pf3HMIKe8z/Bkk0SOupZGMBsWRSKDcFWDye0/V3Jk8nyq7s7T69eXCEbLXKiCnuII5c/4+Ts8aq52+kI+iGeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(66946007)(6506007)(52116002)(83380400001)(316002)(38100700002)(66476007)(38350700002)(66556008)(8676002)(4326008)(6512007)(6666004)(2906002)(1076003)(36756003)(2616005)(44832011)(7416002)(26005)(6486002)(5660300002)(186003)(508600001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4NSr15Gufh4+b9z2Kppl6pmFqWBuQKv/BurbHKyBZ79mTcVS44l/HVXsv7bL?=
 =?us-ascii?Q?x0mk3oHhDRJ/fLkG+F8gaLklagTelGsBOy/AZQPklilAb5KEAOUGrfT70FAi?=
 =?us-ascii?Q?oBoRDMxC7arSev55Te3mBRffV4pzKUQ5wbSWXv0nFJOITFEousD9SRM3eF8q?=
 =?us-ascii?Q?gh2Qke9s80jyvZjw5Eg+9DNzksGDIBuMqIuljbKvY8a1mYAZpQ1dKohY/Bdr?=
 =?us-ascii?Q?Tp/tfoZBUo/4K9lYOLmfRkgdtqRCs9PdmEDw8EUPNysJFX6mtDF268Lm0ZbW?=
 =?us-ascii?Q?h+7GJgszAf0nWu9NcDfbGZ6n6fBtLToIWWR0ey0VYnDTf7Mqb3w5q/0QkQEX?=
 =?us-ascii?Q?x4m57dDUIQcDB05W0BVy23ZD1V6CdD5iUVLJOgyuH+QpQ6ugxefpPYJOwPOK?=
 =?us-ascii?Q?NCNv3PJtL/+AXDmJA44T18a/FzCpfRCqgVXAJip8e7J2CQs5OcwErFimiCPv?=
 =?us-ascii?Q?HIHn04eZveHZV5DJWVMPIfKf4eRkpRMqPQIW/OTwTzfhayuoKvDAcVi5V5ih?=
 =?us-ascii?Q?C1qeaq6YOx7kD/xnl/kcSSmzoYgxbN1oPCn2uXYNgM7zsnp59Jwfa0tprHVd?=
 =?us-ascii?Q?ioyL8uSNxCjNOoogWYkuOKGhOjEyUJq1VcuC2fI0FAu80/MB+QSxwLU4xP8c?=
 =?us-ascii?Q?+W2jXrWbsLwTK1G0lV2LhK1OYPv7lw8PpeapmYhvS5JRmNX3aQSWECxQCLwa?=
 =?us-ascii?Q?fOMLm3l4nP/GaTMMz/1T7mKha+yMHm40fgP5ZcZ2w3oAAdbfFh8bQa4kju1i?=
 =?us-ascii?Q?LHlahZnOJUVIFpBrQZFduRoYzoVWyLeNekdPrNpsKBj3AKFJLQqVzaDEPyTH?=
 =?us-ascii?Q?OiyDSBqn8sBzjE1RUDn2Gh1aCU9J+eSdF16MijD/EpCHVqx8tsYw8lk7H7M+?=
 =?us-ascii?Q?YU6+Gy/giEshyfTpntQ+ED43MOuyp8LmviMRRVzZKsqX0OIZBqcALkyDbtGp?=
 =?us-ascii?Q?YoZro5CFOuC9R1mvboAQJ9vqTSISAteVPX0ACbUNme6MbXwLKpkrAi7o9Y04?=
 =?us-ascii?Q?dDX0scOCX2Qozn538JRNNx1xttYZHQNQewkfi9E2XDCv8ZqgWyE7hMViPbjm?=
 =?us-ascii?Q?NrrgCKT7RQK6g7dmzK6wo+bffC7Br8jj18t7T8x8iUhljU7/AMP1CXwo7Dzc?=
 =?us-ascii?Q?4M0uXnwqlDxuczfGWw9KZiFwnBpxIuvFbxno6DiOVzrGoFzbyU4e5zlLIaNV?=
 =?us-ascii?Q?Gr6bPt0NT477+DDuce+hCnwt8Jo9hzbHk3oYomYkkert9yLZkliM5w4nNUkh?=
 =?us-ascii?Q?fohxwL+YrKwS8uxmHbK58nWptEyFWWz+1Y7u0GljuqfbAguyDg8mfFi1ShA4?=
 =?us-ascii?Q?ml7/f7/xiLG0Tka3RTN6XY1qBMzKYyOQUTvOocXjRJLi1eE/CRSHadG21bEI?=
 =?us-ascii?Q?CmtcRb12t1SUGErm/Fc8QcfngC87aLo6B1enA0lH9HYiRhyIWmLrhT5iX/LP?=
 =?us-ascii?Q?zchir8njFSWOkmJlXNpnVEtkV1TWsrQ3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e8cd16c-1cbf-48af-5b01-08da0260f540
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 06:41:08.4066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zf38kXT7N7IK2oKG6nlqBErYNgkD7JH/9Eqgz/N1BPFfu22KIb4gJL98I4XBD2TLqH9pWqRsfgdmsM/VWQajXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7235
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pm_runtime_get_sync() also returns 1 on success.
The documentation for pm_runtime_get_sync() suggests using
pm_runtime_resume_and_get() instead

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/vpu_core.c | 8 ++++----
 drivers/media/platform/amphion/vpu_dbg.c  | 2 +-
 drivers/media/platform/amphion/vpu_drv.c  | 6 ------
 3 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/media/platform/amphion/vpu_core.c b/drivers/media/platform/amphion/vpu_core.c
index 016554387f3f..968b578700e3 100644
--- a/drivers/media/platform/amphion/vpu_core.c
+++ b/drivers/media/platform/amphion/vpu_core.c
@@ -359,7 +359,7 @@ struct vpu_core *vpu_request_core(struct vpu_dev *vpu, enum vpu_core_type type)
 		goto exit;
 
 	mutex_lock(&core->lock);
-	pm_runtime_get_sync(core->dev);
+	pm_runtime_resume_and_get(core->dev);
 
 	if (core->state == VPU_CORE_DEINIT) {
 		ret = vpu_core_boot(core, true);
@@ -650,7 +650,7 @@ static int vpu_core_probe(struct platform_device *pdev)
 	vpu_iface_set_log_buf(core, &core->log);
 
 	pm_runtime_enable(dev);
-	ret = pm_runtime_get_sync(dev);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret) {
 		pm_runtime_put_noidle(dev);
 		pm_runtime_set_suspended(dev);
@@ -682,7 +682,7 @@ static int vpu_core_remove(struct platform_device *pdev)
 	int ret;
 
 	vpu_core_remove_dbgfs_file(core);
-	ret = pm_runtime_get_sync(dev);
+	ret = pm_runtime_resume_and_get(dev);
 	WARN_ON(ret < 0);
 
 	vpu_core_shutdown(core);
@@ -746,7 +746,7 @@ static int __maybe_unused vpu_core_resume(struct device *dev)
 	int ret = 0;
 
 	mutex_lock(&core->lock);
-	pm_runtime_get_sync(dev);
+	pm_runtime_resume_and_get(dev);
 	vpu_core_get_vpu(core);
 	if (core->state != VPU_CORE_SNAPSHOT)
 		goto exit;
diff --git a/drivers/media/platform/amphion/vpu_dbg.c b/drivers/media/platform/amphion/vpu_dbg.c
index 3c12320e1708..376196bea178 100644
--- a/drivers/media/platform/amphion/vpu_dbg.c
+++ b/drivers/media/platform/amphion/vpu_dbg.c
@@ -344,7 +344,7 @@ static ssize_t vpu_dbg_core_write(struct file *file,
 	struct seq_file *s = file->private_data;
 	struct vpu_core *core = s->private;
 
-	pm_runtime_get_sync(core->dev);
+	pm_runtime_resume_and_get(core->dev);
 	mutex_lock(&core->lock);
 	if (core->state != VPU_CORE_DEINIT && !core->instance_mask) {
 		dev_info(core->dev, "reset\n");
diff --git a/drivers/media/platform/amphion/vpu_drv.c b/drivers/media/platform/amphion/vpu_drv.c
index 834ec39640e5..f19f823d4b8c 100644
--- a/drivers/media/platform/amphion/vpu_drv.c
+++ b/drivers/media/platform/amphion/vpu_drv.c
@@ -118,11 +118,6 @@ static int vpu_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	pm_runtime_enable(dev);
-	ret = pm_runtime_get_sync(dev);
-	if (ret)
-		goto err_runtime_disable;
-
-	pm_runtime_put_sync(dev);
 
 	ret = v4l2_device_register(dev, &vpu->v4l2_dev);
 	if (ret)
@@ -149,7 +144,6 @@ static int vpu_probe(struct platform_device *pdev)
 	vpu_remove_func(&vpu->decoder);
 	v4l2_device_unregister(&vpu->v4l2_dev);
 err_vpu_deinit:
-err_runtime_disable:
 	pm_runtime_set_suspended(dev);
 	pm_runtime_disable(dev);
 
-- 
2.33.0

