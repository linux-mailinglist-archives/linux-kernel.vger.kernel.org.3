Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFB748F318
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 00:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiANXjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 18:39:33 -0500
Received: from mail-am6eur05on2071.outbound.protection.outlook.com ([40.107.22.71]:20289
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230147AbiANXj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 18:39:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFQkuwJIZewt2EGEG3TUdcRAZFJ/ykRDnVXOZ2EnEIG7KN1Rb6Y1BUjpC561s0lEIYq6e2ZrMJn33yUrAUoV5waFL/sO9c/HkTDJlSzLMC0+cHWf9IyuDWfh+yQLUUIaq0s6tkywaZPVNMGoYxcg4XhnQ7qfFcJm+lEonH9aXYnu1ynXHHAuNfj3bqlhDmbiOtJiOxY3biMVPTDTB5vWxKk0k8WSINziKbPd8/JJ2HeUfxPq2lqmElyj6iWpnnfwt1p9nHXqwsDGeBnfKpVitklYhc20oMHIJ4O77ClNC8PEIlfHSGciLarewBEPHzuCBb43+wMuR8FWMCDT5bL+7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/LLMNIxV6X/5Gez8Mt39JB0bJ0z9XpMgyvmp5QQ37g=;
 b=F2OQ6P6DTijlIWDYYeeT8aoL3KN6HjeVwfjywttVEng3iM/GIHk2kp0r3G/lVSqrzQxA/mo4oybJb2ag5a1P2nq+nLXt/90TS0+pPRwpIjiaNt7Z/lST8Ifjpv0TvoLMEFIaRXthpmVZApxUtTDdAMM0EA6YfOWaNvorh+u04dQwG+zQj+9TsMRvIv/gqtLDhLQ1r0x4CwIGKalSpcGfNBwGsEjXKEQhBoJ754Vi0w9TliKqPX5UNkiMrFTuPPIAvPRPjiPGBCND4VsWaAE4TcB+2Teqz3QNbezxGEAUsy5wDsn3b6TY5kgZy1DFsrpIV6v60pFXp3n00lZ56cuzWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/LLMNIxV6X/5Gez8Mt39JB0bJ0z9XpMgyvmp5QQ37g=;
 b=i8AqYpS9/tG863oNNVOcrhV0R27M6BB0OD5JN1Kyt9e/XpRZ/Mw86J6F5DenlDl50TAWKWX6/NjliCTh8Sv6S5C29yAIOXUyqw3vvhmKgLXiofijQ2gBpnk5scRwfZ1ZwdKzSIIAVAPEuKy0HWdmPfgJUiMhbLxhDvKfOPwwkXE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by VI1PR03MB4336.eurprd03.prod.outlook.com (2603:10a6:803:5b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 14 Jan
 2022 23:39:24 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::d47e:81b0:256:3005]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::d47e:81b0:256:3005%4]) with mapi id 15.20.4888.012; Fri, 14 Jan 2022
 23:39:24 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Robert Hancock <robert.hancock@calian.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Felipe Balbi <balbi@kernel.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH 3/6] usb: dwc3: Calculate REFCLKPER based on reference clock
Date:   Fri, 14 Jan 2022 18:39:01 -0500
Message-Id: <20220114233904.907918-4-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220114233904.907918-1-sean.anderson@seco.com>
References: <20220114233904.907918-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR22CA0017.namprd22.prod.outlook.com
 (2603:10b6:208:238::22) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 738b4662-be89-45b5-8f6e-08d9d7b71835
X-MS-TrafficTypeDiagnostic: VI1PR03MB4336:EE_
X-Microsoft-Antispam-PRVS: <VI1PR03MB433643095B3C78FE5322552D96549@VI1PR03MB4336.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:655;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SbFzOpRoigsCLW9QBj0i4gDU4uDS5vRkbMT7BYSAK1zpQ9a+0gWp5xTbauJXcDJRjthzukG54gAS0MG3fD3yQOG1WNRe8/WjqethidF7jlvaO3j8epe+YqCj24meTzoFQbVdAl9ZYUaiXQzPwF9aqM4jtf619+EPSrgeyDkXP1tqb6c923UvOoEQ9F0I+7EfuHd+RIRQXwMJ6DdB/8Vl0VrKQ6cH7SuODuAodBzRYI5XiGAqJusQwUPVzFc7IUD5S39bZVx3/Cqivytz3M/3b51D+XE+tri27wwLUxLaNbDMPYm0CXGY8LFpkXJpsHijOW9d5ADCy6H9dtN0Yd0Jlcsw4waOXXHHZ9GUwQ2xesV1rT3N9+MFCbYLFOI9E9xMjzp6FU9MOiUo46fZbAn875Ha4V4GdB4Yu8+ndydh0LKmJ1mMpoBDDrAyEhH+JG7jxWk9dx1RxGeeifK6g4ckPEtX1MNvDCi2/aIkwNm5HI8JBvrfvGL1GqzqQnp+DZ2nu0FEapBz5uM3Om2K2sQfVz1hem4pe7O4i/HaX4NYDo2FOSVtU2J/ZT36aXCRBbb/yQ9+WFgAwdLeM6tIddaQdX3pxu4A6GEnMfkAguP6mnPoTAyV97wl8yCU5M1pmj5PotRMdV/YebSHjrNj6AR+Srw4vvUH4Y7dsqTbM+ygemGgoJAYLIOW2aAT9UP7dCOgbpXiQaei0cL/Adgi8pu6uA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(8676002)(6486002)(44832011)(54906003)(83380400001)(38350700002)(66476007)(52116002)(2616005)(66946007)(6506007)(86362001)(107886003)(38100700002)(186003)(6666004)(2906002)(36756003)(5660300002)(316002)(1076003)(508600001)(26005)(8936002)(4326008)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QQYuKZfleJOoBdZzTwXPGyKd9s+ZrBOBpk3KQ6x7iXpVhU5m06OZSiiXZ8F/?=
 =?us-ascii?Q?0kj+J+Jh7PKIWvkYGsNbb1RBMHp02dN8njsD9fzSvfx8MuHz7Ztj7FultHKf?=
 =?us-ascii?Q?gUvQVv9EYwkoVz6x+pIf+evXRS/1kfPhRFx3LkUuwjrh1/E3IBs9v3Zeuioo?=
 =?us-ascii?Q?mZyEVmwNNUYtq2pd3pHrHVvcGPbzwxDf18Bbgq9t5GYejva5eRl2/klCEhsy?=
 =?us-ascii?Q?/KromY5geNQTI5aRIP0uxRQv+hhD4G7Gk6plbGTM/vYunCIPMet3z/cGw/X4?=
 =?us-ascii?Q?QK6JT75NE5CucaWnTfsF97lLu/efMQ3QErNmnA3HZBsbRREQixETrXJ4/5XK?=
 =?us-ascii?Q?VkvceZDS6g4F/HahoS2K4zYAdm6ZkDcQJQ6A8SL7hnpfh1bMaL0WBEyP7Cbf?=
 =?us-ascii?Q?lQ4+pYmHdO7+umqIXH85/edFNBmbYwfrPnfuzdlOZ10euPwAG0cArDkVED2S?=
 =?us-ascii?Q?53za1gYbwCK1S3+9F7s+B2mbxeInPR+S+zwgIXEfyJ4dKo1E+CCcEG7fYo+P?=
 =?us-ascii?Q?Uq2JeljIuY/bAk8H3mFNUFCDthbUfOhHfFHN8Uo/bWl4dWneWqBsJpmN4PBE?=
 =?us-ascii?Q?vC8TK7UZhid2sD4hnTRkUECKC3dBcADFuh6PGRVg77EXUN0tnZgiQ0k2RD4I?=
 =?us-ascii?Q?HkQJ0dhnM2+hRtkY8yi2X1XLfsZkzbLzVrXBv0pdeTKhWk3c3IhdleLr2J/X?=
 =?us-ascii?Q?3pFMMFsOVLHfafizUFOpwGZhl7YSLfw5RZvkQF+FjXk1kjJn9Co7MINQ+c/f?=
 =?us-ascii?Q?7hhQoJCvCqSSvbXQ0g3puqJiZlaH521kzwJDckPE4cQ9QODjWeJs0FX5lG9p?=
 =?us-ascii?Q?i9klSbmBO/D08HYLsZwuOLKg93fI/hlmMdiWjRiFs2xi8HWULhnqylCuwH2x?=
 =?us-ascii?Q?NxroyCIqTsCLBKDdONcvRm0jjBqDHqildtG4IyHZkT3CgdjeCR4wLUW7UL9W?=
 =?us-ascii?Q?AYptB84QhTLaLL3UPOxBhBzWu1SzLTw9nAcA0s8cglDFQA6Xf7WYZsua3sLB?=
 =?us-ascii?Q?Nxt/LwZ8FC5BjEvH+1sChr/QuZt/qD2QQv5gTzmz1pVn3A7ykhG/LlijcnY2?=
 =?us-ascii?Q?HAd+7qH/Nv7hPzXrTmzJKctNeJD+8/QjKq29nG2u1Fqlu4XCmSBfak/ejgoL?=
 =?us-ascii?Q?swOX97JjVabece3JzrN4+lj9/6cd6z0zDy54OcekAR4Udm4wibaRXGbTvMDq?=
 =?us-ascii?Q?beBQx/cu9Y40+opf7YE9B3g1gsNknVnfXS9xCvuyzJn9i3FDVB6TcfDHylgJ?=
 =?us-ascii?Q?Y33syyayImV1U1u/FOkbmHVb7HYffekIRIWwQ4HXXXPrBznPGbAkYTC5qY3P?=
 =?us-ascii?Q?Z5ek+ey8a+lIs3d5I/Y7xj11LIpyK3Dz9iln18QjqofjPG2ySROAZnIiNNYA?=
 =?us-ascii?Q?PiqHbuC2OuwuBP8qMg5n9rrJo04cFglNuFI8Oykmq7l62bI4OojQraJkLokM?=
 =?us-ascii?Q?9cuikTiykEkq9YAze8wJt67qwb+SJhXbKvCSlv5OjJpu6Wh81fcB0DEe6G3q?=
 =?us-ascii?Q?ABCPiNOCFXQL40gTFeYlqburipCrZr2/Q91D5GHmqxiGiMu0o65/UALli/Pt?=
 =?us-ascii?Q?OyFubFblScPagJluDpRs2OZEE+/2xAtYWwqF8XpR5zGhC6VP34GaGEkawQIO?=
 =?us-ascii?Q?72txKs4naIQPPOpY2yC/9oo=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 738b4662-be89-45b5-8f6e-08d9d7b71835
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 23:39:24.6972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3QagXXdfAd6TCMZtEBhxGkpiZ5BtDAAIxxeolxm1FmJwbEipqaVwW4Jil4AVIfD7pK0uEREzcDwNbhDNWq2p8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB4336
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

