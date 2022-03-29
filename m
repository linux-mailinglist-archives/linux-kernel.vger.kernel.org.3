Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20204EB1FC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 18:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239823AbiC2Qne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 12:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239772AbiC2QnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 12:43:23 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7ED24D9B8;
        Tue, 29 Mar 2022 09:41:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZ/yFWRlXydC/hnI2+L+eigbH4q6ifiknWyJnmP/m5QsKny+vGmXy/Iso88nL0FgJo2gHRoanxRwzRg8In/p84pklbYAvaRIaBRcIn6ZRGOHNGSUYGcF8ZKjmyBnbgwGEoXAgQJB8A7VF8h0WjiMXbHHq851mixhEU1NGFspm8VvIuFYW8NDj7HBFIE+2dN4aBj+AoPa8iAW02IDdQtr1NCFG9BS8TXhOwA87dCf1Daym7XzNG5SdMRlCa98yHeZdiPKkiEXOhsXm1kjoMmWvpdcufA0akFSnnEDIgjYJnVbnxIKtC6lvQ1HwHszUYHUBo1cLDzZvDGb6fHYepAGuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHcJlC19I7dEx3MbVDFsBVna8xKEBgURKEM+Gm+s2II=;
 b=lBxxaNopcQqSKmVbz+2qyQjs5vUIfJdqVtbJHeKlAF9+3VyEOAcigVQc7hdC/zIIDobR6RV9uIup1w1opVWEfRtaYTGEGMua6hyVpxIf1E/wIYyOo+sxcYeq4ogeFcPclHIAv/E8AOVuURk7BADu/NdbudtikJOnGXVRb8BPdQTcVv2xxlQSCLSpZ6Rw0nthSB2zke+TNbkQndt6/owm/Io7P4+s6MEa6f3VA0BdgM3VnxJ9u9zvaZsAP3/orMVN3+yyldxusgK7QfhW6oa7gxKMer4ItppMZhzlHE6trV3coGhZWIOfBOIGOU68of/WBJt7TQNTN61izUaEgr0Z+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHcJlC19I7dEx3MbVDFsBVna8xKEBgURKEM+Gm+s2II=;
 b=ap9kAVqnjU62k2aioUm3Df2OnQ5QQC+gLTL41jWEeOkR5Q2eFmMv5+tI36BELsIwUXT5fv7jb433bRpj/MTBTw8r4z8Ck04Ed3ze8W1gB7PgJDWDVSg0z8xHRrBrCtH302KNqqZkRxug5AqSotRNoWxGlrcM35v45j9vGlRgRKY=
Received: from MW4PR03CA0022.namprd03.prod.outlook.com (2603:10b6:303:8f::27)
 by BN8PR12MB3444.namprd12.prod.outlook.com (2603:10b6:408:47::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Tue, 29 Mar
 2022 16:41:28 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::e9) by MW4PR03CA0022.outlook.office365.com
 (2603:10b6:303:8f::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18 via Frontend
 Transport; Tue, 29 Mar 2022 16:41:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Tue, 29 Mar 2022 16:41:28 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 29 Mar
 2022 11:41:21 -0500
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 29 Mar
 2022 11:41:21 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
CC:     open list <linux-kernel@vger.kernel.org>,
        "open list:AMD CRYPTOGRAPHIC COPROCESSOR (CCP) DRIVER" 
        <linux-crypto@vger.kernel.org>,
        Kerneis Gabriel <Gabriel.Kerneis@ssi.gouv.fr>,
        Richard Hughes <hughsient@gmail.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH v2 4/4] crypto: ccp: When TSME and SME both detected notify user
Date:   Tue, 29 Mar 2022 11:41:17 -0500
Message-ID: <20220329164117.1449-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220329164117.1449-1-mario.limonciello@amd.com>
References: <20220329164117.1449-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB06.amd.com
 (10.181.40.147)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2333e9d-f6ce-4e63-ad8a-08da11a2f8c0
X-MS-TrafficTypeDiagnostic: BN8PR12MB3444:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB34447846F9CA9786A5BE02D0E21E9@BN8PR12MB3444.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Kk/YeXoXkp8U17K+GKSdbj27m6omvufyBPByA56C5/8ftJ/9Isitn49uO0jphIyaLUeWBqcYhezQBJLs2Tejf58FncCf3hdyiZfZzY6MxvIVbi6tQTZ6ioo4Q4OT/qU8QTQpcUpiIpPj2TDviSHUDVsVvFkhxmOKq4Kyz3f4fHk1QdUgk0dkHcPQzduWDGizB7PBp8j6uEeKE8cZwA8dquBxzIK+fyG5BehcVX+c8Xok+3j4hwFyv3pTUPsznNP0lbFBDBXuEKrchPwVd9cvvhD5WrYczwkMoPlrSu1i6WIHZTx/p/Pt886K9ZCpDcPIlk2PH0Y2oblt0sFvM8M885j7pbnOkNP+rzBqzB81qvFbSl8+K82kpMfI07y3wrlAkXyE4ETz/yA4nd9ZQAPKfJl3rSvDIY0O4dxluzt7Pwhm8FBqBoVl3vPxYZBGphbARAjseEjUQXqO97f/T7VUQSvt8/fpMXdbLE+ma/Kubwv2+ajV1ehDJRg6yJVQAcgyugiq3VveRtLUBjeJuKADG5McPc8AD+hqkjmdAtukZwInzJwy9UsSoCmftubKuJxA2QkLNSL/msXWT0Hk2siEEQz2E9qqr3GzIk7LPBhyoMq43IPQqAc6nePRcFqD0JzC0wEGc27nGJYe00VWVUmmV/jOl0FOpwi3tW6IvxU1IRxBP92bxpS3qohxUtYnfTWBH1EMY3a1MLNBlTNeeVlKQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(356005)(36860700001)(8676002)(7696005)(6666004)(4326008)(16526019)(26005)(36756003)(508600001)(81166007)(1076003)(186003)(47076005)(2616005)(426003)(2906002)(110136005)(70586007)(54906003)(70206006)(40460700003)(83380400001)(5660300002)(316002)(44832011)(8936002)(82310400004)(86362001)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 16:41:28.0378
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2333e9d-f6ce-4e63-ad8a-08da11a2f8c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3444
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC_ATTR_HOST_MEM_ENCRYPT is used to relay that memory encryption has been
activated by the kernel.

As it's technically possible to enable both SME and TSME at the same time,
detect this scenario and notify the user that enabling TSME and SME at the
same time is unnecessary.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Reword notice about TSME/SME
 * Use cc_platform_has instead
---
 drivers/crypto/ccp/psp-dev.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/crypto/ccp/psp-dev.c b/drivers/crypto/ccp/psp-dev.c
index 3f47b2d81e3c..38cffc1de4ab 100644
--- a/drivers/crypto/ccp/psp-dev.c
+++ b/drivers/crypto/ccp/psp-dev.c
@@ -74,6 +74,13 @@ static unsigned int psp_get_capability(struct psp_device *psp)
 	}
 	psp->capability = val;
 
+
+	/* Detect TSME / SME both enabled */
+	if (psp->capability & PSP_CAPABILITY_PSP_SECURITY_REPORTING &&
+	    psp->capability & (PSP_SECURITY_TSME_STATUS << PSP_CAPABILITY_PSP_SECURITY_OFFSET) &&
+	    cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
+		dev_notice(psp->dev, "psp: Both TSME and SME are active, SME is unnecessary when TSME is active.\n");
+
 	return 0;
 }
 
-- 
2.34.1

