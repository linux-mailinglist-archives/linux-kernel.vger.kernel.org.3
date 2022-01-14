Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502C648EF0B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 18:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243758AbiANRKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 12:10:00 -0500
Received: from mail-eopbgr130041.outbound.protection.outlook.com ([40.107.13.41]:64900
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243679AbiANRJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 12:09:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UysCIyCE76wi/IiBPBKJjtHuA7I9BnFLbBAWbYJxu4J9bzN5b2KuLx1E1O4RMmm3KXR7+oOjXrnsveUmt5R8t3755A6BiOmFMWBnCRVJy3NiwsHi7/cS5QSn+WM5rl7MqdFc+tatTOL/1bc0CGRJg+DozLNa+VIbLGDvprPXCD3ILOcpXm8TBoOEv1UzLV3XSJGzPO3kaF4sTD42CdqAjJ8rJSe15E4yTrY0oNY3aMvnyU8Skh0WcuuoRkBbibKqhyfGAGLYYF/dFadT/NN6xvzBfl9sM2DiQO4UoSmzKkjt63kyjlTtSIKakfHaJCmHCt31BBqdEabOlYQg7CTReA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKmlWWtHG2B6sYVNNa6rqujlUlEHmaeEspvMM1TLB94=;
 b=V3di6WvawPggapFTqQC2Ywk2wA7oEcLcM4VtU9TdwZx1jJukzjqh2dXob0hTkNsp94vueCJNiwvy+nVs7mfi0HS9u4W/SuCGs68ir7aqBTEWiJep5kEMR4Uol+kW/8gkY4FHlEzpLdSRgI3uQQrltHUnV/cupqSd6b4T2fxfX1nLnC0OUPiJfUL0CUlXnt5PZoZnfXmOOp2mn0QKV6AYzjeIXGpZwPInmN0sOd4lrYqqySgl9ipM6rSn8V0rQZGmZR7EurimaCMgRqHurqJ2lH9m0KdpQGQdTnhTeEl2ATC+UMPYfMzNM3uBolWAJ3P8ILmXqS/WR2XjV9QTEd/DvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKmlWWtHG2B6sYVNNa6rqujlUlEHmaeEspvMM1TLB94=;
 b=NTtQo1HFPTSIUGg115ZsMblxi74df4otPY22gMqEOaXCqpX1dvZ5pYR09FkA1mXAbbaRMzpWNx5Q6LWKdWDXm33HI73/1jpfJIUK1Ss1aZmvJEW1x/r2Pipe/4eWxm0b5y5z1o4UgcqrCDRg5uWid/CS9H1Y5BHLINg2qNNR4TQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from AM0PR03MB4514.eurprd03.prod.outlook.com (2603:10a6:208:d0::10)
 by AM9PR03MB7742.eurprd03.prod.outlook.com (2603:10a6:20b:3dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 14 Jan
 2022 17:09:55 +0000
Received: from AM0PR03MB4514.eurprd03.prod.outlook.com
 ([fe80::6183:d478:82e7:bbe8]) by AM0PR03MB4514.eurprd03.prod.outlook.com
 ([fe80::6183:d478:82e7:bbe8%5]) with mapi id 15.20.4888.012; Fri, 14 Jan 2022
 17:09:55 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Felipe Balbi <balbi@kernel.org>, linux-kernel@vger.kernel.org,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH 2/4] usb: phy: generic: Get the vbus supply
Date:   Fri, 14 Jan 2022 12:09:39 -0500
Message-Id: <20220114170941.800068-3-sean.anderson@seco.com>
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
X-MS-Office365-Filtering-Correlation-Id: f46a1f22-f7f5-42a6-0b98-08d9d780afc3
X-MS-TrafficTypeDiagnostic: AM9PR03MB7742:EE_
X-Microsoft-Antispam-PRVS: <AM9PR03MB7742E2C4D56B891E746FA62996549@AM9PR03MB7742.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0B+T4tsJGFjl1BYzwCCexhjWbs56M1xmfgl8u/mWpn9Ha4fo4poOU0rS6Cgz+pBI13l62asRfjAAAjydxQ2J3ONwmGXDkuxPCBz+MW3MddEc9r4Qal+iD60ThylLM3rcHfH71WDPX3YzqUypYjm8cJqcMvXLmP6Rvtv5o34EdOlkSZ6k/JMQgzCzHTqpPnnKc6K1p3utbeQAlzd71+lAT+Mgmqv+7sSAvItTRWQmi+jJ+wUBGlYunnrUXmsHxsNMnjE9ke6Nke4gQU+B/iXK9F/Yl6hu9jgg4obcLmPzSqQ0WRUVt0TeCAEeMM9twuFtpABvd9dMVntqQVvnPtNwtPSIzEHe70hyCbbytbFdNe3OKy6v3xXv11W1Yg6Wr3q7x83XP/AnF7O33+xKtH3iEh0jD7tLG32edccP235RBn0DdHcXhljscFKTngWBKNhaSL3ubSJt37wbD2TGzeR2xlAuPOggfnZ0yzTS4Df38QuoRAfMcehRR9B/PpfD974iOEZGMOaCCukwPtCrxVBiaTyV45XaZUM7CdZC2GIPl4kRDMGoG7oeXmev/+KVQexXO6GHSV56VkP6tQJV5aR1OnSKwCJUfxITC9peVdx6JWxd+OOPP7iYIyz6HuJxjptKKAvM+JXVzoQ6+uKIY3zJ25TfwvTze4p4Ap6+OFREvM1B7go4YmhieI0eeYiLLZnHZwxD+OeQ25MlNXIjhRhyyUNJFSHDij+oWnG4UBgclLnXskXmeCYcOtwgv298P/2Yn1SgWTL6rFNvhDvJn/GC9gQGz/9khpd//IRXG6a/Vnw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR03MB4514.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(316002)(186003)(2906002)(107886003)(508600001)(26005)(5660300002)(1076003)(2616005)(38100700002)(38350700002)(6512007)(6486002)(4326008)(36756003)(66556008)(66476007)(8936002)(66946007)(6506007)(52116002)(6666004)(54906003)(8676002)(44832011)(41533002)(15583001)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J1ipoEB1cOnCIhFeahSk2bz+7i2egAPJXr72lK1gYsr5JqvWcNaL5pJ5Z8h+?=
 =?us-ascii?Q?7njoQezJB+z3Ju/2IW3dZKjOElaJlOzaDzquOFYU9kb7WciyweRPq+U5MfGS?=
 =?us-ascii?Q?VI4WqnXtp5teJrHP1RBRkW3XwPLi4pR0+ruYhP/gueuMVnPIl0o+ds+VrnXp?=
 =?us-ascii?Q?SrwUxFXmHcLev3jrVT3LRPKF3ZwHI4eCBQcVjiK/YAefVMFzmnL6eXSKf3pA?=
 =?us-ascii?Q?35WrrQn7b90iEvcQJbhkqrjqLKQniCx8p5/LrQowAuY001cZkn39zoZPK/7O?=
 =?us-ascii?Q?GvlIGBnkWum/XKXXZOwSLJZ5qNaeD8RpCnpXngLZ9ammSMa3DNlQkChftXRP?=
 =?us-ascii?Q?HpbUXfgJD2ob+zH4Kb6+aFthmrw1hR9AsaNo/4UMDX1MneW7tk1HGFrYzec0?=
 =?us-ascii?Q?c5bpyVxeK20ex+ihx3azdpUQkN9nOYm8teOGq3lZ4qVOpRGTe0QdPbXmkTDY?=
 =?us-ascii?Q?zIeLM2z7OK/28rxhBu3C9tswi3umsci7AeWF0GzABgDi2qfAzYLAP2fkoByX?=
 =?us-ascii?Q?HQ4QYiWM9CWRs5UQIiZSeXfh563KHuRLwjU1KO4EpeTPdwjO0lvYWiOADnnG?=
 =?us-ascii?Q?rVjbLNWUEN2qfD3a+i++OEDAtJ1+juTBvikcKCbQ/ihPnlf/ETE5zejlMFVr?=
 =?us-ascii?Q?pjdUFoxGhR/PDT+tCkyn9uKsAh6qI32myVV28K6jo0SoyHhegy2BPJN218/+?=
 =?us-ascii?Q?p+QTi5yvpv66Hp2jE1eQZ33sCt4ZFM8GqaU/CjHgj+KlZV8iUSnhQU3U4xcY?=
 =?us-ascii?Q?FeLtZrklhuZZZ1ZJZqPBTXTzrn1Gdb6d/ZzvSB1WZ7ivf3dwAdPq4CffrGxu?=
 =?us-ascii?Q?EP2pfqB3LOoXXXa09pXKaxMve06RBjqqrdY5hwcfULCQTKOeulMw98ZwPvJ2?=
 =?us-ascii?Q?31+o1aXrHQycPfDk0hcMxj9/F3Wnzj0dvFZZDDf2HybgV6FCT40TrhAS3XdH?=
 =?us-ascii?Q?clsSIN2RKyVzQlwnYphWmZVo5sOqBBb6XUHpicweV4SPjjw76Lb4Vmoh2pX+?=
 =?us-ascii?Q?c3oinRi2wRa0UsQqZrwYm4OEv+GD2jTmydvQpN7oVxTFLJ0uebQ5bUb63vy6?=
 =?us-ascii?Q?L1KpxPWXSST8OW/nK93RZEs3vJHr3t0yxCjWTCYRdQz1pjYKb8Y3Kcn2ALbx?=
 =?us-ascii?Q?Byik65d14O5dj9b7+HqgUe6A731DYIqTAL5cMaA4f3CpwGr9iygX6TnC7IoY?=
 =?us-ascii?Q?jZ6FBQdRKQ7iuBAPFJL6HITKjSIw5n0eaGDtv31Gx+Z0alU3fR0Gq9EeC6YY?=
 =?us-ascii?Q?5jX3gYp6Y0LvY5eDT4tnYr6hK+SVwcTNEblc0iQkAD2gR5GNJEcIEgc4SlX1?=
 =?us-ascii?Q?mm+CElyA8BkwO54EUYdzAsJT2d3lLI9ShC0IKnAWlrr5rDntJOoZxO3T9YXu?=
 =?us-ascii?Q?6YDqZqGxFOzZpl0VrTTM3Jn9IBW6729vqZpgo94zIc9TsoW0p2HajZ36nufY?=
 =?us-ascii?Q?ts1ssQg37C45Agg5mYmDcZJVhCV8XGju8LcDkB3HZ1SZjQ2tWSYcxJzrh6Bg?=
 =?us-ascii?Q?KJdYEwcVkG56214G98ftISByCUJzxeHp8koBAlIZsaRshxIRuDogTerJLe/U?=
 =?us-ascii?Q?vVa2kPLe2hwTjAs2NKRk4Gw4D5qfQY7Op6bDwUJ7N6lgfx+WrmCXiBk/JFQ4?=
 =?us-ascii?Q?reMXmok/raIV9jh6kUcRPVY=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f46a1f22-f7f5-42a6-0b98-08d9d780afc3
X-MS-Exchange-CrossTenant-AuthSource: AM0PR03MB4514.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 17:09:55.6091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GsdxCffauyYQ6Y/HIpUUay4A8o8Cs+ZcArqbPyBJFZRsyvWI/0rdRizsH/lPzuEY5VCSKSJ0AgFxnjT76QSJww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7742
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While support for working with a vbus was added, the regulator was never
actually gotten (despite what was documented). Fix this by actually
getting the supply from the device tree.

Fixes: 7acc9973e3c4 ("usb: phy: generic: add vbus support")
Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

 drivers/usb/phy/phy-generic.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/phy/phy-generic.c b/drivers/usb/phy/phy-generic.c
index 661a229c105d..34b9f8140187 100644
--- a/drivers/usb/phy/phy-generic.c
+++ b/drivers/usb/phy/phy-generic.c
@@ -268,6 +268,13 @@ int usb_phy_gen_create_phy(struct device *dev, struct usb_phy_generic *nop)
 			return -EPROBE_DEFER;
 	}
 
+	nop->vbus_draw = devm_regulator_get_exclusive(dev, "vbus");
+	if (PTR_ERR(nop->vbus_draw) == -ENODEV)
+		nop->vbus_draw = NULL;
+	if (IS_ERR(nop->vbus_draw))
+		return dev_err_probe(dev, PTR_ERR(nop->vbus_draw),
+				     "could not get vbus regulator\n");
+
 	nop->dev		= dev;
 	nop->phy.dev		= nop->dev;
 	nop->phy.label		= "nop-xceiv";
-- 
2.25.1

