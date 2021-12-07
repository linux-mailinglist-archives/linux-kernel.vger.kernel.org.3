Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7128946BBF0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 13:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236642AbhLGNAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 08:00:25 -0500
Received: from mail-sgaapc01on2138.outbound.protection.outlook.com ([40.107.215.138]:20577
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232439AbhLGNAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 08:00:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FtAfQlYHAQ+cRmxnRRte/NOFT6DXFC4KzSnFfi95BX1Ucb9jAhxaTtRs43l1ulB90GanBhmwVkgGTQHGO47WYpOULhKHYhHl6xsPdSt54+3JiFQhUveNEt+m2Qx8DDEuuUxOYtAOPjCQeNpj0u9ZIBWhiQ0G12rMruUFXktyYnI/0oJhcRrt7rCjD2r/0cMV/QbWbS/knZfoSgI7g0J3iVf5ZBCqcyZchQPrR5XZFwipQM/79CJ8w4XM2J+JXKUd70jrRYclM/R7KFBplzmlM8xcx1M5RCaJrDuGChL4C2+w9X3vEa7p12eIDoqSHBBwJZUIcXdA1C0HAJraI97EIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkD76ZI66K2BN1Kq/jmCxl/5M6UlbHkZZ+7As4gDmP0=;
 b=Ac3b2UKlpznZ9siG9LgTTqeaw/kAcOBKu3q3+F9lpkIPOFt101iBFfzc3dd70GhdNAU9EEQNz/Tjcx7UU8a8IXL+xOlXtanXY0lKNaxKKmXmNOfvScz2/Rp7dm1Vi+jo4JoDZ8YqwCAanwUP0V4OXe6R+ekluOq5Pd2PHLN6CTXKkVeQv/Gx7I/hummDX+c6RfUxR2fHmp1pfg1WRQ74ZjuBvFdKiZ8FVP4YYDfhAwy55zHcDqTQjbrBZEYi/S/pQfnjRMizVGTPtkslKun0iUx0Awn3qyP+XxWjPp2EQcp5CWkYfwMDPRZuG/QiW20+0ct+b2qDZ7DhhUCdJARtog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkD76ZI66K2BN1Kq/jmCxl/5M6UlbHkZZ+7As4gDmP0=;
 b=WHVVTZMNelC/CrXzV6surhSEeHeKM49hphS2+dDRRq1XejIXgETBfbEufDWquJs6bjg34N0sAYul7TeqWlfkvwQWBbN/l1+dt8yU/yREdR9dje68fIX+hstHOKznxVPaY29UZyJDnywDhUgnq3CNZMtxSlThATPEe3RgOC37sHk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3388.apcprd06.prod.outlook.com (2603:1096:100:3c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Tue, 7 Dec
 2021 12:56:52 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::a0cf:a0e2:ee48:a396]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::a0cf:a0e2:ee48:a396%4]) with mapi id 15.20.4755.021; Tue, 7 Dec 2021
 12:56:51 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] usb: phy: add missing put_device() call in tegra_usb_phy_parse_pmc()
Date:   Tue,  7 Dec 2021 04:56:34 -0800
Message-Id: <1638881794-3361-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0058.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::22) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
Received: from ubuntu.localdomain (103.220.76.181) by HK0PR01CA0058.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4755.21 via Frontend Transport; Tue, 7 Dec 2021 12:56:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17683edf-3a41-4f13-fb6f-08d9b98109d9
X-MS-TrafficTypeDiagnostic: SL2PR06MB3388:EE_
X-Microsoft-Antispam-PRVS: <SL2PR06MB338892D985F8BBDF4C7FAA29BD6E9@SL2PR06MB3388.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 34ZZhYTCacFZ/mOjG4+15wdgnps34p+7+CPiJti5FxT+2A05GR+Z2z8rNeCwiG0e2HCNaEVKqARZIs5U2YRMgHpNB9VgtbSECddZ/gIGzxhUyYCj6/uec2npN5WaaFB+Vbn/OfFQcB8+m9EW35oTlK75hjdwM7qa8SJL7KxRGb52XgOcFex6R6GQVJQUv5/nJ77N+aN8pLHt+hsM/mKqGrvWrlyfTZ9MA+CFPYeT8dnZ20a+0zJoXiMcm2vtOR5jDTVrJ0XeethCTDcEoIpxjnzVNEtjD6He3AlIIvnOtYpL5S/+jYPQPNayjnfI1P2spLHJiwpmDjBDDVwlpzJwwdqBJ27CL1rh0Uf1MHTqebD0/cWLiTGdlDA7D8AISz1ry1Z4z/hC9GCebBx1ZVUF0a5HtG2IRdb5fkA+8hCC1Qk6t9Q6OKWaAQsIkBKb1iRIJWOaEPWqsm4Fbv2X4VeES3q8sl1VYj9BUpCJVj+nT2irPCQ1o3SHWD8TUZfMFgvcE22/rVFguANQga1Um1Wf6sPBtGAmVYWBp/MtObIgT43gpKhpW4hlQ1VGnmx+khAF2Kuy54z5SYdcIl1U6SWrGjD8Z0UkYdtSC4D3aCwGHh4C/N3viou2ypZ21ry/35pNqna3fGu91xzKocRiknD9DgsDR7zP3UB1w0ivoPK9wwUSzg+Ju6Sc+SJBwSXqQfLCHHaVEKB++5KeZgsyGiY3Sg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(186003)(956004)(36756003)(5660300002)(38350700002)(83380400001)(107886003)(8676002)(26005)(2616005)(4326008)(6666004)(316002)(6512007)(6506007)(66946007)(6486002)(508600001)(110136005)(66556008)(66476007)(52116002)(86362001)(2906002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pHRjGQxtv9narH7wXuUSwxMCwxX8rAjhcYjBAo1v4SMWxzeH/LkH8Wwd6ex5?=
 =?us-ascii?Q?Mhho8mMGootc2lIYj47OSzlghLUhZCyDrTj0q1P232DDWOQFwVLT9rr3NJZY?=
 =?us-ascii?Q?4EkJ5stF7VNno1ukJr/mxlRo1Ew5R0XACUrhfrNmebMj5p5HWaVdnJzyu6U9?=
 =?us-ascii?Q?uXgAmAnDskAU4S1KQFaiv/C38ety2t6YyEMstW6CJhxLLxjMWIv4CIoj8r3d?=
 =?us-ascii?Q?jkon9zaBkPBxYFd5A19VSlHXVxwVSNYV0rHuvj9qj9iaGnCa/amLqABTGMx4?=
 =?us-ascii?Q?9wPa3fUWubK4NNylNfQPxqgB346moQCwV/8EOneqIUwwiKU48yiwgIGcdiSG?=
 =?us-ascii?Q?YAVtFEK90KLrfzfAjdQ17MdnwYbKX4U0oehyQhHYZTEu72F99siA0JUo9oYv?=
 =?us-ascii?Q?gWfovuuI52zWeIDdVkboIzglxA8c3e4kr/tgIqzxSyzUQFs3DvFbbvNeqcBu?=
 =?us-ascii?Q?OAjDcG9GF5sod2A3/1XGo1VAMnp+wTyCoqwqxFPGJWfnNsneIt4KsxqeRoEh?=
 =?us-ascii?Q?ujbe4BOZuP+4z1HZPXAn2iaTzG70uvfuVUVsaF1iAuE1rH+5GdTqsDJGoDdq?=
 =?us-ascii?Q?Jdd9MYuKl/sxy6YB4Cpjjzv7MkLub2z55vagiFuOAmtrD6gYJR1Cd/NgXhgt?=
 =?us-ascii?Q?bkxH1r08myTutyq/3JudwGnPUp5+EwgxeDjwxBus2jPJyshL55Bwku7QW0WU?=
 =?us-ascii?Q?kprtUa6K8gk7GLmZ2maAWQs3rFvmBOg8A7/ZcB0eLDczHJjdUnPIn6RTkpwH?=
 =?us-ascii?Q?YFqstpIQsO/k+rdkfdnV6TsC9muZwtgduX2jLP4a7bxTfPcaEUC2TWwGZuSK?=
 =?us-ascii?Q?AF+UaRu0/XJXOCHFd1m2tVBZrJtYebZu7KtQ8BJYhJ2SA1iD3cMocVw70DNz?=
 =?us-ascii?Q?JqzRuDCOB285bqBIX4XGbo95QAeokNDODROXFDTEes6opEpxs+DbCqJFDJZ+?=
 =?us-ascii?Q?tTHT/Whysa8FL95bvhTuS38/RC++t7sggzczf6jURs9LBHDUtK4mHMHlWs+8?=
 =?us-ascii?Q?E+WGDAAK4S60+dXu6d1gNa5te7dQQmGi+jk7DrwNBvFavDGo3fy8hVvHvQfr?=
 =?us-ascii?Q?m5VXEY428GsLMqII7w0FDxrh+lSn/QqYvbYe5gANA77c9TrYqofa06AL8uyU?=
 =?us-ascii?Q?qQUqJj6A8MDrQnOrwG34hVX20RnH1m51GoS1tuttFlpNT6TruQkofETM97Kg?=
 =?us-ascii?Q?MdQvuy5iXlNJb9DTVlHnBmxDIr6gWfEj8llHvgsAqJyVdex+mpZ3Ra9Qnoq1?=
 =?us-ascii?Q?eOGhtz5GXY1CCnlEO2AP/kqrUoKptFmNKJrjxQJJpKdyBYqhFyilDo5JGBFp?=
 =?us-ascii?Q?MLlncndfy4F7MWeWusavSoq/+skhLNhItMmTcMlA7axGJcqcQzv/KUdBj1bt?=
 =?us-ascii?Q?BT7J6tOv+/CNbItgXKM/an+o7AbkcwrPFAW350QECYMiEp5NfPAD1HdIhKLv?=
 =?us-ascii?Q?4wZsM2jH4KTmBJD/UUOlxjxwpcWnozDI2eFdDgKZZj1zXnea9zAXiFY1AoI9?=
 =?us-ascii?Q?9v2L46kk7kW+1wPzjd2nrCi9oTzC6n4r8Tsdm98rPMAzuxwOTrPszi/eD0ii?=
 =?us-ascii?Q?c1rK4AbICJ2ZMLKh7SFbQIrjf9S0Y0JCsqeE7B3X2R1yKiCaNH9cW48j1kb1?=
 =?us-ascii?Q?z8efJy/W2xYBY/noccGXFNI=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17683edf-3a41-4f13-fb6f-08d9b98109d9
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 12:56:51.8088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fiiwCdm88BdKxbl50PMl8A+zwQ0h8/y85+85OYKSnDPygDX4/mD4Mklz+Y8feqePhpScBXvlYG71EvgYRJBLqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3388
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

of_find_device_by_node() takes a reference to the embedded struct device 
which needs to be dropped when error return.

Add a jump target to fix the exception handling for this 
function implementation.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/usb/phy/phy-tegra-usb.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/phy/phy-tegra-usb.c b/drivers/usb/phy/phy-tegra-usb.c
index 68cd4b6..5678b7f
--- a/drivers/usb/phy/phy-tegra-usb.c
+++ b/drivers/usb/phy/phy-tegra-usb.c
@@ -1300,18 +1300,26 @@ static int tegra_usb_phy_parse_pmc(struct device *dev,
 	err = devm_add_action_or_reset(dev, tegra_usb_phy_put_pmc_device,
 				       &pmc_pdev->dev);
 	if (err)
-		return err;
+		goto error_put_device;
 
-	if (!platform_get_drvdata(pmc_pdev))
-		return -EPROBE_DEFER;
+	if (!platform_get_drvdata(pmc_pdev)) {
+		err = -EPROBE_DEFER;
+		goto error_put_device;
+	}
 
 	phy->pmc_regmap = dev_get_regmap(&pmc_pdev->dev, "usb_sleepwalk");
-	if (!phy->pmc_regmap)
-		return -EINVAL;
+	if (!phy->pmc_regmap) {
+		err = -EINVAL;
+		goto error_put_device;
+	}
 
 	phy->instance = args.args[0];
 
 	return 0;
+
+error_put_device:
+	put_device(&pmc_pdev->dev);
+	return err;
 }
 
 static const struct tegra_phy_soc_config tegra20_soc_config = {
-- 
2.7.4

