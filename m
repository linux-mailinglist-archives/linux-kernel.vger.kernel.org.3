Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3061A47FACF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 08:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235578AbhL0Htm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 02:49:42 -0500
Received: from mail-eopbgr140080.outbound.protection.outlook.com ([40.107.14.80]:61409
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235509AbhL0Hti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 02:49:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QY3m+rlxlH0bM6yS7nqZk2eq350uFdpvoz5tHpH+iQjcTNvSgnqvY/nRY/OolnBuGmWzHdWA9ST+t3LJev9RZf3eF3kDJcjQ4E/wDIEwg2n/BWABRsdER1JczEquduY9AlsfJA01FCd4Kgi8bQgRqOMOSXSAB4jiJAELm70jf8zesu+HhKa+oKjUrwSwEN3x+nes68yEzFtfS6lNsi+bi6Px0lgQoKm6JNBTBLh0+kdBnoDMKn5kIWMfXGwbvz0JyN0khwOy+5M51BErmIH4aXUVq9uhsQ5J/oKXPEKej9nt71QfF49WMF4pfTXWOYmLoxS7za3BjRxlgG9xYbZI2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jifJsGARhkDNJRV0D8tgFfXyWzKoCMF4H61IelB15LE=;
 b=KR9K5B84u6EMuc/UOceXec0gnk4yaSoFoZ8k765wnUFQVzH7URv44Nj2nYNPaeDTCeaKwmd/14TejPG6DyLjaLfuto5pBT1NBW81XHbz8ZpnSwk2qfs/aS6I5zuiqlHYJVWPSvA7U7X/xuvfPYgKwKreU0r9V1XB9420AYA0vSYTytEE9IVo2bTlhNVaXQsfgw+sYa1JnCYPIirAOIECiSlntMPIZAybUpXhx/p1tfHbI8dDtzagSf/IYpc4kFXfJuErAQMwjAqjSUVuTIXJtMsol1+IHHQJFhigNiCMKA+835pyL7CjbvIZOJXPaAxLp4F+h9xKfqOdxOlB/gXF3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jifJsGARhkDNJRV0D8tgFfXyWzKoCMF4H61IelB15LE=;
 b=afhGDkK9wuZc5jIOLmcwgvsdN1WTzUm28MwZ6idWEaMheNvSEc+iV1AhjyhBx2Ci89iS181wHHOCf1l7uuOQZWYkqk80xrhko8KtOtjBKESYMAkr3oDvd2uaQmiAx3h0SfDaMXGs+9v6TuEhXuoa+MlcIEyrtpCEIbrmLjFWJpI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5631.eurprd04.prod.outlook.com (2603:10a6:803:dd::27)
 by VI1PR0402MB3904.eurprd04.prod.outlook.com (2603:10a6:803:17::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.21; Mon, 27 Dec
 2021 07:49:35 +0000
Received: from VI1PR04MB5631.eurprd04.prod.outlook.com
 ([fe80::90fe:b60a:94b5:c748]) by VI1PR04MB5631.eurprd04.prod.outlook.com
 ([fe80::90fe:b60a:94b5:c748%5]) with mapi id 15.20.4823.022; Mon, 27 Dec 2021
 07:49:35 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     conor.culhane@silvaco.com, alexandre.belloni@bootlin.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V5 8/8] i3c: master: svc: enable the interrupt in the enable ibi function
Date:   Mon, 27 Dec 2021 15:45:29 +0800
Message-Id: <20211227074529.1660398-9-xiaoning.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211227074529.1660398-1-xiaoning.wang@nxp.com>
References: <20211227074529.1660398-1-xiaoning.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0132.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::36) To VI1PR04MB5631.eurprd04.prod.outlook.com
 (2603:10a6:803:dd::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71f0d48c-a3df-4d44-2cb7-08d9c90d6d0f
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3904:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0402MB39046A020D832B3C009E26FEF3429@VI1PR0402MB3904.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HjZMmqsHR74a2K+IEsKGoaKKhyS5crjoBfwH3KcFEW9rk9QPuMxODBHEWbBxAJhzleKAk623hdvgmmA7qekZ+bjw1VMIGK1EgrEOdMyLzC+Ek0h7ehy1UQCSOOSG3eSLlw+L+8JowrxNWcYrEtRFUhyjNZZ7AmhYtDPuvZ4I7RcVBwkjO85BxhuJR+xkxiiqLYPQfwuGrxq7J5vPM/A8kTJfjkY9qZdNO3GGIUcBifMeWRC5rMawOitOHjbUmbVylFQ/etTDONbGE3ivPGzpoJOLc2Jt1PM7vRmRXz9XWbPSc0dYiFMd2V3i90/+/0D2+c43BAX1fV2ps1dvSCRF3htFijxSfZcW4+IjTDpwNHCZfaebaCiF+gTAUEgB3VUFEDvqO5tdZdYlmPkzyH+YU5Z40QzBdBoPzr/HzCnz6saQyzKrbRvehDee03o2XKVnmu8uQI8cqO+6eo5rb4AhYURVz4sAR3PuJZSd/tF6zXWSuzItBBJYLgz7ZrPuzEIZpc5POgspzulEeaPUKgeUImhbMA3ROZ+HWM8hxpUfpgeOw+aF5xiMxzd2zvZrJVDWyaup3EB2Vj6B8Ce7mh5Fs8//DfYHO8sKjVWPaQe+E/jrvlL5CWC+gFOrKiijas+EeY1BNYxbV0gYI2VxKZrIc3AXTNZeGk0kvoA1yyNPsd7bjZODaS2/NlCQUAAZhMNzrIbPJpFeo2bX6S9oI/ULBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5631.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(1076003)(186003)(86362001)(6486002)(83380400001)(38350700002)(316002)(508600001)(6916009)(2616005)(6512007)(66556008)(6666004)(66946007)(66476007)(26005)(36756003)(6506007)(2906002)(38100700002)(8936002)(8676002)(4326008)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3u95jlQHeQH9dZI/BoUE+fmI0HZW4Zb/nBCU5yraT0SlflqaF/FgZeKkFPpj?=
 =?us-ascii?Q?NtYpcShRk4UM16F+kJhYJCgRQ1jW8tD5tH+kiLOJB0TYd0C5P8MT8Bz59k5r?=
 =?us-ascii?Q?8C8qbKORYh29mOIlvVzEKhodBrvSrtRqU1NcU227O2d2s3efuKoTqvtORJcO?=
 =?us-ascii?Q?b8wNlgw3Ic6tyJS5BJT6REvZYGbX/t2n33vfKprTh3WR9D2zM+icdtsv1WsY?=
 =?us-ascii?Q?bXZ7AoXv8gGYMNhuVBo7IB4bg8IFy07+0QJFme/CtMMqMxslcu+j2IqZ8R3L?=
 =?us-ascii?Q?P7njO5DGptVxbSvMtArA57dlvUyzNKQYRjajb9934C51MtEW/U0m5k8mc9Wt?=
 =?us-ascii?Q?8QOwmNHaQyu3S5qPj9jROkOUtR0fOwGV8p5hsBigVUX0ntjD4AtHwdHfN5dy?=
 =?us-ascii?Q?iPyepbSMT1k9b3CqQPv3LhGQDvLNsSVA6Sc2MA2ge/2OzenDJSsh+iirKeOf?=
 =?us-ascii?Q?/hfOaYcMBaCPqsSQGEdNDB9ewi16p7OGZ8eXu7nkBP6pGtkXPNfKNUJH+1aq?=
 =?us-ascii?Q?SDoxkPFWlDlalbNLnOg196zMGtzfAkE1l0bbQ3NQOT9hR6PtMkvIWyK/aaVM?=
 =?us-ascii?Q?+1EDveX0DjJ053c7AlYm9+DvLlv+4kLSrL31R8vDFnJRm5sDEsf9WIJw/qTM?=
 =?us-ascii?Q?d0dnuxqINu6bCxM7IbngC+UPKMdGEsYZgMVCQX9AfGTl1KkH1sFN4r5j+jP/?=
 =?us-ascii?Q?UAh9G5Jq4FqOh5sZ8Mz0r+kJeTlkPoaCxUN1+Lw7LEmx3uyLjBWFB91ve3hI?=
 =?us-ascii?Q?HlbFCKGyTLl9vKjmZvc0R59C7Ej4pzxAICFPHDtGOpERL4NGiEviMB5wsLf6?=
 =?us-ascii?Q?LsiA0J9C1LX/DGkDQ9nzk9bsYVOJ6l9a/pMJXrTCxDBqrdIkuZYRV73sVUHk?=
 =?us-ascii?Q?SA9hC/fiHGs8lUoZHJ1MUrURnlTLwQxyYhwK0CKFzX81MWtBrv/LewkxrJaC?=
 =?us-ascii?Q?CPS4C7FZqW+Uqbn5joMEI0Djdi9bj5UjmQnekz4nMQfKG7G+rowv1ZQNHd++?=
 =?us-ascii?Q?gxGFZrPtb1L9dYWd+aXrbkdjb0/jpCGV8nM9N+j1of9+Z+GDpCVu1+hdTg6/?=
 =?us-ascii?Q?yW6mTGAhtVF3L5Y/0aUxdkoQQ0EeOAmGuVsu7d4XwCx6B+R3VW5PCyGl+xEN?=
 =?us-ascii?Q?dKcCvdvEFOX1G0tSANxlZKUwpNJ2t844LbeH4g8TyAR94cFxHjuLqgZwU3sc?=
 =?us-ascii?Q?RiGLL5ApUMDn38ByqT4aA+xAeClwzAD4EAeKAg4hRRlFo7RXHmNqsaZVSNwD?=
 =?us-ascii?Q?RX9GaTcEQRgZN8LzlsjAZlFwOiRj0wyYglV5mUfl0hPu9ZwTaZj2dpDf6kpP?=
 =?us-ascii?Q?InEqtSSFY1orbKHX/WCCWLDTJ756389KzmjiRJsqCp6LEa7HvEEvgtj0qZIP?=
 =?us-ascii?Q?bl8Ltsdu3JPgM+EvJtz+vdOqMY391i7NmYGP3zZD/TchLGPi3f8YCmwX+zz4?=
 =?us-ascii?Q?jRkbcxemeBmpupYvUNw5ZYMIgWZ3Rn0ZwF35ZKForuAM4ncJiwLiXcrZvm9j?=
 =?us-ascii?Q?RrzkTExPfYOGghSnTqLPF0qd6Y+qttQo/0KldxHDxVxOO7zqUiaKFUiQVjpm?=
 =?us-ascii?Q?Hf4u+htPW3joc1aD0YIRKTFALKgRloQ7DBCcqqzxhWkeHqrjdhWRbMEpu/pO?=
 =?us-ascii?Q?0Ce8At2IdcKkk66FkGNS6S4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71f0d48c-a3df-4d44-2cb7-08d9c90d6d0f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5631.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2021 07:49:35.2823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ynttRGRXNr05UAbtHdL13Sgg9RcEAqtRk0qrVGluLU4O7dH09F0GWSKBUxNHL1p0lE8Wd2YYWBAdqbJffkZiEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3904
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If enable interrupt in the svc_i3c_master_bus_init() but do not call
enable ibi in the device driver, it will cause a kernel dump in the
svc_i3c_master_handle_ibi() when a slave start occurs on the i3c bus,
because the data->ibi_pool is not initialized.
So only enable the interrupt in svc_i3c_master_enable_ibi() function.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
V5:
 - Yes, it actually happened when I try the lsmdo6d sensor's ibi function.
 - add Miquel's reviewed tag
---
 drivers/i3c/master/svc-i3c-master.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 3bc81ef95334..7550dad64ecf 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -569,8 +569,6 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
 	if (ret)
 		goto rpm_out;
 
-	svc_i3c_master_enable_interrupts(master, SVC_I3C_MINT_SLVSTART);
-
 rpm_out:
 	pm_runtime_mark_last_busy(master->dev);
 	pm_runtime_put_autosuspend(master->dev);
@@ -1400,6 +1398,8 @@ static int svc_i3c_master_enable_ibi(struct i3c_dev_desc *dev)
 		return ret;
 	}
 
+	svc_i3c_master_enable_interrupts(master, SVC_I3C_MINT_SLVSTART);
+
 	return i3c_master_enec_locked(m, dev->info.dyn_addr, I3C_CCC_EVENT_SIR);
 }
 
@@ -1409,6 +1409,8 @@ static int svc_i3c_master_disable_ibi(struct i3c_dev_desc *dev)
 	struct svc_i3c_master *master = to_svc_i3c_master(m);
 	int ret;
 
+	svc_i3c_master_disable_interrupts(master);
+
 	ret = i3c_master_disec_locked(m, dev->info.dyn_addr, I3C_CCC_EVENT_SIR);
 
 	pm_runtime_mark_last_busy(master->dev);
-- 
2.25.1

