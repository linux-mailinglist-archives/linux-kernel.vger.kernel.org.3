Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4972754AA90
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354493AbiFNH1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353996AbiFNH1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:27:48 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2117.outbound.protection.outlook.com [40.107.215.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1452F652;
        Tue, 14 Jun 2022 00:27:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uej4dym1jBlGyOrJuBUA9zne8aEHm1Dc+aJiYPxZBpHeRIeZR+XH+FlBqyQFhX1e2eXVroQYVtIpoQtcP3GVBwXaBQhR+mepRSnOkwCTYP/b0ClwMOrk1toK3H284wzTAKdwGGHsvCzbUg+B3ZdYZwCaCLea5ZDZrlaPn2A4PRn+WqGwVMGW574L1JAdDY2HrMoZUSn6LOeHar+JLF0wqPwqvFCRLe2OEkC20XPzthFJLwvNBvvh+iDeyk2ZVe8Md92ndxBsmx57njQkeWfplqoM0yG5CUdAmDZrX8fFpJcOaw/J3g6D2dgZlqj8y8Rq8ZgjXBkB9iGsvOqu4kZ0dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rVn0I8IuRnjhtP5iqKJJ+F9WM77T22RA/nRLrh7B40w=;
 b=Et/rhwvg+Kn00yvfcXhYWZoEQs5yafr2PImxZPZhAiT7oe0fxNyYIMuxor208nRRyM8MkTbFWmuUus9teOo0EudgIxJCtaANZ4VKhC+8lcWaeQiXMLzPy/ekFisQ8DGicA4doymLFeqF+0YBPMNRRAdgjI13PooLrZcO1CvzcSisAKLkahaQVAKMfXK0d8pX343tzYcEcIi/jh8OppAHceZqbCN88tAfoUxWMuH+0Pb63sWm5YK10dw1oh5a1XccORkYzHUvGi3C2yp8po1eIHW7N+5WqB77IUF6l7S8R9Zs9ziqKCxwaFnAE4YYXMJx8Y8VFMhP0KTh4JfycaROBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVn0I8IuRnjhtP5iqKJJ+F9WM77T22RA/nRLrh7B40w=;
 b=GCRZlHxqZkeu70omtJ+SK8tP0KY2ju7SrRfRU6h9bJxlB9Y6IO38t5dYEG1lhbMPcxn+wB2X4Ix1/EaOgac7lOHiXnSrrqc+7zZWXwCAlxAeiTA9gWigQZXhndGP9tOYqfEC2luCOOSA16nYOh6wqcEWXP4larmgp+dwRm6Tjko=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PS2PR06MB3493.apcprd06.prod.outlook.com (2603:1096:300:63::20)
 by TY2PR06MB2685.apcprd06.prod.outlook.com (2603:1096:404:34::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Tue, 14 Jun
 2022 07:27:44 +0000
Received: from PS2PR06MB3493.apcprd06.prod.outlook.com
 ([fe80::9890:b96e:6c97:ccdf]) by PS2PR06MB3493.apcprd06.prod.outlook.com
 ([fe80::9890:b96e:6c97:ccdf%5]) with mapi id 15.20.5332.022; Tue, 14 Jun 2022
 07:27:44 +0000
From:   Guo Zhengkui <guozhengkui@vivo.com>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Haowen Bai <baihaowen@meizu.com>,
        George Sun <george.sun@mediatek.com>,
        Guo Zhengkui <guozhengkui@vivo.com>,
        linux-media@vger.kernel.org (open list:MEDIA INPUT INFRASTRUCTURE
        (V4L/DVB)), linux-kernel@vger.kernel.org (open list),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support)
Cc:     zhengkui_guo@outlook.com
Subject: [PATCH] media: mediatek: vcodec: fix minmax.cocci warning
Date:   Tue, 14 Jun 2022 15:25:59 +0800
Message-Id: <20220614072618.26925-1-guozhengkui@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0127.apcprd03.prod.outlook.com
 (2603:1096:4:91::31) To PS2PR06MB3493.apcprd06.prod.outlook.com
 (2603:1096:300:63::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9899e996-c90e-4096-9dcc-08da4dd75f33
X-MS-TrafficTypeDiagnostic: TY2PR06MB2685:EE_
X-Microsoft-Antispam-PRVS: <TY2PR06MB26855E7207946E918E4A084EC7AA9@TY2PR06MB2685.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mPi3okusCecG8WHgql43t3HSSuWeKX2b42Nhwf0HFEDisl7SHxuZY2xLGH5r0Yy5Gr1iEiXxdF1PAOF2BTd2t9U9KpazsXhOHAGYIHYPXt8xGbjNZw/6kGzlUsdvVUy2Btitgp/jzlJJnBN+bpRAZh4k7qRA8eOS3Bu0gjL4Cr6qB39aEIjijaFad7i/JjXa7YfeLq96SeO/ll63AHy4kZ0KsZo0n3ursa1noJ8tkYVeQ/Rjl1yn6fpcSkjTb3obLZR/g+4icEeTrHZk4A8UBVmhi6xIE3i/VSH1W9O7kcPHzNgE5SRK7B1Vhodk+AHIhCsa6M7Oj0lcJiB14PF4DdDNMX9MgAAKzqJDY4Lw3JoFWs1OkA1OsarjXiDIutPOGZJ5IfoM8Xqa/Kq4I5TgId/wjgT/gz8s5cofJ+1b/9hfu9j7+XIpQmx8dlYRiyxYtnx6DmNoe5F3sSorBfDnbHINNNWsGG/yUGKAuVIUmurkA+t1QQLCSupsUtrITLhIg/PTbmW7N3oCRMuEvAxb/D25XlE2m4D6ucpipnvgl6iRJJ3wXaJ9VoPsvrZYZTtZPVyuH0puRl60rfsQjuHSIvbwB/GMCTQcp9VhES39Ge2N/AmMunFA/c6UK4EHp8+oStFeH5QEF7QCRKfZCLgYdlyHKjJ+5Wj/1CsL3mFR9DmIBAqeyqUa7hMemAcGoaOr6fsVsFVO/Xvt8yRjlwMmNDuOnBUo6o+bJ9xFC13CEqX0y6W0qLmfHM1uwkWEWVSJLOiUeUvPqC8XRUwpX7o+yQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS2PR06MB3493.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(86362001)(110136005)(6512007)(921005)(6506007)(66946007)(52116002)(66556008)(66476007)(2906002)(6486002)(36756003)(508600001)(8936002)(38350700002)(6666004)(316002)(2616005)(83380400001)(8676002)(1076003)(4326008)(4744005)(7416002)(26005)(186003)(5660300002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LoqKnO/eTXjr2/SiH99ZGZ/Q0lsPSBja7z1+JFTCafVaJ6wQc8VwjgcK+aCy?=
 =?us-ascii?Q?+iSCZspqa55d7jbvF0UTzlaJbMQn43u4wjJCU+t3lhQZk6B34l8eg3GkNPLk?=
 =?us-ascii?Q?23Gl+BVQj9H8hll1FxRgPFURIM2+lVUVqUqUUDdf2ltca1jBosfooKJABIL9?=
 =?us-ascii?Q?oGQdeqvODQT9voGVT6qZArmhQLXIydOjhVq2o620RbjaJ3KbMiTkvK8Ewaah?=
 =?us-ascii?Q?9lRF0fYJY11m9+EXAIynvLZkBOyyW0+SwG5lFzv5biJBqhg+6KXq8q+C73kR?=
 =?us-ascii?Q?vBMm3OJgNuESUi8FpLdN4apqZNgFEpdtZw6MrUKhPDBcug1fVDV/YliNPeyq?=
 =?us-ascii?Q?1P5hTOkpZulJm+KjGc2U0fFgX+qvx9rqLAbmDs1vbpnMWTL0jOOmZMFpgjbi?=
 =?us-ascii?Q?ehImFTTp9D3LN9huTOVuECyXC8XeYim36tYGDhTs+XbPehNz/ISve9GZ3o0m?=
 =?us-ascii?Q?vOonbZpTaYgDy/4/7Zn7Xva98+B2kOhlNcUdaoycYJriGmXazzkA5/RcFnOa?=
 =?us-ascii?Q?Y1B8+lleoQ6H3ldrSQy+xNQO1hq4hyhf30fbuqJIO50+Yu7USRCeTM1JSZSV?=
 =?us-ascii?Q?qSepHD5Qdjpr4DnkJF0CsQ5ofnAnqLXLwGjCFiPaRtjoYjVA1Yq3BWatqe8q?=
 =?us-ascii?Q?jX2c/ugkSuRbrwjxCtvQVsnOOpAPHWtQ/mbLnNKtwe8964BD7E7/GDgdCPg3?=
 =?us-ascii?Q?mfv8Wgd358r+KngV2IUV4B0apIOGkc0khd8HnvG8y61+1XBzA3UKr2AgRTcT?=
 =?us-ascii?Q?NCqyt4X4I5QNyQEJiD8P3hcf8PA20Ypd/qNhJoNxVjN5YE3iHysPNnkUKwGB?=
 =?us-ascii?Q?sBbRit9CpHG0iToCwEW0GdBiTbhkTGeUvWP2R03GWm6jqN0vCokwn3+jIljn?=
 =?us-ascii?Q?aLPv6k/q6K7QBUDJ5yZnywVL65bAdfsaorJ2oDW2dfc10kSqdm2fZtjd/yjN?=
 =?us-ascii?Q?La2X8eH4YqYTs6Z5JfOS6U8EojPXXQ7xkQKngUiW7LIAYF2MuVILtME06Clf?=
 =?us-ascii?Q?X0zAty6sR24fiyKH0A1pPJkHRN00vQ9SNMmsDC8jM1e/R3uV1Ugcg3rPWjej?=
 =?us-ascii?Q?cGz5EVOc4YO7w2LT7QDENb7sCkPNZDP+BoQEveYkHr41HLGj6HxBZA98os85?=
 =?us-ascii?Q?2L+0W3V4uhQWd2NjsoLh2Uv+BasqjFuJvt03k/7QGFomRPgQ24yBGx2emY6h?=
 =?us-ascii?Q?hWg85SZyzzGmR4jfu84XhVXyBZupAIuhIy1UaLBN1U0BKqEeqNg+5mC3Y3Dc?=
 =?us-ascii?Q?wyk9VHhL2yHwVgEiirwda8MV28LnQZuwAoAvGJwTQmyzMhXKtpGEUz2ucyA1?=
 =?us-ascii?Q?py87uRvmPAc4+oPMyLaFB9dheEaRvvo2RU2vER1UgA3VdRJSC+bnBseBkmXK?=
 =?us-ascii?Q?k+3Xct+o3UASSddQYuAHpbWlw48BBvE2KwnTj7M6WfXQhBLMfJujLCY6W9n8?=
 =?us-ascii?Q?1xrFjbFfxli4fsSSwVW/hjx/bqJTuqc+zqKNMVJNnczJtJK6aAq00menwEeh?=
 =?us-ascii?Q?kRLW08xoKodh+CUfJjCI0bB2YgPJWIWtlc0YpzeE/BJBYQXKEe7GyZ9aRQvf?=
 =?us-ascii?Q?WmHOQR8lJhfIQTgw4wPSJDxkGpsQSBvaU2YVUJvRcDV6mJwlVaU13IHNREuw?=
 =?us-ascii?Q?M5qjPe8KM9GFMqQE9PFmvMpF7B3vJakykL8ngwQvOECItq19Ag30ohSh6Mvs?=
 =?us-ascii?Q?Q6Qr4+cA7S7gXZSzEq/UcNYUXDJyadDM6ZHokLJCKgghgOq6/tk3Cm4kL0n5?=
 =?us-ascii?Q?mZ0veZLLXA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9899e996-c90e-4096-9dcc-08da4dd75f33
X-MS-Exchange-CrossTenant-AuthSource: PS2PR06MB3493.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 07:27:43.9996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SIU3Pm0XV1FhZSDEPpPhRHXn+kRG0NKQW2kA1fi4nacQdnNESFk2ubTKdDvVY85pnD/mtRjuh4ENgSje+Lvcxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR06MB2685
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c:
694:15-16: WARNING opportunity for min().

Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
---
 .../media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c   | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
index f464af190d8c..81de876d5126 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
@@ -691,7 +691,7 @@ static int vdec_vp9_slice_tile_offset(int idx, int mi_num, int tile_log2)
 	int sbs = (mi_num + 7) >> 3;
 	int offset = ((idx * sbs) >> tile_log2) << 3;
 
-	return offset < mi_num ? offset : mi_num;
+	return min(offset, mi_num);
 }
 
 static
-- 
2.20.1

