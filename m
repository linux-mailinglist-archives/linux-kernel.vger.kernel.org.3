Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6DCB5A8D87
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 07:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbiIAFrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 01:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbiIAFrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 01:47:47 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42AB1166E5;
        Wed, 31 Aug 2022 22:47:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a96yNSzEJ79X5MXRRhEVydOUo6/eUyp4qstojTOSwlpZsyyuz/i1Rmt13jA5EHaUTK5kBmDqfIbUKy/7etuWBCm6uvS9j711+4pXECOiUM9qkYA0P28+huGKZvK+9RCck5tcoOjMQKSJq0T2hxFoD9mbh+zUCYWQR0HjR/9DpSf6OoimWv761v2dhYVeTtULC/t0Tj+sk1BNPCZOrbbT9S+1kzyXzZks89HEKMzclcakkWqiEv7E6okNr5e6CtesLyEgzNj5eXKyhpkUGHfSH88yFKeOGQxHMMBEBFmcmgNAjeOWB/eneBr3d7pmuWxGOuSVwShDNyxuIu9h07QwOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EmB6ONnzMqepefRTO24y/1dfryzwxL8VM7b188uJcPc=;
 b=F83eeXBw9iradirZw4trN/ByqblrAckiVNn7UMb1beYwS5qmvA5kz673GCYbirj523bSAQucfOr2/MafAGPNFLSHqqkupV78ytTQFd/0PNtIyAOJI2RnsHfQ7ZDxsMDUHaDk37iOkYGZwcq5VYVm0upfi0G0JJf4oHJrHAEjUWm/X04k78jygz22TlbQC6ktYi90zISs4S1R/nSQfYfSKO8ozkCNuqSDXHGM6s4djReDVW49V+nBh9xRNmWpQn0a+bSXxPu4XIjZP8zWBOljPm79+IVncfUi6WUA60QwSRP9vWA5+t+fL5aIBxzZxi5OAvhYudMJKZFu/NCF8MMTSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmB6ONnzMqepefRTO24y/1dfryzwxL8VM7b188uJcPc=;
 b=OXnpRhHzrGOtYVobGioRSB3D7mAPfFERucNYjqbfwvVG/fTl2j0SQ/Ee0sObJsQYubbM32QmDt24cSUtcZUB/6FoGSLGuJZJODiQewvPkVNt5801Hmu+0rzmqX+edkL0/MGHKiRSTVO0DQlH4KaVUYHYlAG8EsyvCdQ/6pgRKUY=
Received: from DS7PR05CA0107.namprd05.prod.outlook.com (2603:10b6:8:56::25) by
 SJ0PR02MB7150.namprd02.prod.outlook.com (2603:10b6:a03:29a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 1 Sep
 2022 05:47:40 +0000
Received: from DM3NAM02FT008.eop-nam02.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::44) by DS7PR05CA0107.outlook.office365.com
 (2603:10b6:8:56::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.5 via Frontend
 Transport; Thu, 1 Sep 2022 05:47:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT008.mail.protection.outlook.com (10.13.5.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Thu, 1 Sep 2022 05:47:40 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 31 Aug 2022 22:47:39 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2507.6 via Frontend Transport; Wed, 31 Aug 2022 22:47:39 -0700
Envelope-to: broonie@kernel.org,
 robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 git@amd.com,
 michal.simek@amd.com,
 linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 akumarma@amd.com
Received: from [10.140.6.18] (port=60724 helo=xhdlakshmis40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1oTd3D-000Eqz-DB; Wed, 31 Aug 2022 22:47:39 -0700
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <git@amd.com>, <michal.simek@amd.com>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <akumarma@amd.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Subject: [PATCH 1/7] spi: spi-zynqmp-gqspi: Fix kernel-doc warnings
Date:   Thu, 1 Sep 2022 11:17:25 +0530
Message-ID: <20220901054731.7705-2-amit.kumar-mahapatra@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220901054731.7705-1-amit.kumar-mahapatra@xilinx.com>
References: <20220901054731.7705-1-amit.kumar-mahapatra@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fca99d2-9988-4549-34a4-08da8bdd7bab
X-MS-TrafficTypeDiagnostic: SJ0PR02MB7150:EE_
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: squt+33lPETo/2x0pZcUwgi9+2h9aqodPuShaUtxBRP8wp5kpCDrV30U9ijACWIf7SH2l6FPbor64otBF7N870zMoxxoo8Gl5FfzUeNzZzx4cb/06bzyQqk9fhzgjyCN11i0aMne5o7tI/VB1mQ4Kp0yYMeTPDcDtjpgg1QHmPjgIO6hqnHUJ8ugAuaNPn/p/qbq2OycXSQjhueYdw+835dj9zHugeRWkuuAy5t4QNab2tRMLHJY0QmodbbG9JYaUNu+qfnsQeLqN2Ekii+dX2OyyumasQ3iHuvJdoJ8eICVGEqrc5J6aA9cl0Y8AtpqMdnAMJxtygB6wx+jx4mOjmKePjrXqbmKnKwwZhZ8atPhr/qClnY6Egk1X+i5cjfp2BhDRc4mjKfKxI6SQgiwdY/p6Abg2Gbj6qtkHgvgwQMuQ3qeRjpDm20vKI2EhBGpKb25J2OeRpZDNXPsYJPSKvASgKaVZSzbF8M1xulHiPuYXBtisD70mQQbRAvbrrBzYsAGn3C/BTXoFYWm/PfWLtRIL7RuAUHjRZF6d6StzZ59z/mNoQQzxMWshf1dZAwtQckTOUEEYw+RxEaq5Wnq4LOndEuhTP/XnYpr2tEIiqawRiw5NQ628UmYTiXPTDh2WW9fPPy223VsJk7krxEYbGog4p+bN3IdQLvrj1mj5oNdnEOVNkm0/OpN1GPmkWYGuQA0lhnbnyeGgyaxq+HZN5/KAPSPVOnFQXQv2mEdGnupP9FwETQ/K2BSFqAVi9m4FJ1ltzXmbGVXc8evGJe1z8hBJmC9Ix0fQRSfVs4ZeNg=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(136003)(346002)(376002)(36840700001)(40470700004)(46966006)(2906002)(82310400005)(40480700001)(4326008)(8676002)(70586007)(70206006)(8936002)(54906003)(26005)(7696005)(316002)(6666004)(110136005)(41300700001)(107886003)(478600001)(83380400001)(40460700003)(47076005)(336012)(2616005)(36860700001)(356005)(426003)(186003)(1076003)(36756003)(7636003)(9786002)(82740400003)(7416002)(5660300002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 05:47:40.4103
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fca99d2-9988-4549-34a4-08da8bdd7bab
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT008.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7150
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document zynqmp_qspi ctrl and op_lock member description. It also adds
return documentation for 'zynqmp_qspi_setuprxdma' and zynqmp_qspi_read_op.

Fixes below kernel-doc warnings-

spi-zynqmp-gqspi.c:178: warning: Function parameter or member 'ctlr' not
described in 'zynqmp_qspi'
spi-zynqmp-gqspi.c:178: warning: Function parameter or member 'op_lock'
not described in 'zynqmp_qspi'

spi-zynqmp-gqspi.c:737: warning: No description found for return value of
'zynqmp_qspi_setuprxdma'
spi-zynqmp-gqspi.c:822: warning: No description found for return value of
'zynqmp_qspi_read_op'

Signed-off-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 2b5afae8ff7f..b07bb97cf874 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -139,6 +139,7 @@ enum mode_type {GQSPI_MODE_IO, GQSPI_MODE_DMA};
 
 /**
  * struct zynqmp_qspi - Defines qspi driver instance
+ * @ctlr:		Pointer to the spi controller information
  * @regs:		Virtual address of the QSPI controller registers
  * @refclk:		Pointer to the peripheral clock
  * @pclk:		Pointer to the APB clock
@@ -155,6 +156,7 @@ enum mode_type {GQSPI_MODE_IO, GQSPI_MODE_DMA};
  * @genfifoentry:	Used for storing the genfifoentry instruction.
  * @mode:		Defines the mode in which QSPI is operating
  * @data_completion:	completion structure
+ * @op_lock:		Operational lock
  */
 struct zynqmp_qspi {
 	struct spi_controller *ctlr;
@@ -732,6 +734,8 @@ static irqreturn_t zynqmp_qspi_irq(int irq, void *dev_id)
 /**
  * zynqmp_qspi_setuprxdma - This function sets up the RX DMA operation
  * @xqspi:	xqspi is a pointer to the GQSPI instance.
+ *
+ * Return:	0 on success; error value otherwise.
  */
 static int zynqmp_qspi_setuprxdma(struct zynqmp_qspi *xqspi)
 {
@@ -816,6 +820,8 @@ static void zynqmp_qspi_write_op(struct zynqmp_qspi *xqspi, u8 tx_nbits,
  * @rx_nbits:	Receive buswidth.
  * @genfifoentry:	genfifoentry is pointer to the variable in which
  *			GENFIFO	mask is returned to calling function
+ *
+ * Return:	0 on success; error value otherwise.
  */
 static int zynqmp_qspi_read_op(struct zynqmp_qspi *xqspi, u8 rx_nbits,
 				u32 genfifoentry)
-- 
2.17.1

