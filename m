Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEA2529B3D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 09:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241668AbiEQHmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 03:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242624AbiEQHlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 03:41:10 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53BC483AA;
        Tue, 17 May 2022 00:41:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QiQSYuJAKfM6NeVBkwmESdnTPwvqiTIX3eUpr6BruzWXSUXwigmm4fJnFNL41SFuw7hdUHV5xyXnIPgR2vPbdg4g0q70XC351Edk72jKn7ZSeTaEUTVyuYhOY3lWvHV6vJ6r8Coy3GicGsDknIKxk/BCo/wbguRKA6DxTWyVFjYTAwYq7iUvLH7eHnjxsyek4DQ/3RR4ZDK86YtXJNqjLKw9zfLwwMwgtuKJglRO3mMsg4OwLdyIvgoRU414v9lgS5Xt55mzHrEC++ocn5bsBV/t31313NOV55OLFYwRdKOKZ3QZdkFGr+fSVzxQh9OI2LKeIsDdXe8WBLDN8JBARw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZ1sD84aEjd1mdsFmmSTopbeioZVYNjELgFYiUF5MYk=;
 b=FgiD/rCUx7Cua1FfvaC6VatO3jUeUzIwWvNeVtpMIGV0LMGUi7lVtsumU4lypIOFkNHp+Vqrgi4ClK0zDJL+utIEhnNWnWetwz1N4GUYs0OWP608xAK4TYnQSJl2OXV+LbG836UOjAJJe5R16Qz86VGevTeaTLpvC3At3iRcNiOYNTOYic7x6BVy8VdSE8B8oLaKlTPE4bKjef6jxsFUbLCCTcFTq/ff19Kj0mbsYcQmN2XjZllKrXw2HzOuvZTyTL4sbKdW4d57uQ5nCDDB+3yDFC0/RxFfrseYevUlGp2S5eLFowA5qliS/M8AwNX+lgLb/C2i02RKqhy8QHjabg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZ1sD84aEjd1mdsFmmSTopbeioZVYNjELgFYiUF5MYk=;
 b=joGXQndLx3FMKEfW8qpLrYTbtz1AtvBOhw+g39sAw8DG+u7cjT2zTbH8TumkoOCMrKNwm0UjFUukE0L2PoeF6tz8LPhmtpQ7n0I2KCryh0kqjW1oJAAzfyQ7pZElOvatz16rB0OFl3fxs5woA0XLoKb6KPdbh1Z8Ry+u9Jf2vU0qj13KXPI85bd/szZB4rBFiZhjFoq4JfXWECSTolZWx49xpjbTytFk60L/NcNeGqpSNnsWJr4mEsT8HWua2jejb1h32eY6YQvQ2fcyV2xJKVcvxLKP5Fo7iWn4RZPsqAAmHsbAxCEUjUH/oLa5iZvNTpmgLIbDZS2IfXbPig+42g==
Received: from BN0PR04CA0014.namprd04.prod.outlook.com (2603:10b6:408:ee::19)
 by CH2PR12MB4312.namprd12.prod.outlook.com (2603:10b6:610:af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Tue, 17 May
 2022 07:41:00 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::46) by BN0PR04CA0014.outlook.office365.com
 (2603:10b6:408:ee::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.15 via Frontend
 Transport; Tue, 17 May 2022 07:41:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5250.13 via Frontend Transport; Tue, 17 May 2022 07:41:00 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 DRHQMAIL109.nvidia.com (10.27.9.19) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Tue, 17 May 2022 07:40:59 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 17 May 2022 00:40:59 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Tue, 17 May 2022 00:40:57 -0700
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v2 0/2] Add GPCDMA support for Tegra234
Date:   Tue, 17 May 2022 13:10:46 +0530
Message-ID: <20220517074048.54347-1-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71caa909-3c47-4dd1-7160-08da37d89689
X-MS-TrafficTypeDiagnostic: CH2PR12MB4312:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4312ECBE3C4D84C5DED16BC3C0CE9@CH2PR12MB4312.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vcc5LQi5Xm1QOKxqmgn6yXSEDq1VOfo4+bcd4QIcvYCqFxY5X84Lplp4BucJ4/huYSftKW3LFfAtd7sXfNR8Ks8nEfS8nHua4P8KDuz2GHyDceOKIfFtfkwzzaHKEEhyChksF8iPl8aFQaOH74UZOrf+EfxrdYEILMxlei9lL1cru4HSaRJ5BoZQWNSTBqEu+6jdMPrYx/frGFb9qBv73K7r/V8trNCKclPHsfH2WaHDHlcs80groVUKQsgCVBQ0HrWTBt+AeetAhhg1rTqiHv3YkKtkomQtstOVO9KdbkS4onizNqb3/4xgCN107FyGuE7IQU0wdrvbd5W+tYOLWXojCAY4ShoD9a+dALByuR9Dmfk/IZsJH8lKNCtw0KFwJKOdOoSkKb235py9Kdiyp/Hxg2ABZXJaUGFQz8Ilb+bpGxxBWKjhdOgliV2XNZfXQdHPe+Gy8V42MMrgpCxMLclJ35sGyKrf+wgGoeTmh60wzSSHZ98PhFx7TkB6iUjG4FsQdzs8K6YXHTjQNDtrey5YK76Gqxmri6yPDKwPryJ+XjUOXOXH/CtaZgVuyGWbC/9GJ+abA3kbgb+Uvd2PvIC+wEialNu+yT249zV27X1w08iokWXOVu/XGQtSCvbZHttHtzyac40MHROAqdVFwkigmrcZI3p40eQwwHP4PLjXG82F3TC33sqBOT6sRaRhQ/kh88iM6fms2MvEEWCb+A==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(81166007)(6666004)(2906002)(186003)(1076003)(7696005)(47076005)(426003)(356005)(336012)(82310400005)(316002)(110136005)(36860700001)(86362001)(40460700003)(5660300002)(508600001)(4326008)(8676002)(70206006)(70586007)(4744005)(8936002)(26005)(107886003)(2616005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 07:41:00.2681
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71caa909-3c47-4dd1-7160-08da37d89689
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4312
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add headers and device tree node to support GPCDMA in Tegra234

v1->v2:
  * Removed 'status="okay"' since the node is enabled by default

Akhil R (2):
  dt-bindings: Add headers for Tegra234 GPCDMA
  arm64: tegra: Add Tegra234 GPCDMA device tree node

 arch/arm64/boot/dts/nvidia/tegra234.dtsi   | 42 ++++++++++++++++++++++
 include/dt-bindings/memory/tegra234-mc.h   |  1 +
 include/dt-bindings/reset/tegra234-reset.h |  1 +
 3 files changed, 44 insertions(+)

-- 
2.17.1

