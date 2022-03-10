Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30BF14D4F84
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 17:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242267AbiCJQns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 11:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiCJQnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 11:43:46 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EF512A92;
        Thu, 10 Mar 2022 08:42:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7bftQANkaR4jTrFZKv8qW0uIR2aO7W1jN/NV12tF0WD6lpAlz8rd69qIVQGzvJqgnr1fS87OYzEBfWupJ7iFWP+64GBwFrFMw8L6nGLaPhGQmjNEXcldAS/E53f9y+N0P7rV5QRmNhX7NS96mNWjyjDf5pGBLzcT6GibTK0N+GfetnPpvWxKrd28huJJHqkH7f7klRrTMiU8wr9EhhW3ISbL5LO9Bl2YsAbC5t50pBz2LaicER6QC22nL9Ym6rbNlastDUn9x/dKol7i+Z2CE0q+HgpNgN03I1yNX8my7ZRX3v4dfwjFkPF4l1N8a2Z/zZU7cbzQbgBFVpMmSAnLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eply5Q5iYu7fze5mptEdRDQnP+RNBsAnaLLFiCQJZYc=;
 b=cHCfHlNATqFN+VtJAzwZkKn9wySTAAsGSZNUjtPITEa5je8j1svFplx0iFG1ILwwQESsMXoHWeWbpViIDa98rh9wCt8uDhIIT/EkiXhaCl1Hn35zLcmA9C6jqB9vxyzs6owyzPnwfWOZLU7RakvytxLXGCyCmDPBg1+umUVoGIQZrj5vBtYTo1oTVEDNNyeD7atJqMB1a/Le/3TDoUltJ9d6B9fZMWxp1+xiHrLqIVsx5owrO9+TznaogSDNq+BsPY8WuH3uQ1Mo0P6cSr+NVJLVyjt600hTfGWhlzubGgqBGj637FKPx3ptn418C7kedW+R6c7Blx1BaRngz497RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eply5Q5iYu7fze5mptEdRDQnP+RNBsAnaLLFiCQJZYc=;
 b=c1wNhX+vtMD9njmezmBuzvXgY8cZdx5LXBEaBh6LInbfc59liwma5dHfhlF3U2JAsHGeWiLfoT+8EmF+n3iddGtNITVXquQwBVvEjKnJ5BJ3o4NlK1RgnIAuFL6JcF2syKM0ieegUXlkM/rGEZQ+M3zwezeC0h2M3zXglY5utMU=
Received: from BN0PR04CA0196.namprd04.prod.outlook.com (2603:10b6:408:e9::21)
 by SJ0PR02MB7133.namprd02.prod.outlook.com (2603:10b6:a03:2a2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Thu, 10 Mar
 2022 16:42:43 +0000
Received: from BN1NAM02FT052.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::94) by BN0PR04CA0196.outlook.office365.com
 (2603:10b6:408:e9::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Thu, 10 Mar 2022 16:42:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT052.mail.protection.outlook.com (10.13.2.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Thu, 10 Mar 2022 16:42:43 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 10 Mar 2022 08:42:42 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 10 Mar 2022 08:42:42 -0800
Envelope-to: git@xilinx.com,
 broonie@kernel.org,
 linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.18] (port=57612 helo=xhdlakshmis40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1nSLs9-0003SM-HT; Thu, 10 Mar 2022 08:42:41 -0800
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>, <akumarma@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Subject: [PATCH 0/2] spi: spi-cadence: Align function names and fix
Date:   Thu, 10 Mar 2022 22:12:33 +0530
Message-ID: <20220310164235.32230-1-amit.kumar-mahapatra@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 988ec379-aa24-4d0f-140b-08da02b4ffc0
X-MS-TrafficTypeDiagnostic: SJ0PR02MB7133:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR02MB71335C83791760CCF6FD85DABA0B9@SJ0PR02MB7133.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7zV6P+ziaBMCwVsoi7vqZHTN49m52fZL3QvqtVItsXSl/2fuKNsRFqaIN5JZ0PUDOpfBK4tM4Hj+kMSCtWaZ/0ZdD1WoLrQklpsRdDsB19rtpeEerxG7DvE2ecfrQsxJ8L8n1XizlhKCzGk4t8LsCyLwU+OZtOUu77Qj78t4pyqItURsZ1QQwWQXSrfpcLnJNYpg83WANfT57UcJZgwmukkK80aYjS9WXRnqHVu/BpXIBT+xWWi5eIRS0IvxREvHv6/vuqlcJrsM5PaMoT7gDiyXkcSCffvhpI/A0CF83FRJAFnVqWJL4YHj6IiRnysNGvC5BwKqNYqNYZHvhrrz3m3J88HoC+p6rIqNPVLUOok1vzByG779a4g2g10N1gtmpnr8o2kNDvbQ+6wPsmHukUnPGeF8pU2/Pz90F9Z3Pwv2NRu1Zdtex5FAJI7LOZ/6JwftrvDmGgFHdyiN4pqogGx7+h211tB72a7nB7ab4uolkfOy+CgVSbIQ2oPx+BbSVq9huxRMtRKrMtK3n/Vv0DoOoViJiVda+fOSylPNPBN3+kq1CDYZzL6y5hmSPsbRvMQpONmBtivXyNSMxyGj95eMaUz+sHmlxhgOLenW3oN3fUAY6Vet1QQKk5N7ut4tCRmZhVX1zSc1nKduYM6FXpaT3hU3QgIeRGBrtZ52ez11Znvbk1uIC3wUaSeT55/nFQ2Y7RoVWn1yohe7eHUbEA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(40460700003)(8936002)(9786002)(47076005)(36756003)(508600001)(2616005)(54906003)(6916009)(7696005)(316002)(6666004)(336012)(426003)(83380400001)(26005)(4326008)(186003)(8676002)(70586007)(1076003)(82310400004)(107886003)(5660300002)(70206006)(36860700001)(4744005)(7636003)(356005)(2906002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 16:42:43.3242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 988ec379-aa24-4d0f-140b-08da02b4ffc0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT052.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7133
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series
 - Aligns resume/suspend function names.
 - Fixes kernel-doc format.
---
BRANCH: mtd/next
---

Michal Simek (2):
  spi: spi-cadence: Align function name s/cnds/cdns/g
  spi: spi-cadence: Fix kernel-doc format for resume/suspend

 drivers/spi/spi-cadence.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

-- 
2.17.1

