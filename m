Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2327B50E6B3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243840AbiDYRSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243929AbiDYRRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:17:44 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20047.outbound.protection.outlook.com [40.107.2.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D4C19C09;
        Mon, 25 Apr 2022 10:14:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KY7kkkQ3zFkrwMGOipueLyFvLPQ0ASWcJV/4AoH//MX5Vndb9DNuEcyXCK30CqzVxFvR+pCuHhcjjYm2Basb9cHN4Ea0dHDIabrqjIU23HANmPsvhTabZiNuCJ+yX9yTfnwrkQSdli4VNYEytHkRA8ndVddha7f53lWWIC/8+Tv3OqlH+mWQVewqc2k+iP/t4iCYDGH/yx8hfBEFcgdymc+s0ZgEeuBjv1fSqQmZ2FNZMvdiLYXFna7D2U2G/Dh377pDsYOyl6kGVwfBpwcPNIU6TYiMv+CAAdUZmgge33JEw1MPT/FS0UWtaYMW/HAemOCqU0BpWk5uk2nSsZDlFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29qaSf0CDGEwAZXoKb/IWRI0rTzDvvVzN1TZyF7dYqI=;
 b=ZVvCG1FKPB6N/fVQ0oJKsCbYfnOXpiMRZdmUvae8cByU/xCXAOWQhkJCFMW2XW56doDVXdFbFNJRyPm99PCjDhdUbrXvDNmpLRbQ//yKGEQBWcnxpuGzdLf964v+PDB6Y6Dq3oWPt0rSzMpF4fiqYf2cf+AJ0jrUl3AEkkRUVUyWyTDfZBt3IEvinM4Okb6uJQ/n2q91XEpunqavh8MJf3+ZDIvlIhdzUQ6VUjRTBT8DjghP+fteqWldAQLtJ0CrxFSm2EPzkgP84dDM7PAJYoUds9vCxvJY5FEeH28gAoLkhncNm7LXTSwnOFLy+t6DhyFefCJ+BkVMqK2JmYTkkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29qaSf0CDGEwAZXoKb/IWRI0rTzDvvVzN1TZyF7dYqI=;
 b=viTDCQDG7rjClZxsxW1MzIiJzc0ZXR/hLd5dlfmC4F5H+ODMr1UNeYRKUOI7HgK5rhTX1J5xhph/XtY3ora7qCEETs2bD6Ur5+Wo7TKTdBqSkFj4Hz1fi5fpDTrDjUCD6U+P6v3iJZGbXg8GZ9HR9e4kysX58MXRFGBN0eN3g+/uGd/jBdFwRyoDR10WnNCd1OjzQdudge4KaKhogr8910A/8ebkRMa53yPteUAvAk+lOcvy/zgFCpybwnHQ9AlXfNU1zTA4WZ4F48IyNLFjX4dZp1g9BSH2050b5jpzyozRks6482TwQ+Kujdnrc/Etzd35Uf/jvtjqEhhdE5cB7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by AM6PR03MB3736.eurprd03.prod.outlook.com (2603:10a6:209:2d::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Mon, 25 Apr
 2022 17:14:38 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd%4]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 17:14:38 +0000
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
Subject: [PATCH v2 2/4] usb: phy: generic: Get the vbus supply
Date:   Mon, 25 Apr 2022 13:14:09 -0400
Message-Id: <20220425171412.1188485-3-sean.anderson@seco.com>
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
X-MS-Office365-Filtering-Correlation-Id: 851f8cc2-2b4e-4d8d-9ca0-08da26df13ca
X-MS-TrafficTypeDiagnostic: AM6PR03MB3736:EE_
X-Microsoft-Antispam-PRVS: <AM6PR03MB3736FB77E082259106FEB55D96F89@AM6PR03MB3736.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hMviI2VeM0XDUiFVPCd4f/FFc/UwOPc/sBs+Jk96fwkJLaAMEITcEgHzxGLvA22RDoz5Aa8b2d8kNHFL7QJmP2h7pmr1GCt1RNUyML1um2OXAgrc7fCEn0O41JQ7Smivedy8NhyfNGIQF5FikGKD419JY9HnSxqw9QYLKkt91AKIfL/n3h3SVoc2ORIvGxy2EuZLruSI+hqifd2s/EW7GCPqDzSRfPmuNXqYj16pL9e6cUSo0WFKz8DMNQu3HadoaDO7+Oaf9KeAnnJNqzdYh6Bh+0OVUEQQ+GyjWDtD3t16qgPXMdZR28744SHLSIS6ipBQNe3UoRYCe7z/qtLQ8frsMtkH7xKUWwk1HjrEGOXKuVTm+7gupuVo2RkGa7gKqax0EKHO5E574pLS/aIsec8+mV6cnCCPYut8pJGQsfCuon01IYUuUEMpdPizjpJli+nS5gli4pfnUQPXhFVAZ17du/DUlilEfo/OAnxdrTMtM1GhySDHU4vQfTJFPLOcTOo3oPBFwc2JCQH659nNW+XTf1x79rS21r806MyGGAUlYqSqQZCEzDHxIhCbBliq+TNaH5iIYLC+ds1uzf8Lq1FlQqyPpc+guNF1yS1sAi6mckRXBTBDiIjRTHZq9F5XoBxCtSVSgUMmzIo4Rt1ilB+SuWAMZ+zVwSv0vashxnHkTyEnhlSJ8LBGYxGDyyGOtVYTNdJn1ICBNKW4/BDajCXavxv7s3tSJrVNAi5tRmJaMBjbrmoGz/So8BhvutXrlCmGKSOIsCifgAW4yacUWle8UcZMJQ5AvIy0BLCx5Tc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(107886003)(54906003)(38350700002)(38100700002)(6666004)(1076003)(186003)(26005)(2616005)(5660300002)(316002)(36756003)(44832011)(8676002)(66476007)(4326008)(66946007)(66556008)(8936002)(52116002)(86362001)(6512007)(2906002)(6506007)(508600001)(6486002)(41533002)(15583001)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nWJy5ZivvBUcdcDbgcCLLHBoZS+Ev75O1U/fb+yxlRNsI4pbFoiJ2qMz6H54?=
 =?us-ascii?Q?chNcepSUvn6CVPC55rQuJZtIaYcrdLNAoM+bnao6BzaEKGWUKuvWdoZR4ZzB?=
 =?us-ascii?Q?VHW9QNbd64G3A0RfEEISs/0ap/FdwgGkQ9oeuRNd4TxQyC4cecJ6OGjInNWm?=
 =?us-ascii?Q?PNxGWtl4l/Nh/ec/fb3KqmMSrnVBuEIMnvgMrjFKO0ule8wOXKOI380oiW1a?=
 =?us-ascii?Q?2K/to5JgpaZdTcx94plUtZscSpydav72baYl0+xEQuTwbbjaxPPMZgRIvFYl?=
 =?us-ascii?Q?KdMeMRTp0L3eU3s6sKqPoRtu+Z6V0Cc7Q9QDLAOt8YQCYjwsMrx0m3V47OPJ?=
 =?us-ascii?Q?WZFlzPws+Z1gFXfVe2UrVLXgQ2DRgfCZnWtBwCVUFgGJcUlRaK83kzfnwKDt?=
 =?us-ascii?Q?FpTXIM0uXJ7adXvE4HmU0TTlKJc5vvpv7KUTXbUsfGwt2M95U9rhjj34rJJQ?=
 =?us-ascii?Q?Zs6/4/BlzDrMDc8mXARlbzyM2zKbuZD/iP+ROKhhyoshhDHvPTmL1F31kaqP?=
 =?us-ascii?Q?otFYBJ2CAt25jNbjUhMU/PH3ykCgPhTQEuMkDXZYaniytzhGiuuDfjm864aC?=
 =?us-ascii?Q?GtNz8aJyIJupIb19z5jAYW/VFwxabVJqM1MthlKPAGA4PJnMyQbCA+YrbLLS?=
 =?us-ascii?Q?UqEHmTthyignWnlK5RHaCiKibtLYYMW5g7BMwSVDV4D+Y19fBZlTarr31NQu?=
 =?us-ascii?Q?/2v2/dS5QXoeKtWATirjtccfHFGfLAxXShwhFiGgitN411Kj0FKyJRJyGAxO?=
 =?us-ascii?Q?ZqKQ53FAc0NuheDhpmOx68vfb5KjSwUXt/xsFS7b5ezoPggg6dslpOmNcgNZ?=
 =?us-ascii?Q?DLIu2W1eMD4qNFykt0Bz+N2IT5CVuWbWB626Sm1Dvhlg4nbs/5lDV2Fk5+N+?=
 =?us-ascii?Q?ZyVFEn6u+pF/PiqZkMS4MrnVUfanjqQeS+iHczw0LqbHWdLPmVojSgwlKB3S?=
 =?us-ascii?Q?hjvzV75AuaWzOkvfLqjB8wMjEabuiBmQ52vFG1iR5bLTKG3dUc4hvIuW7Efj?=
 =?us-ascii?Q?pgTat7KcOknj+AdQQwQXCdHk8NO2G6IJDqTROqbTlk6J/WFtdT6pLLRAhpBS?=
 =?us-ascii?Q?PLcEgInzvAd9l/p7E9IAes1ttHSaeZ8ZJdqWiVeypzfd+0mgTa7IwHAaSmWA?=
 =?us-ascii?Q?rJMIUUsCVy7CQustspD7GStnqDsxSvTgHR5kTw0z+L2RktYGvq0ayGSFnwZp?=
 =?us-ascii?Q?Amd5eL8q6zXxW2WO5Ix28AXQ8NHnsfeKYjOwBzIAyyXKhAKFRqzqVJ5E5NJb?=
 =?us-ascii?Q?BjXH6hi9DedeOWHiPTI0Z4SJYJWALj2Mb+fwhfaRwR/IMywl/8FI0bYlQIPK?=
 =?us-ascii?Q?BT800bPvjW8xVqGm41liyQxY5o1wEYEwmDacNb8On745ICQYAPLuyQzrZxkd?=
 =?us-ascii?Q?kYCeLb3oWWqucb0OA0UPjaV4guaAxq88p/z5xDmL5arzioBdbD7EVYGHAzwZ?=
 =?us-ascii?Q?x4wIst7LaAeKXQxj2CQqRHNRuI9BJ1zlkyQtaNKLV+W/KoQaQburmV3xKGOr?=
 =?us-ascii?Q?qqdeqIDUbYrj1iXZzgfi2jeGBpOE7JrLHIkn44GlKzskLRa5N23gCg8BHZ2C?=
 =?us-ascii?Q?SNhfNpy4Ye7YHq2zDrNxNe8h/Gu/Ek43ktYhGQn9xU727KueCTCHKYza29lj?=
 =?us-ascii?Q?y4kZ2WUjQQaBi5rI6uhbK+CG2TMuLFtYz1cCxX1JPaXkTMfkTRJEsmzfW+Rq?=
 =?us-ascii?Q?xiLKJN2TTjVu0b+/i0XYydRKtvH7CDCESTTbA5DvVjW47ZMx47R93JWTYiTA?=
 =?us-ascii?Q?rBUgyaGnYgzBJdiuPllRT4JCFyk2VYg=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 851f8cc2-2b4e-4d8d-9ca0-08da26df13ca
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 17:14:38.0610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V8d7zdRE3xCyXCe/sgUUwsqtNZ4BvhpibKSR/MIBJS8/iqU1j4McqiVcyyYOAi/l/lxXe05bgmA0E4ngS+Sv4w==
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

While support for working with a vbus was added, the regulator was never
actually gotten (despite what was documented). Fix this by actually
getting the supply from the device tree.

Fixes: 7acc9973e3c4 ("usb: phy: generic: add vbus support")
Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

(no changes since v1)

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
2.35.1.1320.gc452695387.dirty

