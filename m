Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 919F04986F9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 18:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244674AbiAXRex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 12:34:53 -0500
Received: from mail-vi1eur05on2060.outbound.protection.outlook.com ([40.107.21.60]:41185
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244712AbiAXRel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 12:34:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1l4Q/pBlkcHBPAVKINEjdq7PTYpnc8p8kRLgg+MW7C8MvyHosjuMWULuSwdXHbkAJD3fEYHI0b5dLdwRjV54KA1c4h9ljZ5JWPtRKDnRCLJIXMqnW501Zz0+lPrLTLeTOk0a/SnnMEwCzX2s3TZzdljoask0pGc8cf+E6ilYZmm+06ofRE3f25lrA6sa9FIJvrShM66OJmAqFgoy9Hn/UY4tJVImMfKXLu7VDzX3BEMbyOc1EIp+CzsUpLPazBBshwP1kDvE/LgJOPTe2Ll09DtVG0MQ2FYMxYIbNRwYyh6euCg2yKFczgglX3TAXfaRh48C66q2gJ41JTrZdhUfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=inbGHgAo8wll9Bb80GVYomGzFyRjW/aRDtDW3v0WE/8=;
 b=cV2bt/GD+weDWE6sfOT2m892U32LpNr5bKA24XdmV77Cmx/KWotVWy/DWq5iew5DitZOqSnXZkIKNjhXBEeeyrkI8OgTfP+SKlsrEWqSFZ7XKJLddOqrfwwDSBPvM+UXZgztjFW+M6eAJoSsMoK3tK8Do1dGEpoE0bwLYxr8/JIxLKmkcsvJlaCzxpjl7fYynXBhqnX8f0mx+fRXVrxi2zO2AjSfu8h74mjKlt7llJKwICBc9hEDIOokQbSNoPeiGaU931cQFnKiiQvnWb25Y/B5/g48yuMRFLVlo9wmtVevJCiTjKsE3KKWXVuNWuw3WQvqXY3r+VwPIX78AhfMAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inbGHgAo8wll9Bb80GVYomGzFyRjW/aRDtDW3v0WE/8=;
 b=Xeqh/krsROxI9dKUPen/3DlsJWajS9ZV8jhxxaBOnF2pqY9IJo/wq0S/YijN5DfCa7Ps37RqqP358bwFCuwTtzV9p7HnX08aovw7milWMAi3ZmSEq9qZTOFMPrvtbhMD2LPh5/6XfRNotuugEo7Vrype7EfK/ab+XVv596BfW4bO+JzaPInZ0dL+WPERjeu6VVx+lAWxibRNu6TztcL+2SwfUfov7OxBTRpwTTs1iqgR6WK6yHeNBXb0u3fuFW6+XtGVb9vVGksAQHUbDjDf7bhr7aho1QVCZ4u9ca5FoI2q1hqXfDRHbr56fDzKdy3fnzLJqTEC2ulaW/k/FpyK8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB3PR0302MB3355.eurprd03.prod.outlook.com (2603:10a6:8:8::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17; Mon, 24 Jan
 2022 17:34:38 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::2d1f:654e:f946:1a95]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::2d1f:654e:f946:1a95%6]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 17:34:38 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v2 2/2] usb: ulpi: Call of_node_put correctly
Date:   Mon, 24 Jan 2022 12:33:44 -0500
Message-Id: <20220124173344.874885-2-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220124173344.874885-1-sean.anderson@seco.com>
References: <20220124173344.874885-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0409.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::24) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8f439da-a875-49d4-2901-08d9df5fcb74
X-MS-TrafficTypeDiagnostic: DB3PR0302MB3355:EE_
X-Microsoft-Antispam-PRVS: <DB3PR0302MB3355112DC42811BC5713FC61965E9@DB3PR0302MB3355.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IFb38jG00mz9jDfsKPUaobb2tw7gaCseifAtaGdtI3JZYWwzPy89ayApb/dX+zr9lORGMoH82PZnzWz/CmAGDbIWxvlbOhx1+9hXAcdG28zdJxnrfdHhmKhD6yu+IL3KJBzXSqgDMferpM0E36g1TYOzBC07HvzfTbYce9WHWBTnNRGbdbIIjeouJ6HiWoXKpUVMW5sKfO5yhE8eGnmeKjynmxWb3+9RHoPtbdQcZpnLik+VYswmeOyC2PDwFpMR2O13T6qVkc2i7XinaU/IfDHg97EUmEO8ru6ygMFalc+FWeEDZc7dwiquc1BmMRH1B8Gv0Z2kp79E6T5HaP3LQLSnnwoZx2nAXTtdAdyvkI/vEMcAFtbx9bSt+82vxo4FzpayqNPKQ6B+oHRtY1OCT02MEG8BDDt+Kczxz/Qbbkr4Z5AvaoWvJCw4N/CSSeXs+KN+p84mCKzZpF6KUb4kETYl/MYHeII0HgrTPyOKrB4p6sgtJJEEGTnKB0F33WJQvJOdlpbX77NNtn3MlX217iKLMsVvKSnL5VOCLSZzcpWcKj3NrtKRTa2UUL4sP2U0P5L630X+CXpnxA/LciStBNS7g3T5X6JvCazsluxnZ5IT+UscBewdWgyAj2d8izuuOHKFBObY2ig79woTwzqd7jEjNJvhOhzU8Wr4EK/bX/B/v9g5gaLoMXSzAyR/Aev29c0K+yp9KLEgCjhiNHTkLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(66946007)(2616005)(83380400001)(5660300002)(4326008)(54906003)(66476007)(66556008)(107886003)(316002)(8676002)(26005)(6666004)(44832011)(1076003)(36756003)(6512007)(6486002)(508600001)(52116002)(2906002)(86362001)(8936002)(38350700002)(38100700002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eTrt8PP7J1Sit7VQWnObrn5AbR/jy6xVwwe0PM2X+aA8mFwYYTdIkV7BPAvb?=
 =?us-ascii?Q?UYVazqwN21pr7v6WucGVHfz3WdiVdpVzxt9GbayzXeRp2BRKRxlNmgZ+agVV?=
 =?us-ascii?Q?mCpbTDl6Qr3syZqcjJov4GnFDbUGTFZbOZOrBwxwpVu9EYPOd915t4wN1YwE?=
 =?us-ascii?Q?AJrnErHGpFShjd+yPp7mM79aYNLGdq1qame20NNXD+sBAnvv5XZ79nLu8U6D?=
 =?us-ascii?Q?IQCWqQA1j3D8GJpwUumDXKKVjtR+gFziSHDzYWDjWldO8oXXHpzTg8T3iFlw?=
 =?us-ascii?Q?sgnmbky6s8ZgysBTTy4mczpu6Jg407vP8cGsi0ga/VCJpF54Z6pPOf+DXUb0?=
 =?us-ascii?Q?dfYuBXiGz66qnYbLC5/wh2+jl8ZBK8h5qQsiS7VvAejuQEXsJcfPeIeOgepY?=
 =?us-ascii?Q?UVpnvlg0Ekc6vzbD81pElVkCtbno/aB1kbTSqpmxtXQ/Px0i982zcV33tWDF?=
 =?us-ascii?Q?6Qbgq2gYoJ2zhSWn69RRyRv5F401NzAXggAPblq58Wy9VSJb5cSoPoG+6wQy?=
 =?us-ascii?Q?SThuc5vlMNpzBReKtN2z7Ztmeac0jLQVu9EHVgwutEctmplsxHHnBWS5h8lm?=
 =?us-ascii?Q?fFjizERYleNl4KiN0y0yfuw5b+CA+Ovm+tNqDDKc8gjK8lGIkwQu8mUb0NyY?=
 =?us-ascii?Q?uSXo2a8m2MfRU7tOo1j4yuer19kFNE3jrJ6rpBW7JjnQ/+i5Db23QVwu+dPz?=
 =?us-ascii?Q?OuXO/WOyjntBqygsZ9fgZc80WI7bUwZgeybcK7FBXnkUxh4Q70oLZWa5KAOh?=
 =?us-ascii?Q?6KqfNktnWKil//1BgfFCLMXm8SboHvxLdBVm/RUvGBRS/BdqxwioMPBDFibN?=
 =?us-ascii?Q?cWIqH7ufWo9tYKL9+Iw9zAiVRR3DdbXUomHOEhSw3DnP+xovlVIywD43QkgL?=
 =?us-ascii?Q?4kSP8NZ77cG0roYhHF14Y4XIn7CMrWoKZrI/sd0mhzI9SRV+lHxjIevtt40J?=
 =?us-ascii?Q?4DMSycXWrxwTnZlVfBlnLO3JWUQ0Ct3rVLyVaf9NcFTrdNv3F6QYpA5z8B8O?=
 =?us-ascii?Q?gUUh8F268CZ2nXhkZgOOKjCYXrTXi/pNQCggwF2ETFdfU+rzzSqGPVo0Ooln?=
 =?us-ascii?Q?7gV16nBOPDxX0qR0xSANVpguMV88MCRnvNsuUj0uVwZtSNr38LBTl5eFLtHG?=
 =?us-ascii?Q?UCnls4PBl3bxPHSPaAeDXfVDMrBSHIRDBkED5/8drJsPD4XoBIUF08NlCV7u?=
 =?us-ascii?Q?VLN061gZU8+CuwbyBmFeTjYGNqc4VomKZ21e4W4gBJhwS7pAkwp0YIEfFdw9?=
 =?us-ascii?Q?QKhB7nByBCs7Uenhn9QKJGr238ZkjE6KARzNlS+CibrDxq9ZpwzYeHbL8z0B?=
 =?us-ascii?Q?PXnpPT293+mMIk7iGipvzH7gJ6T35UIT+gqCu7Que9Y2WHVKWh3SgAJ5eaBl?=
 =?us-ascii?Q?oHu6CxTabG4xZ8Quu8uGFtp4R2jXa7GwGLCq/GXTD0TOkwiezeY9esyxvvzB?=
 =?us-ascii?Q?pC0K0zL9L+JQ1eAjbfyxKOsgolfDmqm+ghUrUPmCyiVH6REy6ouJ7uT9LzRz?=
 =?us-ascii?Q?OHY078hcvat2ppgg8p5R8QlN2JSkr0Cy0SNnMeAVTm+W2dTcfu0RqQhOBjU0?=
 =?us-ascii?Q?AEKZDqkHNnIkWm5AFolYD0tpDxO28ErqC1KNlAG488myjRtFDIivfK3MBOoZ?=
 =?us-ascii?Q?y4t7ntG01NZUA9ZWDTtTHjo=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f439da-a875-49d4-2901-08d9df5fcb74
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 17:34:37.9316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rwgq2xag6tRR8oSdKayHjDmzXavRBzrWzKKHf+TobZSBy3ESsb4rY6YlJPCnwaWCywLRmM6qRgKah3L0psJntA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0302MB3355
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_node_put should always be called on device nodes gotten from
of_get_*. Additionally, it should only be called after there are no
remaining users. To address the first issue, call of_node_put if later
steps in ulpi_register fail. To address the latter, call of_node_put
only after calling device_unregister.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

Changes in v2:
- New

 drivers/usb/common/ulpi.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
index 87deb514eb78..c6ba72544f2b 100644
--- a/drivers/usb/common/ulpi.c
+++ b/drivers/usb/common/ulpi.c
@@ -301,11 +301,11 @@ static int ulpi_register(struct device *dev, struct ulpi *ulpi)
 
 	ret = ulpi_read_id(ulpi);
 	if (ret)
-		return ret;
+		goto err;
 
 	ret = device_register(&ulpi->dev);
 	if (ret)
-		return ret;
+		goto err;
 
 	root = debugfs_create_dir(dev_name(dev), ULPI_ROOT);
 	debugfs_create_file("regs", 0444, root, ulpi, &ulpi_regs_ops);
@@ -314,6 +314,10 @@ static int ulpi_register(struct device *dev, struct ulpi *ulpi)
 		ulpi->id.vendor, ulpi->id.product);
 
 	return 0;
+
+err:
+	of_node_put(ulpi->dev.of_node);
+	return ret;
 }
 
 /**
@@ -357,8 +361,8 @@ void ulpi_unregister_interface(struct ulpi *ulpi)
 {
 	debugfs_remove_recursive(debugfs_lookup(dev_name(&ulpi->dev),
 						ULPI_ROOT));
-	of_node_put(ulpi->dev.of_node);
 	device_unregister(&ulpi->dev);
+	of_node_put(ulpi->dev.of_node);
 }
 EXPORT_SYMBOL_GPL(ulpi_unregister_interface);
 
-- 
2.25.1

