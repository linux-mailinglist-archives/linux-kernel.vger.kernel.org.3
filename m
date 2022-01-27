Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEB5549EAB8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 20:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245361AbiA0TAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 14:00:41 -0500
Received: from mail-vi1eur05on2045.outbound.protection.outlook.com ([40.107.21.45]:49655
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245190AbiA0TAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 14:00:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3OCEgsyQxI1TycYMgWIcE6i6I8zA9vO368lWnpyGK1SnB6p1U145pM8JKwCUB4FdQkH2T2S4XLbnhWoKwh2ET3foCAGkUU7+o6ugeeody1xDWnWllbNQO0C5vZOB5av5UarhnyLLyncjLwS6MdHB/aAbFcArj78AtMhm+q1/ZRoaTLm+dNS7qdaobn88s1C80z3O8gtFJhqkZ8Y+Ai40IuxZCrZiSST5cGKN7sN+Sh7+b9QbSQp/Wa1mZWxTy2Dm8Bdo+8uIYlcQHAqAJeUTX5XnveVAd277beHGK4sdbeNf9zV101aNsb5Q9RTxmnx5Kih8fYji4VJL2POvfxXhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bbMdOUrgPHbbbx0+slVc+FT+cJ7CfYzcREzPX/lui4=;
 b=XeCbROHsUvHXzdm2ahiy1SIICOlt0WD7p81F1PShyDtPtCZcEaBxtTWZ/5rjYTZ0YlA2bv0STBkK3lNvP5Gy1xtYIU9a+j6NzxWSbT4ANlCJeMAzEsWvB047XACxn9kB7Q9irUeENchOVIRcC/ya4uwqdwLcrQcRj9khWQvldw4Z9Q0svQzjwx8/6rTgvLjrK6XiTfVclXr6euMzZfJpz9E8VuIaGvkkBO4IFVCSu5dGd0710nqqqaYwehoWSXmq1t+/6Wx4wPzW/N9MrLFKMy5zFi8f4nHpnHCYhgZ8DEUh3HuxoS8JbELxyzzCnEiAmB6VztbTA9fNlxlSbclmzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bbMdOUrgPHbbbx0+slVc+FT+cJ7CfYzcREzPX/lui4=;
 b=kTE6ZWluTaGByiY0ENls/eye+kP9pUkYUJnTcyBUiWykBRXm0AEUhXG1oyhAn00X3PrbfEDwEzln3vN/qt00SIV9I2z/nDA/HYiCIfj91W2Zd+rEr1jg2t7V0RgHtrQXKdL1s66b0biMtNTTXhUf2N5+tj+bqsOm8V4352pTpOmgCs+t9uFDXsmCCfCjJshOGnhjI0A4YzWaU4IFhCXdMzeanD88QBdywlj/jyTB45TkXIdJnAdldunCTTsFJXeyGwTLGC1rPe/7XHKPIjVlVHX0DLObfltMwiCJhX2x4kaPgDQ+alnokLKOOqRdPsEUMoTxbjnAx8rByhxKTXTkdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by PR2PR03MB5466.eurprd03.prod.outlook.com (2603:10a6:101:1e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 19:00:26 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::2d1f:654e:f946:1a95]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::2d1f:654e:f946:1a95%6]) with mapi id 15.20.4930.015; Thu, 27 Jan 2022
 19:00:26 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v3 2/3] usb: ulpi: Call of_node_put correctly
Date:   Thu, 27 Jan 2022 14:00:03 -0500
Message-Id: <20220127190004.1446909-3-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220127190004.1446909-1-sean.anderson@seco.com>
References: <20220127190004.1446909-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:208:d4::21) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5180027f-15e5-4e03-6d59-08d9e1c74747
X-MS-TrafficTypeDiagnostic: PR2PR03MB5466:EE_
X-Microsoft-Antispam-PRVS: <PR2PR03MB5466701467F94E58A08C9D1A96219@PR2PR03MB5466.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B4eMYMitSsSNSizqhKZxbgWjB8ABrsKWP6b6+8erSGeYQ+b0Gs6Cw/XVDLseL9n+w4m50WM3+E05tNkxFWofl348xd89r38a54BEh3Q0Joyb0C1Pz7NlO+YzvHI9CdcGPOnvXtcuMYZOje0qsASMYG/5TJJ4r0jQRf5BXNtxp3nFdwptIfP6uHOglL6WSHUoC4txF5pehD5BVMihUMyWkqg9ygY3sICCLHWHuaeOipNWIU2soQg0tY2EEieyS0F04YCv0P+4DIEoXN/kBNl80CMZErxYCxZp6M8lAuUVkSlyv5/1Pv8j0IYYCZgo3pFix7lemmwy7eFlMugmEiitU2KJZCwTpkim7zkZed23DOTQYWjzFHBN61f1ne/wCArlN2R6e6zm7ywhd/6ycH98nE0U+iNvNcVgqC6hZ3mP5IM6M6Hd9yrklNHtBtS/H6oT9Yc8cY30aBJUpzCvOcyBKMvJb0tlp0K8M8t5RW7Y6r6cY6bnQzvROgJgTQpWb4kSA2Op1HMXZDr4w0ol9XzT79cMf4OavmXE2K2vVZHstAsha356EwRIRAyYKQHm8HCcTzBxn8EAGCoFo95vk/phTiZXVPPBo4szmFj12jxIutvCnShnp44ZXy4xhJh8TyxZqW1Z7H/DURijt9kujsS9InJYAhp8Ux0qHOXNysWaJTDN56nrvhSpya2hMTBsTSccPZkZDLd3ozGUUanLBX8akQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(36756003)(4326008)(54906003)(6506007)(5660300002)(8936002)(66476007)(316002)(66946007)(66556008)(38100700002)(38350700002)(8676002)(6666004)(83380400001)(2906002)(6486002)(86362001)(6512007)(1076003)(508600001)(52116002)(107886003)(186003)(26005)(2616005)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AgAyCF+jqee2oduBt9ouMkMDjJ6xJlW/rAsz8rl6+YOA38w7BFVJ3JGkD3X4?=
 =?us-ascii?Q?hS5H0QUfCXXMYr42bfUSWOFzEjf++Id/GYoLuHcwuOLoOeFs72O3guh2ynQW?=
 =?us-ascii?Q?l1K2Z2XcXljb7pKje/sSnsii0dbx8ys1bhUEhfTIL0Speqgclo0P9pz5Iuvp?=
 =?us-ascii?Q?SGE75v9OHGswN35kDGPUVYjJCe1HvB+UggTpSCZ42JNkyzLgRGbSNQ5bTygx?=
 =?us-ascii?Q?Yu2Ob7EFm5rn6AuGM6VoP2XzDSS7YxFa6Eiz7NVD4Rlalx7IsWH9SCy9lAip?=
 =?us-ascii?Q?N49B0TfGVKj2NntnqMe/ozif/UqMrlkjU6grttv8P5BVNHmGszuTUXcMzcZr?=
 =?us-ascii?Q?khQdfgL9PHRoUzurX8EatNTTDlCPswsGLIsPOp/CTw4yMiuUEstyEZ6Wqrel?=
 =?us-ascii?Q?sW1P5BUKdfJb3ubyPwsIHROdOsJ8u7j7Etk0+5eNYq5K5RXOaedN9uy7LqjQ?=
 =?us-ascii?Q?BJ18io55qncHEgroHXbHvE5qUfpv7oy2+8YK4gHx4hENkQYeXibn4K2P0vmT?=
 =?us-ascii?Q?KTHi9TlHZtmwW7QUY1n2VLqzNzJMuEtRl9Jr0e12jDRFzXofT+fhdStEoog+?=
 =?us-ascii?Q?J3qGqXtsq9/JnRQKeUuRwnjVe4zWbFJHPeUb+aas33Ec2jZSn+SCpyM4xUta?=
 =?us-ascii?Q?vDN7QJRUmtZrf96X+tdbDZkVSJYe/QGRl0E5xhiUKNEbxz7dxin8frEuSnT0?=
 =?us-ascii?Q?//XxpxWF2INZ1SNeQPJoYsC9qSYhII/7WK+Dl5u7XrUIqHC/L41vP0x0PQ0b?=
 =?us-ascii?Q?LBxtwRzGo1FoCqygquotws+DP4YmrcRyCQYO8tzXlRBvx1jpEYTCUXTjXr2L?=
 =?us-ascii?Q?0gG+cgzanspUU1wXpL9dvG4Ppx2mEiLRoXl27BCk700LN35PUWUqowN+bGCU?=
 =?us-ascii?Q?us/BNgAmQuw3nzTbMvrP9dMYg/Oc2nnn5dEXUblPnMqznfbz5Vuznbco83IJ?=
 =?us-ascii?Q?ccdzY5FQkoUl2ScsVqnx6ZSMNvhcq8Y2F9e4njGwl+nWruYZ+1HUs2/zL3aU?=
 =?us-ascii?Q?3VIoXF/sB1mshYaUcXC0SFRIiCVaxSdeGG6mMImHchsHANUnBucL/M05M1Zr?=
 =?us-ascii?Q?XqaS+Fz2DlkqVD7zG3EQVT7LZe8uqWyYYQ3Z+e2hVUyPJhap5N3Y1X50AjfZ?=
 =?us-ascii?Q?ikrF94WG2bxF1aN3/i4x5erMnzZeevkC96FuwXJ34YC86hhiyYX+W5u8RpmC?=
 =?us-ascii?Q?kljJaADhzBSKhKudtgInpPrLPx5UI34l4c34aGKgea/HMS1YNSGXXaV6ltlb?=
 =?us-ascii?Q?EN68k3Tv0yhK5JDD//yCdK+x7XihRPCrSoaqgHVYSQr2+1udqiJfjWUoDVYT?=
 =?us-ascii?Q?i1x/hEqU5AXaBKucqaiZdhxHhE/ZLx5f2RL/nzRRpvlFFntWbG7Zp/3yUzju?=
 =?us-ascii?Q?s8jrYMzs6bLYW00z2zodYC1OZ/0NEuekBqtWLG5ofEiwHlMVrRVLxBpM/cH3?=
 =?us-ascii?Q?uTlKRWtmb7KoHtGHfuZic62u40PL0A8aN6YB8b2qE2sW6cBwvPPrBIa57Zxe?=
 =?us-ascii?Q?BYK4jU9Xuv16XeJxDmdp5X+a6zUE4EV1CNFJkyFrUopznPKiiOPYfMD7yQZS?=
 =?us-ascii?Q?hNFVdH24lst2uljJwUEUAAjw4dwhTS8D++idJCK0AJVxgcnzigOwS8e2NnlT?=
 =?us-ascii?Q?1RafD5w+uJRT5EdT+SW04m0=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5180027f-15e5-4e03-6d59-08d9e1c74747
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 19:00:26.2584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0UcsDLVyrvpvqdZKuxTEr9Zj7CmxsQC9XxtLLZxihOisSNCd/vhm5q+UOuDGyC6RxSDCtMxreBW0pPG6thUOLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR03MB5466
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_node_put should always be called on device nodes gotten from
of_get_*. Additionally, it should only be called after there are no
remaining users. To address the first issue, call of_node_put if later
steps in ulpi_register fail. To address the latter, call put_device if
device_register fails, which will call ulpi_dev_release if necessary.

Fixes: ef6a7bcfb01c ("usb: ulpi: Support device discovery via DT")
Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

Changes in v3:
- Add Fixes tag
- Call put_device if device_register fails

Changes in v2:
- New

 drivers/usb/common/ulpi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
index c90a1ab705a3..dedcb749a02f 100644
--- a/drivers/usb/common/ulpi.c
+++ b/drivers/usb/common/ulpi.c
@@ -245,12 +245,16 @@ static int ulpi_register(struct device *dev, struct ulpi *ulpi)
 		return ret;
 
 	ret = ulpi_read_id(ulpi);
-	if (ret)
+	if (ret) {
+		of_node_put(ulpi->dev.of_node);
 		return ret;
+	}
 
 	ret = device_register(&ulpi->dev);
-	if (ret)
+	if (ret) {
+		put_device(&ulpi->dev);
 		return ret;
+	}
 
 	dev_dbg(&ulpi->dev, "registered ULPI PHY: vendor %04x, product %04x\n",
 		ulpi->id.vendor, ulpi->id.product);
-- 
2.25.1

