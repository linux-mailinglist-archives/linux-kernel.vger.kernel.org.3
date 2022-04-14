Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B05B500926
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241509AbiDNJFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241769AbiDNJDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:03:34 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10049.outbound.protection.outlook.com [40.107.1.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E0E33B;
        Thu, 14 Apr 2022 02:01:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gcPhBSa1Oo4PwwH8i3dPavMvxQwH9SkxFDuriGYopfIq+0CcpZp+fHhWQeRyUDVXEbyec+WtV/orIEyREauYbJhu09gI/a/qPG1ZZv1tEnnrt34U1tx+0rw5A7mnRDMR9wTk3Hc4vGh9l4uRj5asMu+t7gI8PkpVQDnQw8n+PebJWw9eS8zjM57LQ7a+GAV23xWix+8uYkBduYdo3UO0dvRpCbqOqURmsKH+ciBktRAawWRU86gyGqQZ/gOgAtirjz40wXWFfjg+32RkEx2DYSKeRy4ddjQEyd2LUyQ75b8rj848vGtFLsDjb5YNGjSWi6+pIq4Q19XbqPMt91Febw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvgCLFXsubbtA01RXJpLMrioAnoJFVPtPhj24b1wrTA=;
 b=DGUn6ufxdEnxZlFt/r0VEb2U45BsmA2m9TmiAvX9jrGoC8rpzwcHfmkfPaNZ7RzCuNUCle5oO1xol0zpyc92FwP5gM9FodHMZlN6Zf0ygH8Ca+SFJq+DeAjCQ6hZxAKgM2+CIimY2gCJy7ImUr3I5fffMC/t+uQnEEtZaoj5m0Za3ja+45KqlCouVnVMgPi1vo+ZOvFB7RObOj0+IBOoevMjfZF87j/Pf5pmBLmECTo5PCVRaUO1K6u7uX/P00+UzXinmvSA3ZyT4c66CWs5Zv1BTx9X6bgP92blPfhzEhJukBvHYCxvaNVbj8kq+zgC2qpS9cB6CZuA9ZeTQzIX6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvgCLFXsubbtA01RXJpLMrioAnoJFVPtPhj24b1wrTA=;
 b=GNQ/odc3AW9bnDXywhwdvlZPUycRFX2DpRtye80wnHJKRk4fgiYwjMmNHfE9Z9a1fWH6uropKRIuH5GOneRVSrNCgFbPgmVPGVRVgdW3Cyjpi2wA1sX3iVtbXsxfrT2i/m2obzm/BneJXdb7QSaTb+8SjR2SEJ6YQfmTlXFyty8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM7PR04MB6885.eurprd04.prod.outlook.com (2603:10a6:20b:10d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.30; Thu, 14 Apr
 2022 09:01:07 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::d8b5:5914:5189:ffa5]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::d8b5:5914:5189:ffa5%6]) with mapi id 15.20.5164.020; Thu, 14 Apr 2022
 09:01:07 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org
Cc:     hverkuil-cisco@xs4all.nl, robh+dt@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/2] media: amphion: copy timestamp from output to
Date:   Thu, 14 Apr 2022 17:00:28 +0800
Message-Id: <cover.1649753692.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0011.APCP153.PROD.OUTLOOK.COM (2603:1096::21) To
 AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d741faf-076d-466b-7b05-08da1df54fe7
X-MS-TrafficTypeDiagnostic: AM7PR04MB6885:EE_
X-Microsoft-Antispam-PRVS: <AM7PR04MB6885260F6BF07FD04837756EE7EF9@AM7PR04MB6885.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C3n33wXv25I8Qijk9B/VOQBkOg6Lte7k0rX+gCFR6xBJHD86b+fizzdveUkiqa7dGNZOTCRTmp+2Sz+uZuGimKVrVf86XPhT1DcA1/tCt1E8yuPwIrQuOsWvrshQlch/672gfNu2iEav6/gvTrLv6t4g7XscS+yQ/CuW+6uEzEStX6L+OQik9EKRVvcNgpu6WTKKXoFKCr2bA6S5PH9yXhNmBtV50NDdzZIN+OmMMsH6oRyqmwcv7NzAE9HRkIfp37T/EdUP9MbdtlaRsNnqEajchnNWSuwJlhRFdQTim1PYjvntzefTrm3f2hfqPq8uagaSnRmTYhdXb6kei+D5gH1SbxNPkELUeNBWR0SN6exf1XT7qaGleWvlRCiL/8YWXcfngUFMqmjaZE2Iy6QgalVsTARl9JMSLgp0zPWInPLijZMkjkbyzNem5lPB16E/khw+jtpQzgMgnUX9sEveAGykD1qDM5ZQy+5/0nAvYCnnQfnZoJviNyzX0A71i9DIikkGZpVmreUmkrIl+5DG9fFMnx2oPsBBAiaSMXElbfkeaOSEcfMD13RcUnU5KgllhwZ/jUHR41OrQYJ6Loiiww67Lgt9FiqoR9GSVQVwdTbw0pkjle59nOtI5BqXorfx/HCzUdXIEvDtvRDLy1WAByIw8+poCckOG+kYykME3ot/uC2AthALzRZOt6oo/oPHeR3ZBJfCwomYA3uZsCXT7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(38350700002)(2616005)(83380400001)(5660300002)(66556008)(8676002)(52116002)(86362001)(186003)(26005)(7416002)(66946007)(4326008)(36756003)(2906002)(8936002)(44832011)(6486002)(6666004)(508600001)(6506007)(6512007)(316002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NIgXYe/fx1WdRDY7IpYlONKDeNYXq6jhnzAd8ZtRi98hGa1ZcCeimNRhtF5S?=
 =?us-ascii?Q?f9nBry2HiPnGXtvSfwcuzD9hYWafsFunbPkLi1mrb7tTqbSWgZ9nuSsWJX6V?=
 =?us-ascii?Q?xueF7GqDswHL1xGDSkoL+5R1bFMk7rr71EF6vryFXinr2Fbmcp64yvI3K10m?=
 =?us-ascii?Q?A7OQIB5j1gadI/RVwpA4+TooPaBABK++yUbgV1Z1XoioEoBQDQxrRDaZPwaD?=
 =?us-ascii?Q?L5Yn4nGm9ReBzk/cVIsV/3ncNGEGjUpAb4El6mgKfLDJiaJatBL56J4rE9Do?=
 =?us-ascii?Q?S1MfAmRf7jh3TBhTwhZttXaSVhGXLYgFont+VERXVzKdeuLP3zQVQv+9NM7Z?=
 =?us-ascii?Q?Mq6c8zsje6rVUyu+QRC+LYvaP/W1YC/z7iCmhtxxid9QNILPUbd29Apd/aYn?=
 =?us-ascii?Q?/rzcGLKguwxFcPVOq+keFwcj0dr7QLFdcH75c+3GwDYx8Z3MrJ8cakp8YxjM?=
 =?us-ascii?Q?mJZHbVHw5VS3JzJHWyuw5GnfD3pTNXr/xTJdTUNACAzd+X6R+phK+n0qDaeq?=
 =?us-ascii?Q?E6pjWVlzJLSFvyHzTZ8IEmsFYmPaMmUyPB3RDy6Btn51TC6WX+qkFEfnzZee?=
 =?us-ascii?Q?pO1kv4BMtZl0RH6Q5ZtFcpQH4tbEIT/oTLqHsNhqpX6MinfcsgjCfOB37ycl?=
 =?us-ascii?Q?KmXGakVq/PAEq6/TuLh1S9NmVdiRQO6o0nlGW84s0ib3kNO5Oiy5Tujnu91O?=
 =?us-ascii?Q?+VEdDEkrZKHIykLg9tkGacooj9eZnI/t9+s9UrQ3fPFCr7Y+LPH+9+QCfUpo?=
 =?us-ascii?Q?7eYMkos4Oqal4MmVjpi1q/NiU+0KNlD5ZEzNDRShCVgp/M61ld3wKcExiSow?=
 =?us-ascii?Q?K9BgRq/QNY2jAcSunioeShRGHGn8dgwgNsRmuBozQFhy+C5+tdhanak7lLd7?=
 =?us-ascii?Q?eMLsdMsDEpmwMDOR5TVzMf32bTcxtjCO3CvdAIUshRb89XXoRfZYXJbvdnGW?=
 =?us-ascii?Q?ccS9ya8+gWflIwyA+XWJtZTDwEsJ2gACamnJ91JBdOhjb/my4jXUYDgX67dl?=
 =?us-ascii?Q?ANjd0ACh8hmK/yEML1AOkiPDCQc9dfYIUSWkHyOei9buCMwci7J2kLtONk2K?=
 =?us-ascii?Q?1C8vJ+JbHu2PEyCvEPz3jqsNqFyxxEiaKaLdxAq4IUn4GV62ghq2g93s+Dd3?=
 =?us-ascii?Q?hCxJCXxImYeIcdoUnI7K6HPduhgkxGzMp2mNWmjzTFPe0OPvLEFDzC/DD+ZT?=
 =?us-ascii?Q?uwHcSgAAQ3ZH3M7n3uT4rkxeg9J5egtGjnwvgQspdE7LfJ4F9IC0NAdL/k/s?=
 =?us-ascii?Q?Rxzr8o3TsAZD7KEazfvLodTOYbIFjiAEwvy1JWXjSlSqRWDj7/PyhbBcmQk8?=
 =?us-ascii?Q?AH8H/4Vo2effxbslvlBl12HhN2SlTA/f/nj4g/Ivg0nXaO4Nkyr5lM3DXcGM?=
 =?us-ascii?Q?ZPxNcVV96v26aCaP63RXiMp3UWnUSmEv17RJ76E/2QXqYwotnm+U77vCK1G/?=
 =?us-ascii?Q?OfD/+iiznEO9fkYTPz0hB2TGz0hV8TSN4nJ4eLlBu17x3BuADQdahO9eMt9o?=
 =?us-ascii?Q?R3eQLWXoaeZBoV8xJJo0+HLnqerLSQLnDK9Fqe2Jm26c/w3RkiizZmH83wMt?=
 =?us-ascii?Q?pFpaACyQgSFBdm9B7iwQz8CUyw6ZuhBUH4jW37P+5lCDvSBZHoeERU7DzRUC?=
 =?us-ascii?Q?OGKjIhgdtd5E2x1pjzP+6PdWl02FxdgXWfqO25MB2gR5ZF1YdNjMs8Z+hylN?=
 =?us-ascii?Q?3LUAleM8rJ/qd6u9f0/K9KEK/PHqXqKvWVVOVcOrOlAOwU7JWUwiKL27xIpa?=
 =?us-ascii?Q?B8w8z6kYCw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d741faf-076d-466b-7b05-08da1df54fe7
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 09:01:07.4234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GwfZB3kiUc+1FEqT/Vj1pSEqpGl5X8iPTQ86WSjlNAGW0gAaV1Nxb/tx/u3c4mTNr111wYaJsQ7TMfJL50MCXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6885
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2
- reduce the min buffers count

There is a timestamp manager in firmware,
so in previous, driver will pass the timestamp to firmware,
and when a frame is decoded or encoded,
firmware will pass the timestamp to driver,
then driver set the timestamp to the capture vb2_buffer.

But there is problem that the timestamp manager will ensure that the
timestamps are monotonically increasing.
So if there are reorder frames, the capture buffer's timestamp is
inconsistent with the timestamp of the corresponding output buffer.

It goes against the description of V4L2_BUF_FLAG_TIMESTAMP_COPY in the
specification

In order to comply with the specification, driver should copy timestamp
from output buffer to capture buffer, and there is an helper function
v4l2_m2m_buf_copy_metadata to handle it.

Ming Qian (2):
  media: amphion: decoder copy timestamp from output to capture
  media: amphion: encoder copy timestamp from output to capture

 drivers/media/platform/amphion/vdec.c     | 89 ++++++++++-------------
 drivers/media/platform/amphion/venc.c     | 47 ++++--------
 drivers/media/platform/amphion/vpu_v4l2.c | 13 ++++
 drivers/media/platform/amphion/vpu_v4l2.h |  1 +
 4 files changed, 70 insertions(+), 80 deletions(-)

-- 
2.35.1

