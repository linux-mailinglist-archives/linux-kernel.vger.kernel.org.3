Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B80344931D6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 01:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350503AbiASAZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 19:25:08 -0500
Received: from mail-eopbgr80059.outbound.protection.outlook.com ([40.107.8.59]:23461
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350444AbiASAZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 19:25:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y7gh8hL/vFaogHzoq9+7SmzATNVgWTDU5kXFv8aHArwvC0ilLf2x+y6hkCT4KOWAvxwjWvhX3pNgPyb4c77yOTBjWhSh1Uy0cCQpveOiebPUYUAG0FvnuDoRmcoWm6Ud79mLYByzQQCoI08KIBf1Ic7ofcbj9Mr3sORgV3x0RUu73kx9M10NUMiWWeME5YQwik+sdD5finPJM+/seoKTrv6RDNMqhNHRslRngruwkOV2m14QSnV1oWH+89ObGraD65mqp6lYbKaBX1gYAbVOr7230LFhZTJdoHritHdc3NxqiTNiIU4FqPzI7RQR8TkBF34jIl8705gyekd+G3+y7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QoG04zDC/PgCcp+9nUwNyJjCUUziUhCyFKJdNwmrwhg=;
 b=eRaM0Sqvp2JMtGbWN9FVcTvflcKmcf1a8hGWfXk1qYvIGi2Z24AmsUMiFW6ZhHdA7+oRLoYleCCcmVrkKp9B7CkZ77vNmYokOPBOpnLZOg5Czpu9IqZ0PLt1MTBlE09fFkf/QiLlwlEwW/XeGV2oVZyBcneE778zBGCykddpo3kegwSo1/nwV9eIe2saqIYUIatgpbeytp32unnVCJwyeL/djDItodH/Q8lRrsYVBVBX1EacKz1Gjgopn4t6kHVCupLQD6EyFF/YEjkZrkf7H1DUPzV478nMNnMMnKArZthDH9t/bIpBJB8i//gMYWNNIzh1wbvpb5t5MrHm3sXU2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QoG04zDC/PgCcp+9nUwNyJjCUUziUhCyFKJdNwmrwhg=;
 b=d5PvtazyItBCdwwup8rEbx4/yHUlfth6uJzxquQSTjL+H7KGuOsyt/VusoPspTku+YWpcht3IW0ql6Nf6jP5J54GWSKoHa/FZC6sDnegS0s9Qiz4172HTupO1oIDCb8Vscfsj/Uwf1v0YQ6g3G55NR8t4Hwg2VKaYHR0IBagYac+qt88Zjou0lTm8BAw6nUEXdhhuu9sKAzHQEAG933OaBpQmTLE0ekiyHeBTHoiH1J1dkRXONuWing8GoT5zoe+d8ElGqL7zMhzix2FTvAJYzAEFkfdsM/uTskEMEEP2z63tUmkxCBN6LgphjZ3AIOLHI6Z5uYiLe6vzKPPApFDjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by AM6PR03MB4373.eurprd03.prod.outlook.com (2603:10a6:20b:10::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Wed, 19 Jan
 2022 00:24:57 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::d47e:81b0:256:3005]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::d47e:81b0:256:3005%4]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 00:24:57 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Robert Hancock <robert.hancock@calian.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v2 3/7] usb: dwc3: Calculate REFCLKPER based on reference clock
Date:   Tue, 18 Jan 2022 19:24:33 -0500
Message-Id: <20220119002438.106079-4-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220119002438.106079-1-sean.anderson@seco.com>
References: <20220119002438.106079-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0025.prod.exchangelabs.com (2603:10b6:208:10c::38)
 To DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6dfba06b-bda3-4d5d-08c7-08d9dae21f0c
X-MS-TrafficTypeDiagnostic: AM6PR03MB4373:EE_
X-Microsoft-Antispam-PRVS: <AM6PR03MB437364FAFAE71271957E655696599@AM6PR03MB4373.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:655;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rSpBeDeHRCOEzU9iZVl4+7ADjENtzrS1g9GK0dMiCKF/7K8/U5HmndrgM3AepK9rvzlFl3HlWFCn5OWIGTRjEf9R3CB5hME2Wp866zfA/bVtzTUUBZhu+r41aqbCCs8ZgHIHemRIemkMIOlAQl+oni2aA6WSELXgQdk/qC0YswcZBd/ivH46MISJkcT+Tft2OI2Ug6PA2SR3Iv8lyu82KQU9HHBhCVZ0TNGoLcARxTBuPkYSaa53ghb1nkLj+AMc+K70D3ii51zopC73uPtRq3xxEseMQOmmcU56NsoCVlM/EvLm3tSfVg7Pe1oNwsuhikjmEssN/glFdf7FVdX3N8VgeMkRrLxuEeMRULJtY7PnsF0RTSw5lcpj6lh9IWYRCGAbuwhywIXcOfn0Qx8+fS9yQD9bX0DuFATrwvJBQiOJTsK6DVt3r4yqNRp86cZiE61axO9Xekot42NPu0GdoZrpq5CuIfErnvShmP5uIjlrTiTzkzQtpB7XX8xIJ7gYPo9JDRvHLjUi+pXyDjrP5c86tvxLh3iu+I4oYDY88tnE8HCCoo++J+XQGce/ojRBG7QsSQ8lD4xWH6itiS6pUVzQGaeawlT5qomR1TybYX95L5/bYoXNzG5MtWHYp+1ZzQ70CUv0uuarNDPk4JMopJgzeeIX4Y3N1/aoBLfRVXE9dwQ1mTXQqsgRvTOyowFSxmipTngHOr+xQ2MCSWko+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(107886003)(316002)(6666004)(5660300002)(186003)(4326008)(6512007)(44832011)(6486002)(6506007)(38100700002)(2616005)(1076003)(66556008)(38350700002)(52116002)(54906003)(66946007)(8936002)(508600001)(2906002)(83380400001)(36756003)(26005)(8676002)(66476007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EwKc/4ifuQV0Ks51L3IYTD2O+TA7aQlye01eXVvnmw4ASx7yBn1H/sHG7XYW?=
 =?us-ascii?Q?I6zhnbYiuagygfBnJdVjxN0z7dEh+1f4Abg9fey/8aJt7xObiDpyNGMo83Ji?=
 =?us-ascii?Q?gxL2RZtKrs1TdnysG7Z8+AMtyET2FDC1HhPjWtSasBPgRd5rkHX9Er6oquKv?=
 =?us-ascii?Q?NMYtvKkYbM/vvvJdm49GGMLRiW+lm76kdEloPI27Hmg1yuambH5ks4zNtTXf?=
 =?us-ascii?Q?r3SxMj/StX8NC/Jj+ATuv09OYpwNDAkgu7D2XPdXSPsIk0sewDL0LHLwcVEc?=
 =?us-ascii?Q?gU7b8EZgAEDmBUaRwqqvUNnK3Vayx4HsnUlGao+Krz9J6Z430Hv+PM9q4qlr?=
 =?us-ascii?Q?NzPOyRgiOck5jwKSvcO3eoputEm+Bg9xihON0FxvvyKP4pQy24nv4IihNYbt?=
 =?us-ascii?Q?Bbj/Jv/5xtPQp+JvLJHmDYXQRowLdnTk0z6UiTIllbg3d6FSzSwxr4crnbXM?=
 =?us-ascii?Q?xsY8XMqxuVKKVVW+m8QFbUXAW4dOkNFgs4iZO32k3ryUCqw6FWFEPogAy5hp?=
 =?us-ascii?Q?wMJprkbGxH+WdbhEpzIHKNMx+myF0TZ1ajeBATjvLm8s35gMJ8GzDMY0P+Uf?=
 =?us-ascii?Q?vF1vkdncVDSF38KY3fuyT/8yX/CEazN5+AC3zqB6SmJaS7fzaLkpjEG0hQAa?=
 =?us-ascii?Q?R7bFpu+7KvJ9EshLOnBi7FYwodA3yfELe/MZMbhX2QDv5I1Z7/3RRbhdSG/F?=
 =?us-ascii?Q?WMOQJxh7yG96F9HMEKfrgXR1wRYtBu4/DPqGJRN8as0i9W4uCgDInwcUOjzn?=
 =?us-ascii?Q?TGJ0lnM+tu+X2G7JZOZco4MHnMtndvn2hqJqYHEGbfbRRb/8XXLd6DAwN8pi?=
 =?us-ascii?Q?TnDRGmeQquUG8pkf8PJTKjqPXjr/we9CgX1iXvG11jW9JHFfDBL85X3K4gH7?=
 =?us-ascii?Q?w/6eoBPJ75kYuYRTsHzAGNoE8sW7SyW2NPAwUOKRCQOwGzwnL5O6dZvQrNxR?=
 =?us-ascii?Q?7c1MADaxQzO4qRTQs7bbNetmHIU9frNWPx+71wqUwAmSqNdA6g2P50XzKpkX?=
 =?us-ascii?Q?OfXaUval/DhZ9oyZX93ByHuulKIw42zwqbi1i+H0jLE7DlUD430ziMuK0iid?=
 =?us-ascii?Q?S+fakJ7ApVcZpBcry7M/NWiR9e25TFaHkJt5pkSRYMU4YzS+fepLZY4f063j?=
 =?us-ascii?Q?DBCEFSrpEs5CqiC9TlUDLXsnp5ehrD4Pati0Fr4laiUtGhgj0qYcdPOWdYfU?=
 =?us-ascii?Q?KDLiUAUc7KLn8KcYnlr6XVYFS/gt9XnxPx5/OUOGDhq6Xnaq191QuCRxhT0d?=
 =?us-ascii?Q?i3TIDfbjUvViw62TpZiWcXsLoFS7CLKiP1EhvCWNK/gNw4KV25pBby127eEc?=
 =?us-ascii?Q?o9SbS0eBmfHk8tZV4BXx8Fcpjw7zuEex6SGOx8DznJKTsG3KGMpwISlPcCsf?=
 =?us-ascii?Q?GKn4Xb0awAq5ND9BV+ySdwfNeCFjfT1wSEJBtrBvoZjOqja0PA3vF+ke68p0?=
 =?us-ascii?Q?bcyyfmmc9pVZQ/luBDryfrgWwDV6BDaJL4lZ+AJxIkzeTqLBewLBXNFcJpkf?=
 =?us-ascii?Q?1OLZ3o0c9+wyHt+JDWGaQL4b2nDcrTCoCtc8WUXHW+sHERPGyLPa9xyb/7MR?=
 =?us-ascii?Q?fJTY3BopLC1cBtxbtkXfUwcoa7kF3i2LvAkZsoYPxnJDvFcksf3uhLM+F6Y2?=
 =?us-ascii?Q?0yQpTSvpSJMd77yhGkN5u58=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dfba06b-bda3-4d5d-08c7-08d9dae21f0c
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 00:24:57.0950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oSiOWwVK6m1C6m7X3dLFLGhrWNSSPjaG1TXc5HH2t9gaz6mC4IO9P/8i8jKTPQg9Rh08Fl/ciu0uOM1+2162uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4373
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using a special property to determine the reference clock
period, use the rate of the reference clock. When we have a legacy
snps,ref-clock-period-ns property and no reference clock, use it
instead. Fractional clocks are not currently supported, and will be
dealt with in the next commit.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

(no changes since v1)

 drivers/usb/dwc3/core.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 699ab9abdc47..5214daceda86 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -348,13 +348,22 @@ static void dwc3_frame_length_adjustment(struct dwc3 *dwc)
 static void dwc3_ref_clk_period(struct dwc3 *dwc)
 {
 	u32 reg;
+	unsigned long rate, period;
 
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

