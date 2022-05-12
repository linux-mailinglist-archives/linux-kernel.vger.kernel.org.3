Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5DB52487F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 11:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244199AbiELJBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 05:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351776AbiELJBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 05:01:36 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CB83DDC2;
        Thu, 12 May 2022 02:01:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lEaIUzAvuHMOYKX0bPVSas7bW1fIa21uajDHZuzePYaXQ/fSWNUgRYOvswx6IEzhpcX5vCwW3youEFL2GUMJ8SpaLaRKCTnBCpWjdEXQmCv305LKw9MSjJ0q67ZKwnbR7wWe0qvzQG+05tbFq1ROVtI3I3qNV4rNKDLF/OqMIJnQJzWr902ws53oM8XMLrkprO7ajwCAOH4r5g8JftSBW5woWYuNm20rh5CTD6KQINZDM14xiK6eU5FrRilEdHd7XCOD9SVkAfPEqSoG4jZl2CNJITCTPiowQRlYCdHJZTGxa/oS3qiL0N3/Q+TMHNBhsxRqZNzakZi/bV7SAMeQFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/GggGl32TH0MnE+38mh4T+yfFrxBJP6cm+Jq/+922U=;
 b=eAAmu17I11DVux7nVDpOQULLfH194Xg9k4Y3BOrfphXcQDKehV5X3K7rusP0ZR0HMTniNNWbseuVY21OWOwZtNpndO4lL0D8c0ih87gpmK3Ezedq3WLqId34KRUVPN1yvc0zFQ3Y/5G0ufU9AkBFr1u7tsBsyhTNWARi7lOUcuqgjfaqcdAlSvic3ljkVbEfR3REze4TsodQrdY0lYwQN3NKDTPClpegDdNtA648h6mYjIDt1+Mjxz/HUyB7mvF4mv92MjxoDY5vCn4Hu9iXkBOnkp4DkE7RKw9ca5aPtDtL1ch1v643Wyqccg+QfJGZ2CFhX+sXoLQLYoJu7xB6Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/GggGl32TH0MnE+38mh4T+yfFrxBJP6cm+Jq/+922U=;
 b=SimJAFZL6cgVyR3DpqsDugivzpRfvvno7dU6Z3KHTLakKJtNTcHstRUbpyVSaYaMyGUV7GD4iD9MOMpPXKQYUaPZCeBy2Xl5UOJ7KRwxYeSbs66GsVPWJkBEnfyEU+YNqrgI9D+Dj/ebn4Zt+n1zwBVVsQsoqfCQ5Gj560Tf9Ncz8tgWdoXqD/uxCxPGwFs88GgwQO0xmdT3N4GUwNFInhB6hxvWUKtQZNUP3cYjtkcOm9GD0Gh34VU1uZnoFyBaUBFqtJI9lmZNA2V0YHG/1yjjvdAjgbubLncD/jyyjqJ0moQkbZ10ea+2cvAJE09CJwzuKoAPCFtWVlU9EUZtxA==
Received: from MW4PR03CA0310.namprd03.prod.outlook.com (2603:10b6:303:dd::15)
 by SA0PR12MB4573.namprd12.prod.outlook.com (2603:10b6:806:9c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Thu, 12 May
 2022 09:01:29 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::a6) by MW4PR03CA0310.outlook.office365.com
 (2603:10b6:303:dd::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22 via Frontend
 Transport; Thu, 12 May 2022 09:01:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5250.13 via Frontend Transport; Thu, 12 May 2022 09:01:28 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Thu, 12 May 2022 09:01:01 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 12 May 2022 02:01:01 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Thu, 12 May 2022 02:00:59 -0700
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH 0/2] Add GPCDMA support for Tegra234
Date:   Thu, 12 May 2022 14:30:50 +0530
Message-ID: <20220512090052.47840-1-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a1d22bd-806c-4943-316d-08da33f60068
X-MS-TrafficTypeDiagnostic: SA0PR12MB4573:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB45731B4C5B145819EB4101AEC0CB9@SA0PR12MB4573.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9SwiCHdehiEkDVbEuLtuXoeqTDgXMeibTNRiNnsjZ7A3Feo2q3rOY76p/ZeZjJE1NVhGlg49Oi16BbQNjI4c6G+y5PhY8dyeax3bsDaqUQYuuh+O61tcPH9wXKWlexntY0juC5C+aX+Wj8Lo0ylsA3xdqCniuU1ebRYLw6upeqP030M+e7P7sp22uveocTxVlF96MTxYLxSXVdadBhMfHK+Cfm6cntHDe1CJ0VwhMR9+oOBzJbvEfXyM05tF9AL7NzwweaWbCQzbNmXmy1qQzSRuoa2GtoasIffsUwpZ3T41ipOml93JZegPS1OcBOlh6KS9sjWMMnB4dhWIqZDSW9DQMjGHmRlQmSadVEKRer7SZJWV/kwu+rL7osy2wgbEzblBiMqBbh0uWBIKhEaOL44eHlWRShpFwR+rvx+plR0jPOwH9elKBVHGREwh2/BGq9ZF9bu4xHLzOaTrj1NNdluFFzivkI+m21gFQRZnGvXIzOwdoy7ehL1EtbTZkZaS9Al7U9AcppWhWllaRfDxA7hrSvC8KvG8SIuqSb4690KYj2/Syh5lAbSHggArK/ng+DIivY9ufosSjHpLyXqOuBk7Nl5LIlczu0lKdzk2rn+J4nYOh25AS1astqizbpfcEwpL+87n7sqHYDA4K+BXnqxPRxFDwWDC8y1RtZtU0NWVbRQKfsoPy71FOh7AEhzkBt3oi/XvP2CWl6OGWQMzTw==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(81166007)(7696005)(4744005)(8676002)(4326008)(356005)(70586007)(70206006)(6666004)(426003)(336012)(508600001)(40460700003)(8936002)(26005)(86362001)(5660300002)(107886003)(186003)(1076003)(2906002)(2616005)(316002)(36860700001)(36756003)(110136005)(47076005)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 09:01:28.6896
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a1d22bd-806c-4943-316d-08da33f60068
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4573
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add headers and device tree node to support GPCDMA in Tegra234

Akhil R (2):
  dt-bindings: Add headers for Tegra234 GPCDMA
  arm64: tegra: Add Tegra234 GPCDMA device tree node

 arch/arm64/boot/dts/nvidia/tegra234.dtsi   | 43 ++++++++++++++++++++++
 include/dt-bindings/memory/tegra234-mc.h   |  1 +
 include/dt-bindings/reset/tegra234-reset.h |  1 +
 3 files changed, 45 insertions(+)

-- 
2.17.1

