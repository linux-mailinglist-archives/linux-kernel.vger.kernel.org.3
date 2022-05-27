Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B5F535E2A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 12:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350948AbiE0K02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 06:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235292AbiE0K0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 06:26:25 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37705DE7D;
        Fri, 27 May 2022 03:26:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FgPTHyC31RXk8FGE8AwOmWL+XLHj3PsJp3AiEE7YIFqaRD6Eb93fmgmYDo+Roe1omwwpfprT5IO+c05AFuTRD+v+OVNTkXhCH6G7ZDg3wVMLZc+8ET3TFZIqsMPkmTVncV8aEcp3XcZak99wTkwGqiOVspi9MU/gVnhKeSmLiUVzjB1VjUJHxPGaLmli+zPDcWiQDHxu2YYB+FZBYb0lSoWj+89uwboJXGzdQCmwQ0hyJPPvuuVxK6h07QqjXKsg1FtTi7yP+lIkcj4pbxEXYEjqKF0uJ2L8eQ052jpYpXi3PzT7U8awfvZ70vfk4OgPJoKzaiolqwpnNcVJ626Oxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqq4B6OfvsiG2rPOm66KnCCVaisQZoQZQh6TY13SjU0=;
 b=cHu8iDL+Ec0psAdP4miuBw4yCbS00UE8LK+7wUtAttuqtSiIydythxIuo8HU2mA0WaE1HfshjLZsR7DlsCg50X7CljOpL1gPpRDWsfW3Fl8DGTD6gQL87ONpljxremwxqiq4JXCO9enWvO9I6+5u2WfQN0oCqK/KVz7ZdKEYwSYCvkoIjCra1vFVcklLg8VFB5pk2WXezxn5S3LvRqI4SIOpigOmQ0murEWZQ57aWxlQcSWwHmBA6tcOzZOEUSz5CHzJqU20HVV9DSdI/CVG75p/nQdCrR37nQ8EhZQcxSwV6apWTL/FirqY9f9DMOudiuygfNIiWD/gOawLSFGQNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqq4B6OfvsiG2rPOm66KnCCVaisQZoQZQh6TY13SjU0=;
 b=ijxgQ71D+fiJwFilItsVzMYbwHzyq+go210AGrpC10zvYGayVhX1waqGTxwlbhxutqpYBo/grIyLnDgVNQUR2R1kfx4WzOD+yQfJAhQ63EEDDaV+rSJqlMqGs/uTZdTBcpBoSmCWtS1jQHEeN4mIVrYgJO5tFgSmo8JEycYxdgItZFmBWtRUE9pm39SZGqnPJpenvl+R8lvRxoSgEZl6wORWB/ywn3ylDA/KkgjZNVb/NbDecLSOfchEXSR5uA0x92+0iHeU2Q073kk9gMXS8/MBVOzBvkWqC+zWarYJ3XDIa7IWuhItW5/yFmZuNrGJ/bQKfizJioY6no9kMtTq4A==
Received: from BN6PR16CA0023.namprd16.prod.outlook.com (2603:10b6:404:f5::33)
 by CH2PR12MB4199.namprd12.prod.outlook.com (2603:10b6:610:a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Fri, 27 May
 2022 10:26:21 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:f5:cafe::df) by BN6PR16CA0023.outlook.office365.com
 (2603:10b6:404:f5::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.15 via Frontend
 Transport; Fri, 27 May 2022 10:26:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5293.13 via Frontend Transport; Fri, 27 May 2022 10:26:21 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Fri, 27 May
 2022 10:26:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 27 May
 2022 03:26:20 -0700
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Fri, 27 May
 2022 03:26:16 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <thierry.reding@gmail.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <jonathanh@nvidia.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v2 0/6] OPE support on Tegra210 and later
Date:   Fri, 27 May 2022 15:56:06 +0530
Message-ID: <1653647172-2569-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db2c9632-483b-4e16-c2a1-08da3fcb582a
X-MS-TrafficTypeDiagnostic: CH2PR12MB4199:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4199515D8A44044343562883A7D89@CH2PR12MB4199.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3C82Oinj6knCOp/NLJNGU8ABNG3MZGuTyt5tX2I4CLotTGxkSD8l6Af59LywO9DPp17/+ph/CqVF9wRNoGAH1vEp4btik+BOguN5ai214bU/R2+yVrf+C8AZtnrfBpoSb0D7WrCNyQ40YUbpNDUPuqGRz07BzeVcMZjtI1vcjL4zNmh+QSSxW7FjBiBb37aMPa7a2Ovwm5RARmIjJ5YLsFlXoIbp1MWzDS0sCk1qfGjhVlSP6YjvFkk8h1s7EZ5q5yuXsC7Ih7Yo1aQ2/zFP5Sumwt6AiM4aUUihlnRY8A5/GHna7APmP3GZYL8BPKFmrWwlxRODnra5hukMtA9EzUP6v5p6DJcvV71iRDETpwl+40q1j+kXhh7faPzG2Tl/uJyQGa4RPu5qPl7YRfGFDLc+CnO/9OI68/3Ucuztgd4yZK267Nt6PlliEqrXoTjn5pRbRFlYPH2TEW++JcycKdBSIVdbN3dP+AynLh1dZjqFzbgXNYOViCiX0pp1bd6BBoO6WSbz1vWev6wYwTT3+2wZKQudBTp0Tw+Lot+Qyah5qEoK/lZtRYv0rqtyEbMCqfCS7n777O+WVBABo4+YkkBdHI2r2za+xkU4sYuw5hS4yzQNqWc8UOTfq1EouHy9+fdP9YQOlevx+FnppG87TfUajI3rEyMfTIyZc4liaapy/aN0L2+JvwSajYWYJg2bEcQw5SXDudsbtOT/fOlj5g==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(7696005)(26005)(81166007)(2906002)(83380400001)(316002)(5660300002)(7416002)(70206006)(70586007)(107886003)(40460700003)(186003)(6666004)(2616005)(356005)(508600001)(426003)(336012)(47076005)(36756003)(8676002)(4326008)(36860700001)(54906003)(110136005)(82310400005)(8936002)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2022 10:26:21.4736
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db2c9632-483b-4e16-c2a1-08da3fcb582a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4199
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for Output Prcoessing Module (OPE) module on
Tegra210 and later generations of SoCs. OPE is a client of AHUB and it
has sub blocks of PEQ (Parametric Equalizer) and MBDRC (Multi Band
Dynamic Range Compressor) for data processing.

An ASoC component is registered for OPE, which includes PEQ and MBDRC
functions as well. This can be plugged in audio path using ALSA mixer
controls. The series adds necessary binding documentaion, driver and
DT binding patches to enable OPE module on Jetson platforms.


Changelog
=========

  v1 -> v2:
  ---------
    * Use generic node names for OPE, PEQ and MBDRC devices. Update
      binding doc and DT patches for this.
    * Remove redundant nodename rule enforcement from
      OPE, PEQ and MBDRC nodes. Update binding doc patch for this.
    * Fix spaces before binding doc examples and remove '|'
      from binding doc descriptions.

Sameer Pujar (6):
  ASoC: tegra: Add binding doc for OPE module
  ASoC: tegra: Add Tegra210 based OPE driver
  ASoC: tegra: AHUB routes for OPE module
  arm64: defconfig: Build Tegra OPE module
  arm64: tegra: Add OPE device on Tegra210 and later
  arm64: tegra: Enable OPE on various platforms

 .../bindings/sound/nvidia,tegra210-ahub.yaml       |    4 +
 .../bindings/sound/nvidia,tegra210-mbdrc.yaml      |   47 +
 .../bindings/sound/nvidia,tegra210-ope.yaml        |   87 ++
 .../bindings/sound/nvidia,tegra210-peq.yaml        |   48 +
 arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts |   43 +
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           |   23 +
 arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts |   43 +
 .../arm64/boot/dts/nvidia/tegra194-p3509-0000.dtsi |   43 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           |   23 +
 arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts |   84 ++
 arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts |   84 ++
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |   40 +
 .../dts/nvidia/tegra234-p3737-0000+p3701-0000.dts  |   43 +
 arch/arm64/boot/dts/nvidia/tegra234.dtsi           |   23 +
 arch/arm64/configs/defconfig                       |    1 +
 sound/soc/tegra/Kconfig                            |    9 +
 sound/soc/tegra/Makefile                           |    2 +
 sound/soc/tegra/tegra210_ahub.c                    |   39 +-
 sound/soc/tegra/tegra210_mbdrc.c                   | 1012 ++++++++++++++++++++
 sound/soc/tegra/tegra210_mbdrc.h                   |  215 +++++
 sound/soc/tegra/tegra210_ope.c                     |  419 ++++++++
 sound/soc/tegra/tegra210_ope.h                     |   90 ++
 sound/soc/tegra/tegra210_peq.c                     |  434 +++++++++
 sound/soc/tegra/tegra210_peq.h                     |   56 ++
 24 files changed, 2908 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra210-mbdrc.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra210-ope.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra210-peq.yaml
 create mode 100644 sound/soc/tegra/tegra210_mbdrc.c
 create mode 100644 sound/soc/tegra/tegra210_mbdrc.h
 create mode 100644 sound/soc/tegra/tegra210_ope.c
 create mode 100644 sound/soc/tegra/tegra210_ope.h
 create mode 100644 sound/soc/tegra/tegra210_peq.c
 create mode 100644 sound/soc/tegra/tegra210_peq.h

-- 
2.7.4

