Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12E34ED956
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 14:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235779AbiCaMKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 08:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235801AbiCaMJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:09:59 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2114.outbound.protection.outlook.com [40.107.215.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32691FF21A
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 05:08:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFh9RFZxMm5aW2ql1zb9PNmHly7UOasBjmjTQOt6JRt/t5i7UzMVcD7daPxR7b+DDvNXYqkGnPpD3rf2Mh2+rM/BFNuGGb7AyiMPkixN4kx4fnJwH+8kh7g/KWD+ih9OmnlYPfkiW+2KnQd4hepqVHrxyD9u5ydU40gXhG7JETslqDr3RnnU3JVsXtW6AP2bxVmZ2iaHJZ4fv0gz08+D3cuXSZtqAWr7ZYRmhdAY2DgkFYamgCV0QYLV/dv/Fwt6N/Mac2B25jsN1lybk6/oUSS24mk2RMUyYkpmDPlKrcQcZzzB9OpT2XqeMSU421tNgNU0s+8GvETbfNM+11hYmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzj06jA/gkpHKuNdlg0X94IjAyyHF2qab5SIQ1CDBSE=;
 b=MNOF9zsovERG9IFO/DUdHvHk6TSypmYS7GuE1hwg4VHLes6shxJ7wMTH90H2l1K/GRA9e8cH5XsizlSoisDu281VN7z3Jre6VifQ7qTP9/ZFJqwCJCFVeeWIhKJlKXH+XzLb8xGSPT3b7T1dWubADKyH5c5w2Qm8Pz2raKbOx10OzVDSoq45OT8UIQJ+lkN8Qiag54DVMCDXwMCanVlCs33t58uotYM4TDTlJ9i+ly0TeyIPtVD06Y+ofoo988r6PK19muDbgyD81o8gZaKtZ0lqMY74IL24N5osJXZFTDGgPaCElT0v4Mi3e9Yd9OOUJMgVvpaD+nZxjMO5mvxyNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzj06jA/gkpHKuNdlg0X94IjAyyHF2qab5SIQ1CDBSE=;
 b=HOaunyCZ7iSyRTjO+QhuYKAcvt4oa43CB3OLUxL5YHCHbNJV8bo1zDJOBd2pukeF1CgFiXwUcSZoqfbKTHb3fvI407TlUVY/+yhH9Q3buUUz2HxLYdcBdWFfNjWJwEjLsjJJqG59tyjLGSIp50JsDAdG0mZjq3gtYnfGcZPOJRE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SI2PR06MB3882.apcprd06.prod.outlook.com (2603:1096:4:ea::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.23; Thu, 31 Mar
 2022 12:08:04 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::6c6e:d8af:2d3c:3507]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::6c6e:d8af:2d3c:3507%7]) with mapi id 15.20.5123.021; Thu, 31 Mar 2022
 12:08:04 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] hsi: clients: remove duplicate assignment
Date:   Thu, 31 Mar 2022 05:07:38 -0700
Message-Id: <1648728460-37288-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:203:d0::19) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2eebd71d-f3ff-4d6d-2d17-08da130f1c16
X-MS-TrafficTypeDiagnostic: SI2PR06MB3882:EE_
X-Microsoft-Antispam-PRVS: <SI2PR06MB388226E8B3776B2269F31DE1BDE19@SI2PR06MB3882.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G1spuxGPuncFPhUWox01SOUNL1XsP9rOqrlFGlBtvpB/3lgrLH3O/CcM4gZHvp3tiekgdLrTHrHqcUnSV5gtvx3C88brgyBrxZHIzXEyvodkf/2QM4KytjpPP/gC5OlQj73C8WGv+5D0zo9E/hF0i07BhWYfy20d228PZTIoxLmyunDzwQG5AiNp7nyle14bBcd4IMj1jsPghHEHgCcgl7dr3ADdnyoTDKU/KXbFlELQSsEXYBiOpwedroJUWjEoTj/Ee+1udDplf3rY6uRjnGZIVF47KoNNjAXcaTISUcPPHzxQdOihuxvqda+r8UdYZ+DENtey+2E0pZ8Om0hDzCWYppQ178GK2ORNJfUUi+64zwlizftISMxUBbQPTwhIlygrmCkX8Z37g/xdTiSXUcI9GeB/UfsjarEDBITCZgIR9By6f9/T2giQQiJaRSh7vGPC9tqOwu1BbCWP3tWYlhw1zGL6aomjovPChowKOkFuwL5xakPp5QOzBKIK7Q12YmikYub5KUSJTcZCm+Gi3aRgQJRWQoo/Y/f9otVYOHH/xGdvtBzS2/tTPbpnz/eY6g73J2HnGsVOzNXRgqL3GRQbPZhGmWT+nCM2nCORx3ekUjHsz10GqTF8WmaqfZSqIdGCpIfZQx1330ZZgC6B04t9On2G4o7AaP1Q0DmyVr2ezk7kzkDn4VC8fyiKJhHA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38350700002)(38100700002)(86362001)(316002)(8936002)(4326008)(66946007)(66556008)(66476007)(8676002)(107886003)(2616005)(26005)(186003)(83380400001)(6666004)(508600001)(6486002)(6512007)(52116002)(6506007)(36756003)(4744005)(2906002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mOXsUEs/nagumGqiRCx7UiDUmwF8PMTkfLeVQbgZCyp3OnRuO6LIuGeO7M3k?=
 =?us-ascii?Q?GJ4W3kBPxWGVEHBJL0rDho9fvC3uj75rb08irfwnNgD+6+csWv4GgDTSeSC1?=
 =?us-ascii?Q?RnTLpd9hoGyqbavLJT0/X1L98WNki2PgrubbZv+Vn0t3yUUHLx28SYOz8KfJ?=
 =?us-ascii?Q?bW/7fEF4hNETuxb4RaUlQ/MdzOGzlaxHgYV1HfIt9ySgahGvledAHIEZjgrt?=
 =?us-ascii?Q?R1d3pfncX6V2Fq5dL9i9gD1IM8R6eh8v5t1APX34UeAjah+VeMvTNL9/imDK?=
 =?us-ascii?Q?f4QhR0ciywMGowrrQZxZ7hBebIdXHjLGcIj/lAX3f47GEjzV26f39dDDdRgG?=
 =?us-ascii?Q?Ca982Du5/bMWzLly4bI1GXuwb9GrMA0rXqRv5GiRDy3Gr+eQqKJ0jORcPLw/?=
 =?us-ascii?Q?dBMX4//YqcdK3d0xvDk7N5UIwwL40Qr1ea7GoiV2RVd6G1r76zKPOPmh2Fsa?=
 =?us-ascii?Q?7BbumX6RxWAvUygj9vnVGAR8i6lGUJSrqD5yc7UCsf50XHJmJUfi6d+zOgax?=
 =?us-ascii?Q?l9oMoFTn/2dznO0S61H+7/65BcPpnOgwSI9PAd7proT0A1/JlqvAtvQ6Yjp8?=
 =?us-ascii?Q?HU7tmDmt1pofBPwyDrR80Yg9zKBsPWEytHueCI7+xcP/Hxc+ZIY/21oQyhD4?=
 =?us-ascii?Q?Hkj/jhyh3Syi0WOHkzKt/caiECRvYiPNWtVkG3jhzpHMVF1fhg7U3flZbQrJ?=
 =?us-ascii?Q?X24fAXB1yMDfufzyFoHcNoudKEYFU2fX2PZAxbRyK0HF+TSROQfdq9D/fnhx?=
 =?us-ascii?Q?0nShtDa8Kl8SBkzuGcwAvyou0K2iGL/kU3H+uzuXW2h1Ie2YKuaBYdj4Ajqf?=
 =?us-ascii?Q?uGtfVMDB5SwegQHgwJqh5d8k3yN/s5o5AVTyXCeXeBbXN6HZuDmPoAkaeyvk?=
 =?us-ascii?Q?h00wfsFVExfWh2xatRm6q+hSlSpdqns4zdXlNTKdQWBv7ECE8BKoJ8bn8Oz8?=
 =?us-ascii?Q?NeQwyYsNTaxyg33GCKGsWHL+gsYRpbMeD8aYAj+8sXE2RstLB1obCFk44sY4?=
 =?us-ascii?Q?iPuDRep8z077yVyVLOLI+l8xTFqilJtDPYCULtr8Dt6aGjXdly+vnfkT0Exe?=
 =?us-ascii?Q?a6SsSRFp9OE4XbpK2+3v3JX/NpFDfBCX6w2xIiwLPe0FlB7LMscIeD15UVeK?=
 =?us-ascii?Q?Y2Dq3RAcEANkXH99sT0dMBZH/pEv08JOZDus45G7ZWeKXec8c+tMQtXUmNKY?=
 =?us-ascii?Q?gZhvHhdLivwtpWIC2dFq8smxHNhyv/5cD8fI7ag833Wd+O8vt2QzTcyWRKh0?=
 =?us-ascii?Q?e3tLo4MuXKQoHW9gPIwPi1YxPxqKArxiUqDMGpZok5V4KHo+tp+D5iR2c3UY?=
 =?us-ascii?Q?4Qw/MdYrhBcimhQCPdBCmuitS2f+Ycmd8SZO3ZeQ30cN4Txri5brLByFRM40?=
 =?us-ascii?Q?ey5hr7535XZxzNb0Lh4zm2heF4a77rLphMwgPTQlMv3Z0gnutKL6WD0OxjRO?=
 =?us-ascii?Q?nrOh9ST0Kh2HTgWZWyFSh94J7YO/puNlDI4I0UpaHsRj37BZ+bVvWDA24/q6?=
 =?us-ascii?Q?G1vxeiMV7/5T2MTQS6OkN9o2cba4npVQv/wf89F4VQLnzb9znu/qGyCr6HXL?=
 =?us-ascii?Q?ddCjcuyyhUoTYZfM1+pAR1hpDaY9bmqOy1Kk1g6ausE2IH+r6W/SrZ+7OroK?=
 =?us-ascii?Q?gXGhmCXwECcilgyujPbMp1oYQpCJSloq5zHLn1owfH3gYicdd7j8X5j+1vWk?=
 =?us-ascii?Q?g5HP5G8VCcfWSBVWm9oL5rIkORIrm9kbtuawA+MJ/DFA/NZvHiACqjMKvk6R?=
 =?us-ascii?Q?XxPSDAYLvw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eebd71d-f3ff-4d6d-2d17-08da130f1c16
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 12:08:04.5342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gihIdY1vN2YVudx1G2Jl9TmW4TSfR1DSJi+buqc2DqNCheTqqNj3hegwLqv1YZ8XDcnHaBRmcJbHujyMreg8Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB3882
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

netdev_alloc_skb() has assigned ssi->netdev to skb->dev if successed,
no need to repeat assignment.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/hsi/clients/ssi_protocol.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hsi/clients/ssi_protocol.c b/drivers/hsi/clients/ssi_protocol.c
index 21f11a5..7aacb19
--- a/drivers/hsi/clients/ssi_protocol.c
+++ b/drivers/hsi/clients/ssi_protocol.c
@@ -796,7 +796,6 @@ static void ssip_rx_strans(struct hsi_client *cl, u32 cmd)
 		dev_err(&cl->device, "No memory for rx skb\n");
 		goto out1;
 	}
-	skb->dev = ssi->netdev;
 	skb_put(skb, len * 4);
 	msg = ssip_alloc_data(ssi, skb, GFP_ATOMIC);
 	if (unlikely(!msg)) {
-- 
2.7.4

