Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28F654F5E5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 12:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382190AbiFQKr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 06:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382169AbiFQKrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 06:47:23 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146E86B7F1;
        Fri, 17 Jun 2022 03:47:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9TG1r+905kfPM/SMntdqBzixYbqppl25Ilql8illxBTwKDxuqDx6fEyQWE920g8qKyJQUDxBG9uwMZ76y+2HJ4JTkN0A0ZeqRslEonq8r+vm7tFKJE0eLh5k8IGeA0S65WQUVpfO/x9Gy57uZhfSGRK3Byz38GsPluC2NbDTMb4a9hA5h/iycOIoAIVo3Gct+zgJDjVnmLZIXiZfm9fQlKk/HLDA8lTqD4ZVTJZZLtcUkNpSUSSDhdeiy8GLQRSdK5ZChV+VzSr6BdckrfJSdHP/47O2Pqtuak7XxJpSLM3jAtjMQF5aSPPPvT8a3K0efCb1Of8ZczHTLH3szMvXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Odb4IuMKC+46SK664kcy7WZMI3iEcQXZdtlnoW8WVc=;
 b=ChDxOYDqBMPoGFaHeTfLxQarzFrc5UljZV5MmJF4HB4G6B2/taVWmx/8lBYubIkEIAiidyGlRPRy01EkTWuZ9qXt/IUEr++NHxc1TO/w6JLAupLFifIGNBm3SMw5EyfZgc4mg7jmZFM6Y7dY+Krx5KoNuGlmW/HyJq8yd9Bs55RlZApIpYXoscAFBve3ce5KYSp1VZYkzQv/HUdiBfIZ004c063rRCHyyTVQvSH0b4Rz83Ma7kel8Pzw0efTi+wNl54LQQ86t70JqmDxfA8MbLXgGt3VVmblVb/MAj8mUql0i4P/Z89VBwkqwPhHiNGrqJLQplN+Q3QKZtZaMmkPdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Odb4IuMKC+46SK664kcy7WZMI3iEcQXZdtlnoW8WVc=;
 b=FQteRmVyPQlXD+j6Aj/zGXch20lxGO17RalBkLSeXWLGVHGf6js+0kNYaI68Qo4nue83YW08vmTWbK2037taZV9vTNgXIEB2/QbUXtqBhzMHj3xaVZcsxRyt1KW2TOvCd9Xqao0CnF3tuhsY9Mo6N7W+24xSGumr1EfKNoMuRRs=
Received: from DM3PR11CA0002.namprd11.prod.outlook.com (2603:10b6:0:54::12) by
 MW4PR02MB7171.namprd02.prod.outlook.com (2603:10b6:303:7d::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.13; Fri, 17 Jun 2022 10:47:17 +0000
Received: from DM3NAM02FT024.eop-nam02.prod.protection.outlook.com
 (2603:10b6:0:54:cafe::ae) by DM3PR11CA0002.outlook.office365.com
 (2603:10b6:0:54::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14 via Frontend
 Transport; Fri, 17 Jun 2022 10:47:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT024.mail.protection.outlook.com (10.13.5.128) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Fri, 17 Jun 2022 10:47:17 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 17 Jun 2022 03:47:15 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 17 Jun 2022 03:47:15 -0700
Envelope-to: git@xilinx.com,
 saikrishna12468@gmail.com,
 robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 linus.walleij@linaro.org,
 linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org,
 linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.23.64.1] (port=60015 helo=xhdvnc101.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lakshmi.sai.krishna.potthuri@xilinx.com>)
        id 1o29VN-000AyD-H3; Fri, 17 Jun 2022 03:47:14 -0700
Received: by xhdvnc101.xilinx.com (Postfix, from userid 14964)
        id A5D9E215C3; Fri, 17 Jun 2022 16:17:08 +0530 (IST)
From:   Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <git@xilinx.com>,
        <saikrishna12468@gmail.com>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Subject: [PATCH 0/4] pinctrl: pinctrl-zynqmp: Add tri-state configuration support
Date:   Fri, 17 Jun 2022 16:16:55 +0530
Message-ID: <1655462819-28801-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57a7a76f-7ba4-473d-46f6-08da504ebf79
X-MS-TrafficTypeDiagnostic: MW4PR02MB7171:EE_
X-Microsoft-Antispam-PRVS: <MW4PR02MB7171936A4B692C2B2DE84722BDAF9@MW4PR02MB7171.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DwKaHAmYBAGqtnnp6vc3fBT8QU+ANJr3Lc/5LOIVpq4l7boG2g7h7cPyiP9CWSquAt1DRPXlqeM73hzGOZu1jQlRXWQkCEmJGl0trV0cbKfM8BFVAnT6ZCnHhroLT67Sub6QaYSZa/Vs1+Dw4IjFCEN/9jnq7F75MXMyZ+hkI5yZSDN9ePS1szDMv7K0bK8Vb8ALFW/Z9fog5VGf1VpviML3F7IayGLZwwShUYcbbhTmfQx5RdClVGSXbUDXp3kauFLMRsqL43rcvOOsAXbbZW4VIWaI8w4ujcQ7Tdif2LkOkLmEmRYbluq4sLa26eDmUU0WwC8XJWJ6HfZZdtChfXVK47S/YwJ96xjpqqBcCEzb1RMYbnZ/C/sR93mbXhdx/CnKLrcuqm9PzScSixWdT+bBkKnL3XnWYoSbvZtUZxSYR5Wf5YyDcoWmO+VkTju2N6rbqxr4CKBpBe4a5K3RwWNYX/MVZ3QkglauCWLcOKf9ngo72lQa97oGbmc2bV/iGm22twLdXJX8KO5xBIgCPVCp6a+tTKA3+PcJIu/3/WdWLQ3+fliGP0/hdoNqgwuxau8cEtZEDsDQWDy3wsotPOrOMz+oE8XCXoIeOu+J4eF/XlM6iB7ojg136508pc4/wChHHtPgUbPVMRyGFzvYIkg0OCKxI7epR9WxlNEGIvB/6oAhR7QGkgdd9lNp5M62PPdNONrG0t6KMXsJhZMbMQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(36840700001)(40470700004)(46966006)(6666004)(4744005)(356005)(47076005)(107886003)(5660300002)(186003)(336012)(2906002)(82310400005)(36756003)(426003)(6266002)(316002)(26005)(83380400001)(42186006)(7636003)(54906003)(36860700001)(8676002)(8936002)(498600001)(4326008)(40460700003)(70206006)(70586007)(2616005)(110136005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 10:47:17.5632
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57a7a76f-7ba4-473d-46f6-08da504ebf79
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT024.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7171
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

This series update the Xilinx firmware, ZynqMP dt-binding and ZynqMP
pinctrl driver to handle 'output-enable' and 'bias-high-impedance'
configurations. As part of these configurations, ZynqMP pinctrl driver
takes care of pin tri-state setting.
Also fix the kernel doc warning in ZynqMP pinctrl driver.

Note: Resending the series as i see this series didn't went out due
to some issue with my mail client. Please ignore if this series is 
already received.

Sai Krishna Potthuri (4):
  firmware: xilinx: Add configuration values for tri-state
  dt-bindings: pinctrl-zynqmp: Add output-enable configuration
  pinctrl: pinctrl-zynqmp: Add support for output-enable and
    bias-high-impedance
  pinctrl: pinctrl-zynqmp: Fix kernel-doc warning

 .../bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml         |  4 ++++
 drivers/pinctrl/pinctrl-zynqmp.c                      | 11 +++++++++++
 include/linux/firmware/xlnx-zynqmp.h                  |  5 +++++
 3 files changed, 20 insertions(+)

-- 
2.17.1

