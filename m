Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2143D48EE65
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 17:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243486AbiANQkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 11:40:21 -0500
Received: from mail-db8eur05on2045.outbound.protection.outlook.com ([40.107.20.45]:63713
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236457AbiANQkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 11:40:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PsNuawV0CU++UoLdK6nQoHuOLnR+AR5l7XgoBhbTsOuOUqNhD/V6QQKz7hEjZBCpNZKbxIWXKOD/mjPnX0vnkYjlGSvTcqMIEwsH8FaQwRKd9S28pOoyEv/gKu36qlq6HzQhD2tfEMLylms1fGTT8QNtdPEmO39BEJgL+ABC6vzzByYeadXty2TtHtnFZpl1GzFySNEiBJufPTXK0vFyhhqM9xMn61NilKz91/uuy1pmykTeerDZ/lYyOXBl7mkBPzqqLgTq1AaTHmP7Ba0onwX4DN5+TlnyFEAh/cfdiV8a8WMp+pMOqRlVRP6ZOnb2yfXe4Re0AwAlnv6I7IRNZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5TtOfKTEI06+FyDYOZxDAqYsImAJxPrsoqL9H1PI+PA=;
 b=JpxtByylbnNjWJY9YXWzkPDmTQJzDAvQHugfLUwnN6SwxhxBK7P/QLGuhtRGMCcM0pDTOGR33jqab1sS/q2LKycqZ3z7HpwC334kVLOqasVQbnYdd9rbDl279jZyLHV/OKEJrIH4GPyW6prZZoihzNUuPE83eaisOfJQAEjQdRNNH0CVbjJtSr+tMuvdTTJ7cHCaAq3G1MULuuXQbBCD5JfahXUbQzUUe9xeeBjCJej29TcMRfBXj6JFQWHW2n6pZEopGJALrRE0yVPOKLw+WicQv5I/y734iiJM46g6jZ3hDP39nOD2xcYhGonCcUw+VA2QSSQnkYR4zFPxCz9KRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5TtOfKTEI06+FyDYOZxDAqYsImAJxPrsoqL9H1PI+PA=;
 b=fM8fWcXun5GiovgaXZWgWsfvGJArh8AqN8bClk0BIfWsJdJCdSeYXPAXOBgSiPuBhVQcLInvqyA6Id9xmqDh/3WDS+N8QwoOn91Gx46c8yBoio9W75tXo6T3/ojLF2xaqGEKQTitcr7s4yeTzKqRS+kci7x1BfIEw47muYEdRIQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by AM6PR03MB3509.eurprd03.prod.outlook.com (2603:10a6:209:2f::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 14 Jan
 2022 16:40:17 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::d47e:81b0:256:3005]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::d47e:81b0:256:3005%4]) with mapi id 15.20.4888.011; Fri, 14 Jan 2022
 16:40:17 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH] usb: ulpi: Add debugfs support
Date:   Fri, 14 Jan 2022 11:39:47 -0500
Message-Id: <20220114163947.790078-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0133.namprd02.prod.outlook.com
 (2603:10b6:208:35::38) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b774ce2b-992c-4f75-2685-08d9d77c8ba1
X-MS-TrafficTypeDiagnostic: AM6PR03MB3509:EE_
X-Microsoft-Antispam-PRVS: <AM6PR03MB35092F72AA4BF88AB980DC8096549@AM6PR03MB3509.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:785;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t6oPrwfiapq1E5U3SzV3AgOsw6+TbtzTf3irHtZ0k1V+bIVE1hX6A9wg9otG3/HIOq6oEyIOEytrTGsQP9ThO70GhXYYXE6yFbWGOuMiX7kexxx7NwhIuvqjrejb5jFbJeFsNRfQK/f1dxhKiQYw6NZSe27Cjz7Ro0XysWRPTDkcDemV5k7E0JNj5kezDDNQ89AfRr4Ou2/x4GT09j4X7OUnPWb4DnITvB0R0TH50w3OB2LHbyrP/X+xau1xljBYJc+FJU3YEV1oC5wcEg33BTqZXqPKFXIdcwkHx7TuSYWbhCj0eKYvZ1zwH9NAp0NGJCqQoa1E/dUAY4jxsqLVCESXH3ynx/38IznF3aKkcBUyh/eSQ3MWFn5Yf8iJjz4w5uEZUQ0mJ/oklNY0WbpAZuaBi972gyglutRiMEDEbnR18ENzZHms+lgAAStIKCSjzsMBzY/ExscLqA7UHxEnVM/sXDB0Vgl+MnzV9XUP5RO3DiWRIBK+wDi92hewCGtjpfCOYrrhQhuxAAercwTm9M2/usUbg/ULY2c+NWSJeh5I/vW8kvKhoDjWqpJegdLS+Mw7/HixjmbLTqX4eWLBQ+/GuOV5t6ejxVLdXgbPbGpMkkylCGLhs1wmGT/Ue0gad8uJAYWYJm5YP0I586QF69wX1I3QbZLFXSPoToM76Y86Kv/cmlYJgkWfekaNv2Ec+28npQFkEpJ5EAS3FfP+TA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(66946007)(8936002)(6512007)(66556008)(86362001)(6506007)(6666004)(52116002)(66476007)(36756003)(5660300002)(1076003)(4326008)(54906003)(44832011)(26005)(107886003)(316002)(508600001)(2616005)(186003)(38100700002)(38350700002)(83380400001)(6486002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kCdh6FV1lL07etdpNlLzpXAskRlZAUJt4A8P3vWjREal0gr81buyAEhZnleO?=
 =?us-ascii?Q?wSmnOQaJn0JqnYORLLG2Ofjeilvpeou44v7fKtFBM3VXtYSFX1t0+ma4xCev?=
 =?us-ascii?Q?iDhOcYszo7qWy/DNQ7UOeWku4Buqd6smsqp2CfCPw751f1tAekytpyAgkJYT?=
 =?us-ascii?Q?dUH/jWLB+YcDgwSDgFb6tq0BLitVvjLzdzmIpfQKDZ3P6nST3A6QXxR2GjIE?=
 =?us-ascii?Q?GhUcbrXZgH6FExM0VXTP2NVCa4g8qYBbAdWHQc/kmNUa/2jD4iDtHEVKNCvB?=
 =?us-ascii?Q?lRu2ewRn0ZNnpQpPiL0hbi1IppixGr85LE+HwRUOyCvtrBP0DJsxi6butetK?=
 =?us-ascii?Q?DNGBliMSn5fPwEYtKx8ZVKvFei5aorDZ0cC2R13uao27p1pCjQgxCSaw1qIf?=
 =?us-ascii?Q?pQLoMYwdB5pLXoz4DUrGA3waLwdvqnU9DV/hdj4WWWq7EdTE+OfDU1uUCdd8?=
 =?us-ascii?Q?8ZKX7X+v0jH/FN33kmG0239n0PLzhOJGfEnmOKa50nXdYu8EZK4BNoCLX9Th?=
 =?us-ascii?Q?d8/NAcqufGGwYt1wPrKA/3VzPqAWv2bghDGUdeqHAy1fS0Nq1muwodVvbYX9?=
 =?us-ascii?Q?uTZj4jY8PD+g0hY7yjtrTr2wAkU/roA2ITeKRg9sjpekxamp+zIbc9jDFTMa?=
 =?us-ascii?Q?Md9zTVwp/JfcU/WHuHObdaUUZlJ495kh45DS6nLOy2+KlewOeQUvJ/vYgOqW?=
 =?us-ascii?Q?tWH2xJjFiLwvuP90qD/7QyNJztBRtxTAyoYEv12zcB+kXi2EhZEU39/vtyHd?=
 =?us-ascii?Q?rd4Wbs4rs4SxKO+zVfy2jWO4dki+uieiOwJ6SXz2e0H2o7Y6XuapTPYN5T79?=
 =?us-ascii?Q?mRj/kz4msen9e4H2fhhsspuYAChQlPNOrfKtuuy/01GTybZR8N3WB21rPdep?=
 =?us-ascii?Q?NQ04fFl5kcSAggfJhTdepnXRPmfqY/RZyRCq1D1caXdC1YTEA6j/HQY+TFsb?=
 =?us-ascii?Q?YHeUE4FlAR+JeeDVvKbjw0Bunvv4NrEi+EmvgTo4J5VImxilMcuIs4nIhEt3?=
 =?us-ascii?Q?mYki/IqcUCAQLoHAxJxKZR1YwyYJ3mGj7uNHrcdjnbuGMFhTh9+XnPedS0ci?=
 =?us-ascii?Q?xtKxxhmuDstpNEOcrqnCGsEOcm8GLc18LVnX08giVey+jZA4BJ+vUMW8s6et?=
 =?us-ascii?Q?0qiO+yTEoAx9ZJYcXqC0fo42h3TnZtvRZRPSquGU3E6ZeDszoy4iVjcwJ8z9?=
 =?us-ascii?Q?KVqEv/ET/Pf7lhsXfZ6WY2BWLcpYQDgyEd4i+g4nFBkaCQhIwHdlUzbWm046?=
 =?us-ascii?Q?8wqxx5RjhhoSOBBv4R1eVrQgJ6XYwcAPpH9acLSAOi2OKlKicZpf22HxqG6T?=
 =?us-ascii?Q?vZnbIi3oa0sY+6g4bpQhfgkO+lJ8NLvBv5YZbG6G/69YR3Ggm68quYCeKfiu?=
 =?us-ascii?Q?e5eGe8nG7XHs0KzdOG9s/LAtBspzE8EaoUCj5+wvgWrbGO9XaYGxALZUaqEc?=
 =?us-ascii?Q?pF7Yh9wpRVWIDL5u9Lpp8i3mRdqh2rxlpifaRvPJWmR3h7YNKDCoMXkri73/?=
 =?us-ascii?Q?amsSTz35vY4h3hNshTcmQ5qh3j8IMvoaHd3/hOtst0sc8OgOakB+TiV7fau6?=
 =?us-ascii?Q?sEcOyhBCU0tD/GDshIK5+xC6hW36exxt1aRUkURrOA1pcFSSlgYQi1N/mbtq?=
 =?us-ascii?Q?qOogPXb6n8kNR0mtugzs6E4=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b774ce2b-992c-4f75-2685-08d9d77c8ba1
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 16:40:16.9552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A1YdRZJpxDHnaghb9tVcx1Ci1KhB2xWW+ka6XatzmdPv+jKzcLFd5eFkC0PmNtxEmlkvc1LPgcbq7980QLKIJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB3509
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a debugfs file for ULPI devices which contains a dump of their
registers. This is useful for debugging basic connectivity problems. The
file is created in ulpi_register because many devices will never have a
driver bound (as they are managed in hardware by the USB controller
device).

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

 drivers/usb/common/ulpi.c   | 100 ++++++++++++++++++++++++++++++++++--
 include/linux/ulpi/driver.h |   3 ++
 2 files changed, 99 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
index 4169cf40a03b..a39c48e04013 100644
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
 
+static int __maybe_unused ulpi_regs_read(struct seq_file *seq, void *data)
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
+static int __maybe_unused ulpi_regs_open(struct inode *inode, struct file *f)
+{
+	struct ulpi *ulpi = inode->i_private;
+
+	return single_open(f, ulpi_regs_read, ulpi);
+}
+
+static const struct file_operations __maybe_unused ulpi_regs_ops = {
+	.owner = THIS_MODULE,
+	.open = ulpi_regs_open,
+	.release = single_release,
+	.read = seq_read,
+	.llseek = seq_lseek
+};
+
+static struct dentry *ulpi_root = (void *)-EPROBE_DEFER;
+
 static int ulpi_register(struct device *dev, struct ulpi *ulpi)
 {
 	int ret;
+	struct dentry *regs;
 
 	ulpi->dev.parent = dev; /* needed early for ops */
 	ulpi->dev.bus = &ulpi_bus;
@@ -245,16 +301,39 @@ static int ulpi_register(struct device *dev, struct ulpi *ulpi)
 
 	ret = ulpi_read_id(ulpi);
 	if (ret)
-		return ret;
+		goto err_of;
 
 	ret = device_register(&ulpi->dev);
 	if (ret)
-		return ret;
+		goto err_of;
+
+	if (IS_ENABLED(CONFIG_DEBUG_FS)) {
+		ulpi->root = debugfs_create_dir(dev_name(dev), ulpi_root);
+		if (IS_ERR(ulpi->root)) {
+			ret = PTR_ERR(ulpi->root);
+			goto err_dev;
+		}
+
+		regs = debugfs_create_file("regs", 0444, ulpi->root, ulpi,
+					   &ulpi_regs_ops);
+		if (IS_ERR(regs)) {
+			ret = PTR_ERR(regs);
+			goto err_debugfs;
+		}
+	}
 
 	dev_dbg(&ulpi->dev, "registered ULPI PHY: vendor %04x, product %04x\n",
 		ulpi->id.vendor, ulpi->id.product);
 
 	return 0;
+
+err_debugfs:
+	debugfs_remove(ulpi->root);
+err_dev:
+	device_unregister(&ulpi->dev);
+err_of:
+	of_node_put(ulpi->dev.of_node);
+	return ret;
 }
 
 /**
@@ -296,8 +375,9 @@ EXPORT_SYMBOL_GPL(ulpi_register_interface);
  */
 void ulpi_unregister_interface(struct ulpi *ulpi)
 {
-	of_node_put(ulpi->dev.of_node);
+	debugfs_remove_recursive(ulpi->root);
 	device_unregister(&ulpi->dev);
+	of_node_put(ulpi->dev.of_node);
 }
 EXPORT_SYMBOL_GPL(ulpi_unregister_interface);
 
@@ -305,13 +385,25 @@ EXPORT_SYMBOL_GPL(ulpi_unregister_interface);
 
 static int __init ulpi_init(void)
 {
-	return bus_register(&ulpi_bus);
+	int ret;
+
+	if (IS_ENABLED(CONFIG_DEBUG_FS)) {
+		ulpi_root = debugfs_create_dir("ulpi", NULL);
+		if (IS_ERR(ulpi_root))
+			return PTR_ERR(ulpi_root);
+	}
+
+	ret = bus_register(&ulpi_bus);
+	if (ret)
+		debugfs_remove(ulpi_root);
+	return ret;
 }
 subsys_initcall(ulpi_init);
 
 static void __exit ulpi_exit(void)
 {
 	bus_unregister(&ulpi_bus);
+	debugfs_remove(ulpi_root);
 }
 module_exit(ulpi_exit);
 
diff --git a/include/linux/ulpi/driver.h b/include/linux/ulpi/driver.h
index c7a1810373e3..083ea2d2e873 100644
--- a/include/linux/ulpi/driver.h
+++ b/include/linux/ulpi/driver.h
@@ -6,6 +6,7 @@
 
 #include <linux/device.h>
 
+struct dentry;
 struct ulpi_ops;
 
 /**
@@ -13,10 +14,12 @@ struct ulpi_ops;
  * @id: vendor and product ids for ULPI device
  * @ops: I/O access
  * @dev: device interface
+ * @root: root directory for debugfs files
  */
 struct ulpi {
 	struct ulpi_device_id id;
 	const struct ulpi_ops *ops;
+	struct dentry *root;
 	struct device dev;
 };
 
-- 
2.25.1

