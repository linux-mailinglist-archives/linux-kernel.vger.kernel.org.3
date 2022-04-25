Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0E250E6AB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243771AbiDYRSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243793AbiDYRRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:17:47 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20067.outbound.protection.outlook.com [40.107.2.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99971A3A2;
        Mon, 25 Apr 2022 10:14:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lS4Lay10JYxf9zKDHJL14XHJZsfxg96MsaK7yDzHvT0ccoMgB5n55p6J4JrrmKi9QdWWK9dSFaLWvkwyDFPdrNhe8vnAy7D0skK7MM1QXNJ1Kh/WmTQr52iae7lYVYsW5DGG0J1WPREh364X7vvn9HQo7atoY4KHehg8mEqnEqsP9NfabnwsVq4ianPb6uzJ02bp1P6f6vTm916RbZ5Un7PKd9gvYwPG+fIYJuMDwpTG/MLbsCZ34ZWuAdMB3bMhkHLzj5VUyZnI31qzqSTkI3W/9Megxld0fwckXthuSSNZr3NnCjWFQjOHL5fVtclJ+SxdziaUjWVtALt7GfcYag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3yPmNJzrTkAY9MEvoPEVBhCsjl9W2F4ax4LoObojoA0=;
 b=KZuC7zvVvHwKvLJxVs5pzdofxchzqA4THjcApUZTXkZTfF7NU5r1/5bJy5e09zKGVl2vA6B+6zQxymgdhQEqUvmYSwslcyureqkTEJjoa2pj8MbXRxOO8V+3N9vaONkSVAGUN0KSmkn1sijKSB5s/u1XYH2Ikg9QirZCV4BOwXIfqZKDjqtCGfbeodesubwMHiPD3Sj/aqjBGKsGkZDoxJkOXukBnEHx1RXmBDtFJzpEpMditVugRXcpCerzVcOp0pJpwpXkyj2y8l9Y4Uib33tiMovenPoolS5qKYIqLHM5TQTdSVVOhG72IrS1waI4MNkk0ZwNB9dVVvGdA8OBsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3yPmNJzrTkAY9MEvoPEVBhCsjl9W2F4ax4LoObojoA0=;
 b=atxSsdgTuKi+mlsjAmEedKblVqKXIIFt+5BR0khkxi/gzlauQNbPvjHRuoI3h6SgamDghkNZsAalk1Mil2p37lLg34Z9vWItyBWhbxZQZZ3arRQUvwu4G61N+p0o0XoXITbsBILTHmeYJfG4Q59gEg2rxcsGzwCyCbM0980Oyga7js1N2gH+F8/xpwbFMDNLTd/E8N5HmXR8TLM0l9C1pWNAkLLnXFsprhm5onhrARmywVrEPsSGBJyKWTKbfYOr47NOowZORzLv4G8eK4JIlnz4VFTfRIpOaIebl+Ad3spEXFg5W05v9R//ci8E3U6Q+wF8LnQUEIwmy9D9gG3x6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by AM6PR03MB3736.eurprd03.prod.outlook.com (2603:10a6:209:2d::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Mon, 25 Apr
 2022 17:14:40 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd%4]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 17:14:40 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     Mike Looijmans <mike.looijmans@topic.nl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jules Maselbas <jmaselbas@kalray.eu>,
        Felipe Balbi <balbi@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v2 3/4] usb: phy: generic: Implement otg->set_vbus
Date:   Mon, 25 Apr 2022 13:14:10 -0400
Message-Id: <20220425171412.1188485-4-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
In-Reply-To: <20220425171412.1188485-1-sean.anderson@seco.com>
References: <20220425171412.1188485-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0133.namprd02.prod.outlook.com
 (2603:10b6:208:35::38) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c88f5fb3-e293-4aa9-e556-08da26df155f
X-MS-TrafficTypeDiagnostic: AM6PR03MB3736:EE_
X-Microsoft-Antispam-PRVS: <AM6PR03MB3736C9187C6C0B01AC6B077796F89@AM6PR03MB3736.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xWmjEytUAtXDmtGs2SciPOjHtrJe8y6Z+17/+mnTecpPBEVPmARsQAqqgZVQyfiDgS/t/0mkOOosjsKmikiCzBamJmtIyF0thNp8WonYLAD5ifPu2bxLq9K/Nx7+XLJ2UQHTkOOhuRm9nbA5FFfhRg6RRmLpOFJ2Q1qlloyELgUBS54irjfC0xbbYfzdTFtfJ7tWLuNZFzG7bUP5f4DvD3mweUkCRLxE623z1weHvFMz9VLW8LXrK0RnNwEm495iE/AnKsoTnzJ6ZvsvzIoEFwPBdrEKGFrKNCF/fgHEytNJ6MMqq70JK+I7CjF+H0sgz7Nl/5T+4nS+lZq/Skcq3oY9binAPYXjoydpOB5FfVl6DMIQqkOBW1cB9u4fLke3qkI9Vv3yRPq+TyFu+EtzFtFq8P9oWZY7SUdhTvxCyZWQVj0ZIZXPYV0kGMK2myz8mVMkJ3ZlkVR0Ch/c4K+dg9++VUa+vb7uOt1lMRZW/DY17m6J9YOgUM72lsYD2IHoMaKTcqY/12HaPjbRpaio8Y2JISMW/fGAwpcBIePhyULe1UW6Oh/pJZeM8tGhGn8rv3eHMmDXS3Eq3Z60/5rQjhVGK7tSNSI2uHX4DiCSQlrWWh5dMeMe93nvbwkAkigjFMaCr+AU8taGIYl2rPAOIzNtYJ6ACypxzHjlNBAIQ+0Rgeh06vwIv83VsQ+ddpNOZ/mDLrKdLAllhf3d5XuIWwJHO4lRUdB/QXGX4GS/WL7mEnF52fZ0OxTTYeihHnJTyRgZLohZeVAPCsCuwqPzlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(107886003)(54906003)(38350700002)(38100700002)(6666004)(1076003)(186003)(26005)(2616005)(5660300002)(316002)(36756003)(44832011)(8676002)(66476007)(4326008)(66946007)(66556008)(8936002)(52116002)(86362001)(6512007)(2906002)(6506007)(508600001)(83380400001)(6486002)(41533002)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AMeqOLPFQDHil03j7cKBvyTVJQXRa3X0zIZ6nZqBgdT/RznHAf6aMBh5wa00?=
 =?us-ascii?Q?ykod9tm/Nq0ZbjHnDEYWa7aw9LFAJ0S9XoqOKrs736gaih5awexlsMTwpnGx?=
 =?us-ascii?Q?6QshynqcWEuIJVYU81YYGkwlFAh2HDzeB2EdMKoF44MuXJdPocRNlFBqmg42?=
 =?us-ascii?Q?yldPz52BbcnsjVOvfJPU0Y5IB2z7weu6tAyXDPe1CtfOM3pI1FTh+u7mJutJ?=
 =?us-ascii?Q?gTxgOypoJzOq9EWxQPThCc/Y+UY2gWOLqsqeFOe2N3Pjzz84K0I9YcFZ6OIF?=
 =?us-ascii?Q?zoiwNx4oYR3W1e/MXaKYXvyRpQ3o44UndD05aYVKlH9Zny6VLFCScD77r7Vj?=
 =?us-ascii?Q?sQesktRZlfQT/lnxF32qdUSru2zWACs1ROJJlDfOmKzaCq0k9Zv/jkFO1HnA?=
 =?us-ascii?Q?MzqjIiB0zqFmi2wMXCtUhnvz6sbf0WaDwOSOXpHil2jIl6JEkXMPwwu1Vuio?=
 =?us-ascii?Q?FLNklAaRNVHFJAJgFn9C28ZQM9qHgsTi1iv3KQJKRnT187wEhzvGFw/4JJEQ?=
 =?us-ascii?Q?1K/BZq5+XXZGuXxwBCdT0uZgG8HOXzdI6CTGRYEFeHWvdeQbllDDNj0dmhxg?=
 =?us-ascii?Q?0mXtyrxQSev//GYaHrqa/QMog6hGiFMPKlNwDyYUWkqftYxo996bG6EtPz36?=
 =?us-ascii?Q?aWl4v7ArqX5VgLf+pQiMd6RzMgGZkx22PqJJdGgHVTDLblsfzKcRrx6ilfHm?=
 =?us-ascii?Q?eYYk79/28PSW6F+NY3goh0ypoFTRUc8ZFzBCy89GOYN5wGnWtt1uFOWnAZME?=
 =?us-ascii?Q?esMmfILVw1QTgm535AOBReVjb2PiJuwUQQK+tygbNVP0Dl+rxQVBfRRqRlZE?=
 =?us-ascii?Q?zcZPibePp9BCWNJ8dAGmaUKY7ORnPTsovBEANDl/hdkgcJSTpFiVee5fylor?=
 =?us-ascii?Q?s89GBztakpv72JPyukzwhhZ40FhSxlIoHeoSzbgukKP6N/Udzf2o1WJK9B4i?=
 =?us-ascii?Q?sr1fQqaUutmcTGuzAjMHFBESBIh8YhkL2jvNu1XCt5Lsoa/lPXtkb68ikDKq?=
 =?us-ascii?Q?ayhZA6+js3y7XkEHAkY8aaHQ16+cjZEg86lR9myIdLwyak4DuA4UvHOUjmjj?=
 =?us-ascii?Q?QbcqyA1CHMcSpXtlEPMX5hTcu1IjER3sI1EOvWLX7NQACsbATF9Yg7BUeywE?=
 =?us-ascii?Q?+73IXRFGAVSBjeWDypsTpXYTqg/K9VSGPYyGbnZwa+GJPg4A/6Tzoe8FGYNJ?=
 =?us-ascii?Q?0mQnNf3XQjRcOuqJDqzmteEk8oKueorLG4cUzaPUCZZwb5JcSc7hQl4OEj2J?=
 =?us-ascii?Q?5seSBotJZu5gq3yC2/SsRNff84ksULSPm8adoKL1mf1+WQhXc6sIcc7qZvOn?=
 =?us-ascii?Q?vnvY5D6Z08tPzVULzSy9Kw7P9jUj96trSKuSrvsRkQkrxLlYdyfvsmo1ngnY?=
 =?us-ascii?Q?FFEflHxfAw0o5FchGHvTRG2J+t0/H6LXFf36pPqnC4DAFPyW+rxGc9iR4eLk?=
 =?us-ascii?Q?F/hYmQOoi1thDEq6GB1h4ja1XadlTL6wod8t73Q9q+Ihk4v1vkO2Uk4+qKFh?=
 =?us-ascii?Q?oZj1tVJRXU7OSQhFpsCOakh8jrRzBAjgQafHSSRmWll3Q/v1fG0YZkbIcHbU?=
 =?us-ascii?Q?+pdbXPpiTeDPfRM6LlvwjtYaYL48MRMQEIVPgSbIOPbTlw5N5S4cisAGvFJn?=
 =?us-ascii?Q?Ooqe0cyUEI7oWQv3CB4lnjZyy5TffHO8SwD2uDIqkcmTQfcIT48dXQnvx3m/?=
 =?us-ascii?Q?AjltvPk4bUW7slWDuTX+5yBxIdvt7RqFUu3s//P1M4g3bFwvb4J7JDtrM7GZ?=
 =?us-ascii?Q?9nIpCqZgTx735fCGqRMIMd710EqOlI8=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c88f5fb3-e293-4aa9-e556-08da26df155f
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 17:14:40.5452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qUvSZjvYSzgZU+UGT5BmaEsGPcYI2kkFhdMkaIAviVjcPRqpzyH6FXZyXZmZcuZfmoslIC+LcMNzPRqA26Lv5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB3736
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

(no changes since v1)

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
2.35.1.1320.gc452695387.dirty

