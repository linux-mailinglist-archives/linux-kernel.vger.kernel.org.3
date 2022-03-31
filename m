Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28AA64EE314
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 23:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241661AbiCaVN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 17:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241646AbiCaVN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 17:13:56 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171A62335CF;
        Thu, 31 Mar 2022 14:12:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N98+FAONyodZw/Wr0wscuk2g3MFrhoPacbikhc9tyeeiuytsCRfhVkTRBQjsztTSelYmZru+rREHVl4woLjS7jhiWVM7Tq53HewMUSKuMAAeGqQBAunkJ5OlLevjJhvsa07kO918uA9wtEHFGYyf0/0kYI5N4MIpPBL83FGeZRVNdune+H1ETrjFXv8dZ4doG4mtWjL6N6fSVmIQn4IU2iHakEOSuEgHWHWO+8BrkPB+2MSnl767wDS28r3lVNjP9ekIlMdkBETUo2vzi946FvzxGsiPmISReFTgSZoTLYGAhhpf0aAR60yTXpivpBjN9Tyl1SHCeEL+5JccJsFQHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sS2FJmKCvfBvsJjwt5eOKKFdqyzQh2Mr+XEd2JrvIvo=;
 b=isVX7J9Lj3gWrO/rAKUtZyun3wH83i9ziWFqfXjlbO5cgZPc+2WigeiCvEgNxWLTlj0KFyZaotAilJ4rgvYRNcf+Wv0CsEQ3rvbOR9EpTeotwq8m/zFCv//oJMWkwCJERYF1MJ9ZAEEILDs6wfXqm2soN9KfXqk8ghaPNYwHO8Ra+cBSnrAIA+IwN5oU75mlZr1vEQ8i78C9dmiGcXopMvdkCUXm0QldlTxuAzVCD+Nhj65yLwUC78gFkFxeJIgTfG73NZnD6BQi9fg/PdM8ug8PhfwM5g1ybdfjPHLLWzlQIQeNHwra+sG0aelUq3ox3hRHlRTC4s3cowcVQY2GBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sS2FJmKCvfBvsJjwt5eOKKFdqyzQh2Mr+XEd2JrvIvo=;
 b=LWqnt5mQ4gzBVYe2Ks2EV90ijJ8zu7Nx01EDtyblvxvby4SIh4yXdlbFxD9oI11HTW6LlpDzBmFp97ZR67dy2qqFnFv1YtsLyTcJ+63IawwGBUiyuAuE7YCm3ii2qXwF5aKMQZnehB2heTeLiDZCwd+8HbJtLhkT8TQrLxM5/SY=
Received: from MW4PR03CA0145.namprd03.prod.outlook.com (2603:10b6:303:8c::30)
 by DM5PR12MB2486.namprd12.prod.outlook.com (2603:10b6:4:b2::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Thu, 31 Mar
 2022 21:12:05 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::bb) by MW4PR03CA0145.outlook.office365.com
 (2603:10b6:303:8c::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.13 via Frontend
 Transport; Thu, 31 Mar 2022 21:12:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Thu, 31 Mar 2022 21:12:03 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 31 Mar
 2022 16:12:02 -0500
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
Subject: [PATCH v3 0/4] Export PSP security attributes
Date:   Thu, 31 Mar 2022 16:12:09 -0500
Message-ID: <20220331211213.2844-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21b41180-dc21-4171-d9ae-08da135b1adc
X-MS-TrafficTypeDiagnostic: DM5PR12MB2486:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB2486B7A5D6D181765E3CA65FE2E19@DM5PR12MB2486.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kLMbjwnN8+2U/9eBDXdqhSucAJIAwRDCLZ16NTKaPaJzoOx8TWN02h5yD4+aERkih8/Ukvr0hEZq5XHG0OqDdFLxyBwBNXD16WS+3Xeggip9p502r7tQ/58sQ2osgTnm/4qs7SwvHRy5+PLnPvvLEwia8ChMWlJmg3HQ9kVRCAUlcpNmCHEukQwVmzMohXZ6j5nYa0fq+Cp7q1KmU2DskpVe19jCtU7ydQOqV5Mhc5OMjZQFXHdC+cWmKkfTH8/bgjLspTezHnbU3jWpFPOFybnxHlYUqiuZpAy6A2d45jamWGSCjPlESq7/RzaMlNKcqIo0p32E2lFHBMA/m6R5Q+V97rnwChJ4ci0nYjKgl2xIyBEb07dZU9NUgWYG2PEEqsqoNa3PGkEhZJmcfg+uHpTomcMRzKX82Tl55jN++jmhdS+dcmNVAx0rBYufE3HTDDPIOAui2C3aGJ4mU0l3ZZ0VO4cbboNzsnvvHbdN2kSlYcx5dAhxxQLuRun8yF2nPeghI2GUcZ+QVymZy91+BIEtqbR7Y2PZBBGNw8Vm9acMNSR435LVJyZwsFh/qizgXGNUECKSkop7qGYox6DE67lnVHxbmcqAsQrRmEay6uD4Qhtv6OZniDutISHjVGH6shvqQJ76h4eK8uVnLwE6UPuX6OyWK6tq2v/ihn/krl4G4hf8/EJmHxqxtk9VT/Z/Pkqd10XRtDY5XxVrBsc7Jw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(508600001)(110136005)(2616005)(47076005)(186003)(16526019)(8676002)(316002)(81166007)(4326008)(426003)(26005)(15650500001)(70586007)(70206006)(1076003)(54906003)(5660300002)(36860700001)(7696005)(356005)(86362001)(40460700003)(8936002)(44832011)(336012)(2906002)(82310400004)(36756003)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 21:12:03.8260
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b41180-dc21-4171-d9ae-08da135b1adc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2486
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Select AMD SOCs include the ability to export capabilities that
have been activated or detected by the platform security processor.

This information is useful for both system designers as well as system
administrators to ensure that the system has been properly locked down
to their expectations.

Software such as fwupd will also be modified to use this information
as part of the calculations for a security level score that may be
presented to a user.

This series also adds the ability to detect that TSME and SME are both
activated simultaneously to notify a user.  Previously a user could turn
on TSME and SME at the same time, but the kernel was unable to detect
that TSME was enabled in the OS.

This information is evaluated "too late" right now in the kernel to stop
the kernel from enabling SME, but if that is desirable at a later time
some of the early code can be modified to read the same information and
make that decision.

Mario Limonciello (4):
  crypto: ccp: cache capability into psp device
  crypto: ccp: Export PSP security bits to userspace
  crypto: ccp: Allow PSP driver to load without SEV/TEE support
  crypto: ccp: When TSME and SME both detected notify user

 Documentation/ABI/testing/sysfs-driver-ccp | 87 ++++++++++++++++++++++
 drivers/crypto/ccp/psp-dev.c               | 49 +++++-------
 drivers/crypto/ccp/psp-dev.h               | 22 ++++++
 drivers/crypto/ccp/sp-pci.c                | 62 +++++++++++++++
 4 files changed, 189 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-ccp

-- 
2.34.1

