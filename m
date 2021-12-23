Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17FA047DF05
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 07:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346611AbhLWGUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 01:20:35 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:63392 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234232AbhLWGUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 01:20:33 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BMN45kI002320;
        Wed, 22 Dec 2021 22:20:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=PLrvYGR0jUGOxOkqtxxr2QsHkbRlH7PQhIkiPnk0dr8=;
 b=A7KMybt04+DU9FNU5Sl5l/EGxzfBtBc8fYX2hR267g9m1lO37l45tSvQKCRIBCHDjNbD
 8xneph94ZKvW+w81w74Nqc82Z8U0gEQp/lWncnCjC7TVbNQdxKiY1wzjuupRLfHDb8wo
 MrzkDaVRVSKCm9q5cH4MsRC9oArHEqjIHCJyj+pWjU+7dacFUzmJ3Ksc7AX82fznQ92v
 sNPC00mIDoB508/jpqu7viqGnnasKzi/QWwQ5OpkkdJr7dnKomCCmOJr2EWi0H0LdvaL
 aZ90XnVXF0cqAIl7kzn6yGmdfFoHjiNKw1vKHdbwy2Bxp78zwp+1rnN4UzicNef+/ig7 gw== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3d411ru64u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Dec 2021 22:20:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ws6dEFoeqtgwZVPP+w6hJsD158lMeoowE1VkMzNr6SIGZPjkKA/2TtVuri2E+tEMKtS1+e4saOMlhbq3SOtHLD98QwfziL/l+IrlYAUe+jqom1U6xb6nA4bnIKCBeJ4vnXLDu6OonT0XBNLC5Ks0KZEENh65jTsZYamDzgYRDib8cKjmm9oe91VBD2IthgQkU9jQzYV2FlXYmO5uPwrQbInmuxtelOa76h8hH7dFgjq7G7GoybYY/wxleXAAfM+wOF7Jtx23Z3jA8yNd+s/5i4abuVF+/fCYc6EYirg/aZWvItCxnRJIYnE/55MzAX3GHpFcBf7ZT7rR6Hk7twEWdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLrvYGR0jUGOxOkqtxxr2QsHkbRlH7PQhIkiPnk0dr8=;
 b=U/fDLCmdT0teu2kQbvvmqcVW6nBxis5OjSRXqwTUIr+dolEJP3pJFvj0G/xRg9gv5jjUcfI7Ik7Vx1l2c0xpezmmps51+TgHA7mJPfOlz81mIbMUX0BsI922YxGfkKIa1Yu/urPuodPurHOJKEylOz0pZ1IaUFl0c6qugB8KfCyLgK6cwpTQAh64zGECvZAJIgk/lNzHCcyqPG9xr7pe0Q1zxAOkT1zZIXPfrrkuOajr39gKZXqZFMXs25EmM/kiQ35XFW+u1FxWohIy7ZKAyFj1ebhXlgzYyPl3Gjwjtq/9F0BShm7Kz/xjdMC0gtvKLa7mzzI2lCs/fAjzJ2Ozmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLrvYGR0jUGOxOkqtxxr2QsHkbRlH7PQhIkiPnk0dr8=;
 b=UpADObB8ZahCS8SrtcA8TB+wio+8RDMSFpwFvYRD/IRkTzqMmGj6SmWNrRypVlH11zNsNR5MPPLyL85WDbJqreuYW/Pkn5KWMUZy85F853MZv+I+jtFN5QMgS2RLOa6ICy21Fd+aRLEKTd5fDlZFRkCEilTppOcmST7oAaQ3Qzo=
Received: from DM6PR02CA0122.namprd02.prod.outlook.com (2603:10b6:5:1b4::24)
 by BY5PR07MB6887.namprd07.prod.outlook.com (2603:10b6:a03:1f0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Thu, 23 Dec
 2021 06:20:20 +0000
Received: from DM6NAM12FT038.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::be) by DM6PR02CA0122.outlook.office365.com
 (2603:10b6:5:1b4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19 via Frontend
 Transport; Thu, 23 Dec 2021 06:20:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 DM6NAM12FT038.mail.protection.outlook.com (10.13.178.113) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4844.7 via Frontend Transport; Thu, 23 Dec 2021 06:20:19 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 1BN6KJem019875
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Dec 2021 22:20:20 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu5.global.cadence.com (10.160.110.202) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Dec 2021 07:20:18 +0100
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 23 Dec 2021 07:20:18 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 23 Dec 2021 07:20:18 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 1BN6IfN5020165;
        Thu, 23 Dec 2021 07:19:14 +0100
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 1BN6IfeR020164;
        Thu, 23 Dec 2021 07:18:41 +0100
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <a-govindraju@ti.com>
Subject: [PATCH v4 11/15] phy: cadence: Sierra: Fix to get correct parent for mux clocks
Date:   Thu, 23 Dec 2021 07:01:33 +0100
Message-ID: <20211223060137.9252-12-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20211223060137.9252-1-sjakhade@cadence.com>
References: <20211223060137.9252-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d423bff-a6ed-4902-3734-08d9c5dc4b96
X-MS-TrafficTypeDiagnostic: BY5PR07MB6887:EE_
X-Microsoft-Antispam-PRVS: <BY5PR07MB6887C4096CB809BD8A680128C57E9@BY5PR07MB6887.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: avqbRauiYgcLD3qhoLQNzx2Hf42uxSmUSKCkGPAcXepMNejE6QEUCGwcCkS9CSYadw+DK7OJp/BOQLMOS247JZf9eogRFgQyx/3VyaTypbzyWAyf+n5CNZ5FxRoPH3VhjycJoQsA5wG1K9GIKRbMUaBxnGZeoXmuGYVHLDf97aU61ZK53HGGQgEOkbjrdGeWDNCIl+y3Fqhw8wN8OdK+uBrCmLHoUKNx8pGmXkEPco5IMVKPvpyXhCl6RYFcrD64SlacQrmdqru6Ylw6ZBXUXE+ho+WwwRcArA6zsyZjPZuBpkgRzt4ynzV/qzqUHel7RLz+e7KcbKmXbpqg1mCHbUon4PbwUDIwSF6Eiz/rLidfmigy6F5fNRlPzSNL46lTXBFATCUzEu5EdfwvRWVXQYkaW9jo9wYISMAiaw/te59RAOAkaTC2wNTZ/41fM7p+Uf4E/skQ4cAkx+CaVj4yZV0WioHLlDMm/+9kzoSCJG8qE1h11VT17cVY3BLhjIlj5Q6mNrNxHQvbqFxdJCZ7ddgcmHUeN+oAapZaCx9ADKvKtcxPGxAEmtMCmrN3uuuGZdU6lwKwNfT5AFJcsydH9oSA9UazXWH33V6YzmG4gQ1BznCIBICNQ1ut3/B2ilb2bDykH5KtX0KSb4GcRsRWjCvQVakzvl1goSGtcNzh11DBcoR42AMtz1tal3GbE07d6Xg5GOqkR737h+7QMOJjnE6Wr6LSZ7FqChYtmByhbk9NGYOlsudhhSXir4FOwGl3hkVLAmMTxBbR2Wxw/shZlsGmjhE+jBgOdFSOsaZLsec=
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(36092001)(46966006)(40470700002)(36840700001)(86362001)(356005)(36860700001)(426003)(7636003)(47076005)(4326008)(82310400004)(8676002)(26005)(70206006)(70586007)(8936002)(186003)(336012)(316002)(42186006)(2616005)(508600001)(110136005)(40460700001)(2906002)(5660300002)(1076003)(36756003)(54906003)(83380400001)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2021 06:20:19.5467
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d423bff-a6ed-4902-3734-08d9c5dc4b96
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT038.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR07MB6887
X-Proofpoint-ORIG-GUID: CzsyFJ4HgfnWJQhn4kG5Db4DXAhtVMeN
X-Proofpoint-GUID: CzsyFJ4HgfnWJQhn4kG5Db4DXAhtVMeN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-23_01,2021-12-22_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxlogscore=969
 spamscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112230035
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix get_parent() callback to return the correct index of the parent for
PLL_CMNLC1 clock. Add a separate table of register values corresponding
to the parent index for PLL_CMNLC1. Update set_parent() callback
accordingly.

Fixes: 28081b72859f ("phy: cadence: Sierra: Model PLL_CMNLC and PLL_CMNLC1 as clocks (mux clocks)")
Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Reviewed-by: Aswath Govindraju <a-govindraju@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 31 ++++++++++++++++++++----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 728abd14aa79..abdbc6ebd5a8 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -257,7 +257,10 @@ static const int pll_mux_parent_index[][SIERRA_NUM_CMN_PLLC_PARENTS] = {
 	[CMN_PLLLC1] = { PLL1_REFCLK, PLL0_REFCLK },
 };
 
-static u32 cdns_sierra_pll_mux_table[] = { 0, 1 };
+static u32 cdns_sierra_pll_mux_table[][SIERRA_NUM_CMN_PLLC_PARENTS] = {
+	[CMN_PLLLC] = { 0, 1 },
+	[CMN_PLLLC1] = { 1, 0 },
+};
 
 enum cdns_sierra_phy_type {
 	TYPE_NONE,
@@ -567,11 +570,25 @@ static const struct phy_ops ops = {
 static u8 cdns_sierra_pll_mux_get_parent(struct clk_hw *hw)
 {
 	struct cdns_sierra_pll_mux *mux = to_cdns_sierra_pll_mux(hw);
+	struct regmap_field *plllc1en_field = mux->plllc1en_field;
+	struct regmap_field *termen_field = mux->termen_field;
 	struct regmap_field *field = mux->pfdclk_sel_preg;
 	unsigned int val;
+	int index;
 
 	regmap_field_read(field, &val);
-	return clk_mux_val_to_index(hw, cdns_sierra_pll_mux_table, 0, val);
+
+	if (strstr(clk_hw_get_name(hw), clk_names[CDNS_SIERRA_PLL_CMNLC1])) {
+		index = clk_mux_val_to_index(hw, cdns_sierra_pll_mux_table[CMN_PLLLC1], 0, val);
+		if (index == 1) {
+			regmap_field_write(plllc1en_field, 1);
+			regmap_field_write(termen_field, 1);
+		}
+	} else {
+		index = clk_mux_val_to_index(hw, cdns_sierra_pll_mux_table[CMN_PLLLC], 0, val);
+	}
+
+	return index;
 }
 
 static int cdns_sierra_pll_mux_set_parent(struct clk_hw *hw, u8 index)
@@ -589,7 +606,11 @@ static int cdns_sierra_pll_mux_set_parent(struct clk_hw *hw, u8 index)
 		ret |= regmap_field_write(termen_field, 1);
 	}
 
-	val = cdns_sierra_pll_mux_table[index];
+	if (strstr(clk_hw_get_name(hw), clk_names[CDNS_SIERRA_PLL_CMNLC1]))
+		val = cdns_sierra_pll_mux_table[CMN_PLLLC1][index];
+	else
+		val = cdns_sierra_pll_mux_table[CMN_PLLLC][index];
+
 	ret |= regmap_field_write(field, val);
 
 	return ret;
@@ -627,8 +648,8 @@ static int cdns_sierra_pll_mux_register(struct cdns_sierra_phy *sp,
 	for (i = 0; i < num_parents; i++) {
 		clk = sp->input_clks[pll_mux_parent_index[clk_index][i]];
 		if (IS_ERR_OR_NULL(clk)) {
-			dev_err(dev, "No parent clock for derived_refclk\n");
-			return PTR_ERR(clk);
+			dev_err(dev, "No parent clock for PLL mux clocks\n");
+			return IS_ERR(clk) ? PTR_ERR(clk) : -ENOENT;
 		}
 		parent_names[i] = __clk_get_name(clk);
 	}
-- 
2.26.1

