Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374BD4AECDE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 09:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242974AbiBIIlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 03:41:22 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242774AbiBIIlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 03:41:04 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2070b.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::70b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D97C094CA8;
        Wed,  9 Feb 2022 00:41:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJF/vLZaYNXCnJ4QYsD6F2P9OrtScq2St+ONPecjGzVWv4rxQQRmEPHXWfp+phfpNGtXGaMjfBd6dIfnBU9SgBZR7uwgfHO8egijlXXKVg/09f7CyWnIfIvbrXFOfz1JClQ53Bm1Y5/9cGA+OJqRGytTgUrxY3VthHv9zua9OvgYW/ZPmiOG1CGzrHTMXqJXyn50kq30u/R078qzHcXo7a2JcmrhLXo/KIhWy0VsWv/LBaX9hvNAnKihW1Xhg3AV1fjJWYDgHFmfqV63FwugvEg4Kxr+9z80wUUv3HDfA3TUVfND7J5b9ThpfR64lNGr80W6TpxOOaCXBwgn2qDReQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ef8wGdZsIBk+o3idi35TNPNDxY687FuRHDwMgz52sW8=;
 b=btTIO8sexQJKyPisH+RKDXrJexzmopusMHSG9GZR7Nq1VOCLHyvgXaN7loL0Lu6uTzhqQiTC3vN3QAXEC15+O4TxqatXnxzRInJbwYMWRtIC+yxd/sQUknOtGvYFzxXyxVN+n4O6E9e3rEsitmdW3EiIKrZQGKL+oFCemn06FrGrnVcLYhhljsr9xiqiJGiZCndepu0BEd2wjG5NgL1p0MhmGjztzrzPkSvT6oKnpy0IFDgch1KI4zNnqZbtdcjmTxsqaVwPrcPR7lCvRJx5ruFg3EGn6wQ8cw+fkqHOTGP3Pe8o0F+OWTVM+pB2d0J4udXay+Mcr/C5+Mrp7LnQlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ef8wGdZsIBk+o3idi35TNPNDxY687FuRHDwMgz52sW8=;
 b=RrLYjhB6JNUh/1PNtJ4F/9FvbqEQADu4txDh/u8GbI0bphk5by4akbdlPnQuPwCJBhwel28vj0tIMO5/FwRgL9h+syeG45REHs/AaD0GDOrMJfxHuA2neqzVK9ShG56PAUr1SJfvuGc5o7ClqyrbA3aGekvwjA2xlbyCUQhETrc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by PS2PR06MB3559.apcprd06.prod.outlook.com (2603:1096:300:6b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 08:38:41 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb%4]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 08:38:41 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] media: qcom: use div64_u64() instead of do_div()
Date:   Wed,  9 Feb 2022 00:38:33 -0800
Message-Id: <1644395913-4091-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::29)
 To SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 864a3aa0-85ea-4e02-2298-08d9eba79321
X-MS-TrafficTypeDiagnostic: PS2PR06MB3559:EE_
X-Microsoft-Antispam-PRVS: <PS2PR06MB3559A6CA98E11CC4FEFDE8DFBD2E9@PS2PR06MB3559.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I8O7O7+XMHO3t0yO2EUCPzLk6ASUhY84TZOS71GchdDm/RDkQFd7WGPypIngEcsvBYpwhZSjh5dXfwZSXHQu8MpxaYR989mnAGUQq7lc+bYPsaPX1L8Gtlw8JOC2+2JeFJZmp7U4VvZ7K+0aWQPPukgLZ4Jq66F4o85HJAUoqxgnA9K0kwVD4FtUdJuFy6SR/qCtGf0Bijf0NxH8Yd0G2cPv1+po/v0fnYqISFjl7V8KYC4xzXRRieCDvoEv3PPetrcvTMkoZYWFix4NrzU6P7FYnkO8A4wGxMtMIotq049yycyEtjI8G+8v0yPbK4OvgZJQSh32cUaPtQXqcR2N9L+FHmWj4w6Y3Nt6WtpZMQ3Sw6KVvucabwot4P1BBcUP4EfPAtKUOeXUl9W5bBNk0X9fVQx8R54t5ULcTWHfX+tbl+SJli8ZYWTpDS3/msFec/rrPvpdaw8lCD00tICuCPeJF97DeKzKvlo3ccrKbDMLzM2mSo6HLVYjuTilTVkOotcYWMhssaVC3XvyNd6+gGAgNhe8RgZQS6e2VWDIdKZwcKYj7i2TZJz3Y+OSyC9FxZb6GqJe3SyzHi/x/uKZ0lN3OCNO3jIvJFcKWaanO1EuHpiyUQA+u7GtEHXk6IhbfNSZne2kaCcvwwmiDYiByXkWooBemMVd4WV/+/jqJX2+yOs8RglZwU7DVo+qmMK8Pz0Yag+ZFA+ibc+PgShp5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(8676002)(4326008)(66946007)(66556008)(66476007)(186003)(26005)(6486002)(107886003)(6512007)(38350700002)(6666004)(86362001)(6506007)(38100700002)(316002)(110136005)(8936002)(52116002)(4744005)(508600001)(36756003)(2906002)(83380400001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Eq+vJ0TS0LXlrtABhxQ4oOvbqFy14X2KdSn2idbc3ESY4BL9VZzGpVh4GTrD?=
 =?us-ascii?Q?zw46hVpmrvSLaarVwJLxjFG+PjB/VvHSjlCVbpg9/DR6j72mmupuq16bVRt/?=
 =?us-ascii?Q?U53kaypuVW0G6cm/ZQEPcpfdEUlui2fc4t2dsApdWmOzPfL9R0mPlIwBvybc?=
 =?us-ascii?Q?9S3jZPv7SyNL4zkPKSrEtJad6FaKdHqzIiKtOqIPIHPSsHAAszrdbP7Add2A?=
 =?us-ascii?Q?rVqrajHqS63bNc+7uKFGHXIgHY8rJSVLJB9e2cpyxNr1Mx2tHBC6KUEuNNVE?=
 =?us-ascii?Q?vuxG/U4NEzZYbHsQsYCCZHVusYV4hMTcZ4dZIYmuOz/4h7XcMT8OOTfucLar?=
 =?us-ascii?Q?IOtdsZGvx8rPCZC+Rpr1D8XM+yGdCPr7YSkyk0dukw1cd4gn6w50652b7epQ?=
 =?us-ascii?Q?GrWt0o7bbnFQb4nk6Zc19pF1t9g+RxD+ofyEUcDkYkFZZVOGNedZz2G6u6kE?=
 =?us-ascii?Q?4Vzx4g2vOoQgFM3ZHkxppysE9ko+1nMAuyaLNZYu5Pi5RTxpZu5vN/jNZbWy?=
 =?us-ascii?Q?I4uyIhCIF7EiSe88IsYiYax/qW+OwOzrAKdKX+Hrt9FTkGtyI94RsRUAraBV?=
 =?us-ascii?Q?X64cABRSKKAh7Hdwor5NqgrWZt2Bm/6rLnT/ABW1mL/sqOTUGHQSprtQyMxy?=
 =?us-ascii?Q?nG/iAiMp5Hc5PtojtxrIsYuBoo7Snv6nOua/fw85pstGoZZ2dLKay84RBDXT?=
 =?us-ascii?Q?6xdWfwA9XxLVF3Z+7eV5L7Uuo4rzrZBw52+Ng0FnwaNAk2gu1jJZFaDR6Joi?=
 =?us-ascii?Q?oI+MLCebqPs+Zh4tkf0bEllH6//CXcFkQDExtRf6oEaS5EoZf5h34n/UMB7j?=
 =?us-ascii?Q?9xa86vCZNiLMmZo9wVj6vTDz/jbuf/4yAmLQa7B9rUlLFTYgAacCLzxKn3iJ?=
 =?us-ascii?Q?nEQ5HKk9xJRjv3npLh0ibXnjB69c3txlebRlzH895rylRzAasHJw/JwvcaBp?=
 =?us-ascii?Q?iVnevgrXyraTP0xnIbi8T477AxZa0yGKIF79qZhCr6cmWZFt6QuXMHGO+IAI?=
 =?us-ascii?Q?DpNlyDi0RSRYnkctVB5XfOpaaYDMRwe3oKik98f7zD9iFQesJTEgNmVTURPu?=
 =?us-ascii?Q?Y458D0M8RTPYkatXInZ/MKVZ5FheGz+S3J5QZK/NcQasTNxpDk/nven09wJm?=
 =?us-ascii?Q?UJJGMnqw4dJtjCXaVDf2jhKC2ZBF9cTzJbTGPxqONJJ+/cnD7vk4ruBkjPre?=
 =?us-ascii?Q?mzqm4Rhd9ptYfsoQGWItX2jckdL9pbUmrEh4MInNCKl2uvw9hdkBXelx9y5V?=
 =?us-ascii?Q?33QdJPdSKUh6Rch3/PCgpbal+tOpUr9QvNHxVDH/9jj/OX32pTwbf2UVMvs/?=
 =?us-ascii?Q?b2yJseYk86sW0NTzvlXvIWN90FiYYXpz9gXaUnwPHzsXdpTM8vGK5Z5o8CS1?=
 =?us-ascii?Q?+WH/JPtv7bD1X2q/DKRBAwLgjs7BvbKkx8Og8+EMPOo38gbI0iXT/AM7RiVD?=
 =?us-ascii?Q?2I6YAtQ+p43c82t8Kt4enF4Bv2HZvNt7JMFbgom84mZNpB263bQnCa11onr+?=
 =?us-ascii?Q?FpqNcIblu5WEOZhjlzVC2Vo2/HGDkhhf/5ba63vn5JpaMQRKim6lDrawy5vI?=
 =?us-ascii?Q?m05oHD4wTH5toXI43dFuB6FMmIaAulKIZBN0PS5xIC/PadpRDPJubdR3xyWS?=
 =?us-ascii?Q?YcseIPdGEslW+xFzFX41TEA=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 864a3aa0-85ea-4e02-2298-08d9eba79321
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 08:38:41.1998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dlffmw/HPr7FuEgmK+1B0AcAuQQlV28g1hNxUedtkY2CagCop4cowcwNypgWdfmgdxcqp7LHOfalm6AfBsJT+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS2PR06MB3559
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

do_div() does a 64-by-32 division.
When the divisor is u64, do_div() truncates it to 32 bits, this means it
can test non-zero and be truncated to zero for division.

fix do_div.cocci warning:
do_div() does a 64-by-32 division, please consider using div64_u64 instead.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/media/platform/qcom/venus/vdec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 91da3f5..941a904
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -435,7 +435,7 @@ static int vdec_s_parm(struct file *file, void *fh, struct v4l2_streamparm *a)
 		return -EINVAL;
 
 	fps = (u64)USEC_PER_SEC;
-	do_div(fps, us_per_frame);
+	div64_u64(fps, us_per_frame);
 
 	inst->fps = fps;
 	inst->timeperframe = *timeperframe;
-- 
2.7.4

