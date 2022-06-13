Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3B45496FC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241573AbiFMPXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 11:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239612AbiFMPWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 11:22:47 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DC5133930;
        Mon, 13 Jun 2022 05:48:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hxIFCkf9VbSovbfIgQJIeqph8Bq2yjTIiwjPVK1Jgl4gSackC8AkmX7qL1dUIORQ9L4ND9jMrjX/4g7mfVoMhWmeNHppbDilYccxc6JJ2K6J9xPKAs/TvaGVbRph6a9tQ8MJ//H1ce0OeoV7U3S10cNspOqaNJVS8vuNc6mkMpT5X7siTgR5nt6D6eF/XzrQ7ZPAvwtVtQ9M3lag8WJYIa2R7mvbmToa1P9Q25hk5UlQFFgzqcMcv+4rtJ1UopN3OP/eEHCQYN0Nhu4qEK20n3YxZDpT7wGFJUImLMf6vEkGawhmLT2IH8CD+yr7CL05XDwzlNUpJLT/79FWVfZLUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EpYJqiJkkC6IgmQoVBFPSLCMeFkAmqlXucJsN5YMtjM=;
 b=SSd/8aBfT/Ug7l05lEXkfJs9ycACO4pP/zgA8+XC/K5ORPfi1LMsORhZ+KAp/+lyzCN+Vs1idY03iAbH/LIiiTcbpxGsQKTGpNkCwKrm+uc5uG0zOMSUE2fTtHvtQ6GN+TBUQQQEgy4x307GwyKkAI42XfS6Pb9+lKaU/O32WC6o1caAxHMJ5HmyDP1e4pfwRKIvJPduKMG5WFCrjDW+bqUJw5seqcEj9ePK7xN/Ywe/TVecyzhFFklXr1v6Ai0o7Chi4UMSNGhskqBmFLXUFX7rUloLUbhtI/yCoQRGRpPystsw0b5bhnY3vriYYdeQAf4Esl0I78s+IQtAzbnJ7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpYJqiJkkC6IgmQoVBFPSLCMeFkAmqlXucJsN5YMtjM=;
 b=TNW/HlbDcSgRlXPf9x8n6BkXoWCKHS/EIOTizmZGpxJpleml6P+465wLr8hMc/xeZN2f2VhYWft9X+tiAlM7+nDfovN5RZ2Jwmog2XHTyxYjbA0G3WH3yQsaYE5xgRtH83eAqaViTCvPJbM4EqjVnA+beoyJwTe/qB4ZYaFcAhs=
Received: from BN9PR03CA0305.namprd03.prod.outlook.com (2603:10b6:408:112::10)
 by DM6PR02MB4250.namprd02.prod.outlook.com (2603:10b6:5:9a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.17; Mon, 13 Jun
 2022 12:48:02 +0000
Received: from BN1NAM02FT049.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::23) by BN9PR03CA0305.outlook.office365.com
 (2603:10b6:408:112::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13 via Frontend
 Transport; Mon, 13 Jun 2022 12:48:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT049.mail.protection.outlook.com (10.13.2.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Mon, 13 Jun 2022 12:48:02 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 13 Jun 2022 05:47:57 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 13 Jun 2022 05:47:57 -0700
Envelope-to: git@xilinx.com,
 gregkh@linuxfoundation.org,
 robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 balbi@kernel.org,
 linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.18] (port=39406 helo=xhdlakshmis40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <piyush.mehta@xilinx.com>)
        id 1o0jU4-000A8B-3K; Mon, 13 Jun 2022 05:47:56 -0700
From:   Piyush Mehta <piyush.mehta@xilinx.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <balbi@kernel.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <michal.simek@xilinx.com>
CC:     <git@xilinx.com>, <sivadur@xilinx.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>
Subject: [PATCH 0/2]  usb: dwc3: core: Enable GUCTL1 bit 10 for fixing crc error after resume
Date:   Mon, 13 Jun 2022 18:17:01 +0530
Message-ID: <20220613124703.4493-1-piyush.mehta@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5aa0ef1-a564-49ef-bde7-08da4d3af41c
X-MS-TrafficTypeDiagnostic: DM6PR02MB4250:EE_
X-Microsoft-Antispam-PRVS: <DM6PR02MB42507FEA7029E105EB002F98D4AB9@DM6PR02MB4250.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uHAxlZ/DRSwzu1j3EIlngfso/1ipZ4NO/2IBbra0WWAofk3HCM6QEGLhUQK1lVUFu25S/jplm1YO1cE9rgdSIVj5Xs9ZhwI/01C+Ymk7kh7w3+ZPMi8vf1cbvIYso2exlMfKp92WBOlOvF9XSxX1LBj0PW63iVeuKHFo9xsnt3F+a/gr29WuAesiB49h2w3SJAcF0kxXwrhkFMTr5l8d+FZ1h0vz1Ve7jk5DWEHDf5kwF/MqC3/XqGHkrf+T5Eg1+Y0bkV4+fNalkm7f4ZSsYz3yIL/9ZoNumw+lgrG5BizZ5NFcXIHkNKCfTuL7hEBo9n/LQBAG9W+qODVAIWa9KcPX4GG+67LPpv4YqNwOaI0b+8C4FN3YFoZEE71NGAPDLD+iY7KWF5Nh8lsVZ8Y2BmVZ7PcKhrfCnTl6vTqYd6d7tLoVc5MM0FL0mf76+Bs29EufNiPhUu2qSYOZLOGV8oiBU0mindNO7kWNw+V/xREF/cbAda6uqk1ZpRkvG0h2ntNywaaha7Ar/5TXbDG4X1BiMhmxBBJhkxPV+sb1CydX9rubZdiEL5IJMtPnpbnlvEIMzuqqrha8sTQDkwsSZSqzHukSy/yknsDRxnLAiKKkdu49MFMqQ4Kajgld58sB4XPZQW5lUFvDSiSyRh8F3PY6iJEQeqJSl5V/UjcO2p++VNf/QA8XIunBmJojz9FOUMH8OyFFT6Pd6rbEg/g3UQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(40470700004)(36840700001)(46966006)(7696005)(4744005)(6666004)(36860700001)(70206006)(2906002)(82310400005)(26005)(70586007)(316002)(44832011)(110136005)(6636002)(54906003)(8936002)(2616005)(7636003)(36756003)(186003)(107886003)(1076003)(5660300002)(40460700003)(426003)(336012)(47076005)(356005)(9786002)(508600001)(4326008)(8676002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 12:48:02.3750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5aa0ef1-a564-49ef-bde7-08da4d3af41c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT049.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4250
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch of the series does the following:
- Add a new DT "snps,enable_guctl1_resume_quirk" quirk
- Enable GUCTL1 bit 10 for fixing crc error after resume bug
  When this bit is set to '1', the ULPI opmode will be changed
  to 'normal' along with HS terminations after EOR.
  This option is to support certain legacy ULPI PHYs.

Piyush Mehta (2):
  dt-bindings: usb: snps,dwc3: Add 'snps,enable_guctl1_resume_quirk'
    quirk
  usb: dwc3: core: Enable GUCTL1 bit 10 for fixing crc error after
    resume bug

 .../devicetree/bindings/usb/snps,dwc3.yaml       |  6 ++++++
 drivers/usb/dwc3/core.c                          | 16 ++++++++++++++++
 drivers/usb/dwc3/core.h                          |  6 ++++++
 3 files changed, 28 insertions(+)

-- 
2.17.1

