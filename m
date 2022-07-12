Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457065715D8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 11:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbiGLJi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 05:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiGLJiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 05:38:24 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30066.outbound.protection.outlook.com [40.107.3.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C75066ACE;
        Tue, 12 Jul 2022 02:38:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMGBxafKws2/OB4lMz+pOee2G2Tv6Cn+4r+eIsecVGQ7Om6HQnyazcl5qH7puIUqaKZblqGfGLOjlWHM0nfOoWYudYX9qc3k1xM9C+M8W3kJ7k2VFVmKpoIIeMDVXSTmQX34Yl5OInieLq5tJYTXi+Vrq2TqW+cy/AJBftC5A7knrOnFxcmFbV3NsjEgtsPZrLPLSN48LXCpU6PfdtX1lhNuFkRTDY8IvJI92m7T1wBJc2B9LxW1YkVREuM5AppaJu2X1DZfQ2qVF7YEQlI/9Pii6eYnTkeEZ9lbhF0JP3epzlK17tQ0uUStu861at9C8sHLos70sl1KHbC9TM/xXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUl6BBIJxeYarpHeMEyGUB7Qo/Kd8TrppMxr6sgXxuM=;
 b=i5JPem2EaNDTSSNs0L9dCqfXLCFZXGZr5uzIxpNiGe4Kno6VCi68APUq++76eCP/MZsg3MVhUZvhiiG9ZlaLWLt3RiX5p25UWIHYIbvX5L7XWn7mdOaiCe2zyM8qdJOFvdT0voiWx0+ZZtL+U5kkAWFh54dOJDLn1J/tXLLiaZk96JnWXqOpIKnQ2JvEm+EjIE6l09wtrvvQP0u8+IsAFHWKkuKiXtiKXRC7y7Orx3w2+nkISbgRuOZst4lozW0wu4jMoAF4AnTpKZWBloM2AntLziyFYAwH7dOUqfe8GN3td81naAwEhdBHtShg2bmeqd4xIvkjxYQtWH3IVIImkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUl6BBIJxeYarpHeMEyGUB7Qo/Kd8TrppMxr6sgXxuM=;
 b=iLyIndi3B7iucNsE57i1rIqVgOPpg1CUZfXFigTCFWqhM1gXizjlpGYoLT8taRskjJLNtMHKQqRqvAr1hcj1Q+GgLEYs/Z9XPjHJ1kHr7U7TlvAXgMln2K2R4scM98EMU2He///SAplZCkFDn6nrau74X85xBdALu71A0Aotn/E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB8PR04MB5881.eurprd04.prod.outlook.com (2603:10a6:10:a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Tue, 12 Jul
 2022 09:38:20 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3582:eb2f:9652:d98b]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3582:eb2f:9652:d98b%5]) with mapi id 15.20.5417.025; Tue, 12 Jul 2022
 09:38:20 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: videobuf2: add V4L2_BUF_FLAG_HEADERS_ONLY flag
Date:   Tue, 12 Jul 2022 17:37:54 +0800
Message-Id: <20220712093754.23370-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0063.apcprd02.prod.outlook.com
 (2603:1096:4:54::27) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e661f6cd-5641-473a-c616-08da63ea41ad
X-MS-TrafficTypeDiagnostic: DB8PR04MB5881:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gh+ZEUxfbd+LRFHjGs/6HQ7Moh5gExUu+ap12nSBkaHyMAh+nWNUx30Ikwc6E257Cc66XkSc8vd8Rdu7n998+OeMobvM0+TORpWlmsx5SLpZC5ffwYuvUim5xdemcwUGkkmDYN6jt9lCf0iH6h5/lo8lkMRqQwkjYnAUYEqfsnoQHsmqRW1iQlbdTBspSG4Pp0X5fce2WnSwIymOV1WqGf9OndYL7v0O2JoraxdodNtvrryrXFJQUGYG+OC6AfmPJb97VDRVdG7tObvwJw1/ABRqLzerQc/dNBj3shKplsUKuVQ8DUUOq8JyMO+WNBYk6W2iv+LvbIrf/44sDcSGrJ8EOBUJ8fSGIhxmqerq9LKBQkI95xKCRgIMzmIpWSv73TcbSNnK+u3DGkI0Gzn5GeOqAgGlhj4SyFtwc27sf8kIT3nO4kEFBvX3GawTrC2zXlnW2jv2ZJRrsMTom3xRwKMch86BRkfdeIKD6j6lwuk9wZqys1xJ0DTDuhPh4AHRitWOSb+7pvyuYzj43kCrs1E4YnL5e8BgpZBC8YMZxs/zrZgPkIZ6mL5pc+f8NVm4eA/f9t3baxrqFpu08X6da5l95XC3Hah8hLKOSWVUHxeNtmd+RM3Qiwo4i8X5NkO5/8eRyQqgGJrV+L3674G53lN5aJzZEg49KBhD9oRRBvK/V/ga/qQCZrOuBRriUX/RjeLg3FUG241Ti+0mhxs7SJE0bbJZ0U8JrB1zZOcvou0dJsx7fHcEOahLPy11rr7h5Vw5FSbOO7HVx40fmRD2yrZf19/BFAbrg4QhrcKu+ByzeT4iH24ptCNPh7lCleJe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(26005)(44832011)(2906002)(478600001)(6486002)(8936002)(52116002)(7416002)(41300700001)(6666004)(6506007)(38100700002)(38350700002)(5660300002)(316002)(186003)(1076003)(83380400001)(6512007)(2616005)(86362001)(36756003)(66946007)(8676002)(66556008)(66476007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7oyAcf08cvRPWUCjJuG4RrY2C7fHQkVV8zfKWoGXoC5cfaHUM9FX6Vs4ROkC?=
 =?us-ascii?Q?YvuGzJtFtFZjbL8lqvRwVOrTNO4L1JuTeSvpA2zhOP1/UOHkGZhKD8CHIkNm?=
 =?us-ascii?Q?UHC+Bwd7R7fbm4oHjneBrQdwztWN4bJijpWFHJw/L94dxnBDAr2fuTjkpvBm?=
 =?us-ascii?Q?KThEhXUPZiIBOiRh4VjfpgNUtClecofVvsFfh5s1Sujg7WpzP9AHC5SOvVNC?=
 =?us-ascii?Q?lKv2GNgB5VLTvqNHAG6NymkbO3eZCsr5aWlmDik55vuC7peVUrzk8IYEJjNv?=
 =?us-ascii?Q?k/l+DuBw9pcwzQjlD0xk2qLlRCJv8bA0KA63vTrKLnnxPKOtidUQ3wx/m/10?=
 =?us-ascii?Q?Og71xZrOmbRS7xKcc+fsjXpvzc3sx3v+zsPiCNwdIpSDJNP7peiK0b//qXlh?=
 =?us-ascii?Q?zNPWqdyr2F0l+y3CDx7mXHthc1ffPdVwq+L794E2o7GhCKvoEQ1ynLmTwkX3?=
 =?us-ascii?Q?Wzdrw+8/B4Je/zBRjinYnPz/D5J7lT+tv3MwET9kRvHqjWZcSJIbB/rGBSTu?=
 =?us-ascii?Q?Zwjx+EA9ziE3NEVg1vkqqGR5Nn1reFnbvLjH9tN+F8rO6N7NloRQEgg1uFzX?=
 =?us-ascii?Q?Wdptlkq3uwkLkr4mD8WZE5CGlk/DYKoRW3sxSCsiGam5WyXdY6UK2o+ywrTG?=
 =?us-ascii?Q?hhsIHMFCS8KNj/LyDIolFj0J6lIK9WilUOnOT/KJ5dxHDunMu/kdjsf/Ocfk?=
 =?us-ascii?Q?WzlXuVuZZ/oRmgpKKgXmkF2GJu3bh/ExZOZZ5aPwV0hpo7H8EWYRBQFrXazu?=
 =?us-ascii?Q?2/md5lAf5CQzmFF8S3qFhkPbmuuwrNRjqVuq6o++gYz/Kfrf15cpP3EE/6q1?=
 =?us-ascii?Q?ybu5zKWuWOImw9I3hkDbxtq/ncUllbqo4gBUe9ETcpLsKbtvWi28JSe2h6Fv?=
 =?us-ascii?Q?kWZGZ00LI0QAdL9yZ2Bc3TMMq4ZdM9y3q53C3HO1rbL0HBrB2I/me+rZ9HlE?=
 =?us-ascii?Q?v3MIkghHZN/HfXBPcpyIgDc/bJE9D0aDuEBLxGTJo7HmkENZLiZQu60QK0m4?=
 =?us-ascii?Q?9Mwc3cdzkCjIu4YfvxwrYIcXtMnYiA6TCguzqrk6PY0BzZLfbMGPciPGuI1c?=
 =?us-ascii?Q?g1ldL2m4E0U7/u9rBLIOc0Kb9z0OA3PpcCheS8tSj0jFJf8CmSQrjJP395DE?=
 =?us-ascii?Q?0qAwOjmIKfOXhg0ZeY8aLhB4lFpEOEV4Yqx8qUF2MMPQ48tmPaTCymylFGzr?=
 =?us-ascii?Q?WeE5wjx7ggC9IZPX0ltFeG124W7q6QmPLTXklEuveVKSB39WQnI121EGmgRM?=
 =?us-ascii?Q?gh5YnAkPt5ELYpjGPtAYeQFtkNGTOxLL8Stm5R1IBJZwSl/hUNrwbCyMS+Jq?=
 =?us-ascii?Q?mr68LI4JUncLWb28X0vcP4n3A2xE6FTddfh5h4oN1CbV7WqZ5x59uzP4aOKe?=
 =?us-ascii?Q?T846Ur3qmVNP6E9d++/tmZoHA4/+PILCxy4tH8vUqk4L6JnUNIAstuyHh2/C?=
 =?us-ascii?Q?PY/9FeXTSKNG60DA8BIdsVyA2dh0cqeUg5MusHlQ/XpC4JcICZK39ASxd/oh?=
 =?us-ascii?Q?x7dxkkYaBWdunMurBrBurvtq1LpXbOUepw70jwTICQvKLzM6ZRbevMV6yn+v?=
 =?us-ascii?Q?BamPUgyZHwDrTcW+jkFh2IlF6GoPw8+jYPXV51RN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e661f6cd-5641-473a-c616-08da63ea41ad
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 09:38:20.3313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fe+l+7utAL+laCXwpzblBl71uaAcXixQX0o7nxholHbV+uos8dpU5vA3tdVouZL3OGTNnPLr1JGLwKxoXPHfTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5881
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By setting the V4L2_BUF_FLAG_HEADERS_ONLY flag,
hint the vb2 only contains stream header,
but does not contain any frame data.

This flag needs to be used when header mode is set to
V4L2_MPEG_VIDEO_HEADER_MODE_SEPARATE.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 Documentation/userspace-api/media/v4l/buffer.rst      | 11 +++++++++++
 .../userspace-api/media/v4l/ext-ctrls-codec.rst       | 10 +++++++---
 include/uapi/linux/videodev2.h                        |  2 ++
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/buffer.rst b/Documentation/userspace-api/media/v4l/buffer.rst
index 4638ec64db00..18a6f5fcc822 100644
--- a/Documentation/userspace-api/media/v4l/buffer.rst
+++ b/Documentation/userspace-api/media/v4l/buffer.rst
@@ -607,6 +607,17 @@ Buffer Flags
 	the format. Any subsequent call to the
 	:ref:`VIDIOC_DQBUF <VIDIOC_QBUF>` ioctl will not block anymore,
 	but return an ``EPIPE`` error code.
+    * .. _`V4L2-BUF-FLAG-HEADERS-ONLY`:
+
+      - ``V4L2_BUF_FLAG_HEADERS_ONLY``
+      - 0x00200000
+      - This flag may be set when the buffer only contains codec
+	header, but does not contain any frame data. Usually the codec
+	header is merged to the next idr frame, with the flag
+	``V4L2_BUF_FLAG_KEYFRAME``, but there is still some scenes that will
+	split the header and queue it separately. This flag can set only when
+	codec support V4L2_MPEG_VIDEO_HEADER_MODE_SEPARATE,
+	and the header mode is set to V4L2_MPEG_VIDEO_HEADER_MODE_SEPARATE
     * .. _`V4L2-BUF-FLAG-REQUEST-FD`:
 
       - ``V4L2_BUF_FLAG_REQUEST_FD``
diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
index 6183f43f4d73..478b6af4205d 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
@@ -1386,8 +1386,12 @@ enum v4l2_mpeg_video_intra_refresh_period_type -
     (enum)
 
 enum v4l2_mpeg_video_header_mode -
-    Determines whether the header is returned as the first buffer or is
-    it returned together with the first frame. Applicable to encoders.
+    Determines whether the header is returned as the first buffer
+    with flag V4L2_BUF_FLAG_HEADERS_ONLY or is
+    it returned together with the first frame.
+    Applicable to encoders and decoders.
+    If it's not implemented in a driver,
+    V4L2_MPEG_VIDEO_HEADER_MODE_JOINED_WITH_1ST_FRAME is to be assumed,
     Possible values are:
 
 .. raw:: latex
@@ -1401,7 +1405,7 @@ enum v4l2_mpeg_video_header_mode -
     :stub-columns: 0
 
     * - ``V4L2_MPEG_VIDEO_HEADER_MODE_SEPARATE``
-      - The stream header is returned separately in the first buffer.
+      - The stream header is returned separately in the first buffer with the flag V4L2_BUF_FLAG_HEADERS_ONLY.
     * - ``V4L2_MPEG_VIDEO_HEADER_MODE_JOINED_WITH_1ST_FRAME``
       - The stream header is returned together with the first encoded
 	frame.
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 5311ac4fde35..6fd96acd6080 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -1131,6 +1131,8 @@ static inline __u64 v4l2_timeval_to_ns(const struct timeval *tv)
 #define V4L2_BUF_FLAG_TSTAMP_SRC_SOE		0x00010000
 /* mem2mem encoder/decoder */
 #define V4L2_BUF_FLAG_LAST			0x00100000
+/* Buffer only contains codec header */
+#define V4L2_BUF_FLAG_HEADERS_ONLY		0x00200000
 /* request_fd is valid */
 #define V4L2_BUF_FLAG_REQUEST_FD		0x00800000
 
-- 
2.36.1

