Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB3857396E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236693AbiGMO6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236660AbiGMO6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:58:16 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE953ED6C;
        Wed, 13 Jul 2022 07:58:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kEdSssu+hwuZWem6NAbds1rweQ8IHuYgLi3pgTp/syhzmr2AZBbTWYAi/qE3ufStTeiwy8g81CUYzUO68SvGX+EUyKhQzuLDvR46atedeTKJ6Mhn3YqOvzgCcvCmVLkt6xM94cAVlaIRnla0FK840vaHYA+GH4L3g9CkQ8qekR89dpC7NnJS7pPXeDZMyiaP2Tt5TZOdseDfI3I2jb6TXoKh43Z2k6I4V++csM1mHXxFPKNgYubUad3kO0TPYMyWm+l38ODhVbf2cUycHUqz4V5ZUvuiPfhtRDd0/0WAjgUW3VTonwD/1AHhivBOtYAbUQkUdZ9iwUik/SoRVB16MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vsMYZT9ZGage1XOGx8Qbmm4a9oY0jhH71JzfXIWycu8=;
 b=bCFx5xs+T3a1UeE+IHw0WSzG1UWmf2+I7etFYOU80vU+CyaeIdqdy0ZhUOQYO0KawwuUffyRKgJonQAB/o0N75wJIKN8TizLIEQ7LjyVGVo5OS9yQcajBduYuuo49IKIE8NNwHRo2kqSNCkMkaqkbJ6tRm4/uoxWg4gzjJLkIMEABxBjkcMbpyHCPEJCKlyyF/+6YaFrdwsnSeVMUKVJAr7vzJjrLH546vnSS66EKYI4hMydCs7F4AfJbcLkMHEz6awG5LZL3Rgu6o/asMXBOkmJZOPfUIIcuT9e6VFXKyCtJsOvxBEJ+gkKRfOJZYm7n2nlx+/m/A3w0Be7e5zXxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vsMYZT9ZGage1XOGx8Qbmm4a9oY0jhH71JzfXIWycu8=;
 b=WnjPomL7v+3Upfn16hmFAiEDZHYvzxcPnOq0ngOScroKn6HU7MdZGkD2hqw58snIY0JYenB4FPXPN0VuEnSCo2SLGolSwZbaxF2AU29Bol2SXpcprMzsIV2FWRGWLPdfJQ4iCgG4F9BJvwycvHzXHZemRJ1aHzZYWGMNz8BbZwQ=
Received: from DS7PR03CA0185.namprd03.prod.outlook.com (2603:10b6:5:3b6::10)
 by DS7PR12MB6119.namprd12.prod.outlook.com (2603:10b6:8:99::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.25; Wed, 13 Jul 2022 14:58:07 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::61) by DS7PR03CA0185.outlook.office365.com
 (2603:10b6:5:3b6::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20 via Frontend
 Transport; Wed, 13 Jul 2022 14:58:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Wed, 13 Jul 2022 14:58:07 +0000
Received: from ethanolx1ade-milan-genesis.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 13 Jul 2022 09:58:06 -0500
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <bjorn.andersson@linaro.org>, <amitk@kernel.org>,
        <thara.gopinath@gmail.com>, <konrad.dybcio@somainline.org>
CC:     <agross@kernel.org>, <david.brown@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bilbao@vt.edu>,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH 3/4] thermal/drivers/qcom: Simplify function calibrate_8960()
Date:   Wed, 13 Jul 2022 09:56:58 -0500
Message-ID: <20220713145655.3844109-4-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220713145655.3844109-1-carlos.bilbao@amd.com>
References: <20220713145655.3844109-1-carlos.bilbao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbe2d4d9-4791-436e-0f81-08da64e018cf
X-MS-TrafficTypeDiagnostic: DS7PR12MB6119:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mp5DqeG5H8XYu+qtcEvTXWadadC2AIrfiU0zv8D+MOx8PYvaTxBfnVaFhMjLlVXWSR83MB+ZRiiqC4RU6t1ZhVBapvMGUXs11DDlkyxCVZUO5LRBs40StZBOrewO/Z9gE0Q0on8+s0Aa67M7CMexm/2JnaSI+8DQ39kFiKSTq3nLULbftQM7kSuPdIvc+lh/POmvZ8E9a924xDBQvSpbSTBGQB0GfwuzcgofSkP/b/uofFIWJ9d53gNcvqrKML2g1dTASLseoW97e33fy0ii+PldikowaiwBBy6eFmuJ/KZqK/woHz9SWlEF3CZkt2GpLgX0DYBuhAuIJQp6IVNhik4rIxul5nb5slD04wMlHRRGnhoQgU9vGHJY4qKoEU0IefZYYW6XLRDqSvWWFXRxJNHDDFFlpOdhlTwVnekKOVU3Z6G/kWayE9PARL2HaV3HFh3S9s7SX5oM6GjDAoh/0JsPVqoWDvkBpVw/3ANCU6PfhGeulkE2dfmWL9vXK55AatZk3mLEO+jYsED4p1+LKHcsQVDynG7FyUP8lrfDEuyn0wQHEi1bTtvTrHdnoFTRoftIwjaDpUmgPSagqq+DHrBYNx1NL6lGAaQrHTOyp8yzQFGnxjHtLzIK++Mwg2+gPBqNa2/dC0ktydXlrKK26Vh0RiLGEG4AB3FDYd124HJ2TQERElfhjGSjT4sfxEuB3t2Yki4W6aC8PZZDzMWZvECphUEkraJusoa42wZgmpIZpW6b3vlRm7MHbIDYI0fYkvMm4I4srLooLF4wEny+ZaXst23qkQix0aN2G3x07QhXeI3xFyo4Jp1iwrXcCBCZWvly/U5VP2fhv0qFA4q/N3japuLjVbFq/hV90L5X4r0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(346002)(136003)(39860400002)(46966006)(36840700001)(40470700004)(83380400001)(478600001)(4744005)(86362001)(16526019)(356005)(36756003)(44832011)(336012)(2616005)(70206006)(4326008)(54906003)(82740400003)(316002)(8676002)(70586007)(47076005)(426003)(186003)(36860700001)(82310400005)(81166007)(110136005)(41300700001)(2906002)(26005)(40480700001)(8936002)(1076003)(5660300002)(40460700003)(7416002)(7696005)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 14:58:07.6927
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe2d4d9-4791-436e-0f81-08da64e018cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6119
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simply function calibrate_8960() so a second check to IS_ERR(data) may be
avoided.

Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 drivers/thermal/qcom/tsens-8960.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
index f4fc8a1c161e..b41ff164e67a 100644
--- a/drivers/thermal/qcom/tsens-8960.c
+++ b/drivers/thermal/qcom/tsens-8960.c
@@ -205,10 +205,11 @@ static int calibrate_8960(struct tsens_priv *priv)
 	struct tsens_sensor *s = priv->sensor;
 
 	data = qfprom_read(priv->dev, "calib");
-	if (IS_ERR(data))
+	if (IS_ERR(data)) {
 		data = qfprom_read(priv->dev, "calib_backup");
-	if (IS_ERR(data))
-		return PTR_ERR(data);
+		if (IS_ERR(data))
+			return PTR_ERR(data);
+	}
 
 	for (i = 0; i < num_read; i++, s++)
 		s->offset = data[i];
-- 
2.31.1

