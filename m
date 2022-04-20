Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37491508722
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 13:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244785AbiDTLia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 07:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234663AbiDTLi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 07:38:26 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130085.outbound.protection.outlook.com [40.107.13.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC75A15A28;
        Wed, 20 Apr 2022 04:35:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VH3+DoOND4XBX/hBjskImz3t9rswCKP+rBDI40QVHn4is4SZe0JLbJU2mW4sGGfKrGNTYVDywaWcKgtD9jvnFPGwds2eH1N881ojz6e82tDEjcefvVIuB9SeWtEQu573omxvjD9LmduiCLwejbxwQJUAsOkx2aLc/Wzvi3MTjlVUmh2nv3UT7VochPxmLay63datCmw3itASBC+UwEXBhjwqWPcDXWs0BMmZRlBgSQnekmA2CEM8wMt5L4bcyodoKJ2eJpzBfkurqEB+IT3q/nWIcQ0Io+k6Bai/QH+X3KNlmyASIYiu7pvUjjT2DJTzs+zXBZyHlaQP1TF6kG+iKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+I9FEztKWd4Bwr+DteqvAJpkrWIAnN6WtfEbArW0aI=;
 b=f9By44c6py18v2BasvOClioVN50zexg6ie19gFx7JqKgE2F/f3oO9qzEeRIuDlKcDd7wY8LN9fQaB2tL8fhnUr1gYezoC5btAA+zFn9nZvPk8A8T4pAodcR611emgk1Ks/YbQV8tTjNvqFxztobMO8a+BgpZ6y60aLPAlqjlGx5DKIpZbHv6Uoqe0h7LOpcKio90QyUEgtDxlD3Xvf15G9QYTYZ8uUQbBu4AhwkaJy6hoL2iSgbsrtYQUUp9NmAB8iwn6uHSrgZadZHBFz6PFXSTqTbZ4XEEMPS7nLzviE9NviKvjYrpdUIQGvPhMaax2S789gG3B4TrplJDpbF4Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+I9FEztKWd4Bwr+DteqvAJpkrWIAnN6WtfEbArW0aI=;
 b=VpJHxJ39LghWcAtXdGSA2eEqQ5BC0aLn0QzhdHdajX91GjLFlSU452mpma++GI6x9z1tlLL/t+BiOT6A5chAWmyPdBnT/mL/qEvIFYda6OQhRv8ovWkgdZv0ORTtTgWGXUKSiy0e1Dt66eAurHn+ZUxvEqDPIHE/IChxfST8BxQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by VI1PR04MB5376.eurprd04.prod.outlook.com (2603:10a6:803:cd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Wed, 20 Apr
 2022 11:35:34 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::d8b5:5914:5189:ffa5]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::d8b5:5914:5189:ffa5%6]) with mapi id 15.20.5186.014; Wed, 20 Apr 2022
 11:35:34 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org
Cc:     hverkuil-cisco@xs4all.nl, robh+dt@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/2] media: amphion: copy timestamp from output to
Date:   Wed, 20 Apr 2022 19:34:52 +0800
Message-Id: <cover.1650453924.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0029.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::8) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 833b259f-148d-4c99-7f15-08da22c1e20c
X-MS-TrafficTypeDiagnostic: VI1PR04MB5376:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB5376CDBC8A7D12C25022BA5AE7F59@VI1PR04MB5376.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UOuuwn1p/7doBjef5FV9FNscYg3rY/ZuRGJyK3BeDy9vYZt67YqpdtyFSGyaaMaS12kLRGp3ZqitMo8JtPFF1aZwxOgF8GtatKS5O8KLxKKmWB5/cHWNREhuy58v4ztn4/Aa43SuQCxIj6wVtefUxZM+EVQ9YjLhG2Mm5xt7CM2/6PKe2GRhjoF4SCdU/mhPhWhYIw6l+SvaIcJeL8vHxFrCmtZUsqcA0l5TQ5nyFYQbHL/YQpyZBsz0E7Aa/ef2w5CAX8MtgGZj7R813p7KqE6ZrxTH/bOVauRov5yX/iLJPw9z9wAzAcMFBdMWrzac5zLVsh2pLLZKtUd3OEkSjXewz097G5EJItJHXR/G3pC/b4CfB6ql43gWaqqHBTjuT24ULj9FVJoVPhX45drwg+eK3OXvVoKZm48vfAeRwAEJXT+sCFpYZYzvU62mD/ldNeZx3pnzCDL5R8//4b+w/LKCuTT29loFWniZ8CPTNY06RRpMXKeDcLzYS55fnRRoqInTWXewuWA9MRkXAlXEqKEYDGniR8aX7oNrjz5meK+jbGeElWF9sw4gauXn2/pAcqVH1L5hrFgeTMHPGTSzmnqVqf9Dfqs4RZ58qEMilAyExtM3fTw4UjGjM17kXH3AnQib8bukYtLjTPREn5Agc9WcLkqzc1Ty3ilBTFnUobjfx8gNDB9h5ToUvzppm5S6tkZ1hA8RZu0cfilrOhaRUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52116002)(6506007)(6486002)(508600001)(86362001)(2906002)(6666004)(38350700002)(38100700002)(316002)(26005)(186003)(2616005)(36756003)(7416002)(5660300002)(66946007)(8676002)(4326008)(83380400001)(44832011)(66556008)(8936002)(6512007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oSc58la1Ii3OPrag4NjSRTVQWLZeGYU3C4AkBUAmVQ8VobTpFsCux+0HEiSv?=
 =?us-ascii?Q?OX4ogTcZYmGPIWWJPPlqOIBStvYY12CDsdGUvTP+4gyG5FAQPWBgaMm/k1fh?=
 =?us-ascii?Q?MDD06J1wmMOJiBy/Hgwak79iz4i2/b+UVsWov40PrSA6KO07pYxkhJgrK0FE?=
 =?us-ascii?Q?l5aAcH9jn1P1uRp8wzZlMAZKP6KDxdmO+weI5pdxEbXH9Re6xkzynAwtBVnH?=
 =?us-ascii?Q?hh8Td6nxojqNefU6DGIYQ7xNwcb33IMn0ePaPoq7w8XOjHItJ5ZxJwcdQItD?=
 =?us-ascii?Q?EyarDGluHcWXIA+k1RJL89UJB8+zmCsD3SJ3wdp9MPe8QltfYc1vIe+gOFPB?=
 =?us-ascii?Q?804lvxIafYG0nVZ5NAEOCOerIlFw12YQwjOEa67mmp2lnwp7KuKr2qXsCkfx?=
 =?us-ascii?Q?FziWSi+RkYj61XSKNAz3PkbaQ80wUNBRnGUybrAmKfeH5UDx9wET41/UL8L7?=
 =?us-ascii?Q?Zg+3pTtXDLv8rzzaRFmUmgyekM9eB7xW/+L+BWQKaeIsSZDodcjDM6sDdFu6?=
 =?us-ascii?Q?D2GoZkA4TPBi/JvhcoQcPgx3ephoyAGCvpua/Vt/mTsVV/0HV+qB+Fpa1+Ix?=
 =?us-ascii?Q?Xpse7EAiaAGL4uY4vVtC9mLhH9A3uUaOaPT2lBiBFhmiD86Tsak3j/8V3loV?=
 =?us-ascii?Q?6M4HYef2k8YMOhupJ5ZiJMZIO87rrRq17hwBR8YbxofNuwjJWkqXvU4vsyIl?=
 =?us-ascii?Q?1h390kFXAI52iNnp4syp0GzWdNWMPu355QuVHT9l5J+uEM14WJ24TKKWMJX8?=
 =?us-ascii?Q?liggk1fL9Du0pGs4WaCzfGuoTo+Mim89lkq84pxO+X+r+IWumgsX58nrpZRb?=
 =?us-ascii?Q?J55EosFqNGbvweN09QEBiJ6sopKqKWRVR0K5WH6bBiha/vkGlvFPnLcMQv5C?=
 =?us-ascii?Q?maeYFCe9CMEroGY2qTZN22Qw9pD8gVpP4T3jTLiWiaim02SjQCsgl+zUhoRJ?=
 =?us-ascii?Q?EnZlwmleB8y1yXcGM3ZHIAy8+ccCw9ofnatHsc2N312lLJ7XKrol0NbvTBSf?=
 =?us-ascii?Q?QABV4w0wFabfcBwdu7zZzs2Ja4jcCnlKiiGWsPA38fzYY6prOIB5adG8j1yW?=
 =?us-ascii?Q?shEoMctJQ5Fah0TefYpZMjenwpdhtyF3HCP31ZyGBqveHf4ED3qZJEOWRjYE?=
 =?us-ascii?Q?vt5Fu2UZ4VdhHvZDJ3pf6zYgOFrrVsn/vM/QtGvEpxlW+m8mYP0D2gzBaXxm?=
 =?us-ascii?Q?Nc4ZFbgacqUrFx/WGrCTFjeue+9iAlK8LKQZdDLeFxWRg5vx8MxVFAFY4VWf?=
 =?us-ascii?Q?W54JOnpqV1ySNwH4RkoanI9yOepmnXElU7SU3jMWpEZkReFIALX5wos4kh/1?=
 =?us-ascii?Q?qTPTgslegiaOd66NGXdu9s41KbBX/PGuuckBiydin7n/RGOoxVM73A1Gt6Xp?=
 =?us-ascii?Q?xGbjdyLg/LKgwQnDa6yhOQjN2D54JGSN5K8ABdBQEMFB9eVic2aYBu8eN+Dq?=
 =?us-ascii?Q?0XFlc7WGglT7NYtZ4rEeadQPwdDOgGcXqx3SSoTVWfemFFLhGsA8czQaWobo?=
 =?us-ascii?Q?8r6GVg7rZEyDAAVsqO+On9EGSvL7ef4m+m4KnL7zrCw/KR0imh4Ktm7G7zxO?=
 =?us-ascii?Q?AUNA+ZVv3U108HqDtkYpVGzaIOQCpgk7CC41lLyGHWDouw0+HRx61P3cQYq5?=
 =?us-ascii?Q?eJ3ZGLzD41/NgjgDB4EbEUGDPG48kF1JL3x8PKGeygEodQc+kPflTO1RxyxB?=
 =?us-ascii?Q?ODqFGhwx5YhdxEuzQ1JYRGMgLQtrykIfHn7wgoH2MVYk1gjFdhMRavQkWcc8?=
 =?us-ascii?Q?0Cu5Y++b3w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 833b259f-148d-4c99-7f15-08da22c1e20c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 11:35:34.4567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T4gMFZRu1ruBNCfN3T2gTJ4jdWD/GEN9tp/X4NPFyz6CW1Mu1w83jJTeH7DKqezkJKFp4Jf1r1Ga+SiXw21YnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5376
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3
- add helper function vpu_skip_frame() and vpu_next_src_buf()

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

 drivers/media/platform/amphion/vdec.c       | 76 ++++++++-------------
 drivers/media/platform/amphion/venc.c       | 47 +++++--------
 drivers/media/platform/amphion/vpu_malone.c |  2 +-
 drivers/media/platform/amphion/vpu_v4l2.c   | 56 +++++++++++++++
 drivers/media/platform/amphion/vpu_v4l2.h   |  3 +
 5 files changed, 103 insertions(+), 81 deletions(-)

-- 
2.35.1

