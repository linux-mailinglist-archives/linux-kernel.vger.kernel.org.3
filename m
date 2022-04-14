Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489D3500701
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 09:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240408AbiDNHii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 03:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237526AbiDNHid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 03:38:33 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203F31FA69;
        Thu, 14 Apr 2022 00:36:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJuHpY9bO/2Lx13KS7VftZMtjL7VrOoMNEh1NrgsizCE/LEgKJKYPYXB6NihpEDVLrSmjDmjk9Tnvgwh6iFsawrp1+VmJ27O1BedZb1clTT5SYPyQjzBqbnes0Fdl06+Dps/gz/Cs33aVyYN/9b917P84CGcxfz3c0HX+qCrrA1z/3E2awBboPWaqNoPEJKw8VZa1l4iWCfPn4If/GvdvzSj+zmQKJAqmFLVS1bjOYyci9MMFHj2Uatmm36Gpw+AdENev5urVU3qGeekZDEO8bxkE4Z/P8lkcXh/vLyz8lOFqrvXcMEPZWbvOr1E18dAw3Qw7dBQjrWBZd0okdBm/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EpXotP3RGc2a04pM4nBby3jczJEnx9xKHpCEZZz+ndU=;
 b=YAPI72Wmo40Ntz9kZ4KA/5ax2N28NApSWsLZgEklb+IguGqB2RnnOTDfTPxIpBe3DNarnTR5pACuQuBkvf1ylwPeH5xgs65aO4r6eHSxwXDGUq1F9QyAcTMQTlpxf/0/sWTul4I7J9Pm4kzeA4vEnT25Q9Cb4wzxHGVhDpiKyrHjotzJxASMzo3b/uli2z7ow21JPVLqB8oWP5idsdwOEU7QYH/xHcLP6oLn3B9h40CB/2njnPFPhk9MGO45DkskzVNoxFhu90Hs8xLwFLuOnBPtt/p78wDoem2QrEQtIYzVcMZTw+hTQJK/35HNQOZm1uApGYwWypfULZLDhdFWzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpXotP3RGc2a04pM4nBby3jczJEnx9xKHpCEZZz+ndU=;
 b=M/NGgjdDNGMhMxr2grRkM7vhCN8dUCU00QJQCeJRVcrlvFELruUdk7/x7ZQCFpR35DCpnluYC9ui9HDfGtMVxDnCw+53i/cIlkt/o7YOpqR0svzsrK4PIvbOKUzXrMhSRT+gTbQajMpVzouWBT4pwz9R3AA2cIw/ESmyEtTRpXWR2TXZdW+Ei8+MKJN1ezpuiYE3AYQbv0j4xjb+TI0MZMxEUNVSlxTHSrb3gWpmdRXGWqirIe0DdDKqmmhhQuv67OG0Kj/g/rkNsxnmhGX8EGu+5oddpQCbT8/ujLR7rGwIVvKwaU1DPMZxaOBxKx8auafM3kVNiCQ76WWf6ydvoA==
Received: from BN9P223CA0015.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::20)
 by DM8PR12MB5414.namprd12.prod.outlook.com (2603:10b6:8:3e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 14 Apr
 2022 07:36:06 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::29) by BN9P223CA0015.outlook.office365.com
 (2603:10b6:408:10b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20 via Frontend
 Transport; Thu, 14 Apr 2022 07:36:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5164.19 via Frontend Transport; Thu, 14 Apr 2022 07:36:06 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL109.nvidia.com (10.27.9.19) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Thu, 14 Apr 2022 07:36:04 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 14 Apr 2022 00:36:03 -0700
Received: from kkartik-desktop.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Thu, 14 Apr 2022 00:36:01 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <jassisinghbrar@gmail.com>, <robh+dt@kernel.org>,
        <krzk+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <kkartik@nvidia.com>
Subject: [PATCH 1/3] mailbox: tegra-hsp: Add tegra_hsp_sm_ops
Date:   Thu, 14 Apr 2022 13:05:55 +0530
Message-ID: <1649921757-16919-2-git-send-email-kkartik@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1649921757-16919-1-git-send-email-kkartik@nvidia.com>
References: <1649921757-16919-1-git-send-email-kkartik@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f70c816c-3f0c-4b16-26b5-08da1de96fbb
X-MS-TrafficTypeDiagnostic: DM8PR12MB5414:EE_
X-Microsoft-Antispam-PRVS: <DM8PR12MB541454F4CD02C0569FB416CECDEF9@DM8PR12MB5414.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QfdSC4eiR68eGSyQkr4clBtr9/a5qgCWUNDkUguPDuSE/1r35WZXmU2aoBSFipvkfTMmKmmPKUWVFfpnZNBNG5Vsdwyv6+1T1hsGvw293JeI2rLWyIj4a501Jn9OWFXitrir7wSjTs04kwF46jSvsmyrnRCT1/wOe5np7XBvQj7ANmEHIZIKwrdgaHzHvDQtIDrhk7Lkv0EyqKo2t4qxq3eiRS7qISlih/YaTZ3sovSA1Ruu791W+IiP3nsbkALzjbPMLUTC29M/g/ki0LE4YRxwxU9eCxKonzwdFsnR7kcMZr0yuNPDsoprlwMCOLriB0671sXfobBCzt+rxXESjCieeHt3poLSoOzTmRbnVlYkjk3ZEj/ts/zQgiB9cc2Vx1w3FRhqanJn6LANh9N5S8qZWDupyyzErj4kSd2YP4sd2A5KPTuurx6wYBQ1ICu2sL8V2swZqPVL6m2H8Jryv18Ps2kgMcMb3Lk2ZqhnYCF/jNvirYgcVE+2RKhJm9cQk8BEoYLtZfhijb1i1oMamDZu2NqNQmcZc8Trh38y4MYRKpREOlaGR2XQtlEo1aieFFGnpN8ZsIxLCWG0qwWWYriKLxZCslcdMjJTQpLF47ygPrLt+Htqlonsajr3LA9ZWHnoVI2waM7F1u/WbuysYJ5f4Z4MbTtJO1Yo/73Kt2+g5qp2J+rNBpF8Z5cmmPPaO2G1l7qzLYoDgtfY6Bgagw==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(36756003)(36860700001)(336012)(426003)(47076005)(186003)(26005)(82310400005)(7049001)(15650500001)(2616005)(2906002)(83380400001)(40460700003)(7696005)(6666004)(508600001)(316002)(5660300002)(8936002)(8676002)(81166007)(356005)(86362001)(70206006)(70586007)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 07:36:06.3905
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f70c816c-3f0c-4b16-26b5-08da1de96fbb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5414
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces tegra_hsp_sm_ops to abstract send & receive
API's for shared mailboxes.

Signed-off-by: Kartik <kkartik@nvidia.com>
---
 drivers/mailbox/tegra-hsp.c | 74 +++++++++++++++++++++++--------------
 1 file changed, 47 insertions(+), 27 deletions(-)

diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
index 78f7265039c6..af61ae43ab09 100644
--- a/drivers/mailbox/tegra-hsp.c
+++ b/drivers/mailbox/tegra-hsp.c
@@ -67,8 +67,14 @@ struct tegra_hsp_doorbell {
 	unsigned int index;
 };
 
+struct tegra_hsp_sm_ops {
+	void (*send)(struct tegra_hsp_channel *channel, void *data);
+	void (*recv)(struct tegra_hsp_channel *channel);
+};
+
 struct tegra_hsp_mailbox {
 	struct tegra_hsp_channel channel;
+	const struct tegra_hsp_sm_ops *ops;
 	unsigned int index;
 	bool producer;
 };
@@ -208,8 +214,7 @@ static irqreturn_t tegra_hsp_shared_irq(int irq, void *data)
 {
 	struct tegra_hsp *hsp = data;
 	unsigned long bit, mask;
-	u32 status, value;
-	void *msg;
+	u32 status;
 
 	status = tegra_hsp_readl(hsp, HSP_INT_IR) & hsp->mask;
 
@@ -245,25 +250,8 @@ static irqreturn_t tegra_hsp_shared_irq(int irq, void *data)
 	for_each_set_bit(bit, &mask, hsp->num_sm) {
 		struct tegra_hsp_mailbox *mb = &hsp->mailboxes[bit];
 
-		if (!mb->producer) {
-			value = tegra_hsp_channel_readl(&mb->channel,
-							HSP_SM_SHRD_MBOX);
-			value &= ~HSP_SM_SHRD_MBOX_FULL;
-			msg = (void *)(unsigned long)value;
-			mbox_chan_received_data(mb->channel.chan, msg);
-
-			/*
-			 * Need to clear all bits here since some producers,
-			 * such as TCU, depend on fields in the register
-			 * getting cleared by the consumer.
-			 *
-			 * The mailbox API doesn't give the consumers a way
-			 * of doing that explicitly, so we have to make sure
-			 * we cover all possible cases.
-			 */
-			tegra_hsp_channel_writel(&mb->channel, 0x0,
-						 HSP_SM_SHRD_MBOX);
-		}
+		if (!mb->producer)
+			mb->ops->recv(&mb->channel);
 	}
 
 	return IRQ_HANDLED;
@@ -372,21 +360,52 @@ static const struct mbox_chan_ops tegra_hsp_db_ops = {
 	.shutdown = tegra_hsp_doorbell_shutdown,
 };
 
+static void tegra_hsp_sm_send32(struct tegra_hsp_channel *channel, void *data)
+{
+	u32 value;
+
+	/* copy data and mark mailbox full */
+	value = (u32)(unsigned long)data;
+	value |= HSP_SM_SHRD_MBOX_FULL;
+
+	tegra_hsp_channel_writel(channel, value, HSP_SM_SHRD_MBOX);
+}
+
+static void tegra_hsp_sm_recv32(struct tegra_hsp_channel *channel)
+{
+	u32 value;
+	void *msg;
+
+	value = tegra_hsp_channel_readl(channel, HSP_SM_SHRD_MBOX);
+	value &= ~HSP_SM_SHRD_MBOX_FULL;
+	msg = (void *)(unsigned long)value;
+	mbox_chan_received_data(channel->chan, msg);
+
+	/*
+	 * Need to clear all bits here since some producers, such as TCU, depend
+	 * on fields in the register getting cleared by the consumer.
+	 *
+	 * The mailbox API doesn't give the consumers a way of doing that
+	 * explicitly, so we have to make sure we cover all possible cases.
+	 */
+	tegra_hsp_channel_writel(channel, 0x0, HSP_SM_SHRD_MBOX);
+}
+
+static const struct tegra_hsp_sm_ops tegra_hsp_sm_32bit_ops = {
+	.send = tegra_hsp_sm_send32,
+	.recv = tegra_hsp_sm_recv32,
+};
+
 static int tegra_hsp_mailbox_send_data(struct mbox_chan *chan, void *data)
 {
 	struct tegra_hsp_mailbox *mb = chan->con_priv;
 	struct tegra_hsp *hsp = mb->channel.hsp;
 	unsigned long flags;
-	u32 value;
 
 	if (WARN_ON(!mb->producer))
 		return -EPERM;
 
-	/* copy data and mark mailbox full */
-	value = (u32)(unsigned long)data;
-	value |= HSP_SM_SHRD_MBOX_FULL;
-
-	tegra_hsp_channel_writel(&mb->channel, value, HSP_SM_SHRD_MBOX);
+	mb->ops->send(&mb->channel, data);
 
 	/* enable EMPTY interrupt for the shared mailbox */
 	spin_lock_irqsave(&hsp->lock, flags);
@@ -557,6 +576,7 @@ static struct mbox_chan *tegra_hsp_sm_xlate(struct mbox_controller *mbox,
 		return ERR_PTR(-ENODEV);
 
 	mb = &hsp->mailboxes[index];
+	mb->ops = &tegra_hsp_sm_32bit_ops;
 
 	if ((args->args[1] & TEGRA_HSP_SM_FLAG_TX) == 0)
 		mb->producer = false;
-- 
2.17.1

