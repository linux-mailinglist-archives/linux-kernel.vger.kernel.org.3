Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10211588C0C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 14:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237971AbiHCM1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 08:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237945AbiHCM1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 08:27:21 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E26653D00
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 05:27:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYCar9gc/Hn2ktVOU3JF3e0gEcL0STnuJiDIVdtieBTsG+Jl/O+2O0cOL20VkFoVMVwzFjChNOMCColnWHeh7lqM1MPojWAaJD49Kgh+XH7YaOaUXwdLaby1bq7CeaYrPO+yD7dlEzgaHvFgikdBO9I3LeWuO37J4aGB40+Fsx0UkzuouOIcUWOB4BJH3L+Nb1Vqwbuwax0cENqN8Xn8cFEtYKiON2IUodrkZvJQrJ58JL8cFoMdjnjffI4y1NEbBJl3MwDMoff1i5ECF3Ugds8CPv/V4DTY/uVX2k/axbO4vWIEWowq+5SJ99nEYhTGlugMg5ZFJS462IBlXSaSew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Q7MHKEDtcRPDgbi9IX5EtqQnXbIhQbT/SKcHxC8gro=;
 b=h3EA9OsFnCvuKW5DdacHKvMdYt9Isj6f2oSHIAz8Pfl60UETAG8vUDN1GtDIfNczHbsajqg7W6ciyDO+QwNIV2n129VUCfDc1+rq5FGDLmdlvgOzxMJGkKkoPNFervGCpOt7vEx5WQLF2JfIMVtTVtRJkZ9ps08Js6Xdy1qJhL5PotW5VhUH5ecnsi3VWUdo94iCyoZ+JDYefGGGt4EbIXPRJiM4hrvBAc38KlzPUBaPeg64r5D+6s597SJYlJ1RKq8M595zTvJ/40medWJ4evFWt304NnRdCwppHOkh+wKrdNlKmKBCx5ZmbC8jEWdYjUBRs1Tb4UtwrLxnCKPIDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Q7MHKEDtcRPDgbi9IX5EtqQnXbIhQbT/SKcHxC8gro=;
 b=hiU4LUwLRHMgzo1B83w3ZtHaUzF12kMqzllN3xvWqNEfm/JRzS2tkDWtHSlFjSCG35zzjplBrYDgKf+XumgT8IRjMilYBggFO/tD1LPOWlIj004G060nb3IoXVRjQRSdr90/K0d8gWktcR7qN5WiqUCpG609AMvnpgkTHHUq52Y=
Received: from BN0PR04CA0187.namprd04.prod.outlook.com (2603:10b6:408:e9::12)
 by CY8PR12MB7340.namprd12.prod.outlook.com (2603:10b6:930:50::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Wed, 3 Aug
 2022 12:27:13 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::c6) by BN0PR04CA0187.outlook.office365.com
 (2603:10b6:408:e9::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.10 via Frontend
 Transport; Wed, 3 Aug 2022 12:27:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Wed, 3 Aug 2022 12:27:12 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 3 Aug
 2022 07:27:11 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 3 Aug
 2022 07:27:11 -0500
Received: from xhdipdslab49.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 3 Aug 2022 07:27:08 -0500
From:   Nipun Gupta <nipun.gupta@amd.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <maz@kernel.org>, <tglx@linutronix.de>
CC:     <okaya@kernel.org>, <harpreet.anand@amd.com>,
        <michal.simek@amd.com>, <nikhil.agarwal@amd.com>,
        Nipun Gupta <nipun.gupta@amd.com>
Subject: [RFC PATCH 2/2] driver core: add compatible string in sysfs for platform devices
Date:   Wed, 3 Aug 2022 17:56:55 +0530
Message-ID: <20220803122655.100254-3-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220803122655.100254-1-nipun.gupta@amd.com>
References: <20220803122655.100254-1-nipun.gupta@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d0df5ff-af4e-424c-d4bd-08da754b7e6e
X-MS-TrafficTypeDiagnostic: CY8PR12MB7340:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9co+kn22O1OAtYuvSjwhMEYAznwRzF+yrr8k1mMdie6d40wGzRya35ixyb6EDyxdLhYDURSA4ucsYAa+tW4SjOL+fbmXmqyrytANpqY/F0pl0rbvRnrhpzZQEfW0itnKsmMhiCwZNYVAPvppL5hpDno/TaoMPUz6wrzjSljSGhJdKzB9nS6pTsuGXjGLFX0b3BxLIyiabaBBzsE2aUs6lXq3AWqoFfjy35BARdnvIzMbA6yz8f0F4324EBs/dhzm7CRUrMLo8bFj6NxS4eZ8wc5xu9eBRB9kNuBBe/eHetzycBOeqTBpSHOaSgKK3zmtfEQobt74daDF2VMrMyGH6JH8CBaJzAisAiFAlqi5NheUVJvJdBk2QKQ/ikU9nHtooN9bwNwFa0dn/ldXcyykSW/2/hF4D/FDLA8+EPdDc5IfeBtSzU6QkZKgUl8sEbFcqn+qOr9YQm9h91cJAq1FrJmAsCbOq5R39nGz2WNdIG/PYalTRolmG6vNBhj8fpWJs5iukIIRmiqNIiYU2Gk4AqbC8KrosBC6+xUF2NV7nCBrMbsmZbxi76HDIpWN9Lyb8rPZLb3HuahA+qDIpnLiOSRrIHeMLu4L9MSXy6vlbd9r6pgY9FE4S3oiASsGjmFpWCIzS9PFCQ+eJHq2v/KcToINu3LwwkIFHzH9ApWkJoq6vTD1rRWnMD1gzkJnMSss3ksG8zShwAZMtrE1F+aVy+JCUVFOXAh4tFjpVN5HSWrQYaQzPwxAedVPZJuRkEWc7e/VKBfFVANpq0fH626FOhLJ0yAy+O97lLywf1iy3zU7bjrg0OZmgXE7pBePkm2o03oZGjN2QKzWp7/9fuH/lwLfaAbaX4SyT8GLNdV4RfA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(396003)(136003)(36840700001)(46966006)(40470700004)(44832011)(82310400005)(356005)(316002)(2906002)(86362001)(4326008)(8936002)(82740400003)(5660300002)(70206006)(70586007)(8676002)(81166007)(478600001)(2616005)(1076003)(40460700003)(426003)(36860700001)(6666004)(336012)(47076005)(26005)(41300700001)(186003)(40480700001)(36756003)(54906003)(110136005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 12:27:12.9911
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0df5ff-af4e-424c-d4bd-08da754b7e6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7340
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For devices registered dynamically using platform_device_register
API, this patch exposes the sysfs entry for the compatible string.

Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
---
 drivers/base/platform.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 51bb2289865c..89949f88a0a1 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1289,10 +1289,25 @@ static ssize_t driver_override_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(driver_override);
 
+static ssize_t compatible_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	const char *compat;
+	int ret;
+
+	ret = device_property_read_string(dev, "compatible", &compat);
+	if (ret != 0)
+		return 0;
+
+	return sysfs_emit(buf, "%s", compat);
+}
+static DEVICE_ATTR_RO(compatible);
+
 static struct attribute *platform_dev_attrs[] = {
 	&dev_attr_modalias.attr,
 	&dev_attr_numa_node.attr,
 	&dev_attr_driver_override.attr,
+	&dev_attr_compatible.attr,
 	NULL,
 };
 
-- 
2.25.1

