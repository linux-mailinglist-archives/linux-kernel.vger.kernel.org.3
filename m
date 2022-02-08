Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17CC04ADBD8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 15:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379143AbiBHO7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 09:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379099AbiBHO7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 09:59:43 -0500
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30042.outbound.protection.outlook.com [40.107.3.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C342C061578
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 06:59:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ewc7whPqoaQYOO36XBLg7UhkWCgW0XyKKoh/+8/Qf3kNH/brdh/jeRUgxXtEqDa64iAhX0LQW7n/xo+x/O4PcdWjdsCLn2uR6Yveqh2x5/dxMOOewRLMlCmiYasKM6ki0DBmVMLJGyWF78VR78ba5VqnGJtQIZTWvaDzJ4ets/yekOWXmoHB7pFsFRe4lP0jE/4t2LtUbeGSf/LtCx9MAxgUjTflmEpV8l2F2KmqEQkAzwMpWJqyxr8Il0n7FppaQ+xkOHflUXzd9l7vrTM9wYlzSW7m2TYiQXU9GTGGAKdIBnecTyIhr8Ss2uet1YV4QFQSSWMd0QFgAg86ut90fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKFQR0hA8rDXqDC5X7c0kl6i1a652gZ0b4wH8tJcUTA=;
 b=Jz7lm4P4FrWnuqtKJXP01IOZRov5infK0Pmz19D4qzp3xVcIehKNg6vm3Su+c9I9rtiED6n1oveR5jFOnCUEcdHD/mnIIpBMvzHPVnJDRAe3fJvugi4EEM3mWtj3cOTpc+ZH+VPFm+vt15hP2PLohHsnvR6cSwv8ntfCm5/gruwB+auFxMWxy8h5Px21xzVwrlAviU1e4yOMgM/QQBmJgNlM4BodlJvof/rutVAHduptdQfEP9//toxL+QnPK16WuRjrUR6fFa90dSIbJKLxCVtsEgKzxTbnuSt5qd9GTNe4wa89GwNUAjIm8FOoPjSJnMZ0MZLcd1NaocDPxPS6FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKFQR0hA8rDXqDC5X7c0kl6i1a652gZ0b4wH8tJcUTA=;
 b=JW4sQ3dAS0mEcW+qYlaMp4qh0Uhh1+Lg+priEJTvY7IX6Smw+G12qZrX2OJTBmPpAM4dsNAMMtKlA5CJ7Z7a8fde/vGwoU92v4nT5B3gY1NxX4zg2y1B+d1AKfImlJUf6XFzf4qLH9BmAfLQnMYna5du2kxtVRC9/Y1AV0Te1IM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by HE1PR04MB3018.eurprd04.prod.outlook.com (2603:10a6:7:1f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Tue, 8 Feb
 2022 14:59:38 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::f826:3bf6:b77d:5a53]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::f826:3bf6:b77d:5a53%7]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 14:59:38 +0000
From:   laurentiu.tudor@nxp.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     ioana.ciornei@nxp.com, diana.craciun@oss.nxp.com,
        jon@solid-run.com, Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH 0/6] bus: fsl-mc: fixes and .shutdown() op for dprc driver
Date:   Tue,  8 Feb 2022 16:59:22 +0200
Message-Id: <20220208145928.12468-1-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM0PR08CA0025.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::38) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4061f29b-2a8c-4bca-19c5-08d9eb13a069
X-MS-TrafficTypeDiagnostic: HE1PR04MB3018:EE_
X-Microsoft-Antispam-PRVS: <HE1PR04MB3018FEAF932A817851D22285EC2D9@HE1PR04MB3018.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ip5LeGO94C0gDJkxTbhcFvTEZlGF9nWMPohnd8k4n4aeuHzqrlLaPJU6+aKcmFuIQ6Xw0HH81Szqu5cLFYsYecvAi1oNwOs7e2Y63oAgeDIV3Vg3ipzk0oEi6Y0pkNQfGLvN+BBtCbENDVKMv0VJTI0SzRIu3OiKdiAF4dJYWxogvZL1xe3gzwcNcUVI8+wZFFyHG/n/VPWM9Et4UJVBDXJc5mTnYdHDCdpF4flYKMgK9KhTMyOdfmIrt3boLc2hC4luMhipKGc+aRziWLdIclse/4C7pwhZ3NlLi5sSdDQJaBfVYmYbq1o1hMzF4aEt1akIzZrwQUWC1xxf5eUjfp0c49RE3uyapNhcws98ZmvO6k56+URQ6sqLaenc/DRAyVjpS01iFQcFPKBdtJ63iE0k0dGkbYMPkkAp48ApFChT06tjEMZee4pbXXor221QRVajzXUJk6gFPuwoPoLLKgoqjcwJpS1HjatKO1XClvy6FNSmEBRFLUrzIWefb+YYhU46kBov/5gbCk3/Jq9DhrYRDyv5yNNcnVSfVVKqmx5S9xBAYGDdWbaLAEGX5zLQgwDVvQKSxjjqWgxWH2VJyex9TVw6pBX8jlTrb2Rud8Ajh90TiaoMyuM26ib7WaFhPdjHYBaa1umHemR6WYgvcgidwKlRBPiOlmI2Q5IzWHg79gUCLV1UUgKnJY5GqKqYSgGyYuH+ZmsOkBwuQGfOPlFYZxlAtZchnY0nd+YBx0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(6666004)(66476007)(316002)(9686003)(66556008)(508600001)(52116002)(4744005)(186003)(6506007)(2906002)(6512007)(1076003)(26005)(5660300002)(6486002)(8676002)(66946007)(4326008)(86362001)(36756003)(83380400001)(8936002)(38350700002)(38100700002)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zd4aV3eKn+u3JFkIY0qRMNURENJI2wNcTQFv9MTmNwYunYq45bCxwVcsOkRX?=
 =?us-ascii?Q?XnCBwbG/1Q7rjeFLSoVbSJ7T3icxk1xrwn3gqBdvXHlsuvEbjdDB478NzdP3?=
 =?us-ascii?Q?ov0xISny0rjSM7gkp2V1dsXvpcQu7rD0GeI7EXL/wJ7WcnfPda2DCiGAj8Hb?=
 =?us-ascii?Q?qQ9Hkt6KFAdaBfhcEUWrnTkxyoq75grCnExSFZFqKJYCbl/ehK/basGLAuSB?=
 =?us-ascii?Q?3zPAGtuGESSZf8KCStJdQ8LJaOh3dUskMFhdE8zuJUsbJgtWF6cbX2ywmueE?=
 =?us-ascii?Q?Drg09NuZVPBLI4+zacD2oJIM/Bu4SrHG67uQjqopzOwBZNza8Y84MKjBYRs0?=
 =?us-ascii?Q?sm/5/6r2BrZ/aOHLkUh+F9eBz4cp34drRoc3wjlEYlvgMgVo8gL7cOZ8ud1d?=
 =?us-ascii?Q?+AK4XRpkwnSuLzLyBuW0RGCw2g0CW7Ax5/B9wm1fX7dq3997uXxEEg6cLC9S?=
 =?us-ascii?Q?mFQ5m0Jy2FBBdWWmY5J+9D655Od/bWYjTZRKNmyu9KgumiTUnLAPXGmLWGAs?=
 =?us-ascii?Q?G+nN+wwVNu9+w6oAYCYILolAjOAvrWDVP9GnL+q4ClMYJ219yBQnuTuUsY4W?=
 =?us-ascii?Q?H1bP/o3YlLVt2IdNMVXEZ/oA6+43I7FNLA/MHh+kLbDx59siYj4pW+caRpRn?=
 =?us-ascii?Q?9QB64/gzA1GJfnwzFwYu9kNb7bmytbMi4T81JQUar5krL4Q4+g8UAL36h5j7?=
 =?us-ascii?Q?rtN2VYLSmDmewO1u4ERgkmrtnIiFHnLo8aN+eOZceCNrPXtNPjnnFVA1Ji/8?=
 =?us-ascii?Q?vA7CRXnz/VjXZnkQHZcB6kxkmcrETvUJ779CgeQImSr3s72xsjmN/8FJXeuz?=
 =?us-ascii?Q?YLBROvMXGo/8rGu4+VMIzoMKzIUZ+lJ+X6yKnGdHiM+JJiv5Mw808aTRatH0?=
 =?us-ascii?Q?9KiAzH2/RF4mwD2OWh/lR0uJ8GrWtV2BB4cjl9No7bv1HCAjnLz9uZJbVsbO?=
 =?us-ascii?Q?l7ykNqe0zVM8FDt6lBQG3/aQ576kG0aTCU5VWfHEpS+95RHO+UUnQi9gGxCp?=
 =?us-ascii?Q?qfTI0Vn8s47qH1Qn3RbTY2QsCgx3wSbvNIPyVAOyIfnX35JfgWS/9YlvThEG?=
 =?us-ascii?Q?H0UyYniMMu8ZR2sFIaUBx4+zw/l98VriD3lR01WgPZYvfafgWGD1/RdAICEC?=
 =?us-ascii?Q?rV+FTZbOp2JfRJocys2zgk4nIXsZvf2OPXgqJjdtUaICOu6JuNzuy347vPJE?=
 =?us-ascii?Q?EhO6D/6G7He8LjA7zulh8HTenbREz0LEasAQrCKowuDmZyg9KkJ+dPj6VRZ4?=
 =?us-ascii?Q?MM7aSuzOX94Zz4+BWvGYnVdhCTwKy4OZpbhQGOUwsuOv/rIEiFE3ggpvbJi1?=
 =?us-ascii?Q?Hv3+DVvUKYfSsqcoVTcWYgw9ZUh6AA7oaOULY3sHlYYEZY4ALpBV2XxFohej?=
 =?us-ascii?Q?b1YKBlLXNYlo51Cb8Rqj2mJSD521Ly1iSHqCOvC8Qf2FdAJaibppOgGhnFjv?=
 =?us-ascii?Q?8ofBOwk60pVB07aAOeXwUYRNYNHrc5zAtJkY4kvx3Dw7v5iTn2fRy1Qs5zYW?=
 =?us-ascii?Q?k9i61TtHl+dV+eX91Ng9kx8Cy60nDUw9ESFLgRWI445e2p8GDnZTrcEasUQv?=
 =?us-ascii?Q?px7opzXVkfuQqPHpqCsARtKb7bhjcy5HOzta31GvXv2vUEi5XNqY+fMKxTrx?=
 =?us-ascii?Q?aA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4061f29b-2a8c-4bca-19c5-08d9eb13a069
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 14:59:38.0596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +GzsLnX7yihGxXBq7omp0fSHfGh6ph2A09A0SjbTbl80vlbppvAm0MuzhxJ6yTgS98q3s0e5UsFWit/+nNsE8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3018
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

The patch series addresses various issues showing up on DPAA2
driver bring down, fixing scenarios such as kexec, bind/unbind
and halt/reboot. Most notable change is the addition of the
.shutdown() op for the DPRC driver.

Laurentiu Tudor (6):
  bus: fsl-mc: drop useless cleanup
  bus: fsl-mc: fix a use-after-free issue
  bus: fsl-mc: fix double free of the root DPRC fsl-mc device
  bus: fsl-mc: check for null irq array
  bus: fsl-mc: move uapi misc dev create/remove in probe and remove
  bus: fsl-mc: add .shutdown() op for DPRC driver

 drivers/bus/fsl-mc/dprc-driver.c      | 61 ++++++++++++++++++++-------
 drivers/bus/fsl-mc/fsl-mc-allocator.c | 24 -----------
 drivers/bus/fsl-mc/fsl-mc-bus.c       | 34 +++++++++------
 drivers/bus/fsl-mc/fsl-mc-private.h   |  2 -
 4 files changed, 67 insertions(+), 54 deletions(-)

-- 
2.17.1

