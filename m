Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4ED48EF0D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 18:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243779AbiANRKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 12:10:08 -0500
Received: from mail-eopbgr130041.outbound.protection.outlook.com ([40.107.13.41]:64900
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243767AbiANRKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 12:10:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NwAgcYl9lqFjMyhe4bjXzVcTj7M7bJWAQxHFXGZkWyKWao+nHwF9U40XUkGDHNk58vEJcoiGCi0gluXdOhm8Mb3IRUX1XCoIMuy7L9Yr4EcvZgdbab4B6YkqttBfpKiFlS1wXW26fXdScsCbjFbdpiT24UnbiFWrxBVGuhlwh9ict6gyvdQPhxBGVoP7O9xkhpr0DVlHYgZYsL6eFo+XDaCr+5dWjqAonMcxaRRheFzwuLvho43NcNXcnBuMNUsBVAGS4VvgqqxPuYsHVLTqPhUg1y91Rl6dPpX+mHMKUF8eSg9l4ff+zG20d2FNHn+EVte3PtCHcfyyJ1Vn86tFXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2SOONQ4qU1CZT1hLzr7RWPQGgDZdVilFPaUTDKM1rY=;
 b=Y1f9Ngp/vMfAWof2Ayw0/f2IhlAIdzuLf4PLy5Pc/SVUpRR27QjDNt3iPLDPLqbfvdqdG0xGG5RQFsxCIuT3fx1A5rJHnyMrncNVQJkdLjquNxO1DTPwdWxSMR+cPyT6Ox7LP5zFItUVjjLyH9SBVkuxxeESpAf73/enqpXqNfTvzK5hnSF+S6jd9ZIExhWFjMIKF2uAcRifalllfIJd9jfIOnaSOEsdnCg65Sh5xfqb4VkGK16S2fzvwhS3vhtAE47sxz6hsf3OuGYTZQEIXcc2f6zn2nHA3zXUov77a3f/tcbRrw1NDg2quGV7dcn29bGP7swjHHuUBPY1yq5UAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2SOONQ4qU1CZT1hLzr7RWPQGgDZdVilFPaUTDKM1rY=;
 b=R31IC8DE1hxyfjcewLRnlHapjAPlUm4zXwnMopVTkvC672R7ooqjHBu17cR2lFwH6vhwrdfRMOu09uo7cTH8mP2h5LXicimQEGJahAkQZA6/RFO8QH027XtguAdz1MMXQMgUJy9e5mLGPAvxwfSeTm2+6e4jIrEexDVYUJIocpE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from AM0PR03MB4514.eurprd03.prod.outlook.com (2603:10a6:208:d0::10)
 by AM9PR03MB7742.eurprd03.prod.outlook.com (2603:10a6:20b:3dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 14 Jan
 2022 17:09:56 +0000
Received: from AM0PR03MB4514.eurprd03.prod.outlook.com
 ([fe80::6183:d478:82e7:bbe8]) by AM0PR03MB4514.eurprd03.prod.outlook.com
 ([fe80::6183:d478:82e7:bbe8%5]) with mapi id 15.20.4888.012; Fri, 14 Jan 2022
 17:09:56 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Felipe Balbi <balbi@kernel.org>, linux-kernel@vger.kernel.org,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH 3/4] usb: phy: generic: Implement otg->set_vbus
Date:   Fri, 14 Jan 2022 12:09:40 -0500
Message-Id: <20220114170941.800068-4-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220114170941.800068-1-sean.anderson@seco.com>
References: <20220114170941.800068-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0072.prod.exchangelabs.com
 (2603:10b6:208:25::49) To AM0PR03MB4514.eurprd03.prod.outlook.com
 (2603:10a6:208:d0::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65400021-1f2b-41f1-269e-08d9d780b084
X-MS-TrafficTypeDiagnostic: AM9PR03MB7742:EE_
X-Microsoft-Antispam-PRVS: <AM9PR03MB774278E13D7FB28E69C2BB5796549@AM9PR03MB7742.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XFgQCUoJ0Z0HajRqLIQsX74chB5ZHquU82y/ovtGKyQtP5k4UeYMa0Eeb38H2vFr12hQGR29TtefE4vR64eS+N8xabSRKI0T3LataPQKRLQkHtpBoUhaIfYC2d8wk19lj2+YCjFGyamQWtwOfawG6WOcMWwkvUmkk4BFcxDi5Vt8tGX2lefqINFRO0FlOJyFaoa/IXP9Zy9THASOH/RRnzV39aYDppgp2TkNqR9+2bgy7+YWsHkam5+o7hWaRvldh/zAVkNNki9GtuVTNxplm+MtweAJryjUHeFIgwmgmOA8oFOWAIrt22wocW48GKp9t1dA1Te7Cd2i7/vLTu3jqaCW2zIsauejhWbsXEh677YJPN+2XDc9sIBPKvWlCiAw8IKj6aOTLF0odCWcbTxGX+I/Zw6V+2+tn+CsJuSkWOfrSRdCgSXTe0ibEOrTyvETFwpw87sgeB1rDMf7lH31JuQRq4u4Zr8MBOwo5cNmbfWUtqiczCfISxR0OtbJ0FRlsibZsVVdSG2duF4Zh4GEgLg7qk1L82nUwtAKK3lSXulo3/0MLUySMt1t7PfqF4b+AMeuUs75zYmhcYzrL7VD1aTA5wyL+/fhdPb23VL9XG3h8FhcX1zxfI5IhYZYqxIISiXWZAJYgictU7d8QXdDSYpyP9fqqxjxKrFIJ4w3OZSuolO0p3O5lTsfUJDdumDyQLND0QwWmDlySDpQi1AeQ8p3NUKwkqQo/7sL5wF10LI5DMpEjRZjMt4zKsXl7sXj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR03MB4514.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(316002)(186003)(2906002)(107886003)(508600001)(26005)(5660300002)(1076003)(2616005)(38100700002)(38350700002)(6512007)(6486002)(4326008)(36756003)(83380400001)(66556008)(66476007)(8936002)(66946007)(6506007)(52116002)(6666004)(54906003)(8676002)(44832011)(41533002)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eqbISiizdYG6S+cAJbSM7oEMvM93C4tIKtZfxhKUOc1C0t4xP2w3sdYCns/0?=
 =?us-ascii?Q?ze+OKpu28AFG6tlj615Uc1VkSl8a4J2xoFjkEliFhloV5thnZz5WasmPhHUD?=
 =?us-ascii?Q?am8cV2X93FFhhjtKwXQcvCM99NQhKCJt26FxmxQpuY1fqfckXTtJD682ApH4?=
 =?us-ascii?Q?MyusBKFaXB9RgN6UNJZe/OdLXPegd6lmL3Qc7EjKkhyctbkaTgng9zUZ3U/C?=
 =?us-ascii?Q?MddXuPJhhcFZ9ozO/2YoQtJOgQIIxWEH6ABaMdPvdZ1YAl5o9tpSHrX4CaOJ?=
 =?us-ascii?Q?7czjLeIXQX4z17AfskW5iDQa4NRMUCZjPU0ucbzpmuQeynolbDltN1koA1Wz?=
 =?us-ascii?Q?5oUHiQyQdalIfp11/FptXNY3Dbuly47rAWz+DTvSNkdAUTUfFNVCfcaIekoK?=
 =?us-ascii?Q?uGL9bSLny2TzzJfLJT48+nbaJDZ5oflghNQZppPkP8QNleApsOd8aqQeumzZ?=
 =?us-ascii?Q?/OD/y8RoqjyJ38K5TWj4vEqSIP8vrkf0m+kAKnB7cQxh7ICSk2T1Bd5ZKMcd?=
 =?us-ascii?Q?lEK9pDD9kayf8ZqnQ/lR0OKC3UKaJMenobHY/UOpRjShNG1LM8Yv4hgtNTKi?=
 =?us-ascii?Q?qYAimlHBKetwVMOT6eOe1LLKHhrH8i8DCb9FR9NtzO4jO+uOBjvW56A7QiAW?=
 =?us-ascii?Q?WPMw4xgVPfB1D2Q9x7kEnLmgT1vCIyj5gezB7RYipvaLgJ3EA/ja5bYaxaSL?=
 =?us-ascii?Q?MVYbqOLu7x/6/Q1iFAFxPuDjGrIeKXzIs/hl9JVcIygHl7aP76Xqv8lnILAI?=
 =?us-ascii?Q?1EVjm2QCLa5+S7K40pDnlaLHnSgTkTCTI7ibxmjz+zbZCHA/eJKlpJEhQ8ro?=
 =?us-ascii?Q?3feY3UtIjoUbvcT+Yp+evJE2jxyy6fABaBNehJCvmxcts5e9pDLzwU3WZFOI?=
 =?us-ascii?Q?e0bQ2C2zTxpR+JbnyCQfy16DPSkmDsMmzIQUxj9tEg/ozId4UUb1/PmpV0C1?=
 =?us-ascii?Q?1x0SnRGFCOuqb9xfPmX7/n1I6somDR/2YVb8IccMvWA+MgeTodvfXm8u8kMl?=
 =?us-ascii?Q?2wh/wbnuqMwp8ndQXd94UcR/cxzb9ukbeUawAFTwoZ33wQfxAwuitAWwbRNC?=
 =?us-ascii?Q?3Llr8JjuONMjQYmmYxaVrtRIE5ZWX8tgepiTAfxIOQE2Zw14PimRVyo3rzMy?=
 =?us-ascii?Q?zl+f3cBoDGkOkn7q+BuJsfnBsRyCMydcDaWc1yROR2xKAJa4AbZOlRodIzlS?=
 =?us-ascii?Q?MRC0OrAI9WwHdcX6HqQ9wNpRKBf2fM9xZrwYQZ5UE0Wk4m53wPgE5tadYyn/?=
 =?us-ascii?Q?mRe54NC59Zbj6ps4h52cdlAVnlxt7GU7ebvbKvxj1g8kXZna1LOvpSuaZfDx?=
 =?us-ascii?Q?GdpZ9KBXc3p4YCuIef0vuvsf2e/YxJREFOMaUYJT096q6HYSOLKKOD/oZSsk?=
 =?us-ascii?Q?WY1l8VaFy7w3glOefGLcIlEtUq6Yupb8Cgbepj61mCto/6YuchgNT+fAfsRR?=
 =?us-ascii?Q?930QyHh1tivpbyGeHyzkR9cC3RNrn1Dcn8y8sDw0YHZvCXyfrB+hKmKh5hED?=
 =?us-ascii?Q?3gvSRfTRdnYuhZFmNuDPl5aBsYLrlSBouj67c22l7ft42xjD4GR9eaVMHEfe?=
 =?us-ascii?Q?RJLt5crrCl2RqcnpcpIzaLVGWkY7yGK2wulx6lpvsJ4CIJZw45GzwWWQnJwY?=
 =?us-ascii?Q?MVq34Ak78WJu4rGi545a9J4=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65400021-1f2b-41f1-269e-08d9d780b084
X-MS-Exchange-CrossTenant-AuthSource: AM0PR03MB4514.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 17:09:56.7965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sWq69Gi/mHHHunG5nvGtgXAe8Fvs6jWH4qmAOyx7iTR0/sAD8UriskNBnaug5ECRhsvAJrOC9EMrn2U9B2vNMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7742
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some USB controller drivers call otg_set_vbus when entering host or
device mode. Implement this callback so that VBUS can be turned on and
off automatically. This is especially useful when there is no property
for a VBUS supply in the controller's binding.

This results in a change in semantics of the vbus_draw regulator.
Whereas before it represented the VBUS supplied by an A-Device when we
acted as a B-Device, now it represents an internal VBUS source.
Accordingly, we no longer set the current limit or enable/disable the
bus from nop_gpio_vbus_thread. Because this supply was never initialized
before the previous commit, there should be no change in behavior.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

 drivers/usb/phy/phy-generic.c | 45 +++++++++++++----------------------
 1 file changed, 17 insertions(+), 28 deletions(-)

diff --git a/drivers/usb/phy/phy-generic.c b/drivers/usb/phy/phy-generic.c
index 34b9f8140187..2c2553bc9b54 100644
--- a/drivers/usb/phy/phy-generic.c
+++ b/drivers/usb/phy/phy-generic.c
@@ -68,33 +68,26 @@ static void nop_reset(struct usb_phy_generic *nop)
 }
 
 /* interface to regulator framework */
-static void nop_set_vbus_draw(struct usb_phy_generic *nop, unsigned mA)
+static int nop_set_vbus(struct usb_otg *otg, bool enable)
 {
-	struct regulator *vbus_draw = nop->vbus_draw;
-	int enabled;
-	int ret;
+	int ret = 0;
+	struct usb_phy_generic *nop = dev_get_drvdata(otg->usb_phy->dev);
 
-	if (!vbus_draw)
-		return;
+	if (!nop->vbus_draw)
+		return 0;
 
-	enabled = nop->vbus_draw_enabled;
-	if (mA) {
-		regulator_set_current_limit(vbus_draw, 0, 1000 * mA);
-		if (!enabled) {
-			ret = regulator_enable(vbus_draw);
-			if (ret < 0)
-				return;
-			nop->vbus_draw_enabled = 1;
-		}
-	} else {
-		if (enabled) {
-			ret = regulator_disable(vbus_draw);
-			if (ret < 0)
-				return;
-			nop->vbus_draw_enabled = 0;
-		}
+	if (enable && !nop->vbus_draw_enabled) {
+		ret = regulator_enable(nop->vbus_draw);
+		if (ret)
+			nop->vbus_draw_enabled = false;
+		else
+			nop->vbus_draw_enabled = true;
+
+	} else if (!enable && nop->vbus_draw_enabled) {
+		ret = regulator_disable(nop->vbus_draw);
+		nop->vbus_draw_enabled = false;
 	}
-	nop->mA = mA;
+	return ret;
 }
 
 
@@ -114,14 +107,9 @@ static irqreturn_t nop_gpio_vbus_thread(int irq, void *data)
 		otg->state = OTG_STATE_B_PERIPHERAL;
 		nop->phy.last_event = status;
 
-		/* drawing a "unit load" is *always* OK, except for OTG */
-		nop_set_vbus_draw(nop, 100);
-
 		atomic_notifier_call_chain(&nop->phy.notifier, status,
 					   otg->gadget);
 	} else {
-		nop_set_vbus_draw(nop, 0);
-
 		status = USB_EVENT_NONE;
 		otg->state = OTG_STATE_B_IDLE;
 		nop->phy.last_event = status;
@@ -285,6 +273,7 @@ int usb_phy_gen_create_phy(struct device *dev, struct usb_phy_generic *nop)
 	nop->phy.otg->usb_phy		= &nop->phy;
 	nop->phy.otg->set_host		= nop_set_host;
 	nop->phy.otg->set_peripheral	= nop_set_peripheral;
+	nop->phy.otg->set_vbus          = nop_set_vbus;
 
 	return 0;
 }
-- 
2.25.1

