Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4359F50E6A9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243862AbiDYRSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243846AbiDYRRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:17:55 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20056.outbound.protection.outlook.com [40.107.2.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4939D1C93E;
        Mon, 25 Apr 2022 10:14:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ruzuwb/EAunndwelvZ8HTPMqWjs0/+Ac5He49JJoT40pNFeZJpgoQk8UnAwRRkhHLNaqAsbS1Me0J7bcPciLxo3VunGbVHGkz10n1uoTpRzREiRwjF5H+yy2nps+iYerYdk1PWCr98Dp8WbQXpKJv3Q2w6vPnmqWMNouPjRoMnUOvGvegQk/u+2wGXkPYa25/fQ9/Fja/CJuK4FxHm/fplGXN/9/i1Cxe7CxdC58luQF5DswrJQTaIcmyjgLQt70kiHxWJ6k28Y5HDPE8px3ImPB9CN/hFPwYeEaaOtf5QRuWr5iVCR0mFA/9mJgp5vFKypanSC/5DFSa0PUDpco4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2e4MjTHsONdsSnuOk5kuskINOGvsPZUxHxr/imJY0oY=;
 b=I1sKCCzAlbtPcj0vvhKEWGa0NMxBSjqigjo5p5MV73JiQzpgMd+SFAmVPwzZwjLjHc6PlQ6CyWZxahjmH3tUiRREtuE8MMN2wJo5qjI6mC0AoQtH730ERr2SvohqZKWby9PGHZsqmVV1aCKA1l6J286fJTEgvrMk4u3C2e1u+Tt0SVTi/T2Hu1xIgZ+6TGixF37ED+ifTOo9FXad2NWn3ZJvQUj/f+NYQqMu4E2Di3Ael+OuvvnthEZ533A3aNLRA3vKWyxWK4dBUnQAOw8ia5W2Fm1jmW18bJble8fRlhlai0T9urMGlactauN1aw+6Iu2hPLeBdLFppef/g4cMIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2e4MjTHsONdsSnuOk5kuskINOGvsPZUxHxr/imJY0oY=;
 b=hsclYYI/gn4cq3bOwnNdsVupjV28UsNn5r1/2o838cJyYANaEA/7xzWpsOLtADT+Oew1G7ROPt9TBHG42p0bSAKp5N559Z5ppoyJssn82rMHapnWoWgfNx/nlOrxHwz03/L1eBBUqsVnt5dA7laEkgqKydRE16NERHlKhk2VhwLchUApzpUXV+muzR69va0AjZwjUUO6uQbXyZGapUKZ48NdInfBOpLCYAntOd/cXia/0yaKUQhgwryH+YghCxV8x+n/8o4WQaHYwWaYxW6qjNOo0J+Cr/OCBdN3fsix5IVfBNb5YKH1hLG571ODIuk35C4oVzRJrqJlkFDyfUcz9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by AM6PR03MB3736.eurprd03.prod.outlook.com (2603:10a6:209:2d::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Mon, 25 Apr
 2022 17:14:43 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd%4]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 17:14:43 +0000
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
Subject: [PATCH v2 4/4] usb: phy: generic: Disable vbus on removal
Date:   Mon, 25 Apr 2022 13:14:11 -0400
Message-Id: <20220425171412.1188485-5-sean.anderson@seco.com>
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
X-MS-Office365-Filtering-Correlation-Id: 984e2d7c-70a9-4f85-f0ba-08da26df1718
X-MS-TrafficTypeDiagnostic: AM6PR03MB3736:EE_
X-Microsoft-Antispam-PRVS: <AM6PR03MB37367E110245E59B980ED72096F89@AM6PR03MB3736.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 28h4qkAM9O14cFsiAwaqaz8PyWaKWwpMqQZIZ4mbPEdmBop80ocQ0YaVh5CTBpB//o8LIA6Ub5MrZ8DjqeI31O1LjUbo5o6UTfYwzKVh0ciXwTr9DOTAArSNaeq12QrxqBs2AgQiRz6w3DMRHMt8DeRcOCxwbMykOBvoz+gWm6e4t5vCylFhDzdAVHZdZztwLM8MudCum7Ls9GK9Ont79ZCCNiclVGnP3uONdmUn/hnyMVRQ4a77d71yvIOoxlTh2j4Q0LTDGGOpq3ksSfcWlxh5FwSCFpSTMJt97b5cFZbJVSgwHl8Tec4Ggobmbm1KoXfetdUi00eYN2jYnIbb0vyr5HnEnVIMA5wBDWHMdeQtpE1FyFe5XuQaNIxFEGb5ipaz+qO1zj7OiY7YZAC6VFGimxK0o6BZJYMnSochSoEmhiUzF9kxqU1vfqSJIgQqLQhvrGu0qT4f8Hth5ONThMJg5RZbz/DRY9CHvRRsnn5ts1I3SqEEKKaSfCqSZcDv8c1vgYvoeefYCN63gofxxGBgZz/U21cK9D2p78S9FjJp6fl5l2UZCutwXwlUB4Q5OcIJJV/d71ddtRVDXIkZANFGQBlFB8MjlIHpIN/udaHHpYjp5EYAU2diVNZO9+imFSE+I8f6K7BdHL+koFJHA3Wwk0uALUPWwXiRnHXnTVY7xbp7KEY2+UDdrWNFcKLzCeEwI3bSWJ+otMiy27NA+BmnVx3KOGlNkO/o4oIX4UX/S6FgPHEwrR/TA26xmexfdIEGPcN+zw/EZyy9cEg9Tw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(107886003)(54906003)(38350700002)(38100700002)(6666004)(4744005)(1076003)(186003)(26005)(2616005)(5660300002)(316002)(36756003)(44832011)(8676002)(66476007)(4326008)(66946007)(66556008)(8936002)(52116002)(86362001)(6512007)(2906002)(6506007)(508600001)(6486002)(41533002)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AIsnFE9uHb40Q4tKnr3kXkqs/l7oLNaCNFBVZ+ajH8BrH52YATQN+lVl8bDk?=
 =?us-ascii?Q?QiukZA40T60jPXpZOsskm0MaphI/9xZNJL2tGwv45qP7VAb5rlyX+AJ0k3m4?=
 =?us-ascii?Q?HnNguMvHwzkjwTXNqtTSWkDbQ2ZhVtcLugtOa8pWmzTMLhngrVYD5GsN4uEN?=
 =?us-ascii?Q?CLDsG6+kjFuqiItvhncdtXdIcXF+1zmW/RCCxlHAUgpl7syoWRFQUg4YVY+L?=
 =?us-ascii?Q?fC4mdqttSfS5nZWDA/20dGjf+D2lIl5777Z2uJCUzixqr6387QIVyajeFVb5?=
 =?us-ascii?Q?ML4FFU4guaO23pwDtjJOJKlZUV86wjNz6W+7Y2lda9lajate8Skpkwuxu+2j?=
 =?us-ascii?Q?4vgV9sQs5pdEljTb6T+S1spxWRmpfXuprFQfvaaqGyP72fd6B09tn0/5VXfl?=
 =?us-ascii?Q?wEinwGl6NyvuD1L5F96kEbXy+LBPWxz6m9sUFBIypZMgVkoNRcruTCNyYX6O?=
 =?us-ascii?Q?ZoJyi4U7D/0bLU6zydGHh3uFzwBpmQEgHzZfjq0UoLvwC+sx+PZHPh16h4qq?=
 =?us-ascii?Q?xxW2eUFTo+DxDXCgBt95VO35/50ZOlixet4jQ4RP97xMTKf1mO50ASKWIriF?=
 =?us-ascii?Q?ig/SE9Uh8V1jbqWN9RMEd0rEjbqP98I9ftbbU1eZi3ofJHPXLF3KcKOoeQv5?=
 =?us-ascii?Q?k3a6lA10mm3SyvoiCd+sUucSxJXxDGzcyg7X9Z52g2nkfcgZqBTX95sljWvK?=
 =?us-ascii?Q?SbPNxX4KL8Ay3t8fc+s9LGxHTV3LjO8JvSAcyYJbbARumCyOr8Ar7aYwoEG9?=
 =?us-ascii?Q?GLJltkjsVc5DO0TOo+PPmRymzFztSjBfflt5al5caZvb0Bna9pK9jdeAfCfI?=
 =?us-ascii?Q?LEsINMLJ8xXXPvoj1hYxtnjU4mUwEkTZWUfDxIfFW9fND1WuMZPivdXp7vtt?=
 =?us-ascii?Q?fwDWWUvxY7O2ggt20RGPshFtyEqgHptFPonIW+yMgtt9ni9pu/fd3oFyH7Uk?=
 =?us-ascii?Q?fJVeJ0Po1CjBtgVbNWaESod8OLpSVPCFv8gCTFsQohCsxVlqYa5fzeuNkc2j?=
 =?us-ascii?Q?YkMQ5Blr7306BMZfnoVqzh1HmKPguLjSiPvZ7Ml8CQOIvdNwJHOD+I182FM0?=
 =?us-ascii?Q?6nenwi8VHLBMSzmRBhqDMvuIdocDQNBXHr6Vj6mnhIKql7Sqq430CqqThwf1?=
 =?us-ascii?Q?3c9nblmYk6WEiPqZ0Jnhv1vtHHElsQKe4Yksp2aUAzsH4IQEEK1LTDcYyDlH?=
 =?us-ascii?Q?TAkXMC+DnJL16xeTiIZ/phuebqlhpSh2V5WOie3+yXmxv0+i9NNviwDzHChT?=
 =?us-ascii?Q?WC0vHChfS2FpmKMonPaiRRvAYmT+R4ZKKCTCNYONu7HAMa3GRrFbUFYOZ9sU?=
 =?us-ascii?Q?36fuvL5zAx8RnF1Ts0tD0LMvGebsDv8EixK6IX2PQXKksKsIh1U88mR/Rot3?=
 =?us-ascii?Q?DANhFSzCSH5VlrajAjk+N/CANvaWxANRbO5GoEGqiwKJiEeEEfpe0duy6KrG?=
 =?us-ascii?Q?/gk1LmUnyMhLqnJ6E74Ru3CcR1JKo1Oa6wKrZBYO9xXuzbn3iEew2bRmnqzb?=
 =?us-ascii?Q?iTCwO4EzPHydd1RlaGiNPX6NF4UXiwHRRzynHmoEBjXAeFV2xFU/NZL6wtW6?=
 =?us-ascii?Q?trTYRDWCRZSbGysdbveQYwEkP2odi6krTTkbs//KaRgyGg9IPyX8GsuQAS1O?=
 =?us-ascii?Q?r5KxZTdxM4WWvb7CNVwnZbDU9uGzfughD1ESq2XX3SzH177YTPTHIMd+lpLC?=
 =?us-ascii?Q?Su0l8oNvfY8XOcGZUhHQBbGzMdcY0VPemKoVdrvTwBNNVnVrz/yvffXWL+p8?=
 =?us-ascii?Q?g6JM+kzDGNAVFeD77TyFbZjJ7xbGegk=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 984e2d7c-70a9-4f85-f0ba-08da26df1718
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 17:14:43.7325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mHMO+0PN24TqyKGGgbx45rir4MovgX9mD9yiFsuE5UynNJ1PP8l05gzKlLlqQ5mP4T0/FysmK+Pk9B6HRfEsLA==
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

If we enabled vbus, we need to balance that with a disable.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

(no changes since v1)

 drivers/usb/phy/phy-generic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/phy/phy-generic.c b/drivers/usb/phy/phy-generic.c
index 2c2553bc9b54..9fc3312d614a 100644
--- a/drivers/usb/phy/phy-generic.c
+++ b/drivers/usb/phy/phy-generic.c
@@ -328,6 +328,9 @@ static int usb_phy_generic_remove(struct platform_device *pdev)
 
 	usb_remove_phy(&nop->phy);
 
+	if (nop->vbus_draw && nop->vbus_draw_enabled)
+		regulator_disable(nop->vbus_draw);
+
 	return 0;
 }
 
-- 
2.35.1.1320.gc452695387.dirty

