Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD155246C6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350908AbiELHUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235907AbiELHUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:20:17 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D572F61D3;
        Thu, 12 May 2022 00:20:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dk3Fl28oscMtsFv4f1wz/Vt8NXdSCu/9VsP9wR/2IdVydA+V7UTmMDTFO7wkfh0JsH80QhfOosLpqnZ8zCi6KdwJku//JWyp143IpsvLWBSkWj4vR/yQv8s6quA9F269xOu5scn93OVYJZ0Y3CE90SpFfDVWQibPzKPkqL0J6c/Qqsp4oLVkz4SuFFKj0+Tyaxf7E/GgZnlr6cXMWgK2RvTXffjD9XLa8aMwR9rjlFDCaXAIcvQiMQHcevGX8yMffNp7OAswiEcI1oP5VPyWRSJqjX5+dJywK2scj4Z5gyTQnBZjMNpTRX+nIghi/PPD2mr6OVJxoiS07ZVBVpfI5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+6ZJfyH57Nsu+xycuZwWWFMkUL7pd9JQ3WB4p4QbVk=;
 b=aYWsBjIne5pnr3cap/BXjt2oPyRBIipmoIWW1gYVNxkFfGQCDoA9spkIwr03LJGed9dj82TgvpSH9bTbJQqrEO86CVp20IcTZjjmUOwkgc4/b7l2JAPaVExJTMtBQzg5fqRcVT6sA+eska9pZrkik5Q0IQvcFoLePjGei19mINoCVVfiT51Wp4YwYJB7MM6QnaUu6+rKtbOfB7WMVDfu74W7ZjlfLPW2HVCsNMqy5RbJle0QP6DkRTObPBu56yHYd3yaHog6IDiLmYFy01wA/GnPRhXHxCuAVdkD/8dQXHIfMumxR8k0cFsXavoFmv0fkkKLku52k4USUdxC8Pp6XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+6ZJfyH57Nsu+xycuZwWWFMkUL7pd9JQ3WB4p4QbVk=;
 b=NvsnjmfCUzdio47jVrkERoInT8QuBHhjsqpy0eJ660owmYAMYWEcUyXgVGuOi9c1vAvM18KISOsrujyuBzU4XxoG0aKXFlU7hLi8iic6tTlib/KGefMI0i2SUHwerHAfpv1ksMLJRobMgtQtaVfriuw64w7+VhA5D8WiTlCU9Lc=
Received: from SN4PR0501CA0126.namprd05.prod.outlook.com
 (2603:10b6:803:42::43) by PH0PR02MB8358.namprd02.prod.outlook.com
 (2603:10b6:510:102::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 07:20:14 +0000
Received: from SN1NAM02FT0053.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:42:cafe::b7) by SN4PR0501CA0126.outlook.office365.com
 (2603:10b6:803:42::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.5 via Frontend
 Transport; Thu, 12 May 2022 07:20:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0053.mail.protection.outlook.com (10.97.4.115) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Thu, 12 May 2022 07:20:14 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 12 May 2022 00:20:12 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 12 May 2022 00:20:12 -0700
Envelope-to: git@xilinx.com,
 saikrishna12468@gmail.com,
 adrian.hunter@intel.com,
 ulf.hansson@linaro.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org
Received: from [172.23.64.3] (port=38989 helo=xhdvnc103.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lakshmi.sai.krishna.potthuri@xilinx.com>)
        id 1np37L-000Fck-LL; Thu, 12 May 2022 00:20:11 -0700
Received: by xhdvnc103.xilinx.com (Postfix, from userid 14964)
        id D6D4D102C79; Thu, 12 May 2022 12:50:10 +0530 (IST)
From:   Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@xilinx.com>,
        <saikrishna12468@gmail.com>, <sgoud@xilinx.com>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Subject: [PATCH] mmc: sdhci-of-arasan: Add NULL check for data field
Date:   Thu, 12 May 2022 12:49:53 +0530
Message-ID: <1652339993-27280-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d57e9c2-3872-46c1-1beb-08da33e7dbcb
X-MS-TrafficTypeDiagnostic: PH0PR02MB8358:EE_
X-Microsoft-Antispam-PRVS: <PH0PR02MB8358D5536F2F64052F889288BDCB9@PH0PR02MB8358.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K+kkUJoNPpFbhqTdpvG7nJEeu0OAfs10Vz0uiz10/HGh4pkwpI3N2DbBaqjWwEAmfZfQICMzkhATU5SILZlKuS8vQyTzDTVMtBAgZBMy7g50YB2kBa+STUOGJOxhSbeLCIVo/T0X3vBur4Dj7tVDbKOO5RU//AFKrXZtIFqHi2MgdEZjkDw79orvUIReVOC62Vifd9uPlyeXMEr4N7gi2WI62tnjCEjSzLgFf8JuT6g3lHVJQin9sK65Y04YJz/QDQM+9jlrDYLnT5SlIiM34/bdJvQB9Re/sNfasLstD6hiIlnnfuItYAVKN5D1qAj7zs5pkuYtb+F7yd/mnu8qiWbbM3FLrBidHV+T59alG3IcK/Bqq35rHhOEevnP4CYk2av2ls+9lfI50xI7nhegUvsU+9HQGJ1Tlk0UBII4uCjmeXCFJtUgdADVNHx4HJbpuxgPu39Dx8a3BXlV2+V/ixKopzpg/QSE5ZdyTzLXG1KwfrA4SiJOURSvZKdM0KaQpS1i77TLD/Og7Ac+KknNoaMORRxm4REm/YbIGeLWgQocz72hDyn/IQVCrVpC10H6dgRL99+rY8wNoc5QOM/0pBtqx0fcQ8cTR3RGoEzioUkmirXKidtVcpL8vnrs5txvulXcyFoYMHkkotcMECNSuLqEltAdcNYzHvKB3MhGUZgpDp3l9+7o7LVnCrBF0qnQPafZJUUZih20q6Rjxxva/g==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(36860700001)(508600001)(54906003)(70206006)(70586007)(8676002)(4326008)(6666004)(82310400005)(110136005)(6266002)(26005)(426003)(47076005)(336012)(8936002)(2906002)(40460700003)(316002)(107886003)(186003)(36756003)(4744005)(2616005)(42186006)(5660300002)(7636003)(356005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 07:20:14.3079
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d57e9c2-3872-46c1-1beb-08da33e7dbcb
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0053.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8358
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add NULL check for data field retrieved from of_device_get_match_data()
before dereferencing the data.
Addresses-coverity: CID 305057:Dereference null return value (NULL_RETURNS)

Signed-off-by: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 6a2e5a468424..757801dfc308 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -1577,6 +1577,9 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 	const struct sdhci_arasan_of_data *data;
 
 	data = of_device_get_match_data(dev);
+	if (!data)
+		return -EINVAL;
+
 	host = sdhci_pltfm_init(pdev, data->pdata, sizeof(*sdhci_arasan));
 
 	if (IS_ERR(host))
-- 
2.17.1

