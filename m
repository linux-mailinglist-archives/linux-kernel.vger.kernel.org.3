Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A818B55C4C8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243505AbiF1CUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 22:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243441AbiF1CTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 22:19:41 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80072.outbound.protection.outlook.com [40.107.8.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408D0101E5;
        Mon, 27 Jun 2022 19:19:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Snm2sCYZqxO8Jtb5262BWUxcjXtEgsPEXyuXyv1Sud/ww/Tc5M62uBoTgv98x1Hho4RQrVHzIRMHY9hk22pZCveHXajNrrA/s+N1g+vnNw/Fk3iHSqDa0bkaioGWzzP83P8rjO3xj2bo4RXGY2ilBJUGFWU0OXvSmekI98iAEU8LmPvPDewBYCLmsr/ZgmAGR4qFZSMMxxVSpFXamh/r2DYmXxP5YJapVecxyzq/SGepKjWQFP0iHjyzYJ/Z3F7WTD0DclNsh+PY1bWUP9ES2SwwCRST4jp7ZTctlqkLBi33jwqXc/RztPuv8U6AQeJ8A0vvzrvlAnEsxQLobj/GlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tz0Jmv1n7+1GhJk/NLHSRXGo9ktaddFePgiG5lW7Ils=;
 b=SbdfONL+bXKsS3T9PyFV/bs8tBtodoVg8uqykiqUBydzBCR9s2jsDYB/wWJvY3KqXFeI7eF7TrfYsujzX0kGFQ03392A+4AVI8qA3Mql0Lw+HjypBxkpuAoD6wCdZqx7LYVBEbfioy1yNWhx/OSnlqTSr83XdGmSC3pxrqE1oeccx2YtcDAFHoDl+eas3NO+577AFq+SWHwtT8mfCKGgiANBDpb58OZGfPhskSad2YJYCYS+UJHG8rFvdtbv/TKVDWWZb+FnzeP6e1/z8VvhBeRGm83klRyfSHHWbO7XvOJW2XgII4P1Xce/pT7O2ZRUhxRK7ZBWN+1IdtCNDUtdCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tz0Jmv1n7+1GhJk/NLHSRXGo9ktaddFePgiG5lW7Ils=;
 b=kPKqa5Qq06kF7I9CZCvajlj7JfbCWeO41OBxILe3v5Twh0IG5ZDES7ZfyUiHyafyMOy6LTyCqJGcnz+Ukodvw61Xelw2WAZl1C4Vu8DkSsis2h8Y59PKf2eS1GnIjHvVBs3iS75S3WSYWiJikNqoic6jxpWQaPRKKdQq6DOagOQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DBBPR04MB8044.eurprd04.prod.outlook.com (2603:10a6:10:1e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Tue, 28 Jun
 2022 02:19:37 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3582:eb2f:9652:d98b]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3582:eb2f:9652:d98b%5]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 02:19:37 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: videobuf2: add V4L2_BUF_FLAG_CODECCONFIG flag
Date:   Tue, 28 Jun 2022 10:19:09 +0800
Message-Id: <20220628021909.14620-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::12) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a26b6096-b4de-4d82-15da-08da58aca641
X-MS-TrafficTypeDiagnostic: DBBPR04MB8044:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dny5i6WifHKEgkrDsgcApwTzReensBXfwoqfu8/Nsu/xwECeyueNgDXtV+BPfk69co4DlWwT1tBDpVxgfgjspplfMDDGcGdFxPBDITFTBOfkQru8TGEhyXrAJH/78LSPGJqBATXJ4VE624+DniAOFmw77cciJBobAvMvRkzx7KtQiU7Z+tIQr2Ypy8HRVgg/11DL7qx4BQfuQMcgURZ8mLu8+uFyIs9G5s+d+ljQeZaNE6SsYSSnSQpH7P5HpC2xNU8zb/uqxnOSnoSJUhn+HUaID3OVJIy4OR/bXt890jMJBhB10LNYDx8tc6FNeh2/vV3WXKyrB3g6FHsuTVFqFVrYeQS0l9ie9/xXNBHegaG3JKdgNgJQAQLBMGh+ibcBp/fk4JctMpIOzWipnp1Qg2TJedBcKtfux16DzguSd/ehs5FuFBn6Xdc7kBw/aCJGXi6Pb9klpxDNYpVV9DT9HxqC2Mj9OXtm80GDsVLL5DQ3FRTlcSjpe4A13j0yszsuodcY/SPtrfnWeX6bc+A3Bev4YEmNQuR+j7x5f/UCmns/3W6GlZ4STO6qZuROeMa/K23MFXsRJ/9VBUsJRZsu3fVPgJQZLsfEbYs05qrH1aUgXn6FZH2EhEEuhIqscLeCLlr8l6+a7Po9nK/H5F+wsDdtSkaHcq5MfdPiIKdp0vmAVeOe00ZDho+j9bPmpb3beaFODPS1mA48WRhzTPD2f6Q+4aTAihRhnRV0976RfKnggZZmX/9Cjr0RNdqv4E4AE3F9ETcyZb9NxDvjsGTGqdJnclpP8SxP2t3h3RMNumk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(5660300002)(44832011)(7416002)(2616005)(316002)(8936002)(478600001)(1076003)(36756003)(41300700001)(83380400001)(186003)(6486002)(66556008)(26005)(86362001)(52116002)(6512007)(6506007)(66946007)(38100700002)(38350700002)(66476007)(4326008)(6666004)(2906002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O+azeirNoOZDoscVR7ZEBLpXd408syxWVBqOZrdoXY3ZAR7PHxlXiyI3O50M?=
 =?us-ascii?Q?ZLqyzofZbj8YCQMKYWB46mxSqOiOPt8rUHwtssPDPkZusntbn8IkCcsiY6cc?=
 =?us-ascii?Q?vvlZ3y0Genqm/X2DMW7L67F6Dd8MclPiAlpGVr+C2YAqA4K1E7lBNkqjMs6x?=
 =?us-ascii?Q?u6As1Xzpkk0QRQTBJ8WkV4qZrA3P3CUbJVkpyFs91PJvSh5N6lj+F6470v8v?=
 =?us-ascii?Q?H4VLUsEGLcUSCt865L/jAQnl58++mIdTB4M5b0vinPzqTyX+5VMIEG5fDxs3?=
 =?us-ascii?Q?7ppMxPyWGFhrCWPNaU0dxOTpU/VpU3muuVk18/cQJbmKMumZbxDvi2eCsXge?=
 =?us-ascii?Q?9mMh/i0lmfXP2jzsVIivhRGz2KZdyMsqwGHzsmvGWx1m33uWOSZDmssxi6EZ?=
 =?us-ascii?Q?zCDTq3S7R9syktzB/dxbUXgmf5WpjJwTH5UECRoQXlaA3F6DDk0+qKLggBtP?=
 =?us-ascii?Q?Tz9UYBN8rtGVT2DEmhpEbrGpfEwRIY3jRErRUEAkHDVx+uVw8torTq1exld1?=
 =?us-ascii?Q?B1lwN30SEJI/uuhza3/sVVJT251XyajMYYo7uYWh+ah17VoNZt/E81iheD1S?=
 =?us-ascii?Q?4SbTA+QnabQ7ag2GLvooWvqu3Kc9wOYzIm9gG5A1fAlHWnyTSZkqbS0aLJA8?=
 =?us-ascii?Q?CI0FD0zZ/QmSaqkSoIWyH0/4Ao3zKoYbSdyMxnrvTDTDIH7wbOPeBmsCDom2?=
 =?us-ascii?Q?6ml8hRO51x77EFscjUj5wt0E0tME0c+Aesbe9wVW670fBi4tB1nWDfVqurQZ?=
 =?us-ascii?Q?c0k3U8sQK9nUvlVtRO9SrxWBSFb+0V9Ut4MtudXaTxXF/wUYQ2TZG5ZOV9ZT?=
 =?us-ascii?Q?8M7ADN5eQIdK7GDsDBdReT3CVZsn4VGEC31xD5rWV60SN/FwaMWw4mSsnkQf?=
 =?us-ascii?Q?cT0QUtCk94+DaYi3CkfWDcTr6TnggVW8avj4ezfkDzQTYWIbBn09uQJSh/sP?=
 =?us-ascii?Q?mOPTZ61R0SDO3AhYlTBKO8pcG12+K10OuCuqedOOtHDxho76xxKMprZlp1Vz?=
 =?us-ascii?Q?sDL/Mv0eleOI7S/xeq1hpjVuf0o1pQWtxAQeZOvmUrQUM16Ki/lh/1PSTnsR?=
 =?us-ascii?Q?zh+SUmzxKKBt1KNjcPlYKeQtWx5V+EqvnEYUMR38H/fAe762RbAioAhSc7oR?=
 =?us-ascii?Q?xmBVaO6KBQC9EjCnVu1lGwzTgJhAoBzVUh2I9KpsDUMYSvdfmXtHnmKNB2Ih?=
 =?us-ascii?Q?MvcC3QqbBC8lMUvmZ5PtsMxRrloyXENb+gn7awRp3ZI6UyfbeolExGZAiT75?=
 =?us-ascii?Q?9gajqtUpU+XAL5rI1qpIf6AB6J302N4UXpjYehfCWdaoscgkSI9cqCgjQv7T?=
 =?us-ascii?Q?8ZxLR97h4BdLS2S9jxnjZ3CZ8tc7KC0K6AO37G9929z4wsjndb/xh3IaTi9j?=
 =?us-ascii?Q?ptmICE+NCSsBnci4NwBLp7VF905XqpzsBnEXKiPql0Qj+Yv3SiCtTrmqSTeB?=
 =?us-ascii?Q?XJFtJzzoAcmRJtdQMbXpoie4ex09zeVVDVNfXv/EJUiyQuYPzjTNmNmRVMx0?=
 =?us-ascii?Q?9qmpw0uTqpvOw80a7+myL8u2HkgHDfIUMF76GOwrMj9K1ffdr4nCysXPa1IT?=
 =?us-ascii?Q?PXnIPCkSfWsm1tEWxdlZmMjGynTm4ZETuLEmK+z0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a26b6096-b4de-4d82-15da-08da58aca641
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 02:19:37.5123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dSRjiBT3qCA/POJN8OlLVYmCdQWZKlkPkNws6+nMUmgM9AJRHp95wjgufh23guUjnEBdUvpsJ/YF7/d/G0VwfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8044
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By setting the V4L2_BUF_FLAG_CODECCONFIG flag,
user-space should be able to hint decoder
the vb2 only contains codec config header,
but does not contain any frame data.
It's only used for parsing header, and can't be decoded.

Current, it's usually used by android.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 Documentation/userspace-api/media/v4l/buffer.rst | 9 +++++++++
 include/uapi/linux/videodev2.h                   | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/buffer.rst b/Documentation/userspace-api/media/v4l/buffer.rst
index 4638ec64db00..acdc4556f4f4 100644
--- a/Documentation/userspace-api/media/v4l/buffer.rst
+++ b/Documentation/userspace-api/media/v4l/buffer.rst
@@ -607,6 +607,15 @@ Buffer Flags
 	the format. Any subsequent call to the
 	:ref:`VIDIOC_DQBUF <VIDIOC_QBUF>` ioctl will not block anymore,
 	but return an ``EPIPE`` error code.
+    * .. _`V4L2-BUF-FLAG-CODECCONFIG`:
+
+      - ``V4L2_BUF_FLAG_CODECCONFIG``
+      - 0x00200000
+      - This flag may be set when the buffer only contains codec config
+    header, but does not contain any frame data. Usually the codec config
+    header is merged to the next idr frame, with the flag
+    ``V4L2_BUF_FLAG_KEYFRAME``, but there is still some scenes that will
+    split the header and queue it separately.
     * .. _`V4L2-BUF-FLAG-REQUEST-FD`:
 
       - ``V4L2_BUF_FLAG_REQUEST_FD``
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 5311ac4fde35..8708ef257710 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -1131,6 +1131,8 @@ static inline __u64 v4l2_timeval_to_ns(const struct timeval *tv)
 #define V4L2_BUF_FLAG_TSTAMP_SRC_SOE		0x00010000
 /* mem2mem encoder/decoder */
 #define V4L2_BUF_FLAG_LAST			0x00100000
+/* Buffer only contains codec header */
+#define V4L2_BUF_FLAG_CODECCONFIG		0x00200000
 /* request_fd is valid */
 #define V4L2_BUF_FLAG_REQUEST_FD		0x00800000
 
-- 
2.36.1

