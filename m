Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A4149EABA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 20:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245433AbiA0TAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 14:00:43 -0500
Received: from mail-vi1eur05on2045.outbound.protection.outlook.com ([40.107.21.45]:49655
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245355AbiA0TAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 14:00:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CulJ/YegMiBNBs3ecNJdYPbdAyNEzBbzGOU/smun8yga+AUEdNXUbYhPaLI41+63iHS/XPCGsjCJNQIf2fDngKa2iSNbpeBe8rkBfyc/SD5+iOy61POho5Mv16uZIVzg+8EOuWxFlvARwYianULqk3gFhztDSFuwj/7MYPdJFCBFPMsjvlkr2rb5NhkYuLOjSUc/C/O4wUeo4yqvNSxoLVd/Eq5EBNkUxRRWDTSmNckMElnTA5i+jx5Lnu7Oojp+V/vNc6gZ+KRS1c66EU7qhLh/MzwlKjqGdtCMRmmNlT4ARghEPMgvfhpU3iDl6t7oHvn2cLA7kgqWnUM+jU/3kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L58mPA+UQQaMhVFi4BsiVloZjuevT88VtMmdQ4hhIyc=;
 b=LQHN9Lp4CFolpksaYjfa26M/XD+kcC1aI1nm5DNRKATRjw8Pelop4A0+j1fF4GIle9mpIUxXIF5TqCk4j3Kw0gHmGZrqitV/nUA0BE7TyCA5alQOnq9+e2WfUYBCXs9pWUZMyaomOBWoKvMrUpX0X758J9XpeUF316QME6F9cy4KrI/ZeTYp7CY5jGiGqK7iJ1PqbQvX784mIv5zWa1wr3cgtT9XH/3By5Xb+ICRlBy6vfSAZw/tnSlD5yyrlAdyXM0jPwrkrL8LhjlYr3Ru78H2fw9zr14PfSsPgyUfLhfWAX0LbzhlKkuYfmMvIwrgyMnZA0QkVYRGjrrbCvFxww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L58mPA+UQQaMhVFi4BsiVloZjuevT88VtMmdQ4hhIyc=;
 b=mgDzbN0luAu4tEXQD2KRKNBlPCS2SK9h5HPveG3cwsdMsiRlkilENe9Rd/cfyo7DSa3RIrFSnpC6VvPF6mOcH/0NWtiKRFq7AmgJ4Y4Hw3nbRWWiz+mGJee/KthWMT/XF2Q/+I1N0LiEGSAUzjXpcF4oMpMNbWpdCAwuZNNVryyfrYgltZG1w3Fd0jhJ28bNZ8/0NMVFdprnYs8S7AQk1036e+BB6FQqIyyBj/hxRqy/v8pgheRyaoBx/EZ1bezEFbRZXfH3Nt/Dv8qA6GzPFeWF2ESbe+ZPmHkNjn4FWmGfhe1sZFoX68BZ2RCmqn8zt/bbeN5mBeqiThlpnzsgCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by PR2PR03MB5466.eurprd03.prod.outlook.com (2603:10a6:101:1e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 19:00:27 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::2d1f:654e:f946:1a95]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::2d1f:654e:f946:1a95%6]) with mapi id 15.20.4930.015; Thu, 27 Jan 2022
 19:00:27 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v3 3/3] usb: ulpi: Add debugfs support
Date:   Thu, 27 Jan 2022 14:00:04 -0500
Message-Id: <20220127190004.1446909-4-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220127190004.1446909-1-sean.anderson@seco.com>
References: <20220127190004.1446909-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:208:d4::21) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 340fcef8-abfa-4a5b-88c2-08d9e1c74808
X-MS-TrafficTypeDiagnostic: PR2PR03MB5466:EE_
X-Microsoft-Antispam-PRVS: <PR2PR03MB54660939D4C47C99C591105F96219@PR2PR03MB5466.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iKz11ztsW8lU3DIygxwGX+qbKhvNN6vKNmXC0kpQNzcTusoX7wuWGEOmrivHjom1P28JO//d4y06But3weJNWsN4sSaCOENIu3WwXHqXS5AsCyhXMJNAsEpc2zuPxcpoOQss1vCrKdf9RS4ugU6ps+qtoVml3lj7y2FtlyIZeIUky06wCfvAC24SEvNbPSt4juZLUBnLMjyInorR2JHDymx3yzxGP1EYB5uPQtxmomkpvZJ5LGxdSwrBZT15YA2HGMmXGFW0lSJ1C9jttIpyNFrAWvA3mcHbq+6I/XN5kzlSBR+to1npTMQKWMv+SRqKVlr6TpeUE+uBuf+4FCGHlEfEeUK7BAEeHho5eGP2GDa5S+52lersWqIy3RLP4NaQ/qaXGDlXZ95n7RX+I4vCh9QlirnerdgGXU1lZZPmtSUK0xLErNWlPQi7RRwkRibQN3LNX2Yuef/Sfj2rDBYjh+u7X+0xxNKGD5SS6WoEYjmQhOW88KkDWaY5I/29r5LS87UpHuJg4y8J3DaKR/8hnurVUxKKnEeMb4TXzs9oQPAFNjQxHzQm57drd8yl5V6YCz4Q5rlmcge5Me+8Sj0eO8Nlb+yiXH0A0i4QzhiVTBrkVLzvhFCiAhRAF0tvE5sGPNEt6irL3BkZZW5vef/wcO8uj3UVLElFdHAsPQg6l9Nd40UcU6BJV9o2omic0zO/2MKrhbv/GunORRZ4W+Aw4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(36756003)(4326008)(54906003)(6506007)(5660300002)(8936002)(66476007)(316002)(66946007)(66556008)(38100700002)(38350700002)(8676002)(6666004)(83380400001)(2906002)(6486002)(86362001)(6512007)(1076003)(508600001)(52116002)(107886003)(186003)(26005)(2616005)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xooOHNLHxWphddPLB2EfA+fBXF34ahsEfY6bfOjcxT56KJeMItosWo9cfTke?=
 =?us-ascii?Q?vt8C+9JQczq3rKjeVnvk+R/LuzA0Tyr1OK/XL3MwPoTqveX+j5C6KPQQRUla?=
 =?us-ascii?Q?teDXXy5+1J2t6Ec/zL8hzrNGcYafEtGXmTIo6lN+VD37AyDP997fVIPT0Tjf?=
 =?us-ascii?Q?RqnvvUTCbgIn4TkMlRAyqSXfeahGAfwevoJ7WKFyvbf7QdIAYG/EDKMfxrVD?=
 =?us-ascii?Q?/TEGPTZyThp03Lj7ZmByvx6K83YQ0p+8RtKlkZ4NfiseYlHcWXIbh7oOg1GH?=
 =?us-ascii?Q?uHbyZKHkH/rXDe7/Lu+CW7GQSY38NqbuFT0z4M8uUCVck+TFBCh2dGB/+Hxw?=
 =?us-ascii?Q?hkKHzBjU4GZS8KOfzcKMFu26KzylNNupMTVw1c3KINZv4Yz+Tp+NEvXG2Cq2?=
 =?us-ascii?Q?gySbguKdW2bGSTp/JgT5Vju51j/m5NseXBlXHsuiNrQUreu/tADAVr1H8nmg?=
 =?us-ascii?Q?bgloYOKlswXKwwUI2tpwEyja9t2r+WSp1KQPeCtOZNAJjoDgJR/GNMI/aeMR?=
 =?us-ascii?Q?4fDA9H5NNitspdFtcdiq+Ex1JIYqFOCuMJ+kz3bV3eJ900NWuy6lm8g6+3Zm?=
 =?us-ascii?Q?2y28DqnMZS7/PtnjwveFzOaxgdRnhav6V1o8CL+IjH1QtMAv8Cx/COL24smI?=
 =?us-ascii?Q?DxMcrO/OYz1A8DpCwppeZaV9mA1QmhpqjSvPtWK7jtUrotU15UmQvpM6UvSl?=
 =?us-ascii?Q?m7AAFNUWGzO08mpdiqN4bKfqq7f0lyH8bdCpxrid4DyOq4oD3KbCt+Th0Wct?=
 =?us-ascii?Q?pqUPqmAGsA/qDPuYn/3y4SMpJnRJovR36G/3i/KR9gWd1m1Xz/h9mDTuIPhR?=
 =?us-ascii?Q?RT0zzjx5fjNxSZYAvzNAyhBY14yck/E+oS3KgV8foxN2kWH6OgC7zeBn3N19?=
 =?us-ascii?Q?YUXoM9b9ksoeqvywy1M+61rZp0SiGn1BBhpa5JaGV2cFvX1vgZWKFzh7scL5?=
 =?us-ascii?Q?xi4uB9eYf/nXr7/pnhmCg9EtW1nfzRF93xWpyErF26Os5u1kn71ExsUFmK9V?=
 =?us-ascii?Q?gB5GFRjbFNqTZ6PHfAaWUDI8MyUj7eSxwgfslWF4gPe7Ql4mKmMc9pJdcMZG?=
 =?us-ascii?Q?gpJ3PAeuor89MKYcXx2cCQY/8nn9ayohk5Lr3Q3Do+h4GU6d0D2WAEG5fEf6?=
 =?us-ascii?Q?GabJgWa8iqWlCBrlTQRAu9fK03kArBexzS04xsmct0rPROEntCIRqJ3TmO3E?=
 =?us-ascii?Q?DIeGGZTz2zdYvPGbrL47vEXZXDv84yvPuGsCOZfazqMvNi/3eKApOgV5ITMM?=
 =?us-ascii?Q?6YvRPi45NTTVnW3ZYpGUt0pTP8hN0Q1ggWGdJw/K8m6eu9DrzbKK+SdWNF2A?=
 =?us-ascii?Q?u0DlgMOOZ9hOaSuAr3SeQ6K7nPuvf2+7VTm8cQjaBFyiUN5GNDOffHd2JlzI?=
 =?us-ascii?Q?38GqZDozh9logGXUyQS/Siskk8XwJG+63h5IQOvSLAcJv8Egtc4hVMMchP1s?=
 =?us-ascii?Q?+hr6HL5pK99oIt4Z5ZrPZBXU7w0EEHi3dHN0HJ/IJAf7gC5KjAG+O4mCNg5T?=
 =?us-ascii?Q?RhJbGxg0gfH7j2Yf3vBGQ+9PxwpD+eZ44OlVLrinL39HwD23q30VuWkYHQ+r?=
 =?us-ascii?Q?HjAzWRZG6yCrQbODYVgTkPSI1402/lHZkMTxeyMTCTmTv+El8qLWlLMNAnct?=
 =?us-ascii?Q?V8EdmBh0tUFlxO55ggGc6zE=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 340fcef8-abfa-4a5b-88c2-08d9e1c74808
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 19:00:27.4302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: euPPI+MwP3lJS8LDSeOs6UJXm2+ROJXYTgBBwK3LOt5VHvHx5wRQl6dJJZnr5XeMjSIZI3XM4wTQ+85gVjqjyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR03MB5466
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a debugfs file for ULPI devices which contains a dump of their
registers. This is useful for debugging basic connectivity problems. The
file is created in ulpi_register because many devices will never have a
driver bound (as they are managed in hardware by the USB controller
device).

The root directory of this subsystem is created before we register the
bus to ensure that devices can always create their directories.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

(no changes since v2)

Changes in v2:
- Always create debugfs files and ignore errors
- Look up dentries dynamically

 drivers/usb/common/ulpi.c | 71 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
index dedcb749a02f..897e1a374f9e 100644
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
@@ -229,9 +230,64 @@ static int ulpi_read_id(struct ulpi *ulpi)
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
@@ -256,6 +312,9 @@ static int ulpi_register(struct device *dev, struct ulpi *ulpi)
 		return ret;
 	}
 
+	root = debugfs_create_dir(dev_name(dev), ULPI_ROOT);
+	debugfs_create_file("regs", 0444, root, ulpi, &ulpi_regs_ops);
+
 	dev_dbg(&ulpi->dev, "registered ULPI PHY: vendor %04x, product %04x\n",
 		ulpi->id.vendor, ulpi->id.product);
 
@@ -301,6 +360,8 @@ EXPORT_SYMBOL_GPL(ulpi_register_interface);
  */
 void ulpi_unregister_interface(struct ulpi *ulpi)
 {
+	debugfs_remove_recursive(debugfs_lookup(dev_name(&ulpi->dev),
+						ULPI_ROOT));
 	device_unregister(&ulpi->dev);
 }
 EXPORT_SYMBOL_GPL(ulpi_unregister_interface);
@@ -309,13 +370,21 @@ EXPORT_SYMBOL_GPL(ulpi_unregister_interface);
 
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

