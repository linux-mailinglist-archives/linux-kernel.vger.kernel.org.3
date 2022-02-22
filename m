Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCAB4BEED4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 02:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237758AbiBVA2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 19:28:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbiBVA2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 19:28:39 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C97255AB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 16:28:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YePU6rd6EMAYdMP2oEgCftS+6rQJ8zB5eZKbhMt3+cyISfORAl0+xmuFfSXgSXdYvype3dpdHbTptf5nz/vSxV+nzNi1Hh30u9YiG84MkaW/+Q5k0WueRrzuMjXM14CL6cCXACidnUcDuGI2+irPv2DUzNtfo4lXF5aBicVEti3zvVhSfZjKWkuYTPKyo1AQvkDLA21jE9aB0UaVbrhm+2oBS1WnCzmiHCnKU6Uky9Bt7Mbr1SuuopEMEJwQbJ+MhugxwkELnP7zOs3BpH7adbDo/KNFmdL0+ENcMsJZiOP/mF6nlb0Q1GiZIg221zdtOhdkhE2ri+szimgLe0gkow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1+KNbD9w0qf2EFG5U045EY4NauZoku3kx90wdiqzMk=;
 b=jqsNN34D/FqItAKRQo7AgJy66Rqfk+NV6oLneyTSV58gKzxG54p5IFBiEDfsKVov8K7pwDnreOiIGI/AMZpNlZt9JTAAjvzDxF7LZnKHDRAQw8PZaU9Pya2vsdBucvH/QkncfcYe6la6VdihT1iF9B9Fl2ecIoNYzO0Xc7VlceFPMBhw4fQDkbYzTaXziaAACDyjhInswJJzREO71iZEXT1Q46rNSmHcrO/pRmPOESTCquOqimMWoV592/pLqUkosyDZz8v7l8xOyR1YriYIkwCeIB6nlGhCevXO0l6XvLIAwn0HDrNQz3cNpfWXuxcrYU6NAOzZ5lBZzigo0ET/PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=gmail.com smtp.mailfrom=diasemi.com;
 dmarc=none action=none header.from=diasemi.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1+KNbD9w0qf2EFG5U045EY4NauZoku3kx90wdiqzMk=;
 b=MTnK4JslpolafVyeBMsRm2iqz7t2BXqXEEMocYVNGdOM8Jp31PdUqsZzPBGe35IQHC0Emxs5eq+ljIQCrTK2HnnTsJoblOOfkE7DOh4jzKwXIawCBn+xkmp98/cQBST9lARhpwFA/+CRMDXW37JudrZtyhmPdk4sAcr9ppVjvc0=
Received: from OL1P279CA0007.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:12::12)
 by VI1PR10MB2783.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:eb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Tue, 22 Feb
 2022 00:28:08 +0000
Received: from HE1EUR02FT031.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:e10:12:cafe::fa) by OL1P279CA0007.outlook.office365.com
 (2603:10a6:e10:12::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Tue, 22 Feb 2022 00:28:08 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 HE1EUR02FT031.mail.protection.outlook.com (10.152.10.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.20 via Frontend Transport; Tue, 22 Feb 2022 00:28:08 +0000
Received: from nbsrvex-01v.diasemi.com (10.1.17.243) by
 nbsrvex-01v.diasemi.com (10.1.17.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 22 Feb 2022 01:27:44 +0100
Received: from slsrvapps-01.diasemi.com (10.24.28.40) by
 nbsrvex-01v.diasemi.com (10.1.17.243) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 22 Feb 2022 01:27:44 +0100
Received: by slsrvapps-01.diasemi.com (Postfix, from userid 23378)
        id 3438380007F; Tue, 22 Feb 2022 00:27:44 +0000 (UTC)
Message-ID: <a175201b4a7ea323c6a70d77f7f6d2124bfc0bed.1645489455.git.Adam.Ward.opensource@diasemi.com>
In-Reply-To: <cover.1645489455.git.Adam.Ward.opensource@diasemi.com>
References: <cover.1645489455.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
Date:   Tue, 22 Feb 2022 00:27:44 +0000
Subject: [PATCH 3/3] regulator: da9121: Remove surplus DA9141 parameters
To:     Mark Brown <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da145e6c-afdc-4f3a-0a1b-08d9f59a3347
X-MS-TrafficTypeDiagnostic: VI1PR10MB2783:EE_
X-Microsoft-Antispam-PRVS: <VI1PR10MB2783267A1D5E7B75BDCACEEFCB3B9@VI1PR10MB2783.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LwvWnX1i+QpzyrPzvlen8RyYmm/plLZGIyrwc01iyeBQMJzj1thoa4q6oID95QRSSlbaVfzjE6zeVkRz69h52OtUFvyCo/pCLA1yraRyuMhShnkESkjb+CKDr2PRlSA663bMZDlwqiAzNVk5oogaobBCn6HEkoPk5msxX2aLHTwW44cFkwZTMtWUiv31fayfTa7HtXLGOpAIxFOmYWorHrLKO/Yft/a1MLz+gJnSyOO+LTU9zBYGYpwLgWJfnFSAkmwX+EH+9MhGgybnWHNVhFJ70oxm7E27aIiBMbOHpZeKoMsffmZWCmAM1t1RoayanyjQd5wqwSpwMBh+htv8hh5FzZL5aTR2qzOruycU8KhyTw/9PHG2r2RNmiy5xscWD50udPfwSWo3cMuf5d5pgbZeeH3kgDIoSOlVN64WWbHHIX73pyXFLT4nvyTTYkWiFbXJVHIdMwpPzG+YHko2wLkM4LkNJfHx0RYatgfkorxrhuxNu5tKAxpsExuTMV7rZ3JylrQiK6EwXMg9C7r54NP1TaGSS1WG86jkdC+PerjxhK/DTEljsdGUdamgAwTNs8dkfI6t5pe3Qt8OWW2xCAjwW2hmz10u85p6Dp49U6+igyEhuEB0ScLEPTbOg/GSQlEp7BzWaryOt00I+3Jp0Qf1pairGcAOOPYxdBl3t36UbeMq9eEhXQ3zJm29adXR
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(42186006)(316002)(83380400001)(54906003)(47076005)(6916009)(36860700001)(426003)(107886003)(8936002)(2906002)(36756003)(508600001)(70206006)(356005)(5660300002)(4744005)(81166007)(86362001)(26005)(186003)(336012)(70586007)(6266002)(2616005)(82310400004)(8676002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 00:28:08.2760
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da145e6c-afdc-4f3a-0a1b-08d9f59a3347
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT031.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2783
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove ramp_delay/enable_time values - subject to OTP, incorrect

Signed-off-by: Adam Ward <Adam.Ward.opensource@diasemi.com>
---
 drivers/regulator/da9121-regulator.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/regulator/da9121-regulator.c b/drivers/regulator/da9121-regulator.c
index f16649dec17e..eb9df485bd8a 100644
--- a/drivers/regulator/da9121-regulator.c
+++ b/drivers/regulator/da9121-regulator.c
@@ -585,10 +585,6 @@ static const struct regulator_desc da9141_reg = {
 	.vsel_mask = DA9121_MASK_BUCK_BUCKx_5_CHx_A_VOUT,
 	.enable_reg = DA9121_REG_BUCK_BUCK1_0,
 	.enable_mask = DA9121_MASK_BUCK_BUCKx_0_CHx_EN,
-	/* Default value of BUCK_BUCK1_0.CH1_SRC_DVC_UP */
-	.ramp_delay = 20000,
-	/* tBUCK_EN */
-	.enable_time = 20,
 };
 
 static const struct regulator_desc da9142_reg = {
-- 
2.25.1

