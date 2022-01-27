Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B47649EC31
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 21:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343829AbiA0UHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 15:07:00 -0500
Received: from mail-eopbgr80041.outbound.protection.outlook.com ([40.107.8.41]:8839
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231156AbiA0UG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 15:06:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLuse11DLWB20rbK+3t6UfKo1YX0+HosN+3Y3iIW4Mz3HvXY6Djc3iRMGG5cn8lw9fTtQYUNQCKkRbEnIumZfxwV2lTf667rT2UyeKZu/eAAPssZdAUZ9P31/KyIHa31ccFMtVh9Hr1vqKnFfphP+gKsg7uvjBcvewudLO2Wu7eZ80zkfgpYgfTVHm0VrnwKD38KZUgqx2YNCWIMv2RpWYu4PMMAANbEGi4rPCTMpthzYXEO1aLcjDSaAKmZa2JV9Q+MgLG1zDFuVyatk6JxfWQBfdQgCHhvBxpbMk4bHToKmov4MXNnzF7fNjLPcRQibnfPwoJEcifbyU8BEAhw9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQ9q5vjkZjkiyqauylhlD5CDmI0n7NoRcRcreqp/J/Q=;
 b=NHbrVgWh5M6bpgH7OGZWI95KtbiJPHgERSjcJLHpfQiINMVRmgWEPBXdOTrYD/VbGKiOzd27nRdQAqm4HjLt5ileFyUsrNvLwtlKnN9p8Tz516hrV/QKXp60Yk3o4mTdsnr0ifk6ho2EfxvfH081rEzTBfMCTVJ7DOv+npAzC7u8cc1cdbBTJiWni7YR8iC83swBslz4C2MmEptVPKXzE6aBBPZo7ugWO/t0cZkwRwUkqVQ5ZSIJEUScd3BnQzXxfPxNh/laMbvkv5gwDnuzuWlY1szq7gObjIKY4h0hJ8Wc9cSyRFt6YrdOrMVN7RqHDkVZkDuFWrUgBTQi7UgMDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQ9q5vjkZjkiyqauylhlD5CDmI0n7NoRcRcreqp/J/Q=;
 b=lwlTrpQWIuj0aI/dWfIna3A6VFFp1AdjziKKqy5QnPXjv2xC7C0vca4aGFvpQyMSl8ORm1F2TQPvZJ8sl50RpmzTVduLQ+QoPIotohG8tYMSXtNrCtjvET4ZJKMCvHTwb2CFAp/XPYbnWSGBl9vUI7yAFr12Lcw3o0xBrQkFTObL7K2zo0l/vqzZVoTu7O59y//wxm4QxT24jNXepfQVjisWsJsTGz35UT7V9zi1ygeoc+s+oLWsgPBxDX6BFuR4rV5eexs7LqRn7V3m7c0Mh0018ptgO/s6whoxHyUxv2rSlYKf7hT+OtdRhgaSPhKnTdPSDKam7MfpdcwJ5pDFWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by AM0PR03MB3747.eurprd03.prod.outlook.com (2603:10a6:208:4f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Thu, 27 Jan
 2022 20:06:53 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::2d1f:654e:f946:1a95]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::2d1f:654e:f946:1a95%6]) with mapi id 15.20.4930.015; Thu, 27 Jan 2022
 20:06:52 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     Robert Hancock <robert.hancock@calian.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-kernel@vger.kernel.org,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v3 3/7] usb: dwc3: Calculate REFCLKPER based on reference clock
Date:   Thu, 27 Jan 2022 15:06:32 -0500
Message-Id: <20220127200636.1456175-4-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220127200636.1456175-1-sean.anderson@seco.com>
References: <20220127200636.1456175-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR12CA0030.namprd12.prod.outlook.com
 (2603:10b6:208:a8::43) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2cb61563-7f64-4717-0a54-08d9e1d08f6f
X-MS-TrafficTypeDiagnostic: AM0PR03MB3747:EE_
X-Microsoft-Antispam-PRVS: <AM0PR03MB37475E5C37ECB78AC46F2BE596219@AM0PR03MB3747.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W5YlZA/EMLMQjqgUPRC7a75ACXTPg8jo8h1dNxfQ87RpH4u/enRQYe9vcI8AIrc2rVt/rSbxp//JcK5Fkv1Z5VQsup9jfX0Yor3YyztK6Bg5p5ZC8QAtqseMmKtNGDKz9MitdjGCVKJ6UCs7LV8qhnsmIBY7qSLfm0jJanyvoSugi6Hk/xzHnVTiNl8xNA1z/t7YQ5tAjh80Dhsp5gdgzwH+AWOsK2rjMlkQmUJ7OPRJo38qN22YQbvAZUMlNDax6Ujc+QDCjClIRxC7tv4Dn+YvCIe1QQd3e+qS7cJ5QVb3uO9fpSVzR55R+M6vIE/BC+htZhkChjFWAK7E8mxUEsuMf9RBEULZsYIgoPaX9/FyZNwor4njFQa5Fkgn6EK/w1gIdntLjJEJD5WTxRnLcHxHV3rHXsZWmGpS8D0flhFPWrVY5cYapxN3Zq+c5vvP/xUwIBbADDwNuWajQjCgAMqcEDLpQ/+BrvCxfIvGxuMx5h8VbkKELes0nktVWMN+wWorXApcddJpIAYKsHastPv0ffxh8YrHLP+srOApZOD3WXS1fco1k8G48jwjbJdjBfPAgZC0jJwYDfrmjEWLJmonpreYfG2FviPHvwpO2Hm9K+S9VAhW2knjXFM91AP4RIvuvVRPfr95YlPxwzCtW1iPngHQ6mXHp5Rv1TDa5+R6hOEx4EdqOw9aFDwqlpOG8nxFAEbCxOn10g3yuoJW8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(83380400001)(36756003)(52116002)(6666004)(6512007)(6506007)(107886003)(2616005)(186003)(26005)(1076003)(5660300002)(38350700002)(38100700002)(66476007)(66556008)(66946007)(4326008)(8676002)(8936002)(2906002)(44832011)(54906003)(86362001)(6486002)(316002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5QAo6ZazratIQXIReL/Z5mr5O6RLXvyeeE8wA3HjwELt8uGF0U53WwaQbKgg?=
 =?us-ascii?Q?7qTYbgdJlU8hZBgp7mOhrlcuKJXtmyJg6GJQ3FwRsue89E4k/D3KbViyug71?=
 =?us-ascii?Q?l4Uc8eMz8EGjLD9P63G3O/kB9on4NHAS/t0nqd/fC5uj1uSPTDy/RmKrMHTB?=
 =?us-ascii?Q?EOnaSyEY9XmEznLBiNvY/GaR4B5nVqHBpYAJGfNYsrzdcVVakRdBOGTnvJiL?=
 =?us-ascii?Q?grnRVCRKQrd1HzAxWSvSf/n4bIRaiOgKEPVmyvDqde5canLph2UtkzXMDRdg?=
 =?us-ascii?Q?tj5o3YAbQIt1UjE2guJi7+0SWAyHr/oDnsMLmR80VDBgqAdc+20jHPteX7Ph?=
 =?us-ascii?Q?GwMTkpk8/gB8QB8Bic8dktmGB8qTK20L0ZIAN7MH+QAMvz6sSZ1M4UDoPqBi?=
 =?us-ascii?Q?uU4XFVqgJRnF2x2Npk0z/ZnPA5fA5NIQwymdVVORUKFjfw/AQRyuf09g6WZz?=
 =?us-ascii?Q?KNqzj/LrS+lY2ly1B/VBLOIKOC+87wimHud9milnjPTNMK2HXIQl2R9t+ECL?=
 =?us-ascii?Q?cskIXp3OOrKsN5gAk/9yCES5EwIO9cbEn09tAeh6izeOzWQ+wK/7Fl3gtqOg?=
 =?us-ascii?Q?s6FWGoS7hlfWNbdzNUDMke9ywGhHAJq2192sfNZpbMvDzGM5HAffN6PKvrp/?=
 =?us-ascii?Q?RCtcyZ2JJbuiXIj50JNQSsn0kGrPPUQ7RQtkzOFy4rBoZgOziINY84koH7Kz?=
 =?us-ascii?Q?JpycbvgcSnImBdvRqBlzjC+89e2ADPixre3/tAyPVY4sARbKidDWrZIu/iRB?=
 =?us-ascii?Q?Zc4WfkmlYRaELdbIhnc4XIYek6Ms1rbCrV78dofrDbX1UmBJk7QoqILKnTZc?=
 =?us-ascii?Q?wTi1SxZOXyhcFIFZUJxEEJ1A3b/buECB3ycruNZWPqvDvHdOXouovPoFf4+L?=
 =?us-ascii?Q?n5i1cI3xKni3x3pBsnq5epge9vwFMN9goIEhNFOK2+sVSVrz4kb8B6b5Ml4e?=
 =?us-ascii?Q?xk/N15Sz7ulKaGn9u2BGnZkrYDCFm4pcbDTuh8FtELFsK3NSlqcQ8TzmMQ1S?=
 =?us-ascii?Q?VC+R0SmEEo3rC3wNtkU+7TPYBwtm/QGpWIj4UhZeTZsDkyoKzC/R4NTrPcSr?=
 =?us-ascii?Q?EmCwzCMmT/xVxJGSXxFfz4D90PdAcvjKg2FLN4EGLeeXc+QJiP/4GG62x0BN?=
 =?us-ascii?Q?lTTWAy3bAr0C+IpI1laxXRe2hFuvs1fKFUsYfDPOYvzptsDsFnpiFfvSKdsz?=
 =?us-ascii?Q?ozPWMwVvMrW4pshe8Js8EtKsrLQJB/mYXQKY7zEwfHOA0S0kN0hoAnt4RnWl?=
 =?us-ascii?Q?av7mlh/cBjEhIggAgrtnO0nP8YgbXq7PovL3xV7fT/RbWbSnDrMNLvTa9kRQ?=
 =?us-ascii?Q?OQqv1kwgNRcmWdxSJG7m38X2rn3aiNRyQsg6Jbzk/b2x3jkXkXglTBoeQn9c?=
 =?us-ascii?Q?VqrJeV3AlxX8FuZ7kFgb4hc+JvFlwoC85flNoO9SDXdqNDGACCW4AOxS0UPm?=
 =?us-ascii?Q?QEROZz4N58OXbkamo0/fR9wUImPELvlE7C6vJOP2HfP+KRl+e3FF5NcxdxPz?=
 =?us-ascii?Q?TsKwcaRzu3b9QLGM4MZkdzmRl0idQ2jmeO+aXl6RUStXkC9j5ZSINmDvK9Lt?=
 =?us-ascii?Q?NryuRjYmmfkj63Sz0nj0S/1JaFkTHaDNzO2sfMsFpoTPbHGLKjHW2Cz9lm2m?=
 =?us-ascii?Q?wZsyqpWfMzVuuSngtWuu/eY=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cb61563-7f64-4717-0a54-08d9e1d08f6f
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 20:06:52.6595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uS1cLZkDHDTfvvvNjpRjE5JU3SnJ/MiFPmsFG05H7vjcWpDkqWLDVruTOfKIB7nfgLrjaoNZOp5y+9oqBFyTTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB3747
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using a special property to determine the reference clock
period, use the rate of the reference clock. When we have a legacy
snps,ref-clock-period-ns property and no reference clock, use it
instead. Fractional clocks are not currently supported, and will be
dealt with in the next commit.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
Reviewed-by: Robert Hancock <robert.hancock@calian.com>
Tested-by: Robert Hancock <robert.hancock@calian.com>
---

Changes in v3:
- Define each variable on its own line

 drivers/usb/dwc3/core.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 699ab9abdc47..38fef5c74359 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -347,14 +347,24 @@ static void dwc3_frame_length_adjustment(struct dwc3 *dwc)
  */
 static void dwc3_ref_clk_period(struct dwc3 *dwc)
 {
+	unsigned long period;
+	unsigned long rate;
 	u32 reg;
 
-	if (dwc->ref_clk_per == 0)
+	if (dwc->ref_clk) {
+		rate = clk_get_rate(dwc->ref_clk);
+		if (!rate)
+			return;
+		period = NSEC_PER_SEC / rate;
+	} else if (dwc->ref_clk_per) {
+		period = dwc->ref_clk_per;
+	} else {
 		return;
+	}
 
 	reg = dwc3_readl(dwc->regs, DWC3_GUCTL);
 	reg &= ~DWC3_GUCTL_REFCLKPER_MASK;
-	reg |=  FIELD_PREP(DWC3_GUCTL_REFCLKPER_MASK, dwc->ref_clk_per);
+	reg |=  FIELD_PREP(DWC3_GUCTL_REFCLKPER_MASK, period);
 	dwc3_writel(dwc->regs, DWC3_GUCTL, reg);
 }
 
-- 
2.25.1

