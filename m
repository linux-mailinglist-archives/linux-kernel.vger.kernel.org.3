Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1EAD48BCF4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 03:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236254AbiALCKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 21:10:15 -0500
Received: from mail-eopbgr80047.outbound.protection.outlook.com ([40.107.8.47]:6974
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348290AbiALCKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 21:10:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GSb+5qD/l1tU82B/CwPMLnVvP9bjQg2gewuIr2B4HRCMfuOR68nAlp/7nNU1acZ494yRxNy6TYhB5NGHq6FovDXRZHewbP+FuN3VbaiBrIeLm/8o1ZLQ8BCle0zo2Q6HWSb00u3bcocGNxA6oxULytlCfBtbNgfUdgXhfe+v6QOTAxKa5n9sb76ocLHPJMRRZDn5esMIbBpeb9iw/TqrW8erbMbFHcnT/OiToksvrUDsWDgOVWw52QAMn0oqriUBhvv2r7luePlqgld6PWJ3UBxwMKt253AUiLzOxpSJNc903MoyPBByVnzInCc2sHcMiFTH5VMzvFXzRUpWkF8e2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cbDuhYhy+Bvu1zLghzk+LDZCECM5odyUsK92+FmmPxc=;
 b=ZHfG8EEodr6pe4OBw9J9/xo5zvjXC0NgdCpSWHrIpOsn8uRVt3ShRft+uSKZx1aslf6ub7QMeHLt6sLEA9i4vcWH9HG03yxbMmlhU82CCY6CX8smEf2fr/rXg4mMu7sJfmSyxcEZSvjZgIA/QFrUVI81aVTjQPdGyhSYAlBLXCMLvnFBg4CsIr/se3lphJIAazXCRfOLdqwND8WGwByjtbT5/snhDI001QQx83PKOZI4x6iQz100Nz4er8L+fbMPxxZPjvt+pAkrUBM8N08Vmxmns26Zfk+SttdPefQs6R0iSw8cHaH5GtfjcnCr/TGQikHmaHBO16Nmyt5pNHQ/qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbDuhYhy+Bvu1zLghzk+LDZCECM5odyUsK92+FmmPxc=;
 b=hsHfcLIs0swPOdv4oc9k0wHczRL6+Zka0TgbvhJVqzOG6bt6AL9o6aPqFc2KG8AZGBB1Y0Bju4smxMSgfQ9lCleN1D0/de9fREt3Xdzc6n7dPO9emgxD+5G8cPf2ya2IMq8dEvU/9r/QeDCWQzEn3yWcCwfI+/JORc+0JczYk24=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR0401MB2495.eurprd04.prod.outlook.com
 (2603:10a6:800:52::15) by VI1PR0402MB2783.eurprd04.prod.outlook.com
 (2603:10a6:800:ae::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Wed, 12 Jan
 2022 02:10:04 +0000
Received: from VI1PR0401MB2495.eurprd04.prod.outlook.com
 ([fe80::698a:af10:114f:2487]) by VI1PR0401MB2495.eurprd04.prod.outlook.com
 ([fe80::698a:af10:114f:2487%12]) with mapi id 15.20.4867.012; Wed, 12 Jan
 2022 02:10:04 +0000
From:   Mirela Rabulea <mirela.rabulea@oss.nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        ming.qian@nxp.com
Cc:     linux-media@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, festevam@gmail.com,
        robert.chiras@nxp.com
Subject: [PATCH] media: imx-jpeg: Prevent decoding NV12M jpegs into single-planar buffers
Date:   Wed, 12 Jan 2022 04:09:50 +0200
Message-Id: <20220112020950.656796-1-mirela.rabulea@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0152.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::21) To VI1PR0401MB2495.eurprd04.prod.outlook.com
 (2603:10a6:800:52::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a79ed911-d61c-4fc0-7b4c-08d9d570a581
X-MS-TrafficTypeDiagnostic: VI1PR0402MB2783:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB2783E9F6655CED528F6B2AB9CE529@VI1PR0402MB2783.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0K4qvW9gMOekk8GGj15YU9Y0pJMirbg64j/5FFkro7ZxglCpeDbmSeGFgrJ0gy367u/oCBV3oJmxdIEVFXc/1Rn09pV2itYi4OEU4crF9epCYc+4wvPfOlzaLzHQoQpxq5Undwj0CPm4NpYmVEB9LeayWnKtmlaJEk/ot7tjVRNs7JUk3DEiB9EgFVW15YVvLF4dGSFTHrDnxpiir1foNIPrwHG144Z2Y627rjusKPmt9Lmhp/nHUFEI8pGxpaqB3sfw81MpHhxHinkO9wT6bnJXhTJKSYSqAvbD97DkpM6Qt6RFJMXCHrhLOfpzkq+TqKg7J61deHhigZyD01KYhPTMX1WfmrVtRU7qiN64kN7b5sD1PDHTe4mG73NY5FMyRLy3Un6FsnR/9y7xwzjRJx7al8jm6jTW3sp99co3zwIgOWgbGcX85fvsTUUJ9G3JoOpClMKf4TmIHWpaqI25vy5Nz1HB/zWtnuP3VPjJqkw0f/khGEqFw3sfooCs5spEMP0k08A+4cXkF5wfgS88eokxK18U7W+VMpwwvGJgHWFCV/DzU3vU99fKU3OMIKTsBKcZW7OZNEez929E7mFC1BmGyk0lHgTCp4sVCmcVDp2XmFsRWUfTtm8A0Wkr0apnvNmqKDGeZdPGiZejiI39a0oG0Iv85OW8iEzgbHJUcxtsq2DmdMN1g3vWgNfZCP9E9aBp3yawg54tOpMT6/cPwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2495.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(508600001)(1076003)(186003)(38100700002)(26005)(52116002)(316002)(38350700002)(6666004)(8676002)(6506007)(2906002)(4326008)(66556008)(66476007)(66946007)(8936002)(2616005)(6512007)(6486002)(5660300002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BIvwGVTYQqcZo3JWK1HSBnqpzicB0o8E/BdM4sge82bKmLsW3UGSno0XRbBN?=
 =?us-ascii?Q?GS1JxKxbh4LNwDMjLbALYyijch+fjadoGnV/BP2EX4YRjkFsp4uKiDAdp5oA?=
 =?us-ascii?Q?x3PrBAIGx/Dxec87dcO2R6PHTJ1SxYwvIKWTGPKJRmPacwt9X444S9foTZ9u?=
 =?us-ascii?Q?lNV491nvTFHXIZw8qqytdut86n/a/XWHrzqUvBPoW3f9TiGhzJfFxLtxCjoe?=
 =?us-ascii?Q?4iPRT4YRgN9/4aWtwvlXAjrc5LeEBPVz7V+vmkYMzTp6dKVS9RMlEurqFiiZ?=
 =?us-ascii?Q?ZKbucDxW2QPhvKr8s1raV6c8UF6D4T3BgK5fg3+FW70dePuGXg75cu5I7YxS?=
 =?us-ascii?Q?xIPboIIdNSWAb/NDLezq9Q2H6DbjiHqPACDD3v1bG4dpFpHDie86AiR2wTXn?=
 =?us-ascii?Q?84R4Dj97Yb02evcijQK+Xd2t4MmOgP+b8ulq16ppMKUWmlI1AZF+PNr/flMP?=
 =?us-ascii?Q?yqwzURJqp8t8BwvNPm5hkFBSinlO8TdhoIDNJ7BgOOoZKTdZWB2p2g7Al8Vo?=
 =?us-ascii?Q?Fh01t0LDplNhtk0D9P3reiP/nxyId4UTS6hQpEaI2gscFyIco+cgu9Whhpr+?=
 =?us-ascii?Q?LrqJ2wyCsZRbJa8pYfMKBA1RHYdBCkrRnSnN4eLPOCHeCcWOZU5Yss75QEpY?=
 =?us-ascii?Q?m9Zc97ysnNFeoKFvXKmQWQOauMe4vl5Xlfqot1tOfsZqQestmIYUoy6Dg8XQ?=
 =?us-ascii?Q?Nie/xyRC7UfC2szNfeBonMGWgAww1UsiYomsjdgEmyrtTASHANJvdFEJERXn?=
 =?us-ascii?Q?s0LkwT114OqZvlLD8P7p7T57UzDSNDXF5kopzyKXLAipQ1logVKTOY0s+JuU?=
 =?us-ascii?Q?ejNTPe5BIpxv46Ni6aYkEf8jNjJZCl5779nCDokalXC0Ht32nvShlAaHYrNn?=
 =?us-ascii?Q?bnM1tzjn1UUTcnD8U6xOQbUbt93oQ1dQDK2No2kk9HCkfRa5jab65MNqcgpu?=
 =?us-ascii?Q?KdhDHc7acJWmMU3jzIZwm3kB0SZJVHYqK/sG3gio54wP3LDJNPepfjop0O8/?=
 =?us-ascii?Q?udPgsWnKL8YZEk0imFb3SaA0LtC4Kee7yQ7fSXuyfV8FMjBbRZ1aIJPAYRgN?=
 =?us-ascii?Q?SrbZ67AVongpeNmQ3OqTk+g89CeA/zhtxQhZ7YqwEsZbpc6oybYUPVAAUSeC?=
 =?us-ascii?Q?kzskHQPrnyAE0Emc8FFH4TroNVlCZW0gW5DMOuQ2NX+HaTDbPaJwcYcE1z4N?=
 =?us-ascii?Q?y1vzv0sVgablY4HElwsGh+z+Pryw9/dplXoiAEKvfjtwILpA/sWc8ZIalZGk?=
 =?us-ascii?Q?6/I2dR62xg2FoY6fwIHa7brPiJUuMG6oMAj+8IXwpCZSUXkUd8cefMmkruH6?=
 =?us-ascii?Q?0DW3Z9ODagRO8cEzEiZ9OcmtgzClQlHdiWo3VYLtNCtwawNNAhdKLGEX4icJ?=
 =?us-ascii?Q?AsfmzD5t25s4RlMlixhfyofwU7QLAyt0nXMxAlkJLnFL3lpaGfOLBddXtezS?=
 =?us-ascii?Q?yitXl86aoq91rP5HgI/RtizWCmRccB/dx8JcffpIdEfKB4JWTl6UPDEOfqSX?=
 =?us-ascii?Q?FAUzkrPoYMOazLYMOB2Qh49CQ/4c71hZ087YACLMN5P+PmsamSV6IM9ozEGv?=
 =?us-ascii?Q?BG3oau5fslV8Oj3HsKZy4vCgnJWpghYoJY0qzEdmFt+MBJnT6niG7IiKjZZ5?=
 =?us-ascii?Q?WbWNS+ashhYH/agsMOywius=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a79ed911-d61c-4fc0-7b4c-08d9d570a581
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2495.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 02:10:04.1474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O7EFB2ekbhwkpIhyCMOL5cZwWcpGl8P/ZzFBMUQNAdyBlO9HpGap1EyGgApYNN7I7OJZJYsXBLYlEPdXGt1aSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2783
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the application queues an NV12M jpeg as output buffer, but then
queues a single planar capture buffer, the kernel will crash with
"Unable to handle kernel NULL pointer dereference" in mxc_jpeg_addrs,
prevent this by finishing the job with error.

Signed-off-by: Mirela Rabulea <mirela.rabulea@oss.nxp.com>
---
 drivers/media/platform/imx-jpeg/mxc-jpeg.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/platform/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/imx-jpeg/mxc-jpeg.c
index 4ca96cf9def7..6acb17318cf4 100644
--- a/drivers/media/platform/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/imx-jpeg/mxc-jpeg.c
@@ -947,6 +947,11 @@ static void mxc_jpeg_device_run(void *priv)
 	v4l2_m2m_buf_copy_metadata(src_buf, dst_buf, true);
 
 	jpeg_src_buf = vb2_to_mxc_buf(&src_buf->vb2_buf);
+	if (q_data_cap->fmt->colplanes == 2 &&
+	    dst_buf->vb2_buf.num_planes < 2) {
+		dev_err(dev, "Decoding multi-planar, but capture buffer is single-planar\n");
+		jpeg_src_buf->jpeg_parse_error = true;
+	}
 	if (jpeg_src_buf->jpeg_parse_error) {
 		jpeg->slot_data[ctx->slot].used = false;
 		v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
-- 
2.25.1

