Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787B259582A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234542AbiHPK1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234533AbiHPK1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:27:06 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BEB118DD9;
        Tue, 16 Aug 2022 01:24:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZEDn+MMpPPuhHnbRNaM0Ny661NrO9XDFJYoHpOWNYTJo5Po0vcj/xzc2Dewg5vjYrYTnx8sqYDBek3fbplegsUtenQhrAcLsZEWlmNWVVSfDuLJod8fMQqmmEiwcpH+8IfyHDW0SOfgyqvAOZ0xXDCoUJK8x5lkZXyk9LQ+c1pM+23ygYJlbT2i0DAjquIMvL+gP5Dkxx1GLZHtWPNh5v3e2VCZHZGmgk9F6qqWOn5U80h7KMOEYXKHqRZFO+tXtnxg21ROuGoe6j8RrQHZOa30SBrIQ16Od6A279AAJjrPxRixqJfqcacYxc4z3K9K7zXwhD0SZMU9HW5Psri6uBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QbSqgDbRO1qrFuSattDjN/6k3i4SwBMrEUT990l7bxQ=;
 b=D6t1HNcuVRyc1uVpzY7kV29agXWSf6Hth1new4BqBxa8EJTEepy6CHHIVzg15PYcXKhTcsUtfgLdUF7MCVvFYNOwmyAe0cVJdN4w3ncIZkM5eIOtjgGk+Rz40i9toKRoKDO6A0QylVQuBZfO/Ba49BQf2U4UOpUbyMNDQTvXhUihu3lpbQVrp1MDiLMK93MRF18OlZ4jPFjXxaI9lvo1/svcy8c8IQO6fXU/iH75BvJ4RvnxJdAWqlYIK2zlRXuXOMwg+oPAB5SXpzZLnFCL6mLitTZ3S7dwCFupkGNGV+hS0n7qJ/TtLqYUaWmRWDy5MVl6zUdsqEmmGjIYKkg0yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QbSqgDbRO1qrFuSattDjN/6k3i4SwBMrEUT990l7bxQ=;
 b=f3H8VH2ctYE24fl2vJ5vopwvrJGVeN8K7BCJmdkZMSQGmTxQrTheSB5O2yBG1wJOris0J4BWsIe4nH1L0/aIMI4FCFRouuyDtx9WhQmotyDqh0p4n9Sxsc8u8F16FYw5ODZZJ+XokfPjsxPrO0Bw58/Iuiw3x0PJ2Z1MI6NoRSp1K4vj6V51JI14dx9Dg4tOZdtoRtcUzZZXcamjaNuLnpLHIq2EVXrdHFL4iwA+nJrr/kUCodhVLulP4qquKn84ivtM8dGLHrjAx8zTbv8TY9NwM1Ody+cLDRMDPuR/zErwAte3nTT+ejr2YQcwdMbWaeFKOCFN5kWMuV/nGCi/uQ==
Received: from DS7PR07CA0004.namprd07.prod.outlook.com (2603:10b6:5:3af::13)
 by BN6PR1201MB0004.namprd12.prod.outlook.com (2603:10b6:404:ac::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Tue, 16 Aug
 2022 08:24:01 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::f5) by DS7PR07CA0004.outlook.office365.com
 (2603:10b6:5:3af::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10 via Frontend
 Transport; Tue, 16 Aug 2022 08:24:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5525.11 via Frontend Transport; Tue, 16 Aug 2022 08:24:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Tue, 16 Aug
 2022 08:23:59 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 16 Aug
 2022 01:23:58 -0700
Received: from jilin-desktop.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 16 Aug 2022 01:23:56 -0700
From:   Jim Lin <jilin@nvidia.com>
To:     <jckuo@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <vkoul@kernel.org>, <balbi@kernel.org>,
        <gregkh@linuxfoundation.org>, <jilin@nvidia.com>,
        <bhsieh@nvidia.com>, <linux-phy@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Subject: [PATCH v2 0/2] usb: tegra: power down UTMI pad
Date:   Tue, 16 Aug 2022 16:23:51 +0800
Message-ID: <20220816082353.13390-1-jilin@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3407395d-378a-464b-fa0e-08da7f60ac6f
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0004:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zTAgtGPQocCTpqOaQ2n+4XJBRDPL5HXBJ4FXNytfIQhgSyGwB+aIYaUjdsEr+ahRze8u0kJTU87Jm8KzUDiZ83W4UUOMG6iv0yhXjycvFXLX32rSgbANtJ8MTVQLMlW+GPNL3HTigzVButfCj2NzADEUsFT8aUWMNrOFVXsoEIUpCbyKjRH6bZlyAYNkWt+NiSB7RjWWParDsKeCjBEJvcAy3cnQJ+V79IJYChy/FXXNstnMM5CetTGk14TdFwKZ72KiVKsreha7+czJsehSNba1Nht8PSpub+lpfFHTWIjFP3l8E0qMnSpbtvBrCt/zUesecD7zSLHmgW4Ozh9qN9hhzPHE/Z0OHaiTol20m+LBXSlBLWqOKhbnMcw8xTdVSleuaamC3ZilonoMq+rJSknloNqlXD6d1WEiIsp8Uc2OaFwftwg7S+YaN/IEBhSJ+OvlqezrSKuyywsW9cXlFQr6MjvCzjGSpqmYYO+8PPBVl6ouJYcBJO/Tyqo2riGQXRWGbO0dNItr/1mylz18oBdKaAB1VEAvKYYyHNm6BVSIzKTxzp9SOzvjbeuPfkURNRFpWapMrad4shqmNb0WzfEhsKSeGa+5cJ8tckAYawaHhdBKnCzZolWYjaIho/aYmzrW5MaOD4BqexaLAeXkXOpPtckEpdoKFnc97K4Bo1srN4lqFGYlVDih6DKMleKKPRXca+5NLAvlLz5Scefl6QXu80AUx36/fXVvUz3UkYTDLcI0Y8E8KRmyC+V7ejwIIM7eqxoJo6UO5VWipz8yqBmUIYoNyLt3QRLcRFzJseaf2U0/YJROjN4KohoPMGtw9rptfKCVwoLyzpJpMcw+dg==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(39860400002)(136003)(346002)(36840700001)(40470700004)(46966006)(336012)(7696005)(6666004)(36756003)(86362001)(41300700001)(186003)(47076005)(83380400001)(1076003)(110136005)(426003)(478600001)(2616005)(26005)(40460700003)(36860700001)(316002)(6636002)(82740400003)(2906002)(8676002)(70206006)(40480700001)(54906003)(70586007)(4744005)(4326008)(5660300002)(356005)(81166007)(8936002)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 08:24:01.1704
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3407395d-378a-464b-fa0e-08da7f60ac6f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0004
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Make functions to be generic and public for tegra host/gadget driver 
 to power on/down UTMI pad
2. For tegra gadget driver to power down pad after disconnected
--
v2: update copyright year
    drivers/usb/gadget/udc/tegra-xudc.c
    include/linux/phy/tegra/xusb.h

Jim Lin (2):
  phy: tegra: xusb: add utmi pad power on/down ops
  usb: gadget: tegra: Reduce pad power

 drivers/phy/tegra/xusb-tegra186.c   | 19 ++++++++++++-------
 drivers/phy/tegra/xusb.c            | 22 +++++++++++++++++++++-
 drivers/phy/tegra/xusb.h            |  4 +++-
 drivers/usb/gadget/udc/tegra-xudc.c |  6 +++++-
 include/linux/phy/tegra/xusb.h      |  4 +++-
 5 files changed, 44 insertions(+), 11 deletions(-)

-- 
2.17.1

