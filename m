Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E8853FDCF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 13:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243124AbiFGLra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 07:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243088AbiFGLrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 07:47:15 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBDB24E;
        Tue,  7 Jun 2022 04:47:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6xNzqISXgjU7tPWJ09s0XrtuA7Y0CNJNznXFma9u7HO0YKstIyNnhHLDFozo88a+DEc1HQUihNiAVoRU95O8ebtuv9w1/OVnvwA+/5eVwkWfsWlFlERnqxVoc58bJ2AURTEjAygMCvcE2Pgbrt+txXnG9Jqx38rYxTlCJKzcPi0pOYvRlno0zhYvDWC3LQwLsRibQfrD71ZQPoQOSiWM+Qav70D/PpBwz9kTLFDsNif67FpYkRpHOMwK+eUUrkuj+75nJEmCT+9CA2Qqtbb8frjNEtAANqI2mIg2Xgaq+Rr+EH7lJ/pAl5qSOBaNMn759IPHmZLM54H8CbgHbBgHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=satYG4o/8g1NzPl1yoDs3GMB205kYvZT+Iv63Kpjov8=;
 b=WALMYHFOkPKrdreyA5N3Hc1nMkv+05geMx8c05h09RlWMXghycQ9Qt6P4xRdtDo+ZoDYJr49sv2GzZ/h+SkqeIKJQEndmlrPC+4yaExhYqKTgouoHdFdu5mHfg6hLaOtQ512owAHC9zBLH/zRJbeWIO+S+sm/VlXa+QZ439IJN9uEOwMwQXcRfPrqryfTUVa8qnNv3ke/MHlRhGbcUloA3VbXzROtrYErlyKPkfP+NLPoChZ9xfBQSDidjAou+FL3No/RlX/xTvBEXdrugSqYd80w7EM8XYcybDLdgCeMhzrXUIBzEZhAYGwfRv5YK+ZPhfDnP+ta2EFOs0hZMtbbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=satYG4o/8g1NzPl1yoDs3GMB205kYvZT+Iv63Kpjov8=;
 b=YgjUtJSEHcZfjyR9ajcuB9qonLSMJdiHYfDS8mDZq7oyhmCMPTII2i8jYnbcXtBCmfunjuLNvfy/NGec2VH/MN5vv6mFOMOrcQCvI63H33LX/mxxSyg/gyXmR9KVI2CTPhU4cUmsNfCGpvLBwrAS2yKwbvlKghR6Eqt0Sxofp8mb6Vr2ZyntDoqvfRkdiDu6d8buh6toKZ5nobVAdAe/G1h3u7QQ97BravOAyOBfaO1ZJTUuSYCf45bAM6S5iya53T01Of7eEk3vKDTe/wPQeGjTgulbHj843fTSjuJWWmmcU1wXWojgcK7cn4eIu+9XX0LgahBu62DG1ybsexAKug==
Received: from MW4PR03CA0345.namprd03.prod.outlook.com (2603:10b6:303:dc::20)
 by BYAPR12MB3415.namprd12.prod.outlook.com (2603:10b6:a03:d5::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15; Tue, 7 Jun
 2022 11:47:08 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::c5) by MW4PR03CA0345.outlook.office365.com
 (2603:10b6:303:dc::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Tue, 7 Jun 2022 11:47:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5314.12 via Frontend Transport; Tue, 7 Jun 2022 11:47:08 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Tue, 7 Jun 2022 11:47:08 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 7 Jun 2022 04:47:06 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Tue, 7 Jun 2022 04:47:03 -0700
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <broonie@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <ashishsingha@nvidia.com>,
        <robh+dt@kernel.org>
CC:     <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Krishna Yarlagadda" <kyarlagadda@nvidia.com>
Subject: [Patch V3 0/3] spi: tegra quad: Add Tegra Grace features
Date:   Tue, 7 Jun 2022 17:16:56 +0530
Message-ID: <20220607114659.54314-1-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cdc0e2da-173f-463b-325c-08da487b73c8
X-MS-TrafficTypeDiagnostic: BYAPR12MB3415:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3415CA7832E5FF39CF021EC1C3A59@BYAPR12MB3415.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5PAnUM7RaFIH50QrMvC0iZHA0Ukiy9u9nil/FBJbZ18TzrZ/CGK8azFUuaNkv6WuneNXgZHtyu07+bdFj3Jv1qlyy9wS+PcmZaMUJO7wTL2V7wUGjU90Rt+319NZTGT6mKyxgV+Do5CogdH7xglbwXV8PZ3Fq8yhStonuH/I+7rP4/7a7XaXhbJsTR7izHI29Pt5tryZkEYZSOlESJh21OVwy+SgqGWTtm0NXzfupdcDPDkJ3Ro7l2jPU0V7ZxAESDTYCeZiB8cC6gr67sfLHRR9gJbPOLJM6X3kw0oY/Gk1Km3Ag3JN/0w23ISrtpqgsQaj28NphbtwQA1pPEoAWnbBhj1+uE4GaqeOdiFNpucPNN88AEgn+vPgIq1otGhpvOCdOMklw7ovsAag3Il0TvwZ8bjf7Kk1E3O/iSjauJspADNP5A415mejIvLzD7wlIf+c9pkJ7MTTqqs706wJ+/X71Tygt/RnEaJKaCHLmVUXmKNlyDR4vqwjL9ptm16OIUvoJLuTbq30fhsdVBTsN8GKI4kWO5bB6FIMl/e5M3uZ50Z7HO3/xrAo1e/xmW5vNO7ED5st7Khm8aVPbX6OiFgNXT5Tk2mEUkfhXK6RlHVZUKdLoPd0uiiBqK60LgTO36DXuPF+MxlZMPdNNykrCiRQk6z9ShNNfnjFjrfXLlAVFZQrKxTvWBrjw6zFYiyM2LI6fNzGgvDpxBfZwIh/pw==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(54906003)(110136005)(5660300002)(316002)(8936002)(70586007)(70206006)(81166007)(356005)(36756003)(8676002)(4744005)(4326008)(6666004)(426003)(336012)(186003)(26005)(107886003)(47076005)(2616005)(1076003)(7696005)(86362001)(83380400001)(82310400005)(40460700003)(2906002)(36860700001)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 11:47:08.6086
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdc0e2da-173f-463b-325c-08da487b73c8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3415
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add multiple chip select lines supported on Tegra 241

Changes in v3:
Handle review comments.
Move controller's properties to "nvidia,tegra210-quad.yaml".
Fix style errors in peripheral yaml doc.
Changes in v2:
Split Wait polling changes to be handled later
Change chip name to convention followed (Grace to 241)
Add tegra qspi peripherals yaml file

Krishna Yarlagadda (3):
  spi: tegra210-quad: Multi-cs support
  spi: dt-bindings: split peripheral prods
  spi: dt-bindings: Add compatible for Tegra241 QSPI

 ...nvidia,tegra210-quad-peripheral-props.yaml | 33 +++++++++++++++++++
 .../bindings/spi/nvidia,tegra210-quad.yaml    | 22 +------------
 .../bindings/spi/spi-peripheral-props.yaml    |  1 +
 drivers/spi/spi-tegra210-quad.c               | 33 +++++++++++++++++--
 4 files changed, 66 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/nvidia,tegra210-quad-peripheral-props.yaml

-- 
2.17.1

