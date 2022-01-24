Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5AFC4986F7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 18:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244659AbiAXReu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 12:34:50 -0500
Received: from mail-vi1eur05on2060.outbound.protection.outlook.com ([40.107.21.60]:41185
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244701AbiAXRek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 12:34:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4JLpGjY2sVyEhhslYbBKrBIp6x/q7NJ63rIqecxuOHckEfVYJnN7pBPEklAjrfRAZ8HoyFj1uEVIaZAdOK8NWhLGpyie6boG42OT+o8CdqBrsi0fNzDJjLQZiE08X0bLNOV13XlMIv0CdHbKcn6ErLMd6tou4M1iS9GXUO8Oz34skVy7Ejh6aX/ScJOiGIcgf0fNgjRERMKru9/l6T+O8kpM6dvKR8pZ+kWO7wESU5NuiGtky9hIqmJ+g3uYTl3tSEPgdFpO12m/QpcCWxPbgXxcTooai/l5J3MGJzRzILm6K+SH9pHA9uqsSZYHGxvttBkN2OdAR99JD7IGt2nng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94o9gRn3/osDaaVsHcLcID835+mK6wf6CvcRd8Bcsb4=;
 b=YPmDTfqHOwddJ58QH4m8Euwxd+hhOIscbkGn55qicfVqAK81eJwKaIBhp1e0EVrw24hRIZp8zV6aXjK38KMNn5ppXdYgeMsqxQMCr/MEzGsttuyNI/IgxT3ULCdPRIJWqx/YXypRcsycyyKxb7VuspPDXepcb98JE/IuyOZsQgE9M1AAm0jrpE9R9AkDtrKP1qfYniSZ+QkyhP1WyoIEtjQ/RMYdS5+5Z3R8dgR8GDLjpxpIJV4s5isk01epLKu+kn+XYPH424qKwEFzjCW62RAAdFYlPc7+PPMdvwqAxUaADXbhlM0e/IAyae+2nkTnBw9fyXpqUa+kPVRFXG/ZbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94o9gRn3/osDaaVsHcLcID835+mK6wf6CvcRd8Bcsb4=;
 b=CI8MmtlTL4K/kD7ZiCaloCgGnsDEpOS6F3RRsnNfGvQZnaqt8WPc/aoYZJagbVLiXl+7r29y8Yi9Rt9gg75GzKci5dqDmfeFsLcCjXOZKOxdcRq1eBDBTABgOKdmCMQb59imziie5mrA20O8OiLIxLGR9Lcooba1cBUTUEUgXJz3MJqQxTF5sjHhH0GW3w/d/lkRiLD3+KP+oJ1MFP2okKBhCVWz0GTcM0NaAYWF+G9FvVJKLP48nhSpBQzAr36IyBaZxWlS1OabGldGqd6hyL+pqj17pRuph9fkXYOn8OJHKUrSbNwxkg/fzf5Y5hAM59So300mohROjOkK968dCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB3PR0302MB3355.eurprd03.prod.outlook.com (2603:10a6:8:8::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17; Mon, 24 Jan
 2022 17:34:37 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::2d1f:654e:f946:1a95]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::2d1f:654e:f946:1a95%6]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 17:34:36 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v2 1/2] usb: ulpi: Add debugfs support
Date:   Mon, 24 Jan 2022 12:33:43 -0500
Message-Id: <20220124173344.874885-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0409.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::24) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9d362a4-dad7-4f8b-f93d-08d9df5fcabe
X-MS-TrafficTypeDiagnostic: DB3PR0302MB3355:EE_
X-Microsoft-Antispam-PRVS: <DB3PR0302MB33550B1B839AE07CEAE8F56B965E9@DB3PR0302MB3355.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XhivMCGz114KUifN1ZHtG568BPAfA23yg+d5xZMGVopmjvovxpXbs1gXmcJ+v99xTsB5B1e+1FfLlkG/+T4KL4H6z2dxWlUOETY4U6sGCw1ziL7AxMKxgK8yELGH/BKIUXCUmywkrORCzch3iCv7SwHiO23FfGyZxIFvkHnRfLy1XtPAdh6tuMKCAxiYYBQ76NMyOt4TrPRZGuZuF4yCRtMRpPyh6J8kN5M5+JTMXhBKHE8VxP5FGN4yY8GhoAsnVahDbqQIg3ABQO32Os9KVdBIDBVk7K95fYUf4CU590R2Zl3iB1mowb89aODv2U+n7oxMTGS4VxdXMh+jmbLqJqSuOJ6Zfa5c0TX9DYyEztBf37bey48Qce8mnSGNBLPQoExKz7pTB+MUmEuJrZCq/HFXr99NpnutARy5rSBZ20W5QjMH5pzolfwk1Es8qwzErd9neZCbg/G0i19NJ+vcCN8D3AJVErUm6Epf4s7l9F0FoSqTa7W0PAq2BaLEFCZ8YOv7NgK+8LaGec28ASB33dcywVzVQFi6RTjC3jJ4Nt/jPLpYVMJBCaivo2cjqviQpZT4kwnzlwSc8mDSHi5IHqzVVFNBAS9tyhkoqfj7TLInYWKxKXS6dO8Zean2yJQCyhdb0fDTVbQpdUxuZJa3kODbR52hTIgj8GOgMPqZgiEXYsvlZjlelYsPyf09EBpgQAnTAZ83ZknYu92N+QO87g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(66946007)(2616005)(83380400001)(5660300002)(4326008)(54906003)(66476007)(66556008)(107886003)(316002)(8676002)(26005)(6666004)(44832011)(1076003)(36756003)(6512007)(6486002)(508600001)(52116002)(2906002)(86362001)(8936002)(38350700002)(38100700002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j5b5i3cg3/fUOfyJqWQ6+kEq4h1qnp1hv/I4nwPIMiFQkzqkI6bruR2aaeIA?=
 =?us-ascii?Q?9odflb4EVSkp3s+/ENoH3VB2E0FYfb78wr+MNdFZ4xWoPGmkQ0OdVjXqjzdI?=
 =?us-ascii?Q?ztaZPamonswAZ33SlDQZ6ptfSOAgpsz1AZeEEfFaTENhniTOsM8AvmqV9GnU?=
 =?us-ascii?Q?1Fwo9s08yrnrd8hMJ+DKGcftq3MCqdMVw/BGy3ROC4jD4ZVn6etpvzqgubDr?=
 =?us-ascii?Q?KnNWt8QAFBFRpl+db62pW5+yMiYP8KzGdu3qtX97D4DwwTHIPiayPT3sFPE/?=
 =?us-ascii?Q?TCs+X0/+t1r/tsO0s+fJ0IhRMh1FLLgFdgpTebYggQiaydqWhJgWWrAIzXCb?=
 =?us-ascii?Q?u0Lr7O4B3DNnlWfadzrh2wcx53aItBqnjV6xGDHO0r/wSVqKnMAh94BZ2VWb?=
 =?us-ascii?Q?FD35Hk9uixkqX4ZfKkKAJ27yNchDBpPyhc2FIFmBu2Hw9Bik/R4C0nXLHVRU?=
 =?us-ascii?Q?qzChlD5u7ob7ShenNNSQp8ADTrSE1ZobNeeKzbQItRYTyBXoMxZnCSVAhtgp?=
 =?us-ascii?Q?Xats+wV8qBdHu20d8IwRKTSc+AF9lhMeghY5q0sPSVdLonoRxfwyY2iBW+Cs?=
 =?us-ascii?Q?9+lgugnmgpZ4uhydFDtzlOU5xk+dxrx4diScKgJK9knqtf2JUX70icM5wXD1?=
 =?us-ascii?Q?mUWn7E4P0mXBiE85H8/H8pJ7QmwDt+zB84unxv6mcT1I8/sINRIctw8VfE4h?=
 =?us-ascii?Q?oistFwnO+KQQr3Ry5mk3v4+8U9CSObYl1HL4bN0riw/f6OgKK6iiivMdvDAX?=
 =?us-ascii?Q?XU1pbVAA+ahINy7EeQSpRPrZ3bSZxGAQKGst1fFpncsWlU4X9SHIugi5QtO8?=
 =?us-ascii?Q?JtJR782/x5y4VPBeDwa+c23vDtQjDHqQUCNRbJK3HH8zoun9OubEm/PfeESx?=
 =?us-ascii?Q?VX9i8GnUvFlgHCdI0HtJC+OzqVD1Nh6XfbBzbeoHDvwI3jfpWpqDX0DJ9vG/?=
 =?us-ascii?Q?SKyPtDTtivmwZK/tvsgHY4qWBZDDDpS1RDBuwarmuMKPB/aoU4KIicfu7vBS?=
 =?us-ascii?Q?+ralsspX3jEC7RtgVX+cSMAH/u1BGl2mByVh3IQphT2L1V2vx/7pZEWKu16E?=
 =?us-ascii?Q?xUgKb7sZpGMSkSzEBizv6231SIqZQdEHIFX9knUzzbNMtzRz3bjFfiQGEOMF?=
 =?us-ascii?Q?v4WKybXpq/0HFxYCwwn2DNLZe89T2PsSi2iBe5SKFu3vXMxz1MBnmknoAj3A?=
 =?us-ascii?Q?lzF0XsBP9ZNx6KVSPNbZtc7T2HlA1eRRsWUXZaiGGk2bURqjjTHKFadobjFa?=
 =?us-ascii?Q?Cmhm8pxmQKKbm2fdmGqBBv8sj62dh1P96WUWbFEke3yfezuRsMX40WTzuY38?=
 =?us-ascii?Q?1jqxV6RL7psAOqPwnpPZoAI757KPoxoFnyPuK3aWLttLgcvGmyMDRaBLbVnU?=
 =?us-ascii?Q?PXOCnTfhHvcMDQq29AsHR6KEWdcTcCislzney169SMq/cUkQ7GQ+Mwxq0aBM?=
 =?us-ascii?Q?PSQrDq7/CWKWTNvoWvylK24aAdFm1tSMxptXGLCEtVvu7HwS7VJe/BvKvGbd?=
 =?us-ascii?Q?mt7nCSQvasNJURV3736M9Vd7LEQLCPm5aEnChvnoSIZkyTN0bNSKQ6mdpOYM?=
 =?us-ascii?Q?BnwX84u1z3+8aK6CXPvy17XhLgeel6t4qUNSBbwSsLEoKiFlBPi69hygZoOv?=
 =?us-ascii?Q?4RnM+S/z+Gf50oU6apGmzlg=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9d362a4-dad7-4f8b-f93d-08d9df5fcabe
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 17:34:36.8223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yj5UqrzaTWJpTCC2S+beu0opLj/NldRwT6F++SBlnQp2NwxRWZDapaJqBBRkLKU4PzbjpxfIyST9Kbk+gLzTzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0302MB3355
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a debugfs file for ULPI devices which contains a dump of their
registers. This is useful for debugging basic connectivity problems. The
file is created in ulpi_register because many devices will never have a
driver bound (as they are managed in hardware by the USB controller
device).

This also modifies the error handling in ulpi_register a bit to ensure
that ulpi->dev.of_node is always put.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

Changes in v2:
- Always create debugfs files and ignore errors
- Look up dentries dynamically

 drivers/usb/common/ulpi.c | 71 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
index 4169cf40a03b..87deb514eb78 100644
--- a/drivers/usb/common/ulpi.c
+++ b/drivers/usb/common/ulpi.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
+#include <linux/debugfs.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/clk/clk-conf.h>
@@ -228,9 +229,64 @@ static int ulpi_read_id(struct ulpi *ulpi)
 	return 0;
 }
 
+static int ulpi_regs_read(struct seq_file *seq, void *data)
+{
+	struct ulpi *ulpi = seq->private;
+
+#define ulpi_print(name, reg) do { \
+	int ret = ulpi_read(ulpi, reg); \
+	if (ret < 0) \
+		return ret; \
+	seq_printf(seq, name " %.02x\n", ret); \
+} while (0)
+
+	ulpi_print("Vendor ID Low               ", ULPI_VENDOR_ID_LOW);
+	ulpi_print("Vendor ID High              ", ULPI_VENDOR_ID_HIGH);
+	ulpi_print("Product ID Low              ", ULPI_PRODUCT_ID_LOW);
+	ulpi_print("Product ID High             ", ULPI_PRODUCT_ID_HIGH);
+	ulpi_print("Function Control            ", ULPI_FUNC_CTRL);
+	ulpi_print("Interface Control           ", ULPI_IFC_CTRL);
+	ulpi_print("OTG Control                 ", ULPI_OTG_CTRL);
+	ulpi_print("USB Interrupt Enable Rising ", ULPI_USB_INT_EN_RISE);
+	ulpi_print("USB Interrupt Enable Falling", ULPI_USB_INT_EN_FALL);
+	ulpi_print("USB Interrupt Status        ", ULPI_USB_INT_STS);
+	ulpi_print("USB Interrupt Latch         ", ULPI_USB_INT_LATCH);
+	ulpi_print("Debug                       ", ULPI_DEBUG);
+	ulpi_print("Scratch Register            ", ULPI_SCRATCH);
+	ulpi_print("Carkit Control              ", ULPI_CARKIT_CTRL);
+	ulpi_print("Carkit Interrupt Delay      ", ULPI_CARKIT_INT_DELAY);
+	ulpi_print("Carkit Interrupt Enable     ", ULPI_CARKIT_INT_EN);
+	ulpi_print("Carkit Interrupt Status     ", ULPI_CARKIT_INT_STS);
+	ulpi_print("Carkit Interrupt Latch      ", ULPI_CARKIT_INT_LATCH);
+	ulpi_print("Carkit Pulse Control        ", ULPI_CARKIT_PLS_CTRL);
+	ulpi_print("Transmit Positive Width     ", ULPI_TX_POS_WIDTH);
+	ulpi_print("Transmit Negative Width     ", ULPI_TX_NEG_WIDTH);
+	ulpi_print("Receive Polarity Recovery   ", ULPI_POLARITY_RECOVERY);
+
+	return 0;
+}
+
+static int ulpi_regs_open(struct inode *inode, struct file *f)
+{
+	struct ulpi *ulpi = inode->i_private;
+
+	return single_open(f, ulpi_regs_read, ulpi);
+}
+
+static const struct file_operations ulpi_regs_ops = {
+	.owner = THIS_MODULE,
+	.open = ulpi_regs_open,
+	.release = single_release,
+	.read = seq_read,
+	.llseek = seq_lseek
+};
+
+#define ULPI_ROOT debugfs_lookup(KBUILD_MODNAME, NULL)
+
 static int ulpi_register(struct device *dev, struct ulpi *ulpi)
 {
 	int ret;
+	struct dentry *root;
 
 	ulpi->dev.parent = dev; /* needed early for ops */
 	ulpi->dev.bus = &ulpi_bus;
@@ -251,6 +307,9 @@ static int ulpi_register(struct device *dev, struct ulpi *ulpi)
 	if (ret)
 		return ret;
 
+	root = debugfs_create_dir(dev_name(dev), ULPI_ROOT);
+	debugfs_create_file("regs", 0444, root, ulpi, &ulpi_regs_ops);
+
 	dev_dbg(&ulpi->dev, "registered ULPI PHY: vendor %04x, product %04x\n",
 		ulpi->id.vendor, ulpi->id.product);
 
@@ -296,6 +355,8 @@ EXPORT_SYMBOL_GPL(ulpi_register_interface);
  */
 void ulpi_unregister_interface(struct ulpi *ulpi)
 {
+	debugfs_remove_recursive(debugfs_lookup(dev_name(&ulpi->dev),
+						ULPI_ROOT));
 	of_node_put(ulpi->dev.of_node);
 	device_unregister(&ulpi->dev);
 }
@@ -305,13 +366,21 @@ EXPORT_SYMBOL_GPL(ulpi_unregister_interface);
 
 static int __init ulpi_init(void)
 {
-	return bus_register(&ulpi_bus);
+	int ret;
+	struct dentry *root;
+
+	root = debugfs_create_dir(KBUILD_MODNAME, NULL);
+	ret = bus_register(&ulpi_bus);
+	if (ret)
+		debugfs_remove(root);
+	return ret;
 }
 subsys_initcall(ulpi_init);
 
 static void __exit ulpi_exit(void)
 {
 	bus_unregister(&ulpi_bus);
+	debugfs_remove_recursive(ULPI_ROOT);
 }
 module_exit(ulpi_exit);
 
-- 
2.25.1

