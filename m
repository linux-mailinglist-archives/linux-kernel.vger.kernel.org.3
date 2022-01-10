Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA24448953E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 10:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242955AbiAJJaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 04:30:09 -0500
Received: from mail-eopbgr1300110.outbound.protection.outlook.com ([40.107.130.110]:64880
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242963AbiAJJ3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 04:29:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GE1Z+gyFtUvkYwTQVSO0YRq8+q0an6wmk8zbgenPOwFLv7bHRRhl6SONYykOBOXOZy8xs5cyrY0WEVjxgQ3DwGiiRYUAYpxuNHsdnxFUu+mKQDD0kgT8S9r7AQUcurnoNOcD/YTSPBjYiaoLH7EYZR4KWTjGjbzwkWbps52bK9Q+2w8Xc7C0q/PFktWEmdAU7VRV2iBwA038c3RFbLysNYlFeHYEGxnYkb4xqfw3nEfA15w6geHmgIxHAWExklib9OTc55qGCXqVuXqSO4v8rVUZhBbBa0DzRc7bRe1atqdWMqBETVG5OlX7ZulvFR3l6Ky77/xpfRNagDf8pvVq7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aj5xeNC7KyrO3V6mDWmv0Ty/hO5Qa6OMG+wPez+oJrQ=;
 b=OMczSWvFnrje63DLwm+TQsCOHhh7b1t6O7CwH+DBGQBnB0lQd5kRYDSQzK9mgtENsxTUfJ68U8NXgWdq7BX3wA3T93VorQeWQiTM2FFbIJiWHQU2XAC1+cLyXEflL9PEE0mebIz6UteHjpXRDZUu/IxBg8tTZW8CNxKTqy0I6TuESEK+5jvCMjpph5JTRHNOGme40q0ukuKvWqq40/+726nHZAJ0P36w6NtE7EyUiZxEvwyntVIiSWRJqfPCpg0bLnBTook78NjpDRbLU+f4I+6AVY2Zfyx52NR+xNmV+qx0042RljgXhZNn/zt+QVmUyc3nqi+gYAMu077eXfSreQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aj5xeNC7KyrO3V6mDWmv0Ty/hO5Qa6OMG+wPez+oJrQ=;
 b=VNbC9XtWNHYdM2ZYt5Po+JEgla58DohRB2jPO/aR3cI91Y/7TiuXRuXOglJaFEL19C3inTW5x11kQ3QIufR0in+5AJyGfqqg0UtrlR+/H+zkX05lYwFvb9A3NRn+daDsITmnYncLAYazkDEJJ20nOsdj7LO9AsztJzrCLBVmBEc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 SG2PR06MB3451.apcprd06.prod.outlook.com (2603:1096:4:a0::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.9; Mon, 10 Jan 2022 09:29:47 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::ac83:c27d:7c9:74ba]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::ac83:c27d:7c9:74ba%6]) with mapi id 15.20.4867.011; Mon, 10 Jan 2022
 09:29:46 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jiabing.wan@qq.com, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] regulator: qcom_smd: Add of_node_put() before return
Date:   Mon, 10 Jan 2022 17:29:14 +0800
Message-Id: <20220110092915.1444044-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0098.apcprd03.prod.outlook.com
 (2603:1096:203:b0::14) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40f1a26b-a01d-42b7-c7ef-08d9d41bbda1
X-MS-TrafficTypeDiagnostic: SG2PR06MB3451:EE_
X-Microsoft-Antispam-PRVS: <SG2PR06MB3451691E6C4A50ECACEF2C39AB509@SG2PR06MB3451.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yMF7vOk5j8Sr5Fl07PgX8wPKjyH9ReX3l9+HbpRoZW0L/4fr1sVzRLa3YhzvxJqyYeincsH941nK6wzjvxGmBvP21bGxEJZ/+zna+qImjPr0uxe7bNdppxb2EZZ6wLGeKKTMxtpdqflr8+YOaiIx57u4YyxqbZ5b7040gW/aZ76B+NWfjM4gHlbEyr3Q7uGgqY5EUlu0f4TzasKivbBZK9xR72SxYK0cXlAGgoMuAXEeFBnu/Nzipey4vU/JtcChJ5XEbu0iqhJlVcw85Hd1jwt3BPavjLggyCaPubKXMig+zaKJLPRz9yZRhV3JSKtpfnagQI27nYPoyvdFUZklTLSx1ERUHjH15nFq3ZmvKo5Mft5tI1BuJYQV+qUoRYw0EOrUVK+z2LjcTckhdkRf6+ncXaXtMR6v03i+DBENThbdSgYo8+9Rfs2OI+uT4IdPV+Q/7ZInMosoRY5V8L1gwOZSkP2DJyPAurA7Zh2/M+yzzy4a57c1Sq9R1FgySPokeRQVxQgXuuJzhYZ/9y2L+Z342dEIPiSaDm341wmAZf2m0N/RHok7EKubdy3TXzazocNVTGh1r1TQeY19Tiycynw+twkNk2ukrvlNuYFsnwAABTJ3eUmkElFcPa+VOhrHwWH0IFAnrM4R2iyqLTfFHARMgNzrNzrL1RlHAFLfG7wD3Pjy3WDYxFlsW20J0p29
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(8676002)(8936002)(6512007)(38350700002)(110136005)(2616005)(52116002)(6486002)(66946007)(66476007)(5660300002)(66556008)(1076003)(6666004)(508600001)(107886003)(2906002)(4744005)(4326008)(6506007)(26005)(316002)(38100700002)(186003)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TuO1Klo69svqQWEgqWqjidtqXozOUQPKl/7qKogTBRk2ptXbL+bBR5S+PHOh?=
 =?us-ascii?Q?W5jISkXycJhlNzLNUjcyGRF1NfEGnVDWcadDw/Jpx+zRYqwdHgXJEMY6Zigp?=
 =?us-ascii?Q?IcVtWFN0+csM/MXge1SuGcXtZ8IaJxrPVGWPe/PSMPKJvaRuRQ0fmK0qRUU6?=
 =?us-ascii?Q?Xrq3B6VmuLnG1aXLkKtpVNNcUv0wDspQ5TH8lwSD+wFbcCns8FZbttt7UR59?=
 =?us-ascii?Q?4dU0ONQSot3YlJBJSmAwlh6uobmHmR5H/soUCq/mNdVcSl5SFwA2jm+JSnpS?=
 =?us-ascii?Q?uMmOws1SdsgjL1ybZAIUEtQlTd33g5eG+IFKdKNt17L7TQwDYUF5W6BmtGyh?=
 =?us-ascii?Q?BzQ1LhP6SRpUaVCi+xHIiAG/Jc3sLTcJA1bfa4K8/+7ekNhhu9zXGWF+++jX?=
 =?us-ascii?Q?DLBhUYFnao6aA49FMJNeesvKaIeLbIU1YFRLV17bSutXVE6TzhVLtEkwEuWm?=
 =?us-ascii?Q?6C9UIpjbouAcwvbyzYl5saBPJcc9O5KrjzJXhgz1Qs99FTor1GCR2FdQeD66?=
 =?us-ascii?Q?kz3Y8zUXxhHrS8SCYJbRyG99lzW6ICsffFvr6D7w59CHsJnYsuTtV35WuNmq?=
 =?us-ascii?Q?uCT7tGqPOHsHSQRc8LgKjhjpBStMXIFfRR+DVMyqL8mywyVEHsRfZLLYBave?=
 =?us-ascii?Q?KZnmS7JgrWWSLsBNrkGgfvRCdHzp0Bzz2ZnBuZdn/lMdYjQgzZk88ldP+rLt?=
 =?us-ascii?Q?v5CI3UmRPCrgr3h0vrejkeWskEDkBu5icB3Xk7EvzGxB+8w4JpcBFU5bJFQy?=
 =?us-ascii?Q?nOoF3JEOaOoQssfzk3vNdziashuDUJFrtfIAisX9RvBK8FjuEBV+ugccENNc?=
 =?us-ascii?Q?HCI02V8tRHVgHLDWBbw4WPExRPg9GAbC8JOmVepCqNAmvEtmN5gbYBImTHYe?=
 =?us-ascii?Q?lDbr8gpSAecNory8puM92HNStyKCf6r3CPTL7J+xBWeJD9/niqm10egPJpHv?=
 =?us-ascii?Q?cYvzR9rQuYV9o5ZUjJZCwe7kh2gmSYgzmiLueAgrhK8nn51BfH1dAiiWYKMi?=
 =?us-ascii?Q?I9McXi5EJuS85WXO2W7oXnbdKwVXm+LcH7V89hNszCP4rtbZTcOxecF4ZbQu?=
 =?us-ascii?Q?2B83Zh+rK7A/eYWrWWQVTjeO/NIvDOGlov9jS1PLxhdRzrSsRkVULDYhW60s?=
 =?us-ascii?Q?CIMrZeJ9P5J0Y96AB/N5uUyFBrVR3in4qEVOOMvwh1/LH3hAVSPKtgG3Kp9Y?=
 =?us-ascii?Q?kOGxSHiHJb/z8MyhGWsQi0QeKQ/WNS60bIDYIhtwDOc1XnH4BerWvvsAYcJm?=
 =?us-ascii?Q?EV//qIHu4YJF+Gp2Pmm4J+jV3HpvkOJi9NqqQN+A2/p5i/43ATM/lTsfCTsx?=
 =?us-ascii?Q?licmvxjIjlSRTZbXCg0EBN/5k69aa50Z4k81QsvalIsVURAZVEFKrslZAovn?=
 =?us-ascii?Q?Ktb1Y1AGPr88bIZizXFyU1xMioGTTk/v2WR+tN4m6wboPga81hcmlbeS0a2A?=
 =?us-ascii?Q?e1grMWhvsBnLG00XyA9Ks8FRKhdNne9V9zZoGSX+9hJI5VoueTkVqyKLlgRq?=
 =?us-ascii?Q?0EMrKypVmYgEMGR16Ih+tKxB2bftZfVdF5ZYTDkWJDqnXn6KejG1HBTG1qlB?=
 =?us-ascii?Q?nLVksBBeaB49S5jg326fWwzfqW7tGodQojohhznRlSxqVbq93l/oVzmi8ukK?=
 =?us-ascii?Q?lV8Xvj7Zn5gdHBfqKmsV1fc=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f1a26b-a01d-42b7-c7ef-08d9d41bbda1
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 09:29:46.5181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ON3qzlTbwE7nUB0LhvPUBqyxMXw85s91W6Mfu3CjNlniTzujeLwyeMSlzNh4kJS2mVwU9l9tkZJDtWGTVXVHmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB3451
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following coccicheck warning:
./drivers/regulator/qcom_smd-regulator.c:1318:1-33: WARNING: Function
for_each_available_child_of_node should have of_node_put() before return.

Early exits from for_each_available_child_of_node should decrement the
node reference counter.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/regulator/qcom_smd-regulator.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
index 9fc666107a06..8490aa8eecb1 100644
--- a/drivers/regulator/qcom_smd-regulator.c
+++ b/drivers/regulator/qcom_smd-regulator.c
@@ -1317,8 +1317,10 @@ static int rpm_reg_probe(struct platform_device *pdev)
 
 	for_each_available_child_of_node(dev->of_node, node) {
 		vreg = devm_kzalloc(&pdev->dev, sizeof(*vreg), GFP_KERNEL);
-		if (!vreg)
+		if (!vreg) {
+			of_node_put(node);
 			return -ENOMEM;
+		}
 
 		ret = rpm_regulator_init_vreg(vreg, dev, node, rpm, vreg_data);
 
-- 
2.34.1

