Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D9546E855
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 13:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236279AbhLIMY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 07:24:56 -0500
Received: from mail-psaapc01on2104.outbound.protection.outlook.com ([40.107.255.104]:42241
        "EHLO APC01-PSA-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232290AbhLIMYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 07:24:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IEC7HFJh4z2+FeLwikddWK8j2YTR/1uSo2o+Ou1ZJYIGYlBs1RbMCUCSfg+la9o8imuwR8STDo7zIUCG36KDbmTHHp5Cc/OKgVFelc4UdDm3Kwh6Uda+XL9Ce1JBqOWU8T71GQOsDGzynB+oZxBfit15VhYzru/BUBv/hJh0JLHUfWyGVEtZjMW+Vu9SZuPS8MkUSiZPUXqwOWACdq8h0daKKvnDFplN4VSWikeSDVkamqok1LeFp25hV92C1qbtkcmLsoF3Ht8L7cKlDbnqzzdZVrl/DrmEIPzyvucq0quKYoz2eNg6uspqYPJH8czpBRiPxItsRS0Ot4Y5cWzSJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FoAzQy0t3X9KjO4hsv4ADg/+uo4ddQs0LZ4dBrkv3zA=;
 b=Iz+8ZLJt8yiV2N8CC8SjqvY92GkrPljNxXRRj2oMp2CxjMyAAij1RvPORNUzMlOMZiFT41OrZ71JUzjqIuLi5SJfejV+HB8d8vDFA5zP6nNkWvcSM697Zfnz7uLxFoFRnkmPIBYp2mUmTQIfnG3KhClVoyxm0P3UXEfMIU36KJ2nkoixO0zpLSL1XmtKySmgSP75S2FeWZ5SnIbaUUrVOgw6JWuCB3dpuFXOQPiP8lxbdMEQmvgHdplJPXplN0mCntwNMfm8Omx37/NL4l3Po1S7VuSxTDA4Dh8usn4gDWm469vfpGmSY/vFbA4y0uSFygTx/zWSAfRVI5xMQ56M/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FoAzQy0t3X9KjO4hsv4ADg/+uo4ddQs0LZ4dBrkv3zA=;
 b=XDcwOr9iNFD6Lq9KhzG/MqN2tI9GlRvATVmweeGFHNgIeS+tKXtnPniHZEy7e8EXJJvrNttlUL7VccB6iiP5HC9jIB5xLuxViCvo1oXdToWrbOBnnDjzfQHmM6kOlbwzq4uh+m5NpNkhNiPLj5paqUM47lggvU7zT5lKRTOaYnc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3033.apcprd06.prod.outlook.com (2603:1096:100:36::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13; Thu, 9 Dec
 2021 12:21:18 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::a0cf:a0e2:ee48:a396]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::a0cf:a0e2:ee48:a396%4]) with mapi id 15.20.4755.023; Thu, 9 Dec 2021
 12:21:18 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] clk: tegra: add missing put_device() call in emc_ensure_emc_driver()
Date:   Thu,  9 Dec 2021 04:21:10 -0800
Message-Id: <1639052470-23368-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0047.apcprd04.prod.outlook.com
 (2603:1096:202:14::15) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
Received: from ubuntu.localdomain (218.213.202.189) by HK2PR04CA0047.apcprd04.prod.outlook.com (2603:1096:202:14::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4755.24 via Frontend Transport; Thu, 9 Dec 2021 12:21:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 880f8b53-156b-4769-c4cb-08d9bb0e672d
X-MS-TrafficTypeDiagnostic: SL2PR06MB3033:EE_
X-Microsoft-Antispam-PRVS: <SL2PR06MB3033D811E09C26CD88227BDABD709@SL2PR06MB3033.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tx9fZtUfYcgDN+MmrhI+jkku8+23xsdUmZ9sWdMNY0pcwKd8L91AJJo+uX5pzzB5PehoTqQKWbWs5REpf1j9yo1R/0CmiySXpwu0cBPPBhldONUqCm3Dj5ue1+8RphfIB6yeyx1VdK988Nl1AV/6Evfg/j+K06/x3v9cIdtTsjcYbE/nzgCG9JY45tvKDyYgc5+LtAOCDbhY+dxCwGt3s8rXmKaHwdwtt04M6hvy7KwwnP3ouy/NcE6ro1zaU0H2rMa61OTAN2HyJstA7cLRglFFtaWPSUr+ZxDXcZhkV868RgHeiNNk7AjFnFo95TP6iPZ9rzW/6myuqt7TlPGYCWH2vG/1pJK9b1rH11FEWiSWvXJ7F4Ya26S3krH9+CybjotvKZsO72kTLTSbzPz6iAjyvjMZB5FhoToKiTMH/yaURtXKhOarHmUG7xSC25ZPB2y74z20PTNOqpsn3FXdsH7ljHyzpK2Anv3i4U/96OLyr6bY+XX690/cweqNzl2kZjNhISuOkaNGDK2Dt4C3DT1y9d7Sv3KBpWm+GYF3mDqYC0k7VbUN7eamB4L8bB1JYVBtzXuWSCtMDSnewCQYOqPZAOxj423GLjSPGcy5/jlwIQRNxcnY/lDLIDCdBfhk0rNpesb0f6kGXm2JEmqO1os39r4RBzUsrvAa4hazplmuihSsXDNmNr7v/vLhVZD60SHKjMQlRzywAn3G8RZ+Yg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4744005)(107886003)(2616005)(956004)(26005)(38100700002)(38350700002)(86362001)(508600001)(8676002)(316002)(2906002)(5660300002)(110136005)(8936002)(66946007)(66476007)(66556008)(186003)(52116002)(6666004)(6512007)(6506007)(6486002)(4326008)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5LYnfGh46+KxbA+tANMLbvtHQIreDD19Bd1/ObH2iDsPnav70Jg6pFlBuFyq?=
 =?us-ascii?Q?2HGPgkTw3zlQEh6wjBdGp4yZSdVIjMvPmyJB7iGWRGklLwbRliE9vjJJctxu?=
 =?us-ascii?Q?NfT3P5gi1N/0uuf8cSSCfOiWIvoDqxuoSSuCGoJ/htPZ9UyF7WVZjoj9KxHA?=
 =?us-ascii?Q?ClFu9GHJj4yBpxJzprl9W/KS81/vvVxJzqzU02I3a1MpfGuwCA24AG6jb+Tu?=
 =?us-ascii?Q?zYW1kzm/9hLv7s141zTBUQDT0q1OEhx4nNr1U4Ui7ORWzCfCTZNH5bI9E/j4?=
 =?us-ascii?Q?1gQ5bH+JBIu7OhjLH24JBmwh9VpOYxXYlSQm2ms4w4D1j25zpXh7F0/IB/mW?=
 =?us-ascii?Q?3nhgtP3WjhToXMiMJBz31cUwQHrCHfFg9s56KHSvAuBokpVzqqwQTRB10rfV?=
 =?us-ascii?Q?INarMDziEkVQFvg+sOOXE5cgAbt20q0D7iP6LCplEu0EQVY8vFWj6XY4tFeN?=
 =?us-ascii?Q?nKLGDOQDPu4AvL4x08haDb/68li1OAvMnWY8S/AHIm3vIaC+OV2QoXJdC6Wz?=
 =?us-ascii?Q?oZDAfe79yvDlYhMTVyoBCT9vjD+qZTUdgu4w+Xzeaek55M8N2MBJCjIaZOou?=
 =?us-ascii?Q?MJQcWlgKeWtSGjcuYl0YKCN2L1j4VVmiPLt1tBiyACA5dSzNQiMwFlLXHYP9?=
 =?us-ascii?Q?v6Ab0CgJaBUwF+Dt0Wqm4iJvFmXzvhLvMiX6Q1WS7eHRYjHyzmFjqm97uYum?=
 =?us-ascii?Q?Pu3vzowwRdHAdllS25ukuARGOsrXhw88WhlTqNB7JENBMN9dL6ksagXe6NRw?=
 =?us-ascii?Q?A0+b4AAPO8gTiqBL1ivRwviXIDcANqlILzC9b8XGgji/m3gI15fVVhT1BMqM?=
 =?us-ascii?Q?Pszl6RRcYTIOHypAveOZjDrs0t/HT/ibuyW+NqXGyHrDRU9012fqblVYmFJv?=
 =?us-ascii?Q?PA5WKnt8nbw29/Nq+RzEdMeVcY7/ax3Si4PA/Kp97Oin8JPD5GsjkE5lYg48?=
 =?us-ascii?Q?XRrdjFk/k41vf0XkJBFuim/l0dixIUa/5iZQf285qtp/QIYU+O5g7cqXmKF/?=
 =?us-ascii?Q?9s9dzfNmUh0kABw6yYMa42s4VdXRq0cS+Etd4qJibZX4zQZPs5E7ZcGCX9+b?=
 =?us-ascii?Q?Rf8BZDSeGWQ3dc3rXw4h0eq+gD57mQkeCEyWjKLsNPQleUmKS/7K5V7+9J6s?=
 =?us-ascii?Q?OHYJegtIJMpgiKxM/erClEXU2i2yH9oksHkqVFZPITK4949Qf2XbEwEDrSPc?=
 =?us-ascii?Q?mnGd83d9ED+DvFc3dIYqRcEe++AFGo1zswaK5eLzbyHrWnFkF4BkMPvWesxh?=
 =?us-ascii?Q?Ozmui9JBr1f4fKh5xAqA3ncBobE0Qc4y+Gd/wbs5xQQ2fgMJVWK7j1rWnemh?=
 =?us-ascii?Q?5irXRu0Mw7MWF1ZJmKsXY9xFW3Oavl7Msc5wZcvSz8690SAC1GbY7Zb9urPR?=
 =?us-ascii?Q?u0RZnPQX6SSOplHuN4X4eCzDg1O5zQL/MdOdmU8TmIlQcL91/8XPWF97a9pV?=
 =?us-ascii?Q?R5iR4vvczVqJXbmGNTHfnWuLvWUtjFXdjEBr8mGpXvbIHiXOHO26efp8qhhM?=
 =?us-ascii?Q?6PehaSys1u5VWzbn8L/p/mDmZ7OJAMyQ6DxcM4vagA5AkPEu3dh55cHGkVOg?=
 =?us-ascii?Q?dsyJLJSgA38Kh1UWitnk9bBnFdJ7YzN/3e+UTx482Isj4dXQwpFwXIRQ1r3T?=
 =?us-ascii?Q?LejsOrBuWqxDH+lWuZei/jw=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 880f8b53-156b-4769-c4cb-08d9bb0e672d
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 12:21:18.6386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k+TBBdjB0lYzKmWG+JkXHYx/qz5+oLWTwXjNxk/3nwqR1yM2+u6AlYhM2d3ecukBUvCFJPxod1ytH2becbk5cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3033
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

of_find_device_by_node() takes a reference to the embedded struct device 
which needs to be dropped when error return.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/clk/tegra/clk-tegra124-emc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/tegra/clk-tegra124-emc.c b/drivers/clk/tegra/clk-tegra124-emc.c
index 74c1d89..219c806
--- a/drivers/clk/tegra/clk-tegra124-emc.c
+++ b/drivers/clk/tegra/clk-tegra124-emc.c
@@ -198,6 +198,7 @@ static struct tegra_emc *emc_ensure_emc_driver(struct tegra_clk_emc *tegra)
 
 	tegra->emc = platform_get_drvdata(pdev);
 	if (!tegra->emc) {
+		put_device(&pdev->dev);
 		pr_err("%s: cannot find EMC driver\n", __func__);
 		return NULL;
 	}
-- 
2.7.4

