Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB6F5113F9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 11:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbiD0JDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 05:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbiD0JDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 05:03:16 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2051.outbound.protection.outlook.com [40.107.22.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52ADCCC521;
        Wed, 27 Apr 2022 02:00:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3naTwyAqWLL+TdPveaG2+rooOoKymPkZx1HjQU/Pzu8PPtXb8XatVDE9w0tV+0JiCb4MHNE9FhLDZj6eHjamypY9v0E2gDMiYp3SMPQ8dCmPuMFVcZrfO3htFRYJCQiqwuP5AhpooaJqrkLAl2D2lkmRlWPlTguuYPmaWMgjVHG/GEi+v4cf4jxS48WNrVtmtPNEsoRcQCfbCuzuUBL5QnaJYxUOZDYi5D0MprQtd+jMGwP78915kne7lG8iRLPtjfuBRPxFaHNYwcX202rFqVebDhbDlAXZWlI6DcuJ6UWOasGAzjUzgTwQ1gXOz5ltruRDgExqgj5caW3qM7+RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubbCCIcAPd3Nnxk+w7wyfBdzvZkHXxXsz1AGw66Qndg=;
 b=m03HFrm+JPIz9zWgAspRehMwfkev1L1z1nZEyPas1oGoy8drevw7ntX/aTDrFw8aQZ4PbwnE88hR/AgmHQoLfmo1NOoFJ4zn2rLijE2m828jz+llSi3tbk/0Vo+HpJ0hovUe5n39lt+M68Np2Q7/fjdxAZCw8HgW8B9pquMfGqb8lGgpSEnL7VbysmX5G1UkuZa4mj3HdswMX8UUTIoMkkJ2UMCznDb+mFK/Mo5tu/sj/p+wj+mqyrNPKrJX5P95meQtxUTR4FuZyG8UhIfqLwAZ1JhmIRLXTDKpjtGN42MdKxR0spqSPyMTxw7J5156zomWkdov9tlEFwjA2MW2wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubbCCIcAPd3Nnxk+w7wyfBdzvZkHXxXsz1AGw66Qndg=;
 b=F0Asm6BjFZn3UKpK3FbglvYjffzUvCuSzXXjb7lhxgtr8nXOIaXCaCpmF/zFXvEUkVnT1V3xaYBDRqP8GZS5LU98LOhLhkBD86a1XYoTneyLvk0A53QpZslfVrNwWmVyeRn05n7d/NdIxPuSZm1Hb+fN0ayLvckVPVTj6eHQjgk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB3PR0402MB3786.eurprd04.prod.outlook.com (2603:10a6:8:e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Wed, 27 Apr
 2022 08:59:57 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::ed87:b085:802d:2390]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::ed87:b085:802d:2390%6]) with mapi id 15.20.5206.013; Wed, 27 Apr 2022
 08:59:57 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] media: amphion: ensure the buffer count is not less than min_buffer
Date:   Wed, 27 Apr 2022 16:59:42 +0800
Message-Id: <20220427085942.18159-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.36.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49babb03-e5bf-41d1-6919-08da282c4d55
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3786:EE_
X-Microsoft-Antispam-PRVS: <DB3PR0402MB37868B030D9673817252D213E7FA9@DB3PR0402MB3786.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vdq+ZZtaYuZStr2+vdxL3D5YzA/7XaOf1LPuiPD6ZQ+dSb2IP+SY0gqj8EatH3ZBKU43mxaZfSNxqu3fw98f/FHAldi9AveNw5T9Ngv6VrqztQZPOoDqRXCRtYFKlD0jkUeExd33ye5tGIpEBti5g/HO7tx7MGo+QAksLMBPRczBeY4+11PBTiPxRI0GDy4GZWp0YkJezxnwd8y1z3qZPllO/tjH5cL3abcFLhTZYcGa+17Wsh2Xupv0jSytf73bA+jAndtrK7mtfzf/OPJL8r6x0X5Ii4EhM7y23UT/jT5Llm9Ms311e4gJPWKce3PmExYeoZX+iOifQWpQ/7ayowbQ2J2aJsfCPEcG/0xP0ltnxX4/0GBDfnuhT4k+8wEl+ttt/VsH/rbEmjB9Ondsfkpn6mlF9u5sDp7v3RRYdlr71xOaaaLjVB5LdPFzarK631ZcuB1BLCpbQm0Efv/iQowzAUKiEk969olrl0MUoqeuGmfy+R/u2M7QzrNr5rGzrEOugXDpaz0KZss1vfy8QutVqtzmX/PhoVvmJAcyCq9gg//yWzEK12GwYAe0h94BxD12nLOXBFRLJRr059bUNrAxofk8vLwyDrYpEebvCr39UlfLyzyFTQTFeYjiJbMiHeGuvNz7zGWouB5L4pFxRk8B7Lbkfxf/nfwOnyAHP/EjTW4KWKKVFTSSWkXvEIxrVtwp4ZW7VRAr4S3QXfSCxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(6512007)(6506007)(6666004)(86362001)(83380400001)(2616005)(1076003)(186003)(7416002)(4744005)(44832011)(8936002)(66476007)(4326008)(66556008)(8676002)(38350700002)(2906002)(52116002)(5660300002)(38100700002)(66946007)(36756003)(6486002)(508600001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1MzNgUKwQuSOFKfBkoQHEMApGE4XcccS62C83/fW3iR1zO//venY8d8HkFXj?=
 =?us-ascii?Q?t/XivbwPrG5kM9STApzPW3KaI69ZxAAr3NvaO65AnKeaF0eoFWLT3oiRpK7z?=
 =?us-ascii?Q?FIytw2V0JIvXnQ7lQe+ZEbKiqZVtySDQa2RREvMKYgC3lsbVx/f1yvNgDQFW?=
 =?us-ascii?Q?JBBT43FOVybzvLNQGEEJe85w1Um7qOpbX9OUG9kOB1bKmLHMOyMiDREpLPf4?=
 =?us-ascii?Q?x+EULAzBjurM56dOiX8gZ4Ikx5P8HBo0G039YcsAM0fwij85SCzLs3WH/XUo?=
 =?us-ascii?Q?CV/aZGjvRWICY8V1EXGqASmW/yTU/H/cfebWhdgRy/zYNxC8xfm+DNKDkRH+?=
 =?us-ascii?Q?Vy/eFr87jlWP7IR5lVtkf3zaVT/DyAokYKRR1PdrwxsAP1JTpM2fq1kd51i9?=
 =?us-ascii?Q?pMWnGF/5f3swfGN+4Oj+WIe9ykf4g0mp3+8vnx92LDDBW1k2lL/zmR9inky/?=
 =?us-ascii?Q?BmPqQotGB+C/6LsPhpgsjAVAWWm7jExSJWjuBl0hxvqPVskVHUd/9hLMjcow?=
 =?us-ascii?Q?PHRwfvNyn4lcviDsKp3NgSOGgKU9OyRcr0oI7+uKt3N+NL4LP8TQ8TrpLORC?=
 =?us-ascii?Q?yalHMtYHPEKx3uGJTSBdtXCWamklJFmqzQaQqvc930AoYjgZlRUCyuolnrlz?=
 =?us-ascii?Q?6h0ahaWS5iHu0hcb85TN61LQSI2xMp271gw1KxsLkk7A0W8jc3T8yQ3xeO/6?=
 =?us-ascii?Q?riM7LbeRx4adDusDEUlKuyRpth40f+yZIL4VjjWSDrd1MLhuc3Fbk0kLkjLx?=
 =?us-ascii?Q?R4GhMHicrADEw44I0JsIBZ9knF1fRG7uhJt0vltKe6Ybksnw3AVPI3+BBb41?=
 =?us-ascii?Q?6A4glnm+5z19roDK5uK2gpvFuan6NHbiMfVuOn7H9cdM1YVWv0P98ZEneFf4?=
 =?us-ascii?Q?o30SAgdxFPwgPaRnUUXYSIQAr2F/8mLZcWTVdKTDVvNY1TnE7JfE+KV0deZ6?=
 =?us-ascii?Q?nqZnkcHaI8Chl8CvDheOI6/uUijrEIGyPedaX6CrxXeQsAyqtUZvoEkOJ/AC?=
 =?us-ascii?Q?xe50HQOF4ht8M1iLgqruoQrWcKzltPP0TFi2apySw/SPvjB4g/VE56LMBooZ?=
 =?us-ascii?Q?J8tVbn9VtMJXW3lQvOlumgH8HtwPFRbZgzRjnO/BB++s3mt1d662QPo8lrZi?=
 =?us-ascii?Q?LqlONYSNLuNiCzCs0cxCcZtZRuGkd3KI3HHk3JHNu5N4JliDJPR/rB2nC/4z?=
 =?us-ascii?Q?wDlgmtxKVJQgx+PAZKj8i7VTx0zCWwR2l8QV3D/GHd1/M7Y481D7X+LD6Z3d?=
 =?us-ascii?Q?6q6ZOmKnG72248/AFOloaKG1HzcQyGXAwGcu7uhhAJxyEbkm98uHmXS2lu5b?=
 =?us-ascii?Q?auuh4/AzFq8bpiw5TnFLXIIOlPGu9G6FCNNdgEMoSV6Bo2AdOVNPlhH2v9Ja?=
 =?us-ascii?Q?Zqx0AE1sBl7mtBeWtLXBdwr/z9GfNlcndG2paxmjXxQ71Ab7idmHU24/ED4B?=
 =?us-ascii?Q?RVW33jP1VdsAx6YFjodTxoPSAydrWA6Juluw33skg+RTOtNEe3SUbs9eM6ZV?=
 =?us-ascii?Q?6/wX5NJtRjwWYGhcgDpbMjYmDM/nPrlSbxJWVa7T1Pi5BM1CvZIZYJxrCdE9?=
 =?us-ascii?Q?wgZO47iQa8zgADwKw7SS/i0iswbdKJ+EcdMbd2MjwYdRywyvOsdOYG/Cb0L2?=
 =?us-ascii?Q?VmLpjRc4h8PyJjEfAo+85KJHbt17JzK2W5QmIBxJv1H48qBICUMK/DneQe3/?=
 =?us-ascii?Q?4TB4bQhhy13GzM23D/C9qGGFQQyBRYZ5EHdD9l7fpjGnStXXPrVxyJM86SiO?=
 =?us-ascii?Q?varZ8QApKA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49babb03-e5bf-41d1-6919-08da282c4d55
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 08:59:57.0586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pAviPkJZH05wwXlHIzGri1PE0hjkQOYIZ/2B4P4UVBXWaJRUGTLQNw6PI2wsa0QGSH0W4lS4ihwPTEwPCEvbMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3786
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the output buffer count should >= min_buffer_out
the capture buffer count should >= min_buffer_cap

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
v2
- don't mess up the VIDIOC_CREATE_BUFS ioctl

 drivers/media/platform/amphion/vpu_v4l2.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/amphion/vpu_v4l2.c b/drivers/media/platform/amphion/vpu_v4l2.c
index 9c0704cd5766..0d25ba3afbf6 100644
--- a/drivers/media/platform/amphion/vpu_v4l2.c
+++ b/drivers/media/platform/amphion/vpu_v4l2.c
@@ -340,8 +340,12 @@ static int vpu_vb2_queue_setup(struct vb2_queue *vq,
 				return -EINVAL;
 		}
 		return 0;
+	} else {
+		if (V4L2_TYPE_IS_OUTPUT(vq->type))
+			*buf_count = max_t(unsigned int, *buf_count, inst->min_buffer_out);
+		else
+			*buf_count = max_t(unsigned int, *buf_count, inst->min_buffer_cap);
 	}
-
 	*plane_count = cur_fmt->num_planes;
 	for (i = 0; i < cur_fmt->num_planes; i++)
 		psize[i] = cur_fmt->sizeimage[i];
-- 
2.36.0

